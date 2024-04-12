import 'package:crude_bloc/logic/send_otp_cubit/post_cubit.dart';
import 'package:crude_bloc/screens/verify_otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostScreen extends StatefulWidget {
  final phoneNumber = '';
  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Send Otp"),
          centerTitle: true,
          backgroundColor: const Color(0xffFFBBB2),
        ),
        backgroundColor: const Color(0xffFFBBB2),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _otpController,
                  decoration: const InputDecoration(
                      hintText: "Enter Number",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(10),
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a phone number';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<PostCubit>()
                      .postData(
                            phoneNumber: _otpController.text,
                            groupId: 1703228300417,
                          );
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VerifyOtpScreen(
                                phoneNumber: _otpController.text),
                          ));
                    }
                  },
                  child: const Text("Send OTP"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
