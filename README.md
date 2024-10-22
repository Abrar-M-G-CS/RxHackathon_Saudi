# RXHackthon

## Overview

RXHackthon is a SwiftUI application designed to provide live activity updates for a travel experiance. It uses Swift's new ActivityKit to display real-time delivery statuses in a user-friendly interface. This application showcases various phases of a delivery process, including picking the order, delivery, arrival, and completion.

## Features

- **Live Activity Updates**: Real-time updates that reflect the current status of the delivery.
- **Dynamic UI**: The UI updates every 10 seconds to reflect the current phase of the delivery.
- **Reusable Components**: The application is built using reusable components for better maintainability and scalability.

## Technologies Used

- SwiftUI
- ActivityKit
- WidgetKit

## Getting Started

### Prerequisites

- Xcode 14 or later
- iOS 16 or later

### Installation

1. Clone the repository:
    ```bash
    git clone https://github.com/Abrar-M-G-CS/RXHackthon.git
    ```
2. Open the project in Xcode:
    ```bash
    open RXHackthon.xcodeproj
    ```
3. Build and run the project on a simulator or device.

## Structure

- `FlightActivityModel.swift`: Contains the model for the flight activity details.
- `FlightActivityView.swift`: UI component displaying the current phase of the delivery.
- `FlightActivityWidget.swift`: Widget implementation for displaying live activity on the home screen.
- `FlightActivityUpdate.swift`: Defines the structure for updates at each phase of the delivery.

## Usage

1. The application starts by showing the initial phase of the travel.
2. Every 10 seconds, the app updates the display to reflect the current status of the flight experiance, cycling through defined phases.
3. The widget allows users to view the current status without opening the app.

## Contributing

Contributions are welcome! Please feel free to submit a pull request or open an issue to discuss changes.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgements

- Thank you to the SwiftUI and ActivityKit communities for their contributions and resources.
