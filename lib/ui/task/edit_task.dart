import 'package:NewsLine/ui/task/task.dart';
import 'package:flutter/material.dart';

class EditTaskPage extends StatefulWidget {
  final Task task;

  EditTaskPage({required this.task});

  @override
  _EditTaskPageState createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController taskController = TextEditingController();
  TextEditingController categoryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    titleController.text = widget.task.title;
    taskController.text = widget.task.task;
    categoryController.text = widget.task.category;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Tugas'),
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

                Task editedTask = Task(
                  id: widget.task.id,
                  title: title,
                  task: task,
                  category: category,
                );

                Navigator.pop(context, editedTask);
              },
              child: Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}