# Network Theory and Agent-Based Modelling

Coursework and project repository for the **Network Theory and Agent-Based Modelling** course.

The repository will contain the work for the three course meetings and the final project.

## Course structure

- **Meeting 1 — Networks I**
  - network measures
  - centrality, clustering and assortativity
  - network algorithms
  - comparison of a real network with Erdős–Rényi random graphs

- **Meeting 2 — Networks II**
  - degree distributions
  - random graphs
  - configuration model
  - preferential attachment
  - community detection
  - percolation
  - SIR/SIS dynamics
  - synchronization

- **Meeting 3 — Agent-Based Modelling**
  - agent-based implementation of network dynamics
  - ODD protocol
  - verification and testing
  - sensitivity and uncertainty analysis

## Biological application

The main application will use a **spatial single-cell network** related to persistent *Salmonella* infection.

Each node will represent an individual cell.

Edges will represent spatial neighbourhood relationships between cells.

The aim is to use the same biological dataset throughout the course whenever possible.

## Data source

Candidate dataset:

**NCBI GEO accession: GSE309522**

Spatial transcriptomics data generated using the 10x Genomics Xenium platform.

Raw data files are not stored in this GitHub repository. See [`data/README.md`](data/README.md) for details.

## Environment

Python 3.12

Install dependencies with:

```bash
pip install -r requirements.txt