

WIP

# Anthropic's citations
Knowledge is sent to Anthropic via their `citations` feature:
https://docs.anthropic.com/en/docs/build-with-claude/citations#response-structure


# Why?
Significantly less hallucinations.
Set you LLM up for success.
When you ask a question without a RAG - LLM can only reply with an aggregated-and-generic-trained-on-the-whole-internet knowledge.
However if you include a related knowledge (e.g. proprietary) - you set your LLM up for success - making it reason in a direction that you lead.

# Technical Why
There are a lot of various RAG technics & implementations on gh. They are packaged as "agents" - you can use them but there is no free integration with other tools.
What's missing is a standard (a standardized way to use them).
Meaning you need to take a source code and fiddle around in order to integrate it in your pipeline.

- Lets say if you are using open-webui, and its its own RAG / Knowledge, how do you bring this knowledge to summarization.
- Or you use some VS Code extension, that lets you add knowledge about your codebase, how do you bring that knowledge into 
- Or you use a custom RAG tool from gh, how do you bring that knowledge into VS Code

None of the existing RAG implementations would be able to use it, because all they know how to use is openAI API spec / Anthropic / Ollama, etc...
Most of these tools (open-webui, endless VS Code extensions use openAI API spec).

Ideas with sven is to have a transparent RAG with central knowledge base. So that any tool that uses openAI-like API can benefit from the knowledge that you accumulated. It does not have a direct access to the knowledge db, but all LLM asks are enriched with knowledge that is related to a question.


# Alternatives
The closest I ever found was
extensible
proxy lib I found but could not use becuase it messes up chats history.
It takes all chat turns and zips into 1 user-assistant pair. This was a no go (instead of having LLM do actual work, it now wastes resources on keeping track where is user and where is an assistant in a one-turn conversation step).




