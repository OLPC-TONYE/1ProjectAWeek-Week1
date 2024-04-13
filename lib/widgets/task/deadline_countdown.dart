import 'package:flutter/material.dart';
import 'package:todo/extensions.dart';
import 'package:todo/models/task.dart';

class DeadlineCountdown extends StatefulWidget {
  const DeadlineCountdown({
    super.key,
    required this.task,
  });

  final Task task;

  @override
  State<DeadlineCountdown> createState() => _DeadlineCountdownState();
}

class _DeadlineCountdownState extends State<DeadlineCountdown> with SingleTickerProviderStateMixin {

  late Animation<double> animation;
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1900))..repeat();
    animation  = CurvedAnimation(parent: animationController, curve: Curves.elasticOut);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Text(widget.task.deadline!.counterFormat(), style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),);
      },
    );
  }
}
