import 'dart:io';

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
${nodes.map((node) => node.render()).join('\n')}
${edges.map((edge) => edge.render()).join('\n')}
}""";

  save(String filepath) {
    File(filepath).writeAsStringSync(render());
  }
}

class Node implements Renderable {
  late final String name;
  final Map<String, String> attributes = {};

  Node(this.name);

  Node.from(object, [String? label]) {
    this.name = object.hashCode.toString();
    this.attributes['label'] = label ?? object.toString();
  }

  @override
  String render() {
    final attributes = this.attributes.entries
        .map((entry) => '${entry.key}="${entry.value}"')
        .join(',');
    return '  $name [$attributes];';
  }
}

class Edge implements Renderable {
  final Node from;
  final Node to;

  Edge(this.from, this.to);

  @override
  String render() => '${from.name} -> ${to.name};';
}
