import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/widgets/expense_list/expenses_list.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/new_expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _userExpenses = [
    Expense(
      title: 'Flutter Course',
      amount: 19.99,
      category: Category.work,
      date: DateTime.now(),
    ),
    Expense(
      title: 'Cinema',
      amount: 20,
      category: Category.leisure,
      date: DateTime.now(),
    ),
  ];

  void _addExpense(Expense newExpense) {
    setState(() {
      _userExpenses.add(newExpense);
    });
  }

  void _handleNewExpense() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(onAddExpense: _addExpense),
    );
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _userExpenses.indexOf(expense);
    setState(() {
      _userExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expense has been delected!'),
        action: SnackBarAction(
            label: "Undo",
            onPressed: () {
              setState(() {
                _userExpenses.insert(expenseIndex, expense);
              });
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(child: Text('No data! Try adding some!'));
    if (_userExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _userExpenses,
        onRemoveExpense: _removeExpense,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Expense Tracker'),
        actions: [
          IconButton(
            onPressed: _handleNewExpense,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          Chart(expenses: _userExpenses),
          Expanded(
            child: mainContent,
          ),
        ],
      ),
    );
  }
}
