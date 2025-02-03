import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'task_provider.dart';

class NewTaskScreen extends StatefulWidget {
  final int? taskIndex;
  final Map<String, dynamic>? task;

  NewTaskScreen({this.taskIndex, this.task});

  @override
  _NewTaskScreenState createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  bool isImportant = false;
  Color _backgroundColor = Colors.white;

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      titleController.text = widget.task!['title'];
      descriptionController.text = widget.task!['description'];
      dateController.text = widget.task!['date'];
      timeController.text = widget.task!['time'];
      isImportant = widget.task!['isImportant'];
      _backgroundColor = Color(widget.task!['backgroundColor']);
    }
  }

  void _pickColor(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Pick a background color'),
        content: SingleChildScrollView(
          child: BlockPicker(
            pickerColor: _backgroundColor,
            onColorChanged: (color) {
              setState(() {
                _backgroundColor = color;
              });
            },
          ),
        ),
        actions: [
          ElevatedButton(
            child: Text('Done'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.taskIndex == null ? "New Task" : "Edit Task"),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: "Task Title"),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: "Category"),
            ),
            TextField(
              controller: dateController,
              decoration: InputDecoration(labelText: "Date"),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );
                if (pickedDate != null) {
                  dateController.text = pickedDate.toLocal().toString().split(' ')[0];
                }
              },
            ),
            TextField(
              controller: timeController,
              decoration: InputDecoration(labelText: "Time"),
              onTap: () async {
                TimeOfDay? pickedTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (pickedTime != null) {
                  timeController.text = pickedTime.format(context);
                }
              },
            ),
            CheckboxListTile(
              title: Text("Important?"),
              value: isImportant,
              onChanged: (value) {
                setState(() {
                  isImportant = value ?? false;
                });
              },
            ),
            ElevatedButton(
              onPressed: () => _pickColor(context),
              child: Text("Pick Background Color"),
            ),
            ElevatedButton(
              onPressed: () {
                if (widget.taskIndex == null) {
                  taskProvider.addTask(
                    titleController.text,
                    descriptionController.text,
                    "Category",
                    dateController.text,
                    timeController.text,
                    isImportant,
                    _backgroundColor,
                  );
                } else {
                  taskProvider.editTask(
                    widget.taskIndex!,
                    titleController.text,
                    descriptionController.text,
                    "Category",
                    dateController.text,
                    timeController.text,
                    isImportant,
                    _backgroundColor,
                  );
                }
                Navigator.pop(context);
              },
              child: Text(widget.taskIndex == null ? "Add Task" : "Edit Task"),
            ),
          ],
        ),
      ),
    );
  }
}
