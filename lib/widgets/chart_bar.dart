import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String weekDayLabel;
  final double spendingAmount;
  final double pctgOfTotal;
  ChartBar(
      {required this.weekDayLabel,
      required this.spendingAmount,
      required this.pctgOfTotal});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 20,
          child: FittedBox(
            child: Text(
              '\$${spendingAmount.toStringAsFixed(1)}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Container(
          height: 80,
          width: 15,
          child: Stack(children: [
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1),
                  color: Color.fromARGB(255, 216, 216, 216),
                  borderRadius: BorderRadius.circular(5)),
            ),
            FractionallySizedBox(
              heightFactor: pctgOfTotal,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            )
          ]),
        ),
        SizedBox(
          height: 4,
        ),
        Text(
          weekDayLabel,
          style: TextStyle(fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
