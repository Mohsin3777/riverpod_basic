import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn_riverpod/river_examle/change_notif_chnage_notify_prov.dart';
import 'package:learn_riverpod/river_examle/fetchListofdata_river.dart';
import 'package:learn_riverpod/river_examle/future_provider.dart';
import 'package:learn_riverpod/river_examle/state_not_state_notif_prov.dart';
import 'package:learn_riverpod/river_examle/state_prov.dart';
import 'package:learn_riverpod/sidebar/side_home.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  // const MyApp({super.key});

  List<Widget> lst = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AllDataExample(),
    );
  }
}

final counterProvider = StateProvider<int>((ref) => 0);

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    _counter = ref.read(counterProvider.notifier).state++;
  }

  void _decrementCounter() {
    _counter = ref.read(counterProvider.notifier).state--;
  }

  @override
  Widget build(BuildContext context) {
    final counter = ref.watch(counterProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        children: [
          FloatingActionButton(
            onPressed: _incrementCounter,
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
          SizedBox(
            width: 10,
          ),
          FloatingActionButton(
            onPressed: _decrementCounter,
            tooltip: 'Decrement',
            child: const Icon(Icons.minimize),
          ),
        ],
      ),
    );
  }
}
