import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/expense.dart';
import '../models/expense_category.dart';
import '../models/tag.dart';

class FirebaseExpenseRepository {
  FirebaseExpenseRepository({
    required FirebaseFirestore firestore,
    required FirebaseAuth auth,
  })  : _firestore = firestore,
        _auth = auth;

  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  static final List<ExpenseCategory> defaultCategories = [
    ExpenseCategory(id: '1', name: 'Food', isDefault: true),
    ExpenseCategory(id: '2', name: 'Transport', isDefault: true),
    ExpenseCategory(id: '3', name: 'Entertainment', isDefault: true),
    ExpenseCategory(id: '4', name: 'Office', isDefault: true),
    ExpenseCategory(id: '5', name: 'Gym', isDefault: true),
  ];

  static final List<Tag> defaultTags = [
    Tag(id: '1', name: 'Breakfast'),
    Tag(id: '2', name: 'Lunch'),
    Tag(id: '3', name: 'Dinner'),
    Tag(id: '4', name: 'Treat'),
    Tag(id: '5', name: 'Cafe'),
    Tag(id: '6', name: 'Restaurant'),
    Tag(id: '7', name: 'Train'),
    Tag(id: '8', name: 'Vacation'),
    Tag(id: '9', name: 'Birthday'),
    Tag(id: '10', name: 'Diet'),
    Tag(id: '11', name: 'MovieNight'),
    Tag(id: '12', name: 'Tech'),
    Tag(id: '13', name: 'CarStuff'),
    Tag(id: '14', name: 'SelfCare'),
    Tag(id: '15', name: 'Streaming'),
  ];

  String get _userId {
    final user = _auth.currentUser;
    if (user == null) {
      throw StateError('User is not signed in.');
    }
    return user.uid;
  }

  DocumentReference<Map<String, dynamic>> get _userDocument =>
      _firestore.collection('users').doc(_userId);

  CollectionReference<Map<String, dynamic>> get _expensesCollection =>
      _userDocument.collection('expenses');

  CollectionReference<Map<String, dynamic>> get _categoriesCollection =>
      _userDocument.collection('categories');

  CollectionReference<Map<String, dynamic>> get _tagsCollection =>
      _userDocument.collection('tags');

  Future<void> seedDefaults() async {
    final categoriesSnapshot = await _categoriesCollection.get();
    if (categoriesSnapshot.docs.isEmpty) {
      final batch = _firestore.batch();
      for (final category in defaultCategories) {
        batch.set(_categoriesCollection.doc(category.id), category.toJson());
      }
      await batch.commit();
    }

    final tagsSnapshot = await _tagsCollection.get();
    if (tagsSnapshot.docs.isEmpty) {
      final batch = _firestore.batch();
      for (final tag in defaultTags) {
        batch.set(_tagsCollection.doc(tag.id), tag.toJson());
      }
      await batch.commit();
    }
  }

  Future<List<Expense>> loadExpenses() async {
    final snapshot = await _expensesCollection.orderBy('date', descending: true).get();
    return snapshot.docs
        .map((doc) => Expense.fromJson(doc.data()))
        .toList(growable: false);
  }

  Future<List<ExpenseCategory>> loadCategories() async {
    final snapshot = await _categoriesCollection.orderBy('name').get();
    return snapshot.docs
        .map((doc) => ExpenseCategory.fromJson(doc.data()))
        .toList(growable: false);
  }

  Future<List<Tag>> loadTags() async {
    final snapshot = await _tagsCollection.orderBy('name').get();
    return snapshot.docs
        .map((doc) => Tag.fromJson(doc.data()))
        .toList(growable: false);
  }

  Future<void> saveExpense(Expense expense) {
    return _expensesCollection.doc(expense.id).set(expense.toJson());
  }

  Future<void> deleteExpense(String id) {
    return _expensesCollection.doc(id).delete();
  }

  Future<void> saveCategory(ExpenseCategory category) {
    return _categoriesCollection.doc(category.id).set(category.toJson());
  }

  Future<void> deleteCategory(String id) {
    return _categoriesCollection.doc(id).delete();
  }

  Future<void> saveTag(Tag tag) {
    return _tagsCollection.doc(tag.id).set(tag.toJson());
  }

  Future<void> deleteTag(String id) {
    return _tagsCollection.doc(id).delete();
  }
}
