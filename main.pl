% ===============================
%      MAIN KNOWLEDGE BASE       
% ===============================

% Caricamento dei fatti
:- consult('facts continues_features\\laptop_continuous_features_fixed.pl').
:- consult('facts brand_name\\laptop_brand_acer_adjusted.pl').
:- consult('facts brand_name\\laptop_brand_apple_adjusted.pl').
:- consult('facts brand_name\\laptop_brand_asus_adjusted.pl').
:- consult('facts brand_name\\laptop_brand_chuwi_adjusted.pl').
:- consult('facts brand_name\\laptop_brand_dell_adjusted.pl').
:- consult('facts brand_name\\laptop_brand_fujitsu_adjusted.pl').
:- consult('facts brand_name\\laptop_brand_google_adjusted.pl').
:- consult('facts brand_name\\laptop_brand_hp_adjusted.pl').
:- consult('facts brand_name\\laptop_brand_huawei_adjusted.pl').
:- consult('facts brand_name\\laptop_brand_lg_updated.pl').
:- consult('facts brand_name\\laptop_brand_lenovo_updated.pl').
:- consult('facts brand_name\\laptop_brand_msi_updated.pl').
:- consult('facts brand_name\\laptop_brand_mediacom_updated.pl').
:- consult('facts brand_name\\laptop_brand_microsoft_updated.pl').
:- consult('facts brand_name\\laptop_brand_razer_updated.pl').
:- consult('facts brand_name\\laptop_brand_samsung_updated.pl').
:- consult('facts brand_name\\laptop_brand_toshiba_updated.pl').
:- consult('facts brand_name\\laptop_brand_vero_updated.pl').
:- consult('facts brand_name\\laptop_brand_xiaomi_updated.pl').
:- consult('facts type_name\\laptop_type_is_2_in1_convertible_updated.pl').
:- consult('facts type_name\\laptop_type_is_gaming_updated.pl').
:- consult('facts type_name\\laptop_type_is_netbook_updated.pl').
:- consult('facts type_name\\laptop_type_is_notebook_updated.pl').
:- consult('facts type_name\\laptop_type_is_ultrabook_updated.pl').
:- consult('facts type_name\\laptop_type_is_workstation_updated.pl').
:- consult('facts cpu_brand\\laptop_cpu_is_amd_cpu_corrected.pl').
:- consult('facts cpu_brand\\laptop_cpu_is_intel_cpu_corrected.pl').
:- consult('facts cpu_brand\\laptop_cpu_is_samsung_cpu_corrected.pl').
:- consult('facts gpu_brand\\laptop_gpu_is_amd_gpu_updated.pl').
:- consult('facts gpu_brand\\laptop_gpu_is_arm_gpu_updated.pl').
:- consult('facts gpu_brand\\laptop_gpu_is_intel_gpu_updated.pl').
:- consult('facts gpu_brand\\laptop_gpu_is_nvidia_gpu_updated.pl').
:- consult('facts memory_type\\laptop_memory_is_memory_flash_updated.pl').
:- consult('facts memory_type\\laptop_memory_is_memory_hdd_updated.pl').
:- consult('facts memory_type\\laptop_memory_is_memory_hybrid_updated.pl').
:- consult('facts memory_type\\laptop_memory_is_memory_ssd_updated.pl').
:- consult('facts opsys_name\\laptop_opsys_is_android_updated.pl').
:- consult('facts opsys_name\\laptop_opsys_is_chrome_os_updated.pl').
:- consult('facts opsys_name\\laptop_opsys_is_linux_updated.pl').
:- consult('facts opsys_name\\laptop_opsys_is_mac_os_x_updated.pl').
:- consult('facts opsys_name\\laptop_opsys_is_no_os_updated.pl').
:- consult('facts opsys_name\\laptop_opsys_is_windows_10_updated.pl').
:- consult('facts opsys_name\\laptop_opsys_is_windows_10_s_updated.pl').
:- consult('facts opsys_name\\laptop_opsys_is_windows_7_updated.pl').
:- consult('facts opsys_name\\laptop_opsys_is_macos_updated.pl').
% ---- Fine del caricamento dei fatti ----

% ---- Regole di Categorizzazione ----
    
is_low_cost_warning(ID) :-
    laptop(ID, Inches, _, Ram, Price, _, _, CPUFrequency, _),
    Price < 400,
    is_memory_hdd(ID, 1),
    (Ram =< 4 ; Inches =< 13.5 ; CPUFrequency =< 1.8).

is_mid_range(ID) :-
    laptop(ID, _, _, _, Price, _, _, _, _),
    Price >= 400,
    Price =< 1500.

is_high_end(ID) :-
    laptop(ID, _, _, _, Price, _, _, _, _),
    Price > 1500,
    Price =< 3000.

