///////////////
// OMER AMAC //
//   323796  //
///////////////

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <pthread.h>
#include <sys/types.h>
#include <sys/sem.h>
#include <signal.h>
#include <wait.h>
#include <semaphore.h>
//define the food number
#define FOOD_NO 20
//define the number of philosophers
#define PHILOSOPHERS 5

void grab_forks(int left_fork_id);
void put_away_forks(int left_fork_id);
void action(int name);
//semaphore id
int sem_id;
//philosopher id
int phil_name;
//return value of semctl
int semctl_ret;
//int meal;
int hunger = 0;
int a;

int main(){
    //gettng the semaphore id with semget
    sem_id = semget(IPC_PRIVATE, PHILOSOPHERS, 0644 | IPC_CREAT);
    //check if semget return error or not
    if (sem_id == -1)
    {
        printf("Error for semget.\n");
        _exit(0);
    } 
    int food_list [PHILOSOPHERS+1];
    for (int j = 0; j < PHILOSOPHERS; j++)
    {
        food_list[j] = FOOD_NO;
    }
    //call semctl over all philosophers
    for (int i = 0; i < PHILOSOPHERS; i++)
    {       
            //performs the control operation specified by cmd on the System V semaphore set identified by semid
            semctl_ret = semctl(sem_id,i,SETVAL,1);
            //chehck if semctl returns error or not
            if (semctl_ret == -1)
            {
                printf("Cannot set semctl.\n");
                _exit(0);
            }
            
    }   


    for (int f = 0; f < PHILOSOPHERS; f++)
    {       
            //creating forks with child process
            pid_t forks = fork();
            //check if child respawn successfully
            if (forks <= -1)
            {
                printf("Error while creating forks.\n");
                //kill the children if error occurs
                kill(-2,SIGTERM);
                _exit(0);
            } else if (forks == 0) //if child respawn successfully:
            {
                phil_name = f;
                
                
                
	            int z =0;
	            int meal = FOOD_NO;
	            for (int d=0; d<FOOD_NO; d++)
	            {
		            while(food_list[phil_name]>0)
		            {
                        //sem_t *sem = &phil_name;
                        //sem = #;
                        if (a == phil_name)
                        {
                            //sleep(1);
                            //printf(" \n");
                            //hunger = 0;
                            //sem_wait(&phil_name);
                            
                        }else{
                            action(phil_name);
                            food_list[d]= food_list[d] - 1;
                            

                        }
                        //sem_post(&phil_name);
                        
			            
                        /*meal = food_list[phil_name] - 1;
                        if (meal == 0){
                            semctl(sem_id, phil_name, IPC_RMID);
                        }*/
			            
		            }
		            //else
		            //{
			            //sleep(1);
			            //hunger = 1;
		            //}

	            }

                
                
                return 0;
            }
            
            
    }

    while(1) {
		int temp = wait(NULL);
		if (temp == -1){
            //printf("Error in while.\n");
            break;
        }
			

	}

    //Release the storage used for the process/task
    if (semctl(sem_id, 0, IPC_RMID) == -1){ //IPC_RMID :Immediately remove the semaphore set, awakening all processes blocked in semop
        printf("Error while removing the semaphore.\n");
        exit(1);
    }
    printf("All Philosophers are full after meal.\n");
    return 0;

}




//grabbing forks
void grab_forks(int left_fork_id){
    //decrease left fork by one and find the fork next to it
    int right_fork_id = left_fork_id - 1;
    if (right_fork_id == -1)
    {
        right_fork_id = PHILOSOPHERS-1;
    }
    
    
    struct sembuf sem_fork[2];
    //right fork 
    sem_fork[0].sem_num = right_fork_id; //semaphore number
    sem_fork[0].sem_op = -1; //for grabbing the fork
    sem_fork[0].sem_flg = 0; //operation flag

    //left work
    sem_fork[1].sem_num = left_fork_id;
    sem_fork[1].sem_op = -1;
    sem_fork[1].sem_flg = 0;

    //perform the operations over the sem_id semaphores
    semop(sem_id, sem_fork, 2);
    printf("Philosopher %i => GRABBING left fork %i and right fork %i \n",phil_name,left_fork_id,right_fork_id);
    
}

void put_away_forks(int left_fork_id){

    int right_fork_id = left_fork_id - 1;
    if (right_fork_id == -1)
    {
        right_fork_id = PHILOSOPHERS-1; //if left fork is zero, jump to last fork which is next to first fork
    }
    
    struct sembuf sem_fork[2];
    //right fork
    sem_fork[0].sem_num = right_fork_id;
    sem_fork[0].sem_op = 1; //for putting away the fork
    sem_fork[0].sem_flg = 0;

    //left fork
    sem_fork[1].sem_num = left_fork_id;
    sem_fork[1].sem_op = 1;
    sem_fork[1].sem_flg = 0;
    //perform the operations over the sem_id semaphores
    semop(sem_id, sem_fork, 2);
    printf("Philosopher %i => PUTTING AWAY left fork %i and right fork %i \n",phil_name,left_fork_id,right_fork_id);
    
}

void action(int name){
     
                    
    printf("Philosopher %i => thinking...\n",name);
    //sleep(2);
    //philosopher with certain id is grabbing the fork
    grab_forks(name);
    printf("Philosopher %i => eating.\n",name);
    //sleep(2);
    //printf("Philosopher %i ate portion %i.\n",name);
    //philosopher with certain id is putting away the fork
    put_away_forks(name);
    a=name;            




}