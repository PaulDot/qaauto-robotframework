import sys
import os
import subprocess
import manage_app

def run_command(cmd):
    print(f"🏃 Executing: {cmd}", flush=True)
    subprocess.run(cmd, shell=True, check=True)

def handle_setup (pip_bin, rf_bin):
    """Executes environment preparation"""
    print("📦 Creating virtual environment...", flush=True)
    run_command(f"{sys.executable} -m venv venv")
    
    print("📥 Installing Python dependencies...", flush=True)
    run_command(f"{pip_bin} install -r requirements.txt")
    
    print("🌐 Initializing Playwright browser engines...", flush=True)
    run_command(f"{rf_bin} init")
    print("\n✅ Test platform setup complete!", flush=True)

def handle_test(robot_bin):
    """Parses execution parameters and manages the target test suite run lifecycle."""
    if not os.path.exists(robot_bin):
        print("\n❌ Error: Test platform not found.", flush=True)
        print("👉 Please run 'python task.py setup' first to install required dependencies.\n", flush=True)
        sys.exit(1)

    # If --headless in passed in args return true
    headless_flag = "True" if "--headless" in sys.argv else "False"

    # Gather and sort all trailing arguments after the action word
    raw_args = [arg for arg in sys.argv[2:] if arg != "--headless"]        
    paths = [arg for arg in raw_args if arg.endswith(".robot") or "tests/" in arg]
    flags = [arg for arg in raw_args if arg not in paths]        
    
    if not paths:
        paths.append("tests/")
        
    flags_str = " ".join(flags)
    paths_str = " ".join(paths)

    manage_app.start_docker_environment()

    print("🚀 Launching Robot Framework Test Suite...", flush=True)
    run_command(f"{robot_bin} --variable HEADLESS:{headless_flag} --outputdir results {flags_str} {paths_str}")

    manage_app.teardown_docker_container()

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("❌ Usage: python task.py [setup|test]", flush=True)
        sys.exit(1)

    action = sys.argv[1]
    
    # Identify execution paths based on Operating System
    is_windows = os.name == 'nt'
    pip_bin = "venv\\Scripts\\pip" if is_windows else "./venv/bin/pip"
    rf_bin = "venv\\Scripts\\rfbrowser" if is_windows else "./venv/bin/rfbrowser"
    robot_bin = "venv\\Scripts\\robot" if is_windows else "./venv/bin/robot"

    if action == "setup":
        handle_setup(pip_bin, rf_bin)
    elif action == "test":
        handle_test(robot_bin)        
    else:
        print(f"❌ Unknown action: '{action}'. Use 'setup' or 'test'.", flush=True)
        sys.exit(1)
