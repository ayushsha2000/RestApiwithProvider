// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_is_empty, prefer_const_literals_to_create_immutables, avoid_print
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:vassignment/models/data.dart';

class Details extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.read<Data>().fetchData;
    return Scaffold(
      appBar: AppBar(
        title: Text('Json Data'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await context.read<Data>().fetchData;
        },
        child: Center(child: Consumer<Data>(
          builder: (context, value, child) {
            return value.list.length == 0 && !value.error
                ? CircularProgressIndicator()
                : value.error
                    ? Text(
                        'OOPs Something went wrong',
                        textAlign: TextAlign.center,
                      )
                    : ListView.builder(
                        itemCount: value.list.length,
                        itemBuilder: (context, index) {
                          print(value.list[index]);
                          return CardDetails(map: value.list[index]);
                        },
                      );
          },
        )),
      ),
    );
  }
}

class CardDetails extends StatelessWidget {
  const CardDetails({Key? key, required this.map}) : super(key: key);
  final Map<String, dynamic> map;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 16,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(map['title'],
                  style: TextStyle(
                    fontSize: 12.0,
                  )),
              SizedBox(
                height: 5.0,
              ),
              Text(map['body'],
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w800,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
