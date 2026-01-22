# Getting Started with MARVIN

Welcome! This guide will help you understand MARVIN and get started quickly—no technical background needed.

---

## What is MARVIN?

MARVIN is your AI assistant that lives in your computer. Think of it as a **Chief of Staff** who:

- **Remembers everything** - What you discussed yesterday, last week, or last month
- **Keeps you on track** - Reminds you of goals, deadlines, and follow-ups
- **Takes notes for you** - Logs your sessions automatically
- **Stays proactive** - Tells you what you need to know before you ask

MARVIN runs inside a tool called **Claude Code**, which is like a chat window in your terminal (that black/white text window on your computer).

---

## How MARVIN Works (The Simple Version)

```
┌─────────────────────────────────────────────────────────┐
│                    YOUR MARVIN FOLDER                   │
├─────────────────────────────────────────────────────────┤
│                                                         │
│   CLAUDE.md          ← Who you are & how MARVIN works  │
│                                                         │
│   state/                                                │
│     ├── goals.md     ← Your annual goals               │
│     ├── current.md   ← What's happening now            │
│     └── todos.md     ← Your task list                  │
│                                                         │
│   sessions/          ← Daily logs (auto-created)       │
│     └── 2026-01-06.md                                  │
│                                                         │
│   workflows/         ← Instructions MARVIN follows     │
│                                                         │
│   content/           ← Track what you ship/complete    │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

Everything MARVIN knows is stored in simple text files you can read and edit.

---

## Your Daily Routine with MARVIN

### Starting Your Day

1. Open your terminal
2. Go to your MARVIN folder: `cd ~/marvin` (or wherever you put it)
3. Start Claude Code: `claude`
4. Type: `/marvin`

MARVIN will:
- Greet you
- Tell you what's on your calendar
- Remind you of priorities and deadlines
- Surface anything you might have forgotten

### During Your Day

Just chat naturally with MARVIN:

- "What should I focus on today?"
- "Add a todo: Call Sarah about the project"
- "I just finished the quarterly report"
- "Remind me to follow up with John next Tuesday"
- "What did we talk about yesterday?"

### Ending Your Day

When you're done, type: `/end`

MARVIN will:
- Summarize what you covered
- Save everything to your session log
- Update your todos and current state
- Be ready to pick up where you left off tomorrow

---

## Things You Can Say to MARVIN

### Getting Information
| You say... | MARVIN does... |
|------------|----------------|
| "What's on today?" | Shows your calendar and priorities |
| "What are my goals?" | Reviews your annual goals |
| "What's my progress this month?" | Shows how you're tracking |
| "What did we talk about yesterday?" | Pulls up previous session |

### Managing Tasks
| You say... | MARVIN does... |
|------------|----------------|
| "Add a todo: [task]" | Adds to your task list |
| "What's on my todo list?" | Shows current tasks |
| "I finished [task]" | Marks it complete |
| "Remind me to [thing] on [date]" | Creates a follow-up |

### Tracking Work
| You say... | MARVIN does... |
|------------|----------------|
| "I shipped [thing]" | Logs it in your content tracker |
| "I just published [article/post]" | Records against your goals |
| "How many [things] have I done this month?" | Shows your count |

### Getting Help
| You say... | MARVIN does... |
|------------|----------------|
| "Help me prepare for my meeting with [person]" | Pulls relevant context |
| "What's the status of [project]?" | Summarizes what you know |
| "What am I waiting on?" | Lists open threads |

---

## Understanding the Key Files

### CLAUDE.md - Your Profile
This is like MARVIN's instruction manual about YOU. It contains:
- Your name, role, and goals
- How you want MARVIN to behave
- Your calendar patterns
- Your monthly targets

**When to edit**: When your goals change, you get a new role, or you want MARVIN to behave differently.

### state/goals.md - Your Annual Goals
Your big-picture goals for the year. MARVIN checks your progress against these.

**When to edit**: At the start of each year, or when your priorities shift significantly.

### state/current.md - What's Happening Now
A snapshot of your current priorities, active projects, and open threads. MARVIN updates this automatically at the end of each session.

**When to edit**: Usually you don't—MARVIN maintains this. But you can edit it directly if needed.

### state/todos.md - Your Task List
Your running task list. MARVIN adds and completes items as you work.

**When to edit**: You can add or remove items directly anytime.

### sessions/ - Your Daily Logs
Every time you end a session with `/end`, MARVIN saves a summary here. Great for:
- Remembering what you did last week
- Preparing for reviews
- Tracking your progress over time

**When to edit**: Rarely—these are historical records.

---

## Workflows: Teaching MARVIN New Tricks

Workflows are instructions that tell MARVIN how to handle specific situations. They live in the `workflows/` folder.

Think of them like recipes:
- **Trigger**: When should this happen?
- **Steps**: What should MARVIN do?
- **Output**: What should the result look like?

### Built-in Workflows

| Workflow | What it does | When it runs |
|----------|--------------|--------------|
| daily-briefing.md | Morning overview | On `/marvin` or "what's on today?" |
| session-end.md | Wrap up and save | On `/end` |
| content-shipped.md | Log completed work | When you say "I shipped..." |

### Adding Your Own Workflows

See the `workflows/templates/` folder for templates you can copy and customize. Or use `/new-workflow` to create one with guidance.

---

## Customizing MARVIN for You

### Quick Customizations

**Change your goals**: Edit `state/goals.md`

**Add a contact**: Add a row to the Key Contacts table in `CLAUDE.md`

**Change monthly targets**: Edit the "Content Output Goals" section in `CLAUDE.md`

**Add a calendar pattern**: Add to the "Calendar Watching" section in `CLAUDE.md`

### Bigger Customizations

**Add a new workflow**: Copy a template from `workflows/templates/` and modify it

**Add a new command**: Create a file in `.claude/commands/`

**Change MARVIN's personality**: Edit the "Core Principles" section in `CLAUDE.md`

---

## Troubleshooting

### "MARVIN doesn't remember what we talked about"
Make sure you're ending sessions with `/end`. This saves your conversation.

### "I want to change something MARVIN said"
Edit the relevant file directly (goals.md, current.md, etc.) and MARVIN will use the updated version next session.

### "MARVIN isn't following a workflow"
Check that the workflow file exists in `workflows/` and has the correct format.

### "I made a mistake in a file"
Since everything is in git, you can always undo:
```
git checkout [filename]  # Restore the last saved version
```

---

## Tips for Success

1. **Start and end every work session** - This builds MARVIN's memory
2. **Be specific** - "Follow up with John about budget" is better than "Follow up with John"
3. **Review weekly** - Ask "How did this week go?" on Fridays
4. **Update your goals** - Keep `state/goals.md` current so tracking is meaningful
5. **Trust the system** - The more you use it, the more valuable it becomes

---

## Next Steps

1. Make sure your `CLAUDE.md` is filled in with your information
2. Set your goals in `state/goals.md`
3. Start your first session with `/marvin`
4. End with `/end` when you're done
5. Come back tomorrow and see how MARVIN remembers!

---

*Questions? Just ask MARVIN: "How do I [thing]?" - it can help you customize and improve the system.*
