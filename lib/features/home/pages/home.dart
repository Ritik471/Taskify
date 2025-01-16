import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_app/constants/utils.dart';
import 'package:task_app/features/home/pages/add_new_task.dart';
import 'package:task_app/features/home/widgets/date_selector.dart';
import 'package:task_app/features/home/widgets/task_card.dart';

class HomePage extends StatelessWidget {
  static MaterialPageRoute route() =>
      MaterialPageRoute(builder: (context) => const HomePage());
  const HomePage({super.key});

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
              Navigator.of(context).push(AddNewTask.route());
            },
          ),
        ],
      ),
      body: Column(
        children: [
          DateSelector(),
          Row(
            children: [
              Expanded(
                child: TaskCard(
                    color: Color.fromRGBO(245, 222, 194, 1),
                    headerText: 'Hello!',
                    descriptionText:
                        'This is a New Task!,This is a New Task!This is a New Task!This is a New Task!This is a New Task!This is a New Task!This is a New Task!'),
              ),
              Container(
                height: 10,
                width: 10,
                decoration: BoxDecoration(
                  color: strengthenColor(
                    Color.fromRGBO(146, 96, 35, 1),
                    0.69,
                  ),
                  shape: BoxShape.circle,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '10.00 AM',
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