is_worth_premium(ID) :-
    laptop(ID, _, Ram, _, Price, _, _, CPUFreq, Mem),
    Ram >= 32,
    CPUFreq >= 3.5,
    Mem >= 1000000,
    Price > 3000;
    (is_amd_gpu(ID, 1) ; is_nvidia_gpu(ID, 1)).

is_gaming(ID) :-
    laptop(ID, _, Ram, _, _, _, _, _, _),
    Ram >= 16,
    is_nvidia_gpu(ID, 1),
    is_memory_ssd(ID, 1).

is_education_laptop(ID) :-
    laptop(ID, _, Ram, Weight, _, _, _, _, _),
    Ram >= 8,
    Weight < 2,
    is_windows_10(ID, 1).

is_business_laptop(ID) :-
    laptop(ID, _, Ram, _, _, _, _, _, _),
    Ram >= 8,
    is_memory_ssd(ID, 1),
    (is_windows_10(ID, 1);is_windows_10_s(ID, 1)).

is_creator_laptop(ID) :-
    laptop(ID, _, Ram, _, _, ScreenWidth, _, _, _),
    Ram >= 16,
    ScreenWidth > 1920,
    (is_amd_gpu(ID, 1); is_nvidia_gpu(ID, 1)).

is_high_performance(ID) :-
    laptop(ID, _, Ram, _, _, _, _, CPUFrequency, MemoryAmount),
    Ram >= 32,
    CPUFrequency >= 3.0,
    MemoryAmount >= 50000.0,
    is_nvidia_gpu(ID, 1).

is_long_battery_laptop(ID) :-
    is_ultrabook(ID, 1),
    laptop(ID, Inches, _, Weight, _, _, _, _, _),
    Weight < 1.3,
    Inches =< 14,
    is_memory_ssd(ID, 1).

is_photography_laptop(ID) :-
    is_apple(ID, 1),
    laptop(ID, _, _, _, _, _, _, _, MemoryAmount),
    MemoryAmount >= 500000.
    

is_overpriced(ID) :-
    laptop(ID, _, Ram, _, Price, _, _, _, _),
    Price > 1000,
    Ram =< 4;
    is_no_os(ID, 1).

is_easy_to_carry(ID) :-
    laptop(ID, Inches, _, Weight, _, _, _, _, _),
    Inches =< 14,
    Weight < 1.5.


% ---- Regole di Calcolo Derivato ----

screen_size_inches(ID, SizeRounded) :-
    laptop(ID, _, _, _, _, SW, SH, _, _),
    DiagonalPx is sqrt(SW^2 + SH^2),
    InchesPerPixel = 13.3 / sqrt(2560^2 + 1600^2),
    Size is DiagonalPx * InchesPerPixel,
    round(Size * 10, SizeRoundedInt),
    SizeRounded is SizeRoundedInt / 10.

ppi(ID, PPI) :-
    laptop(ID, Inches, _, _, _, SW, SH, _, _),
    DiagonalPx is sqrt(SW^2 + SH^2),
    PPI is DiagonalPx / Inches.

aspect_ratio(ID, Ratio) :-
    laptop(ID, _, _, _, _, SW, SH, _, _),
    Ratio is SW / SH.

has_fast_memory(ID) :-
    laptop(ID, _, Ram, _, _, _, _, _, _),
    Ram >= 16,
    is_memory_ssd(ID, 1).

gaming_ready(ID) :-
    laptop(ID, Inches, _, _, _, SW, SH, _, _),
    DiagonalPx is sqrt(SW^2 + SH^2),
    PPI is DiagonalPx / Inches,
    PPI >= 120,
    is_nvidia_gpu(ID, 1).

refresh_rate(ID, 60) :-
    laptop(ID, Inches, _, _, _, SW, SH, _, _),
    DiagonalPx is sqrt(SW^2 + SH^2),
    PPI is DiagonalPx / Inches,
    PPI < 150.
    
refresh_rate(ID, 75) :-
    laptop(ID, Inches, _, _, _, SW, SH, _, _),
    DiagonalPx is sqrt(SW^2 + SH^2),
    PPI is DiagonalPx / Inches,
    PPI >= 150,
    PPI < 200.
    
refresh_rate(ID, 120) :-
    laptop(ID, Inches, _, _, _, SW, SH, _, _),
    DiagonalPx is sqrt(SW^2 + SH^2),
    PPI is DiagonalPx / Inches,
    PPI >= 200.
    

display_quality(ID, 'retina',Refresh) :-
    laptop(ID, Inches, _, _, _, SW, SH, _, _),
    DiagonalPx is sqrt(SW^2 + SH^2),
    PPI is DiagonalPx / Inches,
    PPI > 200,
    refresh_rate(ID, Refresh).

