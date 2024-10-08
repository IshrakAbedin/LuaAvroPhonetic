local avro = require("lib.avro")

local parser = avro.new(nil)
local failCount = 0
local passCount = 0
local failedCases = {}

function TEST_EQ(input, expected_output)
    local processed_input = parser:parse(input)
    if processed_input == expected_output then
        passCount = passCount + 1
    else
        failCount = failCount + 1
        failedCases[failCount] = { input = input, expected_output = expected_output, processed_input = processed_input }
    end
end

function PRINT_TEST_RESULTS()
    for i = 1, failCount do
        print(string.format("[%03d] Failed:\n\tReceived : %s\n\tProcessed: %s\n\tExpected : %s",
            i, failedCases[i].input, failedCases[i].processed_input, failedCases[i].expected_output)
        )
    end
    print(string.format("Test Summary: %d passed, %d failed", passCount, failCount))
end

-- Basic tests
TEST_EQ("bhl", "ভ্ল")
TEST_EQ("bj", "ব্জ")
TEST_EQ("bd", "ব্দ")
TEST_EQ("bb", "ব্ব")
TEST_EQ("bl", "ব্ল")
TEST_EQ("bh", "ভ")
TEST_EQ("vl", "ভ্ল")
TEST_EQ("b", "ব")
TEST_EQ("v", "ভ")
TEST_EQ("cNG", "চ্ঞ")
TEST_EQ("cch", "চ্ছ")
TEST_EQ("cc", "চ্চ")
TEST_EQ("ch", "ছ")
TEST_EQ("c", "চ")
TEST_EQ("dhn", "ধ্ন")
TEST_EQ("dhm", "ধ্ম")
TEST_EQ("dgh", "দ্ঘ")
TEST_EQ("ddh", "দ্ধ")
TEST_EQ("dbh", "দ্ভ")
TEST_EQ("dv", "দ্ভ")
TEST_EQ("dm", "দ্ম")
TEST_EQ("DD", "ড্ড")
TEST_EQ("Dh", "ঢ")
TEST_EQ("dh", "ধ")
TEST_EQ("dg", "দ্গ")
TEST_EQ("dd", "দ্দ")
TEST_EQ("D", "ড")
TEST_EQ("d", "দ")
TEST_EQ("...", "...")
TEST_EQ(".`", ".")
TEST_EQ("..", "।।")
TEST_EQ(".", "।")
TEST_EQ("ghn", "ঘ্ন")
TEST_EQ("Ghn", "ঘ্ন")
TEST_EQ("gdh", "গ্ধ")
TEST_EQ("gN", "গ্ণ")
TEST_EQ("GN", "গ্ণ")
TEST_EQ("gn", "গ্ন")
TEST_EQ("gm", "গ্ম")
TEST_EQ("Gm", "গ্ম")
TEST_EQ("gl", "গ্ল")
TEST_EQ("Gl", "গ্ল")
TEST_EQ("gg", "জ্ঞ")
TEST_EQ("GG", "জ্ঞ")
TEST_EQ("Gg", "জ্ঞ")
TEST_EQ("gG", "জ্ঞ")
TEST_EQ("gh", "ঘ")
TEST_EQ("Gh", "ঘ")
TEST_EQ("g", "গ")
TEST_EQ("hN", "হ্ণ")
TEST_EQ("hn", "হ্ন")
TEST_EQ("hm", "হ্ম")
TEST_EQ("hl", "হ্ল")
TEST_EQ("h", "হ")
TEST_EQ("jjh", "জ্ঝ")
TEST_EQ("jNG", "জ্ঞ")
TEST_EQ("jh", "ঝ")
TEST_EQ("jj", "জ্জ")
TEST_EQ("j", "জ")
TEST_EQ("J", "জ")
TEST_EQ("kkhN", "ক্ষ্ণ")
TEST_EQ("kShN", "ক্ষ্ণ")
TEST_EQ("kkhm", "ক্ষ্ম")
TEST_EQ("kShm", "ক্ষ্ম")
TEST_EQ("kxN", "ক্ষ্ণ")
TEST_EQ("kxm", "ক্ষ্ম")
TEST_EQ("kkh", "ক্ষ")
TEST_EQ("kSh", "ক্ষ")
TEST_EQ("ksh", "কশ")
TEST_EQ("kx", "ক্ষ")
TEST_EQ("kk", "ক্ক")
TEST_EQ("kT", "ক্ট")
TEST_EQ("kt", "ক্ত")
TEST_EQ("kl", "ক্ল")
TEST_EQ("ks", "ক্স")
TEST_EQ("kh", "খ")
TEST_EQ("k", "ক")
TEST_EQ("lbh", "ল্ভ")
TEST_EQ("ldh", "ল্ধ")
TEST_EQ("lkh", "লখ")
TEST_EQ("lgh", "লঘ")
TEST_EQ("lph", "লফ")
TEST_EQ("lk", "ল্ক")
TEST_EQ("lg", "ল্গ")
TEST_EQ("lT", "ল্ট")
TEST_EQ("lD", "ল্ড")
TEST_EQ("lp", "ল্প")
TEST_EQ("lv", "ল্ভ")
TEST_EQ("lm", "ল্ম")
TEST_EQ("ll", "ল্ল")
TEST_EQ("lb", "ল্ব")
TEST_EQ("l", "ল")
TEST_EQ("mth", "ম্থ")
TEST_EQ("mph", "ম্ফ")
TEST_EQ("mbh", "ম্ভ")
TEST_EQ("mpl", "মপ্ল")
TEST_EQ("mn", "ম্ন")
TEST_EQ("mp", "ম্প")
TEST_EQ("mv", "ম্ভ")
TEST_EQ("mm", "ম্ম")
TEST_EQ("ml", "ম্ল")
TEST_EQ("mb", "ম্ব")
TEST_EQ("mf", "ম্ফ")
TEST_EQ("m", "ম")
TEST_EQ("0", "০")
TEST_EQ("1", "১")
TEST_EQ("2", "২")
TEST_EQ("3", "৩")
TEST_EQ("4", "৪")
TEST_EQ("5", "৫")
TEST_EQ("6", "৬")
TEST_EQ("7", "৭")
TEST_EQ("8", "৮")
TEST_EQ("9", "৯")
TEST_EQ("NgkSh", "ঙ্ক্ষ")
TEST_EQ("Ngkkh", "ঙ্ক্ষ")
TEST_EQ("NGch", "ঞ্ছ")
TEST_EQ("Nggh", "ঙ্ঘ")
TEST_EQ("Ngkh", "ঙ্খ")
TEST_EQ("NGjh", "ঞ্ঝ")
TEST_EQ("ngOU", "ঙ্গৌ")
TEST_EQ("ngOI", "ঙ্গৈ")
TEST_EQ("Ngkx", "ঙ্ক্ষ")
TEST_EQ("NGc", "ঞ্চ")
TEST_EQ("nch", "ঞ্ছ")
TEST_EQ("njh", "ঞ্ঝ")
TEST_EQ("ngh", "ঙ্ঘ")
TEST_EQ("Ngk", "ঙ্ক")
TEST_EQ("Ngx", "ঙ্ষ")
TEST_EQ("Ngg", "ঙ্গ")
TEST_EQ("Ngm", "ঙ্ম")
TEST_EQ("NGj", "ঞ্জ")
TEST_EQ("ndh", "ন্ধ")
TEST_EQ("nTh", "ন্ঠ")
TEST_EQ("NTh", "ণ্ঠ")
TEST_EQ("nth", "ন্থ")
TEST_EQ("nkh", "ঙ্খ")
TEST_EQ("ngo", "ঙ্গ")
TEST_EQ("nga", "ঙ্গা")
TEST_EQ("ngi", "ঙ্গি")
TEST_EQ("ngI", "ঙ্গী")
TEST_EQ("ngu", "ঙ্গু")
TEST_EQ("ngU", "ঙ্গূ")
TEST_EQ("nge", "ঙ্গে")
TEST_EQ("ngO", "ঙ্গো")
TEST_EQ("NDh", "ণ্ঢ")
TEST_EQ("nsh", "নশ")
TEST_EQ("Ngr", "ঙর")
TEST_EQ("NGr", "ঞর")
TEST_EQ("ngr", "ংর")
TEST_EQ("nj", "ঞ্জ")
TEST_EQ("Ng", "ঙ")
TEST_EQ("NG", "ঞ")
TEST_EQ("nk", "ঙ্ক")
TEST_EQ("ng", "ং")
TEST_EQ("nn", "ন্ন")
TEST_EQ("NN", "ণ্ণ")
TEST_EQ("Nn", "ণ্ন")
TEST_EQ("nm", "ন্ম")
TEST_EQ("Nm", "ণ্ম")
TEST_EQ("nd", "ন্দ")
TEST_EQ("nT", "ন্ট")
TEST_EQ("NT", "ণ্ট")
TEST_EQ("nD", "ন্ড")
TEST_EQ("ND", "ণ্ড")
TEST_EQ("nt", "ন্ত")
TEST_EQ("ns", "ন্স")
TEST_EQ("nc", "ঞ্চ")
TEST_EQ("n", "ন")
TEST_EQ("N", "ণ")
TEST_EQ("OI`", "ৈ")
TEST_EQ("OU`", "ৌ")
TEST_EQ("O`", "ো")
TEST_EQ("OI", "ঐ")
TEST_EQ("kOI", "কৈ")
TEST_EQ(" OI", " ঐ")
TEST_EQ("(OI", "(ঐ")
TEST_EQ(".OI", "।ঐ")
TEST_EQ("OU", "ঔ")
TEST_EQ("kOU", "কৌ")
TEST_EQ(" OU", " ঔ")
TEST_EQ("-OU", "-ঔ")
TEST_EQ(",,OU", "্‌ঔ")
TEST_EQ("O", "ও")
TEST_EQ("pO", "পো")
TEST_EQ(" O", " ও")
TEST_EQ("iO", "ইও")
TEST_EQ("`O", "ও")
TEST_EQ("phl", "ফ্ল")
TEST_EQ("pT", "প্ট")
TEST_EQ("pt", "প্ত")
TEST_EQ("pn", "প্ন")
TEST_EQ("pp", "প্প")
TEST_EQ("pl", "প্ল")
TEST_EQ("ps", "প্স")
TEST_EQ("ph", "ফ")
TEST_EQ("fl", "ফ্ল")
TEST_EQ("f", "ফ")
TEST_EQ("p", "প")
TEST_EQ("rri`", "ৃ")
TEST_EQ("rri", "ঋ")
TEST_EQ("krri", "কৃ")
TEST_EQ("Irri", "ঈঋ")
TEST_EQ("^rri", "ঁঋ")
TEST_EQ(":rri", "ঃঋ")
TEST_EQ("rZ", "র‍্য")
TEST_EQ("krZ", "ক্র্য")
TEST_EQ("rrZ", "রর‍্য")
TEST_EQ("yrZ", "ইয়র‍্য")
TEST_EQ("wrZ", "ওর‍্য")
TEST_EQ("xrZ", "এক্সর‍্য")
TEST_EQ("irZ", "ইর‍্য")
TEST_EQ("-rZ", "-র‍্য")
TEST_EQ("rrrZ", "ররর‍্য")
TEST_EQ("ry", "র‍্য")
TEST_EQ("qry", "ক্র্য")
TEST_EQ("rry", "রর‍্য")
TEST_EQ("yry", "ইয়র‍্য")
TEST_EQ("wry", "ওর‍্য")
TEST_EQ("xry", "এক্সর‍্য")
TEST_EQ("0ry", "০র‍্য")
TEST_EQ("rrrry", "রররর‍্য")
TEST_EQ("Rry", "ড়্র্য")
TEST_EQ("rr", "রর")
TEST_EQ("arr", "আরর")
TEST_EQ("arrk", "আর্ক")
TEST_EQ("arra", "আররা")
TEST_EQ("arr", "আরর")
TEST_EQ("arr!", "আরর!")
TEST_EQ("krr", "ক্রর")
TEST_EQ("krra", "ক্ররা")
TEST_EQ("Rg", "ড়্গ")
TEST_EQ("Rh", "ঢ়")
TEST_EQ("R", "ড়")
TEST_EQ("r", "র")
TEST_EQ("or", "অর")
TEST_EQ("mr", "ম্র")
TEST_EQ("1r", "১র")
TEST_EQ("+r", "+র")
TEST_EQ("rr", "রর")
TEST_EQ("yr", "ইয়র")
TEST_EQ("wr", "ওর")
TEST_EQ("xr", "এক্সর")
TEST_EQ("zr", "য্র")
TEST_EQ("mri", "ম্রি")
TEST_EQ("shch", "শ্ছ")
TEST_EQ("ShTh", "ষ্ঠ")
TEST_EQ("Shph", "ষ্ফ")
TEST_EQ("Sch", "শ্ছ")
TEST_EQ("skl", "স্ক্ল")
TEST_EQ("skh", "স্খ")
TEST_EQ("sth", "স্থ")
TEST_EQ("sph", "স্ফ")
TEST_EQ("shc", "শ্চ")
TEST_EQ("sht", "শ্ত")
TEST_EQ("shn", "শ্ন")
TEST_EQ("shm", "শ্ম")
TEST_EQ("shl", "শ্ল")
TEST_EQ("Shk", "ষ্ক")
TEST_EQ("ShT", "ষ্ট")
TEST_EQ("ShN", "ষ্ণ")
TEST_EQ("Shp", "ষ্প")
TEST_EQ("Shf", "ষ্ফ")
TEST_EQ("Shm", "ষ্ম")
TEST_EQ("spl", "স্প্ল")
TEST_EQ("sk", "স্ক")
TEST_EQ("Sc", "শ্চ")
TEST_EQ("sT", "স্ট")
TEST_EQ("st", "স্ত")
TEST_EQ("sn", "স্ন")
TEST_EQ("sp", "স্প")
TEST_EQ("sf", "স্ফ")
TEST_EQ("sm", "স্ম")
TEST_EQ("sl", "স্ল")
TEST_EQ("sh", "শ")
TEST_EQ("Sc", "শ্চ")
TEST_EQ("St", "শ্ত")
TEST_EQ("Sn", "শ্ন")
TEST_EQ("Sm", "শ্ম")
TEST_EQ("Sl", "শ্ল")
TEST_EQ("Sh", "ষ")
TEST_EQ("s", "স")
TEST_EQ("S", "শ")
TEST_EQ("oo", "উ")
TEST_EQ("OO", "ওও")
TEST_EQ("oo`", "ু")
TEST_EQ("koo", "কু")
TEST_EQ("ooo", "উঅ")
TEST_EQ("!oo", "!উ")
TEST_EQ("!ooo", "!উঅ")
TEST_EQ("aoo", "আউ")
TEST_EQ("oop", "উপ")
TEST_EQ("ooo`", "উ")
TEST_EQ("o`", "")
TEST_EQ("oZ", "অ্য")
TEST_EQ("oY", "অয়")
TEST_EQ("o", "অ")
TEST_EQ("!o", "!অ")
TEST_EQ("^o", "ঁঅ")
TEST_EQ("*o", "*অ")
TEST_EQ("io", "ইও")
TEST_EQ("yo", "ইয়")
TEST_EQ("no", "ন")
TEST_EQ("tth", "ত্থ")
TEST_EQ("t``", "ৎ")
TEST_EQ("`t``", "ৎ")
TEST_EQ("t``t``", "ৎৎ")
TEST_EQ("t```", "ৎ")
TEST_EQ("TT", "ট্ট")
TEST_EQ("Tm", "ট্ম")
TEST_EQ("Th", "ঠ")
TEST_EQ("tn", "ত্ন")
TEST_EQ("tm", "ত্ম")
TEST_EQ("th", "থ")
TEST_EQ("tt", "ত্ত")
TEST_EQ("T", "ট")
TEST_EQ("t", "ত")
TEST_EQ("aZ", "অ্যা")
TEST_EQ("aaZ", "আঅ্যা")
TEST_EQ("AZ", "অ্যা")
TEST_EQ("a`", "া")
TEST_EQ("a``", "া")
TEST_EQ("ka`", "কা")
TEST_EQ("A`", "া")
TEST_EQ("a", "আ")
TEST_EQ("`a", "আ")
TEST_EQ("k`a", "কআ")
TEST_EQ("ia", "ইয়া")
TEST_EQ("aaaa`", "আআআা")
TEST_EQ("i`", "ি")
TEST_EQ("i", "ই")
TEST_EQ("`i", "ই")
TEST_EQ("hi", "হি")
TEST_EQ("ih", "ইহ")
TEST_EQ("i`h", "িহ")
TEST_EQ("I`", "ী")
TEST_EQ("I", "ঈ")
TEST_EQ("cI", "চী")
TEST_EQ("Ix", "ঈক্স")
TEST_EQ("II", "ঈঈ")
TEST_EQ("0I", "০ঈ")
TEST_EQ("oI", "অঈ")
TEST_EQ("u`", "ু")
TEST_EQ("u", "উ")
TEST_EQ("ku", "কু")
TEST_EQ("uk", "উক")
TEST_EQ("uu", "উউ")
TEST_EQ("iu", "ইউ")
TEST_EQ("&u", "&উ")
TEST_EQ("u&", "উ&")
TEST_EQ("U`", "ূ")
TEST_EQ("U", "ঊ")
TEST_EQ("yU", "ইয়ূ")
TEST_EQ("Uy", "ঊয়")
TEST_EQ("^U", "ঁঊ")
TEST_EQ("U^", "ঊঁ")
TEST_EQ("EE", "ঈ")
TEST_EQ("ee", "ঈ")
TEST_EQ("Ee", "ঈ")
TEST_EQ("eE", "ঈ")
TEST_EQ("ee`", "ী")
TEST_EQ("kee", "কী")
TEST_EQ("eek", "ঈক")
TEST_EQ("0ee", "০ঈ")
TEST_EQ("ee8", "ঈ৮")
TEST_EQ("(ee)", "(ঈ)")
TEST_EQ("e`", "ে")
TEST_EQ("e", "এ")
TEST_EQ("ke", "কে")
TEST_EQ("we", "ওয়ে")
TEST_EQ("#e#", "#এ#")
TEST_EQ("`e`", "ে")
TEST_EQ("z", "য")
TEST_EQ("Z", "্য")
TEST_EQ("rZ", "র‍্য")
TEST_EQ("kZS", "ক্যশ")
TEST_EQ("y", "ইয়")
TEST_EQ("oy", "অয়")
TEST_EQ("ky", "ক্য")
TEST_EQ("ya", "ইয়া")
TEST_EQ("yaa", "ইয়াআ")
TEST_EQ("Y", "য়")
TEST_EQ("YY", "য়য়")
TEST_EQ("iY", "ইয়")
TEST_EQ("kY", "কয়")
TEST_EQ("q", "ক")
TEST_EQ("Q", "ক")
TEST_EQ("w", "ও")
TEST_EQ("wa", "ওয়া")
TEST_EQ("-wa-", "-ওয়া-")
TEST_EQ("woo", "ওয়ু")
TEST_EQ("wre", "ওরে")
TEST_EQ("kw", "ক্ব")
TEST_EQ("x", "এক্স")
TEST_EQ("ex", "এক্স")
TEST_EQ("bx", "বক্স")
TEST_EQ(":`", ":")
TEST_EQ(":", "ঃ")
TEST_EQ("^`", "^")
TEST_EQ("^", "ঁ")
TEST_EQ("k^", "কঁ")
TEST_EQ("k^i", "কঁই")
TEST_EQ("ki^", "কিঁ")
TEST_EQ(",,", "্‌")
TEST_EQ(",,,", "্‌,")
TEST_EQ(",,`,", "্‌,")
TEST_EQ("`,,", "্‌")
TEST_EQ(",`,", ",,")
TEST_EQ("$", "৳")
TEST_EQ("`", "")
TEST_EQ("bdh", "ব্ধ")

-- Punctuation invariability tests
TEST_EQ("!", "!")
TEST_EQ("?@", "?@")

-- Sentence tests
TEST_EQ("ami banglay gan gai", "আমি বাংলায় গান গাই")
TEST_EQ("amader valObasa hoye gel ghas, kheye gel goru ar diye gelo ba^sh",
    "আমাদের ভালোবাসা হয়ে গেল ঘাস, খেয়ে গেল গরু আর দিয়ে গেল বাঁশ")

PRINT_TEST_RESULTS()

os.exit(failCount)
