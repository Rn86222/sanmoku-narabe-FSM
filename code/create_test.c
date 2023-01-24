#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int main(){
  FILE *fp;
  FILE *formatp;
  int first, second, third, fourth;
  char fname[1024];
  char fname_sv[1024];
  char format_name[30] = "./code/test_format.txt";
  char line[2048];
  printf("input tester file name (before \".sv\"): ");
  scanf("%s", fname);
  strcpy(fname_sv, fname);
  strcat(fname_sv, ".sv");
  printf("input FIRST: ");
  scanf("%d", &first);
  printf("input SECOND: ");
  scanf("%d", &second);
  printf("input THIRD: ");
  scanf("%d", &third);
  printf("input FOURTH: ");
  scanf("%d", &fourth);

  fp = fopen(fname_sv, "w");
  formatp = fopen(format_name, "r");

  fprintf(fp, "module %s;\n\n", fname);
  fprintf(fp, "\tlocalparam FIRST = %d;\n\tlocalparam SECOND = %d;\n\tlocalparam THIRD = %d;\n\tlocalparam FOURTH = %d;\n", first, second, third, fourth);

  while (fgets(line, 2048, formatp) != NULL)
    fprintf(fp, "%s", line);

  fclose(fp);
  fclose(formatp);

  char ans[1024];
  printf("create executable file by iverilog? [y/n]: ");
  scanf("%s", ans);
  if (strcmp(ans, "y") * strcmp(ans, "Y") == 0) {
    char cmd[1024];
    strcpy(cmd, "iverilog -Wall -g2012 ");
    strcat(cmd, fname_sv);
    strcat(cmd, " ./code/sanmoku.sv -o ");
    strcat(cmd, fname);
    system(cmd);
    printf("execute? [y/n]: ");
    scanf("%s", ans);
    if (strcmp(ans, "y") * strcmp(ans, "Y") == 0) {
      strcpy(cmd, "./");
      strcat(cmd, fname);
      system(cmd);
    }
  }
  return 0;
}