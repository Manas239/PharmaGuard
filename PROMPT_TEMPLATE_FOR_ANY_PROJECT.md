# 🎯 PROMPT TEMPLATE: How to Create Interview Guide for ANY Project

## Use This Prompt to Generate Interview Guides for Other Projects

Copy and modify this prompt for any GitHub project repo:

---

## MASTER PROMPT (Copy & Customize)

```
You are an expert technical interviewer and project documentation specialist.

I have a GitHub repository at: [REPO_OWNER]/[REPO_NAME]

I need you to create a COMPLETE INTERVIEW PREPARATION GUIDE that includes:

1. **Quick 30-Second Overview**
   - What the project is
   - Core problem it solves
   - Who uses it

2. **Part 1: Project Understanding**
   - Core problem statement
   - Key technologies/domains it addresses
   - Main user journey/workflow
   - Tech stack breakdown
   - All important concepts/entities to know

3. **Part 2: Architecture**
   - System architecture diagram (text-based)
   - Data flow step-by-step
   - All important API endpoints/routes
   - How components communicate

4. **Part 3: Implementation Details**
   - Key backend logic and validation
   - Important integrations
   - Data structures and models
   - Configuration/environment variables
   - Error handling approach

5. **Part 4: Frontend Understanding**
   - Component structure
   - Main page/component logic
   - State management approach
   - Important features

6. **Part 5: 15+ Interview Q&A**
   Generate common interview questions with PERFECT answers including:
   - "Tell me about this project in 2 minutes"
   - "What problem does it solve?"
   - "Walk me through the workflow"
   - "Why did you choose [tech]?"
   - "How does [feature] work?"
   - "What are limitations?"
   - "How would you improve it?"
   - "How do you handle [error scenario]?"
   - And 7+ more realistic interview questions

7. **Part 6: Technical Depth Questions**
   - Code-level questions
   - Edge cases
   - Performance considerations
   - Security aspects

8. **Part 7: Quick Cheat Sheet**
   - Must-remember facts
   - File paths
   - API endpoints
   - Key commands

9. **Part 8: Different Explanation Scenarios**
   - 30-second elevator pitch
   - 2-minute explanation
   - 5-minute technical deep dive
   - 10-minute comprehensive explanation

10. **Part 9: Final Interview Tips**
    - Do's and Don'ts
    - Practice points
    - Common mistakes to avoid

Format it as a beautiful, downloadable HTML file with:
- Professional styling
- Dark/light theme compatible
- Print-to-PDF friendly
- Table of contents
- Color-coded sections
- Easy-to-scan formatting
- Code blocks for technical content

Make it comprehensive so someone can understand the ENTIRE project and confidently explain it in any interview scenario.
```

---

## QUICK INSTRUCTION GUIDE

### For Different Types of Projects:

#### **For Web Applications (Frontend/Backend)**
Add this to the prompt:
```
This is a full-stack web application. Focus on:
- User interaction flow
- Frontend state management
- Backend API design
- Database schema (if any)
- Authentication/Authorization
- Error handling
```

#### **For Mobile Apps**
Add this to the prompt:
```
This is a mobile application. Focus on:
- Screen navigation flow
- State management (Redux, Provider, etc.)
- Native API usage
- Performance optimization
- Battery/memory considerations
```

#### **For APIs/Microservices**
Add this to the prompt:
```
This is an API/Microservice. Focus on:
- API design principles
- Request/response formats
- Authentication mechanisms
- Rate limiting/throttling
- Scalability approaches
```

#### **For ML/AI Projects**
Add this to the prompt:
```
This is a machine learning project. Focus on:
- Model architecture
- Training data pipeline
- Preprocessing steps
- Model evaluation metrics
- Deployment strategy
```

#### **For Data Engineering Projects**
Add this to the prompt:
```
This is a data engineering project. Focus on:
- Data pipeline design
- ETL/ELT processes
- Data warehousing
- Query optimization
- Scalability and reliability
```

---

## STEP-BY-STEP USAGE INSTRUCTIONS

