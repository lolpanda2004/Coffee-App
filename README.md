# ☕ Flutter Coffee Ordering App

A beautiful coffee ordering application built with Flutter that allows users to:
- Browse coffee menu
- Customize drink options
- Add items to cart
- Place orders seamlessly

## ✨ Features
- **Interactive UI** with smooth animations
- **Responsive design** for all screen sizes
- **State management** with Provider (or BLoC)
- **Firebase backend** (optional)
- **Dark/Light mode** support

## 📱 Screenshots

![Screenshot_20250801-142824](https://github.com/user-attachments/assets/7e4aed72-cf18-4e42-a99e-bf2eca23792b)
![Screenshot_20250801-142853](https://github.com/user-attachments/assets/16b4b897-f9ee-47ae-8525-0f5ef4b83d1a)
![Screenshot_20250801-142849](https://github.com/user-attachments/assets/523a3859-e191-4791-8f9e-22ee9499fc99)
![Screenshot_20250801-142812](https://github.com/user-attachments/assets/15514092-01b1-4398-873a-9733d83f933f)
![Screenshot_20250801-142829](https://github.com/user-attachments/assets/f7e84692-dd5c-4847-8e61-ca97c8e3a6f3)
![Screenshot_20250801-142819](https://github.com/user-attachments/assets/62484e32-ed3b-438e-8497-585920d44efe)
![Screenshot_20250801-142913](https://github.com/user-attachments/assets/fd7f1a08-0c9b-4403-8107-b052a78e6e10)
![Screenshot_20250801-142858](https://github.com/user-attachments/assets/d2bd2472-d8cd-4d74-9f92-665700f45cea)
![Screenshot_20250801-142809](https://github.com/user-attachments/assets/5bd0f8de-ea86-457e-8ce0-36c022d9b8a4)
![Screenshot_20250801-142844](https://github.com/user-attachments/assets/9550c53a-c01d-4fba-b4ea-358e4a10eb00)
![Screenshot_20250801-142905](https://github.com/user-attachments/assets/adcbbd6e-6596-4852-bb24-7ac52b5df4b3)

## 🛠️ Tech Stack
- **Flutter** 3.16+
- **Dart** 3.0+
- **Firebase** (Authentication & Firestore)
- **Provider** for state management
- **Google Pay/Stripe** integration

## 🚀 Installation
1. **Clone the repository**:
   ```bash
   git clone https://github.com/lolpanda2004/Coffee-App.git
   cd Coffee-App

2. **Install Dependencies**:
   ```bash
   flutter pub get

3. **Run the app**:
   ```bash
   flutter run

## Project Structure
```bash
lib/
├── main.dart # App entry point
├── models/ # Data models
│ ├── coffee.dart # Coffee item model
│ ├── user.dart # User model
│ └── order.dart # Order model
├── screens/ # App screens
│ ├── auth/ # Authentication screens
│ │ ├── login.dart # Login screen
│ │ └── register.dart # Registration screen
│ ├── home.dart # Home screen
│ ├── menu.dart # Menu screen
│ └── cart.dart # Shopping cart screen
├── services/ # Business logic
│ ├── auth.dart # Authentication service
│ └── database.dart # Database service
└── widgets/ # Reusable components
├── coffee_card.dart # Coffee item widget
└── app_bar.dart # Custom app bar
