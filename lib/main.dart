import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyAppThemeConfig{
  static const String faPrimaryFontFamily = 'Vazir';
  final Color primaryColor = Colors.pink.shade400;
  final Color primaryTextColor;
  final Color secondaryTextColor;
  final Color surfaceColor;
  final Color backgroundColor;
  final Color appBarColor;
  final Brightness brightness;

  MyAppThemeConfig(this.primaryTextColor, this.secondaryTextColor, this.surfaceColor, this.backgroundColor, this.appBarColor, this.brightness,);

  MyAppThemeConfig.dark()
      : primaryTextColor = Colors.white,
        secondaryTextColor = Colors.white70,
        surfaceColor = Color(0x0dffffff),
        backgroundColor = Color.fromARGB(255, 30, 30, 30),
        appBarColor = Colors.black,
        brightness = Brightness.dark;

  MyAppThemeConfig.light()
      : primaryTextColor = Colors.grey.shade900,
        secondaryTextColor = Colors.grey.shade900.withOpacity(0.8),
        surfaceColor = Color(0x0d000000),
        backgroundColor = Colors.white,
        appBarColor = Color.fromARGB(255, 235, 235, 235),
        brightness = Brightness.light;

  ThemeData getTheme(String LanguageCode){
    return ThemeData(
      brightness: brightness,
      primarySwatch: Colors.cyan,
      primaryColor: Colors.purple,
      dividerTheme: DividerThemeData(color: Colors.white12, indent: 12,endIndent: 12),
      scaffoldBackgroundColor: backgroundColor,
      appBarTheme: AppBarTheme(backgroundColor: appBarColor),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: surfaceColor,
      ),
      useMaterial3: true,
      textTheme: LanguageCode=='en' ? enPrimaryTextTheme : faPrimaryTextTheme,
    );

  }

  TextTheme get enPrimaryTextTheme =>GoogleFonts.latoTextTheme(
      TextTheme(
          bodyMedium: TextStyle(fontSize: 18),
          bodyLarge: TextStyle(fontSize: 14),
          titleLarge: TextStyle(fontWeight: FontWeight.bold)
      )
  );
  TextTheme get faPrimaryTextTheme => TextTheme(
      bodyMedium: TextStyle(fontSize: 17, fontFamily: faPrimaryFontFamily),
      bodySmall: TextStyle(fontSize: 16, fontFamily: faPrimaryFontFamily),
      bodyLarge: TextStyle(fontSize: 12, fontFamily: faPrimaryFontFamily),
      titleLarge: TextStyle(fontWeight: FontWeight.bold, fontFamily: faPrimaryFontFamily)

  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});



  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = Locale('en');
  ThemeMode themeMode = ThemeMode.dark;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      locale: _locale,
      theme: themeMode == ThemeMode.dark
          ? MyAppThemeConfig.dark().getTheme(_locale.languageCode)
          : MyAppThemeConfig.light().getTheme(_locale.languageCode),
      home:  MyHomePage(toggleThemeMode: (){
        setState(() {
          if (themeMode == ThemeMode.dark) themeMode= ThemeMode.light;
          else
            themeMode = ThemeMode.dark;
        });
      },
        selectedLanguageChanged: (_Language newSelectedLanguageByUser) {
        setState(() {
          _locale = newSelectedLanguageByUser == _Language.en ? Locale('en'):Locale('fa');
        });
      },
      ),
    );
  }
}



class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.toggleThemeMode, required this.selectedLanguageChanged, });

  final Function() toggleThemeMode;
  final Function(_Language language) selectedLanguageChanged;


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

enum _SkillType{
  photoShop,lightRoom,afterEffect, illustrator,adobeXD,
}
enum _Language{
  en,fa,
}

class _MyHomePageState extends State<MyHomePage> {


  _Language _language = _Language.en;


