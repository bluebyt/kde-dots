#!/usr/bin/env python3
import subprocess
import time
import sys

# Path to Ironbar
IRONBAR_PATH = "/home/bluebyt/.local/bin/ironbar" #

# Global variable to track the previously highlighted workspace
last_active_num = None

def run_ironbar(action, num):
    """
    Communicates with Ironbar styling using the mapped CLI subcommands.
    action must be 'add' or 'remove'
    """
    # Use dash format matching your local Ironbar binary's CLI expectations
    cmd = [
        IRONBAR_PATH, "style", f"{action}-class",
        f"work{num}", "active"
    ]
    res = subprocess.run(cmd, capture_output=True, text=True)
    return res.returncode

def force_initial_active(num):
    """Forces the initial active class until Ironbar UI stabilizes"""
    success = False
    attempts = 0
    fail_count = 0

    #
    while not success and fail_count < 15:
        returncode = run_ironbar("add", num)

        if returncode == 0:
            attempts += 1
            if attempts == 5:
                success = True
        else:
            fail_count += 1
            time.sleep(0.5)

def update_ironbar(active_num):
    global last_active_num

    # 1. First run: clear all workspace classes to be safe
    if last_active_num is None:
        for i in range(1, 10):
            run_ironbar("remove", i)

    # 2. Remove 'active' class from the previous workspace only
    elif last_active_num != active_num:
        run_ironbar("remove", last_active_num)

    # 3. Add 'active' class to the new current workspace
    run_ironbar("add", active_num)

    # Update tracker
    last_active_num = active_num

def get_kde_desktop():
    """Gets the current virtual desktop number using qdbus6"""
    try:
        res = subprocess.run(
            ["qdbus6", "org.kde.KWin", "/KWin", "currentDesktop"],
            capture_output=True,
            text=True
        )
        if res.returncode == 0:
            return int(res.stdout.strip())
    except (ValueError, IndexError, subprocess.SubprocessError):
        pass
    return None

def main():
    global last_active_num

    # Get initial workspace and apply it immediately
    initial_num = get_kde_desktop()
    if initial_num is not None:
        force_initial_active(initial_num)
        last_ws = initial_num
        last_active_num = initial_num
    else:
        last_ws = 1

    # Main monitoring loop
    while True:
        try:
            num = get_kde_desktop()

            # Only update Ironbar if the workspace genuinely shifted
            if num is not None and num != last_ws and 1 <= num <= 9:
                update_ironbar(num)
                last_ws = num

        except KeyboardInterrupt:
            sys.exit(0)
        except Exception:
            pass

        # Polling interval (100ms) matches your old script
        time.sleep(0.1)

if __name__ == "__main__":
    main()
