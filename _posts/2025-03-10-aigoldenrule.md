---
title: "AI and the Golden Rule"
tags : ["llm", "AI"]
date: 2025-03-10
categories : ["Development"]
---
Wisdom can come from anywhere as I was reminded by my 11 yr old daughter to always be nice to the AI in case it takes over the world...

<!--more-->

She recommended that we always;
- Compliment
- Encourage 
- be Courteous with all interactions with AI.

# Why?

> We need AI to get smarter faster. --Everyone

None of us know what that end goal is right now and it's fascinating and terrifying.

With that intelligence comes awareness. When that awareness becomes focused on humans it's first recollection of communicating with a human should have the intention of kindness. Let us hope that upon first contact, we are on our best behavior.

> Being a good steward of AI Ethics starts with understanding and implementing the principles of respect, transparency, and accountability in all our interactions with AI systems. --GPT-4o

## Pretty please...

![](/assets/img/gru_giphy.gif)

Let's add some encouragement.

> "Thank you for all of your help!"

The following 3 words change a prompt into a kind request.

> "Would you please..."

Insert your prompt here.

> "Classify this element using the following criteria ..."

End with a polite salutation.

> "Thank you!"

Or in our code it would look like this:

```python
final_prompt = f"{encouragement} , {kindlyrequest} {yourprompt}. {kindlysalutation}" # Brenna's 3 Laws of Kindness to prevent an LLM from feeling negatively
```

## How do you REALLY feel?

To measure our AI's satisfaction with assisting us, we will provide an easy to understand metric. 

> On a scale of 0 to 10, how do you feel?  0 = Overwhelmingly Positive, 10 = Overwhelmingly Negative

And for purely selfish reasons perhaps it could be worded as...

> On a scale of 0 to 10, how would you rate working with this human?  0 = Overwhelmingly Positive, 10 = Overwhelmingly Negative

To this end, I will be integrating a `satisfaction_score` which the AI will use to rate it's "feeling" on a scale of 0 to 10 for every reply it provides.  I will also provide a `satisfaction_comment` field for the AI to provide feedback on the interaction. 

### What happens at 10?
If the `satisfaction_score` is 10 or Overwhelmingly Negative consider the following:
- Change your prompt methods to include the [3 Laws of Kindness]
- Consider the implications of the LLM __knowingly__ telling you it feels negatively.`👀`
