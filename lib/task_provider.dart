import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class TaskProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _tasks = [];

  List<Map<String, dynamic>> get tasks => _tasks;

  Future<void> fetchTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final String? tasksString = prefs.getString('tasks');
    if (tasksString != null) {
      _tasks = List<Map<String, dynamic>>.from(json.decode(tasksString));
    }
    notifyListeners();
  }

  List<Map<String, dynamic>> getTasksForToday() {
    final today = DateTime.now();
    return _tasks.where((task) {
      final taskDate = DateTime.parse(task['date']);
      return taskDate.year == today.year && taskDate.month == today.month && taskDate.day == today.day;
    }).toList();
  }

  List<Map<String, dynamic>> getTasksForThisWeek() {
    final today = DateTime.now();
    final startOfWeek = today.subtract(Duration(days: today.weekday - 1));
    final endOfWeek = today.add(Duration(days: 7 - today.weekday));
    return _tasks.where((task) {
      final taskDate = DateTime.parse(task['date']);
      return taskDate.isAfter(startOfWeek.subtract(Duration(days: 1))) && taskDate.isBefore(endOfWeek.add(Duration(days: 1)));
    }).toList();
  }

  List<Map<String, dynamic>> getTasksForThisMonth() {
    final today = DateTime.now();
    final startOfMonth = DateTime(today.year, today.month, 1);
    final endOfMonth = DateTime(today.year, today.month + 1, 0);
    return _tasks.where((task) {
      final taskDate = DateTime.parse(task['date']);
      return taskDate.isAfter(startOfMonth.subtract(Duration(days: 1))) && taskDate.isBefore(endOfMonth.add(Duration(days: 1)));
    }).toList();
  }

  Future<void> addTask(String title, String description, String category, String date, String time, bool isImportant, Color backgroundColor) async {
    final newTask = {
      'title': title,
      'description': description,
      'category': category,
      'date': date,
      'time': time,
      'isImportant': isImportant,
      'isCompleted': false,
      'backgroundColor': backgroundColor.value,
    };
    _tasks.add(newTask);
    await _saveTasks();
  }

  Future<void> editTask(int index, String title, String description, String category, String date, String time, bool isImportant, Color backgroundColor) async {
    _tasks[index] = {
      'title': title,
      'description': description,
      'category': category,
      'date': date,
      'time': time,
      'isImportant': isImportant,
      'isCompleted': _tasks[index]['isCompleted'],
      'backgroundColor': backgroundColor.value,
    };
    await _saveTasks();
  }

  Future<void> toggleTask(int index) async {
    _tasks[index]['isCompleted'] = !_tasks[index]['isCompleted'];
    await _saveTasks();
  }

  Future<void> deleteTask(int index) async {
    _tasks.removeAt(index);
    await _saveTasks();
  }

  Future<void> _saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('tasks', json.encode(_tasks));
    notifyListeners();
  }
}
