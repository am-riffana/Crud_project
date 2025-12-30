import 'package:flutter/material.dart';


class CrudExample extends StatefulWidget {
  const CrudExample({super.key});

  @override
  State<CrudExample> createState() => _CrudExampleState();
}

class _CrudExampleState extends State<CrudExample> {
  @override
  void dispose(){
    controller.dispose();
    super.dispose();
  }
  List<String> students = [];
  TextEditingController controller = TextEditingController();
  int? editIndex;

  void addOrUpdateStudent() {
    if (controller.text.isEmpty) return;

    setState(() {
      if (editIndex == null) {
        students.add(controller.text); 
      } else {
        students[editIndex!] = controller.text; 
        editIndex = null;
      }
      controller.clear();
    });
  }

  void deleteStudent(int index) {
    setState(() {
      students.removeAt(index);
    });
  }

  void editStudent(int index) {
    setState(() {
      controller.text = students[index];
      editIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 233, 211, 177),
      appBar: AppBar(title:  Text("Student List Crud"),
      backgroundColor: const Color.fromARGB(255, 185, 159, 150),),
      body: Padding(
        padding:  EdgeInsets.all(26),
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration:  InputDecoration(
                labelText: "Enter Student Name",
                border: OutlineInputBorder(),
              ),
            ),
             SizedBox(height: 20),
            ElevatedButton(
              onPressed: addOrUpdateStudent,
              child: Text(editIndex == null ? "Add" : "Update"),
            ),
             SizedBox(height: 20),

            Expanded(
              child: ListView.builder(
                itemCount: students.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(students[index]),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon:  Icon(Icons.edit),
                            onPressed: () => editStudent(index),
                          ),
                          IconButton(
                            icon:  Icon(Icons.delete),
                            onPressed: () => deleteStudent(index),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
