import 'package:flutter/material.dart';

class DelTx extends StatelessWidget {
  final Function _delTx;
  DelTx(this._delTx);
  @override
  Widget build(BuildContext context) {
    bool del = false;
    return AlertDialog(
      title: Text('Delete'),
      content: Text('Are you sure you want to delet it?'),
      actions: [
        TextButton(
            onPressed: () {
              del = true;
              _delTx();
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
    );
  }
}
