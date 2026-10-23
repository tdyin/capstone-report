# Evidence and reproducibility

The manuscript reports existing engineering evidence, not new experiments.
Paths below are relative to the CHRIS monorepo root. Original logs remain in
ignored engineering folders; `figures/` retains the plotted and comparison CSVs.

| Claim | Source | Scope |
| --- | --- | --- |
| Equation 1 | `CHRIS-server/src/chris/core/climb_runner.py` and `core/climb_config.py` | D176: commanded cap 0.75 x 0.02 m; grace retains last above-threshold speed. Equation applies to an eligible update with a valid target and observation history. |
| HTTP completion and latency | Integration `20261022-130521`, recorded in `agents/claude/.conductor/projects/chris/context.md` | Server `c4cff11c`, monorepo `9c5d51c4`: practice 3/3 plus attached session 6/6. Historical config: 0.15 m/s, uncoupled. Software evidence only. |
| Intent sweep | `CHRIS-server/agent/logs/intent-sweep-2026-10-22.md` and `.csv`; D161 `828cbdfd` | 400 reaches/setting; 100 pass-through reaches. Same data used for tuning and evaluation. |
| Initial coupling and hover | `CHRIS-server/agent/logs/intent-coupling-2026-10-22.md` and `.csv`; D165 `d497c38d` | 400 reaches/condition/setting; 75 hovers/condition. 110.5/123.7 mm are AFTER-grace travel over P, not full-hover totals. Coupled nearest still moves 21.7 mm during grace. |
| Speed comparison | `CHRIS-server/agent/logs/d176-speed-2026-10-22.md`; `da44918d`, wrong-depth metric `76467f90` | 120 reaches/condition/setting. Baseline extra motion 30%/72%, not 32%/77% from the separate larger experiment. `figures/coupling.csv` records this matched comparison. |
| Earlier pilot | `CHRIS-server/agent/logs/climb-s1-20261022-190006.jsonl` | Stopped at discomfort 4. Kept as development history, not pooled with the later sessions. |
| Headset session 1 | `CHRIS-server/agent/logs/climb-s1-20261022-193929.jsonl`, `climb-s1-20261022-210306.jsonl`, `climb-s1-20261022-213905.jsonl`; saved `climb-s1-20261022-193929-combined.measures.json` | 18 measured attempts, 15 completions (M 3, N 6, I 6), three attempts with incomplete data. Interrupted and resumed with software/input changes. |
| Headset session 2 | `CHRIS-server/agent/logs/climb-s2-20261022-222257.jsonl` and `.measures.json` | 18/18 measured completions, six per condition, plus three practice trials. One developer; no data loss, causal-motion violations, or no-signal pauses. |
| Manual depth demand | `CHRIS-server/agent/scripts/manual_depth_analysis.py` at `a932cd7f`, applied to session 2 | 8/24 completed cued manual reaches had no depth input; 9/24 began inside the nominal zero-lateral-distance overlap band. These are distinct measures. |
| Fixes and subjective feedback | `knowledge/CHRIS Development History/rice.elec594.chris - History - October 22 First Climbing Sessions.md` (relative to report repo); raw rating records | Tester reported no stereo artifacts after fixes and no clear felt nearest/intent difference. This does not isolate the cause of earlier discomfort or establish interruption recovery reliability. |

## Updated headset evidence (October 22)

Replayed all four raw logs through `chris.service.climb_metrics.analyse` at
monorepo revision `a932cd7f`. After JSON normalization, both reconstructed
analyses exactly match the saved measures files. The compact numeric extract
is `figures/headset-sessions.csv`; it preserves separate sessions and units.
No new experiment was run for this report update.

Figure 3 reads session-2 summaries from this extract and all 18 completed
measured trial times from `figures/headset-session2-trials.csv`. It shows all
three conditions: individual times as hollow circles and medians as bars,
two raw block effort ratings, and total wrong-target assistance-state
episodes. Vertical offsets separate observations and carry no measured value.
Manual is marked N/A for assistance episodes. Session 2 was
chosen as the complete session with six measured trials per condition;
session-1 results and its interruptions remain reported in the text. The
simulation figure source and CSV are retained but are not included in the PDF.

