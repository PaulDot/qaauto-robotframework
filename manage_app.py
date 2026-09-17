import subprocess
import sys

CONTAINER_NAME = "the-internet-test-app"
DOCKER_IMAGE = "gprestes/the-internet:v2.6.5"
PORT = "7080"
LIVE_SITE = "https://the-internet.herokuapp.com"

def check_docker_availability():
    try:
        subprocess.run("docker info", shell=True, check=True, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
        return True
    except (subprocess.CalledProcessError, FileNotFoundError):
        return False

def determine_base_url():
    """
    Returns the appropriate BASE_URL for the test suite.
    """
    if check_docker_availability():
        return f"http://localhost:{PORT}"
    return LIVE_SITE

def start_docker_environment():
    """Explicitly handles the setup lifecycle operations."""
    if not check_docker_availability():
        print("\n📡 Docker is closed or missing. Routing traffic to the LIVE site.\n")
        return

    try:
        print(f"🚀 Ensuring Docker container '{CONTAINER_NAME}' is ready...")
        subprocess.run(["docker", "rm", "-f", CONTAINER_NAME], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
        
        subprocess.run([
            "docker", "run", "-d", 
            "--name", CONTAINER_NAME, 
            "-p", f"{PORT}:5000", 
            DOCKER_IMAGE
        ], check=True, stdout=subprocess.DEVNULL)
        
        print(f"✅ Local container running on http://localhost:{PORT}")
        
    except subprocess.CalledProcessError:
        print("⚠️ Failed to spin up Docker container. Falling back to LIVE site.")

def teardown_docker_container():
    """
    Stops and removes the test container if it is running.
    """
    # Check if Docker daemon is active before trying to stop
    if not check_docker_availability():
        return
    try:
        print(f"\n🛑 Tearing down Docker container '{CONTAINER_NAME}'...")
        subprocess.run(["docker", "rm", "-f", CONTAINER_NAME], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
        print("✅ Container removed successfully.")
    except (subprocess.CalledProcessError, FileNotFoundError):
        # Gracefully skip if Docker isn't running or available
        pass
