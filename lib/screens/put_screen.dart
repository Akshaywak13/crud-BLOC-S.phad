import 'package:crude_bloc/logic/get_cubit/get_cubit.dart';
import 'package:crude_bloc/logic/update_cubit/update_cubit.dart';
import 'package:crude_bloc/screens/delete_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PutScreen extends StatefulWidget {
  const PutScreen({Key? key}) : super(key: key);

  @override
  State<PutScreen> createState() => _PutScreenState();
}

class _PutScreenState extends State<PutScreen> {
  final TextEditingController idController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    context.read<GetCubit>().getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Data"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          BlocBuilder<GetCubit, GetState>(
            builder: (context, state) {
              if(state is GetLoading){
                return Center(child: CircularProgressIndicator(),);
                
              }else if(state is GetLoaded){
                return SizedBox(height: 50,
                child: Expanded(child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.getModel!.length,
                  itemBuilder:(context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text("ID:${state.getModel![index].id??''}",style: TextStyle(color: Colors.red),),
                  );
                },),
                ),
                );
              }
              return Container();
            },
          ),
          BlocConsumer<PutCubit, PutState>(
            listener: (context, state) {
              if (state is PutLoadded) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Data Updated Successfully'),
                  ),
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DeleteScreen(),
                  ),
                );
              } else if (state is PutError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Error: ${state.errorMessage}'),
                  ),
                );
              }
            },
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: idController,
                        decoration: InputDecoration(
                          hintText: 'Enter ID',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter ID';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                          hintText: 'Enter Name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            final id = idController.text;
                            final name = nameController.text;
                            context.read<PutCubit>().putData(id: id, name: name);
                          }
                        },
                        child: const Text("Update Data"),
                      ),
                      SizedBox(height: 15,),
                      ElevatedButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>DeleteScreen()));
                      },
                       child: Text("Delete"))
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