### Step 1: Find Your Repo Info
```
Go to your repo on GitHub
Copy the owner and repo name
Example: Manas239/PharmaGuard
```

### Step 2: Get Repository Details
```
Before using the prompt, you need:
1. Project description/README
2. Main tech stack
3. Key features
4. File structure

These help the AI generate accurate content
```

### Step 3: Customize the Prompt
```
Replace:
- [REPO_OWNER] → your GitHub username
- [REPO_NAME] → your repository name
- Add project-specific details if needed
```

### Step 4: Give the Prompt to an AI
```
You can use:
- ChatGPT
- Claude
- GitHub Copilot
- Or any AI assistant

Just paste the prompt and your repo URL
```

### Step 5: Request HTML Output
```
At the end of the prompt, add:

"Output this as a beautiful HTML file 
that can be downloaded and saved as PDF. 
Include professional styling, 
table of contents, 
and easy-to-read formatting."
```

---

## CUSTOMIZATION EXAMPLES

### Example 1: E-Commerce Platform
```
You are an expert technical interviewer.

I have a GitHub repo: john-doe/ShopifyClone

Create an interview guide covering:
- Product catalog management
- Shopping cart logic
- Payment integration
- Order fulfillment
- User authentication
- Admin dashboard

Include 20 interview Q&A 
with perfect answers.

Output as downloadable HTML.
```

### Example 2: Social Media App
```
You are an expert technical interviewer.

I have a GitHub repo: jane-smith/SnapgramClone

Create an interview guide covering:
- User registration/login flow
- Post creation and feed algorithm
- Real-time messaging
- Notification system
- Image storage and optimization
- User interactions (likes, comments, follows)

Include architecture diagrams
and 15+ interview questions.

Output as downloadable HTML.
```

### Example 3: Todo App
```
You are an expert technical interviewer.

I have a GitHub repo: dev/AdvancedTodoApp

Create an interview guide covering:
- Task management CRUD operations
- Priority and due date handling
- Recurring tasks
- Collaboration features
- Synchronization across devices
- Offline-first approach

Include tech stack analysis
and common interview questions.

Output as downloadable HTML.
```

---

## ADVANCED PROMPT VARIATIONS

### For Deep Technical Focus
```
Add to the prompt:
"Place extra emphasis on:
- Algorithm complexity
- System design decisions
- Optimization techniques
- Edge cases and error handling
- Security vulnerabilities and mitigations"
```

### For Beginner-Friendly Version
```
Add to the prompt:
"Make this beginner-friendly by:
- Explaining technical terms
- Adding more code examples
- Breaking down complex concepts
- Including learning resources
- Adding 'Why?' explanations"
```

### For Hiring Managers/Interviewers
```
Add to the prompt:
"Format this for interviewers by:
- Highlighting key assessment areas
- Including follow-up questions
- Rating complexity levels
- Adding real-world scenario questions
- Suggesting time allocation"
```

### For Job Interview Focus
```
Add to the prompt:
"Optimize for job interviews by:
- Including STAR method answers
- Adding behavioral questions
- Including system design questions
- Adding coding challenge hints
- Including salary negotiation talking points"
```

---

## PROMPT COMPONENTS YOU CAN MIX & MATCH

### Architecture Section Options:
- [ ] Include API endpoint documentation
- [ ] Include database schema diagrams
- [ ] Include deployment architecture
- [ ] Include external service integrations
- [ ] Include data flow diagrams

### Interview Questions Options:
- [ ] Technical depth questions
- [ ] Behavioral questions
- [ ] System design questions
- [ ] Problem-solving scenarios
- [ ] Real-world use case questions

### Documentation Options:
- [ ] Code walkthroughs
- [ ] File structure explanations
- [ ] Configuration guides
- [ ] Troubleshooting section
- [ ] Performance benchmarks

---

## COMMON MISTAKES TO AVOID

❌ **Don't:**
- Give vague project descriptions
- Forget to specify tech stack
- Neglect to mention constraints
- Skip edge cases
- Ignore security aspects

