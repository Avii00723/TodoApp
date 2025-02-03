import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'task_provider.dart';
import 'new_task_screen.dart';
import 'package:intl/intl.dart';

class TodoScreen extends StatefulWidget {
  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  String selectedFilter = 'Today';

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    String formattedDate = DateFormat('dd MMMM').format(DateTime.now());

    List<Map<String, dynamic>> filteredTasks;
    if (selectedFilter == 'Today') {
      filteredTasks = taskProvider.getTasksForToday();
    } else if (selectedFilter == 'This Week') {
      filteredTasks = taskProvider.getTasksForThisWeek();
    } else {
      filteredTasks = taskProvider.getTasksForThisMonth();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Today: $formattedDate"),
        backgroundColor: Colors.blue,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'All Lists',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text("Today"),
              onTap: () {
                setState(() {
                  selectedFilter = 'Today';
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text("This Week"),
              onTap: () {
                setState(() {
                  selectedFilter = 'This Week';
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text("This Month"),
              onTap: () {
                setState(() {
                  selectedFilter = 'This Month';
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: filteredTasks.length,
        itemBuilder: (context, index) {
          final task = filteredTasks[index];
          return Card(
            color: task['backgroundColor'] != null ? Color(task['backgroundColor']) : Colors.white,
            margin: EdgeInsets.all(8.0),
            child: ListTile(
              title: Row(
                children: [
                  if (task['isImportant'])
                    Icon(Icons.star, color: Colors.yellow),
                  SizedBox(width: 8),
                  Text(
                    task['title'],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      decoration: task['isCompleted'] ? TextDecoration.lineThrough : null,
                    ),
                  ),
                ],
              ),
              subtitle: Text("${task['date']} | ${task['time']}"),
              leading: Checkbox(
                value: task['isCompleted'],
                onChanged: (_) => taskProvider.toggleTask(index),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit, color: Colors.blue),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NewTaskScreen(
                            taskIndex: index,
                            task: task,
                          ),
                        ),
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () => taskProvider.deleteTask(index),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NewTaskScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
