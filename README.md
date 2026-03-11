# Expense Tracker Application

A cross-platform expense tracking application built with Flutter that allows users to record expenses, organize them with categories and tags, and review their spending patterns.

The app uses **Provider** for state management and **Firebase** (Authentication + Firestore) as the backend for secure cloud-based data storage.

Because it is built with Flutter, the same codebase runs on **Android, iOS, Web, Windows, Linux, and macOS**.

---

## Overview

Expense Tracker helps users manage their personal finances by allowing them to:

- Record daily expenses
- Categorize spending
- Tag transactions
- Analyze expenses by date or category
- Store data securely in the cloud using Firebase

The project demonstrates a clean architecture separating UI, state management, repository logic, and backend services.

---

## Features

### Expense Management

- Add new expenses
- Edit existing expenses
- Delete expenses with swipe actions
- Store amount, payee, note, date, category, and tag

### Organization

- Group expenses by date
- Group expenses by category
- View category spending totals

### Category Management

- Create custom categories
- Delete categories
- Seed default categories automatically

### Tag Management

- Create tags for expense classification
- Delete tags
- Seed default tags automatically

### Cloud Persistence

- All data stored in Firebase Firestore
- User identity managed via Firebase Anonymous Authentication
- Each user has isolated data storage

---

## Technology Stack

| Technology | Purpose |
|---|---|
| Flutter | UI framework |
| Dart | Programming language |
| Provider | State management |
| Firebase Core | Initializes Firebase |
| Firebase Authentication | Anonymous login |
| Cloud Firestore | Cloud database |
| Intl | Date formatting |
| Collection | Grouping and list utilities |

---

## Architecture

The application follows a layered architecture:

```
Presentation Layer       →   Flutter Screens & Widgets
State Layer              →   ExpenseProvider (ChangeNotifier)
Repository Layer         →   FirebaseExpenseRepository
Backend Layer            →   Firebase Authentication + Cloud Firestore
Model Layer              →   Expense, ExpenseCategory, Tag
```

**Data flow:**

```
UI → Provider → Repository → Firebase
```

This architecture keeps UI components separate from backend logic and improves maintainability.

---

## Folder Structure

```
lib/
 ├── models/
 │     Expense.dart
 │     ExpenseCategory.dart
 │     Tag.dart
 │
 ├── providers/
 │     ExpenseProvider.dart
 │
 ├── repositories/
 │     FirebaseExpenseRepository.dart
 │
 ├── screens/
 │     home_screen.dart
 │     manage_categories.dart
 │     manage_tags.dart
 │
 ├── widgets/
 │     expense_list.dart
 │     add_expense_dialog.dart
 │
 └── main.dart
```

**Platform folders** (`android/`, `ios/`, `web/`, `windows/`, `linux/`, `macos/`) allow Flutter to compile the app for multiple platforms.

---

## Firebase Backend

### Services Used

| Service | Purpose |
|---|---|
| Firebase Core | Initializes Firebase |
| Firebase Authentication | Anonymous user authentication |
| Cloud Firestore | Database for expenses, categories, and tags |

### Firestore Data Structure

```
users/{uid}/expenses/{expenseId}
users/{uid}/categories/{categoryId}
users/{uid}/tags/{tagId}
```

Each authenticated user has their own private set of expenses.

---

## Data Models

### Expense

| Field | Description |
|---|---|
| `id` | Unique identifier |
| `amount` | Transaction amount |
| `categoryId` | Linked category |
| `payee` | Recipient of the payment |
| `note` | Optional description |
| `date` | Date of transaction |
| `tag` | Classification tag |

> Represents a single financial transaction.

### ExpenseCategory

| Field | Description |
|---|---|
| `id` | Unique identifier |
| `name` | Category name |
| `isDefault` | Whether it was auto-seeded |

> Represents a group of related expenses such as *Food* or *Transport*.

### Tag

| Field | Description |
|---|---|
| `id` | Unique identifier |
| `name` | Tag label |

> Tags provide additional classification like *Lunch* or *Vacation*.

---

## Default Categories

The system automatically seeds the following categories for new users:

- Food
- Transport
- Entertainment
- Office
- Gym

---

## Default Tags

The system automatically seeds the following tags for new users:

`Breakfast` `Lunch` `Dinner` `Treat` `Cafe` `Restaurant` `Train` `Vacation` `Birthday` `Diet` `MovieNight` `Tech` `CarStuff` `SelfCare` `Streaming`

---

## Application Flow

```
1. Launch the application
2. Firebase initializes
3. User signs in anonymously
4. Default categories and tags are created
5. Home screen displays expense list
6. User adds expenses
7. Data is stored in Firestore
8. UI updates automatically
```

---

## Setup Instructions

### 1. Clone the repository

```bash
git clone https://github.com/yourusername/expense-tracker-app.git
```

### 2. Install dependencies

```bash
flutter pub get
```

### 3. Configure Firebase

Install FlutterFire CLI:

```bash
dart pub global activate flutterfire_cli
```

Configure Firebase:

```bash
flutterfire configure
```

This will generate the required configuration files for your Firebase project.

### 4. Run the app

```bash
flutter run
```

---


## Future Improvements

Planned enhancements include:

- Spending analytics dashboard
- Charts and financial insights
- Advanced filtering and search
- Budgeting and spending goals
- Export expenses to CSV/PDF
- Offline data sync
- Full user login system
- Notification reminders

