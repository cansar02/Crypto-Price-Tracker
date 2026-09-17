# Crypto Price Tracker

Crypto Price Tracker is an iOS application built with Swift that retrieves cryptocurrency market data from a REST API and displays current price information in a clean, responsive interface.

The project uses the MVVM architecture and RxSwift to separate application logic from the user interface and handle asynchronous data updates.

## Features

* Retrieves cryptocurrency market data from a REST API
* Displays cryptocurrency names, symbols, and current prices
* Updates the user interface dynamically when new data is received
* Uses reactive programming for data binding
* Separates networking, business logic, and UI using MVVM architecture
* Handles asynchronous API requests and JSON data

## Technologies

* Swift
* UIKit
* MVVM
* RxSwift
* REST APIs
* URLSession
* JSON
* Xcode

## Architecture

The application follows the **Model-View-ViewModel (MVVM)** design pattern.

### Model

Represents cryptocurrency data received from the API, such as:

* Coin name
* Symbol
* Price

### View

Responsible for displaying cryptocurrency information to the user using UIKit components.

### ViewModel

Handles application logic, processes API data, and provides updated information to the View.

RxSwift is used to create reactive bindings between the ViewModel and the user interface.

## Networking

The application communicates with an external cryptocurrency API using HTTP requests.

The networking layer:

1. Sends a request to the cryptocurrency API.
2. Receives JSON data.
3. Decodes the response into Swift models.
4. Passes the processed data to the ViewModel.
5. Updates the interface through reactive bindings.

## Reactive Programming

RxSwift is used to manage asynchronous data and update the interface when cryptocurrency information changes.

This reduces direct dependencies between the View and ViewModel and helps keep the application architecture organized.

## Project Structure

```text
CryptoPriceTracker
├── Model
│   └── CryptoCurrency.swift
├── View
│   └── ViewController.swift
├── ViewModel
│   └── CryptoViewModel.swift
├── Service
│   └── WebService.swift
└── AppDelegate.swift
```

## Running the Project

1. Clone the repository.
2. Open the project in Xcode.
3. Install the required RxSwift dependency if necessary.
4. Make sure the cryptocurrency API endpoint is configured.
5. Select an iOS simulator or physical device.
6. Build and run the application.

## What I Learned

This project helped me gain hands-on experience with:

* MVVM architecture
* Reactive programming with RxSwift
* REST API integration
* Asynchronous networking in iOS
* JSON decoding
* Separating networking and UI logic
* Updating UIKit interfaces using observable data
* Structuring an iOS application using reusable components

## Author

**Can Şar**

Computer Science Student
Binghamton University
