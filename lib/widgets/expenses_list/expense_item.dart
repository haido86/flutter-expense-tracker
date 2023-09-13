import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  final Expense expense;

  const ExpenseItem(this.expense, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 20,
        ),
        child: Column(
          children: [
            Text(expense.title), // Display the title of the expense
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Text(
                  '\$${expense.amount.toStringAsFixed(2)}', // Display the formatted amount
                ),
                const Spacer(), // Create space between elements
                Row(
                  children: [
                    Icon(categoryIcons[
                        expense.category]), // Display the category icon
                    Text(
                      expense.formattedDate, // Display the formatted date
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
