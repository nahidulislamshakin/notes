import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:go_router/go_router.dart';
import 'package:notes/firebase_services/firebase_services.dart';
import '../controller/note_controller.dart';

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
        title:const Text(
          "Notes",
        ),
        actions: [
          TextButton(
            onPressed: () async{
              await FirebaseServices().signOut();
              if (FirebaseAuth.instance.currentUser == null) {
                noteController.notes.clear();
                context.go('/login');
              }
            },
            child: const Text(
              "Sign Out",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
            padding: EdgeInsets.only(left: 10.w, right: 10.w),
            child: Obx(() {
              print(noteController.notes.length);
                return FutureBuilder(
                  future: noteController.fetchNote(),
                  builder: (context,snapshot) {
                    return ListView.builder(
                      itemCount: noteController.notes.length,
                      itemBuilder: (context, index) {
                        final note = noteController.notes[index];
                        return Column(
                          children: [
                            Card(
                              child: ListTile(
                                title: SelectableText(
                                  note.title!,
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                subtitle: SelectableText(
                                  note.description!,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                          ],
                        );

                      },
                    );
                  }
                );
             // }

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
