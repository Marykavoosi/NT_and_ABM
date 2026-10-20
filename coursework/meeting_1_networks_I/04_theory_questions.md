# Meeting 1 — Theory Questions

## Which network measures change for directed, weighted, and bipartite networks?

Many standard network measures are originally defined for simple undirected and unweighted graphs.  
When direction, edge weights, or bipartite structure are present, the definitions or interpretations of several measures must be modified.

---

## 1. Degree

### Undirected network
The degree of node \(i\) is the number of adjacent nodes:

\[
k_i = \sum_j A_{ij}.
\]

### Directed network
Degree splits into:

\[
k_i^{\mathrm{in}} = \sum_j A_{ji},
\qquad
k_i^{\mathrm{out}} = \sum_j A_{ij}.
\]

- **In-degree**: number of incoming edges.
- **Out-degree**: number of outgoing edges.

The distinction matters whenever edge direction has meaning.

### Weighted network
Degree is still the number of neighbors, but an additional measure is usually introduced: **strength**.

\[
s_i = \sum_j w_{ij}.
\]

For directed weighted networks, one can define in-strength and out-strength.

### Bipartite network
Degree is still well-defined, but nodes belong to two different sets.  
Degree distributions should normally be considered separately for the two node types because their possible neighbors and interpretations differ.

---

## 2. Clustering coefficient and transitivity

### Undirected network
The local clustering coefficient measures how often neighbors of a node are connected to one another:

\[
C_i =
\frac{\text{number of links between neighbors of } i}
{\text{maximum possible number of such links}}.
\]

### Directed network
Direction creates several different triangle patterns, so clustering must specify which directed triangle configurations are counted.

### Weighted network
Weighted clustering coefficients can incorporate edge weights, so a triangle made of strong edges contributes differently from one made of weak edges.

### Bipartite network
The ordinary triangle-based clustering coefficient is not directly applicable because a simple bipartite graph contains no triangles.

Therefore, bipartite-specific clustering measures are needed, often based on four-cycles or overlap in shared neighbors.

---

## 3. Shortest-path distance

### Directed network
A path must follow edge direction.

Therefore,

\[
d(i,j) \neq d(j,i)
\]

in general, and one direction may be unreachable even when the reverse direction exists.

### Weighted network
Shortest paths depend on the interpretation of edge weights.

If a weight represents a cost, distance, or travel time, the path length is usually:

\[
L(P)=\sum_{(i,j)\in P} w_{ij}.
\]

If a large weight instead represents strong similarity or strong interaction, it cannot automatically be treated as a distance; it may need to be transformed first.

### Bipartite network
Shortest paths remain well-defined, but paths alternate between the two node sets.

As a consequence:

- nodes in opposite partitions are connected by paths of odd length;
- nodes in the same partition are connected by paths of even length.

---

## 4. Closeness centrality

For a node \(i\), closeness is based on the distances from \(i\) to other nodes:

\[
C_C(i)
\propto
\frac{1}{\sum_j d(i,j)}.
\]

### Directed network
Because distances depend on direction, one can distinguish:

- outward closeness;
- inward closeness.

Reachability becomes important because some nodes may not be reachable.

### Weighted network
Weighted shortest-path distances must be used.

### Bipartite network
The formula can still be used, but comparisons between the two node types require care because path-length parity and possible neighbors differ.

---

## 5. Betweenness centrality

Betweenness measures how often a node lies on shortest paths between other nodes:

\[
C_B(v)
=
\sum_{s\neq v\neq t}
\frac{\sigma_{st}(v)}
{\sigma_{st}},
\]

where:

- \(\sigma_{st}\) is the number of shortest paths from \(s\) to \(t\);
- \(\sigma_{st}(v)\) is the number of those paths passing through \(v\).

### Directed network
Only direction-respecting shortest paths are counted.

### Weighted network
Weighted shortest paths are used.

### Bipartite network
Betweenness is still meaningful, but the structural role of nodes in the two partitions may differ substantially, so normalization and interpretation should respect the bipartite structure.

---

## 6. Eigenvector centrality

For an undirected network:

\[
x_i =
\frac{1}{\lambda}
\sum_j A_{ij}x_j.
\]

A node is important if it is connected to important nodes.

### Directed network
The adjacency matrix is asymmetric, so incoming and outgoing eigenvector concepts differ.  
The interpretation depends on whether importance is transmitted along incoming or outgoing edges.

