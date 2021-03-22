#
# Create a HTPASSWD containing x number of users based on an user input
# and set default password
# 
# @author Bryant Son
# @since  03/21/21
#
 
#!/bin/bash


# Set Beginning Index:
counter=1

# Print out a message for user to get the file name:
echo "What is the name of file that we are going to save?"

# Set the HTPASSWD file name:
read fileName

# Check if file exists already. If it does, delete it:
if test -f "./$fileName"; then
  echo "File named $fileName exists already. We need to delete it."
  rm ./$fileName
else
  echo "Lucky! We don't already have a file named $fileName. We will just create a new one"
fi

# Print out a message for user:
echo "How many users do we need to create?"

# Read from an user:
read maxUser

# Ask for a default password:
echo "Lastly, what is the default password you are going to set for users?"

# Set the default password:
read defaultPassword

# Create "maxUser" number of users and store into HTPASSWD file:
while [ $counter -le $maxUser ]
do
  echo "Creating user$counter"
 
  # Each user name will be in a format of "user" followed by a number:
  user="user"
  user+=$counter
 
  # If it is for a first user, just create a new file. Later, just append new user's credential to the file:
  if [ $counter == 1 ]; then
    htpasswd -c -B -b ./${fileName} ${user} ${defaultPassword}
  else
    htpasswd -B -b ./${fileName} ${user} ${defaultPassword}
  fi

  ((counter ++))
done

echo "All done. Your HTPASSWD file is available at $fileName"
