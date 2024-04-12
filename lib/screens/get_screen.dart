// ignore_for_file: non_constant_identifier_names

import 'package:crude_bloc/logic/get_cubit/get_cubit.dart';
import 'package:crude_bloc/screens/put_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetScreen extends StatefulWidget {
  const GetScreen({super.key});

  @override
  State<GetScreen> createState() => _GetScreenState();
}

class _GetScreenState extends State<GetScreen> {
  @override
  void initState() {
    context.read<GetCubit>().getData();
    Future.delayed(
      const Duration(seconds: 10),
      () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const PutScreen(),));
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(title: const Text("GET SCRREEN")),
      body: BlocBuilder<GetCubit, GetState>(
        builder: (context, state) {
          if (state is GetLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is GetLoaded) {
            return ListView.builder(
              itemCount: state.getModel?.length,
              itemBuilder: (context, index) {
                return Card(
                  shadowColor: Colors.red,
                  child: ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(state.getModel?[index].id.toString() ?? '1'),
                        Text(
                          state.getModel?[index].id ?? '',
                          maxLines: 1,
                        ),
                        Text(
                          state.getModel?[index].name ?? '',
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (state is GetError) {
            return Text(state.errorMessage.toString());
          }
          return const SizedBox();
        },
      ),
    ));
  }
}
