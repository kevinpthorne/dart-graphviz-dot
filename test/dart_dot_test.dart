import 'package:dart_dot/dart_dot.dart';
import 'package:test/test.dart';

void main() {
  group('Rendering', () {
    final emptyGraph = Digraph(
      'test',
      [],
      [],
    );

    final Node nodeA = Node('A');
    final Node nodeB = Node('B');
    final Edge edgeAB = Edge(nodeA, nodeB);

    final simpleGraph = Digraph('test2', [
      nodeA,
      nodeB
    ], [
      edgeAB,
    ]);

    setUp(() {
      // Additional setup goes here.
    });

    test('Empty Render', () {
      var result = emptyGraph.render();
      expect(result, equals('digraph test {\nordering = out;\n\n\n}'));
    });

    test('Simple Render', () {
      var result = simpleGraph.render();
      expect(result, equals('digraph test2 {\nordering = out;\n  A [];\n  B [];\nA -> B;\n}'));
    });
  });
}