### Weighted network
The weighted adjacency matrix can be used instead of a binary adjacency matrix.

### Bipartite network
Direct application is possible, but because edges only connect the two node types, centrality alternates between the two partitions. Bipartite-specific spectral approaches or projections are often more interpretable.

---

## 7. Katz centrality

Katz centrality counts walks of different lengths while down-weighting long walks:

\[
x = \alpha A x + \beta \mathbf{1}.
\]

### Directed network
Direction affects which walks exist.

### Weighted network
The weighted adjacency matrix can be used, so stronger edges contribute more.

### Bipartite network
The measure remains mathematically definable, but walk lengths alternate between the two partitions, which affects interpretation.

---

## 8. PageRank

PageRank was designed for directed networks.

A node receives high PageRank when it receives links from other high-ranking nodes.

### Directed network
Direction is essential to the definition.

### Weighted network
Transition probabilities can be made proportional to edge weights.

### Bipartite network
Standard PageRank can be applied, but the alternating two-mode structure changes the interpretation. Bipartite ranking variants may be preferable when the two node classes play different roles.

---

## 9. HITS

HITS separates two roles:

- **authority score**;
- **hub score**.

A good hub points to good authorities, and a good authority is pointed to by good hubs.

### Directed network
Direction is fundamental.

### Weighted network
Weights can be incorporated into the adjacency matrix.

### Bipartite network
HITS is naturally compatible with bipartite-like structures because the two node sets can often be interpreted as two complementary roles.

---

## 10. Reciprocity

Reciprocity measures the tendency for directed edges to be mutual.

If \(i\to j\) exists, reciprocity asks whether \(j\to i\) also exists.

### Directed network
Reciprocity is meaningful and important.

### Undirected network
It is not informative because every edge is automatically symmetric.

### Weighted network
Weighted reciprocity can compare the strengths of opposite-direction edges.

### Bipartite network
It only applies if the bipartite network is also directed.

---

## 11. Assortativity and homophily

Assortativity measures whether similar nodes preferentially connect.

Examples include similarity by:

- degree;
- cell type;
- age;
- category;
- other attributes.

### Directed network
Degree assortativity can distinguish combinations such as:

- in-degree to in-degree;
- in-degree to out-degree;
- out-degree to in-degree;
- out-degree to out-degree.

### Weighted network
Edges may contribute according to their weights.

### Bipartite network
Standard same-type assortativity must be interpreted carefully because edges only connect unlike node classes. Mixing patterns are often analyzed across attributes of the two different partitions.

---

## 12. Cliques, cores, and groups

### Directed network
Clique definitions may require mutual links or may ignore direction, depending on the question.

### Weighted network
Thresholds or weighted variants can be used to define strongly connected groups.

### Bipartite network
Ordinary cliques larger than two nodes cannot exist in a simple bipartite graph.  
Instead, bicliques and other two-mode group structures are more appropriate.

---

# Summary

| Measure | Directed | Weighted | Bipartite |
|---|---|---|---|
| Degree | Split into in/out degree | Strength added | Compute by partition |
| Clustering | Directed triangle variants | Weighted clustering | Ordinary triangles absent |
| Shortest path | Direction matters | Weighted distance | Paths alternate partitions |
| Closeness | In/out closeness | Weighted paths | Partition-aware interpretation |
| Betweenness | Directed paths | Weighted paths | Partition-aware normalization |
| Eigenvector | Incoming/outgoing variants | Weighted adjacency | Two-mode interpretation |
| Katz | Directed walks | Weighted adjacency | Alternating walks |
| PageRank | Naturally directed | Weighted transitions | Two-mode variants possible |
| HITS | Naturally directed | Weighted version possible | Naturally compatible |
| Reciprocity | Important | Weighted reciprocity possible | Only if directed |
| Assortativity | Several in/out combinations | Weighted assortativity | Two-mode mixing |
| Cliques | Direction-specific definitions | Weighted variants | Use bicliques instead |

## Main takeaway

The three network properties change measures in different ways:

- **Directed networks:** asymmetry matters. Incoming and outgoing connections and paths must be distinguished.
- **Weighted networks:** connection magnitude matters. Binary adjacency is no longer sufficient.
- **Bipartite networks:** the two-mode structure matters. Some ordinary one-mode measures, especially triangle-based ones, are not directly applicable.
