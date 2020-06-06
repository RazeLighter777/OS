//kernel entry point
void main() {
	while (1) {
		*(char*) 0xb8000 = (int)(*(char*)0xb8000)+1;
	}
	return;
}
