import 'package:NewsLine/db_helper/db_helper_task.dart';
import 'package:NewsLine/ui/task/detail_task.dart';
import 'package:NewsLine/ui/task/edit_task.dart';
import 'package:NewsLine/ui/task/tambah_task.dart';
import 'package:flutter/material.dart';

class Task {
  int id;
  String title;
  String task;
  String category;

  Task({
    required this.id,
    required this.title,
    required this.task,
    required this.category,
  });
}

class TaskListPage extends StatefulWidget {
  @override
  _TaskListPageState createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  List<Task> tasks = [];

  @override
  void initState() {
    super.initState();
    DatabaseHelper.getTasks().then((taskList) {
      setState(() {
        tasks = taskList;
      });
    });
  }
  
    void editTask(BuildContext context, Task task) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditTaskPage(task: task),
      ),
    ).then((editedTask) {
      if (editedTask != null) {
        DatabaseHelper.updateTask(editedTask).then((success) {
          if (success) {
            setState(() {
              int index = tasks.indexWhere((c) => c.id == editedTask.id);
              if (index != -1) {
                tasks[index] = editedTask;
              }
            });
          }
        });
      }
    });
  }

  void deleteTask(BuildContext context, Task task) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Hapus Tugas'),
          content: Text('Yakin ingin menghapus tugas ini?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                DatabaseHelper.deleteTask(task).then((success) {
                  if (success) {
                    setState(() {
                      tasks.removeWhere((c) => c.id == task.id);
                    });
                  }
                });
              },
              child: Text('Hapus'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Tugas'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddTaskPage(),
            ),
          ).then((newTask) {
            if (newTask != null) {
              DatabaseHelper.addTask(newTask).then((id) {
                setState(() {
                  newTask.id = id;
                  tasks.add(newTask);
                });
              });
            }
          });
        },
        child: Icon(Icons.note_add),
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.task_alt_rounded), iconColor: Colors.green[300],
            title: Text(tasks[index].title),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TaskDetailPage(task: tasks[index]),
                ),
              ).then((editedTask) {
                if (editedTask != null) {
                  setState(() {
                    tasks[index] = editedTask;
                  });
                }
              });
            },
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),color: Colors.blue[300],
                  onPressed: () => editTask(context,tasks[index]),
                ),
                IconButton(
                  icon: Icon(Icons.delete),color: Colors.red,
                  onPressed: () => deleteTask(context, tasks[index]),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}





