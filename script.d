syscall::open:entry
/copyinstr(arg0) == "X.txt" || copyinstr(arg0) == "Y.txt" || copyinstr(arg0) == "Z.txt"/
{
	filename = copyinstr(arg0);
	printf("\n%s is opened by the user %d\n", copyinstr(arg0),uid);
}

syscall::open:return
/filename == "X.txt" || filename == "Y.txt" || filename == "Z.txt"/
{

	fd = arg0;
	printf("\nOpen call returned the fd = %d\n", arg0);
	b = 1
}

syscall::read:entry
/execname == "a.out" && b == 1 && arg0 == fd/
{
	printf("\nRead is called with the following arguments fd = %d, bufpointer = %d, size = %d\n", arg0, arg1, arg2);
	c = 1
}

syscall::read:return
/execname == "a.out" && b == 1 && c == 1/
{
	printf("\nRead returned the number of bytes read = %d\n", arg0);
	c = 0
}
syscall::write:entry
/execname == "a.out" && b == 1 && arg0 == fd/
{
	printf("\nWrite is called with the following arguments fd = %d, bufpointer = %d, size = %d\n", arg0, arg1, arg2);
	d = 1
}

syscall::write:return
/execname == "a.out" && b == 1 && d == 1/
{
	printf("\nWrite returned the number of bytes written = %d\n", arg0);
	d = 0
}

syscall::close:entry
/execname == "a.out" && b == 1/
{
	printf("\nClose is called with the following fd = %d\n", arg0);
}

syscall::close:return
/execname == "a.out" && b == 1/
{
	printf("\nClose returned with the following: %d\n", arg0);
}

proc:::exec
{
	printf("\nNew process is called by user %d\n", uid);
}

proc:::exit
{
	printf("\n%s process is exited with return value = %d\n", execname, arg0);
}

proc:::exec-success
{
	printf("\n%s process is successfully started\n",execname);
}

proc:::exec-failure
{
	printf("\nthe process is failed to start\n");
}
