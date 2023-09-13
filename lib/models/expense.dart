import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const uuid = Uuid();

final formatter = DateFormat.yMd();

enum Category {
  food,
  work,
  leisure,
  travel,
}

const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.leisure: Icons.movie,
  Category.travel: Icons.flight_takeoff,
  Category.work: Icons.work,
};

class Expense {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  Expense(
      {required this.title,
      required this.amount,
      required this.date,
      required this.category})
      : id = uuid.v4();

  String get formattedDate {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  final Category category;
  final List<Expense> expenses;

  const ExpenseBucket({required this.category, required this.expenses});

  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      // : expenses = allExpenses
      //       .where((expense) => expense.category == category)
      //       .toList();
      // better solution
      : expenses = [
          for (final expense in allExpenses)
            if (expense.category == category) expense
        ];

  double get totalExpenses {
    // double sum = 0;
    // for (final expense in expenses) {
    //   sum += expense.amount;
    // }
    // return sum;
    // better solution like using Reducer in JS
    return expenses.fold(0, (sum, expense) => sum + expense.amount);
  }
}
