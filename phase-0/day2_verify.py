import sys
import subprocess

def check(label, condition, detail=""):
    status = "OK" if condition else "FAIL"
    print(f"  [{status}] {label}")
    if detail:
        print(f"         {detail}")
    return condition

def main():
    print("=" * 50)
    print("  Day 2 Environment Verification")
    print("=" * 50)

    results = []

    # Python version
    version = sys.version_info
    results.append(check(
        "Python version",
        version.major == 3 and version.minor >= 12,
        f"Found: Python {version.major}.{version.minor}.{version.micro}"
    ))

    # Virtual environment
    in_venv = sys.prefix != sys.base_prefix
    results.append(check(
        "Virtual environment active",
        in_venv,
        f"Prefix: {sys.prefix}"
    ))

    # psycopg2
    try:
        import psycopg2
        results.append(check("psycopg2 installed", True, psycopg2.__version__))
    except ImportError:
        results.append(check("psycopg2 installed", False, "Run: pip install psycopg2-binary"))

    # PostgreSQL connection
    try:
        import psycopg2
        conn = psycopg2.connect(
            host="localhost",
            database="de_learning",
            user="delearner",
            password="delearner123"
        )
        conn.close()
        results.append(check("PostgreSQL connection", True, "Connected to de_learning"))
    except Exception as e:
        results.append(check("PostgreSQL connection", False, str(e)))

    # Git
    try:
        result = subprocess.run(
            ["git", "--version"],
            capture_output=True, text=True
        )
        results.append(check(
            "Git installed",
            result.returncode == 0,
            result.stdout.strip()
        ))
    except FileNotFoundError:
        results.append(check("Git installed", False, "git not found in PATH"))

    print("=" * 50)
    passed = sum(results)
    total = len(results)
    print(f"  Result: {passed}/{total} checks passed")

    if passed == total:
        print("  Your environment is fully ready.")
    else:
        print("  Fix the FAIL items above before Day 3.")

    print("=" * 50)

if __name__ == "__main__":
    main()