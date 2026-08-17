# Ontology of Socionics

An interactive reference site covering the foundations, dichotomies, small groups, information metabolism elements, models, and intertype relations of Socionics, synthesized across Model A, Gulenko's Model G, the Talanov-Romanov statistical framework, and sociotype.xyz's factor-analytic refinements.

## Structure

The site is a thin React shell (`index.html`) that loads ten self-contained article pages in sequence:

| # | Document | File |
|---|---|---|
| 1 | Foundations & Dichotomies | `OVERVIEW_FINAL.html` |
| 2 | Dichotomies (Traits) | `DICHOTOMIES_FINAL.html` |
| 3 | Temperaments (Rhythms) | `TEMPERAMENT_FINAL.html` |
| 4 | Clubs (Jungian Aspects) | `CLUB_FINAL.html` |
| 5 | Quadra Values (Axes) | `QUADRA_FINAL.html` |
| 6 | Elements (Functions) | `ELEMENTS_FINAL.html` |
| 7 | Models (Slots & Blocks) | `MODELS_FINAL.html` |
| 8 | The Socion (Circumplex) | `CIRCUMPLEX_FINAL.html` |
| 9 | Relations (ITRs) | `ITR_FINAL.html` |
| 10 | Subtypes (DCNH) | `DCNH_FINAL.html` |

Reading order follows a zoom-spiral pedagogy: observable dichotomies → grouping patterns → underlying information-metabolism substrate → formal model architecture → application to intertype dynamics and within-type variation.

## Running locally

The shell uses sandboxed iframes to load sibling articles, which requires a real HTTP origin. Double-clicking `index.html` will not work. From this directory:

```
python3 -m http.server 8000
```

Then visit http://localhost:8000.

## Deployment

Hosted via GitHub Pages. To redeploy after edits, commit and push to `main`; Pages rebuilds automatically within ~1 minute.

A convenience script is provided for first-time deployment:

```
./deploy.sh <github-username> <repo-name>
```

## Dependencies

No build step. The shell loads React 18, Tailwind, and Babel Standalone from CDNs at runtime. Individual articles are self-contained HTML and load their own dependencies as needed.

