import 'package:NewsLine/ui/task/task.dart';
import 'package:flutter/material.dart';

class AddTaskPage extends StatefulWidget {
  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController taskController = TextEditingController();
  TextEditingController categoryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Tugas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Judul Tugas',
              ),
            ),
            TextField(
              controller: taskController,
              decoration: InputDecoration(
                labelText: 'Isi Tugas',
              ),
            ),
            TextField(
              controller: categoryController,
              decoration: InputDecoration(
                labelText: 'Kategori Tugas',
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                String title = titleController.text;
                String task = taskController.text;
                String category = categoryController.text;

                Task newTask = Task(
                  id: 0,
                  title: title,
                  task: task,
                  category: category,
                );

                Navigator.pop(context, newTask);
              },
              child: Text('Tambah Tugas'),
            ),
          ],
        ),
      ),
    );
  }
}

