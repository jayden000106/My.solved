import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:my_solved/pages/login_page.dart';
import 'package:my_solved/pages/main_tab_page.dart';
import 'package:my_solved/services/user_service.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: ((context) => UserService()),
        ),
        ChangeNotifierProvider(create: ((context) => UserService())),
      ],
      child: CupertinoApp(
        home: Consumer<UserService>(
          builder: (context, value, child) {
            return LayoutBuilder(
              builder: (context, constraints) {
                switch (value.state) {
                  case UserState.loading:
                    return Center(
                      child: Text('Loading'),
                    );
                  case UserState.unknown:
                    return LoginPage();
                  case UserState.logedin:
                    return Center(
                      child: MainTabPage(),
                    );
                }
              },
            );
          },
        ),
        theme: CupertinoThemeData(
            brightness: Brightness.light,
            textTheme: CupertinoTextThemeData(
              textStyle: TextStyle(
                fontFamily: "Pretendard",
                color: CupertinoColors.black,
              ),
            )),
      ),
    );
  }
}
