Return-Path: <stable+bounces-169570-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC02B269BE
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 16:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48E5D6034CE
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 14:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA3C207A26;
	Thu, 14 Aug 2025 14:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kwURvcAg"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACFD1F30AD;
	Thu, 14 Aug 2025 14:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755181922; cv=none; b=gCQr96ZUxAQSDHWG9iuaZrB2xeDEEPE/raz5bQwslIGKw7s+xGWb0sg+bl7GcDhPZxv65b4uP082xZl6jAYeA7paAVomq8JuAKvT0vOvp8m0j9rcnc5evax1uRgAzrzeKsroUOPyL3hxVikDncXzaj2B+2U6e6Qc5JuFOhCROZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755181922; c=relaxed/simple;
	bh=y3QvC551wlxATa81LanAfjA6zEZvzxyk6ctLogiNV14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VRw2IV70shwX6mAIIAPzO12dKOuMfcHfnfovVVeYMifRJmG0pjqP7X2ZYVYyebsDT+A0xc3XPzqfGHt6HySuP3sbM+o87+gkMRuPw2IesZAQ8f2/cH4uGiP+8lsSKVrXWDwxecpkPzeQ/KW5xQVy/e08ynsNBg0iuK9r6xyt/Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kwURvcAg; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-76e2e5d244cso1102689b3a.0;
        Thu, 14 Aug 2025 07:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755181917; x=1755786717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4aG1knjr2XkgI9gROa3CqmwxDD9UKXcvHoHGLwsGucQ=;
        b=kwURvcAgRu3KtQPIat6ANSi89yMCEWW3+fsOsmsaEAd5YUTKAn0jeJwPQwNj+ZpMft
         8dd2tZ/cQJeA5796+5GubfKqydXOXukKMRX/B/ZdSsorsrx4eQ4ba2JniV0zBi/5UaeZ
         i/KTxMTWi/X8HzUZ2c018yQUiDkbrfHiIjsFDlyXp7wUqZcyZ8VRXFhM+8Nahq7NxBWz
         OI2YODO8UQTeMz5WLJZ45cX6ovL7J2Piwl3UIXGRULO3nRDZQMQyh8I9J5RNQYX9IRgb
         TYIsupG1bTg7Hql+19YKNaUVR6ld6PsK28LrvWOXGztLZaEFTr5700PDs9eLHiD7yTNj
         C1xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755181917; x=1755786717;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4aG1knjr2XkgI9gROa3CqmwxDD9UKXcvHoHGLwsGucQ=;
        b=oqSDu1K5jSRUatFSikU+9WcsFFAqEHljjMlEiO/RdOwR3Kgnys0/aHwEI9xHaYfYrQ
         g4pYFnLkUObJjX1RfXc9XEPiBlq/WNqKupy7Di71UVjnX3SCZxpbS+v0kC6kAFNMyTAq
         lXGOb71oZYBWnSGGlecgHddVCkO+yojkJ5Vr7f3aTsBICyyHfAqHHUK9gfPGJV0S9gLG
         dwzRaIil19vidJB/HrLwI+3cyuNuVh8+5MXrU6IUfuMgm2zUMIFBkbv7hIcc027Kdeig
         ECRBr4ZVe5ZPzazFG8JobvtwW7S7z0cGtJatTUYOaf6VT2b8LUig2xurSF3KG6DlvhH7
         Z9zg==
X-Forwarded-Encrypted: i=1; AJvYcCV0hSO227UFqdzskFi9iO3o6Qhvb1bNaP0U+zybEAsxf+CQEDvBPNGgvAp98zgQoks6WnULkhDH@vger.kernel.org, AJvYcCVwFXI3mEoZNhl+wZ/n6jRDU7Db4MMNMYw73RzNdyA2oTP1M6C43wgJGjpOCTUK7UQs4PrflDkV1x0o83s=@vger.kernel.org, AJvYcCXfwvrugILv/ApG7C4UuEgiicR3gfxe9ty1jo2xpjQKcjML/u214AnmmGqhZj995r0BWt+piH57er71@vger.kernel.org
X-Gm-Message-State: AOJu0Yx30RuwJwlu+QhoZMLZpEPWKRaX29Zk7y3FIgHNbgGCYrm1wuuY
	oCQTdvuNiG9TUTXwOggn6kin2RyCP+Pzn4k7Y1TPjakxVl5wcGsxLX7F
X-Gm-Gg: ASbGnct/HMk0rouZCsRhiMguTCCypnpXGkdTmv255fTBlT7PKZ2NqyYD5ud9lP5ujE7
	3kpn0+3BJFRE+9ol53qY0bzv7JPvoBJ0vd6FsQT00Wz58aQc44VtKAOeFQZfwXiGQZfSz1YgKRl
	wMB1A1ChOAZZpDcQAuoupxDhCVtkAlPfGWgrR90MFk/ct7v2Uv7sknfSA70UrEKmbJAqyU45rzk
	SDVUg/WXqCgIvKXqh36vLR+0QqWlENKLPSc6a3YlIrL/AdFKkT0T7/VJAd7sl7uS4eN/r/+HSoE
	Q2Lz1rUno/HgnWvMCWHQovE+gEbX4QCFJcO9DPLK+vE58xxSdVAcvp3rWgwbhyLQFmIrqohO5eL
	v6+eWs5pMtpqQtpPXbE9JCanM/4Viy3463AcCYByH7dxIRw4VYRo5
X-Google-Smtp-Source: AGHT+IGmPbO1GOtWcMLXQsvC0GMxP4N+hpeRSzjhrUzIRz3XuVlCG1ulbYn4KjZCTCJ8aGAZ2aGK0A==
X-Received: by 2002:a05:6a00:2315:b0:76a:d724:d712 with SMTP id d2e1a72fcca58-76e2fbf070bmr5510060b3a.3.1755181915657;
        Thu, 14 Aug 2025 07:31:55 -0700 (PDT)
Received: from BM5220 (118-232-8-190.dynamic.kbronet.com.tw. [118.232.8.190])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-76bf77210aesm28703960b3a.113.2025.08.14.07.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 07:31:55 -0700 (PDT)
From: Zenm Chen <zenmchen@gmail.com>
To: larsm17@gmail.com
Cc: gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	pkshih@realtek.com,
	rtl8821cerfe2@gmail.com,
	stable@vger.kernel.org,
	stern@rowland.harvard.edu,
	usb-storage@lists.one-eyed-alien.net,
	usbwifi2024@gmail.com,
	zenmchen@gmail.com
Subject: Re: [PATCH] USB: storage: Ignore driver CD mode for Realtek multi-mode Wi-Fi dongles
Date: Thu, 14 Aug 2025 22:31:44 +0800
Message-ID: <20250814143145.1290-1-zenmchen@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <8e9066d4-1b04-4423-869d-2bac0a3385a2@gmail.com>
References: <8e9066d4-1b04-4423-869d-2bac0a3385a2@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Lars Melin <larsm17@gmail.com> 於 2025年8月14日 週四 上午9:57寫道：
> Hi Zenm,
>
> 0bda:1a2b
> It is a USB Id supported by usb-modeswitch, I suspect that you would not
> had got all the error messages for the device if you had let
> usb-modeswitch access the device early (through udev) before the linux
> storage driver tried to access it. The long time to switch when running
> usb-modeswitch manually is likely also caused by clashes with
> communication by the storage driver.
>
> 0bda:a192
> This USB Id is not yet supported by usb-modeswitch and it probably has a
> different method than ejecting the virtual CD drive, the failure to
> switch it when manually running usb-modeswitch is an indication of that.
> If you are a representative of Realtek or if you know how to switch the
> device then contact the usb-modeswitch maintainer (Joshua Dietze) and
> ask him to add switch support for it.
>
> thanks
> Lars

Hi Lars,

If I apply this patch to my kernel, usb_modeswitch can switch both to
Wi-Fi mode smoothly and fastly, but I don't know why. @@

