import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

const uuid = Uuid();

final formatter = DateFormat.yMd();

enum Category { food, travel, leisure, work }

const categoryIcons = {
  Category.food: Icons.food_bank_rounded,
  Category.travel: Icons.flight_takeoff_rounded,
  Category.leisure: Icons.movie_creation_rounded,
  Category.work: Icons.work_outlined,
};

class Expense {
  Expense(
      {required this.title,
      required this.amount,
      required this.category,
      required this.date})
      : id = uuid.v4();

  final String title, id;
  final double amount;
  final DateTime date;
  final Category category;

  String get formattedDate {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  const ExpenseBucket({required this.category, required this.expenses});

  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = (allExpenses
            .where((expense) => expense.category == category)).toList();

  final Category category;
  final List<Expense> expenses;

  double get totalExpenses {
    double sum = 0;
    for (final expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }
}
