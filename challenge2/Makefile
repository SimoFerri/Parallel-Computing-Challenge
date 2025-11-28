CXX = g++
CXXFLAGS += -fopenmp -O1

TARGET = life_wout_death
PROFILE_TARGET = profile_life_wout_death
SRCS = life_wout_death.cpp

all:
	$(CXX) $(SRCS) $(CXXFLAGS) -o $(TARGET)

profile:
	$(CXX) $(SRCS) $(CXXFLAGS) -pg -o $(PROFILE_TARGET)

