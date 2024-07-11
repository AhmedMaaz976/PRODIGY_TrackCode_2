import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'task_provider.dart';
import 'completed_tasks_page.dart';

class TodoListPage extends StatelessWidget {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do List'),
        backgroundColor: Colors.tealAccent.withOpacity(0.3),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/main.png'), // Path to your background image
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: _textEditingController,
                        decoration: InputDecoration(hintText: 'Enter task'),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_textEditingController.text.isNotEmpty) {
                          Provider.of<TaskProvider>(context, listen: false).addTask(_textEditingController.text);
                          _textEditingController.clear();
                        }
                      },
                      child: Text('Add'),
                      style: ElevatedButton.styleFrom(primary: Colors.blue),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Consumer<TaskProvider>(
                  builder: (context, taskProvider, child) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Completed Tasks: ${taskProvider.completedTasks.length}',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: taskProvider.tasks.length,
                            itemBuilder: (context, index) {
                              final task = taskProvider.tasks[index];
                              return Container(
                                margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                                decoration: BoxDecoration(
                                  color: Colors.lightBlueAccent.withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: ListTile(
                                  title: Text(
                                    task.name,
                                    style: TextStyle(
                                      decoration: task.isCompleted ? TextDecoration.lineThrough : null,
                                    ),
                                  ),
                                  leading: Checkbox(
                                    value: task.isCompleted,
                                    onChanged: (value) {
                                      taskProvider.toggleTask(index);
                                    },
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      IconButton(
                                        icon: Icon(Icons.edit),
                                        onPressed: () {
                                          _textEditingController.text = task.name;
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: Text('Edit Task'),
                                                content: TextField(
                                                  controller: _textEditingController,
                                                  decoration: InputDecoration(hintText: 'Enter task'),
                                                ),
                                                actions: <Widget>[
                                                  TextButton(
                                                    onPressed: () {
                                                      taskProvider.editTask(index, _textEditingController.text);
                                                      _textEditingController.clear();
                                                      Navigator.of(context).pop();
                                                    },
                                                    child: Text('Save'),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.delete),
                                        onPressed: () {
                                          taskProvider.deleteTask(index);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => CompletedTasksPage()),
                            );
                          },
                          child: Text('Completed Tasks'),
                          style: ElevatedButton.styleFrom(primary: Colors.tealAccent),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
