# Resume Repository

## Folder Structure

```
Resume/
├── context.md                        # This file — project documentation
├── .gitignore                        # Excludes LaTeX build artifacts
├── templates/
│   └── resume-template.tex           # Reusable LaTeX template with placeholders
└── resumes/
    ├── v1/
    │   ├── v1.tex                    # Full multi-page resume
    │   └── v1.pdf                    # Compiled output
    ├── v2_single_page/
    │   ├── v2_single_page.tex        # Condensed single-page resume
    │   └── v2_single_page.pdf        # Compiled output
    ├── v3_rithika/
    │   ├── v3_rithika.tex            # Rithika's single-page resume
    │   └── v3_rithika.pdf            # Compiled output
    └── v4/
        ├── v4.tex                    # Latest multi-page resume (merged AidenAI roles)
        └── v4.pdf                    # Compiled output
```

## Resume Versions

- **v1** — Full multi-page resume with detailed descriptions for education, experience, projects, and certifications. Uses standard margins.
- **v2_single_page** — Condensed single-page version with tighter margins, shorter bullet points, and compact certifications section. Suited for applications with strict page limits.
- **v3_rithika** — Single-page resume for Choudarypalli Rithika (B.Tech CSE Data Science, KMIT). Uses single-page layout settings.
- **v4** — Latest multi-page resume for Sreekar. Merges AidenAI intern (probation) and full-time into a single "Product Engineer" entry. Refined experience bullets and condensed Procareer Academy. Compatible with both pdflatex and tectonic.

## How to Create a New Version

1. Copy the template: `cp templates/resume-template.tex resumes/v<N>/v<N>.tex`
   (or `resumes/v<N>_<descriptor>/v<N>_<descriptor>.tex` for a named variant)
2. Fill in your content, replacing the placeholder text.
3. Adjust spacing for single-page or multi-page layout (see comments in the template).
4. Compile to PDF (see below).

## How to Compile

### Recommended: Tectonic (used for local builds)

Tectonic is a single self-contained engine that downloads TeX packages on demand —
no full TeX Live/MiKTeX install needed. From the repo root:

```powershell
.\build.ps1 v2_single_page
```

`build.ps1` finds `tectonic` on PATH, or falls back to `%USERPROFILE%\Tools\Tectonic\tectonic.exe`.
You can also call the engine directly:

```powershell
tectonic --keep-logs resumes/v2_single_page/v2_single_page.tex
```

Tectonic runs the **XeTeX** engine, so the `.tex` files are written to be engine-agnostic:
- pdfTeX-only commands (`\input{glyphtounicode}`, `\pdfgentounicode=1`) are wrapped in
  `\ifdefined\pdfgentounicode ... \fi` so they only run under pdfTeX (ATS glyph mapping)
  and are skipped under XeTeX.
- Use `$\cdot$` for the middle-dot separator, not a literal `·` byte (which mis-renders
  under XeTeX).

### Alternative: pdflatex (TeX Live / MiKTeX)

```bash
cd resumes/v1
pdflatex v1.tex
```

Run twice if you see unresolved references. Build artifacts (`.aux`, `.log`, etc.) are gitignored and safe to delete.

## Naming Conventions

- Folders: `v<N>` for numbered versions, or `v<N>_<descriptor>` for named variants (e.g., `v2_single_page`).
- The `.tex` file inside each folder matches the folder name (e.g., `v2_single_page/v2_single_page.tex`).

## Template Details

- **Origin**: Based on [sb2nov/resume](https://github.com/sb2nov/resume) (MIT license).
- **Style**: Blue accent color (`blue(pigment)` — rgb 0.2, 0.2, 0.6), `\scshape` section headers with a colored rule, ATS-parsable via `\pdfgentounicode`.
- **Key custom commands**: `\resumeItem`, `\resumeSubheading`, `\resumeProjectHeading`, `\resumeSubItem`, `\resumeSubHeadingListStart/End`, `\resumeItemListStart/End`.
- **Single-page tweaks** (documented as comments in the template):
  - Tighter margins (`-0.6in` instead of `-0.5in`)
  - Section title vspace: `-8pt` instead of `-4pt`
  - `\resumeItem` without the extra `\vspace{-2pt}`
  - `\resumeItemListStart` with `[itemsep=0pt, parsep=0pt]`
