# GetX MVVM Todo Task App

![Flutter](https://shields.io) ![GetX](https://shields.io) ![Hive](https://shields.io)

A Flutter application built with production-ready standards, implementing clean architecture principles and robust state management.

## 🛠️ Architecture & State Management
* **Design Pattern:** MVVM (Model-View-ViewModel) for strict separation of UI and business logic.
* **State Management:** GetX (Reactive state management using Rx variables and Obx).
* **Routing:** Dependency-free routing via GetX named routes.
* **Dependency Injection:** Efficient memory management using GetX controllers injection.

## 📁 Core Directory Structure
* `lib/View/` - Declarative UI layers split neatly into modular page components.
* `lib/controller/` - Reactive ViewModels managing explicit UI actions and view states.
* `lib/models/` - Strongly-typed structured data schemas for tasks and user definitions.
* `lib/services/` - Isolated local cache layer handling core database transactions (Hive & SharedPreferences).
* `lib/Routs/` - Centralized absolute path configuration and named route bindings.

## ⚡ Technical Features
* Fully decoupled Authentication workflow (Login, SignUp, Forgot Password).
* Dynamic state-driven Task Creation via componentized Bottom Sheets.
* Reactive dashboard filtering with fully dynamic Calendar state integration.
* Persistent session tracking and profile updates (Username and Image Customization) via Local Storage Layer.
