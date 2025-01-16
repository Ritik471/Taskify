import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_app/model/database_helper.dart';
import 'package:flex_color_picker/flex_color_picker.dart';

class AddNewTask extends StatefulWidget {
  static MaterialPageRoute route() =>
      MaterialPageRoute(builder: (context) => const AddNewTask());
  const AddNewTask({super.key});

  @override
  State<AddNewTask> createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  Color selectedColor = Color.fromRGBO(245, 222, 194, 1);
  final dbHelper = DatabaseHelper.instance;

  void addTask() async {
    final title = titleController.text.trim();
    final description = descriptionController.text.trim();
    final currentTime = DateFormat('HH:mm').format(DateTime.now());

    if (title.isEmpty || description.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in both title and description.')),
      );
      return;
    }

    final task = {
      'title': title,
      'description': description,
      'color': selectedColor.value,
      'date': DateFormat('yyyy-MM-dd').format(selectedDate),
      'time': currentTime,
    };

    await dbHelper.insertTask(task);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Task added successfully!')),
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Add New Task',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () async {
              final _selectedDate = await showDatePicker(
                context: context,
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(
                  Duration(days: 90),
                ),
              );

              if (_selectedDate != null) {
                setState(() {
                  selectedDate = _selectedDate;
                });
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                DateFormat('d-MM-y').format(selectedDate),
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextFormField(
              controller: titleController,
              decoration: InputDecoration(
                hintText: 'Title',
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: descriptionController,
              decoration: InputDecoration(
                hintText: 'Description',
              ),
              maxLines: 3,
            ),
            SizedBox(height: 10),
            ColorPicker(
              heading: Text(
                'Select Color',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              subheading: Text(
                'Select a different shade',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              onColorChanged: (Color color) {
                setState(() {
                  selectedColor = color;
                });
              },
              color: selectedColor,
              pickersEnabled: {ColorPickerType.wheel: true},
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: addTask,
              child: Text(
                'SUBMIT',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
