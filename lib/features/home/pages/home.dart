import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_app/constants/utils.dart';
import 'package:task_app/features/home/pages/add_new_task.dart';
import 'package:task_app/features/home/widgets/task_card.dart';
import 'package:task_app/model/database_helper.dart';
import 'package:intl/intl.dart';
import 'package:task_app/features/home/widgets/date_selector.dart';

class HomePage extends StatefulWidget {
  static MaterialPageRoute route() =>
      MaterialPageRoute(builder: (context) => const HomePage());
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final dbHelper = DatabaseHelper.instance;
  DateTime selectedDate = DateTime.now();
  List<Map<String, dynamic>> tasks =
      []; // List to store tasks from the database

  // Fetch tasks for the selected date
  void fetchTasks() async {
    final formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
    final fetchedTasks = await dbHelper.getTasksByDate(formattedDate);

    setState(() {
      tasks = fetchedTasks;
    });
  }

  // Handle date change
  void onDateChanged(DateTime date) {
    setState(() {
      selectedDate = date;
    });
    fetchTasks(); // Fetch tasks for the new date
  }

  // Handle task deletion
  void deleteTask(int taskId) async {
    await dbHelper.deleteTask(taskId);
    fetchTasks(); // Refresh the task list after deletion
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Task deleted!',
          style: TextStyle(
            color: Colors.red,
            fontSize: 15,
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    fetchTasks(); // Fetch tasks when the page loads
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Tasks",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              CupertinoIcons.add,
              size: 25,
            ),
            onPressed: () {
              Navigator.of(context)
                  .push(AddNewTask.route())
                  .then((_) => fetchTasks());
            },
          ),
        ],
      ),
      body: Column(
        children: [
          DateSelector(
            onDateSelected: (date) {
              onDateChanged(date);
            },
          ),
          Expanded(
            child: tasks.isEmpty
                ? Center(
                    child: Text(
                      'No tasks for this date!',
                      style: TextStyle(fontSize: 18),
                    ),
                  )
                : ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      final task = tasks[index];
                      final taskTime = task['time'] ?? 'Time not set';

                      return Dismissible(
                        key: Key(
                          task['task_id'].toString(),
                        ),
                        direction: DismissDirection.endToStart,
                        onDismissed: (direction) {
                          deleteTask(
                            task['task_id'],
                          );
                        },
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: Icon(Icons.delete, color: Colors.white),
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TaskCard(
                                color: Color(task['color']),
                                headerText: task['title'],
                                descriptionText: task['description'],
                              ),
                            ),
                            Container(
                              height: 10,
                              width: 10,
                              decoration: BoxDecoration(
                                color: strengthenColor(
                                  Color(task['color']),
                                  0.69,
                                ),
                                shape: BoxShape.circle,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                taskTime,
                                style: TextStyle(
                                  fontSize: 17,
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
