import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../model/note_model.dart';

class FirebaseServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //SignUp using firebaseAuthentication
  Future signUp({required String email, required String password, required String name}) async {
    try {
      final user = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      if (user != null) {
        // Save the name to Firestore under the user's UID
        await _firestore.collection('users').doc(user.user?.uid).set({
          'name': name,
          'email': email,
        });
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //Login using Firebase Authentication
  Future login({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return result.user;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //SignOut using Firebase Authentication
  Future signOut() async {
    try {
      final result = await _auth.signOut();
      return result;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //Sending data using firebase firestore
  Future<void> addNotes(Note note) async {
    try {
      //Geting current user's ID
      User? user = _auth.currentUser;
      String? userId = user?.uid;

      //Reference to the user's notes document
      if(userId!=null){
        DocumentReference userNoteRef =
        _firestore.collection('notes').doc(userId);

        //Add note to firestore
        await userNoteRef.set({
          'notes': FieldValue.arrayUnion([note.toMap()]),
        }, SetOptions(merge: true));
      }

    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print("Error adding note: $e");
      }
    }
  }

  Future<List<Note>> fetchNotesFromFirestore() async {
    final userId = _auth.currentUser?.uid;

    if (userId != null) {
      final snapshot = await _firestore
          .collection('notes')
          .doc(userId)
          .get();
      if(snapshot.exists){
        final List<dynamic> notesData = snapshot.data()?['notes'] ?? [];
        return notesData.map((noteMap) =>Note.fromMap(noteMap)).toList();
      }

     // return snapshot.docs.map((doc) => Note.fromMap(doc.data())).toList();
    }
    return [];
  }
}
