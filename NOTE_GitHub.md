## Github note:

The most common working procedure (for me) with GitHub

## From begining

  1. `mix new my_app --sup` or `mix phx.new ...` --> cd my_app --> start development --> test
  2. goto `github.com/new` to create a new repository with `name` and `description`.
  3. At the outermost folder of your project: `git init` --> Init a git config
  4. `git add .` --> add all file in the dev directory to monitor (keeping track of this/all file).
  5. `git commit -m "message"` --> take a snapshot of current state of your dev directory (and store this snapshot in your local machine).
  6. `git remote add origin https://github.com/your-acc-name/your-project-name.git`
  7. `git push` --> push the commit (the snapshot in the step 5th above) up to your remote repository in GitHub. DONE.

## At each step of your development

  1. `git add .`
  2. `git commit -m "message"`
  3. `git push`

## Other git commands

  - `git status`: to see what currently happening in your repository (current branch on local vs "origin/main" on remote). Local version of your repository vs the remote/origin version of your repo.
  - `git commit -am "message"`: commbine: `git add.` with `git commit -m "message"`.

## Quick setup guide (just after you created a new repository in GitHub)

```
** …or create a new repository on the command line **
echo "# exp_scheduler" >> README.md
git init
git add README.md
git commit -m "first commit"
git branch -M main
git remote add origin https://github.com/tuan-karma/exp_scheduler.git
git push -u origin main

** …or push an existing repository from the command line **
git remote add origin https://github.com/tuan-karma/exp_scheduler.git
git branch -M main
git push -u origin main

** …or import code from another repository **
You can initialize this repository with code from a Subversion, Mercurial, or TFS project.
```