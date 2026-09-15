import sys
import os
import subprocess

def run_command(cmd):
    print(f"🏃 Executing: {cmd}")
    subprocess.run(cmd, shell=True, check=True)

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("❌ Usage: python task.py [setup|test]")
        sys.exit(1)

    action = sys.argv[1]
    
    # Identify execution paths based on Operating System
    is_windows = os.name == 'nt'
    pip_bin = "venv\\Scripts\\pip" if is_windows else "./venv/bin/pip"
    rf_bin = "venv\\Scripts\\rfbrowser" if is_windows else "./venv/bin/rfbrowser"
    robot_bin = "venv\\Scripts\\robot" if is_windows else "./venv/bin/robot"

    if action == "setup":
        print("📦 Creating virtual environment...")
        run_command(f"{sys.executable} -m venv venv")
        
        print("📥 Installing Python dependencies...")
        run_command(f"{pip_bin} install -r requirements.txt")
        
        print("🌐 Initializing Playwright browser engines...")
        run_command(f"{rf_bin} init")
        print("\n✅ Test platform setup complete!")

    elif action == "test":
        print("🚀 Launching Robot Framework Test Suite...")
        run_command(f"{robot_bin} --outputdir results environment.robot")
        
    else:
        print(f"❌ Unknown action: '{action}'. Use 'setup' or 'test'.")
        sys.exit(1)