- All 33 completed measured trials share configuration digest
  `f7a31d75472eaad78901b9e7157d6daba2f3b086ec5751ac6a78814543625d82`
  (gain 1.5, assisted cap 0.6 m/s, manual cap 0.15 m/s).
  Session 1's mixed-configuration warning includes the incomplete `s1b1M1`
  attempt under `a3f5fc7e6508`; it does not mean a completed baseline trial
  used that earlier configuration. The knowledge note's contrary sentence
  is superseded for the manuscript by the raw logs; the historical note is
  left unchanged.
- The three incomplete measured attempts are `s1b1M1` (fault), the first
  `s1b3I2` (no ready/end; later rerun successfully), and `s1b6M5` (stopped).
  `s1b6M6` was not started. Practice and incomplete attempts are excluded
  from performance summaries but their failures are disclosed.
- Session orders are M-N-I-I-N-M and N-I-M-M-I-N, with three trials/block
  and four cued holds/trial. A changed from Space to left mouse button during
  session 1; client/runner changes and breaks are not encoded by the shared
  controller configuration digest. Sessions are not pooled for comparison.
- Trial times and wrong-hold depth travel are medians over completed trials.
  Wrong-target assistance episode counts are totals over six completed trials
  per assisted condition in each session. Worst wrong-hold travel is the
  maximum for a single reach, not the maximum trial total.
- Session 2 time medians/ranges in M/N/I order: 11.242 (8.502--19.084),
  9.8405 (8.931--13.610), 11.430 (9.404--15.264) seconds. False-assist
  totals N/I: 9/2. Wrong-depth trial medians: 39.6/0 mm; reach maxima:
  185.8/93.3 mm. A zero median does not mean no wrong assistance.
- Manual block depth-effort ratings were 7; assisted ratings were 1--2;
  block discomfort was 1 in both later sessions. These are one developer's
  repeated ordinal ratings, not independent participant outcomes or evidence
  of preserved agency. One session-2 intent block had lower choice/intention
  ratings (5/5); subjective feedback did not distinguish the conditions.
- The read-only manual-depth script was rerun on the session-2 raw log.
  Its no-input definition requires zero E/Q input frames, zero panel input,
  and less than 5 mm of depth movement during the reach. All eight qualifying
  reaches had zero logged movement. Retained depth and sphere-overlap grabs
  make some reaches possible without adjustment. This observation does not
  identify a causal percentage of the manual speedup; practice/order remain
  confounds, and proposed geometry changes are not reported as implemented.
- The simulation plot's coverage is a within-reach time fraction toward the
  cue. The historical session report's `coverage_applied` is the fraction of
  scored intervals overlapping any assist-state episode. Its suffix separates
  assisted conditions from manual shadow inference; it does not establish
  that depth motion was sent or applied. Median trial engagement coverage in
  session 2 is 100% for nearest and 75% for intent. The manuscript does not
  equate these unlike simulation and headset measures.

## Review revision (October 23)

This revision uses the existing data and metric implementation at monorepo
revision `a932cd7f`, not subsequent changes to geometry or scoring. No new
experiments were run. The additional CSV contains six completed, non-practice,
data-loss-free trials per condition; its time and coverage values come from
the saved session-2 measures. The paper narrows its contribution to coordination
tradeoffs within a fixed lateral/depth split and reports effort as the sole
developer's ordinal ratings rather than a demonstrated population benefit.

Metric details checked against the historical implementation:

- Trial time runs from logged ready to finish. An episode begins at assist-state
  entry and ends when the state or target changes. Each overlap with a scored
  reach/cue interval is assessed against that interval's cue. One episode can
  therefore contribute to more than one scored interval; counts are not unique
  erroneous reaches or wrong grabs. Failed presses and cue changes can produce
  more scored intervals than the 24 completed cued reaches per condition.
