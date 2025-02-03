# Flutter Todo App

A simple Todo App built with Flutter, allowing users to manage tasks efficiently with features like adding, editing, deleting, marking tasks as important, and sorting tasks by today, this week, or this month.

## Features

- Add new tasks with details such as title, description, category, date, time, and importance.
- Edit existing tasks.
- Delete tasks.
- Mark tasks as completed.
- Highlight important tasks with a star icon.
- Set custom background colors for task cards.
- Filter tasks by Today, This Week, and This Month.

![Screenshot 2025-02-03 181150](https://github.com/user-attachments/assets/230e02be-1325-4889-b308-2330244ce055)
![Screenshot 2025-02-03 181223](https://github.com/user-attachments/assets/2c4a4dc3-6ef5-4600-bae6-384414ded58c)
![Screenshot 2025-02-03 181235](https://github.com/user-attachments/assets/f668c46d-3019-499c-8de5-e3376d4bf8c6)


_Include some screenshots of your app here._

## Getting Started

### Prerequisites

- Flutter SDK: [Installation Guide](https://flutter.dev/docs/get-started/install)
- Dart: [Installation Guide](https://dart.dev/get-dart)

### Dependencies

Add the following dependencies in your `pubspec.yaml` file:

```yaml
dependencies:
  flutter:
    sdk: flutter
  provider: ^5.0.0
  shared_preferences: ^2.0.0
  intl: ^0.17.0
  flutter_colorpicker: ^1.0.0

Installing
Clone the repository:

bash
git clone [https://github.com/your_username/flutter_todo_app.git](https://github.com/Avii00723/TodoApp.git)
cd flutter_todo_app
Install the dependencies:

bash
flutter pub get
Running the App
Connect your device or start an emulator.

Run the app:

bash
flutter run
Project Structure
plaintext
lib/
├── main.dart
├── todo_screen.dart
├── new_task_screen.dart
├── task_provider.dart
main.dart: Entry point of the application.

todo_screen.dart: Main screen displaying the list of tasks with sorting functionality.

new_task_screen.dart: Screen for adding and editing tasks.

task_provider.dart: Provider class for managing the state of tasks and performing CRUD operations.

Usage
Adding a Task
Tap the "+" button to open the new task screen.

Enter task details: title, description, category, date, time, and mark as important if needed.

Pick a custom background color for the task card.

Tap "Add Task" to save the task.

Editing a Task
Tap the edit button (pencil icon) on a task card to open the edit task screen.

Modify the task details.

Tap "Edit Task" to save changes.

Deleting a Task
Tap the delete button (trash icon) on a task card to remove the task.

Sorting Tasks
Open the navigation drawer.

Select "Today", "This Week", or "This Month" to filter tasks accordingly.

