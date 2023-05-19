// Stream Provider

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final streamProvider = StreamProvider((ref) async* {
  yield [1, 2, 3, 4, 5, 6, 7, 8];
});

class StreamProv_Example extends ConsumerWidget {
  const StreamProv_Example({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Stream Provider'),
        ),
        body: ref.watch(streamProvider).when(data: (data) {
          return Container(
            height: 200,
            color: Colors.red,
            child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return Text(data[index].toString());
                }),
          );
        }, error: ((error, stackTrace) {
          return Center(
            child: Text(error.toString()),
          );
        }), loading: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }));
  }
}
