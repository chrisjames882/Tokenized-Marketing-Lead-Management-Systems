# Tokenized Marketing Lead Management System

A comprehensive blockchain-based system for managing marketing leads using Clarity smart contracts on the Stacks blockchain.

## Overview

This system provides a complete solution for marketing agencies to manage leads through a tokenized, transparent, and automated process. The system consists of five interconnected smart contracts that handle the entire lead lifecycle.

## System Components

### 1. Agency Verification Contract (`agency-verification.clar`)
- **Purpose**: Validates and manages marketing agencies
- **Features**:
    - Agency registration and verification
    - Reputation scoring system
    - Status management (pending, verified, suspended)
    - Owner-controlled verification process

### 2. Lead Capture Contract (`lead-capture.clar`)
- **Purpose**: Captures and stores marketing leads
- **Features**:
    - Multi-source lead capture (website, social, email, referral)
    - Lead metadata storage
    - Value scoring system
    - Agency-based lead organization

### 3. Qualification Automation Contract (`qualification-automation.clar`)
- **Purpose**: Automates lead qualification process
- **Features**:
    - Automated qualification based on scoring criteria
    - Manual qualification override capability
    - Hot/Cold lead classification
    - Qualification tracking and analytics

### 4. Distribution Coordination Contract (`distribution-coordination.clar`)
- **Purpose**: Coordinates distribution of qualified leads
- **Features**:
    - Lead assignment to agencies
    - Priority-based distribution
    - Acceptance/rejection tracking
    - Agency performance monitoring

### 5. Conversion Tracking Contract (`conversion-tracking.clar`)
- **Purpose**: Tracks lead conversions and performance metrics
- **Features**:
    - Multiple conversion types (sale, signup, demo, consultation)
    - Commission calculation and tracking
    - Agency performance analytics
    - Revenue tracking

## Key Features

- **Transparency**: All lead activities are recorded on-chain
- **Automation**: Automated qualification and distribution processes
- **Performance Tracking**: Comprehensive analytics for agencies and leads
- **Commission Management**: Automated commission calculation
- **Reputation System**: Agency reputation scoring based on performance

## Contract Architecture

\`\`\`
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│ Agency          │    │ Lead            │    │ Qualification   │
│ Verification    │───▶│ Capture         │───▶│ Automation      │
└─────────────────┘    └─────────────────┘    └─────────────────┘
│
┌─────────────────┐    ┌─────────────────┐            │
│ Conversion      │◀───│ Distribution    │◀───────────┘
│ Tracking        │    │ Coordination    │
└─────────────────┘    └─────────────────┘
\`\`\`

## Getting Started

### Prerequisites
- Stacks blockchain development environment
- Clarity CLI tools
- Node.js for testing

### Installation

1. Clone the repository
2. Install dependencies: \`npm install\`
3. Run tests: \`npm test\`
4. Deploy contracts to testnet/mainnet

### Usage Example

\`\`\`clarity
;; 1. Register an agency
(contract-call? .agency-verification register-agency "Marketing Pro Agency")

;; 2. Capture a lead
(contract-call? .lead-capture capture-lead u1 "john@example.com" u1 u75 "High-value prospect")

;; 3. Auto-qualify the lead
(contract-call? .qualification-automation auto-qualify-lead u1 u75)

;; 4. Distribute to agency
(contract-call? .distribution-coordination distribute-lead u1 u1 u2)

;; 5. Record conversion
(contract-call? .conversion-tracking record-conversion u1 u1 u5000 u1 u10)
\`\`\`

## Testing

The system includes comprehensive tests using Vitest:

\`\`\`bash
npm test
\`\`\`

## Security Considerations

- Contract owner controls for sensitive operations
- Input validation on all public functions
- Access control for agency-specific operations
- Error handling for edge cases

## Future Enhancements

- Token-based incentive system
- Advanced analytics dashboard
- Multi-signature agency management
- Integration with external CRM systems
- Real-time lead scoring algorithms

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests for new functionality
5. Submit a pull request

## License

MIT License - see LICENSE file for details