[    0.000000] Linux version 6.15.9-arch1-1 (linux@archlinux) (gcc (GCC) 15.1.1 20250729, GNU ld (GNU Binutils) 2.45.0) #1 SMP PREEMPT_DYNAMIC Sat, 02 Aug 2025 01:20:06 +0000
[    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-linux root=UUID=7e5f26b7-dfb4-4127-a8db-b4a8a512c3c0 rw loglevel=3 quiet intel_iommu=on
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009ffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000009d3dffff] usable
[    0.000000] BIOS-e820: [mem 0x000000009d3e0000-0x000000009d6c3fff] reserved
[    0.000000] BIOS-e820: [mem 0x000000009d6c4000-0x000000009d6d3fff] ACPI data
[    0.000000] BIOS-e820: [mem 0x000000009d6d4000-0x000000009da36fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000009da37000-0x000000009e60cfff] reserved
[    0.000000] BIOS-e820: [mem 0x000000009e60d000-0x000000009e60dfff] usable
[    0.000000] BIOS-e820: [mem 0x000000009e60e000-0x000000009e813fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000009e814000-0x000000009ec4afff] usable
[    0.000000] BIOS-e820: [mem 0x000000009ec4b000-0x000000009eff3fff] reserved
[    0.000000] BIOS-e820: [mem 0x000000009eff4000-0x000000009effffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec10000-0x00000000fec10fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed00000-0x00000000fed00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed40000-0x00000000fed44fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed80000-0x00000000fed8ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100001000-0x000000023effffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] APIC: Static calls initialized
[    0.000000] efi: EFI v32.3.1 by American Megatrends
[    0.000000] efi: ACPI=0x9d6cb000 ACPI 2.0=0x9d6cb000 SMBIOS=0xf04c0 INITRD=0x8b896e18 
[    0.000000] efi: Not removing mem165: MMIO range=[0xfec00000-0xfec00fff] (4KB) from e820 map
[    0.000000] efi: Not removing mem166: MMIO range=[0xfec10000-0xfec10fff] (4KB) from e820 map
[    0.000000] efi: Not removing mem167: MMIO range=[0xfed00000-0xfed00fff] (4KB) from e820 map
[    0.000000] efi: Not removing mem168: MMIO range=[0xfed40000-0xfed44fff] (20KB) from e820 map
[    0.000000] efi: Not removing mem169: MMIO range=[0xfed80000-0xfed80fff] (4KB) from e820 map
[    0.000000] efi: Not removing mem170: MMIO range=[0xfed81000-0xfed8ffff] (60KB) from e820 map
[    0.000000] efi: Remove mem171: MMIO range=[0xff000000-0xffffffff] (16MB) from e820 map
[    0.000000] e820: remove [mem 0xff000000-0xffffffff] reserved
[    0.000000] SMBIOS 2.7 present.
[    0.000000] DMI: System manufacturer System Product Name/F2A85-M, BIOS 6508 07/11/2014
[    0.000000] DMI: Memory slots populated: 4/4
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 3818.865 MHz processor
[    0.000782] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000784] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000790] last_pfn = 0x23f000 max_arch_pfn = 0x400000000
[    0.000799] total RAM covered: 2544M
[    0.001071] Found optimal setting for mtrr clean up
[    0.001071]  gran_size: 64K 	chunk_size: 32M 	num_reg: 3  	lose cover RAM: 0G
[    0.001075] MTRR map: 8 entries (5 fixed + 3 variable; max 22), built from 9 variable MTRRs
[    0.001078] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    0.001364] e820: update [mem 0x9f000000-0xffffffff] usable ==> reserved
[    0.001372] last_pfn = 0x9f000 max_arch_pfn = 0x400000000
[    0.005404] found SMP MP-table at [mem 0x000fd7b0-0x000fd7bf]
[    0.005445] Using GB pages for direct mapping
[    0.006164] Secure boot disabled
[    0.006165] RAMDISK: [mem 0x84433000-0x879fdfff]
[    0.006422] ACPI: Early table checksum verification disabled
[    0.006425] ACPI: RSDP 0x000000009D6CB000 000024 (v02 ALASKA)
[    0.006429] ACPI: XSDT 0x000000009D6CB078 000064 (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.006434] ACPI: FACP 0x000000009D6D1E50 00010C (v05 ALASKA A M I    01072009 AMI  00010013)
[    0.006439] ACPI BIOS Warning (bug): Optional FADT field Pm2ControlBlock has valid Length but zero Address: 0x0000000000000000/0x1 (20240827/tbfadt-611)
[    0.006443] ACPI: DSDT 0x000000009D6CB170 006CDB (v02 ALASKA A M I    00000000 INTL 20051117)
[    0.006447] ACPI: FACS 0x000000009DA2C080 000040
[    0.006449] ACPI: APIC 0x000000009D6D1F60 000072 (v03 ALASKA A M I    01072009 AMI  00010013)
[    0.006453] ACPI: FPDT 0x000000009D6D1FD8 000044 (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.006456] ACPI: MCFG 0x000000009D6D2020 00003C (v01 ALASKA A M I    01072009 MSFT 00010013)
[    0.006459] ACPI: SSDT 0x000000009D6D2EA0 0004B7 (v02 AMD    ANNAPURN 00000001 MSFT 04000000)
[    0.006462] ACPI: HPET 0x000000009D6D20B8 000038 (v01 ALASKA A M I    01072009 AMI  00000005)
[    0.006465] ACPI: IVRS 0x000000009D6D20F0 000070 (v02 AMD    ANNAPURN 00000001 AMD  00000000)
[    0.006468] ACPI: SSDT 0x000000009D6D2160 000D40 (v01 AMD    ANNAPURN 00000001 AMD  00000001)
[    0.006470] ACPI: Reserving FACP table memory at [mem 0x9d6d1e50-0x9d6d1f5b]
[    0.006472] ACPI: Reserving DSDT table memory at [mem 0x9d6cb170-0x9d6d1e4a]
[    0.006473] ACPI: Reserving FACS table memory at [mem 0x9da2c080-0x9da2c0bf]
[    0.006474] ACPI: Reserving APIC table memory at [mem 0x9d6d1f60-0x9d6d1fd1]
[    0.006475] ACPI: Reserving FPDT table memory at [mem 0x9d6d1fd8-0x9d6d201b]
[    0.006476] ACPI: Reserving MCFG table memory at [mem 0x9d6d2020-0x9d6d205b]
[    0.006477] ACPI: Reserving SSDT table memory at [mem 0x9d6d2ea0-0x9d6d3356]
[    0.006478] ACPI: Reserving HPET table memory at [mem 0x9d6d20b8-0x9d6d20ef]
[    0.006480] ACPI: Reserving IVRS table memory at [mem 0x9d6d20f0-0x9d6d215f]
[    0.006481] ACPI: Reserving SSDT table memory at [mem 0x9d6d2160-0x9d6d2e9f]
[    0.006554] No NUMA configuration found
[    0.006555] Faking a node at [mem 0x0000000000000000-0x000000023effffff]
[    0.006564] NODE_DATA(0) allocated [mem 0x23efd5280-0x23effffff]
[    0.006784] Zone ranges:
[    0.006784]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.006786]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.006788]   Normal   [mem 0x0000000100000000-0x000000023effffff]
[    0.006789]   Device   empty
[    0.006790] Movable zone start for each node
[    0.006793] Early memory node ranges
[    0.006793]   node   0: [mem 0x0000000000001000-0x000000000009ffff]
[    0.006794]   node   0: [mem 0x0000000000100000-0x000000009d3dffff]
[    0.006795]   node   0: [mem 0x000000009e60d000-0x000000009e60dfff]
[    0.006796]   node   0: [mem 0x000000009e814000-0x000000009ec4afff]
[    0.006797]   node   0: [mem 0x000000009eff4000-0x000000009effffff]
[    0.006798]   node   0: [mem 0x0000000100001000-0x000000023effffff]
[    0.006800] Initmem setup node 0 [mem 0x0000000000001000-0x000000023effffff]
[    0.006807] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.006848] On node 0, zone DMA: 96 pages in unavailable ranges
[    0.014435] On node 0, zone DMA32: 4653 pages in unavailable ranges
[    0.014457] On node 0, zone DMA32: 518 pages in unavailable ranges
[    0.014471] On node 0, zone DMA32: 937 pages in unavailable ranges
[    0.029877] On node 0, zone Normal: 4097 pages in unavailable ranges
[    0.029938] On node 0, zone Normal: 4096 pages in unavailable ranges
[    0.030098] ACPI: PM-Timer IO Port: 0x808
[    0.030108] ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
[    0.030117] IOAPIC[0]: apic_id 5, version 33, address 0xfec00000, GSI 0-23
[    0.030121] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.030123] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
[    0.030127] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.030128] ACPI: HPET id: 0x10228210 base: 0xfed00000
[    0.030138] CPU topo: Max. logical packages:   1
[    0.030139] CPU topo: Max. logical dies:       1
[    0.030140] CPU topo: Max. dies per package:   1
[    0.030144] CPU topo: Max. threads per core:   1
[    0.030145] CPU topo: Num. cores per package:     4
[    0.030145] CPU topo: Num. threads per package:   4
[    0.030146] CPU topo: Allowing 4 present CPUs plus 0 hotplug CPUs
[    0.030165] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.030168] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000fffff]
[    0.030170] PM: hibernation: Registered nosave memory: [mem 0x9d3e0000-0x9e60cfff]
[    0.030171] PM: hibernation: Registered nosave memory: [mem 0x9e60e000-0x9e813fff]
[    0.030173] PM: hibernation: Registered nosave memory: [mem 0x9ec4b000-0x9eff3fff]
[    0.030175] PM: hibernation: Registered nosave memory: [mem 0x9f000000-0x100000fff]
[    0.030177] [mem 0x9f000000-0xfebfffff] available for PCI devices
[    0.030180] Booting paravirtualized kernel on bare hardware
[    0.030182] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.035886] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:4 nr_cpu_ids:4 nr_node_ids:1
[    0.036296] percpu: Embedded 62 pages/cpu s217088 r8192 d28672 u524288
[    0.036304] pcpu-alloc: s217088 r8192 d28672 u524288 alloc=1*2097152
[    0.036307] pcpu-alloc: [0] 0 1 2 3 
[    0.036326] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-linux root=UUID=7e5f26b7-dfb4-4127-a8db-b4a8a512c3c0 rw loglevel=3 quiet intel_iommu=on
[    0.036410] DMAR: IOMMU enabled
[    0.036413] Unknown kernel command line parameters "BOOT_IMAGE=/boot/vmlinuz-linux", will be passed to user space.
[    0.036423] printk: log buffer data + meta data: 131072 + 458752 = 589824 bytes
[    0.037965] Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes, linear)
[    0.038729] Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes, linear)
[    0.038813] software IO TLB: area num 4.
[    0.063001] Fallback order for Node 0: 0 
[    0.063006] Built 1 zonelists, mobility grouping on.  Total pages: 1951682
[    0.063008] Policy zone: Normal
[    0.063463] mem auto-init: stack:all(zero), heap alloc:on, heap free:off
[    0.099148] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.110177] ftrace: allocating 55585 entries in 220 pages
[    0.110181] ftrace: allocated 220 pages with 5 groups
[    0.110361] Dynamic Preempt: full
[    0.110496] rcu: Preemptible hierarchical RCU implementation.
[    0.110497] rcu: 	RCU restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=4.
[    0.110498] rcu: 	RCU priority boosting: priority 1 delay 500 ms.
[    0.110499] 	Trampoline variant of Tasks RCU enabled.
[    0.110500] 	Rude variant of Tasks RCU enabled.
[    0.110500] 	Tracing variant of Tasks RCU enabled.
[    0.110501] rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
[    0.110502] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4
[    0.110509] RCU Tasks: Setting shift to 2 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=4.
[    0.110511] RCU Tasks Rude: Setting shift to 2 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=4.
[    0.110513] RCU Tasks Trace: Setting shift to 2 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=4.
[    0.117142] NR_IRQS: 524544, nr_irqs: 456, preallocated irqs: 16
[    0.117350] rcu: srcu_init: Setting srcu_struct sizes based on contention.
[    0.117445] kfence: initialized - using 2097152 bytes for 255 objects at 0x(____ptrval____)-0x(____ptrval____)
[    0.117529] Console: colour dummy device 80x25
[    0.117533] printk: legacy console [tty0] enabled
[    0.117743] ACPI: Core revision 20240827
[    0.117936] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484873504 ns
[    0.117950] APIC: Switch to symmetric I/O mode setup
[    0.118793] AMD-Vi: Using global IVHD EFR:0x0, EFR2:0x0
[    0.152388] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.156951] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x6e17ec1bf68, max_idle_ns: 881590834882 ns
[    0.156961] Calibrating delay loop (skipped), value calculated using timer frequency.. 7637.73 BogoMIPS (lpj=3818865)
[    0.157006] Last level iTLB entries: 4KB 512, 2MB 1024, 4MB 512
[    0.157008] Last level dTLB entries: 4KB 1024, 2MB 1024, 4MB 512, 1GB 0
[    0.157014] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    0.157016] Spectre V2 : Mitigation: Retpolines
[    0.157017] Spectre V2 : Spectre v2 / SpectreRSB: Filling RSB on context switch and VMEXIT
[    0.157019] RETBleed: Mitigation: untrained return thunk
[    0.157020] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl
[    0.157026] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.157028] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.157029] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.157030] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.157032] x86/fpu: Enabled xstate features 0x7, context size is 832 bytes, using 'standard' format.
[    0.183958] Freeing SMP alternatives memory: 52K
[    0.183966] pid_max: default: 32768 minimum: 301
[    0.192240] LSM: initializing lsm=capability,landlock,lockdown,yama,bpf
[    0.192959] landlock: Up and running.
[    0.192963] Yama: becoming mindful.
[    0.193196] LSM support for eBPF active
[    0.193425] Mount-cache hash table entries: 16384 (order: 5, 131072 bytes, linear)
[    0.193454] Mountpoint-cache hash table entries: 16384 (order: 5, 131072 bytes, linear)
[    0.297335] smpboot: CPU0: AMD A10-5800K APU with Radeon(tm) HD Graphics (family: 0x15, model: 0x10, stepping: 0x1)
[    0.297668] Performance Events: Fam15h core perfctr, AMD PMU driver.
[    0.297673] ... version:                0
[    0.297674] ... bit width:              48
[    0.297675] ... generic registers:      6
[    0.297676] ... value mask:             0000ffffffffffff
[    0.297677] ... max period:             00007fffffffffff
[    0.297678] ... fixed-purpose events:   0
[    0.297679] ... event mask:             000000000000003f
[    0.297771] signal: max sigframe size: 1776
[    0.297956] rcu: Hierarchical SRCU implementation.
[    0.297956] rcu: 	Max phase no-delay instances is 400.
[    0.297956] Timer migration: 1 hierarchy levels; 8 children per group; 1 crossnode level
[    0.301953] MCE: In-kernel MCE decoding enabled.
[    0.302041] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
[    0.302124] smp: Bringing up secondary CPUs ...
[    0.302300] smpboot: x86: Booting SMP configuration:
[    0.302302] .... node  #0, CPUs:      #1 #2 #3
[    0.306009] smp: Brought up 1 node, 4 CPUs
[    0.306009] smpboot: Total of 4 processors activated (30550.92 BogoMIPS)
[    0.307087] Memory: 7475544K/7806728K available (19713K kernel code, 2940K rwdata, 16528K rodata, 4644K init, 5024K bss, 318256K reserved, 0K cma-reserved)
[    0.307532] devtmpfs: initialized
[    0.307999] x86/mm: Memory block size: 128MB
[    0.309047] ACPI: PM: Registering ACPI NVS region [mem 0x9d6d4000-0x9da36fff] (3551232 bytes)
[    0.309056] ACPI: PM: Registering ACPI NVS region [mem 0x9e60e000-0x9e813fff] (2121728 bytes)
[    0.309203] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[    0.309203] posixtimers hash table entries: 2048 (order: 3, 32768 bytes, linear)
[    0.309203] futex hash table entries: 1024 (order: 4, 65536 bytes, linear)
[    0.309506] pinctrl core: initialized pinctrl subsystem
[    0.310036] PM: RTC time: 14:21:52, date: 2025-08-14
[    0.311237] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.311604] DMA: preallocated 1024 KiB GFP_KERNEL pool for atomic allocations
[    0.311811] DMA: preallocated 1024 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
[    0.312032] DMA: preallocated 1024 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
[    0.312051] audit: initializing netlink subsys (disabled)
[    0.312085] audit: type=2000 audit(1755181311.162:1): state=initialized audit_enabled=0 res=1
[    0.312128] thermal_sys: Registered thermal governor 'fair_share'
[    0.312131] thermal_sys: Registered thermal governor 'bang_bang'
[    0.312132] thermal_sys: Registered thermal governor 'step_wise'
[    0.312133] thermal_sys: Registered thermal governor 'user_space'
[    0.312134] thermal_sys: Registered thermal governor 'power_allocator'
[    0.312149] cpuidle: using governor ladder
[    0.312149] cpuidle: using governor menu
[    0.312149] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.312405] PCI: ECAM [mem 0xe0000000-0xefffffff] (base 0xe0000000) for domain 0000 [bus 00-ff]
[    0.312411] PCI: not using ECAM ([mem 0xe0000000-0xefffffff] not reserved)
[    0.312413] PCI: Using configuration type 1 for base access
[    0.312414] PCI: Using configuration type 1 for extended access
[    0.313036] kprobes: kprobe jump-optimization is enabled. All kprobes are optimized if possible.
[    0.315121] HugeTLB: allocation took 0ms with hugepage_allocation_threads=1
[    0.315121] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
[    0.315121] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
[    0.315121] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[    0.315121] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
[    0.318029] raid6: skipped pq benchmark and selected sse2x4
[    0.318029] raid6: using ssse3x2 recovery algorithm
[    0.318080] ACPI: Added _OSI(Module Device)
[    0.318080] ACPI: Added _OSI(Processor Device)
[    0.318080] ACPI: Added _OSI(Processor Aggregator Device)
[    0.322588] ACPI: 3 ACPI AML tables successfully acquired and loaded
[    0.328097] ACPI: Interpreter enabled
[    0.328123] ACPI: PM: (supports S0 S3 S4 S5)
[    0.328125] ACPI: Using IOAPIC for interrupt routing
[    0.328689] PCI: ECAM [mem 0xe0000000-0xefffffff] (base 0xe0000000) for domain 0000 [bus 00-ff]
[    0.328743] PCI: ECAM [mem 0xe0000000-0xefffffff] reserved as ACPI motherboard resource
[    0.328764] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.328766] PCI: Using E820 reservations for host bridge windows
[    0.329063] ACPI: Enabled 8 GPEs in block 00 to 1F
[    0.337726] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.337736] acpi PNP0A03:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI EDR HPX-Type3]
[    0.337864] acpi PNP0A03:00: _OSC: platform does not support [PCIeHotplug SHPCHotplug PME LTR DPC]
[    0.338100] acpi PNP0A03:00: _OSC: OS now controls [AER PCIeCapability]
[    0.338580] PCI host bridge to bus 0000:00
[    0.338584] pci_bus 0000:00: root bus resource [io  0x0000-0x03af window]
[    0.338587] pci_bus 0000:00: root bus resource [io  0x03e0-0x0cf7 window]
[    0.338590] pci_bus 0000:00: root bus resource [io  0x03b0-0x03df window]
[    0.338592] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.338594] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000dffff window]
[    0.338597] pci_bus 0000:00: root bus resource [mem 0xc0000000-0xffffffff window]
[    0.338599] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.338615] pci 0000:00:00.0: [1022:1410] type 00 class 0x060000 conventional PCI endpoint
[    0.338748] pci 0000:00:00.2: [1022:1419] type 00 class 0x080600 conventional PCI endpoint
[    0.338876] pci 0000:00:01.0: [1002:9901] type 00 class 0x030000 PCIe Root Complex Integrated Endpoint
[    0.338905] pci 0000:00:01.0: BAR 0 [mem 0xc0000000-0xcfffffff pref]
[    0.338908] pci 0000:00:01.0: BAR 1 [io  0xf000-0xf0ff]
[    0.338911] pci 0000:00:01.0: BAR 2 [mem 0xfeb00000-0xfeb3ffff]
[    0.338921] pci 0000:00:01.0: enabling Extended Tags
[    0.338933] pci 0000:00:01.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    0.338971] pci 0000:00:01.0: supports D1 D2
[    0.339037] pci 0000:00:01.1: [1002:9902] type 00 class 0x040300 PCIe Root Complex Integrated Endpoint
[    0.339063] pci 0000:00:01.1: BAR 0 [mem 0xfeb40000-0xfeb43fff]
[    0.339074] pci 0000:00:01.1: enabling Extended Tags
[    0.339105] pci 0000:00:01.1: supports D1 D2
[    0.339195] pci 0000:00:10.0: [1022:7812] type 00 class 0x0c0330 PCIe Root Complex Integrated Endpoint
[    0.339249] pci 0000:00:10.0: BAR 0 [mem 0xfeb46000-0xfeb47fff 64bit]
[    0.339327] pci 0000:00:10.0: PME# supported from D0 D3hot D3cold
[    0.339461] pci 0000:00:10.1: [1022:7812] type 00 class 0x0c0330 PCIe Root Complex Integrated Endpoint
[    0.339515] pci 0000:00:10.1: BAR 0 [mem 0xfeb44000-0xfeb45fff 64bit]
[    0.339594] pci 0000:00:10.1: PME# supported from D0 D3hot D3cold
[    0.339722] pci 0000:00:11.0: [1022:7801] type 00 class 0x010601 conventional PCI endpoint
[    0.339766] pci 0000:00:11.0: BAR 0 [io  0xf140-0xf147]
[    0.339770] pci 0000:00:11.0: BAR 1 [io  0xf130-0xf133]
[    0.339773] pci 0000:00:11.0: BAR 2 [io  0xf120-0xf127]
[    0.339776] pci 0000:00:11.0: BAR 3 [io  0xf110-0xf113]
[    0.339779] pci 0000:00:11.0: BAR 4 [io  0xf100-0xf10f]
[    0.339782] pci 0000:00:11.0: BAR 5 [mem 0xfeb4c000-0xfeb4c7ff]
[    0.339894] pci 0000:00:12.0: [1022:7807] type 00 class 0x0c0310 conventional PCI endpoint
[    0.339938] pci 0000:00:12.0: BAR 0 [mem 0xfeb4b000-0xfeb4bfff]
[    0.340053] pci 0000:00:12.2: [1022:7808] type 00 class 0x0c0320 conventional PCI endpoint
[    0.340098] pci 0000:00:12.2: BAR 0 [mem 0xfeb4a000-0xfeb4a0ff]
[    0.340140] pci 0000:00:12.2: supports D1 D2
[    0.340142] pci 0000:00:12.2: PME# supported from D0 D1 D2 D3hot
[    0.340242] pci 0000:00:13.0: [1022:7807] type 00 class 0x0c0310 conventional PCI endpoint
[    0.340287] pci 0000:00:13.0: BAR 0 [mem 0xfeb49000-0xfeb49fff]
[    0.340393] pci 0000:00:13.2: [1022:7808] type 00 class 0x0c0320 conventional PCI endpoint
[    0.340438] pci 0000:00:13.2: BAR 0 [mem 0xfeb48000-0xfeb480ff]
[    0.340480] pci 0000:00:13.2: supports D1 D2
[    0.340482] pci 0000:00:13.2: PME# supported from D0 D1 D2 D3hot
[    0.340573] pci 0000:00:14.0: [1022:780b] type 00 class 0x0c0500 conventional PCI endpoint
[    0.340674] pci 0000:00:14.3: [1022:780e] type 00 class 0x060100 conventional PCI endpoint
[    0.340833] pci 0000:00:14.4: [1022:780f] type 01 class 0x060401 conventional PCI bridge
[    0.340862] pci 0000:00:14.4: PCI bridge to [bus 01] (subtractive decode)
[    0.340995] pci 0000:00:15.0: [1022:43a0] type 01 class 0x060400 PCIe Root Port
[    0.341022] pci 0000:00:15.0: PCI bridge to [bus 02]
[    0.341029] pci 0000:00:15.0:   bridge window [io  0xe000-0xefff]
[    0.341033] pci 0000:00:15.0:   bridge window [mem 0xfea00000-0xfeafffff]
[    0.341053] pci 0000:00:15.0: enabling Extended Tags
[    0.341106] pci 0000:00:15.0: supports D1 D2
[    0.341220] pci 0000:00:15.1: [1022:43a1] type 01 class 0x060400 PCIe Root Port
[    0.341245] pci 0000:00:15.1: PCI bridge to [bus 03]
[    0.341251] pci 0000:00:15.1:   bridge window [io  0xd000-0xdfff]
[    0.341262] pci 0000:00:15.1:   bridge window [mem 0xd0000000-0xd00fffff 64bit pref]
[    0.341273] pci 0000:00:15.1: enabling Extended Tags
[    0.341321] pci 0000:00:15.1: supports D1 D2
[    0.341416] pci 0000:00:18.0: [1022:1400] type 00 class 0x060000 conventional PCI endpoint
[    0.341476] pci 0000:00:18.1: [1022:1401] type 00 class 0x060000 conventional PCI endpoint
[    0.341532] pci 0000:00:18.2: [1022:1402] type 00 class 0x060000 conventional PCI endpoint
[    0.341588] pci 0000:00:18.3: [1022:1403] type 00 class 0x060000 conventional PCI endpoint
[    0.341652] pci 0000:00:18.4: [1022:1404] type 00 class 0x060000 conventional PCI endpoint
[    0.341719] pci 0000:00:18.5: [1022:1405] type 00 class 0x060000 conventional PCI endpoint
[    0.341787] pci_bus 0000:01: extended config space not accessible
[    0.341845] pci 0000:00:14.4: PCI bridge to [bus 01] (subtractive decode)
[    0.341854] pci 0000:00:14.4:   bridge window [io  0x0000-0x03af window] (subtractive decode)
[    0.341856] pci 0000:00:14.4:   bridge window [io  0x03e0-0x0cf7 window] (subtractive decode)
[    0.341857] pci 0000:00:14.4:   bridge window [io  0x03b0-0x03df window] (subtractive decode)
[    0.341859] pci 0000:00:14.4:   bridge window [io  0x0d00-0xffff window] (subtractive decode)
[    0.341861] pci 0000:00:14.4:   bridge window [mem 0x000a0000-0x000dffff window] (subtractive decode)
[    0.341862] pci 0000:00:14.4:   bridge window [mem 0xc0000000-0xffffffff window] (subtractive decode)
[    0.341930] pci 0000:02:00.0: [10ec:c852] type 00 class 0x028000 PCIe Endpoint
[    0.341988] pci 0000:02:00.0: BAR 0 [io  0xe000-0xe0ff]
[    0.341995] pci 0000:02:00.0: BAR 2 [mem 0xfea00000-0xfeafffff 64bit]
[    0.342093] pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
[    0.342254] pci 0000:00:15.0: PCI bridge to [bus 02]
[    0.342338] pci 0000:03:00.0: [10ec:8168] type 00 class 0x020000 PCIe Endpoint
[    0.342398] pci 0000:03:00.0: BAR 0 [io  0xd000-0xd0ff]
[    0.342404] pci 0000:03:00.0: BAR 2 [mem 0xd0004000-0xd0004fff 64bit pref]
[    0.342409] pci 0000:03:00.0: BAR 4 [mem 0xd0000000-0xd0003fff 64bit pref]
[    0.342506] pci 0000:03:00.0: supports D1 D2
[    0.342507] pci 0000:03:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.342675] pci 0000:00:15.1: PCI bridge to [bus 03]
[    0.343195] ACPI: PCI: Interrupt link LNKA configured for IRQ 0
[    0.343268] ACPI: PCI: Interrupt link LNKB configured for IRQ 0
[    0.343344] ACPI: PCI: Interrupt link LNKC configured for IRQ 0
[    0.343418] ACPI: PCI: Interrupt link LNKD configured for IRQ 0
[    0.343479] ACPI: PCI: Interrupt link LNKE configured for IRQ 0
[    0.343526] ACPI: PCI: Interrupt link LNKF configured for IRQ 0
[    0.343573] ACPI: PCI: Interrupt link LNKG configured for IRQ 0
[    0.343621] ACPI: PCI: Interrupt link LNKH configured for IRQ 0
[    0.343847] iommu: Default domain type: Translated
[    0.343847] iommu: DMA domain TLB invalidation policy: lazy mode
[    0.344038] SCSI subsystem initialized
[    0.344049] libata version 3.00 loaded.
[    0.344049] ACPI: bus type USB registered
[    0.344049] usbcore: registered new interface driver usbfs
[    0.344049] usbcore: registered new interface driver hub
[    0.344049] usbcore: registered new device driver usb
[    0.344061] EDAC MC: Ver: 3.0.0
[    0.344140] efivars: Registered efivars operations
[    0.344205] NetLabel: Initializing
[    0.344206] NetLabel:  domain hash size = 128
[    0.344207] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    0.344224] NetLabel:  unlabeled traffic allowed by default
[    0.344228] mctp: management component transport protocol core
[    0.344229] NET: Registered PF_MCTP protocol family
[    0.344243] PCI: Using ACPI for IRQ routing
[    0.353116] PCI: pci_cache_line_size set to 64 bytes
[    0.353170] e820: reserve RAM buffer [mem 0x9d3e0000-0x9fffffff]
[    0.353172] e820: reserve RAM buffer [mem 0x9e60e000-0x9fffffff]
[    0.353174] e820: reserve RAM buffer [mem 0x9ec4b000-0x9fffffff]
[    0.353175] e820: reserve RAM buffer [mem 0x9f000000-0x9fffffff]
[    0.353177] e820: reserve RAM buffer [mem 0x23f000000-0x23fffffff]
[    0.353228] pci 0000:00:01.0: vgaarb: setting as boot VGA device
[    0.353228] pci 0000:00:01.0: vgaarb: bridge control possible
[    0.353228] pci 0000:00:01.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    0.353228] vgaarb: loaded
[    0.353228] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.353228] hpet0: 3 comparators, 32-bit 14.318180 MHz counter
[    0.355040] clocksource: Switched to clocksource tsc-early
[    0.355681] VFS: Disk quotas dquot_6.6.0
[    0.355715] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.355860] pnp: PnP ACPI init
[    0.355999] system 00:00: [mem 0xe0000000-0xefffffff] has been reserved
[    0.356072] system 00:01: [mem 0xa0000000-0xbfffffff] has been reserved
[    0.356149] system 00:02: [mem 0xfeb80000-0xfebfffff] could not be reserved
[    0.356457] system 00:03: [io  0x04d0-0x04d1] has been reserved
[    0.356460] system 00:03: [io  0x040b] has been reserved
[    0.356461] system 00:03: [io  0x04d6] has been reserved
[    0.356463] system 00:03: [io  0x0c00-0x0c01] has been reserved
[    0.356465] system 00:03: [io  0x0c14] has been reserved
[    0.356466] system 00:03: [io  0x0c50-0x0c51] has been reserved
[    0.356468] system 00:03: [io  0x0c52] has been reserved
[    0.356470] system 00:03: [io  0x0c6c] has been reserved
[    0.356471] system 00:03: [io  0x0c6f] has been reserved
[    0.356473] system 00:03: [io  0x0cd0-0x0cd1] has been reserved
[    0.356474] system 00:03: [io  0x0cd2-0x0cd3] has been reserved
[    0.356476] system 00:03: [io  0x0cd4-0x0cd5] has been reserved
[    0.356477] system 00:03: [io  0x0cd6-0x0cd7] has been reserved
[    0.356479] system 00:03: [io  0x0cd8-0x0cdf] has been reserved
[    0.356480] system 00:03: [io  0x0800-0x089f] has been reserved
[    0.356482] system 00:03: [io  0x0b20-0x0b3f] has been reserved
[    0.356484] system 00:03: [io  0x0900-0x090f] has been reserved
[    0.356485] system 00:03: [io  0x0910-0x091f] has been reserved
[    0.356487] system 00:03: [io  0xfe00-0xfefe] has been reserved
[    0.356489] system 00:03: [mem 0xfec00000-0xfec00fff] could not be reserved
[    0.356492] system 00:03: [mem 0xfee00000-0xfee00fff] has been reserved
[    0.356494] system 00:03: [mem 0xfed80000-0xfed8ffff] has been reserved
[    0.356497] system 00:03: [mem 0xfed61000-0xfed70fff] has been reserved
[    0.356499] system 00:03: [mem 0xfec10000-0xfec10fff] has been reserved
[    0.356501] system 00:03: [mem 0xfed00000-0xfed00fff] could not be reserved
[    0.356503] system 00:03: [mem 0xff000000-0xffffffff] has been reserved
[    0.356687] system 00:04: [io  0x0300-0x031f] has been reserved
[    0.356690] system 00:04: [io  0x0290-0x029f] has been reserved
[    0.356692] system 00:04: [io  0x0230-0x023f] has been reserved
[    0.356780] system 00:06: [io  0x04d0-0x04d1] has been reserved
[    0.357183] pnp: PnP ACPI: found 8 devices
[    0.363785] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.363979] NET: Registered PF_INET protocol family
[    0.364188] IP idents hash table entries: 131072 (order: 8, 1048576 bytes, linear)
[    0.380196] tcp_listen_portaddr_hash hash table entries: 4096 (order: 4, 65536 bytes, linear)
[    0.380246] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
[    0.380327] TCP established hash table entries: 65536 (order: 7, 524288 bytes, linear)
[    0.380785] TCP bind hash table entries: 65536 (order: 9, 2097152 bytes, linear)
[    0.381141] TCP: Hash tables configured (established 65536 bind 65536)
[    0.381345] MPTCP token hash table entries: 8192 (order: 5, 196608 bytes, linear)
[    0.381455] UDP hash table entries: 4096 (order: 6, 262144 bytes, linear)
[    0.381534] UDP-Lite hash table entries: 4096 (order: 6, 262144 bytes, linear)
[    0.381635] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.381644] NET: Registered PF_XDP protocol family
[    0.381661] pci 0000:00:14.4: PCI bridge to [bus 01]
[    0.381675] pci 0000:00:15.0: PCI bridge to [bus 02]
[    0.381678] pci 0000:00:15.0:   bridge window [io  0xe000-0xefff]
[    0.381683] pci 0000:00:15.0:   bridge window [mem 0xfea00000-0xfeafffff]
[    0.381690] pci 0000:00:15.1: PCI bridge to [bus 03]
[    0.381693] pci 0000:00:15.1:   bridge window [io  0xd000-0xdfff]
[    0.381699] pci 0000:00:15.1:   bridge window [mem 0xd0000000-0xd00fffff 64bit pref]
[    0.381705] pci_bus 0000:00: resource 4 [io  0x0000-0x03af window]
[    0.381708] pci_bus 0000:00: resource 5 [io  0x03e0-0x0cf7 window]
[    0.381709] pci_bus 0000:00: resource 6 [io  0x03b0-0x03df window]
[    0.381711] pci_bus 0000:00: resource 7 [io  0x0d00-0xffff window]
[    0.381712] pci_bus 0000:00: resource 8 [mem 0x000a0000-0x000dffff window]
[    0.381714] pci_bus 0000:00: resource 9 [mem 0xc0000000-0xffffffff window]
[    0.381716] pci_bus 0000:01: resource 4 [io  0x0000-0x03af window]
[    0.381717] pci_bus 0000:01: resource 5 [io  0x03e0-0x0cf7 window]
[    0.381719] pci_bus 0000:01: resource 6 [io  0x03b0-0x03df window]
[    0.381720] pci_bus 0000:01: resource 7 [io  0x0d00-0xffff window]
[    0.381721] pci_bus 0000:01: resource 8 [mem 0x000a0000-0x000dffff window]
[    0.381723] pci_bus 0000:01: resource 9 [mem 0xc0000000-0xffffffff window]
[    0.381725] pci_bus 0000:02: resource 0 [io  0xe000-0xefff]
[    0.381726] pci_bus 0000:02: resource 1 [mem 0xfea00000-0xfeafffff]
[    0.381728] pci_bus 0000:03: resource 0 [io  0xd000-0xdfff]
[    0.381729] pci_bus 0000:03: resource 2 [mem 0xd0000000-0xd00fffff 64bit pref]
[    0.381819] pci 0000:00:01.1: D0 power state depends on 0000:00:01.0
[    0.406517] pci 0000:00:12.0: quirk_usb_early_handoff+0x0/0x760 took 23686 usecs
[    0.406675] pci 0000:00:12.2: PME# does not work under D3, disabling it
[    0.428528] pci 0000:00:13.0: quirk_usb_early_handoff+0x0/0x760 took 21335 usecs
[    0.428683] pci 0000:00:13.2: PME# does not work under D3, disabling it
[    0.428714] PCI: CLS 64 bytes, default 64
[    0.428784] Trying to unpack rootfs image as initramfs...
[    0.428785] pci 0000:00:00.0: Adding to iommu group 0
[    0.428809] pci 0000:00:01.0: Adding to iommu group 1
[    0.428821] pci 0000:00:01.1: Adding to iommu group 1
[    0.428848] pci 0000:00:10.0: Adding to iommu group 2
[    0.428860] pci 0000:00:10.1: Adding to iommu group 2
[    0.428872] pci 0000:00:11.0: Adding to iommu group 3
[    0.428893] pci 0000:00:12.0: Adding to iommu group 4
[    0.428904] pci 0000:00:12.2: Adding to iommu group 4
[    0.428932] pci 0000:00:13.0: Adding to iommu group 5
[    0.428944] pci 0000:00:13.2: Adding to iommu group 5
[    0.428969] pci 0000:00:14.0: Adding to iommu group 6
[    0.428981] pci 0000:00:14.3: Adding to iommu group 6
[    0.428997] pci 0000:00:14.4: Adding to iommu group 7
[    0.429019] pci 0000:00:15.0: Adding to iommu group 8
[    0.429032] pci 0000:00:15.1: Adding to iommu group 8
[    0.429072] pci 0000:00:18.0: Adding to iommu group 9
[    0.429085] pci 0000:00:18.1: Adding to iommu group 9
[    0.429101] pci 0000:00:18.2: Adding to iommu group 9
[    0.429118] pci 0000:00:18.3: Adding to iommu group 9
[    0.429134] pci 0000:00:18.4: Adding to iommu group 9
[    0.429148] pci 0000:00:18.5: Adding to iommu group 9
[    0.429154] pci 0000:02:00.0: Adding to iommu group 8
[    0.429160] pci 0000:03:00.0: Adding to iommu group 8
[    0.430785] AMD-Vi: Extended features (0x800000853, 0x0): PreF PPR GT IA
[    0.430800] AMD-Vi: Interrupt remapping enabled
[    0.430982] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.430984] software IO TLB: mapped [mem 0x000000008c2ee000-0x00000000902ee000] (64MB)
[    0.431046] LVT offset 0 assigned for vector 0x400
[    0.431100] perf: AMD IBS detected (0x000000ff)
[    0.460909] Initialise system trusted keyrings
[    0.460925] Key type blacklist registered
[    0.461004] workingset: timestamp_bits=36 max_order=21 bucket_order=0
[    0.462715] fuse: init (API version 7.43)
[    0.462895] integrity: Platform Keyring initialized
[    0.462901] integrity: Machine keyring initialized
[    0.475437] xor: automatically using best checksumming function   avx       
[    0.475439] Key type asymmetric registered
[    0.475440] Asymmetric key parser 'x509' registered
[    0.475499] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 246)
[    0.475556] io scheduler mq-deadline registered
[    0.475557] io scheduler kyber registered
[    0.475599] io scheduler bfq registered
[    0.475743] ledtrig-cpu: registered to indicate activity on CPUs
[    0.476378] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[    0.476407] ACPI: button: Power Button [PWRB]
[    0.476449] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
[    0.480455] ACPI: button: Power Button [PWRF]
[    0.480895] Could not retrieve perf counters (-19)
[    0.481121] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    0.483763] Non-volatile memory driver v1.3
[    0.483766] Linux agpgart interface v0.103
[    0.483818] ACPI: bus type drm_connector registered
[    0.484488] ahci 0000:00:11.0: version 3.0
[    0.484845] ahci 0000:00:11.0: AHCI vers 0001.0300, 32 command slots, 6 Gbps, SATA mode
[    0.484848] ahci 0000:00:11.0: 8/8 ports implemented (port mask 0xff)
[    0.484850] ahci 0000:00:11.0: flags: 64bit ncq sntf ilck pm led clo pmp pio sxs 
[    0.485782] scsi host0: ahci
[    0.485984] scsi host1: ahci
[    0.486129] scsi host2: ahci
[    0.486267] scsi host3: ahci
[    0.486434] scsi host4: ahci
[    0.486564] scsi host5: ahci
[    0.486700] scsi host6: ahci
[    0.486839] scsi host7: ahci
[    0.486902] ata1: SATA max UDMA/133 abar m2048@0xfeb4c000 port 0xfeb4c100 irq 27 lpm-pol 0
[    0.486905] ata2: SATA max UDMA/133 abar m2048@0xfeb4c000 port 0xfeb4c180 irq 28 lpm-pol 0
[    0.486907] ata3: SATA max UDMA/133 abar m2048@0xfeb4c000 port 0xfeb4c200 irq 29 lpm-pol 0
[    0.486909] ata4: SATA max UDMA/133 abar m2048@0xfeb4c000 port 0xfeb4c280 irq 30 lpm-pol 0
[    0.486911] ata5: SATA max UDMA/133 abar m2048@0xfeb4c000 port 0xfeb4c300 irq 31 lpm-pol 0
[    0.486913] ata6: SATA max UDMA/133 abar m2048@0xfeb4c000 port 0xfeb4c380 irq 32 lpm-pol 0
[    0.486915] ata7: SATA max UDMA/133 abar m2048@0xfeb4c000 port 0xfeb4c400 irq 33 lpm-pol 0
[    0.486918] ata8: SATA max UDMA/133 abar m2048@0xfeb4c000 port 0xfeb4c480 irq 34 lpm-pol 0
[    0.487206] QUIRK: Enable AMD PLL fix
[    0.487228] ohci-pci 0000:00:12.0: OHCI PCI host controller
[    0.487234] ohci-pci 0000:00:12.0: new USB bus registered, assigned bus number 1
[    0.487281] ohci-pci 0000:00:12.0: irq 18, io mem 0xfeb4b000
[    0.542492] usb usb1: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 6.15
[    0.542495] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.542497] usb usb1: Product: OHCI PCI host controller
[    0.542499] usb usb1: Manufacturer: Linux 6.15.9-arch1-1 ohci_hcd
[    0.542500] usb usb1: SerialNumber: 0000:00:12.0
[    0.542671] hub 1-0:1.0: USB hub found
[    0.542681] hub 1-0:1.0: 5 ports detected
[    0.543025] ehci-pci 0000:00:12.2: EHCI Host Controller
[    0.543033] ehci-pci 0000:00:12.2: new USB bus registered, assigned bus number 2
[    0.543037] ehci-pci 0000:00:12.2: applying AMD SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
[    0.543049] ehci-pci 0000:00:12.2: debug port 1
[    0.543093] ehci-pci 0000:00:12.2: irq 17, io mem 0xfeb4a000
[    0.548289] ehci-pci 0000:00:12.2: USB 2.0 started, EHCI 1.00
[    0.548340] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.15
[    0.548342] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.548344] usb usb2: Product: EHCI Host Controller
[    0.548346] usb usb2: Manufacturer: Linux 6.15.9-arch1-1 ehci_hcd
[    0.548347] usb usb2: SerialNumber: 0000:00:12.2
[    0.548457] hub 2-0:1.0: USB hub found
[    0.548464] hub 2-0:1.0: 5 ports detected
[    0.589624] ata5: SATA link down (SStatus 0 SControl 300)
[    0.590283] ata1: SATA link down (SStatus 0 SControl 300)
[    0.591283] ata7: SATA link down (SStatus 0 SControl 300)
[    0.591417] ata8: SATA link down (SStatus 0 SControl 300)
[    0.594417] ata3: SATA link down (SStatus 0 SControl 300)
[    0.597305] hub 1-0:1.0: USB hub found
[    0.597314] hub 1-0:1.0: 5 ports detected
[    0.597487] ehci-pci 0000:00:13.2: EHCI Host Controller
[    0.597501] ehci-pci 0000:00:13.2: new USB bus registered, assigned bus number 3
[    0.597509] ehci-pci 0000:00:13.2: applying AMD SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
[    0.597520] ehci-pci 0000:00:13.2: debug port 1
[    0.597575] ehci-pci 0000:00:13.2: irq 17, io mem 0xfeb48000
[    0.603615] ehci-pci 0000:00:13.2: USB 2.0 started, EHCI 1.00
[    0.603726] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.15
[    0.603730] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.603732] usb usb3: Product: EHCI Host Controller
[    0.603735] usb usb3: Manufacturer: Linux 6.15.9-arch1-1 ehci_hcd
[    0.603736] usb usb3: SerialNumber: 0000:00:13.2
[    0.603907] hub 3-0:1.0: USB hub found
[    0.603917] hub 3-0:1.0: 5 ports detected
[    0.604127] ohci-pci 0000:00:13.0: OHCI PCI host controller
[    0.604138] ohci-pci 0000:00:13.0: new USB bus registered, assigned bus number 4
[    0.604175] ohci-pci 0000:00:13.0: irq 18, io mem 0xfeb49000
[    0.658460] usb usb4: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 6.15
[    0.658463] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.658465] usb usb4: Product: OHCI PCI host controller
[    0.658466] usb usb4: Manufacturer: Linux 6.15.9-arch1-1 ohci_hcd
[    0.658467] usb usb4: SerialNumber: 0000:00:13.0
[    0.658563] hub 4-0:1.0: USB hub found
[    0.658572] hub 4-0:1.0: 5 ports detected
[    0.658964] xhci_hcd 0000:00:10.0: xHCI Host Controller
[    0.658969] xhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 5
[    0.659133] xhci_hcd 0000:00:10.0: hcc params 0x014042c3 hci version 0x96 quirks 0x0000000000000208
[    0.659379] xhci_hcd 0000:00:10.0: xHCI Host Controller
[    0.659382] xhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 6
[    0.659385] xhci_hcd 0000:00:10.0: Host supports USB 3.0 SuperSpeed
[    0.662590] usb usb5: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.15
[    0.662593] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.662595] usb usb5: Product: xHCI Host Controller
[    0.662596] usb usb5: Manufacturer: Linux 6.15.9-arch1-1 xhci-hcd
[    0.662597] usb usb5: SerialNumber: 0000:00:10.0
[    0.662693] hub 5-0:1.0: USB hub found
[    0.662703] hub 5-0:1.0: 2 ports detected
[    0.662803] usb usb6: We don't know the algorithms for LPM for this host, disabling LPM.
[    0.662834] usb usb6: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 6.15
[    0.662836] usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.662838] usb usb6: Product: xHCI Host Controller
[    0.662839] usb usb6: Manufacturer: Linux 6.15.9-arch1-1 xhci-hcd
[    0.662840] usb usb6: SerialNumber: 0000:00:10.0
[    0.662933] hub 6-0:1.0: USB hub found
[    0.662942] hub 6-0:1.0: 2 ports detected
[    0.663132] xhci_hcd 0000:00:10.1: xHCI Host Controller
[    0.663136] xhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 7
[    0.663298] xhci_hcd 0000:00:10.1: hcc params 0x014042c3 hci version 0x96 quirks 0x0000000000000208
[    0.663535] xhci_hcd 0000:00:10.1: xHCI Host Controller
[    0.663538] xhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 8
[    0.663541] xhci_hcd 0000:00:10.1: Host supports USB 3.0 SuperSpeed
[    0.666757] usb usb7: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.15
[    0.666759] usb usb7: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.666761] usb usb7: Product: xHCI Host Controller
[    0.666762] usb usb7: Manufacturer: Linux 6.15.9-arch1-1 xhci-hcd
[    0.666763] usb usb7: SerialNumber: 0000:00:10.1
[    0.666863] hub 7-0:1.0: USB hub found
[    0.666872] hub 7-0:1.0: 2 ports detected
[    0.666970] usb usb8: We don't know the algorithms for LPM for this host, disabling LPM.
[    0.666996] usb usb8: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 6.15
[    0.666999] usb usb8: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.667000] usb usb8: Product: xHCI Host Controller
[    0.667002] usb usb8: Manufacturer: Linux 6.15.9-arch1-1 xhci-hcd
[    0.667003] usb usb8: SerialNumber: 0000:00:10.1
[    0.667098] hub 8-0:1.0: USB hub found
[    0.667107] hub 8-0:1.0: 2 ports detected
[    0.667229] usbcore: registered new interface driver usbserial_generic
[    0.667238] usbserial: USB Serial support registered for generic
[    0.667276] i8042: PNP: No PS/2 controller found.
[    0.667373] rtc_cmos 00:05: RTC can wake from S4
[    0.667595] rtc_cmos 00:05: registered as rtc0
[    0.667620] rtc_cmos 00:05: setting system clock to 2025-08-14T14:21:52 UTC (1755181312)
[    0.667650] rtc_cmos 00:05: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
[    0.667701] amd_pstate: the _CPC object is not present in SBIOS or ACPI disabled
[    0.668124] simple-framebuffer simple-framebuffer.0: [drm] Registered 1 planes with drm panic
[    0.668126] [drm] Initialized simpledrm 1.0.0 for simple-framebuffer.0 on minor 0
[    0.669705] fbcon: Deferring console take-over
[    0.669711] simple-framebuffer simple-framebuffer.0: [drm] fb0: simpledrmdrmfb frame buffer device
[    0.669769] hid: raw HID events driver (C) Jiri Kosina
[    0.669808] usbcore: registered new interface driver usbhid
[    0.669809] usbhid: USB HID core driver
[    0.669891] drop_monitor: Initializing network drop monitor service
[    0.670194] NET: Registered PF_INET6 protocol family
[    0.719840] Freeing initrd memory: 55084K
[    0.727642] Segment Routing with IPv6
[    0.727647] RPL Segment Routing with IPv6
[    0.727668] In-situ OAM (IOAM) with IPv6
[    0.727699] NET: Registered PF_PACKET protocol family
[    0.727760] x86/pm: family 0x15 cpu detected, MSR saving is needed during suspending.
[    0.728047] microcode: Current revision: 0x06001119
[    0.728136] IPI shorthand broadcast: enabled
[    0.731101] sched_clock: Marking stable (697660220, 32581741)->(757256275, -27014314)
[    0.731274] registered taskstats version 1
[    0.731596] Loading compiled-in X.509 certificates
[    0.740018] Loaded X.509 cert 'Build time autogenerated kernel key: fe6b385b4e4616e889bee7ce4d741f05caf1b4d2'
[    0.744963] zswap: loaded using pool zstd/zsmalloc
[    0.745064] Demotion targets for Node 0: null
[    0.745356] Key type .fscrypt registered
[    0.745357] Key type fscrypt-provisioning registered
[    0.746988] Btrfs loaded, zoned=yes, fsverity=yes
[    0.747035] Key type big_key registered
[    0.747267] integrity: Loading X.509 certificate: UEFI:db
[    0.751378] integrity: Loaded X.509 cert 'ASUSTeK MotherBoard SW Key Certificate: da83b990422ebc8c441f8d8b039a65a2'
[    0.751384] integrity: Loading X.509 certificate: UEFI:db
[    0.751605] integrity: Loaded X.509 cert 'ASUSTeK Notebook SW Key Certificate: b8e581e4df77a5bb4282d5ccfc00c071'
[    0.751606] integrity: Loading X.509 certificate: UEFI:db
[    0.751631] integrity: Loaded X.509 cert 'Microsoft Corporation UEFI CA 2011: 13adbf4309bd82709c8cd54f316ed522988a1bd4'
[    0.751633] integrity: Loading X.509 certificate: UEFI:db
[    0.751651] integrity: Loaded X.509 cert 'Microsoft Windows Production PCA 2011: a92902398e16c49778cd90f99e4f9ae17c55af53'
[    0.751653] integrity: Loading X.509 certificate: UEFI:db
[    0.751870] integrity: Loaded X.509 cert 'Canonical Ltd. Master Certificate Authority: ad91990bc22ab1f517048c23b6655a268e345a63'
[    0.754691] PM:   Magic number: 5:372:384
[    0.754707] usb usb2: hash matches
[    0.755276] ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    0.755307] ata4: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    0.755392] ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    0.755997] ata2.00: ATA-10: ADATA SU800, Q0518BS, max UDMA/133
[    0.756019] ata2.00: 250069680 sectors, multi 2: LBA48 NCQ (depth 32), AA
[    0.756123] ata4.00: HPA detected: current 976771055, native 976773168
[    0.756132] ata4.00: ATA-8: HGST HTS545050A7E680, GR2OA3B0, max UDMA/133
[    0.756340] ata6.00: ATA-8: ST31000528AS, HP35, max UDMA/100
[    0.756343] ata6.00: 1953525168 sectors, multi 16: LBA48 NCQ (depth 32)
[    0.756358] ata2.00: Features: Dev-Sleep
[    0.756473] ata4.00: 976771055 sectors, multi 16: LBA48 NCQ (depth 32), AA
[    0.756834] ata2.00: configured for UDMA/133
[    0.756971] scsi 1:0:0:0: Direct-Access     ATA      ADATA SU800      8BS  PQ: 0 ANSI: 5
[    0.757077] RAS: Correctable Errors collector initialized.
[    0.757318] sd 1:0:0:0: [sda] 250069680 512-byte logical blocks: (128 GB/119 GiB)
[    0.757331] sd 1:0:0:0: [sda] Write Protect is off
[    0.757334] sd 1:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    0.757350] sd 1:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    0.757377] sd 1:0:0:0: [sda] Preferred minimum I/O size 512 bytes
[    0.757491] ata6.00: configured for UDMA/100
[    0.757503] ata4.00: configured for UDMA/133
[    0.757596] scsi 3:0:0:0: Direct-Access     ATA      HGST HTS545050A7 A3B0 PQ: 0 ANSI: 5
[    0.758039] sd 3:0:0:0: [sdb] 976771055 512-byte logical blocks: (500 GB/466 GiB)
[    0.758046] sd 3:0:0:0: [sdb] 4096-byte physical blocks
[    0.758058] sd 3:0:0:0: [sdb] Write Protect is off
[    0.758061] sd 3:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    0.758079] scsi 5:0:0:0: Direct-Access     ATA      ST31000528AS     HP35 PQ: 0 ANSI: 5
[    0.758081] sd 3:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    0.758120] sd 3:0:0:0: [sdb] Preferred minimum I/O size 4096 bytes
[    0.758593] sd 5:0:0:0: [sdc] 1953525168 512-byte logical blocks: (1.00 TB/932 GiB)
[    0.758607] sd 5:0:0:0: [sdc] Write Protect is off
[    0.758609] sd 5:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[    0.758624] sd 5:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    0.758653] sd 5:0:0:0: [sdc] Preferred minimum I/O size 512 bytes
[    0.766278] clk: Disabling unused clocks
[    0.766285] PM: genpd: Disabling unused power domains
[    0.766291]  sda: sda1 sda2 sda3 sda4
[    0.766457] sd 1:0:0:0: [sda] Attached SCSI disk
[    0.774984]  sdc: sdc1
[    0.775039] sd 5:0:0:0: [sdc] Attached SCSI disk
[    0.787384] usb 2-3: new high-speed USB device number 2 using ehci-pci
[    0.803345]  sdb: sdb1
[    0.803425] sd 3:0:0:0: [sdb] Attached SCSI disk
[    0.805413] Freeing unused decrypted memory: 2028K
[    0.806743] Freeing unused kernel image (initmem) memory: 4644K
[    0.806787] Write protecting the kernel read-only data: 38912k
[    0.807214] Freeing unused kernel image (text/rodata gap) memory: 764K
[    0.807891] Freeing unused kernel image (rodata/data gap) memory: 1904K
[    0.843556] usb 3-2: new high-speed USB device number 2 using ehci-pci
[    0.848644] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    0.848649] rodata_test: all tests were successful
[    0.848655] Run /init as init process
[    0.848656]   with arguments:
[    0.848658]     /init
[    0.848659]   with environment:
[    0.848659]     HOME=/
[    0.848660]     TERM=linux
[    0.848661]     BOOT_IMAGE=/boot/vmlinuz-linux
[    0.913830] usb 2-3: New USB device found, idVendor=0bda, idProduct=1a2b, bcdDevice= 0.00
[    0.913837] usb 2-3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    0.913839] usb 2-3: Product: DISK
[    0.913841] usb 2-3: Manufacturer: Realtek
[    0.925099] usb_storage: loading out-of-tree module taints kernel.
[    0.925170] usb_storage: module verification failed: signature and/or required key missing - tainting kernel
[    0.931483] usb-storage 2-3:1.0: USB Mass Storage device detected
[    0.931772] usb-storage 2-3:1.0: device ignored
[    0.938318] usbcore: registered new interface driver usb-storage
[    0.942880] usbcore: registered new interface driver uas
[    0.969559] usb 3-2: New USB device found, idVendor=0bda, idProduct=a192, bcdDevice= 2.00
[    0.969567] usb 3-2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    0.969570] usb 3-2: Product: DISK
[    0.969572] usb 3-2: Manufacturer: Realtek
[    0.969858] usb-storage 3-2:1.0: USB Mass Storage device detected
[    0.970001] usb-storage 3-2:1.0: device ignored
[    1.216448] [drm] radeon kernel modesetting enabled.
[    1.239880] radeon 0000:00:01.0: vgaarb: deactivate vga console
[    1.240053] [drm] initializing kernel modesetting (ARUBA 0x1002:0x9901 0x1043:0x8526 0x00).
[    1.240127] ATOM BIOS: 113
[    1.240189] radeon 0000:00:01.0: VRAM: 512M 0x0000000000000000 - 0x000000001FFFFFFF (512M used)
[    1.240192] radeon 0000:00:01.0: GTT: 1024M 0x0000000020000000 - 0x000000005FFFFFFF
[    1.240196] [drm] Detected VRAM RAM=512M, BAR=256M
[    1.240197] [drm] RAM width 64bits DDR
[    1.240294] [drm] radeon: 512M of VRAM memory ready
[    1.240297] [drm] radeon: 1024M of GTT memory ready.
[    1.240310] [drm] Loading ARUBA Microcode
[    1.240517] [drm] Internal thermal controller without fan control
[    1.240898] [drm] radeon: dpm initialized
[    1.242779] [drm] Found VCE firmware/feedback version 50.0.1 / 17!
[    1.242794] [drm] GART: num cpu pages 262144, num gpu pages 262144
[    1.245602] usb 1-5: new full-speed USB device number 2 using ohci-pci
[    1.253595] usb 4-4: new low-speed USB device number 2 using ohci-pci
[    1.266013] [drm] PCIE GART of 1024M enabled (table at 0x00000000001D6000).
[    1.266132] radeon 0000:00:01.0: WB enabled
[    1.266135] radeon 0000:00:01.0: fence driver on ring 0 uses gpu addr 0x0000000020000c00
[    1.266511] radeon 0000:00:01.0: fence driver on ring 5 uses gpu addr 0x0000000000075a18
[    1.286701] radeon 0000:00:01.0: fence driver on ring 6 uses gpu addr 0x0000000020000c18
[    1.286706] radeon 0000:00:01.0: fence driver on ring 7 uses gpu addr 0x0000000020000c1c
[    1.286708] radeon 0000:00:01.0: fence driver on ring 1 uses gpu addr 0x0000000020000c04
[    1.286710] radeon 0000:00:01.0: fence driver on ring 2 uses gpu addr 0x0000000020000c08
[    1.286712] radeon 0000:00:01.0: fence driver on ring 3 uses gpu addr 0x0000000020000c0c
[    1.286713] radeon 0000:00:01.0: fence driver on ring 4 uses gpu addr 0x0000000020000c10
[    1.286906] radeon 0000:00:01.0: radeon: MSI limited to 32-bit
[    1.286967] radeon 0000:00:01.0: radeon: using MSI.
[    1.286988] [drm] radeon: irq initialized.
[    1.305501] [drm] ring test on 0 succeeded in 3 usecs
[    1.305510] [drm] ring test on 3 succeeded in 4 usecs
[    1.305516] [drm] ring test on 4 succeeded in 3 usecs
[    1.351556] [drm] ring test on 5 succeeded in 2 usecs
[    1.371570] [drm] UVD initialized successfully.
[    1.407424] usb 1-5: New USB device found, idVendor=0bda, idProduct=5852, bcdDevice= 0.00
[    1.407432] usb 1-5: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    1.407434] usb 1-5: Product: Bluetooth Radio
[    1.407436] usb 1-5: Manufacturer: Realtek
[    1.407437] usb 1-5: SerialNumber: 00e04c000001
[    1.412428] usb 4-4: New USB device found, idVendor=046d, idProduct=c077, bcdDevice=72.00
[    1.412432] usb 4-4: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    1.412434] usb 4-4: Product: USB Optical Mouse
[    1.412435] usb 4-4: Manufacturer: Logitech
[    1.418655] input: Logitech USB Optical Mouse as /devices/pci0000:00/0000:00:13.0/usb4/4-4/4-4:1.0/0003:046D:C077.0001/input/input2
[    1.418749] hid-generic 0003:046D:C077.0001: input,hidraw0: USB HID v1.11 Mouse [Logitech USB Optical Mouse] on usb-0000:00:13.0-4/input0
[    1.462600] tsc: Refined TSC clocksource calibration: 3818.998 MHz
[    1.462607] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x6e18e4af21c, max_idle_ns: 881590542384 ns
[    1.462659] clocksource: Switched to clocksource tsc
[    1.481704] [drm] ring test on 6 succeeded in 18 usecs
[    1.481716] [drm] ring test on 7 succeeded in 4 usecs
[    1.481717] [drm] VCE initialized successfully.
[    1.481992] [drm] ib test on ring 0 succeeded in 0 usecs
[    1.482050] [drm] ib test on ring 3 succeeded in 0 usecs
[    1.482103] [drm] ib test on ring 4 succeeded in 0 usecs
[    1.999769] usb 4-5: new full-speed USB device number 3 using ohci-pci
[    2.005796] [drm] ib test on ring 5 succeeded
[    2.156420] usb 4-5: New USB device found, idVendor=05af, idProduct=1023, bcdDevice= 0.00
[    2.156427] usb 4-5: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    2.156429] usb 4-5: Product: Ghost Key Elimiantion Keyboard
[    2.156431] usb 4-5: Manufacturer: Sunrex/JME
[    2.162697] input: Sunrex/JME Ghost Key Elimiantion Keyboard as /devices/pci0000:00/0000:00:13.0/usb4/4-5/4-5:1.0/0003:05AF:1023.0002/input/input3
[    2.250784] hid-generic 0003:05AF:1023.0002: input,hidraw1: USB HID v1.11 Keyboard [Sunrex/JME Ghost Key Elimiantion Keyboard] on usb-0000:00:13.0-5/input0
[    2.253805] input: Sunrex/JME Ghost Key Elimiantion Keyboard Consumer Control as /devices/pci0000:00/0000:00:13.0/usb4/4-5/4-5:1.1/0003:05AF:1023.0003/input/input4
[    2.305093] input: Sunrex/JME Ghost Key Elimiantion Keyboard System Control as /devices/pci0000:00/0000:00:13.0/usb4/4-5/4-5:1.1/0003:05AF:1023.0003/input/input5
[    2.305180] hid-generic 0003:05AF:1023.0003: input,hidraw2: USB HID v1.11 Device [Sunrex/JME Ghost Key Elimiantion Keyboard] on usb-0000:00:13.0-5/input1
[    2.533782] [drm] ib test on ring 6 succeeded
[    3.037832] [drm] ib test on ring 7 succeeded
[    3.038102] [drm] Radeon Display Connectors
[    3.038103] [drm] Connector 0:
[    3.038105] [drm]   HDMI-A-1
[    3.038106] [drm]   HPD1
[    3.038107] [drm]   DDC: 0x6530 0x6530 0x6534 0x6534 0x6538 0x6538 0x653c 0x653c
[    3.038110] [drm]   Encoders:
[    3.038111] [drm]     DFP1: INTERNAL_UNIPHY2
[    3.038112] [drm] Connector 1:
[    3.038114] [drm]   VGA-1
[    3.038115] [drm]   HPD2
[    3.038116] [drm]   DDC: 0x6540 0x6540 0x6544 0x6544 0x6548 0x6548 0x654c 0x654c
[    3.038118] [drm]   Encoders:
[    3.038119] [drm]     CRT1: INTERNAL_UNIPHY2
[    3.038120] [drm]     CRT1: NUTMEG
[    3.038121] [drm] Connector 2:
[    3.038122] [drm]   DVI-D-1
[    3.038123] [drm]   HPD3
[    3.038124] [drm]   DDC: 0x6550 0x6550 0x6554 0x6554 0x6558 0x6558 0x655c 0x655c
[    3.038126] [drm]   Encoders:
[    3.038127] [drm]     DFP2: INTERNAL_UNIPHY
[    3.060284] [drm] Initialized radeon 2.50.0 for 0000:00:01.0 on minor 0
[    3.162235] [drm] fb mappable at 0xC03E9000
[    3.162240] [drm] vram apper at 0xC0000000
[    3.162242] [drm] size 8294400
[    3.162243] [drm] fb depth is 24
[    3.162244] [drm]    pitch is 7680
[    3.162411] fbcon: radeondrmfb (fb0) is primary device
[    3.162413] fbcon: Deferring console take-over
[    3.162416] radeon 0000:00:01.0: [drm] fb0: radeondrmfb frame buffer device
[    3.213465] fbcon: Taking over console
[    3.235521] EXT4-fs (sda3): mounted filesystem 7e5f26b7-dfb4-4127-a8db-b4a8a512c3c0 r/w with ordered data mode. Quota mode: none.
[    3.360538] Console: switching to colour frame buffer device 240x67
[    3.549597] systemd[1]: systemd 257.8-1-arch running in system mode (+PAM +AUDIT -SELINUX -APPARMOR -IMA +IPE +SMACK +SECCOMP +GCRYPT +GNUTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD +LIBCRYPTSETUP +LIBCRYPTSETUP_PLUGINS +LIBFDISK +PCRE2 +PWQUALITY +P11KIT +QRENCODE +TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD +BPF_FRAMEWORK +BTF +XKBCOMMON +UTMP -SYSVINIT +LIBARCHIVE)
[    3.549604] systemd[1]: Detected architecture x86-64.
[    3.551520] systemd[1]: Hostname set to <BM5220>.
[    3.706540] systemd[1]: bpf-restrict-fs: LSM BPF program attached
[    3.999835] systemd[1]: Queued start job for default target Graphical Interface.
[    4.022064] systemd[1]: Created slice Virtual Machine and Container Slice.
[    4.022978] systemd[1]: Created slice Slice /system/dirmngr.
[    4.023344] systemd[1]: Created slice Slice /system/getty.
[    4.023734] systemd[1]: Created slice Slice /system/gpg-agent.
[    4.024120] systemd[1]: Created slice Slice /system/gpg-agent-browser.
[    4.024497] systemd[1]: Created slice Slice /system/gpg-agent-extra.
[    4.024898] systemd[1]: Created slice Slice /system/gpg-agent-ssh.
[    4.025281] systemd[1]: Created slice Slice /system/keyboxd.
[    4.025657] systemd[1]: Created slice Slice /system/modprobe.
[    4.026038] systemd[1]: Created slice Slice /system/systemd-fsck.
[    4.026318] systemd[1]: Created slice User and Session Slice.
[    4.026385] systemd[1]: Started Dispatch Password Requests to Console Directory Watch.
[    4.026431] systemd[1]: Started Forward Password Requests to Wall Directory Watch.
[    4.026622] systemd[1]: Set up automount Arbitrary Executable File Formats File System Automount Point.
[    4.026648] systemd[1]: Expecting device /dev/disk/by-uuid/6B8E-B343...
[    4.026658] systemd[1]: Expecting device /dev/disk/by-uuid/b9849882-1cdf-4abc-99e8-5ea9811ca848...
[    4.026665] systemd[1]: Expecting device /dev/disk/by-uuid/bb847ad5-cf9a-46c3-a6bc-b1a6a02f25fb...
[    4.026677] systemd[1]: Reached target Local Encrypted Volumes.
[    4.026693] systemd[1]: Reached target Login Prompts.
[    4.026712] systemd[1]: Reached target Local Integrity Protected Volumes.
[    4.026737] systemd[1]: Reached target Path Units.
[    4.026754] systemd[1]: Reached target Remote File Systems.
[    4.026768] systemd[1]: Reached target Slice Units.
[    4.026790] systemd[1]: Reached target Swaps.
[    4.026813] systemd[1]: Reached target Local Verity Protected Volumes.
[    4.026892] systemd[1]: Listening on Device-mapper event daemon FIFOs.
[    4.027012] systemd[1]: Listening on LVM2 poll daemon socket.
[    4.028501] systemd[1]: Listening on Process Core Dump Socket.
[    4.029377] systemd[1]: Listening on Credential Encryption/Decryption.
[    4.029482] systemd[1]: Listening on Journal Socket (/dev/log).
[    4.029569] systemd[1]: Listening on Journal Sockets.
[    4.029614] systemd[1]: TPM PCR Measurements was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
[    4.029630] systemd[1]: Make TPM PCR Policy was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
[    4.029718] systemd[1]: Listening on udev Control Socket.
[    4.029773] systemd[1]: Listening on udev Kernel Socket.
[    4.031062] systemd[1]: Mounting Huge Pages File System...
[    4.031794] systemd[1]: Mounting POSIX Message Queue File System...
[    4.032800] systemd[1]: Mounting Kernel Debug File System...
[    4.036767] systemd[1]: Mounting Kernel Trace File System...
[    4.038063] systemd[1]: Starting Create List of Static Device Nodes...
[    4.040331] systemd[1]: Starting Monitoring of LVM2 mirrors, snapshots etc. using dmeventd or progress polling...
[    4.044056] systemd[1]: Starting Load Kernel Module configfs...
[    4.054499] systemd[1]: Starting Load Kernel Module dm_mod...
[    4.055931] systemd[1]: Starting Load Kernel Module drm...
[    4.057251] systemd[1]: Starting Load Kernel Module fuse...
[    4.059778] systemd[1]: Starting Load Kernel Module loop...
[    4.059842] systemd[1]: File System Check on Root Device was skipped because of an unmet condition check (ConditionPathIsReadWrite=!/).
[    4.059898] systemd[1]: Clear Stale Hibernate Storage Info was skipped because of an unmet condition check (ConditionPathExists=/sys/firmware/efi/efivars/HibernateLocation-8cf2644b-4b0b-428f-9387-6d876050dc67).
[    4.064311] systemd[1]: Starting Journal Service...
[    4.068352] systemd[1]: Starting Load Kernel Modules...
[    4.068380] systemd[1]: TPM PCR Machine ID Measurement was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
[    4.069666] systemd[1]: Starting Remount Root and Kernel File Systems...
[    4.069752] systemd[1]: Early TPM SRK Setup was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
[    4.072374] systemd[1]: Starting Load udev Rules from Credentials...
[    4.074788] systemd[1]: Starting Coldplug All udev Devices...
[    4.077223] systemd[1]: Mounted Huge Pages File System.
[    4.077344] systemd[1]: Mounted POSIX Message Queue File System.
[    4.077440] systemd[1]: Mounted Kernel Debug File System.
[    4.084397] systemd[1]: Mounted Kernel Trace File System.
[    4.084807] systemd[1]: Finished Create List of Static Device Nodes.
[    4.085161] systemd[1]: modprobe@configfs.service: Deactivated successfully.
[    4.085391] systemd[1]: Finished Load Kernel Module configfs.
[    4.085727] systemd[1]: modprobe@drm.service: Deactivated successfully.
[    4.085958] systemd[1]: Finished Load Kernel Module drm.
[    4.086344] systemd[1]: modprobe@fuse.service: Deactivated successfully.
[    4.087181] systemd[1]: Finished Load Kernel Module fuse.
[    4.088627] loop: module loaded
[    4.090013] systemd[1]: Mounting FUSE Control File System...
[    4.093240] device-mapper: uevent: version 1.0.3
[    4.093630] device-mapper: ioctl: 4.49.0-ioctl (2025-01-17) initialised: dm-devel@lists.linux.dev
[    4.094786] systemd[1]: Mounting Kernel Configuration File System...
[    4.101938] systemd[1]: Starting Create Static Device Nodes in /dev gracefully...
[    4.103673] systemd[1]: modprobe@dm_mod.service: Deactivated successfully.
[    4.107859] systemd[1]: Finished Load Kernel Module dm_mod.
[    4.108356] systemd[1]: modprobe@loop.service: Deactivated successfully.
[    4.108580] systemd[1]: Finished Load Kernel Module loop.
[    4.110878] sd 1:0:0:0: Attached scsi generic sg0 type 0
[    4.110968] sd 3:0:0:0: Attached scsi generic sg1 type 0
[    4.111016] sd 5:0:0:0: Attached scsi generic sg2 type 0
[    4.111270] systemd[1]: Finished Load udev Rules from Credentials.
[    4.112305] EXT4-fs (sda3): re-mounted 7e5f26b7-dfb4-4127-a8db-b4a8a512c3c0.
[    4.113805] systemd[1]: Repartition Root Disk was skipped because no trigger condition checks were met.
[    4.114578] systemd[1]: Mounted FUSE Control File System.
[    4.117653] systemd[1]: Finished Remount Root and Kernel File Systems.
[    4.118609] systemd-journald[291]: Collecting audit messages is disabled.
[    4.121680] systemd[1]: Rebuild Hardware Database was skipped because no trigger condition checks were met.
[    4.125829] systemd[1]: Starting Load/Save OS Random Seed...
[    4.125865] systemd[1]: TPM SRK Setup was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
[    4.126675] systemd[1]: Mounted Kernel Configuration File System.
[    4.137679] it87: Found IT8603E chip at 0x290, revision 1
[    4.144753] systemd[1]: Finished Load Kernel Modules.
[    4.146461] systemd[1]: Starting Apply Kernel Variables...
[    4.180844] systemd[1]: Finished Create Static Device Nodes in /dev gracefully.
[    4.182250] systemd[1]: Starting Create System Users...
[    4.188181] systemd[1]: Finished Apply Kernel Variables.
[    4.192598] random: crng init done
[    4.197271] systemd[1]: Finished Load/Save OS Random Seed.
[    4.208738] systemd[1]: Started Journal Service.
[    4.230133] systemd-journald[291]: Received client request to flush runtime journal.
[    4.612658] mousedev: PS/2 mouse device common for all mice
[    4.684261] input: PC Speaker as /devices/platform/pcspkr/input/input6
[    4.708542] acpi_cpufreq: overriding BIOS provided _PSD data
[    4.723660] piix4_smbus 0000:00:14.0: SMBus Host Controller at 0xb00, revision 0
[    4.723667] piix4_smbus 0000:00:14.0: Using register 0x2e for SMBus port selection
[    4.724508] i2c i2c-7: Successfully instantiated SPD at 0x50
[    4.725099] i2c i2c-7: Successfully instantiated SPD at 0x51
[    4.726513] i2c i2c-7: Successfully instantiated SPD at 0x52
[    4.727089] i2c i2c-7: Successfully instantiated SPD at 0x53
[    4.727186] piix4_smbus 0000:00:14.0: Auxiliary SMBus Host Controller at 0xb20
[    4.731682] cryptd: max_cpu_qlen set to 1000
[    4.826788] asus_wmi: ASUS WMI generic driver loaded
[    4.828761] sp5100_tco: SP5100/SB800 TCO WatchDog Timer Driver
[    4.829823] sp5100-tco sp5100-tco: Using 0xfed80b00 for watchdog MMIO address
[    4.836595] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[    4.836689] sp5100-tco sp5100-tco: initialized. heartbeat=60 sec (nowayout=0)
[    4.838178] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    4.838415] Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7ff06c7248db18c600'
[    4.848209] asus_wmi: Initialization: 0x0
[    4.848252] asus_wmi: BIOS WMI version: 0.9
[    4.848319] asus_wmi: SFUN value: 0x0
[    4.848323] eeepc-wmi eeepc-wmi: Detected ASUSWMI, use DCTS
[    4.859180] snd_hda_intel 0000:00:01.1: enabling device (0000 -> 0002)
[    4.859330] snd_hda_intel 0000:00:01.1: Force to non-snoop mode
[    4.866610] input: Eee PC WMI hotkeys as /devices/platform/eeepc-wmi/input/input7
[    4.871299] at24 7-0050: supply vcc not found, using dummy regulator
[    4.873346] r8169 0000:03:00.0 eth0: RTL8168f/8111f, 50:46:5d:b3:63:82, XID 480, IRQ 46
[    4.873355] r8169 0000:03:00.0 eth0: jumbo features [frames: 9194 bytes, tx checksumming: ko]
[    4.876127] at24 7-0050: 256 byte spd EEPROM, read-only
[    4.876173] at24 7-0051: supply vcc not found, using dummy regulator
[    4.878022] at24 7-0051: 256 byte spd EEPROM, read-only
[    4.878090] at24 7-0052: supply vcc not found, using dummy regulator
[    4.880066] at24 7-0052: 256 byte spd EEPROM, read-only
[    4.880097] at24 7-0053: supply vcc not found, using dummy regulator
[    4.881904] at24 7-0053: 256 byte spd EEPROM, read-only
[    4.921894] snd_hda_intel 0000:00:01.1: bound 0000:00:01.0 (ops radeon_audio_component_bind_ops [radeon])
[    4.923814] r8169 0000:03:00.0 enp3s0: renamed from eth0
[    4.926114] input: HDA ATI HDMI HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:01.1/sound/card0/input8
[    5.102138] rtw89_8852ce_git 0000:02:00.0: loaded firmware rtw89/rtw8852c_fw-2.bin
[    5.102267] ACPI: \: failed to evaluate _DSM e8c3a8d2-694b-004f-82bd-fe8607803aa7 rev:0 func:5 (0x1001)
[    5.102278] rtw89_8852ce_git 0000:02:00.0: enabling device (0000 -> 0003)
[    5.105322] rtw89_8852ce_git 0000:02:00.0: git commit 2b491dca7e3dda64eeada28079ee4c02b78f48ac
[    5.110995] rtw89_8852ce_git 0000:02:00.0: Firmware version 0.27.129.1 (a71be205), cmd version 0, type 1
[    5.110999] rtw89_8852ce_git 0000:02:00.0: Firmware version 0.27.129.1 (a71be205), cmd version 0, type 3
[    5.153723] EXT4-fs (sdc1): warning: mounting unchecked fs, running e2fsck is recommended
[    5.182971] EXT4-fs (sdc1): mounted filesystem bb847ad5-cf9a-46c3-a6bc-b1a6a02f25fb r/w without journal. Quota mode: none.
[    5.222426] kvm_amd: TSC scaling supported
[    5.222431] kvm_amd: Nested Virtualization enabled
[    5.222432] kvm_amd: Nested Paging enabled
[    5.222434] kvm_amd: LBR virtualization supported
[    5.357776] rtw89_8852ce_git 0000:02:00.0: chip rfe_type is 1
[    5.379444] rtw89_8852ce_git 0000:02:00.0: Firmware element BB version: 00 28 00 00
[    5.379524] rtw89_8852ce_git 0000:02:00.0: Firmware element radio A version: 00 63 00 00
[    5.379580] rtw89_8852ce_git 0000:02:00.0: Firmware element NCTL version: 00 11 00 00
[    5.379798] rtw89_8852ce_git 0000:02:00.0: Firmware element TXPWR version: 00 78 00 00
[    5.379805] rtw89_8852ce_git 0000:02:00.0: Firmware element PWR_TRK version: 00 26 00 00
[    5.379814] rtw89_8852ce_git 0000:02:00.0: Firmware element REGD version: 00 48 00 39
[    5.381917] ACPI: \: failed to evaluate _DSM e8c3a8d2-694b-004f-82bd-fe8607803aa7 rev:0 func:10 (0x1001)
[    5.381922] ACPI: \: failed to evaluate _DSM e8c3a8d2-694b-004f-82bd-fe8607803aa7 rev:0 func:6 (0x1001)
[    5.381926] ACPI: \: failed to evaluate _DSM e8c3a8d2-694b-004f-82bd-fe8607803aa7 rev:0 func:3 (0x1001)
[    5.381928] ACPI: \: failed to evaluate _DSM e8c3a8d2-694b-004f-82bd-fe8607803aa7 rev:0 func:4 (0x1001)
[    5.381931] ACPI: \: failed to evaluate _DSM e8c3a8d2-694b-004f-82bd-fe8607803aa7 rev:0 func:7 (0x1001)
[    5.381933] ACPI: \: failed to evaluate _DSM e8c3a8d2-694b-004f-82bd-fe8607803aa7 rev:0 func:11 (0x1001)
[    5.382450] rtw89_8852ce_git 0000:02:00.0: rfkill hardware state changed to enable
[    5.390599] rtw89_8852ce_git 0000:02:00.0 wlp2s0: renamed from wlan0
[    5.493025] EXT4-fs (sdb1): mounted filesystem b9849882-1cdf-4abc-99e8-5ea9811ca848 r/w with ordered data mode. Quota mode: none.
[    6.285927] RTL8211E Gigabit Ethernet r8169-0-300:00: attached PHY driver (mii_bus:phy_addr=r8169-0-300:00, irq=MAC)
[    6.449956] r8169 0000:03:00.0 enp3s0: Link is Down
[    6.543755] usb 2-3: USB disconnect, device number 2
[    6.585348] usb 3-2: USB disconnect, device number 2
[    6.906595] usb 3-2: new high-speed USB device number 5 using ehci-pci
[    7.033535] usb 3-2: New USB device found, idVendor=0bda, idProduct=f192, bcdDevice= 2.00
[    7.033548] usb 3-2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    7.033554] usb 3-2: Product: 802.11n  WLAN Adapter
[    7.033559] usb 3-2: Manufacturer: Realtek
[    7.033563] usb 3-2: SerialNumber: 005CC2FF1087
[    7.166604] usb 2-3: new high-speed USB device number 4 using ehci-pci
[    7.281654] r8169 0000:03:00.0: invalid VPD tag 0xff (size 0) at offset 0; assume missing optional EEPROM
[    7.292699] usb 2-3: New USB device found, idVendor=2001, idProduct=332a, bcdDevice= 0.00
[    7.292706] usb 2-3: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    7.292709] usb 2-3: Product: 802.11ax WLAN Adapter
[    7.292711] usb 2-3: Manufacturer: Realtek
[    7.292713] usb 2-3: SerialNumber: 00e04c000001
[    7.360311] rtw89_8851bu_git 2-3:1.2: loaded firmware rtw89/rtw8851b_fw.bin
[    7.360458] rtw89_8851bu_git 2-3:1.2: git commit 2b491dca7e3dda64eeada28079ee4c02b78f48ac
[    7.362189] rtw89_8851bu_git 2-3:1.2: MAC has already powered on
[    7.391818] rtw89_8851bu_git 2-3:1.2: Firmware version 0.29.41.3 (65cefb31), cmd version 0, type 5
[    7.391826] rtw89_8851bu_git 2-3:1.2: Firmware version 0.29.41.3 (65cefb31), cmd version 0, type 3
[    7.941618] rtw89_8851bu_git 2-3:1.2: chip rfe_type is 4
[    8.007127] ACPI: \: failed to evaluate _DSM e8c3a8d2-694b-004f-82bd-fe8607803aa7 rev:0 func:10 (0x1001)
[    8.007142] ACPI: \: failed to evaluate _DSM e8c3a8d2-694b-004f-82bd-fe8607803aa7 rev:0 func:6 (0x1001)
[    8.009628] rtw89_8851bu_git 2-3:1.2: rfkill hardware state changed to enable
[    8.009885] usbcore: registered new interface driver rtw89_8851bu_git
[    8.031906] rtw89_8851bu_git 2-3:1.2 wlp0s18f2u3i2: renamed from wlan0

