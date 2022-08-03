import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TxList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function del;
  TxList(this.transactions, this.del);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 400,
        child: transactions.isEmpty
            ? Column(
                children: [
                  Text(
                    'No transactions added yet!',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 35),
                    height: 200,
                    child: Image.asset(
                      'assets/images/Add-Button-PNG-Pic.png',
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              )
            : ListView.builder(
                itemBuilder: (ctx, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                    color: Theme.of(context).colorScheme.tertiary,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor: Colors.white,
                        radius: 30,
                        child: FittedBox(
                            child: Text(
                                '\$${transactions[index].amount.toStringAsFixed(2)}')),
                      ),
                      title: Text(
                        transactions[index].title,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      subtitle: Text(
                        DateFormat(
                          'EEE, MMM d yyyy',
                        ).format(transactions[index].date),
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => del(context, index),
                      ),
                    ),
                  );
                },
                itemCount: transactions.length,
              ));
  }
}
