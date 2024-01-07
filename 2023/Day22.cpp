#pragma once
#include <cassert>
#include <sstream>
#include <Windows.h>
#include "Day22.h"

int Day22::calculatePuzzle1(std::vector<std::string> input) {
	int answer = 0;

	return answer;
}

int Day22::calculatePuzzle2(std::vector<std::string> input) {
	int answer = 0;

	return answer;
}

void Day22::puzzle1() {
	std::vector<std::string> input = Reader::readFile(puzzleFile);
	std::cout << "First puzzle: " << calculatePuzzle1(input) << std::endl;
}

void Day22::puzzle2() {
	std::vector<std::string> input = Reader::readFile(puzzleFile);
	std::cout << "Second puzzle: " << calculatePuzzle2(input) << std::endl;
}

void Day22::test() {
	HANDLE h = GetStdHandle(STD_OUTPUT_HANDLE);
	SetConsoleTextAttribute(h, 4);
	assert(calculatePuzzle1(Reader::readFile(testFile1)) == 0);
	SetConsoleTextAttribute(h, 2);
	std::cout << "Day 22 part 1 test passed" << std::endl;
	SetConsoleTextAttribute(h, 7);
	SetConsoleTextAttribute(h, 4);
	assert(calculatePuzzle2(Reader::readFile(testFile2)) == 0);
	SetConsoleTextAttribute(h, 2);
	std::cout << "Day 22 part 2 test passed" << std::endl;
	SetConsoleTextAttribute(h, 7);
}