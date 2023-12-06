import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
  Stream<String> getLoadingMessages() {
    final messages = <String>[
      'Loading movies...',
      'Heating the popcorns',
      'Almost there!'
    ];
    return Stream.periodic(const Duration(milliseconds: 1200), (step) {
      return messages[step];
    }).take(messages.length);
  }

  const FullScreenLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Hold on! please'),
          const SizedBox(
            height: 10,
          ),
          const CircularProgressIndicator(
            strokeWidth: 2,
          ),
          const SizedBox(
            height: 10,
          ),
          StreamBuilder(
            stream: getLoadingMessages(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const Text('Loading');
              return Text(snapshot.data!);
            },
          )
        ],
      ),
    );
  }
}
