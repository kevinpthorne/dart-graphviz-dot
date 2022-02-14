abstract class Renderable {
  String render();
}

class Digraph implements Renderable {
  final String name;
  final List<Node> nodes;
  final List<Edge> edges;

  Digraph(this.name, this.nodes, this.edges);

  @override
  String render() => """digraph $name {
${nodes.map((node) => node.render()).join('\n')}
${edges.map((edge) => edge.render()).join('\n')}
}""";
}

class Node implements Renderable {
  final String name;
  final Map<String, String> attributes = {};

  Node(this.name);

  @override
  String render() => "$name;";
}

class Edge implements Renderable {
  final Node from;
  final Node to;

  Edge(this.from, this.to);

  @override
  String render() => '${from.name} -> ${to.name};';
}
