class ExpenseCategory {
  final String id;
  final String name;
  final bool isDefault; // To identify if it's a system default or user-added

  ExpenseCategory({
    required this.id,
    required this.name,
    this.isDefault = false,
  });

  factory ExpenseCategory.fromJson(Map<String, dynamic> json) {
    return ExpenseCategory(
      id: json['id'] as String,
      name: json['name'] as String,
      isDefault: json['isDefault'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'isDefault': isDefault,
    };
  }
}
