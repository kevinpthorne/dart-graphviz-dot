import 'dart:io';
import 'dart:math';

abstract class Renderable {
  String render();
}

class Digraph implements Renderable {
  final String name;
  late final List<Node> nodes;
  late final List<Edge> edges;

  Digraph(this.name, this.nodes, this.edges);

  Digraph.empty(this.name) {
    this.nodes = [];
    this.edges = [];
  }

  @override
  String render() => """digraph $name {
ordering = out;
${nodes.map((node) => node.render()).join('\n')}
${edges.map((edge) => edge.render()).join('\n')}
}""";

  save(String filepath) {
    File(filepath).writeAsStringSync(render());
  }
}

class Node implements Renderable {
  static final Random _rnd = Random();

  late final String name;
  final Map<String, String> attributes = {};

  Node(this.name);

  Node.from(object, [String? label]) {
    name = _rnd.nextInt(1500000).toString();
    attributes['label'] = label ?? object.toString();
  }

  on(Digraph graph) {
    graph.nodes.add(this);
    return this;
  }

  String _escape(String attr) =>
      attr.replaceAll(r"\", r"\\").replaceAll('"', r'\"');

  @override
  String render() {
    final attributes = this
        .attributes
        .entries
        .map((entry) => '${entry.key}="${_escape(entry.value)}"')
        .join(',');
    return '  $name [$attributes];';
  }
}

class Edge implements Renderable {
  final Node from;
  final Node to;

  Edge(this.from, this.to);

  on(Digraph graph) {
    if (!graph.nodes.contains(from)) {
      from.on(graph);
    }
    if (!graph.nodes.contains(to)) {
      to.on(graph);
    }
    graph.edges.add(this);
    return this;
  }

  @override
  String render() => '${from.name} -> ${to.name};';
}