- `climb_runner._hint` logs decision state independently of motion-coupling
  waits. An assist state can persist without delivered depth motion. Both
  episode counts and engagement coverage use this state, whereas wrong-hold
  travel uses applied depth changes. Lower episode totals with lower engagement
  do not independently establish better intent inference.
- The effort item is “Getting the depth right took effort,” with anchors
  1 = none and 7 = a lot. Figure 3 shows both block ratings per condition.
- Assistance aims at near-surface contact, while actual experimental grabs
  accepted sphere overlap over a broader depth interval. Retained depth can
  permit a later grab without adjustment; proposed later geometry changes
  cannot be used to reinterpret these trials.
- The speed simulation stops lateral motion within 3 mm of the target and
  adds motion after a roughly 0.3-second depth stall (28 frames at 90 Hz).
  The headset extra-motion metric requires a completed cued reach with a
  logged coupling hold of at least 0.3 seconds followed by resumed assistance.
  The 53% simulated intent rate and 1/24 headset result have different movement
  policies and scoring definitions; their discrepancy does not identify a
  single causal mechanism or validate prediction of human behavior.

## Simulation details

The three-page manuscript summarizes configurations and sample sizes in Table I;
the speed grid, layout, repetitions, and seed rules are retained here. Methods
defines both extra-motion measures; Discussion interprets their differing rates.

Generator: `CHRIS-server/agent/scripts/intent_sweep.py`. Five speeds:
0.10, 0.15, 0.20, 0.27, 0.35 m/s. Layouts: `branch`, `branch_m`.
Cues: `s2`, then `L1`; the latter crosses P in `branch`.
The sweep and initial coupling use 20 repetitions per speed/layout, hence
200 trials and 400 scored reaches per cell. The speed comparison uses six
repetitions, hence 60 trials and 120 reaches per cell.

The seed rule is `100003 * seed0 + int(speed * 1000) * 101 + 7 * rep +
(layout == "branch_m")`, default `seed0=1`, zero-based `rep`; conditions
share seeds. Reproduction flags are `--reps 20`, `--coupling --reps 20`,
and `--d176 --reps 6`, respectively. Use historical revisions: current
defaults have changed.

- Coverage: mean within-reach fraction assisted toward the cue.
- P duration/episodes: mean over pass-through reaches only.
- Sweep assistance uses assistance-state intervals; coupling/speed comparisons
  use sent depth signals, excluding decisions held by coupling.
- Sweep `ttc`: reach start to first correct assistance, median among reaches
  receiving correct assistance. It is not correction time from a wrong assist
  and is not a Kaplan-Meier estimate.
- Extra motion: depth unfinished 0.3 seconds after lateral arrival, requiring
  the scripted climber to move laterally again.
- Wrong-hold depth: service-applied travel toward a non-cued hold, from frame
  traces, averaged over all scored reaches.
- No confidence intervals or independent validation are claimed. Frames and
  reaches within trials are not independent participant observations.

## Literature checks

`references.bib` remains the single bibliography. This revision added no
references and spot-checked the following claims, not every full paper:

| Key | Primary source and status | Supported claim |
| --- | --- | --- |
| `grossman2005bubble` | https://www.tovigrossman.com/BubbleCursor/ ; peer-reviewed CHI 2005, DOI 10.1145/1054972.1055012 | Dynamic activation area, not cursor snapping. |
| `dragan2013policy` | https://publications.ri.cmu.edu/a-policy-blending-formalism-for-shared-control ; peer-reviewed IJRR 2013, DOI 10.1177/0278364913490324 | Prediction and arbitration; not CHRIS's thresholds. |
| `openbrush-api` | https://docs.openbrush.app/user-guide/open-brush-api ; software documentation | Application/API identification, not proof of the internal audit. The audit claim was removed. |

The unrelated API latency probe was omitted because its setup was not provided
in the paper. Acknowledgements name the co-authors using the contributions
supplied by Tongda Yin.
