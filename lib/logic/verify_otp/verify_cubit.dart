import 'package:crude_bloc/api/api_base.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'verify_state.dart';

class VerifyCubit extends Cubit<VerifyState> {
  VerifyCubit() : super(VerifyInital());
  final ApiBase apiBase = ApiBase();

  Future<void> verifyOtp(
      {required BuildContext context,
      required String phoneNumber,
      required int otp}) async {
    try {
      final parameters = {"phoneNumber": phoneNumber, "otp": otp};
      await apiBase.post('https://4r4iwhot12.execute-api.ap-south-1.amazonaws.com/auth/auth/validateOtp/', parameters, (data) {}, (error) {
        emit(VerifyError(errorMessage: error));
      });
    } catch (e) {
      emit(VerifyError(errorMessage: e.toString()));
    }
  }
}
