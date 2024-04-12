import 'package:crude_bloc/logic/delete_cubit/delete_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeleteScreen extends StatefulWidget {
  const DeleteScreen({super.key});

  @override
  State<DeleteScreen> createState() => _DeleteScreenState();
}

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
final TextEditingController deleteController = TextEditingController();

class _DeleteScreenState extends State<DeleteScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Delete Data'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocBuilder<DeleteCubit, DeleteState>(
                builder: (context, state) {
                  if (state is DeleteLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is DeleteSuccess) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Data Delete SuccessFully",
                          style: TextStyle(fontSize: 25, color: Colors.green),
                        ),
                        ElevatedButton(
                            onPressed: () {
                            },
                            child: const Text("Re Delete"))
                      ],
                    );
                  } else if (state is DeleteError) {
                    return Center(
                      child: Text(state.errorMessage.toString()),
                    );
                  }
                  return _deleteDataWidget();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  _deleteDataWidget() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: deleteController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please Enter Id';
              }
              return null;
            },
            decoration: InputDecoration(
                hintText: 'Enter Id',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20))),
          ),
          const SizedBox(
            height: 20.0,
          ),
          ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  context
                      .read<DeleteCubit>()
                      .deleteData(id: deleteController.text);
                }
                // context
                //     .read<DeleteCubit>()
                //     .deleteData(id: deleteController.text);
              },
              child: const Text(
                'Delete Data',
                style: TextStyle(color: Colors.red, fontSize: 20),
              ))
        ],
      ),
    );
  }
}
