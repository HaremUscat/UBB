#define _CRTDBG_MAP_ALLOC
#include <cassert>
#include "UI.h"
using namespace std;


void testDog() {
	Dog g{ "labrador", "gabi", 5, "slygabidasmaname" };
	assert(g.getBreed() == "labrador");
}

void testValidator() {
	Dog g{ "", "gabi", 5, "slygabidasmaname" };
	try {
		ValidatorDog::validateDog(g);
	}
	catch (const ValidationException& ex) {
		assert(ex.getMsg() == "Incorrect breed\n");
	}
}

void testRepo() {
	Dog g{ "gigi","gg",23,"bella" };
	Dog gg{ "geegee","gg",23,"bella" };
	assert(g == gg);

	try {
		Repo<Dog> repo;
		repo.add(g);
		repo.add(gg);
	}
	catch (const RepoException& ex) {
		assert(ex.getMsg() == "iezicsta deja!\n");
	}
}

void testService() {
	Dog g{ "gigi","gg",23,"bella" };
	Dog gg{ "geegee","gg",23,"bella" };
	assert(g == gg);
	try {
		Repo<Dog> repo;
		repo.add(g);

		repo.add(gg);
		Service ctrl{ repo };
		ctrl.addDog("", "gg", 23, "bella");
	}
	catch (const RepoException& ex) {
		assert(ex.getMsg() == "iezicsta deja!\n");
	}
	catch (const ValidationException& ex) {
		assert(ex.getMsg() == "n-are rasa bun\n");
	}
}

void tests()
{
	testDog();
	testValidator();
	testRepo();
	testService();
}

void Initialize(Repo<Dog>& repo) {
	Dog g{ "gigi","gg",23,"bella" };
	Dog gg{ "geegee","ggg",23,"bella" };

	repo.add(g);
	repo.add(gg);
}

int main()
{
	{
		tests();
		Repo<Dog> repo{};
		Initialize(repo);
		Service ctrl{ repo };
		UI ui{ ctrl };
		ui.runApplication();
		system("pause");
	}
	_CrtDumpMemoryLeaks();
	return 0;
}

