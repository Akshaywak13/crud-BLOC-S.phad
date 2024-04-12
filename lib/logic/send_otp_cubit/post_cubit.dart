import 'package:bloc/bloc.dart';
import 'package:crude_bloc/api/api_base.dart';
part 'post_state.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit() : super(PostInital());
  ApiBase apiBase = ApiBase();
  Future<void> postData({
    required String phoneNumber,
    required int groupId,
  }) async {
    try {
      final parameters = {
        "phoneNumber": phoneNumber,
        "groupId": 1703228300417.toString(),
      };
      await apiBase.post(
          'https://gxppcdmn7h.execute-api.ap-south-1.amazonaws.com/authgw/sendotp',
          parameters,
          (data) {}, (error) {
        emit(PostError(errorMessage: error));
      });
    } catch (e) {
      emit(PostError(errorMessage: e.toString()));
    }
  }
}
