# ChatterBox
ChatterBox is a simple and delightful social media app built using Flutter and powered by Firebase. It offers users a seamless platform to connect with friends, share posts, and engage in meaningful conversations. This repository includes the source code for the ChatterBox app, and here's how you can set it up:

## Prerequisites
Make sure you have the following installed:

Flutter
Firebase CLI

## Getting Started
### Clone the Repository:

```bash
//Copy code
git clone https://github.com/your-username/ChatterBox.git
cd ChatterBox
```
### Set Up Firebase:

Create a new project on the Firebase Console.
Enable Authentication and Firestore in your Firebase project.
Download the google-services.json file from Firebase and place it in the android/app directory.

### Configure Firebase Authentication:

In Firebase Console, go to Authentication > Sign-in method and enable Email/Password.
Add your Android app to the project and follow the instructions to configure the package name.

### Configure Firebase Firestore:

Create a Firestore database in Firebase Console.

### Update Firebase Configuration:

Open lib/services/firebase_service.dart and update the Firebase configuration with your own credentials.

### Install Dependencies:

```bash
//Copy code
flutter pub get
```

### Run the App:

```bash
//Copy code
flutter run
```

## Features

### User Authentication:

Users can create accounts, log in securely, and reset passwords.

### Create Posts:

Users can compose and share their thoughts, images, and links.

### User Profiles:

Each user has a personalized profile page displaying their posts and basic information.
## Contributing
Contributions are welcome! Feel free to open issues or pull requests to enhance the app.
