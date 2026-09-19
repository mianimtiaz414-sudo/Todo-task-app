# GetX MVVM Todo Task App

A Flutter application built with production-ready standards, implementing clean architecture principles and robust state management.

## 🛠️ Architecture & State Management
* **Design Pattern:** MVVM (Model-View-ViewModel) for strict separation of UI and business logic.
* **State Management:** GetX (Reactive state management using Rx variables and Obx).
* **Routing:** Dependency-free routing via GetX named routes.
* **Dependency Injection:** Efficient memory management using GetX controllers injection.

## 📁 Core Directory Structure
* `lib/View/` - Declarative UI layers (Auth, Dashboard, Profile, and Onboarding screens).
* `lib/controller/` - ViewModels managing state, authentication, and local storage services.
* `lib/model/` - Strongly-typed data models for data parsing.
* `lib/Routs/` - Centralized application routing configuration.

## ⚡ Technical Features
* Fully decoupled Authentication workflow (Login, SignUp, Forgot Password).
* Dynamic state-driven Task Creation via Bottom Sheets.
* Reactive dashboard filtering with Calendar state integration.
* Persistent state handling via dedicated Local Storage Controller.
