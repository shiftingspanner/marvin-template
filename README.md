# MARVIN - Your AI Chief of Staff

**MARVIN** = Manages Appointments, Reads Various Important Notifications

MARVIN is an AI assistant template for [Claude Code](https://docs.anthropic.com/en/docs/claude-code) that remembers your conversations, tracks your goals, and helps you stay organized. Like having a personal chief of staff who never forgets anything.

---

## What Can MARVIN Do?

- **Remember everything** — Pick up where you left off, even days later
- **Track your goals** — Monitor progress and nudge you when you're falling behind
- **Manage your tasks** — Keep a running to-do list that persists across sessions
- **Log your work** — Track articles, projects, and anything you ship
- **Give you briefings** — Start each day knowing what matters most
- **Extend itself** — Create new skills for your specific workflows

---

## Quick Start (5 minutes)

### Prerequisites

- [Claude Code](https://docs.anthropic.com/en/docs/claude-code) installed and configured
- Git (for version control)

### Step 1: Clone or Download

```bash
git clone https://github.com/SterlingChin/marvin-template.git my-marvin
cd my-marvin
```

### Step 2: Set Up Your Information

1. Copy the template to create your CLAUDE.md:
   ```bash
   cp CLAUDE.md.template CLAUDE.md
   ```

2. Open `CLAUDE.md` in any text editor and replace the `{{PLACEHOLDERS}}`:
   - `{{YOUR_NAME}}` → Your name
   - `{{YOUR_ROLE}}` → Your job title
   - `{{YOUR_EMPLOYER}}` → Where you work
   - And so on...

### Step 3: Set Your Goals

Open `state/goals.md` and write down your goals. These don't have to be perfect—you can change them anytime.

### Step 4: Initialize Git

```bash
git init
git add -A
git commit -m "Initial MARVIN setup"
```

### Step 5: Start Using MARVIN

```bash
claude
```

Then type `/marvin` and press Enter. MARVIN will introduce itself and give you a briefing.

---

## Daily Usage

### Starting Your Day
```
/marvin
```
MARVIN will:
- Tell you your priorities
- Surface any deadlines or alerts
- Show progress against your goals

### Throughout Your Day

Just talk naturally:
- "Add a todo: finish the quarterly report"
- "What should I focus on?"
- "I just finished the presentation"
- "What did we discuss yesterday?"

### Quick Checkpoint
```
/update
```
Save your progress without ending the session. Use this frequently.

### Ending Your Day
```
/end
```
MARVIN will:
- Summarize what you covered
- Save everything for next time
- Update your state and task list

---

## Commands

| Command | What It Does |
|---------|--------------|
| `/marvin` | Start a session with a daily briefing |
| `/end` | End session and save everything |
| `/update` | Quick checkpoint (save without ending) |
| `/commit` | Review and commit git changes |

---

## Directory Structure

```
my-marvin/
├── CLAUDE.md              ← Your profile and MARVIN's instructions
├── skills/                ← MARVIN's capabilities
│   ├── marvin/            ← Session start
│   ├── end/               ← Session end
│   ├── update/            ← Quick checkpoint
│   ├── commit/            ← Git commits
│   ├── content-shipped/   ← Track shipped work
│   └── _template/         ← Create new skills
├── state/
│   ├── current.md         ← Current priorities and open threads
│   └── goals.md           ← Your annual goals
├── sessions/              ← Daily logs (auto-created)
│   └── 2026-01-22.md
└── content/
    └── log.md             ← Everything you've shipped
```

**Key point:** You own all your data. It's just text files on your computer.

---

## Skills System

MARVIN uses **skills** for repeatable tasks. Each skill is a directory with a `SKILL.md` file that contains instructions.

### Included Skills

| Skill | Trigger | Description |
|-------|---------|-------------|
| `marvin` | `/marvin` | Start session with briefing |
| `end` | `/end` | End session, save context |
| `update` | `/update` | Quick checkpoint |
| `commit` | `/commit` | Git commit workflow |
| `content-shipped` | "I shipped..." | Log completed work |
| `skill-creator` | "create a skill for..." | Make new skills |

### Creating New Skills

Tell MARVIN what you need:
> "Create a skill for weekly reviews"

Or copy the template:
```bash
cp -r skills/_template skills/my-new-skill
```

Edit `skills/my-new-skill/SKILL.md` with your instructions.

---

## Customization

### Editing Your Profile

Open `CLAUDE.md` and update:
- Your goals and priorities
- Key contacts
- Monthly targets
- MARVIN's personality (if you want)

### Adding Integrations

MARVIN can be extended with integrations for:
- Gmail / Google Calendar
- Jira / Linear
- Slack
- And more...

Check out the [full MARVIN implementation](https://github.com/SterlingChin/marvin) for examples of integrations.

---

## Philosophy

MARVIN is built on a few key ideas:

1. **You own your data** — Everything is text files you control
2. **Memory matters** — Context carries across days and weeks
3. **Proactive beats reactive** — Get reminded before you forget
4. **Simple is better** — Start basic, grow as needed
5. **Skills are extensible** — Add capabilities as you need them

---

## Tips for Success

1. **Start and end every session** — This builds MARVIN's memory
2. **Use `/update` frequently** — Save progress as you go
3. **Be specific** — "Follow up with John about budget" beats "Follow up with John"
4. **Review weekly** — Ask for a "weekly review" on Fridays
5. **Keep goals updated** — Current goals make tracking meaningful

---

## Troubleshooting

### "MARVIN forgot something"
Make sure you're ending sessions with `/end` or using `/update` to checkpoint.

### "I want to undo changes"
Everything is in git:
```bash
git checkout <filename>
```

### "How do I add a custom workflow?"
Use the skill-creator: "Create a skill for [your workflow]"

---

## Contributing

Found a bug? Have an idea? Open an issue or PR.

---

## License

MIT License. See [LICENSE](LICENSE) for details.

---

*Created by [Sterling Chin](https://sterlingchin.com). Because everyone deserves a chief of staff.*
