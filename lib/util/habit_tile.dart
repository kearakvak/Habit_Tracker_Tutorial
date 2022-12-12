import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class HabitTile extends StatelessWidget {
  HabitTile({
    super.key,
    required this.habitName,
    required this.habitStarted,
    required this.onTop,
    required this.settingsTapped,
    required this.timeGoal,
    required this.timeSpent,
  });
  String habitName;
  final VoidCallback onTop;
  final VoidCallback settingsTapped;
  final int timeSpent;
  final int timeGoal;
  final bool habitStarted;

  // convert seconds into min:sec->e.g. 62 seconds = 1:02 min
  String formatToMinSec(int totalSeconds) {
    String secs = (totalSeconds % 60).toString();
    String mins = (totalSeconds / 60).toStringAsFixed(5);
    //59 seconds -> 0:59
    // (59/60).toStringAsFixed(0)=0.9..=1

    // if secs is a 1 digit number, place a 0 infront of it
    if (secs.length == 1) {
      secs = '0' + secs;
    }

    //if mins is a 1 digit number
    if (mins[1] == '.') {
      mins = mins.substring(0, 1);
    }

    return mins + ":" + secs;
  }

  //calculate progress percentage
  double percentCompleted() {
    return timeSpent / (timeGoal * 60);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey.shade200,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // progress circle
            Row(
              children: [
                GestureDetector(
                  onTap: onTop,
                  child: SizedBox(
                    height: 60,
                    width: 60,
                    child: Stack(
                      children: [
                        CircularPercentIndicator(
                          radius: 30,
                          percent:
                              percentCompleted() < 1 ? percentCompleted() : 1,
                          progressColor: percentCompleted() > 0.5
                              ? (percentCompleted() > 0.75
                                  ? Color.fromARGB(255, 200, 230, 216)
                                  : Colors.yellow)
                              : Colors.red.shade500,
                        ),
                        Center(
                          child: Icon(
                            habitStarted
                                ? Icons.pause_presentation_outlined
                                : Icons.play_arrow_outlined,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // habit Name
                    Text(
                      habitName,
                      style: GoogleFonts.aclonica(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    //Progress
                    Text(
                        formatToMinSec(timeSpent) +
                            " / " +
                            timeGoal.toString() +
                            ' = ' +
                            (percentCompleted() * 100).toStringAsFixed(0) +
                            '%',
                        style: GoogleFonts.alegreyaSc(
                          color: Colors.grey.shade600,
                        )),
                  ],
                ),
              ],
            ),

            GestureDetector(
              onTap: settingsTapped,
              child: Icon(Icons.settings),
            ),
          ],
        ),
      ),
    );
  }
}
