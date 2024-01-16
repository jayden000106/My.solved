import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_solved/components/styles/color.dart';
import 'package:my_solved/components/styles/font.dart';
import 'package:my_solved/features/home/bloc/home_bloc.dart';
import 'package:my_solved/features/setting/bloc/setting_bloc.dart';

class SettingScreen extends StatelessWidget {
  final HomeBloc homeBloc;

  const SettingScreen({super.key, required this.homeBloc});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingBloc(),
      child: SettingView(
        homeBloc: homeBloc,
      ),
    );
  }
}

class SettingView extends StatefulWidget {
  final HomeBloc homeBloc;

  const SettingView({super.key, required this.homeBloc});

  @override
  State<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text("설정", style: MySolvedTextStyle.title5),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.close),
          ),
        ],
      ),
      body: BlocBuilder<SettingBloc, SettingState>(
        bloc: BlocProvider.of<SettingBloc>(context),
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "사용자 설정",
                  style: MySolvedTextStyle.caption1
                      .copyWith(color: MySolvedColor.secondaryFont),
                ),
                Divider(),
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("일러스트 배경", style: MySolvedTextStyle.body2),
                    BlocBuilder<HomeBloc, HomeState>(
                      bloc: widget.homeBloc,
                      builder: (context, state) {
                        return Switch(
                          value: state.isShowIllustBackground,
                          onChanged: (isOn) => widget.homeBloc
                              .add(SettingIsShowIllustBackground(isOn: isOn)),
                          activeColor: MySolvedColor.background,
                          activeTrackColor: MySolvedColor.main,
                          inactiveThumbColor: MySolvedColor.background,
                          inactiveTrackColor:
                              MySolvedColor.disabledButtonBackground,
                          trackOutlineColor: MaterialStateProperty.resolveWith(
                            (states) {
                              if (states.contains(MaterialState.selected)) {
                                return null;
                              }
                              return MySolvedColor.disabledButtonBackground;
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(height: 24),
                Text(
                  "알림 설정",
                  style: MySolvedTextStyle.caption1
                      .copyWith(color: MySolvedColor.secondaryFont),
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("스트릭 알림", style: MySolvedTextStyle.body2),
                    Switch(
                      value: true,
                      onChanged: ((value) {}),
                      activeColor: MySolvedColor.background,
                      activeTrackColor: MySolvedColor.main,
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("스트릭 알림 시간", style: MySolvedTextStyle.body2),
                    TextButton(
                      onPressed: () async {
                        // final TimeOfDay? timeOfDay = await showTimePicker(
                        //   context: context,
                        //   initialTime: state.streakTime,
                        // );
                      },
                      style: TextButton.styleFrom(
                        minimumSize: Size.zero,
                        padding: EdgeInsets.zero,
                        foregroundColor: MySolvedColor.font,
                      ),
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: MySolvedColor.textFieldBorder,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          "${state.streakTime.hour}:${state.streakTime.minute}",
                          style: MySolvedTextStyle.body1,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("대회 시작 알림", style: MySolvedTextStyle.body2),
                    Switch(
                      value: true,
                      onChanged: ((value) {}),
                      activeColor: MySolvedColor.background,
                      activeTrackColor: MySolvedColor.main,
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("대회 시작 알림 시간", style: MySolvedTextStyle.body2),
                  ],
                ),
                Text(
                  "대회 알림 설정 이후에 시간을 변경하면 적용되지 않습니다",
                  style: MySolvedTextStyle.caption1.copyWith(
                    color: MySolvedColor.secondaryFont,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
