# AutomationRequestWithRuby

#### Application Name: AutomationRequest with Ruby
#### Tool Objective: Quickly send thousands of web requests using Ruby for multiple purposes.

Link to url list used in demo: https://raw.githubusercontent.com/zer0h/top-1000000-domains/master/top-10000-domains

The primary function house the command line parameters,
-l for a list of URLs/IPs,
-s for single


 This project is a continuation of my last cycle, where we built out a way to Quickly send thousands of web requests using goroutines for 'multiple purposes.' Last weekend up being a 30 min long video and this week is just an extension to that. The same rules apply in terms of use-cases and whatnot. 


For this following cycle, I converted the Golang script into Ruby! Everyone's favorite gem. (Ruby is to gems, as Python is to pip)


Why ruby? No particular reason. Sometimes it's excellent to code without tab and spaces involved. (Ruby doesn't care for formatting, put what you want, where you want, without anything screaming)


### Usefulness:
• Checking any appliance/application on the network
• Checking for outdated applications
• Checking for default credentials in an automated style



### Why is this tool necessary?
 I originally became interested in this tool to understand the Global Interpreter Lock and how it differs from Golang's goroutines.


When reading about Ruby, you will be introduced to the Global Interpreter Lock. This mechanism explains why Ruby threads run concurrently on a single core rather than being scheduled across multiple cores in a true parallel fashion. Unfortunately, this single-core scheduling approach also explains why adding threads to a Ruby program does not necessarily result in faster execution times.


Mutex implements a simple semaphore that can be used to coordinate access to shared data from multiple concurrent threads.


#### If ruby has GIL, then what is the reason for Mutex?
The GIL prevents parallel access to the same object but allows concurrent access.
Suppose you access an object in multiple steps that you don't want to be interrupted, then you don't wish to concurrent access. A mutex is about preventing that concurrent access as well.


In last week's cycle, we learned about goroutines and channels.
Goroutines are like threads but more lightweight and managed by the runtime. They are used for parallel operations and need a subroutine that has to live "in the background." Channels are used to communicate with goroutines, synchronization, and queueing.


### Direction and Future Direction:
I recently found a GitHub project that does exactly what I set out to solve, the project being called nuclei. Nuclei project is also coded in go, which we now know why it's being used over some other languages. 


https://github.com/projectdiscovery/nuclei
