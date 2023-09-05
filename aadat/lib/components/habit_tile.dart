import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HabitTile extends StatelessWidget {
  final String habitName;
  final bool habitCompleted;
  final Function(bool?)? onChanged;
  final Function(BuildContext)? settingTapped;
  final Function(BuildContext)? deleteTapped;

  const HabitTile({
    super.key,
    required this.habitName,
    required this.habitCompleted,
    required this.onChanged,
    required this.settingTapped,
    required this.deleteTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Slidable(
        endActionPane: ActionPane(motion: StretchMotion(), children: [
          //delete

          //edit
          SlidableAction(
            onPressed: settingTapped,
            backgroundColor: Colors.black54,
            icon: Icons.settings,
            borderRadius: BorderRadius.circular(12),
          ),

          //delete
          SlidableAction(
            onPressed: deleteTapped,
            backgroundColor: Colors.red,
            icon: Icons.delete,
            borderRadius: BorderRadius.circular(12),
          )
        ]),
        child: Container(
          padding: EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              //cheakBox
              Checkbox(value: habitCompleted, onChanged: onChanged),
              //habit name
              Text(habitName),
            ],
          ),
        ),
      ),
    );
  }
}
