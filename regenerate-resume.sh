#!/bin/bash
set -e

echo "🔄 Resume Regeneration Script"
echo "================================"
echo ""

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Directories
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
RESUME_DIR="$SCRIPT_DIR/resumes"
PUBLIC_DIR="$SCRIPT_DIR/public"

# Create resumes directory if it doesn't exist
mkdir -p "$RESUME_DIR"

echo -e "${BLUE}📁 Working directory: $SCRIPT_DIR${NC}"
echo ""

# Check if pdflatex is available
if ! command -v pdflatex &> /dev/null; then
    echo -e "${YELLOW}⚠️  pdflatex not found. Installing texlive...${NC}"
    sudo apt-get update && sudo apt-get install -y texlive-latex-base texlive-latex-extra
fi

# Function to compile LaTeX file
compile_latex() {
    local tex_file=$1
    local output_name=$2

    echo -e "${BLUE}📝 Compiling $tex_file...${NC}"

    cd "$RESUME_DIR"

    # Run pdflatex twice for proper references
    pdflatex -interaction=nonstopmode "$tex_file" > /dev/null 2>&1
    pdflatex -interaction=nonstopmode "$tex_file" > /dev/null 2>&1

    # Move the output PDF to the desired name
    local base_name="${tex_file%.tex}"
    if [ -f "${base_name}.pdf" ]; then
        mv "${base_name}.pdf" "$output_name"
        echo -e "${GREEN}✓ Generated: $output_name${NC}"
    else
        echo -e "${YELLOW}⚠️  Failed to generate: $output_name${NC}"
        return 1
    fi

    # Clean up auxiliary files
    rm -f "${base_name}.aux" "${base_name}.log" "${base_name}.out"

    cd "$SCRIPT_DIR"
}

# Compile all resume versions
echo -e "${BLUE}Compiling resume versions...${NC}"
echo ""

if [ -f "$RESUME_DIR/daniel_esponda_resume_3page.tex" ]; then
    compile_latex "daniel_esponda_resume_3page.tex" "Daniel_Esponda_Resume_3page.pdf"
fi

if [ -f "$RESUME_DIR/daniel_esponda_resume_2page.tex" ]; then
    compile_latex "daniel_esponda_resume_2page.tex" "Daniel_Esponda_Resume_2page.pdf"
fi

if [ -f "$RESUME_DIR/daniel_esponda_resume_1page.tex" ]; then
    compile_latex "daniel_esponda_resume_1page.tex" "Daniel_Esponda_Resume_1page.pdf"
fi

echo ""
echo -e "${BLUE}📋 Copying main resume to website...${NC}"

# Generate version timestamp (YYYYMMDDHHMM format)
VERSION=$(date +%Y%m%d%H%M)

# Copy the 3-page version as the main resume with version
if [ -f "$RESUME_DIR/Daniel_Esponda_Resume_3page.pdf" ]; then
    cp "$RESUME_DIR/Daniel_Esponda_Resume_3page.pdf" "$PUBLIC_DIR/Daniel_Esponda_Resume_v${VERSION}.pdf"
    # Also create unversioned copy for direct access
    cp "$RESUME_DIR/Daniel_Esponda_Resume_3page.pdf" "$PUBLIC_DIR/Daniel_Esponda_Resume.pdf"
    echo -e "${GREEN}✓ Copied main resume to public directory (version: v${VERSION})${NC}"

    # Update HTML with versioned link
    if [ -f "$PUBLIC_DIR/index.html" ]; then
        # Find current version in HTML and replace with new version
        sed -i.bak "s/Daniel_Esponda_Resume_v[0-9]*.pdf/Daniel_Esponda_Resume_v${VERSION}.pdf/g" "$PUBLIC_DIR/index.html"
        sed -i.bak "s/Daniel_Esponda_Resume\.pdf\" download/Daniel_Esponda_Resume_v${VERSION}.pdf\" download/g" "$PUBLIC_DIR/index.html"
        rm -f "$PUBLIC_DIR/index.html.bak"
        echo -e "${GREEN}✓ Updated HTML with versioned link: v${VERSION}${NC}"
    fi
else
    echo -e "${YELLOW}⚠️  3-page resume not found${NC}"
fi

echo ""
echo -e "${GREEN}✅ Resume regeneration complete!${NC}"
echo ""
echo "Generated files:"
ls -lh "$RESUME_DIR"/*.pdf 2>/dev/null | awk '{print "  - " $9 " (" $5 ")"}'
echo ""
echo "Next steps:"
echo "  1. Review the generated PDFs in: $RESUME_DIR"
echo "  2. Commit and push changes: git add . && git commit -m 'Update resume' && git push"
echo ""
