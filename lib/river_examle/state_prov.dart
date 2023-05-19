import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final stateProvExample = StateProvider<String?>((ref) => null);

class StateProvExample extends ConsumerWidget {
  const StateProvExample({super.key});

  void updageName(String name) {}
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final name = ref.watch(stateProvExample) ?? 'Mohsin';
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text(name),
            ElevatedButton(
                onPressed: () {
                  ref.read(stateProvExample.notifier).state = 'BBBB';
                },
                child: Text('press')),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  ref.read(stateProvExample.notifier).state = 'WWWW';
                },
                child: Text('wwwwwwww')),
          ],
        ),
      ),
    );
  }
}
