import 'package:flutter/material.dart';

void alert(BuildContext context, String name) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      backgroundColor: Color(0xFAC3C3C5),
      contentPadding: EdgeInsets.only(left: 0, right: 0, top: 15, bottom: 10),
      content: Container(
        height: 130,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              "Alert",
              style: TextStyle(
                color: Color(0xFF5F5C63),
                fontWeight: FontWeight.bold,
                fontFamily: 'LatoRegular',
                fontSize: 18,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                "Signed in as $name",
                maxLines: 1,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Color(0xFF5F5C63),
                  fontFamily: 'LatoRegular',
                  fontSize: 16,
                ),
              ),
            ),
            Container(
              height: 0.5,
              margin: EdgeInsets.symmetric(vertical: 5),
              color: Color(0xAA5F5C63),
            ),
            FlatButton(
              child: Text(
                "OK",
                style: TextStyle(
                  color: Color(0xFF0091C6),
                  fontFamily: 'LatoRegular',
                  fontSize: 16,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      ),
    ),
  );
}
