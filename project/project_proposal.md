# Project Proposal — Spatial Cell Networks and Spreading Dynamics

## Working title

**Spreading dynamics on a spatial cell-neighborhood network derived from Xenium tissue data**

## Motivation

Spatial transcriptomics provides the positions of individual cells inside tissue.  
This makes it possible to represent tissue as a network in which:

- each node represents one cell;
- an edge represents spatial proximity between two cells.

The same network can then be used to study how local tissue geometry influences dynamical processes such as spreading, activation, or state change.

## Dataset

**GEO accession:** `GSE309522`

**Selected sample:** `WT4 / GSM9268674`

The current real-network representation contains:

- 10,000 spatially local cells;
- edges between cells whose centroid distance is at most 15 spatial units.

The same fixed real network will be used throughout the course.

## Research question

**How does spatial organization of a real cell-neighborhood network influence spreading dynamics compared with random networks having similar size and mean degree?**

## Network representation

Let

\[
G=(V,E),
\]

where:

- \(V\) is the set of individual cells;
- \((i,j)\in E\) when the Euclidean distance between cell centroids \(i\) and \(j\) is at most the selected spatial radius.

The current master network contains approximately:

\[
|V|=10{,}000
\]

cells, with mean degree approximately:

\[
\langle k\rangle \approx 10.12.
\]

## Planned comparisons

The real spatial network can be compared with synthetic network models such as:

1. **Erdős–Rényi random graph**
   - same number of nodes;
   - similar or identical mean degree.

2. **Configuration model**
   - preserves the empirical degree distribution approximately.

3. **Preferential-attachment network**
   - provides a contrasting heterogeneous topology.

These synthetic networks are comparison models only; the biological dataset remains fixed.

## Dynamical process

A simple SIR-like process can initially be used as a generic spreading model:

\[
S \rightarrow I \rightarrow R.
\]

At this stage, the process should be interpreted as a **generic cell-state spreading process on a spatial contact/proximity network**.

It should not automatically be interpreted as literal cell-to-cell *Salmonella* transmission, because spatial proximity alone does not establish a biological transmission mechanism.

## Analytical and computational questions

The project can investigate:

- degree distribution;
- clustering;
- shortest-path structure;
- giant-component structure;
- robustness/percolation;
- epidemic or spreading thresholds;
- outbreak/final-size distributions;
- sensitivity to model parameters;
- differences between real spatial and random/synthetic networks.

## Planned progression through the course

### Meeting 1 — Network structure

Characterize the real spatial cell network and compare it with an Erdős–Rényi baseline.

### Meeting 2 — Network models and spreading

Construct comparison networks such as configuration-model and preferential-attachment networks.

Simulate SIR-like dynamics and compare:

- outbreak probability;
- final outbreak size;
- threshold behavior;
- topology dependence.

### Meeting 3 — Agent-based model

Reimplement the spreading process as an agent-based model in which each cell is an individual agent.

Prepare:

- ODD description;
- verification against the simpler network simulation;
- global sensitivity analysis using Morris or Sobol methods.

## Expected contribution

The project tests a central network-science idea:

> Two networks with the same number of nodes and similar mean degree can produce very different dynamical behavior because their topology is different.

The real spatial cell network is expected to differ strongly from an Erdős–Rényi graph because spatial embedding produces:

- high local clustering;
- geometric constraints;
- longer paths;
- local fragmentation.

These structural differences may strongly affect spreading dynamics.

## Current preliminary observation

The Meeting 1 analysis already shows that the real spatial network differs substantially from a matched Erdős–Rényi network despite having the same number of nodes and edges.

This provides a clear motivation for testing whether these structural differences also produce different spreading dynamics.

## Question for instructor

Is this scope appropriate for the final course project, especially the use of a generic SIR-like process on a real spatial cell-neighborhood network, with Erdős–Rényi, configuration-model, and preferential-attachment networks as comparison models?
