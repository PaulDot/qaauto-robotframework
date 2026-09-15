import subprocess
import sys

CONTAINER_NAME = "the-internet-test-app"
DOCKER_IMAGE = "gprestes/the-internet:v2.6.5"
PORT = "7080"
LIVE_SITE = "https://the-internet.herokuapp.com"

def determine_base_url():
    """
    Checks if Docker is running and manages the container lifecycle.
    Returns the appropriate BASE_URL for the test suite.
    """
    try:
        # Check if Docker daemon is active
        subprocess.run(["docker", "info"], check=True, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
    except (subprocess.CalledProcessError, FileNotFoundError):
        print("\n📡 Docker is closed or missing. Routing traffic to the LIVE site.\n")
        return LIVE_SITE

    # If Docker is running, manage the container
    try:
        print(f"🚀 Ensuring Docker container '{CONTAINER_NAME}' is ready...")
        # Force remove any stale containers
        subprocess.run(["docker", "rm", "-f", CONTAINER_NAME], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
        
        # Spin up the image
        subprocess.run([
            "docker", "run", "-d", 
            "--name", CONTAINER_NAME, 
            "-p", f"{PORT}:5000", 
            DOCKER_IMAGE
        ], check=True, stdout=subprocess.DEVNULL)
        
        print(f"✅ Local container running on http://localhost:{PORT}")
        return f"http://localhost:{PORT}"
        
    except subprocess.CalledProcessError:
        print("⚠️ Failed to spin up Docker container. Falling back to LIVE site.")
        return LIVE_SITE

if __name__ == "__main__":
    # So it can be called/checked from terminal
    print(determine_base_url())

def teardown_docker_container():
    """
    Stops and removes the test container if it is running.
    """
    try:
        # Check if Docker daemon is active before trying to stop
        subprocess.run(["docker", "info"], check=True, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
        
        print(f"\n🛑 Tearing down Docker container '{CONTAINER_NAME}'...")
        subprocess.run(["docker", "rm", "-f", CONTAINER_NAME], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
        print("✅ Container removed successfully.")
    except (subprocess.CalledProcessError, FileNotFoundError):
        # Gracefully skip if Docker isn't running or available
        pass
