import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinol/widgets/chart.dart';
import 'package:pinol/widgets/delTx.dart';
import './models/transaction.dart';
import 'package:pinol/widgets/newTx.dart';
import './widgets/transactionList.dart';

void main() => runApp(PiNull());

class PiNull extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'PiNull',
        home: HomePage(),
        theme: ThemeData(
            colorScheme: Theme.of(context).colorScheme.copyWith(
                primary: Color(0xFF79302f),
                secondary: Color(0xFF45afb0),
                background: Colors.grey[850],
                tertiary: Colors.grey[500]),
            fontFamily: GoogleFonts.hind().fontFamily,
            textTheme: ThemeData.light().textTheme.copyWith(
                titleSmall: TextStyle(
                  fontFamily:
                      GoogleFonts.hind(fontWeight: FontWeight.bold).fontFamily,
                  fontSize: 30,
                  color: Color(0xFF79302f),
                ),
                labelMedium: TextStyle(
                    fontFamily: GoogleFonts.hind().fontFamily,
                    fontSize: 15,
                    color: Color(0xFF79302f)))));
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Transaction> transactions = [];
  void addNewTx(String title, double amount, DateTime date) {
    final ntx = Transaction(
        id: date.toString(), title: title, amount: amount, date: date);
    setState(() {
      transactions.add(ntx);
    });
  }

  void _showAddNewTx(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            child: NewTx(addNewTx),
            onTap: () {},
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  void _delTX(int index, BuildContext ctx) {
    //transactions.removeAt(index);
    bool del = false;
    showDialog(
        context: ctx,
        builder: (_) => AlertDialog(
              title: Text('Delete'),
              content: Text('Are you sure you want to delet it?'),
              actions: [
                TextButton(
                    onPressed: () {
                      setState(() {
                        transactions.removeAt(index);
                      });

                      Navigator.pop(context);
                    },
                    child: Text('Yes')),
                TextButton(
                    onPressed: () {
                      del = false;
                      Navigator.pop(context);
                    },
                    child: Text('No'))
              ],
            ));
  }

  void _showDelTx(BuildContext ctx, int index) {
    //showDialog(context: ctx, builder: (_) => DelTx(_delTX));
    _delTX(index, ctx);
  }

  List<Transaction> get _recentTransactions {
    return transactions.where((element) {
      return element.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(
          'PiNull',
          style: TextStyle(
              color: Theme.of(context).colorScheme.secondary, fontSize: 30),
        ),
        titleSpacing: 20,
        actions: [
          IconButton(
              onPressed: () => _showAddNewTx(context),
              icon: Icon(
                Icons.add,
                size: 40,
                color: Theme.of(context).colorScheme.secondary,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                  width: double.infinity, child: Chart(_recentTransactions)),
              TxList(transactions, _showDelTx)
            ]),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add_sharp,
          size: 45,
          color: Theme.of(context).colorScheme.tertiary,
        ),
        onPressed: () => _showAddNewTx(context),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
