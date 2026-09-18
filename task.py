import sys
import os
import subprocess
import manage_app

def run_command(cmd):
    print(f"🏃 Executing: {cmd}", flush=True)
    subprocess.run(cmd, shell=True, check=True)

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
        print("📦 Creating virtual environment...", flush=True)
        run_command(f"{sys.executable} -m venv venv")
        
        print("📥 Installing Python dependencies...", flush=True)
        run_command(f"{pip_bin} install -r requirements.txt")
        
        print("🌐 Initializing Playwright browser engines...", flush=True)
        run_command(f"{rf_bin} init")
        print("\n✅ Test platform setup complete!", flush=True)

    elif action == "test":
        # Check if the local test env exists before running
        if not os.path.exists(robot_bin):
            print("\n❌ Error: Test platform not found.", flush=True)
            print("👉 Please run 'python task.py setup' first to install required dependencies.\n", flush=True)
            sys.exit(1)

        # Look for a custom flag in terminal args, otherwise default to False locally
        headless_flag = "True" if "--headless" in sys.argv else "False"

        # Filter out the action name and the optional --headless flag to catch tags
        extra_args = [arg for arg in sys.argv[2:] if arg != "--headless"] 
        # Check if any argument ends with '.robot' or targets a specific item
        has_custom_target = any(arg.endswith(".robot") or arg.startswith("tests/") for arg in extra_args)
        # If no custom target path is given, fall back to executing the whole 'tests/' directory
        target_path = "" if has_custom_target else "tests/"
        extra_args_str = " ".join(extra_args)

        manage_app.start_docker_environment()

        print("🚀 Launching Robot Framework Test Suite...", flush=True)
        run_command(f"{robot_bin} --variable HEADLESS:{headless_flag} --outputdir results {extra_args_str} {target_path}")

        manage_app.teardown_docker_container()
        
    else:
        print(f"❌ Unknown action: '{action}'. Use 'setup' or 'test'.", flush=True)
        sys.exit(1)
