import 'package:crude_bloc/logic/verify_otp/verify_cubit.dart';
import 'package:crude_bloc/screens/get_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';

class VerifyOtpScreen extends StatefulWidget {
  final String phoneNumber;

  const VerifyOtpScreen({
    super.key,
    required this.phoneNumber,
  });

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  TextEditingController otpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffFFBBB2),
        appBar: AppBar(
          backgroundColor: const Color(0xffFFBBB2),
          title: const Text("Otp Verify"),
          centerTitle: true,
        ),
        body: BlocBuilder<VerifyCubit, VerifyState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Pinput(
                      controller: otpController,
                      length: 6,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const GetScreen(),
                              ));
                          context.read<VerifyCubit>().verifyOtp(
                              context: context,
                              phoneNumber: widget.phoneNumber,
                              otp: int.parse(otpController.text));
                        },
                        child: const Text("Verify Otp"))
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