✅ **Do:**
- Provide complete repo details
- Specify target audience level
- Include all integrations
- Mention limitations
- Cover error scenarios

---

## QUICK CHECKLIST

Before using the prompt, ensure:
- [ ] You have the repo URL
- [ ] You know the main tech stack
- [ ] You understand the core problem
- [ ] You can list key features
- [ ] You know the target users
- [ ] You have documentation/README

---

## AFTER YOU GET THE HTML

### Step 1: Review & Customize
- Read through the generated guide
- Add project-specific details
- Correct any inaccuracies
- Enhance examples with your code

### Step 2: Practice
- Read the 2-minute explanation 3 times
- Practice drawing architecture
- Memorize key concepts
- Run through Q&A answers

### Step 3: Export as PDF
- Open HTML in browser
- Press Ctrl+P (or Cmd+P on Mac)
- Choose "Save as PDF"
- Store for offline access

### Step 4: Study
- Print it out for quick reference
- Share with team/mentors
- Use during interview prep
- Update as you learn more

---

## TEMPLATE FOR MARKDOWN VERSION

If you want Markdown instead of HTML, modify the prompt:

```
I need you to create a COMPLETE INTERVIEW PREPARATION GUIDE 
in Markdown format (.md file) for my GitHub project.

[Same requirements as above]

Output format: Markdown (.md)
Include: Table of contents, headers, code blocks, tables
Make it: Print-friendly and easy to convert to PDF
```

---

## GETTING EVEN MORE VALUE

### Add These to Your Prompt for Extra Content:

**1. Real Code Examples**
```
"For each concept, include actual code snippets
from the repository showing how it's implemented."
```

**2. Common Pitfalls**
```
"Include a section on 'Common Mistakes to Avoid'
for each major feature."
```

**3. Performance Considerations**
```
"Include performance optimization tips
and complexity analysis."
```

**4. Security Review**
```
"Include security best practices implemented
in the project."
```

**5. Testing Strategy**
```
"Include testing approach and test scenarios
for major features."
```

---

## REAL EXAMPLE: Full Working Prompt

```
You are an expert technical interviewer and project documentation specialist.

I have a GitHub repository: Manas239/PharmaGuard

It's a pharmacogenomics web application that analyzes drug safety based on genetic profiles.

Tech Stack:
- Frontend: React + Vite + Tailwind CSS
- Backend: Node.js + Express
- External: Groq API for AI

Key Features:
- VCF file upload
- Drug analysis
- Risk assessment
- AI-powered Q&A
- Session history

Create a COMPLETE INTERVIEW PREPARATION GUIDE including:

1. Quick 30-second overview
2. Problem statement and solution
3. Complete architecture with diagrams
4. Data flow explanation
5. Technology stack breakdown
6. 20+ interview Q&A with perfect answers
7. Technical depth questions
8. Quick reference cheat sheet
9. Different explanation scenarios (30s, 2m, 5m, 10m)
10. Final interview tips and dos/don'ts

Make it comprehensive, professional, and suitable for:
- Job interviews
- Project viva/defense
- Presentation preparation
- Team knowledge sharing

Output as a beautiful, downloadable HTML file 
with professional styling, dark theme support, 
print-to-PDF compatibility, and table of contents.
```

---

## 🎯 QUICK START: Copy This Template

```
You are an expert technical interviewer.

I have a GitHub repository: [OWNER]/[REPO]

Project: [Brief description]
Tech: [Languages/Frameworks]
Purpose: [What it does]

Create a complete interview preparation guide with:
- 30-second pitch
- Problem & solution
- Architecture & data flow
- Tech stack analysis
- 20+ interview Q&A with answers
- Cheat sheet
- Multiple explanation lengths
- Interview tips

Output: Beautiful, downloadable HTML file
```

---

**🎓 Now you can create interview guides for ANY project!**

Just fill in your repo details and run the prompt with any AI assistant.

**Good luck! 🚀**
