import 'package:flutter/material.dart';
const cityNameText = TextStyle(
  fontFamily: 'Poppins',
  fontWeight: FontWeight.w500,
  fontSize: 22.0,
  color: Colors.white,
  shadows: <Shadow>[
    Shadow(
      offset: Offset(2.0, 2.0),
      blurRadius: 4.0,
      color: Color.fromARGB(50, 0, 0, 0),
    ),
  ],
);

const timeText = TextStyle(
  fontFamily: 'Poppins',
  fontWeight: FontWeight.w400,
  fontSize: 13.0,
  color: Colors.white,
  shadows: <Shadow>[
    Shadow(
      offset: Offset(2.0, 2.0),
      blurRadius: 4.0,
      color: Color.fromARGB(50, 0, 0, 0),
    ),
  ],
);

const currentTemp = TextStyle(
  fontFamily: 'Poppins',
  fontWeight: FontWeight.w400,
  fontSize: 110.0,
  color: Colors.white,
  shadows: <Shadow>[
    Shadow(
      offset: Offset(3.0, 3.0),
      blurRadius: 10.0,
      color: Color.fromARGB(25, 0, 0, 0),
    ),
  ],
);

const currentCondtion = TextStyle(
  fontFamily: 'Poppins',
  fontWeight: FontWeight.w500,
  fontSize: 24.0,
  color: Colors.white,

  shadows: <Shadow>[
    Shadow(
      offset: Offset(2.0, 2.0),
      blurRadius: 4.0,
      color: Color.fromARGB(40, 0, 0, 0),
    ),
  ],

);

const TitleText = TextStyle(
  fontFamily: 'Poppins',
  fontSize: 20.0,
  fontWeight: FontWeight.w500,
  color: Color(0xFF494949),
);


const sidebarText = TextStyle(
  fontFamily: 'Poppins',
  fontSize: 15.0,
  fontWeight: FontWeight.w500,
  color: Color(0xFF494949),
);


const moreInfoText = TextStyle(
  fontFamily: 'Poppins',
  fontSize: 14.0,
  fontWeight: FontWeight.w600,
  color: Color(0xFF494949),
);

const moreInfoTextSecondary = TextStyle(
  fontFamily: 'Poppins',
  fontSize: 11.0,
  fontWeight: FontWeight.w500,
  color: Colors.grey,
);

const dateText = TextStyle(
  fontFamily: 'Poppins',
  fontSize: 12.0,
  fontWeight: FontWeight.w500,
  color: Colors.black54,
);


const miniDescription = TextStyle(
  fontFamily: 'Poppins',
  fontSize: 8.0,
  fontWeight: FontWeight.w500,
  color: Colors.grey,
);


const inputFieldsDeco = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  prefixIcon: Icon(
    Icons.place,
    color: Colors.grey,
  ),
  hintText: 'City Name',
  hintStyle: TextStyle(
    color: Colors.grey,
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(10.0),
    ),
    borderSide: BorderSide.none,
  ),
);
