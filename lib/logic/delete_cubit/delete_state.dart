part of 'delete_cubit.dart';

abstract class DeleteState {
  final GetModel? getModel;
  DeleteState({this.getModel});
}

class DeleteInital extends DeleteState {
  DeleteInital({super.getModel});
}

class DeleteLoading extends DeleteState {}
class DeleteSuccess extends DeleteState {}


class DeleteLoadded extends DeleteState {
  DeleteLoadded({super.getModel});
}

class DeleteError extends DeleteState {
  final String? errorMessage;
  DeleteError({this.errorMessage});
}
