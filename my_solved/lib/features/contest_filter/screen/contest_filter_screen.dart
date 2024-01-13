import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_solved/components/styles/color.dart';
import 'package:my_solved/components/styles/font.dart';
import 'package:my_solved/features/contest_filter/bloc/contest_filter_bloc.dart';

class ContestFilterScreen extends StatelessWidget {
  const ContestFilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ContestFilterBloc>(
      create: (context) => ContestFilterBloc(),
      child: ContestFilterView(),
    );
  }
}

class ContestFilterView extends StatefulWidget {
  const ContestFilterView({super.key});

  @override
  State<ContestFilterView> createState() => _ContestFilterViewState();
}

class _ContestFilterViewState extends State<ContestFilterView> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      ),
      child: Scaffold(
        backgroundColor: MySolvedColor.background,
        appBar: AppBar(
          backgroundColor: MySolvedColor.background,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text("대회 필터 설정", style: MySolvedTextStyle.title5),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("주최", style: MySolvedTextStyle.body2),
              Divider(),
              SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: List.generate(
                  context.read<ContestFilterBloc>().state.venues.length,
                  (index) {
                    final venues =
                        context.read<ContestFilterBloc>().state.venues;
                    return Container(
                      decoration: BoxDecoration(
                        color: MySolvedColor.main,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                      child: Text(
                        venues[index].displayName,
                        style: MySolvedTextStyle.body1
                            .copyWith(color: MySolvedColor.background),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
