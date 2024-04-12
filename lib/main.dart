import 'package:crude_bloc/logic/delete_cubit/delete_cubit.dart';
import 'package:crude_bloc/logic/get_cubit/get_cubit.dart';
import 'package:crude_bloc/logic/send_otp_cubit/post_cubit.dart';
import 'package:crude_bloc/logic/update_cubit/update_cubit.dart';
import 'package:crude_bloc/logic/verify_otp/verify_cubit.dart';
import 'package:crude_bloc/screens/post_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetCubit(),
        ),
        BlocProvider(
          create: (context) => PostCubit(),
        ),
        BlocProvider(
          create: (context) => VerifyCubit(),
        ),
        BlocProvider(
          create: (context) => PutCubit(),
        ),
        BlocProvider(
          create: (context) => DeleteCubit(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: PostScreen(),
      ),
    );
  }
}
