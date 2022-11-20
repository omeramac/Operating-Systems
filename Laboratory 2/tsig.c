//##  OMER AMAC ##//
//##    323796  ##//

#include <stdio.h>
#include <stdlib.h>
#include <signal.h>
#include <sys/wait.h>
#include <unistd.h>


#define WITH_SIGNALS

//defininng the number of childs
#define NUM_CHILD 9

char inter_occur = 0;
/*void signalHandler(int signo, siginfo_t *info, void *ucontext){*/
/*	*/
/*	*/
/*	if(signo=SIGINT){*/
/*	*/
/*		printf("Interrupt key was pressed.\n");*/
/*		inter_occur = 1;*/
/*		kill();*/
/*		//printf("Child %d is killed related to 2-2.\n",z);*/
/*			*/
/*		*/
/*		_exit(0);*/
/*		*/
/*	}
/*	}*/

/*}*/
//child process, SIGTERM handling function
void child_term(){
	printf("Child [%d] received SIGTERM signal, terminating...\n", getpid());
}

//Parent interrupt handling function
void parent_inter_handle(){
	printf("Keyboard interrupt received.\n");
	inter_occur=1;
}


int main(int argc, char* argv[]){
	
	struct sigaction ig={0}, term={0}, restore={0}, par_int={0};
/*	sa.sa_flags=SA_SIGINFO;*/
/*	sa.sa_sigaction=signalHandler;*/
/*	sigfillset(&sa.sa_mask);*/
	
	//ignoring handler
	ig.sa_handler=SIG_IGN;
	
	//child process, SIGTERM handler 
	term.sa_sigaction=child_term;
	sigfillset(&term.sa_mask);
	
	//Restoring to default handler
	restore.sa_handler=SIG_DFL;
	
	//parent interrupt handler
	par_int.sa_sigaction=parent_inter_handle;
	sigfillset(&par_int.sa_mask);
	
	//getting parent id
	pid_t parent_PID = getpid();

	//empty array for collecting pids' of children
	pid_t hist[NUM_CHILD]; 

	printf("Parent ID is : %d\n", parent_PID );
	
	//https://stackoverflow.com/questions/3663209/sigset-ignoring-ctrl-c-in-unix
		
/*			if (sigaction(SIGINT, &sa, &ig) == 0 && ig.sa_handler != SIG_IGN){*/
/*				for(int f=0; f<NSIG; f++){*/
/*    					sa.sa_handler = force_ignore;*/
/*   					sigaction(SIGINT, &sa, 0);*/
/*   				}*/
/*			}*/
		#ifdef WITH_SIGNALS 
			for (int a=0; a<NSIG;a++){
				//ignore all current signals
				sigaction(a,&ig,NULL);
			
			}
			//if SIGCHLD signal received, use handler from restore pointer
			sigaction(SIGCHLD,&restore,NULL);
			//if SIGINT signal received
			sigaction(SIGINT,&par_int,NULL);
			
		#endif

	//starting to create child processes	
	for (int c=0; c<NUM_CHILD; c++){
		
		//in case of keyboard interrupt was pressed during parent process, flag becomes 1 and all created children get killed
		#ifdef WITH_SIGNALS
    		if(inter_occur==1){
    		printf("Parent[%d] sending SIGTERM signal\n",parent_PID);
			//killin all created children
    			for(int i=0; i<c; i++){
				
				//printf("Child [%d] received SIGTERM signal, terminating.\n",hist[i]);
				kill(hist[i], SIGTERM);
				//printf("c value %d and hist %d.\n",i,hist[i]);
			}
			break;
		}
    		
    		
    		
    		#endif
		
		printf("Trying to spawn child #%i\n", c);
		
		//calling fork for creating children, fork creates two process one is child and previous child becomes parent
		pid_t child = fork();

		//only considering current child
		if(child == 0){
			#ifdef WITH_SIGNALS
			//ignore keyboard interrupt
				sigaction(SIGINT,&ig,NULL);
			//print message from handler for SIGTERM signal
				sigaction(SIGTERM,&term,NULL);
			#endif
			printf("Child[%i]  created.  \n", getpid());
			//10 seconds sleeping
			sleep(10);
			
			printf("Child[%i] execution completed.\n", getpid());
			
			_exit(0);
		//in case of an error during child creation
		} else if(child == -1){
	
			printf("Parent[%i]  failed---.  \n", getpid());
			for(int i=0; i<c; i++){
				//killing child with sending SIGTERM signal
				kill(hist[i], SIGTERM);
				printf("Child [%d] is killed because of failed parent.\n",hist[i]);
			
			}
			_exit(1);	
		}
		//collect the children pid in hist[c]
		hist[c] = child;
		//printf("hist value %d.\n",hist[c]);
	
    	sleep(1);
    	
    	
	}
	
	int count=0;
	while(1){
		int temp = wait(NULL);
		if(temp == -1){
			break;
		} else {
			//printf("Child[%i] completed.\n", temp);
			count++; //counting the succesful processes
		
		}
	
	}
	printf("\n%d process succesfully terminated.\n", count);

	
	//set all signals to default, restoring
	#ifdef WITH_SIGNALS
		for(int x=0; x<NSIG; x++){
			sigaction(x,&restore,NULL);
		
		}
	#endif

	return 0;
}
