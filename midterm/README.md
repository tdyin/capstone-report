# Midterm Report

ELEC 594 midterm report for CHRIS: *Simultaneous AI-Assisted Shared Control for
Alternative XR Input: A Climbing Testbed*. It is a three-page IEEE conference
paper (`IEEEtran`) describing a virtual climbing testbed in which the user
controls lateral movement and grabbing while heuristic AI assistance adjusts
depth.

## Layout

- `main.tex` – root document (title, authors, section includes)
- `sections/` – paper body, one file per section
- `figures/` – TikZ/pgfplots figures and the CSV data they plot
- `references.bib` – bibliography
- `evidence.md` – sources and scope behind each reported claim
- `main.pdf` – compiled output

## Build

From the repository root, run `make midterm` (requires
[Tectonic](https://tectonic-typesetting.github.io/)).
