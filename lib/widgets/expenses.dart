import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
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
    // Initial list of expenses
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

  void _addExpense(Expense expense) {
    // Add an expense to the list
    setState(() {
      _registerExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    // Remove an expense from the list and show a Snackbar
    final expenseIndex = _registerExpenses.indexOf(expense);

    setState(() {
      _registerExpenses.remove(expense);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expense deleted.'),
        action: SnackBarAction(
          label: 'undo',
          onPressed: () {
            setState(() {
              _registerExpenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  void _openAddExpenseOverlay() {
    // Open the NewExpense overlay for adding a new expense
    showModalBottomSheet(
      constraints: const BoxConstraints(minWidth: double.infinity),
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: ((ctx) => NewExpense(
            onAddExpense: _addExpense,
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    // Determine the main content based on whether there are expenses or not
    Widget mainContent =
        const Center(child: Text('No Expense available. Start adding some!'));
    if (_registerExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registerExpenses,
        onRemoveExpense: _removeExpense,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: width < 600
          ? Column(
              children: [
                Chart(expenses: _registerExpenses), // Display the chart
                Expanded(
                  child:
                      mainContent, // Display the list of expenses or a message
                ),
              ],
            )
          : Row(
              children: [
                Expanded(
                  child: Chart(expenses: _registerExpenses),
                ), // Display the chart
                Expanded(
                  child:
                      mainContent, // Display the list of expenses or a message
                ),
              ],
            ),
    );
  }
}
