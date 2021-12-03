#include <stdio.h>
#include <stdlib.h>


int main() {
  FILE *fp = fopen("input", "r");
  if (fp == NULL) {
    exit(1);
  }
  char *buffer;
  size_t len = 0;
  size_t read = 0;
  int prv = -1, prv2 = -1, actual = 0, res = 0, prv_s = -1;
  getline(&buffer, &len, fp);
  prv2 = atoi(buffer);
  getline(&buffer, &len, fp);
  prv = atoi(buffer);
  getline(&buffer, &len, fp);
  actual = atoi(buffer);
  while ((read = getline(&buffer, &len, fp)) != -1) {
    prv2 = prv;
    prv = actual;
    actual = atoi(buffer);
    if (prv2 + prv + actual > prv_s) {
      res++;
    }
    prv_s = prv2 + prv + actual;

  }
  printf("res %d\n", res);
  fclose(fp);
}
