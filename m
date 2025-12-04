Return-Path: <stable+bounces-199974-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F68BCA2E9E
	for <lists+stable@lfdr.de>; Thu, 04 Dec 2025 10:08:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4C818301C641
	for <lists+stable@lfdr.de>; Thu,  4 Dec 2025 09:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FAEB330D22;
	Thu,  4 Dec 2025 09:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20230601.gappssmtp.com header.i=@rajagiritech-edu-in.20230601.gappssmtp.com header.b="r/eOHtaN"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB2514A8E
	for <stable@vger.kernel.org>; Thu,  4 Dec 2025 09:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764839332; cv=none; b=upk8s2qEKCX74eFJgjUVkdqV7uk+m4BVREzbmCHVOnh2kvr82de6RKiTox/Z0L8wEwPdJ3aLH2f/g7OhA0h444j9V59wqaR620/uhbmWRTx753qaP/eJorHM+xOCgcIMNlp/ZAkcdZbjoqI78WC5PLXR4AFyCHtnMAmmrib26No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764839332; c=relaxed/simple;
	bh=+gyHMWZRT3CgtCEoz/mqx/tQV4sNsCgsR6iggkHMHPM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WjUOBJEoLN6Ib/KlLW1bkDCB+67XmRWFofhSGMABmrA052oT07Nd0g8X7wwqBc90NIr5WDWantvx4dkC63Mb7ik3y7VXZpFcAg3ZLVls0dfaK/MLKPs9D8HtZ+CbrbMcUeNChuNjZZuhyGU6qMOz2zEEdI6LvnHsDWKMoJR+FD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in; spf=none smtp.mailfrom=rajagiritech.edu.in; dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20230601.gappssmtp.com header.i=@rajagiritech-edu-in.20230601.gappssmtp.com header.b=r/eOHtaN; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rajagiritech.edu.in
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b736d883ac4so116619066b.2
        for <stable@vger.kernel.org>; Thu, 04 Dec 2025 01:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20230601.gappssmtp.com; s=20230601; t=1764839329; x=1765444129; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UXPpTx2ZRQQDJV/TFv+X0fYC/DHfx7ffZpbwaeuEO/U=;
        b=r/eOHtaNETLRf3C0snlgzhQgzI3A2E0xjWikBGUTiv8iAdMpLIHBV1qQkIpHx0uy6i
         Kn+Lr9rijx9gWEoQIB4YrRpcgbLDVwdOeIB/7+9q56f68+4v1cI95P0vSOu9jGnzjJr7
         fFqGWNwzPdsN1to5d0B+0EHJ6MH27mHqWxGVZZ3S/9qOIhlO7RBQkvzf6C5HcZA55s87
         VrR3ysff9fOe7XbJ0tcQzkfdrIhK8WgE37q5nFxRF+tL0ywzt4BCVXqFRbdYxCb3aQsj
         23BwsBgDgZatmq858SVawSKesH/SuUj2qmGZcNdCV6gNbK/t20pJ4xRdnIPUpFMuBh/u
         DhqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764839329; x=1765444129;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UXPpTx2ZRQQDJV/TFv+X0fYC/DHfx7ffZpbwaeuEO/U=;
        b=e37tH+SKXsAQWYfH0Mau9ynHetGBW68tKjz8uZdjZaYklyFKz8ygpudD5A7/UH/5WN
         O+OgclOFxdCDr1c79HAAkVG59kA/9IeYpLQn3AZJhfDT/lJPdix07mAGdWgUL0FtrcES
         V9bqzmRnx6f1+RgGSTsi9nD9KWHGYxf/jp07Px0eDuzFZF3sKgapfbaWsH5+p3bTQ7ba
         Mo/1VLdpcjyv9+gkBDXE9w5s943mF1epdOpJd5mqezFwZCsc5cuHNt9M+HYESwZwThWC
         hicBeKKp/NY82oGmtNp+zSjhPHfNgIL9F2/oQ9bevEx7ValFf5Z8OQYXpZyTgK+hR73X
         AqRQ==
X-Gm-Message-State: AOJu0YxWsFMdbnP25UZqk6uITv97H2bjhGXTBrF99IAbr/SQVxHY4GEz
	kEeFEmLhyWNEmbJvi32IzYEWVm73Ac3QZsNMMupm4XvxesnZebLcXjL1o6+LR7f10LlImsTLnHA
	OyqL1AjhWLMdrRJtRQI9qoYSJYZY25g9IOWTR4b+g8g==
