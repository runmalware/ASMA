# ASMA
ASMA is an acronym for Automated Static Malware Analysis.

    _   ___ __  __   _   
   /_\ / __|  \/  | /_\  
  / _ \\__ \ |\/| |/ _ \ 
 /_/ \_\___/_|  |_/_/ \_\

### **STP : Situation > Target > Proposal** ###
**Situation**
- Ideas for quick tasks to automate static malware analysis.
- Public sandbox? Sometimes we need to analyze private files, personal files, or files created by malware developers.
- Reduce the time required to execute commands on REMnux.

**Target**
- Simple text-style single file report from many tools installed in REMnux.

**Proposal**
- Create a single Linux shell script. This is the reason for creating this repo.
- Open for contributions.

## focusing tool lists on REMnux. ##
- file
- strings
- pev 
- exiftool 
- yara 
- sha3sum

Contributor can add more up on your idea.


### **How to use script** ###
1. Make sure your REMnux connected to internet
2. Ensure you replace /path/to/virustotal/yara/rules/* with the actual path to your YARA rules from the VirusTotal repository.
2. open terminal and command 
> wget -O https://github.com/runmalware/ASMA/asma.sh
3. chmod +x asma.sh
4. following script instruction



