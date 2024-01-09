import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_solved/app/bloc/app_bloc.dart';
import 'package:my_solved/components/atoms/button/my_solved_text_button.dart';
import 'package:my_solved/components/styles/color.dart';
import 'package:my_solved/components/styles/font.dart';
import 'package:my_solved/features/home/screen/home_screen.dart';
import 'package:my_solved/features/root/bloc/root_bloc.dart';
import 'package:my_solved/features/setting/screen/setting_screen.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => RootBloc()),
      ],
      child: RootView(),
    );
  }
}

class RootView extends StatefulWidget {
  const RootView({super.key});

  @override
  State<RootView> createState() => _RootViewState();
}

class _RootViewState extends State<RootView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    List<BottomNavigationBarItem> bottomNavItems = [
      BottomNavigationBarItem(
        icon: Icon(Icons.home_filled),
        label: "Home",
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.search),
        label: "Search",
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.calendar_month),
        label: "contest",
      ),
    ];
    List<Widget> bottomNaviScreen = [
      HomeScreen(
        scaffoldKey: _scaffoldKey,
      ),
      Text("Search"),
      Text("Contest"),
    ];
    return BlocBuilder<RootBloc, RootState>(
      builder: (context, state) {
        return Scaffold(
          key: _scaffoldKey,
          endDrawer: HomeDrawer(),
          body: bottomNaviScreen.elementAt(state.tabIndex),
          bottomNavigationBar: BottomNavigationBar(
            items: bottomNavItems,
            currentIndex: state.tabIndex,
            selectedItemColor: MySolvedColor.main,
            selectedLabelStyle: MySolvedTextStyle.caption2,
            unselectedItemColor: MySolvedColor.bottomNavigationBarUnselected,
            unselectedLabelStyle: MySolvedTextStyle.caption2,
            onTap: (index) {
              context
                  .read<RootBloc>()
                  .add(NavigationBarItemTapped(tabIndex: index));
            },
          ),
        );
      },
    );
  }
}

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          bottomLeft: Radius.circular(16),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 24,
            horizontal: 8,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(color: MySolvedColor.divider),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MySolvedTextButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SettingScreen()),
                      ),
                      text: "설정",
                    ),
                    SizedBox(height: 16),
                    MySolvedTextButton(
                      onPressed: () => context.read<AppBloc>().add(Logout()),
                      text: "로그아웃",
                    ),
                  ],
                ),
              ),
              Divider(color: MySolvedColor.divider),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("버전 정보", style: MySolvedTextStyle.body2),
                    Text(
                      "1.0.0",
                      style: MySolvedTextStyle.body2.copyWith(
                        color: MySolvedColor.secondaryFont,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
