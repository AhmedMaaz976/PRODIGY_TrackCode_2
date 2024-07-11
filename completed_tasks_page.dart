import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'task_provider.dart';

class CompletedTasksPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Completed Tasks'),
        backgroundColor: Colors.cyanAccent,
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/com.png'), // Path to your background image
                fit: BoxFit.cover,
              ),
            ),
          ),
          Consumer<TaskProvider>(
            builder: (context, taskProvider, child) {
              return ListView.builder(
                itemCount: taskProvider.completedTasks.length,
                itemBuilder: (context, index) {
                  final task = taskProvider.completedTasks[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                    decoration: BoxDecoration(
                      color: Colors.cyanAccent.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: ListTile(
                      title: Text(
                        task.name,
                        style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
