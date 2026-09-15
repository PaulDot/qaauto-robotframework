# QA Automation Showcase — Robot Framework, Playwright Browser Library, Python

[![Robot Framework Suite](https://github.com/PaulDot/qaauto-robotframework)](https://github.com/PaulDot/qaauto-robotframework)

> 🚧 **Project Status: Active Work-in-Progress**

This framework is built using **Robot Framework** powered by the **Playwright-backed Browser Library**, featuring self-managing local Docker service containers, live web fallback layers, and GitHub Actions that incorporate caching.

---

## 🏗️ Core Architecture & Fallback Pattern
To completely eliminate environment flakiness during test execution, this project uses an intelligent environment check (`manage_app.py`):
1. **Local Execution (Docker Active):** Spins up an isolated [`gprestes/the-internet:v2.6.5`](https://hub.docker.com/r/gprestes/the-internet/) container locally on port `7080` and routes all tests there.
2. **Local Execution (Docker Closed):** Transparently falls back to routing traffic to [the live production site](https://the-internet.herokuapp.com/).
3. **CI/CD Execution (GitHub Actions):** Runs tests against a temporary, dedicated Docker instance hosted directly in the pipeline.

---

## 🚀 Quick Start: Run the Project Locally

### 1. Prerequisites
Ensure you have the following installed on your operating system:
* **Python 3.10+**
* **Node.js** (Required under the hood by Playwright)
* **Docker Desktop** (Optional, for local container isolation)

### 2. Automated Setup & Execution
This project includes a cross-platform Python task runner that completely automates virtual environment management, package installations, and test execution for Windows, macOS, and Linux users alike.

```bash
# Clone and enter the repo
git clone https://github.com/PaulDot/qaauto-robotframework.git
cd qaauto-robotframework

# Run the test platform setup script
python task.py setup

# Execute the test suite
python task.py test
```

To review the interactive dashboard results, open `results/report.html` or `results/log.html` in any web browser.

---

## 🛠️ Roadmap / Current Progression
* [x] **Infrastructure Phase:** Standardized `structure and dependencies.
* [x] **Orchestration Phase:** Dynamic container manager (`manage_app.py`) with automatic fallback option.
* [x] **CI/CD Layer:** Fully optimised GitHub Actions pipeline (`robot.yml`) with caching reducing the network load.
* [x] **Ease of Use Tools:** Add script (`task.py`) to simplify local test platform setup and overall test execution.
* [/] **Test Automation Phase:** ToDo: add tests into a **Page Object Model (POM)** structure within `/pages` and `/tests`.