display_quality(ID, 'hd', Refresh) :-
    laptop(ID, Inches, _, _, _, SW, SH, _, _),
    DiagonalPx is sqrt(SW^2 + SH^2),
    PPI is DiagonalPx / Inches,
    PPI >= 150,
    PPI =< 200,
    refresh_rate(ID, Refresh).

display_quality(ID, 'base',Refresh) :-
    laptop(ID, Inches, _, _, _, SW, SH, _, _),
    DiagonalPx is sqrt(SW^2 + SH^2),
    PPI is DiagonalPx / Inches,
    PPI < 150,
    refresh_rate(ID, Refresh).


log_price(ID, LogPrice) :-
    laptop(ID, _, _, _, Price, _, _, _, _),
    LogPrice is log(Price). % Utile per regressione lineare


price_per_ram_gb(ID, Ratio) :-
    laptop(ID, _, Ram, _, Price, _, _, _, _),
    Ratio is Price / Ram.


budget_score(ID, Score) :- 
    laptop(ID, _, Ram, _, Price, _, _, CPUFrequency, Mem), 
    Score is (Ram * CPUFrequency + (Mem / 1000)) / Price.
    budget_score(ID, 0) :- \+ laptop(ID, _, _, _, _, _, _, _, _). % Default se non definito
    

brand_premium_score(ID, Score) :-
    (is_apple(ID, 1) -> Score = 5;
     is_razer(ID, 1) -> Score = 4;
     is_dell(ID, 1) -> Score = 3;
     Score = 1). % Assegna punteggi in base alla percezione di premiumness

% ---- Regole per Query Complesse ----

recommend_programmer(ID) :-
        laptop(ID, _, Ram, _, _, SW, SH, _, Mem),
        Ram >= 16,
        SW >= 1920, SH >= 1080,
        is_memory_ssd(ID, 1),
        Mem >= 256000;
        is_notebook(ID, 1).
    
recommend_video_editing(ID) :-
        laptop(ID, Inches, Ram, _, _, SW, SH, CPUFreq, Mem),
        Inches >= 15,
        SW >= 1920, SH >= 1080,
        Ram >= 16,
        CPUFreq >= 3.0,
        Mem >= 512000,
        is_nvidia_gpu(ID, 1),
        is_memory_ssd(ID, 1),
        (is_asus(ID, 1);is_acer(ID, 1);is_hp(ID, 1);is_dell(ID, 1);is_lenovo(ID, 1);is_msi(ID, 1)).
    
recommend_engineering(ID) :-
        laptop(ID, _, Ram, _, _, _, _, CPUFreq, Mem),
        Ram >= 32,
        CPUFreq >= 3.5,
        Mem >= 1000000,
        is_memory_hdd(ID, 1),
        (is_amd_gpu(ID, 1); is_nvidia_gpu(ID, 1)).
    
recommend_music_production(ID) :-
        laptop(ID, _, Ram, Weight, _, _, _, CPUFreq, Mem),
        Ram >= 16,
        CPUFreq >= 3.0,
        Mem >= 512000,
        Weight < 2,
        is_memory_ssd(ID, 1),
        is_apple(ID, 1).
    
recommend_office(ID) :-
        laptop(ID, _, Ram, Weight, _, _, _, _, _),
        Ram >= 8,
        Weight < 2,
        is_memory_ssd(ID, 1),
        is_windows_10(ID, 1).
    
recommend_cybersecurity(ID) :-
        laptop(ID, _, Ram, _, Price, _, _, _, Mem),
        Ram >= 16,
        Price =< 650,
        Mem >= 512000,
        is_memory_ssd(ID, 1),
        is_linux(ID, 1),
        is_amd_cpu(ID, 1).

% ---- Regole di Controllo Consistency ----

check_ram_integrity(ID) :-
    laptop(ID, _, Ram, _, _, _, _, _, _),
    0 is Ram mod 2.

check_storage_integrity(ID) :-
    is_memory_ssd(ID, SSD),
    is_memory_hdd(ID, HDD),
    Total is SSD + HDD,
    Total =< 1.

check_weight_integrity(ID) :-
    laptop(ID, Inches, _, Weight, _, _, _, _, _),
    (Inches > 17 -> Weight >= 1.5 ; true).

check_gaming_integrity(ID) :-
    is_gaming(ID),
    (is_amd_gpu(ID, 1) ; is_nvidia_gpu(ID, 1)).

check_premium_integrity(ID) :-
    laptop(ID, _, Ram, _, Price, _, _, _, _),
    (Price > 3000 -> Ram >= 32 ; true).

check_apple_os_integrity(ID) :-
    is_apple(ID, apple),
    findall(_, (is_mac_os_x(ID, 1); is_macos(ID, 1); is_no_os(ID, 1)), OSList),
    length(OSList, N),
    N =< 1.
    

check_no_os_allowed(ID) :-
    is_no_os(ID, 0) ; is_no_os(ID, 1).

% ---- FINE DELLE REGOLE ----
