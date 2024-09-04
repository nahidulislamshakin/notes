import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:go_router/go_router.dart';
import 'package:notes/firebase_services/firebase_services.dart';

import '../controller/note_controller.dart';
import '../model/note_model.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final NoteController noteController = Get.put(NoteController());
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Notes",),
      ),
      body: SafeArea(
        child: Padding(
            padding:  EdgeInsets.only(left: 10.w,right: 10.w),
            child: Obx(() {
              return ListView.builder(
                itemCount: noteController.notes.length,
                itemBuilder: (context, index) {
                  final note = noteController.notes[index];
                  return Column(
                    children: [
                      Card(
                        child: ListTile(
                          title: SelectableText(note.title!,style: Theme.of(context).textTheme.titleLarge,),
                          subtitle: SelectableText(note.description!,style: Theme.of(context).textTheme.bodyMedium,),
                        ),
                      ),
                      SizedBox(height: 10.h,),
                    ],
                  );
                },
              );
            })),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.go('/add');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
