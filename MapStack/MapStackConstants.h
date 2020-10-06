

#define kMapStackRestrictedCharArray [NSArray arrayWithObjects: @"~", @"`", @"!", @"@", @"#", @"$", @"€", @"¥", @"£", @"₤", @"%", @"^", @"&", @"*", @"(", @")", @"-", @"+", @"=", @"<", @",", @">", @".", @"/", @"?", @":", @";", @"\"",@"'", @"{", @"[", @"}", @"]", @"\\", @"|", @"•", @"è", @"é", @"ê", @"ë", @"ē", @"ė", @"ę", @"ÿ", @"û", @"ü", @"ù", @"ú", @"ū", @"î", @"ï", @"í", @"ī", @"į", @"ì", @"ô", @"ö", @"ò", @"ó", @"œ", @"ø", @"ō", @"õ", @"à", @"á", @"â", @"ä", @"æ", @"ã", @"å", @"ā", @"ß", @"ś", @"š", @"ł", @"ž", @"ź", @"ż", @"ç", @"ć", @"č", @"ñ", @"ń", @"™", @"1º", @"1ª", @"2º", @"2ª", @"3º", @"3ª", @"4º", @"4ª", @"5º", @"5ª", @"6º", @"6ª", @"7º", @"7ª", @"8º", @"8ª", @"9ª", @"9º", @"0ª", @"0º", @"°", @"—", @"‘", @"’", @"¢", @"₩", @"§", @"«", @"»", @"„", @"“", @"”", @"…", @"¿", @"¡", @"£", @"∞", @"¶", @"ª", @"º", @"≠", @"–", @"‰", nil]

#define kMapStackColorArray [NSArray arrayWithObjects: [UIColor redColor], [UIColor blueColor], nil]

#define IS_PHONE_4 [[UIScreen mainScreen] bounds].size.height == 480
#define IS_PHONE_5 [[UIScreen mainScreen] bounds].size.height == 568
#define IS_PHONE_6 [[UIScreen mainScreen] bounds].size.height == 667
#define IS_PHONE_6Plus [[UIScreen mainScreen] bounds].size.height == 736

#define PHONE_4_HEIGHT 480
#define PHONE_5_HEIGHT 568
#define PHONE_6_HEIGHT 667
#define PHONE_6PLUS_HEIGHT 736
#define PHONE_4_WIDTH 320
#define PHONE_5_WIDTH 320
#define PHONE_6_WIDTH 375
#define PHONE_6PLUS_WIDTH 414

#define DEGREES_TO_RADIANS(x) (M_PI * x / 180.0)

#define kMapStackThemeColor ([UIColor colorWithRed:112/255.f green:168/255.f blue:196/255.f alpha:255/255.f])

#pragma mark - MapStackLocationKeys
extern NSString *const kMapStackLocationClassKey;
extern NSString *const kMapStackLocationTitle;
extern NSString *const kMapStackLocationDistance;