X-Gm-Gg: ASbGncstDmoA9/OVK4U1OB/hQodT4m0qUW2kffCAehhMb+o9F3qF4oj03Z58LmpYiY5
	QJ4JM32AXHpLRQENwTLEpDvdu6DDA1jfA8/PMwMkFLhO3LojTNwDTOs/dUa7VGg2OMq/t9bmEFe
	SYKMGjSlyVAB587tvFEBmk8FdHon6ahTtg0ySD1OsjpDLiyNsRCDAd9WGte+VPkqeHH7XUc0qyG
	tt6bBBJ2Vs/6jP8kZTsb6sZj2BCP89EXhcPbD3ZTU2hVaRT/lpO+jcMs3s5PYtCvYopDQBX
X-Google-Smtp-Source: AGHT+IFEHJOmAybprefVX5JlmyY/EvKKpV+HKIaOmDmMWJ+qJqhzV9CNaL9GOqjDHdeiQh+PyK6KWZEEpDIjn76M+Yk=
X-Received: by 2002:a17:907:1b1e:b0:b73:39c3:b4f with SMTP id
 a640c23a62f3a-b79dc735558mr506216566b.50.1764839329204; Thu, 04 Dec 2025
 01:08:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251203152346.456176474@linuxfoundation.org>
In-Reply-To: <20251203152346.456176474@linuxfoundation.org>
From: Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date: Thu, 4 Dec 2025 14:38:10 +0530
X-Gm-Features: AWmQ_bm_YPLElzDektAuFx3ixqvFPiQyvRF5frNfLajyUQ0olCtBEbZhjvAxN44
Message-ID: <CAG=yYw=7i7O7nLLDQ5hdP03wHFSQ04QEXtP8dX-2ytBmiJWsaw@mail.gmail.com>
Subject: Re: [PATCH 6.17 000/146] 6.17.11-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"

 hello

Compiled and booted  6.17.11-rc1+

dmesg shows err and warn

-----err-------------
[    5.422899] UBSAN: array-index-out-of-bounds in
drivers/gpu/drm/radeon/radeon_atombios.c:2720:34
[    5.422909] index 16 is out of range for type 'UCHAR [*]'
[    5.424099] UBSAN: array-index-out-of-bounds in
drivers/gpu/drm/radeon/trinity_dpm.c:1763:32
[    5.424106] index 16 is out of range for type 'UCHAR [*]'
[   35.833950] systemd[1]: bpf-restrict-fs: Failed to load BPF object:
No such process
--------err-----------------

----------------warn---------------

