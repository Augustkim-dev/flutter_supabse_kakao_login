import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_template.dart';

class SupabaseKakaoLogin extends StatelessWidget {
  const SupabaseKakaoLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kakao'),
      ),
      body: Container(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                hashKeyCheck().then((value) {
                  return showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('hash Key'),
                          content: Text('$value'),
                          actions: [
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('Back')),
                          ],
                        );
                      });
                });
              },
              child: Text('Hash key check'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Back'),
            ),
          ],
        ),
      ),
    );
  }

  Future hashKeyCheck() async {
    var hash = await KakaoSdk.origin;
    if (hash.isNotEmpty) {
      // print('hash key : $hash');
      return "해시키 존재";
    } else {
      return "해시키 없음";
    }
  }
}
