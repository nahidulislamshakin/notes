import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../controller/note_controller.dart';
import '../model/note_model.dart';

class AddNotePage extends StatefulWidget {
  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  final TextEditingController titleController = TextEditingController();

  final TextEditingController descriptionController = TextEditingController();

  final NoteController noteController = Get.find<NoteController>();

  @override
  void dispose() {
    // TODO: implement dispose
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Note'),

      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text("Title",style: Theme.of(context).textTheme.titleLarge,),
                SizedBox(height: 10.h,),
                TextFormField(
                  controller: titleController,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    labelStyle:
                    TextStyle(color: Colors.grey, fontSize: 14.sp),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  maxLines: 2,
                ),
                SizedBox(height: 16.h),
                Text("Description",style: Theme.of(context).textTheme.titleLarge,),
                SizedBox(height: 10.h,),
                TextFormField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    labelStyle:
                    TextStyle(color: Colors.grey, fontSize: 14.sp),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  maxLines: 5,
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    if (titleController.text.isNotEmpty &&
                        descriptionController.text.isNotEmpty) {
                      final newNote = Note(
                        title: titleController.text,
                        description: descriptionController.text,
                      );
                      noteController.addNote(newNote);
                      context.go('/home'); // Go back to the previous screen after adding the note
                    }
                  },
                  child: Text('Add Note'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
