import 'package:bloc/bloc.dart';
import 'package:crude_bloc/api/api_base.dart';
import 'package:crude_bloc/model/get_model.dart';

part 'get_state.dart';

class GetCubit extends Cubit<GetState> {
  GetCubit() : super(GetInital());
  ApiBase apiBase = ApiBase();
  Future<void> getData() async {
    emit(GetLoading());
    try {
      await apiBase.get(
        'https://65804ce16ae0629a3f54dbdb.mockapi.io/Apiendpoint/PostApi',
        (data) {
          // var json=GetModel.fromJson(data);
          List<GetModel> posts = [];
          for (var postJson in data) {
            var post = GetModel.fromJson(postJson);
            posts.add(post);
          }
          emit(GetLoaded(getModel: posts));
        },
        (error) {
          emit(GetError(errorMessage: error));
        },
      );
    } catch (e) {
      emit(GetError(errorMessage: e.toString()));
    }
  }
}
