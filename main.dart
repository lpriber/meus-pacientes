import 'package:flutter/material.dart';
class MeusPacientesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meus Pacientes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PacientesListScreen(),
    );
  }
}
class Paciente {
  final String nome;
  final int idade;
  final String genero;
  final String endereco;
  final String telefone;
  Paciente({
    required this.nome,
    required this.idade,
    required this.genero,
    required this.endereco,
    required this.telefone,
  });
}
class PacientesListScreen extends StatefulWidget {
  @override
  _PacientesListScreenState createState() => _PacientesListScreenState();
}
class _PacientesListScreenState extends State<PacientesListScreen> {
  List<Paciente> pacientes = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meus Pacientes'),
      ),
      body: ListView.builder(
        itemCount: pacientes.length,
        itemBuilder: (context, index) {
          final paciente = pacientes[index];
          return ListTile(
            title: Text(paciente.nome),
            subtitle: Text('Idade: ${paciente.idade}'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PacienteDetailsScreen(
                    paciente: paciente,
                    onDelete: () {
                      setState(() {
                        pacientes.removeAt(index);
                      });
                      Navigator.pop(context);
                    },
                    onEdit: (novoPaciente) {
                      setState(() {
                        pacientes[index] = novoPaciente;
                      });
                      Navigator.pop(context);
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          final novoPaciente = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddEditPacienteScreen(),
            ),
          );
          if (novoPaciente != null) {
            setState(() {
              pacientes.add(novoPaciente);
            });
          }
        },
      ),
    );
  }
}
class PacienteDetailsScreen extends StatefulWidget {
  final Paciente paciente;
  final Function onDelete;
  final Function(Paciente) onEdit;
  PacienteDetailsScreen({
    required this.paciente,
    required this.onDelete,
    required this.onEdit,
  });
  @override
  _PacienteDetailsScreenState createState() => _PacienteDetailsScreenState();
}
class _PacienteDetailsScreenState extends State<PacienteDetailsScreen> {
  late TextEditingController nomeController;
  late TextEditingController idadeController;
  late TextEditingController generoController;
  late TextEditingController enderecoController;
  late TextEditingController telefoneController;
  @override
  void initState() {
    super.initState();
    nomeController = TextEditingController(text: widget.paciente.nome);
    idadeController = TextEditingController(text: widget.paciente.idade.toString());
    generoController = TextEditingController(text: widget.paciente.genero);
    enderecoController = TextEditingController(text: widget.paciente.endereco);
    telefoneController = TextEditingController(text: widget.paciente.telefone);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes do Paciente'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: nomeController,
              decoration: InputDecoration(
                labelText: 'Nome',
              ),
            ),
            TextField(
              controller: idadeController,
              decoration: InputDecoration(
                labelText: 'Idade',
              ),
            ),
            TextField(
              controller: generoController,
              decoration: InputDecoration(
                labelText: 'Gênero',
              ),
            ),
            TextField(
              controller: enderecoController,
              decoration: InputDecoration(
                labelText: 'Endereço',
              ),
            ),
            TextField(
              controller: telefoneController,
              decoration: InputDecoration(
                labelText: 'Telefone',
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    child: Text('Salvar'),
                    onPressed: () {
                      final novoPaciente = Paciente(
                        nome: nomeController.text,
                        idade: int.tryParse(idadeController.text) ?? 0,
                        genero: generoController.text,
                        endereco: enderecoController.text,
                        telefone: telefoneController.text,
                      );
                      widget.onEdit(novoPaciente);
                    },
                  ),
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: ElevatedButton(
                    child: Text('Excluir'),
                    onPressed: () {
                      widget.onDelete();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
class AddEditPacienteScreen extends StatefulWidget {
  @override
  _AddEditPacienteScreenState createState() => _AddEditPacienteScreenState();
}
class _AddEditPacienteScreenState extends State<AddEditPacienteScreen> {
  late TextEditingController nomeController;
  late TextEditingController idadeController;
  late TextEditingController generoController;
  late TextEditingController enderecoController;
  late TextEditingController telefoneController;
  @override
  void initState() {
    super.initState();
    nomeController = TextEditingController();
    idadeController = TextEditingController();
    generoController = TextEditingController();
    enderecoController = TextEditingController();
    telefoneController = TextEditingController();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Paciente'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: nomeController,
              decoration: InputDecoration(
                labelText: 'Nome',
              ),
            ),
            TextField(
              controller: idadeController,
              decoration: InputDecoration(
                labelText: 'Idade',
              ),
            ),
            TextField(
              controller: generoController,
              decoration: InputDecoration(
                labelText: 'Gênero',
              ),
            ),
            TextField(
              controller: enderecoController,
              decoration: InputDecoration(
                labelText: 'Endereço',
              ),
            ),
            TextField(
              controller: telefoneController,
              decoration: InputDecoration(
                labelText: 'Telefone',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              child: Text('Salvar'),
              onPressed: () {
                final novoPaciente = Paciente(
                  nome: nomeController.text,
                  idade: int.tryParse(idadeController.text) ?? 0,
                  genero: generoController.text,
                  endereco: enderecoController.text,
                  telefone: telefoneController.text,
                );
                Navigator.of(context).pop(novoPaciente);
              },
            ),
          ],
        ),
      ),
    );
  }
}
void main() {
  runApp(MeusPacientesApp());
}