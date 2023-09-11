import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registerExpenses = [
    Expense(
        title: 'Flutter course',
        amount: 20.50,
        date: DateTime.now(),
        category: Category.work),
    Expense(
        title: 'cinema',
        amount: 15.25,
        date: DateTime.now(),
        category: Category.leisure),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        const Text('chart'),
        Expanded(
          child: ExpensesList(
            expenses: _registerExpenses,
          ),
        ),
      ],
    ));
  }
}
