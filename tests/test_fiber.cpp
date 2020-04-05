#include <gtest/gtest.h>
#include <boost/fiber/all.hpp>

class FiberTest : public ::testing::Test {
protected:
    FiberTest() {}
    virtual ~FiberTest() {}
    virtual void SetUp() {}
    virtual void TearDown() {}
};

TEST_F(FiberTest, Initialization)
{
    auto fn = [](std::string const& str, int n){
        for(int i=0;i<n;i++) {
            std::cout << i << ": " << str << std::endl;
            boost::this_fiber::yield();
        }
    };
    boost::fibers::fiber f1( std::bind(fn, "abc", 5) );
    boost::fibers::fiber f2( std::bind(fn, "xyz", 7) );
    f1.join();
    f2.join();
}
