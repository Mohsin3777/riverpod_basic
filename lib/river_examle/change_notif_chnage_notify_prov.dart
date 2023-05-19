import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn_riverpod/river_examle/state_not_state_notif_prov.dart';

// Change Notifier Provider

class UserNotifierChange extends ChangeNotifier {
  User user = const User('', 0);

  void updateName(String n) {
    user = user.copyWith(name: n);
    notifyListeners();
  }

  void updateAge(int n) {
    user = user.copyWith(age: n);
    notifyListeners();
  }
}

final userChangeNotifierProvider =
    ChangeNotifierProvider((ref) => UserNotifierChange());

class Change_Notifier_Prov_Example extends ConsumerWidget {
  void onSubmit(WidgetRef ref, String name) {
    ref.read(userChangeNotifierProvider).updateName(name);
  }

  void onSubmitAge(WidgetRef ref, int num) {
    ref.read(userChangeNotifierProvider).updateAge(num);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userChangeNotifierProvider).user;
    return Scaffold(
      appBar: AppBar(
        title: Text(user.name),
      ),
      body: Column(
        children: [
          TextField(
            onSubmitted: (value) => onSubmit(ref, value),
          ),
          TextField(
            onSubmitted: (value) => onSubmitAge(ref, int.parse(value)),
          ),
          Center(
            child: Text(user.age.toString()),
          ),
        ],
      ),
    );
  }
}
