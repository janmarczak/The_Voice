# The_Voice
Implementation of a relational schema in SQL based on provided requirements with queries

## Requirements:
* A television channel has decided to create a simple database to register payment information about its most successful show ‘TheVoiceLondon’.
In this show, there are contenders that compete to represent the UK in Eurovision.
* These contenders are coached by famous artists (namely the coaches). Contenders can be formed by a group of participants or a single participant. Both coaches and participants are paid based on the number of shows they attend.
* For each coach and participant, the database stores their id, name, surname, date of birth, phone, gender and daily salary.
* For each contender, the database stores its id, type (group or individual), stage name, its coach and the participants forming that contender. Each contender should have at least one participant.
* For each show, the database stores its date, start time, end time and a location if the show does not take place in the television studio.
* Finally, the database also registers which coaches and contenders attended each show.
* If a coach decides to leave the program, then their personal and attendance information must be deleted from the database and any contenders they coach need to be assigned a replacement coach.

The following relational schema contains the database model for this TV show.

<img width="958" alt="Screenshot 2021-05-31 at 11 45 04" src="https://user-images.githubusercontent.com/60696500/120181957-a8599400-c205-11eb-82a2-9e0ed25e689c.png">
