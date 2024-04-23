import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vaccination_managment_app/models/vaccine_record.dart';
import 'package:vaccination_managment_app/views/vaccination_history/details_date_item.dart';

void vaccineHistoryDetails(BuildContext context, VaccineRecord vaccine) async {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
          vaccine.name,
          style: GoogleFonts.lato(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Status: ${vaccine.status.name}',
              style: GoogleFonts.lato(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Text(
              'Doses:',
              style: GoogleFonts.lato(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            for (var doseEntry in vaccine.doseDates.asMap().entries)
              DetailsDateItem(
                vaccineId: vaccine.id,
                vaccineDose: vaccine.dose,
                doseEntry: doseEntry,
                prevDate: doseEntry.key == 0
                    ? null
                    : vaccine.doseDates[doseEntry.key - 1],
                nextDate: doseEntry.key == vaccine.doseDates.length - 1
                    ? null
                    : vaccine.doseDates[doseEntry.key + 1],
              )
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Close'),
          ),
        ],
      );
    },
  );
}
