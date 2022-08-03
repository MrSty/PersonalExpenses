import 'package:flutter/material.dart';
import 'package:pinol/models/days.dart';
import 'package:pinol/models/transaction.dart';
import 'package:intl/intl.dart';
import 'package:pinol/widgets/chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;
  Chart(this.recentTransactions);

  List<ExPerDay> get groupedTxList {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var totalSum = 0.0;
      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }

      return ExPerDay(
          LabelName: DateFormat.E().format(weekDay), Amount: totalSum);
    });
  }

  double get totalSpending {
    return groupedTxList.fold(0.0, (elemnt, sum) {
      return elemnt + sum.Amount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Theme.of(context).colorScheme.tertiary,
        elevation: 6,
        margin: EdgeInsets.all(10),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupedTxList.map((content) {
              return Expanded(
                child: ChartBar(
                    weekDayLabel: content.LabelName,
                    spendingAmount: content.Amount,
                    pctgOfTotal: totalSpending == 0.0
                        ? 0.0
                        : content.Amount / totalSpending),
              );
            }).toList(),
          ),
        ));
  }
}