[    0.007594] ACPI BIOS Warning (bug): Optional FADT field
Pm2ControlBlock has valid Length but zero Address:
0x0000000000000000/0x1 (20250404/tbfadt-611)
[    0.486793] Could not retrieve perf counters (-19)
[    0.491808] amd_pstate: the _CPC object is not present in SBIOS or
ACPI disabled
[    5.422897] ------------[ cut here ]------------
[    5.422917] CPU: 1 UID: 0 PID: 174 Comm: (udev-worker) Not tainted
6.17.11-rc1+ #1 PREEMPT(lazy)
[    5.422921] Hardware name: System manufacturer System Product
Name/F2A55-M LK2 PLUS, BIOS 0403 12/06/2012
[    5.422923] Call Trace:
[    5.422926]  <TASK>
[    5.422930]  dump_stack_lvl+0x5d/0x80
[    5.422937]  ubsan_epilogue+0x5/0x2b
[    5.422942]  __ubsan_handle_out_of_bounds.cold+0x54/0x59
[    5.422949]  radeon_atombios_get_power_modes+0x8d6/0x900 [radeon]
[    5.423086]  radeon_pm_init+0x142/0x760 [radeon]
[    5.423212]  cayman_init+0xec/0x2b0 [radeon]
[    5.423342]  radeon_device_init+0x563/0xba0 [radeon]
[    5.423442]  ? pci_find_capability+0x79/0xb0
[    5.423448]  radeon_driver_load_kms+0xa1/0x260 [radeon]
[    5.423548]  radeon_pci_probe+0xf6/0x1c0 [radeon]
[    5.423647]  local_pci_probe+0x42/0x90
[    5.423652]  pci_device_probe+0xda/0x2b0
[    5.423656]  ? sysfs_do_create_link_sd+0x6d/0xd0
[    5.423662]  really_probe+0xde/0x340
[    5.423666]  ? pm_runtime_barrier+0x55/0x90
[    5.423670]  __driver_probe_device+0x78/0x140
[    5.423674]  driver_probe_device+0x1f/0xa0
[    5.423677]  ? __pfx___driver_attach+0x10/0x10
[    5.423680]  __driver_attach+0xcb/0x1e0
[    5.423684]  bus_for_each_dev+0x85/0xd0
[    5.423689]  bus_add_driver+0x10b/0x1f0
[    5.423695]  ? __pfx_radeon_module_init+0x10/0x10 [radeon]
[    5.423785]  driver_register+0x75/0xe0
[    5.423789]  ? radeon_register_atpx_handler+0xe/0x30 [radeon]
[    5.423898]  do_one_initcall+0x5b/0x300
[    5.423903]  do_init_module+0x62/0x240
[    5.423908]  ? init_module_from_file+0x8a/0xe0
[    5.423911]  init_module_from_file+0x8a/0xe0
[    5.423916]  idempotent_init_module+0x114/0x310
[    5.423921]  __x64_sys_finit_module+0x6d/0xd0
[    5.423925]  do_syscall_64+0x81/0x970
[    5.423931]  ? __x64_sys_pread64+0x9c/0xd0
[    5.423936]  ? do_syscall_64+0xb9/0x970
[    5.423939]  ? alloc_fd+0x12e/0x190
[    5.423944]  ? do_sys_openat2+0xa2/0xe0
[    5.423949]  ? __x64_sys_openat+0x61/0xa0
[    5.423953]  ? do_syscall_64+0xb9/0x970
[    5.423956]  ? __x64_sys_openat+0x61/0xa0
[    5.423960]  ? do_syscall_64+0xb9/0x970
[    5.423964]  ? do_syscall_64+0xb9/0x970
[    5.423967]  ? restore_fpregs_from_fpstate+0x46/0xa0
[    5.423973]  ? switch_fpu_return+0x5b/0xe0
[    5.423977]  ? do_syscall_64+0x233/0x970
[    5.423980]  ? do_syscall_64+0xb9/0x970
[    5.423983]  ? do_user_addr_fault+0x21a/0x690
[    5.423988]  ? exc_page_fault+0x7e/0x1a0
[    5.423992]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[    5.423996] RIP: 0033:0x7f95a0a75779
[    5.424000] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00
00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24
08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 4f 86 0d 00 f7 d8 64 89
01 48
[    5.424003] RSP: 002b:00007ffd7a6a4738 EFLAGS: 00000246 ORIG_RAX:
0000000000000139
[    5.424007] RAX: ffffffffffffffda RBX: 0000557d39210560 RCX: 00007f95a0a75779
[    5.424009] RDX: 0000000000000004 RSI: 00007f959ffd344d RDI: 0000000000000044
[    5.424011] RBP: 0000000000000004 R08: 0000000000000000 R09: 0000557d39193500
[    5.424013] R10: 0000000000000000 R11: 0000000000000246 R12: 00007f959ffd344d
[    5.424014] R13: 0000000000020000 R14: 0000557d39197fb0 R15: 0000000000000000
[    5.424018]  </TASK>
[    5.424019] ---[ end trace ]---
[    5.424096] ------------[ cut here ]------------
[    5.424112] CPU: 1 UID: 0 PID: 174 Comm: (udev-worker) Not tainted
6.17.11-rc1+ #1 PREEMPT(lazy)
[    5.424116] Hardware name: System manufacturer System Product
Name/F2A55-M LK2 PLUS, BIOS 0403 12/06/2012
[    5.424117] Call Trace:
[    5.424119]  <TASK>
[    5.424120]  dump_stack_lvl+0x5d/0x80
[    5.424124]  ubsan_epilogue+0x5/0x2b
[    5.424128]  __ubsan_handle_out_of_bounds.cold+0x54/0x59
[    5.424133]  trinity_dpm_init+0x94c/0x9c0 [radeon]
[    5.424254]  radeon_pm_init+0x53c/0x760 [radeon]
[    5.424378]  cayman_init+0xec/0x2b0 [radeon]
[    5.424506]  radeon_device_init+0x563/0xba0 [radeon]
[    5.424600]  ? pci_find_capability+0x79/0xb0
[    5.424607]  radeon_driver_load_kms+0xa1/0x260 [radeon]
[    5.424705]  radeon_pci_probe+0xf6/0x1c0 [radeon]
[    5.424795]  local_pci_probe+0x42/0x90
[    5.424799]  pci_device_probe+0xda/0x2b0
[    5.424802]  ? sysfs_do_create_link_sd+0x6d/0xd0
[    5.424806]  really_probe+0xde/0x340
[    5.424809]  ? pm_runtime_barrier+0x55/0x90
[    5.424812]  __driver_probe_device+0x78/0x140
[    5.424814]  driver_probe_device+0x1f/0xa0
[    5.424817]  ? __pfx___driver_attach+0x10/0x10
[    5.424819]  __driver_attach+0xcb/0x1e0
[    5.424821]  bus_for_each_dev+0x85/0xd0
[    5.424825]  bus_add_driver+0x10b/0x1f0
[    5.424829]  ? __pfx_radeon_module_init+0x10/0x10 [radeon]
[    5.424907]  driver_register+0x75/0xe0
[    5.424910]  ? radeon_register_atpx_handler+0xe/0x30 [radeon]
[    5.425004]  do_one_initcall+0x5b/0x300
[    5.425009]  do_init_module+0x62/0x240
[    5.425012]  ? init_module_from_file+0x8a/0xe0
[    5.425015]  init_module_from_file+0x8a/0xe0
[    5.425018]  idempotent_init_module+0x114/0x310
[    5.425021]  __x64_sys_finit_module+0x6d/0xd0
[    5.425024]  do_syscall_64+0x81/0x970
[    5.425028]  ? __x64_sys_pread64+0x9c/0xd0
[    5.425032]  ? do_syscall_64+0xb9/0x970
[    5.425034]  ? alloc_fd+0x12e/0x190
[    5.425036]  ? do_sys_openat2+0xa2/0xe0
[    5.425040]  ? __x64_sys_openat+0x61/0xa0
[    5.425043]  ? do_syscall_64+0xb9/0x970
[    5.425045]  ? __x64_sys_openat+0x61/0xa0
[    5.425048]  ? do_syscall_64+0xb9/0x970
[    5.425051]  ? do_syscall_64+0xb9/0x970
[    5.425053]  ? restore_fpregs_from_fpstate+0x46/0xa0
[    5.425057]  ? switch_fpu_return+0x5b/0xe0
[    5.425060]  ? do_syscall_64+0x233/0x970
[    5.425062]  ? do_syscall_64+0xb9/0x970
[    5.425064]  ? do_user_addr_fault+0x21a/0x690
[    5.425067]  ? exc_page_fault+0x7e/0x1a0
[    5.425070]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[    5.425073] RIP: 0033:0x7f95a0a75779
[    5.425076] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00
00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24
08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 4f 86 0d 00 f7 d8 64 89
01 48
[    5.425079] RSP: 002b:00007ffd7a6a4738 EFLAGS: 00000246 ORIG_RAX:
0000000000000139
[    5.425082] RAX: ffffffffffffffda RBX: 0000557d39210560 RCX: 00007f95a0a75779
[    5.425083] RDX: 0000000000000004 RSI: 00007f959ffd344d RDI: 0000000000000044
[    5.425085] RBP: 0000000000000004 R08: 0000000000000000 R09: 0000557d39193500
[    5.425086] R10: 0000000000000000 R11: 0000000000000246 R12: 00007f959ffd344d
[    5.425087] R13: 0000000000020000 R14: 0000557d39197fb0 R15: 0000000000000000
[    5.425089]  </TASK>
[    5.425114] ---[ end trace ]---
[   25.822123] clocksource: Long readout interval, skipping watchdog
check: cs_nsec: 5685587027 wd_nsec: 5685584899
[   38.585559] at24 0-0050: supply vcc not found, using dummy regulator
[   38.789287] at24 0-0051: supply vcc not found, using dummy regulator
[   39.678107] asus_wmi: failed to register LPS0 sleep handler in a

---------------warn---------------------------

Version: AMD A4-4000 APU with Radeon(tm) HD Graphics

00:01.0 VGA compatible controller: Advanced Micro Devices, Inc.
[AMD/ATI] Trinity 2 [Radeon HD 7480D]



Tested-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>

--
software engineer
rajagiri school of engineering and technology

