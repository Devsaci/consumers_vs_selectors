import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'my_provider.dart';

void main() => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (ctx) => MyProvider(),
          )
        ],
        child: MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Consumers VS Selectors"),
      ),
      body: Center(
        child: DefaultTextStyle(
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                children: [
                  Text("Provider Listen True : "),
                  Text(
                    '${Provider.of<MyProvider>(context, listen: true).count}',
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  Text("Provider Listen False : "),
                  Text(
                    '${Provider.of<MyProvider>(context, listen: false).count}',
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  Text("Provider Watch : "),
                  Text(
                    '${context.watch<MyProvider>().count}',
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  Text(" Consumer MyProvider : "),
                  Consumer<MyProvider>(
                    builder: (ctx, value, child) => Text(
                      '${value.count}',
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(" Selector<MyProvider, int> : "),
              Selector<MyProvider, int>(
                  selector: (ctx, val) => val.count,
                  builder: (ctx, value, child) => Text('${value}')),
              SizedBox(
                height: 10,
              ),
              Text(" Context Selector: "),
              Text(" ${context.select((value) => null)}"),

            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "context.read<MyProvider>()",
        onPressed: () => context.read<MyProvider>().increment(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
