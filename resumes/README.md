# Resume Source Files

This directory contains the LaTeX source files for Daniel Esponda's professional resume in multiple formats.

## Files

- **daniel_esponda_resume_3page.tex** - Full detailed resume (3 pages)
- **daniel_esponda_resume_2page.tex** - Concise version (2 pages)
- **daniel_esponda_resume_1page.tex** - Executive summary (1 page)

## Quick Update & Regeneration

To update your resume and regenerate all PDFs:

1. **Edit the LaTeX files** in this directory with your changes
2. **Run the regeneration script:**
   ```bash
   cd /home/desponda/resume-website
   ./regenerate-resume.sh
   ```
3. **Review the generated PDFs** in this directory
4. **Commit and deploy:**
   ```bash
   git add .
   git commit -m "Update resume: [describe your changes]"
   git push
   ```

The script will:
- ✅ Compile all 3 versions to PDF
- ✅ Copy the 3-page version as the main website resume
- ✅ Clean up auxiliary LaTeX files
- ✅ Show you the generated files

## Making Updates

### Adding New Achievements

Edit the relevant `.tex` file and add items to the appropriate job section:

```latex
\begin{itemize}[leftmargin=*, itemsep=1pt, topsep=2pt]
    \item Your new achievement here
    \item Quantify impact (e.g., "Reduced costs by 40%")
\end{itemize}
```

### Updating Job Dates

Find the job subsection and update the date range:

```latex
\subsection*{Company --- Title}
\textit{Location} \hfill \textit{Start Date - End Date}
```

### Adding New Roles

Copy an existing job block and modify:

```latex
\subsection*{New Company --- New Title}
\textit{Location} \hfill \textit{Month YYYY - Month YYYY}

\begin{itemize}[leftmargin=*, itemsep=1pt, topsep=2pt]
    \item Achievement 1
    \item Achievement 2
\end{itemize}
```

### Updating Skills

Find the `TECHNICAL SKILLS` section and update the relevant category:

```latex
\textbf{Category:} Skill1, Skill2, Skill3, NewSkill
```

## Tips for ATS Optimization

✅ **DO:**
- Use standard section headings (PROFESSIONAL EXPERIENCE, EDUCATION, etc.)
- Include job titles, company names, and dates
- Use quantifiable metrics and specific technologies
- Keep formatting simple (no tables, text boxes, or complex layouts)

❌ **DON'T:**
- Use headers/footers for important information
- Include graphics or images
- Use columns for job descriptions
- Abbreviate without spelling out first (use "Site Reliability Engineer (SRE)")

## Deployment

After regenerating, the main resume is automatically:
1. Copied to `public/Daniel_Esponda_Resume.pdf`
2. Available for download on the website at dresponda.com
3. Deployed via ArgoCD when you push to GitHub

## Current Resume Structure

**Datadog Experience (Split for Background Checks):**
- **Staff Site Reliability Engineer, CI Infrastructure** (June 2025 - Present)
  - Technical strategy and leadership
  - Incident command
  - Roadmap and architecture

- **Senior Software Engineer, CI Infrastructure** (August 2022 - June 2025)
  - Platform building and cost optimization
  - Technical implementations
  - Infrastructure improvements

This split reflects the promotion date and is accurate for background verification purposes.

## Need Help?

If you encounter LaTeX compilation errors:
- Check for special characters that need escaping: `$`, `%`, `&`, `#`, `_`, `{`, `}`
- Use `\$` for dollar signs, `\%` for percentages
- Use `$<$` and `$>$` for less than/greater than symbols
- Ensure all `\begin{}` tags have matching `\end{}` tags

For more complex updates, you can always edit the files manually and run the regeneration script to see if it compiles successfully.
