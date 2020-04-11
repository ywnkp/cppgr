#include <gtest/gtest.h>

class StubTest : public ::testing::Test {
protected:
    StubTest() {}
    virtual ~StubTest() {}
    virtual void SetUp() {}
    virtual void TearDown() {}
};

TEST_F(StubTest, Initialization)
{
}
