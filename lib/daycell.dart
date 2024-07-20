import 'package:flutter/material.dart';

class DayCellWidget extends StatelessWidget {
  final double? width;
  const DayCellWidget({
    Key? key,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10,),
        Row(
          children: <Widget>[
            Container(
                color: const Color(0xffffffff),
                width: width,
                child: const Text('Su', textAlign: TextAlign.center,style: TextStyle(fontSize: 18,color: Colors.red,fontFamily: 'Sora'))),
            Container(
              color: const Color(0xffffffff),
              width: width,
              child: const Text('Mo', textAlign: TextAlign.center, style: TextStyle(fontSize: 18,color: Colors.black,fontFamily: 'Sora')),
            ),
            Container(
              color: const Color(0xffffffff),
              width: width,
              child: const Text('Tu', textAlign: TextAlign.center, style: TextStyle(fontSize: 18,color: Colors.black,fontFamily: 'Sora')),
            ),
            Container(
              color: const Color(0xffffffff),
              width: width,
              child: const Text('We', textAlign: TextAlign.center, style: TextStyle(fontSize: 18,color: Colors.black,fontFamily: 'Sora')),
            ),
            Container(
              color: const Color(0xffffffff),
              width: width,
              child: const Text('Th', textAlign: TextAlign.center, style: TextStyle(fontSize: 18,color: Colors.black,fontFamily: 'Sora')),
            ),
            Container(
              color: const Color(0xffffffff),
              width: width,
              child: const Text('Fr', textAlign: TextAlign.center,style: TextStyle(fontSize: 18,color: Colors.black,fontFamily: 'Sora')),
            ),
            Container(
              color: const Color(0xffffffff),
              width: width,
              child: const Text('Sa', textAlign: TextAlign.center,style: TextStyle(fontSize: 18,color: Colors.blue,fontFamily: 'Sora')),
            ),
          ],
        ),
      ],
    );
  }
}
