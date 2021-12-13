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
              Text(
                ' Provider Listen True : ${Provider.of<MyProvider>(context, listen: true).count}',
              ),
              SizedBox(height: 10,),
              Text(
                ' Provider Listen False : ${Provider.of<MyProvider>(context, listen: false).count}',
              ),
              SizedBox(height: 10,),
              Text(
                ' Provider Watch : ${context.watch<MyProvider>().count}',
              ),
              SizedBox(height: 10,),
              Consumer<MyProvider>(
                builder: (ctx, value, child) => Text(
                  ' Consumer MyProvider : ${value.count}',
                ),
              ),
              SizedBox(height: 10,),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<MyProvider>().increment(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
