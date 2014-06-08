#include <errno.h>
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <linux/i2c-dev.h>
#include <sys/ioctl.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

void get_code (char * buf, const int len)
{
  int fd;
  char *filename = "/dev/i2c-1";
  const int addr = 0x42;

  if ((fd = open(filename, O_RDWR)) < 0)
    {
      perror("Failed to open the i2c bus");
      exit(1);
    }


  if (ioctl(fd, I2C_SLAVE, addr) < 0)
    {
      printf("Failed to acquire bus access and/or talk to slave.\n");
      close (fd);
      exit(1);
    }

  const char * cmd = "HI";

  if ((write(fd, cmd, strlen(cmd))) < 0)
    {
      perror ("Failed to write to device");
      close (fd);
      exit (1);
    }

  /* Wait for pin entry */
  sleep (10);

  if (read(fd,buf,len ) != len)
    {
      perror ("Failed to read from the i2c bus: %s.\n");
      printf("\n\n");
    }
  else
    {
      int x = 0;
      for (x = 0; x < len; x++)
        printf("%c", buf[x]);
      printf ("\n");
    }

  close (fd);

}
void main ()
{
  char buf[5] = {0};

  get_code (buf, sizeof(buf));
}
