;; Conversion Tracking Contract
;; Tracks lead conversions and performance metrics

(define-constant CONTRACT_OWNER tx-sender)
(define-constant ERR_UNAUTHORIZED (err u500))
(define-constant ERR_LEAD_NOT_FOUND (err u501))
(define-constant ERR_ALREADY_CONVERTED (err u502))
(define-constant ERR_INVALID_VALUE (err u503))

;; Conversion types
(define-constant CONV_SALE u1)
(define-constant CONV_SIGNUP u2)
(define-constant CONV_DEMO u3)
(define-constant CONV_CONSULTATION u4)

;; Data structures
(define-map lead-conversions
  { lead-id: uint }
  {
    conversion-type: uint,
    conversion-date: uint,
    conversion-value: uint,
    agency-id: uint,
    commission-rate: uint,
    commission-amount: uint
  }
)

(define-map agency-performance
  { agency-id: uint }
  {
    total-conversions: uint,
    total-revenue: uint,
    total-commission: uint,
    conversion-rate: uint
  }
)

(define-data-var total-conversions uint u0)
(define-data-var total-revenue uint u0)

;; Record lead conversion
(define-public (record-conversion
  (lead-id uint)
  (conversion-type uint)
  (conversion-value uint)
  (agency-id uint)
  (commission-rate uint)
)
  (let ((commission-amount (/ (* conversion-value commission-rate) u100)))
    (asserts! (is-none (map-get? lead-conversions { lead-id: lead-id })) ERR_ALREADY_CONVERTED)
    (asserts! (> conversion-value u0) ERR_INVALID_VALUE)
    (asserts! (<= commission-rate u100) ERR_INVALID_VALUE)

    ;; Record conversion
    (map-set lead-conversions
      { lead-id: lead-id }
      {
        conversion-type: conversion-type,
        conversion-date: block-height,
        conversion-value: conversion-value,
        agency-id: agency-id,
        commission-rate: commission-rate,
        commission-amount: commission-amount
      }
    )

    ;; Update agency performance
    (match (map-get? agency-performance { agency-id: agency-id })
      perf-data
      (map-set agency-performance
        { agency-id: agency-id }
        {
          total-conversions: (+ (get total-conversions perf-data) u1),
          total-revenue: (+ (get total-revenue perf-data) conversion-value),
          total-commission: (+ (get total-commission perf-data) commission-amount),
          conversion-rate: (get conversion-rate perf-data) ;; Would calculate properly
        }
      )
      ;; Create new performance record
      (map-set agency-performance
        { agency-id: agency-id }
        {
          total-conversions: u1,
          total-revenue: conversion-value,
          total-commission: commission-amount,
          conversion-rate: u100
        }
      )
    )

    ;; Update global stats
    (var-set total-conversions (+ (var-get total-conversions) u1))
    (var-set total-revenue (+ (var-get total-revenue) conversion-value))

    (ok commission-amount)
  )
)

;; Get conversion details
(define-read-only (get-conversion (lead-id uint))
  (map-get? lead-conversions { lead-id: lead-id })
)

;; Get agency performance
(define-read-only (get-agency-performance (agency-id uint))
  (map-get? agency-performance { agency-id: agency-id })
)

;; Get total conversions
(define-read-only (get-total-conversions)
  (var-get total-conversions)
)

;; Get total revenue
(define-read-only (get-total-revenue)
  (var-get total-revenue)
)

;; Check if lead converted
(define-read-only (is-lead-converted (lead-id uint))
  (is-some (map-get? lead-conversions { lead-id: lead-id }))
)

;; Calculate conversion rate for agency
(define-read-only (calculate-conversion-rate (agency-id uint) (total-leads uint))
  (match (map-get? agency-performance { agency-id: agency-id })
    perf-data
    (if (> total-leads u0)
      (/ (* (get total-conversions perf-data) u100) total-leads)
      u0
    )
    u0
  )
)
