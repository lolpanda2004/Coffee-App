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
   '''bash
   flutter pub get

3. **Run the app**:
   '''bash
   flutter run

## 🔧 Configuration
Create `lib/config/keys.dart` with:
```dart
const stripePublicKey = 'pk_test_your_key';
const googleMapsKey = 'your_maps_key';

## Project Structure
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
