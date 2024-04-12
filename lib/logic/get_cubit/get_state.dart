part of 'get_cubit.dart';

abstract class GetState {
  List<GetModel>? getModel;
  GetState({this.getModel});
}

 class GetInital extends GetState {
  GetInital({super.getModel});
}

 class GetLoading extends GetState {
  GetLoading({super.getModel});
}

 class GetLoaded extends GetState {
  GetLoaded({super.getModel});
}

 class GetError extends GetState {
  final String? errorMessage;
  GetError({this.errorMessage});
}
