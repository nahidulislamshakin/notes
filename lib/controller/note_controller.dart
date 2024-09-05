import 'package:get/get.dart';
import 'package:notes/firebase_services/firebase_services.dart';
import '../model/note_model.dart';

class NoteController extends GetxController {
  var notes = <Note>[].obs;
  final FirebaseServices _firebaseServices = FirebaseServices();
  @override
  void onInit() {
    fetchNote();
    super.onInit();
  }

  void addNote(Note note) async {
    await _firebaseServices.addNotes(note);
    fetchNote();

  }

  Future<RxList<Note>> fetchNote() async {
    var fetchedNote = await _firebaseServices.fetchNotesFromFirestore();
    notes.value = fetchedNote;
    return notes;
  }

}
