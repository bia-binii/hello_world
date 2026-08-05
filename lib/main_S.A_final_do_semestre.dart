import 'package:flutter/material.dart';

void main() {
  runApp(const EstoqueApp());
}

class EstoqueApp extends StatelessWidget {
  const EstoqueApp({super.key});

  @override
  Widget build(BuildContext context) {
    const rosaBebe = Color(0xFFF7C9D8);
    const rosaEscuro = Color(0xFFE07A9A);
    const rosaFundo = Color(0xFFFFF3F6);

    return MaterialApp(
      title: 'Estoque Charme',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: rosaFundo,
        colorScheme: ColorScheme.fromSeed(
          seedColor: rosaEscuro,
          primary: rosaEscuro,
          secondary: rosaBebe,
          surface: Colors.white,
        ),
        fontFamily: 'Poppins',
        appBarTheme: const AppBarTheme(
          backgroundColor: rosaBebe,
          foregroundColor: Color(0xFF6B3A4B),
          elevation: 0,
          centerTitle: false,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

class Produto {
  String nome;
  String categoria;
  int quantidade;
  double preco;
  int estoqueMinimo;

  Produto({
    required this.nome,
    required this.categoria,
    required this.quantidade,
    required this.preco,
    this.estoqueMinimo = 5,
  });

  bool get estoqueBaixo => quantidade <= estoqueMinimo;
  double get valorTotal => quantidade * preco;
}

List<Produto> produtosIniciais() {
  return [
    Produto(nome: 'Colar Coração Rosé', categoria: 'Colares', quantidade: 12, preco: 29.90),
    Produto(nome: 'Brinco Argola Dourado', categoria: 'Brincos', quantidade: 3, preco: 18.50, estoqueMinimo: 5),
    Produto(nome: 'Pulseira Pérola', categoria: 'Pulseiras', quantidade: 20, preco: 22.00),
    Produto(nome: 'Anel Solitário', categoria: 'Anéis', quantidade: 2, preco: 15.90, estoqueMinimo: 4),
    Produto(nome: 'Presilha Laço Rosa', categoria: 'Cabelo', quantidade: 35, preco: 8.90),
    Produto(nome: 'Bolsa Transversal Mini', categoria: 'Bolsas', quantidade: 6, preco: 59.90),
    Produto(nome: 'Óculos de Sol Retrô', categoria: 'Óculos', quantidade: 4, preco: 45.00, estoqueMinimo: 5),
    Produto(nome: 'Tiara Flor de Cetim', categoria: 'Cabelo', quantidade: 18, preco: 12.90),
  ];
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Produto> _produtos = produtosIniciais();
  int _indiceAtual = 0;

  final List<String> _categorias = const [
    'Todos', 'Colares', 'Brincos', 'Pulseiras', 'Anéis', 'Cabelo', 'Bolsas', 'Óculos'
  ];
  String _categoriaSelecionada = 'Todos';
  String _busca = '';

  double get _valorTotalEstoque =>
      _produtos.fold(0, (soma, p) => soma + p.valorTotal);

  int get _totalItens => _produtos.fold(0, (soma, p) => soma + p.quantidade);

  int get _itensEstoqueBaixo => _produtos.where((p) => p.estoqueBaixo).length;

  List<Produto> get _produtosFiltrados {
    return _produtos.where((p) {
      final categoriaOk = _categoriaSelecionada == 'Todos' ||
          p.categoria == _categoriaSelecionada;
      final buscaOk =
          p.nome.toLowerCase().contains(_busca.toLowerCase());
      return categoriaOk && buscaOk;
    }).toList();
  }

  void _abrirCadastro({Produto? produtoEditar}) async {
    final resultado = await Navigator.push<Produto>(
      context,
      MaterialPageRoute(
        builder: (_) => CadastroProdutoScreen(produto: produtoEditar),
      ),
    );

    if (resultado != null) {
      setState(() {
        if (produtoEditar != null) {
          final idx = _produtos.indexOf(produtoEditar);
          _produtos[idx] = resultado;
        } else {
          _produtos.add(resultado);
        }
      });
    }
  }

  void _removerProduto(Produto produto) {
    setState(() => _produtos.remove(produto));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${produto.nome} removido do estoque'),
        backgroundColor: const Color(0xFFE07A9A),
      ),
    );
  }

  void _alterarQuantidade(Produto produto, int delta) {
    setState(() {
      final novaQtd = produto.quantidade + delta;
      produto.quantidade = novaQtd < 0 ? 0 : novaQtd;
    });
  }

  @override
  Widget build(BuildContext context) {
    final paginas = [
      _buildEstoquePage(),
      const RelatorioScreen(),
      const PerfilScreen(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: const [
            Icon(Icons.storefront_rounded, size: 26),
            SizedBox(width: 8),
            Text('Estoque Charme',
                style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_outlined),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: paginas[_indiceAtual],
      floatingActionButton: _indiceAtual == 0
          ? FloatingActionButton(
              backgroundColor: const Color(0xFFE07A9A),
              onPressed: () => _abrirCadastro(),
              child: const Icon(Icons.add, color: Colors.white),
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _indiceAtual,
        onTap: (i) => setState(() => _indiceAtual = i),
        selectedItemColor: const Color(0xFFE07A9A),
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.inventory_2_outlined), label: 'Estoque'),
          BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart_rounded), label: 'Relatório'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: 'Perfil'),
        ],
      ),
    );
  }

  Widget _buildEstoquePage() {
    return Column(
      children: [
        // Card resumo do mês (inspirado no card "Resumo do Mês")
        Container(
          margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFF7C9D8), Color(0xFFFCE4EC)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.pink.withOpacity(0.15),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Resumo do Estoque',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF6B3A4B),
                ),
              ),
              const SizedBox(height: 14),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _resumoItem(Icons.category_rounded, 'Produtos',
                      '${_produtos.length}'),
                  _resumoItem(Icons.numbers_rounded, 'Itens', '$_totalItens'),
                  _resumoItem(Icons.warning_amber_rounded, 'Estoque baixo',
                      '$_itensEstoqueBaixo', destaque: _itensEstoqueBaixo > 0),
                ],
              ),
              const Divider(height: 26, color: Color(0xFFEAB4C6)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Valor total em estoque',
                      style: TextStyle(
                          fontSize: 13, color: Color(0xFF6B3A4B))),
                  Text(
                    'R\$ ${_valorTotalEstoque.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF6B3A4B),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Barra de busca
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          child: TextField(
            onChanged: (v) => setState(() => _busca = v),
            decoration: InputDecoration(
              hintText: 'Buscar produto...',
              prefixIcon: const Icon(Icons.search, color: Color(0xFFE07A9A)),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(vertical: 0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),

        // Categorias (chips horizontais, como na tela de Supermercado)
        SizedBox(
          height: 44,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: _categorias.length,
            itemBuilder: (context, index) {
              final cat = _categorias[index];
              final selecionada = cat == _categoriaSelecionada;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: ChoiceChip(
                  label: Text(cat),
                  selected: selecionada,
                  onSelected: (_) =>
                      setState(() => _categoriaSelecionada = cat),
                  selectedColor: const Color(0xFFE07A9A),
                  backgroundColor: Colors.white,
                  labelStyle: TextStyle(
                    color: selecionada ? Colors.white : const Color(0xFF6B3A4B),
                    fontWeight: FontWeight.w500,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(
                      color: selecionada
                          ? const Color(0xFFE07A9A)
                          : const Color(0xFFF0C4D3),
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 4),

        // Lista de produtos
        Expanded(
          child: _produtosFiltrados.isEmpty
              ? const Center(
                  child: Text('Nenhum produto encontrado 🎀',
                      style: TextStyle(color: Colors.grey)),
                )
              : ListView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 90),
                  itemCount: _produtosFiltrados.length,
                  itemBuilder: (context, index) {
                    final produto = _produtosFiltrados[index];
                    return _produtoCard(produto);
                  },
                ),
        ),
      ],
    );
  }

  Widget _resumoItem(IconData icone, String label, String valor,
      {bool destaque = false}) {
    return Column(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor:
              destaque ? const Color(0xFFE07A9A) : Colors.white,
          child: Icon(icone,
              color: destaque ? Colors.white : const Color(0xFFE07A9A),
              size: 20),
        ),
        const SizedBox(height: 6),
        Text(valor,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Color(0xFF6B3A4B))),
        Text(label,
            style: const TextStyle(fontSize: 11, color: Color(0xFF9A6B7B))),
      ],
    );
  }

  Widget _produtoCard(Produto produto) {
    return Dismissible(
      key: ValueKey(produto),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => _removerProduto(produto),
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.red.shade300,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Icons.delete_outline, color: Colors.white),
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.pink.withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: const Color(0xFFFCE4EC),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(_iconePorCategoria(produto.categoria),
                  color: const Color(0xFFE07A9A)),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: GestureDetector(
                onTap: () => _abrirCadastro(produtoEditar: produto),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(produto.nome,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF4A2E37))),
                    const SizedBox(height: 2),
                    Text(produto.categoria,
                        style: const TextStyle(
                            fontSize: 12, color: Color(0xFF9A6B7B))),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          'R\$ ${produto.preco.toStringAsFixed(2)}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFE07A9A)),
                        ),
                        if (produto.estoqueBaixo) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.orange.shade100,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text('Estoque baixo',
                                style: TextStyle(
                                    fontSize: 10, color: Colors.deepOrange)),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // Contador de quantidade (+ / -)
            Column(
              children: [
                Row(
                  children: [
                    _botaoQtd(Icons.remove, () => _alterarQuantidade(produto, -1)),
                    Container(
                      width: 32,
                      alignment: Alignment.center,
                      child: Text('${produto.quantidade}',
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    _botaoQtd(Icons.add, () => _alterarQuantidade(produto, 1)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _botaoQtd(IconData icone, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: 26,
        height: 26,
        decoration: BoxDecoration(
          color: const Color(0xFFFCE4EC),
          shape: BoxShape.circle,
        ),
        child: Icon(icone, size: 15, color: const Color(0xFFE07A9A)),
      ),
    );
  }

  IconData _iconePorCategoria(String categoria) {
    switch (categoria) {
      case 'Colares':
        return Icons.favorite_border;
      case 'Brincos':
        return Icons.circle_outlined;
      case 'Pulseiras':
        return Icons.watch_outlined;
      case 'Anéis':
        return Icons.diamond_outlined;
      case 'Cabelo':
        return Icons.face_retouching_natural;
      case 'Bolsas':
        return Icons.shopping_bag_outlined;
      case 'Óculos':
        return Icons.visibility_outlined;
      default:
        return Icons.category_outlined;
    }
  }
}


class CadastroProdutoScreen extends StatefulWidget {
  final Produto? produto;
  const CadastroProdutoScreen({super.key, this.produto});

  @override
  State<CadastroProdutoScreen> createState() => _CadastroProdutoScreenState();
}

class _CadastroProdutoScreenState extends State<CadastroProdutoScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nomeCtrl;
  late TextEditingController _precoCtrl;
  late TextEditingController _qtdCtrl;
  late TextEditingController _minCtrl;
  String _categoria = 'Colares';

  final List<String> _categorias = const [
    'Colares', 'Brincos', 'Pulseiras', 'Anéis', 'Cabelo', 'Bolsas', 'Óculos'
  ];

  @override
  void initState() {
    super.initState();
    final p = widget.produto;
    _nomeCtrl = TextEditingController(text: p?.nome ?? '');
    _precoCtrl = TextEditingController(text: p?.preco.toString() ?? '');
    _qtdCtrl = TextEditingController(text: p?.quantidade.toString() ?? '');
    _minCtrl = TextEditingController(text: p?.estoqueMinimo.toString() ?? '5');
    _categoria = p?.categoria ?? 'Colares';
  }

  void _salvar() {
    if (_formKey.currentState!.validate()) {
      final produto = Produto(
        nome: _nomeCtrl.text.trim(),
        categoria: _categoria,
        quantidade: int.tryParse(_qtdCtrl.text) ?? 0,
        preco: double.tryParse(_precoCtrl.text.replaceAll(',', '.')) ?? 0,
        estoqueMinimo: int.tryParse(_minCtrl.text) ?? 5,
      );
      Navigator.pop(context, produto);
    }
  }

  @override
  Widget build(BuildContext context) {
    final editando = widget.produto != null;
    return Scaffold(
      appBar: AppBar(
        title: Text(editando ? 'Editar Produto' : 'Novo Produto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _campoTexto(_nomeCtrl, 'Nome do produto', Icons.label_outline,
                  validar: true),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _categoria,
                decoration: _decoracaoInput('Categoria', Icons.category_outlined),
                items: _categorias
                    .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                    .toList(),
                onChanged: (v) => setState(() => _categoria = v!),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _campoTexto(_precoCtrl, 'Preço (R\$)',
                        Icons.attach_money,
                        tipoNumerico: true, validar: true),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _campoTexto(_qtdCtrl, 'Quantidade',
                        Icons.inventory_2_outlined,
                        tipoNumerico: true, validar: true),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _campoTexto(_minCtrl, 'Estoque mínimo (alerta)',
                  Icons.warning_amber_rounded,
                  tipoNumerico: true),
              const SizedBox(height: 28),
              ElevatedButton(
                onPressed: _salvar,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE07A9A),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                ),
                child: Text(editando ? 'Salvar alterações' : 'Cadastrar produto',
                    style: const TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _decoracaoInput(String label, IconData icone) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icone, color: const Color(0xFFE07A9A)),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
    );
  }

  Widget _campoTexto(TextEditingController ctrl, String label, IconData icone,
      {bool tipoNumerico = false, bool validar = false}) {
    return TextFormField(
      controller: ctrl,
      keyboardType: tipoNumerico
          ? const TextInputType.numberWithOptions(decimal: true)
          : TextInputType.text,
      decoration: _decoracaoInput(label, icone),
      validator: validar
          ? (v) => (v == null || v.trim().isEmpty) ? 'Campo obrigatório' : null
          : null,
    );
  }
}

class RelatorioScreen extends StatelessWidget {
  const RelatorioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.bar_chart_rounded, size: 70, color: Color(0xFFE07A9A)),
            SizedBox(height: 16),
            Text(
              'Relatórios em breve',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF6B3A4B)),
            ),
            SizedBox(height: 8),
            Text(
              'Aqui você poderá ver gráficos de vendas,\nprodutos mais vendidos e giro de estoque.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Color(0xFF9A6B7B)),
            ),
          ],
        ),
      ),
    );
  }
}

class PerfilScreen extends StatelessWidget {
  const PerfilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const CircleAvatar(
          radius: 45,
          backgroundColor: Color(0xFFF7C9D8),
          child: Icon(Icons.storefront_rounded, size: 45, color: Colors.white),
        ),
        const SizedBox(height: 12),
        const Center(
          child: Text('Loja Charme Acessórios',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        const SizedBox(height: 24),
        _opcaoPerfil(Icons.person_outline, 'Meus dados'),
        _opcaoPerfil(Icons.notifications_outlined, 'Notificações de estoque'),
        _opcaoPerfil(Icons.history, 'Histórico de movimentações'),
        _opcaoPerfil(Icons.settings_outlined, 'Configurações'),
        _opcaoPerfil(Icons.logout, 'Sair'),
      ],
    );
  }

  Widget _opcaoPerfil(IconData icone, String titulo) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: ListTile(
        leading: Icon(icone, color: const Color(0xFFE07A9A)),
        title: Text(titulo),
        trailing: const Icon(Icons.chevron_right, color: Colors.grey),
        onTap: () {},
      ),
    );
  }
}