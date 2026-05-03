# git-spin

Multi-repo [git worktree](https://git-scm.com/docs/git-worktree) manager. Create worktrees across multiple repos with a single command, branched from the latest `master`/`main`, without touching your current branch.

## Install

```bash
curl -fsSL https://raw.githubusercontent.com/jatingarg36/git-spin/master/git-spin -o /usr/local/bin/git-spin && chmod +x /usr/local/bin/git-spin
```

Or clone and install locally:

```bash
git clone https://github.com/jatingarg36/git-spin.git
cd git-spin
sudo ./install.sh
```

## Usage

```bash
git-spin start <workspace> <repo...> [--dir <path>]
git-spin stop  <workspace> [<repo...>] [--dir <path>]
git-spin list  [--dir <path>]
```

### Create a workspace

```bash
# Spin up worktrees for multiple repos in parallel
git-spin start my-feature repo-a repo-b repo-c

# Add more repos to the same workspace later
git-spin start my-feature repo-d

# Use a specific directory containing your repos
git-spin start my-feature repo-a repo-b --dir ~/projects
```

### List workspaces

```bash
git-spin list
git-spin list --dir ~/projects
```

### Remove a workspace

```bash
# Remove specific repos from a workspace
git-spin stop my-feature repo-a repo-b

# Remove the entire workspace
git-spin stop my-feature
```

## How it works

- `start` fetches the latest `origin/master` (or `origin/main`), creates a branch named after the workspace, and sets up a worktree at `<dir>/<workspace>/<repo>`.
- Your current checked-out branch in each repo is never altered.
- All repos are processed in parallel with live in-place progress updates.
- Running `start` again with the same workspace adds new repos — already-spun repos are skipped.
- `stop` removes worktrees, deletes the local branches, and cleans up the workspace directory when empty.
- `list` scans for workspace directories and shows all repos grouped by workspace.
- Repos that are not cloned are reported and skipped without affecting the rest.

## Directory layout

```
~/projects/
├── repo-a/               # original clone (branch: master, untouched)
├── repo-b/               # original clone (branch: master, untouched)
├── repo-c/               # original clone
└── my-feature/           # workspace directory created by git-spin
    ├── repo-a/           # worktree (branch: my-feature, from origin/master)
    ├── repo-b/           # worktree (branch: my-feature, from origin/master)
    └── repo-c/           # worktree (branch: my-feature, from origin/master)
```

## Options

| Flag | Description | Default |
|------|-------------|---------|
| `--dir <path>` | Base directory containing your repo clones | Current directory |
