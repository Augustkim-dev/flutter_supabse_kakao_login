import 'package:flutter/material.dart';
import 'package:flutter_supabse_kakao_login/kakao_login_info.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_template.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseKakaoLogin extends StatelessWidget {
  SupabaseKakaoLogin({super.key});

  final supabase = Supabase.instance.client;

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
                onPressed: () async {
                  final signin =
                      await supabase.auth.signInWithOAuth(OAuthProvider.kakao);
                  print('로그인 결과 : $signin');
                  supabase.auth.onAuthStateChange.listen((data) {
                    final AuthChangeEvent event = data.event;
                    print('이벤트 : $event');
                    if (event == AuthChangeEvent.signedIn) {
                      debugPrint('데이터 : $data');
                      debugPrint('세션 : ${data.session}');

                      // Do something when user sign in
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              KakaoInfo(session: data.session!)));
                    }
                  });
                },
                child: Text('카카오 로그인')),
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
