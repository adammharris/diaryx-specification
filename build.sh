#!/bin/bash

# A script to build and deploy a static site using a custom Rust CLI tool on Vercel.

# --- Configuration ---
# Exit immediately if a command exits with a non-zero status.
set -e

# The name of the Rust CLI tool's executable.
CLI_TOOL="diaryx"

# The Git repository for the CLI tool.
CLI_TOOL_REPO="https://github.com/adammharris/diaryx-cli.git"

# The main input file for the static site generator.
ENTRY_FILE="Diaryx Writing Specification.md"

# The directory where the static site will be built.
# This should match Vercel's "Output Directory" setting.
OUTPUT_DIR="public"


# --- Script ---
echo "🚀 Starting Vercel build process..."

# 1. Install Rust and Cargo if not already present
if ! command -v cargo &> /dev/null
then
    echo "🦀 Rust is not installed. Installing via rustup..."
    # Download and install rustup non-interactively
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    # Add the cargo bin directory to the PATH for the current script execution
    source "$HOME/.cargo/env"
    echo "✅ Rust installed successfully."
else
    echo "🦀 Rust is already installed."
fi

# 2. Install the CLI tool from the Git repository
echo "🔧 Installing '$CLI_TOOL' from '$CLI_TOOL_REPO'..."
# This fetches the repo and installs the binary into ~/.cargo/bin/
cargo install --git "$CLI_TOOL_REPO"

echo "✅ CLI tool '$CLI_TOOL' installed."

# 3. Clean up old build files
if [ -d "$OUTPUT_DIR" ]; then
    echo "🧹 Cleaning up old build directory: '$OUTPUT_DIR'"
    rm -r "$OUTPUT_DIR"
fi

# 4. Run the build command
# Now that the tool is installed, it should be in the PATH.
echo "⚙️ Building static site with '$CLI_TOOL'..."
$CLI_TOOL build --input "$ENTRY_FILE" --output $OUTPUT_DIR

# 5. Final success message
echo "✅ Build complete! Your site is ready in the '$OUTPUT_DIR' directory."
echo "🎉 You can now deploy the contents of '$OUTPUT_DIR'."


