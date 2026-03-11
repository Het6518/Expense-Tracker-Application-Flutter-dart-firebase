# Firebase Setup

The app is now wired to use:

- `Firebase Auth` with anonymous sign-in
- `Cloud Firestore` for `expenses`, `categories`, and `tags`

Remaining setup:

1. Create a Firebase project in the Firebase console.
2. Add your Android app with package name `com.example.expense_manager`.
3. Download `google-services.json` and place it in `android/app/`.
4. If you run iOS, add an iOS app in Firebase and place `GoogleService-Info.plist` in `ios/Runner/`.
5. Enable `Authentication -> Anonymous`.
6. Enable `Cloud Firestore`.
7. Run `flutter pub get`.
8. Run the app.

Recommended Firestore structure:

- `users/{uid}/expenses/{expenseId}`
- `users/{uid}/categories/{categoryId}`
- `users/{uid}/tags/{tagId}`

Starter Firestore rules for authenticated users:

```txt
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /users/{userId}/{document=**} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
  }
}
```