  _SkillType _skill = _SkillType.photoShop;
  void updateSelectedSkill(_SkillType skillType){
    setState(() {
      this._skill = skillType;
    });
  }
  void _updateSelectedLanguage(_Language language){
    widget.selectedLanguageChanged(language);
    setState(() {
      _language=language;
    });
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(localization.profileTitle),
          actions: [
            Icon(CupertinoIcons.chat_bubble),
            SizedBox(width: 8,),
            InkWell(
                onTap: widget.toggleThemeMode,
                child: Icon(CupertinoIcons.ellipsis_vertical)
            ),
          ],
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset('assets/images/profile_image.png',
                        width: 100,
                      ),
                    ),
                    SizedBox(width: 20,),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(localization.name, style: Theme.of(context).textTheme.titleLarge,),
                          Text(localization.job, style: Theme.of(context).textTheme.bodyMedium),
                          SizedBox(height: 20,),
                          Row(
                            children: [
                              Icon(CupertinoIcons.location),
                              SizedBox(width: 10,),
                              Text(localization.location)
                            ],
                          ),
                        ],
                      ),
                    ),
                    Icon(CupertinoIcons.heart, color: Theme.of(context).primaryColor),
                  ],
                ),
                SizedBox(height: 32,),
                Text(localization.summary,
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 16,
                  ),
                ),
                SizedBox(height: 10,),
                Divider(),
                Padding(
                  padding:  EdgeInsets.only(top: 20.0, bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(localization.selectedLanguage),
                      CupertinoSlidingSegmentedControl<_Language>(
                        groupValue: _language,
                        thumbColor: Theme.of(context).colorScheme.primary,
                        children: {
                          _Language.en:Text(localization.enLanguage, style: TextStyle(fontSize: 16),),
                          _Language.fa:Text(localization.faLanguage, style: TextStyle(fontSize: 16),),
                        },
                        onValueChanged: (value) => _updateSelectedLanguage(value!),
                      ),
                    ],
                  ),
                ),
                Divider(),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Text(localization.skills,style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(width: 10,),
                    Icon(CupertinoIcons.chevron_down, size: 15,),

                  ],
                ),
                SizedBox(height: 22,),
                Center(
                  child: Wrap(
                    direction: Axis.horizontal,
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      Skill(
                        onTap: (){
                          updateSelectedSkill(_SkillType.photoShop);
                        },
                        type: _SkillType.photoShop,
                        title: 'PhotoShop',
                        imagePath: 'assets/images/app_icon_01.png',
                        shadowColor: Colors.white24,
                        isActive: _skill == _SkillType.photoShop,
                      ),
                      Skill(
                        onTap: (){
                          updateSelectedSkill(_SkillType.lightRoom);
                        },
                        type: _SkillType.lightRoom,
                        title: 'LightRoom',
                        imagePath: 'assets/images/app_icon_02.png',
                        shadowColor: Colors.white24,
                        isActive: _skill == _SkillType.lightRoom,
                      ),
                      Skill(
                        onTap: (){
                          updateSelectedSkill(_SkillType.afterEffect);
                        },
                        type: _SkillType.afterEffect,
                        title: 'AfterEffect',
                        imagePath: 'assets/images/app_icon_03.png',
                        shadowColor: Colors.white24,
                        isActive: _skill == _SkillType.afterEffect,
                      ),
                      Skill(
                        onTap: (){
                          updateSelectedSkill(_SkillType.illustrator);
                        },
                        type: _SkillType.illustrator,
                        title: 'Illustrator',
                        imagePath: 'assets/images/app_icon_04.png',
                        shadowColor: Colors.white24,
                        isActive: _skill == _SkillType.illustrator,
                      ),
                      Skill(
                        onTap: (){
                          updateSelectedSkill(_SkillType.adobeXD);
                        },
                        type: _SkillType.adobeXD,
                        title: 'AdobeXD',
                        imagePath: 'assets/images/app_icon_05.png',
                        shadowColor: Colors.white24,
                        isActive: _skill == _SkillType.adobeXD,
                      ),


                    ],
                  ),
                ),
                Divider(),
                SizedBox(height: 10,),
                Text(localization.personalInformation, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20,),
                TextField(
                  decoration: InputDecoration(
                    labelText: localization.email,
                    labelStyle: TextStyle(fontSize: 16, ),
                    prefixIcon: Icon(CupertinoIcons.at, ),
                  ),
                ),
                SizedBox(height: 10,),
                TextField(
                  decoration: InputDecoration(
                    labelText: localization.password,
                    labelStyle: TextStyle(fontSize: 16,),
                    prefixIcon: Icon(CupertinoIcons.lock ),
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                    width: double.infinity,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                        child: Text(localization.done, style: TextStyle(color: Colors.white),))
                ),


              ],
            ),
          ),
        )
    );
  }
}

class Skill extends StatelessWidget {
  final _SkillType type;
  final String title;
  final String imagePath;
  final Color shadowColor;
  final bool isActive;
  final Function() onTap;

  const Skill({super.key, required this.title, required this.imagePath, required this.shadowColor, required this.isActive, required this.type, required this.onTap,  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      child: Container(
        width: 100,
        height: 100,
        decoration: isActive ? BoxDecoration(
            color: Colors.white.withOpacity(0.1) ,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: shadowColor,
                blurRadius: 20,
              )
            ]
        ) : null,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imagePath, width: 50,height: 50,),
            SizedBox(height: 6,),
            Text(title)

          ],
        ),
      ),
    );
  }
}
