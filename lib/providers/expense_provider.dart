import 'package:flutter/foundation.dart';
import '../models/expense.dart';
import '../models/expense_category.dart';
import '../models/tag.dart';
import '../services/firebase_expense_repository.dart';

class ExpenseProvider with ChangeNotifier {
  final FirebaseExpenseRepository repository;
  List<Expense> _expenses = [];
  List<ExpenseCategory> _categories = [];
  List<Tag> _tags = [];
  bool _isLoading = true;
  String? _loadError;

  // Getters
  List<Expense> get expenses => _expenses;
  List<ExpenseCategory> get categories => _categories;
  List<Tag> get tags => _tags;
  bool get isLoading => _isLoading;
  String? get loadError => _loadError;

  ExpenseProvider(this.repository) {
    initialize();
  }

  Future<void> initialize() async {
    _isLoading = true;
    _loadError = null;
    notifyListeners();

    try {
      await repository.seedDefaults();
      final results = await Future.wait([
        repository.loadExpenses(),
        repository.loadCategories(),
        repository.loadTags(),
      ]);

      _expenses = results[0] as List<Expense>;
      _categories = results[1] as List<ExpenseCategory>;
      _tags = results[2] as List<Tag>;
    } catch (error) {
      _loadError = error.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addExpense(Expense expense) async {
    _expenses.add(expense);
    await repository.saveExpense(expense);
    notifyListeners();
  }

  Future<void> addOrUpdateExpense(Expense expense) async {
    int index = _expenses.indexWhere((e) => e.id == expense.id);
    if (index != -1) {
      _expenses[index] = expense;
    } else {
      _expenses.add(expense);
    }
    _expenses.sort((a, b) => b.date.compareTo(a.date));
    await repository.saveExpense(expense);
    notifyListeners();
  }

  Future<void> deleteExpense(String id) async {
    _expenses.removeWhere((expense) => expense.id == id);
    await repository.deleteExpense(id);
    notifyListeners();
  }

  Future<void> addCategory(ExpenseCategory category) async {
    if (!_categories.any((cat) => cat.name == category.name)) {
      _categories.add(category);
      _categories.sort((a, b) => a.name.compareTo(b.name));
      await repository.saveCategory(category);
      notifyListeners();
    }
  }

  Future<void> deleteCategory(String id) async {
    _categories.removeWhere((category) => category.id == id);
    await repository.deleteCategory(id);
    notifyListeners();
  }

  Future<void> addTag(Tag tag) async {
    if (!_tags.any((t) => t.name == tag.name)) {
      _tags.add(tag);
      _tags.sort((a, b) => a.name.compareTo(b.name));
      await repository.saveTag(tag);
      notifyListeners();
    }
  }

  Future<void> deleteTag(String id) async {
    _tags.removeWhere((tag) => tag.id == id);
    await repository.deleteTag(id);
    notifyListeners();
  }

  Future<void> removeExpense(String id) {
    return deleteExpense(id);
  }
}
