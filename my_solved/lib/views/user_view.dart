import 'package:flutter/cupertino.dart';
import 'package:my_solved/models/user.dart';
import 'package:my_solved/services/network_service.dart';
import 'package:my_solved/services/user_service.dart';
import 'package:my_solved/widgets/user_widget.dart';
import 'package:provider/provider.dart';

class UserView extends StatefulWidget {
  const UserView({Key? key, required this.username}) : super(key: key);

  final String username;

  @override
  State<UserView> createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  final UserService userService = UserService();
  final NetworkService networkService = NetworkService();

  @override
  Widget build(BuildContext context) {
    String username = widget.username;
    var navigationBar = CupertinoNavigationBar(
      leading: CupertinoNavigationBarBackButton(
        color: CupertinoColors.label,
        onPressed: () => Navigator.of(context).pop(),
      ),
      middle: Text(widget.username),
    );
    return CupertinoPageScaffold(
        resizeToAvoidBottomInset: false,
        navigationBar: navigationBar,
        child: SafeArea(
            child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: FutureBuilder(
                  future: networkService.requestUser(username),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final User? user = snapshot.data;
                      final Widget widgetGrass = grass(context, snapshot,
                          networkService.requestStreak(user?.handle ?? ''));
                      final Widget widgetTop100 = top100(context, snapshot,
                          networkService.requestTop100(user?.handle ?? ''));
                      final Widget widgetTagChart = tagChart(context, snapshot);
                      final Widget widgetBadges = badges(context,
                          networkService.requestBadges(user?.handle ?? ''));

                      late Widget widgetBackground = backgroundImage(
                          context,
                          networkService
                              .requestBackground(user?.backgroundId ?? ''));

                      late Widget widgetBadge;
                      if (user?.badgeId != null) {
                        widgetBadge = badge(context,
                            networkService.requestBadge(user?.badgeId ?? ''));
                      } else {
                        widgetBadge = SizedBox.shrink();
                      }

                      final PageController pageController = PageController(
                        initialPage: userService.currentHomeTab,
                      );

                      return Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          profileHeader(context, snapshot, widgetBackground),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.08),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.05),
                            margin: EdgeInsets.only(bottom: 10),
                            child:
                                profileDetail(context, snapshot, widgetBadge),
                          ),
                          const SizedBox(height: 10),
                          Consumer<UserService>(
                            builder: (context, userService, child) {
                              return CupertinoSlidingSegmentedControl(
                                children: const <int, Widget>{
                                  0: Text('스트릭'),
                                  1: Text('레이팅'),
                                  2: Text('태그'),
                                  3: Text('뱃지'),
                                },
                                groupValue: userService.currentHomeTab,
                                onValueChanged: (int? value) {
                                  if (value != null) {
                                    userService.setCurrentHomeTab(value);
                                    pageController.animateToPage(value,
                                        duration:
                                            const Duration(milliseconds: 300),
                                        curve: Curves.ease);
                                  }
                                },
                              );
                            },
                          ),
                          const SizedBox(height: 10),
                          Container(
                            alignment: Alignment.topCenter,
                            height: MediaQuery.of(context).size.height,
                            child: PageView(
                              controller: pageController,
                              onPageChanged: (int index) {
                                userService.setCurrentHomeTab(index);
                              },
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          MediaQuery.of(context).size.width *
                                              0.05),
                                  child: widgetGrass,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          MediaQuery.of(context).size.width *
                                              0.05),
                                  child: widgetTop100,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          MediaQuery.of(context).size.width *
                                              0.05),
                                  child: widgetTagChart,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          MediaQuery.of(context).size.width *
                                              0.05),
                                  child: widgetBadges,
                                )
                              ],
                            ),
                          ),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }
                    return Center(child: CupertinoActivityIndicator());
                  },
                ))));
  }
}
