#include<iostream>
#include<stdio.h>

using namespace std;

int main()
{
	cout << "enter filename( X or Y or Z ) space mode(r or w)" << endl;

	string filename;
	string mode;
	cin >> filename;
	cin >> mode;

	cout << "filename = " << filename << " mode = " << mode << endl;

	if( mode == "r" )
	{
		FILE* file;
		file = fopen(filename.c_str(), "r");
		if( file == NULL )
		{
			cout << "You do not have permission to read this file" << endl;
			return 0;
		}
		char str[10];
		fread(str, 8, 1, file);
		cout << filename << " has the content: " << str << endl;
		fclose(file);
	}
	else if( mode == "w" )
	{
		FILE* file;
		file = fopen(filename.c_str(), "w");
		if( file == NULL )
		{
			cout << "You do not have permission to write to this file" << endl;
			return 0;
		}
		string str;
		cout << "enter the value" << endl;
		cin >> str;
		fwrite(str.c_str(), 1, str.length(), file);
		fclose(file);
	}
}
