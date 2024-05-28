Return-Path: <stable+bounces-47584-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85EBE8D2480
	for <lists+stable@lfdr.de>; Tue, 28 May 2024 21:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02F92286D94
	for <lists+stable@lfdr.de>; Tue, 28 May 2024 19:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACCDF171E59;
	Tue, 28 May 2024 19:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="GfIFO9b+"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE993174EE1
	for <stable@vger.kernel.org>; Tue, 28 May 2024 19:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716923884; cv=none; b=ZI+Quo8mNflS6ARL8BuprStThWrjvLUFhFQ8L7/FmFsviBkPhUD1rl1r0O4vopWSoAvJBdfkRhE+WrUm0yiyrR4q+rUXOnmP9vejMh4gFPIguhdsiFzlVuX6Dw6cnoA3e7i7dQoh1uVEwNSCki4Ms5MdyeBE/P8eOztUu0xMYxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716923884; c=relaxed/simple;
	bh=/j5i3X3sO9q6fjB8KBJ9XA05I+VmqemtTvylGtuW/I4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ujJ3AtuyMFqQ4oxKgaKErqU+y3bwAdP1Hhmls03DxQ0Mkjz7hle4un16pE6x7KmJ8rN2Vveyz6FECwFsMjoM0bJFheNERmunbAM7fyY7ecCv3olDXF3ALt6KpvRBj/C6QYvfht/xy1lRMOZjkO6FsGXSCsYKkCUlnTVF+aiDIe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=GfIFO9b+; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5b2e8d73bfcso156829eaf.1
        for <stable@vger.kernel.org>; Tue, 28 May 2024 12:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1716923875; x=1717528675; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=boldEz86PuQf71NEH6iy7BOUQ6YlYzusqkfnQG7B8uU=;
        b=GfIFO9b+rU+tmyYJ7K4AAwCeMGrh04D6986k1TwObP7VyNA/+OH8i6dyZThVM5w1xg
         7DZBrfAWkZqkw8MirIQ3FNsWy93QD3OAID3HqZSgUmK635+Bk2PPFJRXgAzC3TA3/QUN
         jkNCUSgMm3kYH3x1DlGa87l45vHGdQi7XICzTuLoQ0a9r9R9DOMA0Gzw3o7B0kr34GVC
         5OIs7o2O9W6AqbaFndbe3STFwBks58C6Qkjb7cffoWKTQ/Wv++XCn6Ylk7ltllCwwkPX
         9L8lO6WiqemjfN+b77qqhT9B8EHMcoBouzbnUQIfPQ6Uu7urrYk3rVyho1qhq2UO34K2
         ZHPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716923875; x=1717528675;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=boldEz86PuQf71NEH6iy7BOUQ6YlYzusqkfnQG7B8uU=;
        b=tf9oIyNJq5zY0eRa+JClkWhpZkl4HOo3Tpl9tAb2jI0kFTG48dIQG/bFEb3fUdy6Yg
         8HpGnvUKuuE+UpzNb/ZSq9VbYFbixo2JcGUHAthsOacvKJ7Q9EB6qgbkkjTKxYhFqy1L
         Xl3K2b4J6lzkUS4GlSVc+dT5LNmvR89gsnnI0XYM+Pa7udczoBQ55+eGludnvTr8aZu7
         8KI8E4JixEuH4415x+Yx1KAKhkgbBbOp+3yeKs4JSdxjlZIfPakVwpcVzLvukFUMAqB5
         nYiJmXV3sm+nyx++ZFxSjSpfbRVY94te0wSNnCgW5GLL8ldgbJ5Xqp+hOSc0T4grRreq
         dzug==
X-Forwarded-Encrypted: i=1; AJvYcCWxktTqnLEUg4ThG65TCVJcpWzn47odKgXSbZlozn6S5QBblp8J797CUASYSGqCFct1EUiyLGdnHYY+xhxYYgqHHTVXI09u
X-Gm-Message-State: AOJu0YwMqA9XDhkDsjVv7bBD+U2Pd3auErvAHrDW19pgG1QzjlGy0qYR
	ebnQh1rfrAlOUumO0yZ4LvI8cyXQYHLDd9N2FqQO77JdUB13fANSTZEEc7EUrGQ=
X-Google-Smtp-Source: AGHT+IGYSBQUG75P2usXQxXJaJ3FVU2lr6zPvz/aTtE5h15jbA0s0ccuSjBbyH1PdW2AqA5FQNEtcg==
X-Received: by 2002:a05:6830:2d8b:b0:6f0:5119:9e4d with SMTP id 46e09a7af769-6f8d0935406mr14137424a34.0.1716923873824;
        Tue, 28 May 2024 12:17:53 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-6f8d0e7cc1esm2011378a34.71.2024.05.28.12.17.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 May 2024 12:17:52 -0700 (PDT)
Message-ID: <f3b909f3-de1d-4781-aa7a-1967abe24125@kernel.dk>
Date: Tue, 28 May 2024 13:17:51 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION][BISECTED] Scheduling errors with the AMD FX 8300 CPU
To: Thomas Gleixner <tglx@linutronix.de>,
 Tim Teichmann <teichmanntim@outlook.de>
Cc: Christian Heusel <christian@heusel.eu>, regressions@lists.linux.dev,
 x86@kernel.org, stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
 linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>
References: <7skhx6mwe4hxiul64v6azhlxnokheorksqsdbp7qw6g2jduf6c@7b5pvomauugk>
 <87r0dqdf0r.ffs@tglx>
 <gtgsklvltu5pzeiqn7fwaktdsywk2re75unapgbcarlmqkya5a@mt7pi4j2f7b3>
 <87h6ejd0wt.ffs@tglx>
 <PR3PR02MB6012CB03006F1EEE8E8B5D69B3F02@PR3PR02MB6012.eurprd02.prod.outlook.com>
 <874jajcn9r.ffs@tglx>
 <PR3PR02MB6012EDF7EBA8045FBB03C434B3F02@PR3PR02MB6012.eurprd02.prod.outlook.com>
 <87msobb2dp.ffs@tglx>
 <PR3PR02MB6012D4B2D513F6FA9D29BE5EB3F12@PR3PR02MB6012.eurprd02.prod.outlook.com>
 <87bk4pbve8.ffs@tglx>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <87bk4pbve8.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

(Adding Damien, he's the ATA guy these days - leaving the below intact)

On 5/28/24 1:15 PM, Thomas Gleixner wrote:
> Tim!
> 
> On Tue, May 28 2024 at 17:43, Tim Teichmann wrote:
>> On 24/05/27 07:17pm, Thomas Gleixner wrote:
>> I've just tested the fix you've provided in the previous email.
>> The exact patches are attached to the ticket in the archlinux bugtracker[0].
> 
> Thanks! I will write a proper changelog and ship it.
> 
>> The error regarding CPU scheduling disappeared for both kernel verions[0].
>> However, the ATA bus error still occurs.
>>
>> Also, I suppose that the ATA bus error is the same as the previous one,
>> because the only value that changes in the exception message is SAct.
>>
>> This is the message of the ATA error before the patch:
>>
>>>> May 23 23:36:49 archlinux kernel: smpboot: x86: Booting SMP configuration:
>>>> May 23 23:36:49 archlinux kernel: .... node  #0, CPUs:      #2 #4 #6
>>>> May 23 23:36:49 archlinux kernel: __common_interrupt: 2.55 No irq handler for vector
>>>> May 23 23:36:49 archlinux kernel: __common_interrupt: 4.55 No irq handler for vector
>>>> May 23 23:36:49 archlinux kernel: __common_interrupt: 6.55 No irq handler for vector
>>>>
>>>> ATA stuff:
>>>>
>>>> May 23 23:36:59 archlinux kernel: ata2.00: exception Emask 0x10 SAct 0x1fffe000 SErr 0x40d0002 action 0xe frozen
>>>
>>> That's probably just the fallout of the above.
> 
> It's in reality not related and I saw some other AHCI fallout fly by.
> 
>> And that's the message after the patch:
>>
>> [    4.877584] ata2.00: exception Emask 0x10 SAct 0x80000000 SErr 0x40d0002 action 0xe frozen
>>
>> The full dmesg outputs are in the attachments.
> 
> Cc'ed the AHCI people and left the info around for them.
> 
>> Thank you,
>> Tim
>>
>>
>> [0]: https://gitlab.archlinux.org/archlinux/packaging/packages/linux/-/issues/56#note_188563
>> [    0.000000] Linux version 6.9.2-arch1-1.2 (linux@archlinux) (gcc (GCC) 14.1.1 20240522, GNU ld (GNU Binutils) 2.42.0) #1 SMP PREEMPT_DYNAMIC Mon, 27 May 2024 18:36:31 +0000
>> [    0.000000] Command line: BOOT_IMAGE=/vmlinuz-linux root=UUID=963daeed-0888-4658-9f17-18bd343dfb2a rw zswap.enabled=0 rootfstype=ext4 loglevel=3 quiet
>> [    0.000000] BIOS-provided physical RAM map:
>> [    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009f7ff] usable
>> [    0.000000] BIOS-e820: [mem 0x000000000009f800-0x000000000009ffff] reserved
>> [    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
>> [    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000bfdeffff] usable
>> [    0.000000] BIOS-e820: [mem 0x00000000bfdf0000-0x00000000bfdf2fff] ACPI NVS
>> [    0.000000] BIOS-e820: [mem 0x00000000bfdf3000-0x00000000bfdfffff] ACPI data
>> [    0.000000] BIOS-e820: [mem 0x00000000bfe00000-0x00000000bfefffff] reserved
>> [    0.000000] BIOS-e820: [mem 0x00000000e0000000-0x00000000efffffff] reserved
>> [    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000ffffffff] reserved
>> [    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000043effffff] usable
>> [    0.000000] NX (Execute Disable) protection: active
>> [    0.000000] APIC: Static calls initialized
>> [    0.000000] SMBIOS 2.4 present.
>> [    0.000000] DMI: Gigabyte Technology Co., Ltd. GA-78LMT-USB3 R2/GA-78LMT-USB3 R2, BIOS F1 11/08/2017
>> [    0.000000] tsc: Fast TSC calibration using PIT
>> [    0.000000] tsc: Detected 3322.271 MHz processor
>> [    0.002937] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
>> [    0.002941] e820: remove [mem 0x000a0000-0x000fffff] usable
>> [    0.002947] last_pfn = 0x43f000 max_arch_pfn = 0x400000000
>> [    0.002956] total RAM covered: 3070M
>> [    0.003253] Found optimal setting for mtrr clean up
>> [    0.003254]  gran_size: 64K 	chunk_size: 4M 	num_reg: 3  	lose cover RAM: 0G
>> [    0.003260] MTRR map: 7 entries (4 fixed + 3 variable; max 21), built from 9 variable MTRRs
>> [    0.003262] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
>> [    0.004111] e820: update [mem 0xbfe00000-0xffffffff] usable ==> reserved
>> [    0.004120] last_pfn = 0xbfdf0 max_arch_pfn = 0x400000000
>> [    0.007030] found SMP MP-table at [mem 0x000f5ea0-0x000f5eaf]
>> [    0.007051] Using GB pages for direct mapping
>> [    0.007376] RAMDISK: [mem 0x31c9f000-0x34e46fff]
>> [    0.007499] ACPI: Early table checksum verification disabled
>> [    0.007504] ACPI: RSDP 0x00000000000F78B0 000014 (v00 GBT   )
>> [    0.007508] ACPI: RSDT 0x00000000BFDF3000 000040 (v01 GBT    GBTUACPI 42302E31 GBTU 01010101)
>> [    0.007515] ACPI: FACP 0x00000000BFDF3080 000074 (v01 GBT    GBTUACPI 42302E31 GBTU 01010101)
>> [    0.007521] ACPI: DSDT 0x00000000BFDF3100 0069E7 (v01 GBT    GBTUACPI 00001000 MSFT 03000000)
>> [    0.007526] ACPI: FACS 0x00000000BFDF0000 000040
>> [    0.007529] ACPI: MSDM 0x00000000BFDF9BC0 000055 (v03 GBT    GBTUACPI 42302E31 GBTU 01010101)
>> [    0.007534] ACPI: HPET 0x00000000BFDF9C40 000038 (v01 GBT    GBTUACPI 42302E31 GBTU 00000098)
>> [    0.007538] ACPI: MCFG 0x00000000BFDF9C80 00003C (v01 GBT    GBTUACPI 42302E31 GBTU 01010101)
>> [    0.007542] ACPI: TAMG 0x00000000BFDF9CC0 000022 (v01 GBT    GBT   B0 5455312E BG?? 00000101)
>> [    0.007546] ACPI: APIC 0x00000000BFDF9B00 0000BC (v01 GBT    GBTUACPI 42302E31 GBTU 01010101)
>> [    0.007551] ACPI: SSDT 0x00000000BFDF9D60 001714 (v01 AMD    POWERNOW 00000001 AMD  00000001)
>> [    0.007554] ACPI: Reserving FACP table memory at [mem 0xbfdf3080-0xbfdf30f3]
>> [    0.007556] ACPI: Reserving DSDT table memory at [mem 0xbfdf3100-0xbfdf9ae6]
>> [    0.007558] ACPI: Reserving FACS table memory at [mem 0xbfdf0000-0xbfdf003f]
>> [    0.007559] ACPI: Reserving MSDM table memory at [mem 0xbfdf9bc0-0xbfdf9c14]
>> [    0.007560] ACPI: Reserving HPET table memory at [mem 0xbfdf9c40-0xbfdf9c77]
>> [    0.007561] ACPI: Reserving MCFG table memory at [mem 0xbfdf9c80-0xbfdf9cbb]
>> [    0.007562] ACPI: Reserving TAMG table memory at [mem 0xbfdf9cc0-0xbfdf9ce1]
>> [    0.007564] ACPI: Reserving APIC table memory at [mem 0xbfdf9b00-0xbfdf9bbb]
>> [    0.007565] ACPI: Reserving SSDT table memory at [mem 0xbfdf9d60-0xbfdfb473]
>> [    0.007628] No NUMA configuration found
>> [    0.007629] Faking a node at [mem 0x0000000000000000-0x000000043effffff]
>> [    0.007632] NODE_DATA(0) allocated [mem 0x43effb000-0x43effffff]
>> [    0.007673] Zone ranges:
>> [    0.007674]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
>> [    0.007677]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
>> [    0.007678]   Normal   [mem 0x0000000100000000-0x000000043effffff]
>> [    0.007680]   Device   empty
>> [    0.007682] Movable zone start for each node
>> [    0.007682] Early memory node ranges
>> [    0.007683]   node   0: [mem 0x0000000000001000-0x000000000009efff]
>> [    0.007685]   node   0: [mem 0x0000000000100000-0x00000000bfdeffff]
>> [    0.007686]   node   0: [mem 0x0000000100000000-0x000000043effffff]
>> [    0.007689] Initmem setup node 0 [mem 0x0000000000001000-0x000000043effffff]
>> [    0.007695] On node 0, zone DMA: 1 pages in unavailable ranges
>> [    0.007735] On node 0, zone DMA: 97 pages in unavailable ranges
>> [    0.054266] On node 0, zone Normal: 528 pages in unavailable ranges
>> [    0.054340] On node 0, zone Normal: 4096 pages in unavailable ranges
>> [    0.054523] ACPI: PM-Timer IO Port: 0x4008
>> [    0.054534] ACPI: LAPIC_NMI (acpi_id[0x00] dfl dfl lint[0x1])
>> [    0.054536] ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])
>> [    0.054537] ACPI: LAPIC_NMI (acpi_id[0x02] dfl dfl lint[0x1])
>> [    0.054539] ACPI: LAPIC_NMI (acpi_id[0x03] dfl dfl lint[0x1])
>> [    0.054540] ACPI: LAPIC_NMI (acpi_id[0x04] dfl dfl lint[0x1])
>> [    0.054541] ACPI: LAPIC_NMI (acpi_id[0x05] dfl dfl lint[0x1])
>> [    0.054542] ACPI: LAPIC_NMI (acpi_id[0x06] dfl dfl lint[0x1])
>> [    0.054543] ACPI: LAPIC_NMI (acpi_id[0x07] dfl dfl lint[0x1])
>> [    0.054556] IOAPIC[0]: apic_id 2, version 33, address 0xfec00000, GSI 0-23
>> [    0.054559] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
>> [    0.054561] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
>> [    0.054566] ACPI: Using ACPI (MADT) for SMP configuration information
>> [    0.054567] ACPI: HPET id: 0x10b9a201 base: 0xfed00000
>> [    0.054577] CPU topo: Max. logical packages:   1
>> [    0.054578] CPU topo: Max. logical dies:       1
>> [    0.054579] CPU topo: Max. dies per package:   1
>> [    0.054584] CPU topo: Max. threads per core:   1
>> [    0.054585] CPU topo: Num. cores per package:     8
>> [    0.054586] CPU topo: Num. threads per package:   8
>> [    0.054587] CPU topo: Allowing 8 present CPUs plus 0 hotplug CPUs
>> [    0.054599] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
>> [    0.054601] PM: hibernation: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
>> [    0.054602] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000effff]
>> [    0.054604] PM: hibernation: Registered nosave memory: [mem 0x000f0000-0x000fffff]
>> [    0.054605] PM: hibernation: Registered nosave memory: [mem 0xbfdf0000-0xbfdf2fff]
>> [    0.054606] PM: hibernation: Registered nosave memory: [mem 0xbfdf3000-0xbfdfffff]
>> [    0.054607] PM: hibernation: Registered nosave memory: [mem 0xbfe00000-0xbfefffff]
>> [    0.054608] PM: hibernation: Registered nosave memory: [mem 0xbff00000-0xdfffffff]
>> [    0.054609] PM: hibernation: Registered nosave memory: [mem 0xe0000000-0xefffffff]
>> [    0.054610] PM: hibernation: Registered nosave memory: [mem 0xf0000000-0xfebfffff]
>> [    0.054611] PM: hibernation: Registered nosave memory: [mem 0xfec00000-0xffffffff]
>> [    0.054613] [mem 0xbff00000-0xdfffffff] available for PCI devices
>> [    0.054615] Booting paravirtualized kernel on bare hardware
>> [    0.054618] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 6370452778343963 ns
>> [    0.060537] setup_percpu: NR_CPUS:320 nr_cpumask_bits:8 nr_cpu_ids:8 nr_node_ids:1
>> [    0.061434] percpu: Embedded 66 pages/cpu s233472 r8192 d28672 u524288
>> [    0.061443] pcpu-alloc: s233472 r8192 d28672 u524288 alloc=1*2097152
>> [    0.061446] pcpu-alloc: [0] 0 1 2 3 [0] 4 5 6 7 
>> [    0.061468] Kernel command line: BOOT_IMAGE=/vmlinuz-linux root=UUID=963daeed-0888-4658-9f17-18bd343dfb2a rw zswap.enabled=0 rootfstype=ext4 loglevel=3 quiet
>> [    0.061547] Unknown kernel command line parameters "BOOT_IMAGE=/vmlinuz-linux", will be passed to user space.
>> [    0.064351] Dentry cache hash table entries: 2097152 (order: 12, 16777216 bytes, linear)
>> [    0.065732] Inode-cache hash table entries: 1048576 (order: 11, 8388608 bytes, linear)
>> [    0.065812] Fallback order for Node 0: 0 
>> [    0.065818] Built 1 zonelists, mobility grouping on.  Total pages: 4123960
>> [    0.065820] Policy zone: Normal
>> [    0.066244] mem auto-init: stack:all(zero), heap alloc:on, heap free:off
>> [    0.066251] software IO TLB: area num 8.
>> [    0.151668] Memory: 16301808K/16758328K available (18432K kernel code, 2164K rwdata, 13296K rodata, 3412K init, 3624K bss, 456260K reserved, 0K cma-reserved)
>> [    0.159910] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
>> [    0.160107] ftrace: allocating 49852 entries in 195 pages
>> [    0.171323] ftrace: allocated 195 pages with 4 groups
>> [    0.171486] Dynamic Preempt: full
>> [    0.171715] rcu: Preemptible hierarchical RCU implementation.
>> [    0.171717] rcu: 	RCU restricting CPUs from NR_CPUS=320 to nr_cpu_ids=8.
>> [    0.171718] rcu: 	RCU priority boosting: priority 1 delay 500 ms.
>> [    0.171720] 	Trampoline variant of Tasks RCU enabled.
>> [    0.171720] 	Rude variant of Tasks RCU enabled.
>> [    0.171721] 	Tracing variant of Tasks RCU enabled.
>> [    0.171722] rcu: RCU calculated value of scheduler-enlistment delay is 30 jiffies.
>> [    0.171723] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=8
>> [    0.171731] RCU Tasks: Setting shift to 3 and lim to 1 rcu_task_cb_adjust=1.
>> [    0.171734] RCU Tasks Rude: Setting shift to 3 and lim to 1 rcu_task_cb_adjust=1.
>> [    0.171736] RCU Tasks Trace: Setting shift to 3 and lim to 1 rcu_task_cb_adjust=1.
>> [    0.177324] NR_IRQS: 20736, nr_irqs: 488, preallocated irqs: 16
>> [    0.177539] rcu: srcu_init: Setting srcu_struct sizes based on contention.
>> [    0.177631] kfence: initialized - using 2097152 bytes for 255 objects at 0x(____ptrval____)-0x(____ptrval____)
>> [    0.177707] spurious 8259A interrupt: IRQ7.
>> [    0.177727] Console: colour dummy device 80x25
>> [    0.177730] printk: legacy console [tty0] enabled
>> [    0.178132] ACPI: Core revision 20230628
>> [    0.178358] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484873504 ns
>> [    0.178391] APIC: Switch to symmetric I/O mode setup
>> [    0.178896] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
>> [    0.195044] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x2fe37b0bf9a, max_idle_ns: 440795315222 ns
>> [    0.195049] Calibrating delay loop (skipped), value calculated using timer frequency.. 6647.39 BogoMIPS (lpj=11074236)
>> [    0.195073] LVT offset 1 assigned for vector 0xf9
>> [    0.195078] Last level iTLB entries: 4KB 512, 2MB 1024, 4MB 512
>> [    0.195079] Last level dTLB entries: 4KB 1024, 2MB 1024, 4MB 512, 1GB 0
>> [    0.195084] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
>> [    0.195087] Spectre V2 : Mitigation: Retpolines
>> [    0.195088] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
>> [    0.195089] Spectre V2 : Spectre v2 / SpectreRSB : Filling RSB on VMEXIT
>> [    0.195090] Spectre V2 : Enabling Speculation Barrier for firmware calls
>> [    0.195091] RETBleed: Mitigation: untrained return thunk
>> [    0.195093] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
>> [    0.195095] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl
>> [    0.195099] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
>> [    0.195101] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
>> [    0.195102] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
>> [    0.195104] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
>> [    0.195106] x86/fpu: Enabled xstate features 0x7, context size is 832 bytes, using 'standard' format.
>> [    0.218738] Freeing SMP alternatives memory: 40K
>> [    0.218744] pid_max: default: 32768 minimum: 301
>> [    0.219474] LSM: initializing lsm=capability,landlock,lockdown,yama,bpf
>> [    0.220315] landlock: Up and running.
>> [    0.220317] Yama: becoming mindful.
>> [    0.220324] LSM support for eBPF active
>> [    0.220571] Mount-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
>> [    0.220611] Mountpoint-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
>> [    0.228515] APIC calibration not consistent with PM-Timer: 0ms instead of 100ms
>> [    0.228521] APIC delta adjusted to PM-Timer: 1261600 (1512)
>> [    0.228531] smpboot: CPU0: AMD FX(tm)-8300 Eight-Core Processor (family: 0x15, model: 0x2, stepping: 0x0)
>> [    0.228924] Performance Events: Fam15h core perfctr, AMD PMU driver.
>> [    0.228930] ... version:                0
>> [    0.228931] ... bit width:              48
>> [    0.228932] ... generic registers:      6
>> [    0.228933] ... value mask:             0000ffffffffffff
>> [    0.228934] ... max period:             00007fffffffffff
>> [    0.228936] ... fixed-purpose events:   0
>> [    0.228936] ... event mask:             000000000000003f
>> [    0.229048] signal: max sigframe size: 1776
>> [    0.229102] rcu: Hierarchical SRCU implementation.
>> [    0.229104] rcu: 	Max phase no-delay instances is 1000.
>> [    0.231414] MCE: In-kernel MCE decoding enabled.
>> [    0.231495] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
>> [    0.231629] smp: Bringing up secondary CPUs ...
>> [    0.231713] smpboot: x86: Booting SMP configuration:
>> [    0.231713] .... node  #0, CPUs:      #1 #2 #3 #4 #5 #6 #7
>> [    0.000815] __common_interrupt: 1.55 No irq handler for vector
>> [    0.000815] __common_interrupt: 2.55 No irq handler for vector
>> [    0.000815] __common_interrupt: 3.55 No irq handler for vector
>> [    0.000815] __common_interrupt: 4.55 No irq handler for vector
>> [    0.000815] __common_interrupt: 5.55 No irq handler for vector
>> [    0.000815] __common_interrupt: 6.55 No irq handler for vector
>> [    0.000815] __common_interrupt: 7.55 No irq handler for vector
>> [    0.262715] smp: Brought up 1 node, 8 CPUs
>> [    0.262715] smpboot: Total of 8 processors activated (53177.18 BogoMIPS)
>> [    0.266086] devtmpfs: initialized
>> [    0.266086] x86/mm: Memory block size: 128MB
>> [    0.269083] ACPI: PM: Registering ACPI NVS region [mem 0xbfdf0000-0xbfdf2fff] (12288 bytes)
>> [    0.269083] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 6370867519511994 ns
>> [    0.269083] futex hash table entries: 2048 (order: 5, 131072 bytes, linear)
>> [    0.269083] pinctrl core: initialized pinctrl subsystem
>> [    0.269108] PM: RTC time: 14:51:09, date: 2024-05-28
>> [    0.269538] NET: Registered PF_NETLINK/PF_ROUTE protocol family
>> [    0.269947] DMA: preallocated 2048 KiB GFP_KERNEL pool for atomic allocations
>> [    0.270211] DMA: preallocated 2048 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
>> [    0.270526] DMA: preallocated 2048 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
>> [    0.270538] audit: initializing netlink subsys (disabled)
>> [    0.271744] audit: type=2000 audit(1716907868.096:1): state=initialized audit_enabled=0 res=1
>> [    0.271862] thermal_sys: Registered thermal governor 'fair_share'
>> [    0.271864] thermal_sys: Registered thermal governor 'bang_bang'
>> [    0.271866] thermal_sys: Registered thermal governor 'step_wise'
>> [    0.271867] thermal_sys: Registered thermal governor 'user_space'
>> [    0.271868] thermal_sys: Registered thermal governor 'power_allocator'
>> [    0.271881] cpuidle: using governor ladder
>> [    0.271881] cpuidle: using governor menu
>> [    0.271881] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
>> [    0.272117] PCI: ECAM [mem 0xe0000000-0xefffffff] (base 0xe0000000) for domain 0000 [bus 00-ff]
>> [    0.272122] PCI: ECAM [mem 0xe0000000-0xefffffff] reserved as E820 entry
>> [    0.272140] PCI: Using configuration type 1 for base access
>> [    0.272340] kprobes: kprobe jump-optimization is enabled. All kprobes are optimized if possible.
>> [    0.275131] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
>> [    0.275131] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
>> [    0.275131] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
>> [    0.275131] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
>> [    0.275140] Demotion targets for Node 0: null
>> [    0.275248] fbcon: Taking over console
>> [    0.275248] ACPI: Added _OSI(Module Device)
>> [    0.275248] ACPI: Added _OSI(Processor Device)
>> [    0.275248] ACPI: Added _OSI(3.0 _SCP Extensions)
>> [    0.275248] ACPI: Added _OSI(Processor Aggregator Device)
>> [    0.278535] ACPI: 2 ACPI AML tables successfully acquired and loaded
>> [    0.278811] ACPI Error: AE_NOT_FOUND, While resolving a named reference package element - LNKC (20230628/dspkginit-438)
>> [    0.278818] ACPI Error: AE_NOT_FOUND, While resolving a named reference package element - LNKD (20230628/dspkginit-438)
>> [    0.278824] ACPI Error: AE_NOT_FOUND, While resolving a named reference package element - LNKA (20230628/dspkginit-438)
>> [    0.278830] ACPI Error: AE_NOT_FOUND, While resolving a named reference package element - LNKB (20230628/dspkginit-438)
>> [    0.278842] ACPI Error: AE_NOT_FOUND, While resolving a named reference package element - LNKD (20230628/dspkginit-438)
>> [    0.278848] ACPI Error: AE_NOT_FOUND, While resolving a named reference package element - LNKA (20230628/dspkginit-438)
>> [    0.278854] ACPI Error: AE_NOT_FOUND, While resolving a named reference package element - LNKB (20230628/dspkginit-438)
>> [    0.278859] ACPI Error: AE_NOT_FOUND, While resolving a named reference package element - LNKC (20230628/dspkginit-438)
>> [    0.278871] ACPI Error: AE_NOT_FOUND, While resolving a named reference package element - LNKA (20230628/dspkginit-438)
>> [    0.278877] ACPI Error: AE_NOT_FOUND, While resolving a named reference package element - LNKB (20230628/dspkginit-438)
>> [    0.278882] ACPI Error: AE_NOT_FOUND, While resolving a named reference package element - LNKC (20230628/dspkginit-438)
>> [    0.278888] ACPI Error: AE_NOT_FOUND, While resolving a named reference package element - LNKD (20230628/dspkginit-438)
>> [    0.278899] ACPI Error: AE_NOT_FOUND, While resolving a named reference package element - LNKB (20230628/dspkginit-438)
>> [    0.278905] ACPI Error: AE_NOT_FOUND, While resolving a named reference package element - LNKC (20230628/dspkginit-438)
>> [    0.278910] ACPI Error: AE_NOT_FOUND, While resolving a named reference package element - LNKD (20230628/dspkginit-438)
>> [    0.278916] ACPI Error: AE_NOT_FOUND, While resolving a named reference package element - LNKA (20230628/dspkginit-438)
>> [    0.278927] ACPI Error: AE_NOT_FOUND, While resolving a named reference package element - LNKC (20230628/dspkginit-438)
>> [    0.278933] ACPI Error: AE_NOT_FOUND, While resolving a named reference package element - LNKD (20230628/dspkginit-438)
>> [    0.278938] ACPI Error: AE_NOT_FOUND, While resolving a named reference package element - LNKA (20230628/dspkginit-438)
>> [    0.278944] ACPI Error: AE_NOT_FOUND, While resolving a named reference package element - LNKB (20230628/dspkginit-438)
>> [    0.278955] ACPI Error: AE_NOT_FOUND, While resolving a named reference package element - LNKD (20230628/dspkginit-438)
>> [    0.278961] ACPI Error: AE_NOT_FOUND, While resolving a named reference package element - LNKA (20230628/dspkginit-438)
>> [    0.278966] ACPI Error: AE_NOT_FOUND, While resolving a named reference package element - LNKB (20230628/dspkginit-438)
>> [    0.278972] ACPI Error: AE_NOT_FOUND, While resolving a named reference package element - LNKC (20230628/dspkginit-438)
>> [    0.278983] ACPI Error: AE_NOT_FOUND, While resolving a named reference package element - LNKB (20230628/dspkginit-438)
>> [    0.278989] ACPI Error: AE_NOT_FOUND, While resolving a named reference package element - LNKC (20230628/dspkginit-438)
>> [    0.278994] ACPI Error: AE_NOT_FOUND, While resolving a named reference package element - LNKD (20230628/dspkginit-438)
>> [    0.278999] ACPI Error: AE_NOT_FOUND, While resolving a named reference package element - LNKA (20230628/dspkginit-438)
>> [    0.279010] ACPI Error: AE_NOT_FOUND, While resolving a named reference package element - LNKC (20230628/dspkginit-438)
>> [    0.279016] ACPI Error: AE_NOT_FOUND, While resolving a named reference package element - LNKD (20230628/dspkginit-438)
>> [    0.279021] ACPI Error: AE_NOT_FOUND, While resolving a named reference package element - LNKA (20230628/dspkginit-438)
>> [    0.279026] ACPI Error: AE_NOT_FOUND, While resolving a named reference package element - LNKB (20230628/dspkginit-438)
>> [    0.279038] ACPI Error: AE_NOT_FOUND, While resolving a named reference package element - LNKD (20230628/dspkginit-438)
>> [    0.279043] ACPI Error: AE_NOT_FOUND, While resolving a named reference package element - LNKA (20230628/dspkginit-438)
>> [    0.279049] ACPI Error: AE_NOT_FOUND, While resolving a named reference package element - LNKB (20230628/dspkginit-438)
>> [    0.279054] ACPI Error: AE_NOT_FOUND, While resolving a named reference package element - LNKC (20230628/dspkginit-438)
>> [    0.279065] ACPI Error: AE_NOT_FOUND, While resolving a named reference package element - LNKA (20230628/dspkginit-438)
>> [    0.279071] ACPI Error: AE_NOT_FOUND, While resolving a named reference package element - LNKB (20230628/dspkginit-438)
>> [    0.279076] ACPI Error: AE_NOT_FOUND, While resolving a named reference package element - LNKC (20230628/dspkginit-438)
>> [    0.279082] ACPI Error: AE_NOT_FOUND, While resolving a named reference package element - LNKD (20230628/dspkginit-438)
>> [    0.285252] ACPI: _OSC evaluation for CPUs failed, trying _PDC
>> [    0.285324] ACPI: Interpreter enabled
>> [    0.285345] ACPI: PM: (supports S0 S3 S4 S5)
>> [    0.285347] ACPI: Using IOAPIC for interrupt routing
>> [    0.285667] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
>> [    0.285669] PCI: Using E820 reservations for host bridge windows
>> [    0.285824] ACPI: Enabled 5 GPEs in block 00 to 1F
>> [    0.291427] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
>> [    0.291435] acpi PNP0A03:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI EDR HPX-Type3]
>> [    0.291811] PCI host bridge to bus 0000:00
>> [    0.291814] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
>> [    0.291817] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
>> [    0.291819] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000dffff window]
>> [    0.291822] pci_bus 0000:00: root bus resource [mem 0xc0000000-0xfebfffff window]
>> [    0.291824] pci_bus 0000:00: root bus resource [bus 00-ff]
>> [    0.291842] pci 0000:00:00.0: [1022:9600] type 00 class 0x060000 conventional PCI endpoint
>> [    0.291854] pci 0000:00:00.0: [Firmware Bug]: BAR 3: invalid; can't size
>> [    0.291930] pci 0000:00:02.0: [1022:9603] type 01 class 0x060400 PCIe Root Port
>> [    0.291943] pci 0000:00:02.0: PCI bridge to [bus 01]
>> [    0.291947] pci 0000:00:02.0:   bridge window [io  0xe000-0xefff]
>> [    0.291950] pci 0000:00:02.0:   bridge window [mem 0xfb000000-0xfcffffff]
>> [    0.291955] pci 0000:00:02.0:   bridge window [mem 0xc0000000-0xdfffffff 64bit pref]
>> [    0.291961] pci 0000:00:02.0: enabling Extended Tags
>> [    0.291989] pci 0000:00:02.0: PME# supported from D0 D3hot D3cold
>> [    0.292095] pci 0000:00:04.0: [1022:9604] type 01 class 0x060400 PCIe Root Port
>> [    0.292108] pci 0000:00:04.0: PCI bridge to [bus 02]
>> [    0.292112] pci 0000:00:04.0:   bridge window [io  0xd000-0xdfff]
>> [    0.292115] pci 0000:00:04.0:   bridge window [mem 0xfda00000-0xfdafffff]
>> [    0.292120] pci 0000:00:04.0:   bridge window [mem 0xfdf00000-0xfdffffff 64bit pref]
>> [    0.292126] pci 0000:00:04.0: enabling Extended Tags
>> [    0.292152] pci 0000:00:04.0: PME# supported from D0 D3hot D3cold
>> [    0.292253] pci 0000:00:06.0: [1022:9606] type 01 class 0x060400 PCIe Root Port
>> [    0.292266] pci 0000:00:06.0: PCI bridge to [bus 03]
>> [    0.292270] pci 0000:00:06.0:   bridge window [io  0xc000-0xcfff]
>> [    0.292272] pci 0000:00:06.0:   bridge window [mem 0xfde00000-0xfdefffff]
>> [    0.292277] pci 0000:00:06.0:   bridge window [mem 0xfdd00000-0xfddfffff 64bit pref]
>> [    0.292283] pci 0000:00:06.0: enabling Extended Tags
>> [    0.292309] pci 0000:00:06.0: PME# supported from D0 D3hot D3cold
>> [    0.292433] pci 0000:00:11.0: [1002:4390] type 00 class 0x01018f conventional PCI endpoint
>> [    0.292450] pci 0000:00:11.0: BAR 0 [io  0xff00-0xff07]
>> [    0.292460] pci 0000:00:11.0: BAR 1 [io  0xfe00-0xfe03]
>> [    0.292469] pci 0000:00:11.0: BAR 2 [io  0xfd00-0xfd07]
>> [    0.292478] pci 0000:00:11.0: BAR 3 [io  0xfc00-0xfc03]
>> [    0.292487] pci 0000:00:11.0: BAR 4 [io  0xfb00-0xfb0f]
>> [    0.292497] pci 0000:00:11.0: BAR 5 [mem 0xfe02f000-0xfe02f3ff]
>> [    0.292518] pci 0000:00:11.0: set SATA to AHCI mode
>> [    0.292622] pci 0000:00:12.0: [1002:4397] type 00 class 0x0c0310 conventional PCI endpoint
>> [    0.292639] pci 0000:00:12.0: BAR 0 [mem 0xfe02e000-0xfe02efff]
>> [    0.292770] pci 0000:00:12.1: [1002:4398] type 00 class 0x0c0310 conventional PCI endpoint
>> [    0.292787] pci 0000:00:12.1: BAR 0 [mem 0xfe02d000-0xfe02dfff]
>> [    0.292927] pci 0000:00:12.2: [1002:4396] type 00 class 0x0c0320 conventional PCI endpoint
>> [    0.292944] pci 0000:00:12.2: BAR 0 [mem 0xfe02c000-0xfe02c0ff]
>> [    0.293023] pci 0000:00:12.2: supports D1 D2
>> [    0.293025] pci 0000:00:12.2: PME# supported from D0 D1 D2 D3hot
>> [    0.293112] pci 0000:00:13.0: [1002:4397] type 00 class 0x0c0310 conventional PCI endpoint
>> [    0.293129] pci 0000:00:13.0: BAR 0 [mem 0xfe02b000-0xfe02bfff]
>> [    0.293258] pci 0000:00:13.1: [1002:4398] type 00 class 0x0c0310 conventional PCI endpoint
>> [    0.293275] pci 0000:00:13.1: BAR 0 [mem 0xfe02a000-0xfe02afff]
>> [    0.293409] pci 0000:00:13.2: [1002:4396] type 00 class 0x0c0320 conventional PCI endpoint
>> [    0.293426] pci 0000:00:13.2: BAR 0 [mem 0xfe029000-0xfe0290ff]
>> [    0.293506] pci 0000:00:13.2: supports D1 D2
>> [    0.293508] pci 0000:00:13.2: PME# supported from D0 D1 D2 D3hot
>> [    0.293602] pci 0000:00:14.0: [1002:4385] type 00 class 0x0c0500 conventional PCI endpoint
>> [    0.293762] pci 0000:00:14.1: [1002:439c] type 00 class 0x01018a conventional PCI endpoint
>> [    0.293778] pci 0000:00:14.1: BAR 0 [io  0x0000-0x0007]
>> [    0.293788] pci 0000:00:14.1: BAR 1 [io  0x0000-0x0003]
>> [    0.293797] pci 0000:00:14.1: BAR 2 [io  0x0000-0x0007]
>> [    0.293806] pci 0000:00:14.1: BAR 3 [io  0x0000-0x0003]
>> [    0.293815] pci 0000:00:14.1: BAR 4 [io  0xfa00-0xfa0f]
>> [    0.293835] pci 0000:00:14.1: BAR 0 [io  0x01f0-0x01f7]: legacy IDE quirk
>> [    0.293837] pci 0000:00:14.1: BAR 1 [io  0x03f6]: legacy IDE quirk
>> [    0.293838] pci 0000:00:14.1: BAR 2 [io  0x0170-0x0177]: legacy IDE quirk
>> [    0.293840] pci 0000:00:14.1: BAR 3 [io  0x0376]: legacy IDE quirk
>> [    0.293949] pci 0000:00:14.2: [1002:4383] type 00 class 0x040300 conventional PCI endpoint
>> [    0.293971] pci 0000:00:14.2: BAR 0 [mem 0xfe024000-0xfe027fff 64bit]
>> [    0.294037] pci 0000:00:14.2: PME# supported from D0 D3hot D3cold
>> [    0.294116] pci 0000:00:14.3: [1002:439d] type 00 class 0x060100 conventional PCI endpoint
>> [    0.294285] pci 0000:00:14.4: [1002:4384] type 01 class 0x060401 conventional PCI bridge
>> [    0.294316] pci 0000:00:14.4: PCI bridge to [bus 04] (subtractive decode)
>> [    0.294321] pci 0000:00:14.4:   bridge window [io  0xb000-0xbfff]
>> [    0.294325] pci 0000:00:14.4:   bridge window [mem 0xfdc00000-0xfdcfffff]
>> [    0.294331] pci 0000:00:14.4:   bridge window [mem 0xfdb00000-0xfdbfffff pref]
>> [    0.294416] pci 0000:00:14.5: [1002:4399] type 00 class 0x0c0310 conventional PCI endpoint
>> [    0.294433] pci 0000:00:14.5: BAR 0 [mem 0xfe028000-0xfe028fff]
>> [    0.294564] pci 0000:00:18.0: [1022:1600] type 00 class 0x060000 conventional PCI endpoint
>> [    0.294614] pci 0000:00:18.1: [1022:1601] type 00 class 0x060000 conventional PCI endpoint
>> [    0.294661] pci 0000:00:18.2: [1022:1602] type 00 class 0x060000 conventional PCI endpoint
>> [    0.294710] pci 0000:00:18.3: [1022:1603] type 00 class 0x060000 conventional PCI endpoint
>> [    0.294759] pci 0000:00:18.4: [1022:1604] type 00 class 0x060000 conventional PCI endpoint
>> [    0.294808] pci 0000:00:18.5: [1022:1605] type 00 class 0x060000 conventional PCI endpoint
>> [    0.294917] pci 0000:01:00.0: [10de:1c82] type 00 class 0x030000 PCIe Legacy Endpoint
>> [    0.294930] pci 0000:01:00.0: BAR 0 [mem 0xfb000000-0xfbffffff]
>> [    0.294941] pci 0000:01:00.0: BAR 1 [mem 0xc0000000-0xcfffffff 64bit pref]
>> [    0.294952] pci 0000:01:00.0: BAR 3 [mem 0xde000000-0xdfffffff 64bit pref]
>> [    0.294960] pci 0000:01:00.0: BAR 5 [io  0xef00-0xef7f]
>> [    0.294967] pci 0000:01:00.0: ROM [mem 0x00000000-0x0007ffff pref]
>> [    0.294995] pci 0000:01:00.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
>> [    0.295075] pci 0000:01:00.0: 32.000 Gb/s available PCIe bandwidth, limited by 2.5 GT/s PCIe x16 link at 0000:00:02.0 (capable of 126.016 Gb/s with 8.0 GT/s PCIe x16 link)
>> [    0.295151] pci 0000:01:00.1: [10de:0fb9] type 00 class 0x040300 PCIe Endpoint
>> [    0.295165] pci 0000:01:00.1: BAR 0 [mem 0xfcffc000-0xfcffffff]
>> [    0.295315] pci 0000:00:02.0: PCI bridge to [bus 01]
>> [    0.295357] pci 0000:02:00.0: [1106:3483] type 00 class 0x0c0330 PCIe Endpoint
>> [    0.295372] pci 0000:02:00.0: BAR 0 [mem 0xfdaff000-0xfdafffff 64bit]
>> [    0.295433] pci 0000:02:00.0: PME# supported from D0 D1 D2 D3hot D3cold
>> [    0.295503] pci 0000:00:04.0: PCI bridge to [bus 02]
>> [    0.295552] pci 0000:03:00.0: [10ec:8168] type 00 class 0x020000 PCIe Endpoint
>> [    0.295568] pci 0000:03:00.0: BAR 0 [io  0xce00-0xceff]
>> [    0.295589] pci 0000:03:00.0: BAR 2 [mem 0xfdeff000-0xfdefffff 64bit]
>> [    0.295602] pci 0000:03:00.0: BAR 4 [mem 0xfddfc000-0xfddfffff 64bit pref]
>> [    0.295684] pci 0000:03:00.0: supports D1 D2
>> [    0.295685] pci 0000:03:00.0: PME# supported from D0 D1 D2 D3hot D3cold
>> [    0.295808] pci 0000:00:06.0: PCI bridge to [bus 03]
>> [    0.295824] pci_bus 0000:04: extended config space not accessible
>> [    0.295886] pci 0000:00:14.4: PCI bridge to [bus 04] (subtractive decode)
>> [    0.295895] pci 0000:00:14.4:   bridge window [io  0x0000-0x0cf7 window] (subtractive decode)
>> [    0.295897] pci 0000:00:14.4:   bridge window [io  0x0d00-0xffff window] (subtractive decode)
>> [    0.295900] pci 0000:00:14.4:   bridge window [mem 0x000a0000-0x000dffff window] (subtractive decode)
>> [    0.295902] pci 0000:00:14.4:   bridge window [mem 0xc0000000-0xfebfffff window] (subtractive decode)
>> [    0.296188] ACPI: PCI: Interrupt link LNKA configured for IRQ 0
>> [    0.296190] ACPI: PCI: Interrupt link LNKA disabled
>> [    0.296247] ACPI: PCI: Interrupt link LNKB configured for IRQ 0
>> [    0.296249] ACPI: PCI: Interrupt link LNKB disabled
>> [    0.296306] ACPI: PCI: Interrupt link LNKC configured for IRQ 0
>> [    0.296308] ACPI: PCI: Interrupt link LNKC disabled
>> [    0.296363] ACPI: PCI: Interrupt link LNKD configured for IRQ 0
>> [    0.296365] ACPI: PCI: Interrupt link LNKD disabled
>> [    0.296421] ACPI: PCI: Interrupt link LNKE configured for IRQ 0
>> [    0.296422] ACPI: PCI: Interrupt link LNKE disabled
>> [    0.296477] ACPI: PCI: Interrupt link LNKF configured for IRQ 0
>> [    0.296479] ACPI: PCI: Interrupt link LNKF disabled
>> [    0.296535] ACPI: PCI: Interrupt link LNK0 configured for IRQ 0
>> [    0.296536] ACPI: PCI: Interrupt link LNK0 disabled
>> [    0.296591] ACPI: PCI: Interrupt link LNK1 configured for IRQ 0
>> [    0.296592] ACPI: PCI: Interrupt link LNK1 disabled
>> [    0.298404] iommu: Default domain type: Translated
>> [    0.298404] iommu: DMA domain TLB invalidation policy: lazy mode
>> [    0.298664] SCSI subsystem initialized
>> [    0.298672] libata version 3.00 loaded.
>> [    0.298672] ACPI: bus type USB registered
>> [    0.298672] usbcore: registered new interface driver usbfs
>> [    0.298672] usbcore: registered new interface driver hub
>> [    0.298672] usbcore: registered new device driver usb
>> [    0.298672] EDAC MC: Ver: 3.0.0
>> [    0.299557] NetLabel: Initializing
>> [    0.299557] NetLabel:  domain hash size = 128
>> [    0.299557] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
>> [    0.299557] NetLabel:  unlabeled traffic allowed by default
>> [    0.299557] mctp: management component transport protocol core
>> [    0.299557] NET: Registered PF_MCTP protocol family
>> [    0.299557] PCI: Using ACPI for IRQ routing
>> [    0.306688] PCI: pci_cache_line_size set to 64 bytes
>> [    0.306740] e820: reserve RAM buffer [mem 0x0009f800-0x0009ffff]
>> [    0.306743] e820: reserve RAM buffer [mem 0xbfdf0000-0xbfffffff]
>> [    0.306744] e820: reserve RAM buffer [mem 0x43f000000-0x43fffffff]
>> [    0.308426] pci 0000:01:00.0: vgaarb: setting as boot VGA device
>> [    0.308426] pci 0000:01:00.0: vgaarb: bridge control possible
>> [    0.308426] pci 0000:01:00.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
>> [    0.308426] vgaarb: loaded
>> [    0.308429] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0
>> [    0.308434] hpet0: 4 comparators, 32-bit 14.318180 MHz counter
>> [    0.311840] clocksource: Switched to clocksource tsc-early
>> [    0.313225] VFS: Disk quotas dquot_6.6.0
>> [    0.313287] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
>> [    0.313388] pnp: PnP ACPI init
>> [    0.313472] system 00:00: [io  0x04d0-0x04d1] has been reserved
>> [    0.313475] system 00:00: [io  0x0220-0x0225] has been reserved
>> [    0.313478] system 00:00: [io  0x0290-0x0294] has been reserved
>> [    0.313783] system 00:01: [io  0x4100-0x411f] has been reserved
>> [    0.313790] system 00:01: [io  0x0228-0x022f] has been reserved
>> [    0.313793] system 00:01: [io  0x040b] has been reserved
>> [    0.313795] system 00:01: [io  0x04d6] has been reserved
>> [    0.313797] system 00:01: [io  0x0c00-0x0c01] has been reserved
>> [    0.313799] system 00:01: [io  0x0c14] has been reserved
>> [    0.313801] system 00:01: [io  0x0c50-0x0c52] has been reserved
>> [    0.313803] system 00:01: [io  0x0c6c-0x0c6d] has been reserved
>> [    0.313805] system 00:01: [io  0x0c6f] has been reserved
>> [    0.313807] system 00:01: [io  0x0cd0-0x0cd1] has been reserved
>> [    0.313809] system 00:01: [io  0x0cd2-0x0cd3] has been reserved
>> [    0.313810] system 00:01: [io  0x0cd4-0x0cdf] has been reserved
>> [    0.313812] system 00:01: [io  0x4000-0x40fe] has been reserved
>> [    0.313814] system 00:01: [io  0x4210-0x4217] has been reserved
>> [    0.313816] system 00:01: [io  0x0b00-0x0b0f] has been reserved
>> [    0.313818] system 00:01: [io  0x0b10-0x0b1f] has been reserved
>> [    0.313820] system 00:01: [io  0x0b20-0x0b3f] has been reserved
>> [    0.313822] system 00:01: [mem 0x00000000-0x00000fff window] could not be reserved
>> [    0.313825] system 00:01: [mem 0xfee00400-0xfee00fff window] has been reserved
>> [    0.314737] system 00:05: [mem 0xe0000000-0xefffffff] has been reserved
>> [    0.314963] pnp 00:06: disabling [mem 0x000ce600-0x000cffff] because it overlaps 0000:01:00.0 BAR 6 [mem 0x000c0000-0x000dffff]
>> [    0.314986] system 00:06: [mem 0x000f0000-0x000f7fff] could not be reserved
>> [    0.314989] system 00:06: [mem 0x000f8000-0x000fbfff] could not be reserved
>> [    0.314991] system 00:06: [mem 0x000fc000-0x000fffff] could not be reserved
>> [    0.314993] system 00:06: [mem 0xbfdf0000-0xbfdfffff] could not be reserved
>> [    0.314996] system 00:06: [mem 0xffff0000-0xffffffff] has been reserved
>> [    0.314998] system 00:06: [mem 0x00000000-0x0009ffff] could not be reserved
>> [    0.315000] system 00:06: [mem 0x00100000-0xbfdeffff] could not be reserved
>> [    0.315003] system 00:06: [mem 0xbfe00000-0xbfefffff] has been reserved
>> [    0.315005] system 00:06: [mem 0xbff00000-0xbfffffff] could not be reserved
>> [    0.315007] system 00:06: [mem 0xfec00000-0xfec00fff] could not be reserved
>> [    0.315009] system 00:06: [mem 0xfee00000-0xfee00fff] could not be reserved
>> [    0.315011] system 00:06: [mem 0xfff80000-0xfffeffff] has been reserved
>> [    0.315035] pnp: PnP ACPI: found 7 devices
>> [    0.321759] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
>> [    0.322043] NET: Registered PF_INET protocol family
>> [    0.322351] IP idents hash table entries: 262144 (order: 9, 2097152 bytes, linear)
>> [    0.339864] tcp_listen_portaddr_hash hash table entries: 8192 (order: 5, 131072 bytes, linear)
>> [    0.339910] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
>> [    0.340073] TCP established hash table entries: 131072 (order: 8, 1048576 bytes, linear)
>> [    0.340507] TCP bind hash table entries: 65536 (order: 9, 2097152 bytes, linear)
>> [    0.340824] TCP: Hash tables configured (established 131072 bind 65536)
>> [    0.341042] MPTCP token hash table entries: 16384 (order: 6, 393216 bytes, linear)
>> [    0.341169] UDP hash table entries: 8192 (order: 6, 262144 bytes, linear)
>> [    0.341254] UDP-Lite hash table entries: 8192 (order: 6, 262144 bytes, linear)
>> [    0.341355] NET: Registered PF_UNIX/PF_LOCAL protocol family
>> [    0.341370] NET: Registered PF_XDP protocol family
>> [    0.341386] pci 0000:00:02.0: PCI bridge to [bus 01]
>> [    0.341391] pci 0000:00:02.0:   bridge window [io  0xe000-0xefff]
>> [    0.341395] pci 0000:00:02.0:   bridge window [mem 0xfb000000-0xfcffffff]
>> [    0.341398] pci 0000:00:02.0:   bridge window [mem 0xc0000000-0xdfffffff 64bit pref]
>> [    0.341403] pci 0000:00:04.0: PCI bridge to [bus 02]
>> [    0.341405] pci 0000:00:04.0:   bridge window [io  0xd000-0xdfff]
>> [    0.341408] pci 0000:00:04.0:   bridge window [mem 0xfda00000-0xfdafffff]
>> [    0.341411] pci 0000:00:04.0:   bridge window [mem 0xfdf00000-0xfdffffff 64bit pref]
>> [    0.341414] pci 0000:00:06.0: PCI bridge to [bus 03]
>> [    0.341417] pci 0000:00:06.0:   bridge window [io  0xc000-0xcfff]
>> [    0.341419] pci 0000:00:06.0:   bridge window [mem 0xfde00000-0xfdefffff]
>> [    0.341422] pci 0000:00:06.0:   bridge window [mem 0xfdd00000-0xfddfffff 64bit pref]
>> [    0.341426] pci 0000:00:14.4: PCI bridge to [bus 04]
>> [    0.341429] pci 0000:00:14.4:   bridge window [io  0xb000-0xbfff]
>> [    0.341434] pci 0000:00:14.4:   bridge window [mem 0xfdc00000-0xfdcfffff]
>> [    0.341438] pci 0000:00:14.4:   bridge window [mem 0xfdb00000-0xfdbfffff pref]
>> [    0.341445] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
>> [    0.341447] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
>> [    0.341449] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000dffff window]
>> [    0.341452] pci_bus 0000:00: resource 7 [mem 0xc0000000-0xfebfffff window]
>> [    0.341454] pci_bus 0000:01: resource 0 [io  0xe000-0xefff]
>> [    0.341456] pci_bus 0000:01: resource 1 [mem 0xfb000000-0xfcffffff]
>> [    0.341457] pci_bus 0000:01: resource 2 [mem 0xc0000000-0xdfffffff 64bit pref]
>> [    0.341459] pci_bus 0000:02: resource 0 [io  0xd000-0xdfff]
>> [    0.341461] pci_bus 0000:02: resource 1 [mem 0xfda00000-0xfdafffff]
>> [    0.341463] pci_bus 0000:02: resource 2 [mem 0xfdf00000-0xfdffffff 64bit pref]
>> [    0.341465] pci_bus 0000:03: resource 0 [io  0xc000-0xcfff]
>> [    0.341467] pci_bus 0000:03: resource 1 [mem 0xfde00000-0xfdefffff]
>> [    0.341469] pci_bus 0000:03: resource 2 [mem 0xfdd00000-0xfddfffff 64bit pref]
>> [    0.341471] pci_bus 0000:04: resource 0 [io  0xb000-0xbfff]
>> [    0.341473] pci_bus 0000:04: resource 1 [mem 0xfdc00000-0xfdcfffff]
>> [    0.341474] pci_bus 0000:04: resource 2 [mem 0xfdb00000-0xfdbfffff pref]
>> [    0.341476] pci_bus 0000:04: resource 4 [io  0x0000-0x0cf7 window]
>> [    0.341478] pci_bus 0000:04: resource 5 [io  0x0d00-0xffff window]
>> [    0.341480] pci_bus 0000:04: resource 6 [mem 0x000a0000-0x000dffff window]
>> [    0.341482] pci_bus 0000:04: resource 7 [mem 0xc0000000-0xfebfffff window]
>> [    0.364641] pci 0000:00:12.0: quirk_usb_early_handoff+0x0/0x730 took 22551 usecs
>> [    0.384684] pci 0000:00:12.1: quirk_usb_early_handoff+0x0/0x730 took 19559 usecs
>> [    0.404731] pci 0000:00:13.0: quirk_usb_early_handoff+0x0/0x730 took 19371 usecs
>> [    0.424781] pci 0000:00:13.1: quirk_usb_early_handoff+0x0/0x730 took 19569 usecs
>> [    0.444850] pci 0000:00:14.5: quirk_usb_early_handoff+0x0/0x730 took 19381 usecs
>> [    0.444885] pci 0000:01:00.1: extending delay after power-on from D3hot to 20 msec
>> [    0.444921] pci 0000:01:00.1: D0 power state depends on 0000:01:00.0
>> [    0.445120] PCI: CLS 64 bytes, default 64
>> [    0.445128] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
>> [    0.445129] software IO TLB: mapped [mem 0x00000000bbdf0000-0x00000000bfdf0000] (64MB)
>> [    0.445171] LVT offset 0 assigned for vector 0x400
>> [    0.445205] Trying to unpack rootfs image as initramfs...
>> [    0.449662] perf: AMD IBS detected (0x000000ff)
>> [    0.451294] Initialise system trusted keyrings
>> [    0.451307] Key type blacklist registered
>> [    0.451387] workingset: timestamp_bits=41 max_order=22 bucket_order=0
>> [    0.451400] zbud: loaded
>> [    0.451792] fuse: init (API version 7.40)
>> [    0.452284] integrity: Platform Keyring initialized
>> [    0.452291] integrity: Machine keyring initialized
>> [    0.467117] Key type asymmetric registered
>> [    0.467119] Asymmetric key parser 'x509' registered
>> [    0.467204] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 246)
>> [    0.467299] io scheduler mq-deadline registered
>> [    0.467301] io scheduler kyber registered
>> [    0.467357] io scheduler bfq registered
>> [    0.468354] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
>> [    0.468472] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
>> [    0.468506] ACPI: button: Power Button [PWRB]
>> [    0.468558] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
>> [    0.470399] ACPI: button: Power Button [PWRF]
>> [    0.470470] ACPI: \_PR_.C000: Found 2 idle states
>> [    0.470564] ACPI: \_PR_.C001: Found 2 idle states
>> [    0.470635] ACPI: \_PR_.C002: Found 2 idle states
>> [    0.470712] ACPI: \_PR_.C003: Found 2 idle states
>> [    0.470792] ACPI: \_PR_.C004: Found 2 idle states
>> [    0.470863] ACPI: \_PR_.C005: Found 2 idle states
>> [    0.470937] ACPI: \_PR_.C006: Found 2 idle states
>> [    0.471006] ACPI: \_PR_.C007: Found 2 idle states
>> [    0.471398] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
>> [    0.471585] 00:03: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
>> [    0.474648] Non-volatile memory driver v1.3
>> [    0.474650] Linux agpgart interface v0.103
>> [    0.474750] ACPI: bus type drm_connector registered
>> [    0.475607] ahci 0000:00:11.0: version 3.0
>> [    0.475894] ahci 0000:00:11.0: AHCI vers 0001.0100, 32 command slots, 3 Gbps, SATA mode
>> [    0.475900] ahci 0000:00:11.0: 4/4 ports implemented (port mask 0xf)
>> [    0.475903] ahci 0000:00:11.0: flags: 64bit ncq sntf ilck pm led clo pmp pio slum part ccc 
>> [    0.476572] scsi host0: ahci
>> [    0.476799] scsi host1: ahci
>> [    0.476957] scsi host2: ahci
>> [    0.477175] scsi host3: ahci
>> [    0.477232] ata1: SATA max UDMA/133 abar m1024@0xfe02f000 port 0xfe02f100 irq 22 lpm-pol 3
>> [    0.477236] ata2: SATA max UDMA/133 abar m1024@0xfe02f000 port 0xfe02f180 irq 22 lpm-pol 3
>> [    0.477239] ata3: SATA max UDMA/133 abar m1024@0xfe02f000 port 0xfe02f200 irq 22 lpm-pol 3
>> [    0.477242] ata4: SATA max UDMA/133 abar m1024@0xfe02f000 port 0xfe02f280 irq 22 lpm-pol 3
>> [    0.477489] ohci-pci 0000:00:12.0: OHCI PCI host controller
>> [    0.477498] ohci-pci 0000:00:12.0: new USB bus registered, assigned bus number 1
>> [    0.477543] ohci-pci 0000:00:12.0: irq 16, io mem 0xfe02e000
>> [    0.536033] usb usb1: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 6.09
>> [    0.536046] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
>> [    0.536053] usb usb1: Product: OHCI PCI host controller
>> [    0.536058] usb usb1: Manufacturer: Linux 6.9.2-arch1-1.2 ohci_hcd
>> [    0.536063] usb usb1: SerialNumber: 0000:00:12.0
>> [    0.536600] hub 1-0:1.0: USB hub found
>> [    0.536614] hub 1-0:1.0: 3 ports detected
>> [    0.537585] ehci-pci 0000:00:12.2: EHCI Host Controller
>> [    0.537618] ehci-pci 0000:00:12.2: new USB bus registered, assigned bus number 2
>> [    0.537631] ehci-pci 0000:00:12.2: applying AMD SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
>> [    0.537651] ehci-pci 0000:00:12.2: debug port 1
>> [    0.537772] ehci-pci 0000:00:12.2: irq 17, io mem 0xfe02c000
>> [    0.540855] Freeing initrd memory: 50848K
>> [    0.548534] ehci-pci 0000:00:12.2: USB 2.0 started, EHCI 1.00
>> [    0.548672] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.09
>> [    0.548675] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
>> [    0.548677] usb usb2: Product: EHCI Host Controller
>> [    0.548679] usb usb2: Manufacturer: Linux 6.9.2-arch1-1.2 ehci_hcd
>> [    0.548680] usb usb2: SerialNumber: 0000:00:12.2
>> [    0.548923] hub 2-0:1.0: USB hub found
>> [    0.548931] hub 2-0:1.0: 6 ports detected
>> [    0.615460] hub 1-0:1.0: USB hub found
>> [    0.615471] hub 1-0:1.0: 3 ports detected
>> [    0.615594] ehci-pci 0000:00:13.2: EHCI Host Controller
>> [    0.615599] ehci-pci 0000:00:13.2: new USB bus registered, assigned bus number 3
>> [    0.615603] ehci-pci 0000:00:13.2: applying AMD SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
>> [    0.615614] ehci-pci 0000:00:13.2: debug port 1
>> [    0.615676] ehci-pci 0000:00:13.2: irq 19, io mem 0xfe029000
>> [    0.628733] ehci-pci 0000:00:13.2: USB 2.0 started, EHCI 1.00
>> [    0.628840] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.09
>> [    0.628843] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
>> [    0.628845] usb usb3: Product: EHCI Host Controller
>> [    0.628846] usb usb3: Manufacturer: Linux 6.9.2-arch1-1.2 ehci_hcd
>> [    0.628848] usb usb3: SerialNumber: 0000:00:13.2
>> [    0.629065] hub 3-0:1.0: USB hub found
>> [    0.629079] hub 3-0:1.0: 6 ports detected
>> [    0.629268] ohci-pci 0000:00:12.1: OHCI PCI host controller
>> [    0.629273] ohci-pci 0000:00:12.1: new USB bus registered, assigned bus number 4
>> [    0.629292] ohci-pci 0000:00:12.1: irq 16, io mem 0xfe02d000
>> [    0.689602] usb usb4: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 6.09
>> [    0.689606] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
>> [    0.689608] usb usb4: Product: OHCI PCI host controller
>> [    0.689610] usb usb4: Manufacturer: Linux 6.9.2-arch1-1.2 ohci_hcd
>> [    0.689611] usb usb4: SerialNumber: 0000:00:12.1
>> [    0.689768] hub 4-0:1.0: USB hub found
>> [    0.689778] hub 4-0:1.0: 3 ports detected
>> [    0.690103] ohci-pci 0000:00:13.0: OHCI PCI host controller
>> [    0.690108] ohci-pci 0000:00:13.0: new USB bus registered, assigned bus number 5
>> [    0.690144] ohci-pci 0000:00:13.0: irq 18, io mem 0xfe02b000
>> [    0.749775] usb usb5: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 6.09
>> [    0.749779] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
>> [    0.749782] usb usb5: Product: OHCI PCI host controller
>> [    0.749783] usb usb5: Manufacturer: Linux 6.9.2-arch1-1.2 ohci_hcd
>> [    0.749785] usb usb5: SerialNumber: 0000:00:13.0
>> [    0.749940] hub 5-0:1.0: USB hub found
>> [    0.749949] hub 5-0:1.0: 3 ports detected
>> [    0.750237] ohci-pci 0000:00:13.1: OHCI PCI host controller
>> [    0.750246] ohci-pci 0000:00:13.1: new USB bus registered, assigned bus number 6
>> [    0.750266] ohci-pci 0000:00:13.1: irq 18, io mem 0xfe02a000
>> [    0.794105] ata1: SATA link down (SStatus 0 SControl 300)
>> [    0.795664] ata4: SATA link down (SStatus 0 SControl 300)
>> [    0.800164] usb 2-1: new high-speed USB device number 2 using ehci-pci
>> [    0.809908] usb usb6: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 6.09
>> [    0.809912] usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
>> [    0.809915] usb usb6: Product: OHCI PCI host controller
>> [    0.809916] usb usb6: Manufacturer: Linux 6.9.2-arch1-1.2 ohci_hcd
>> [    0.809918] usb usb6: SerialNumber: 0000:00:13.1
>> [    0.810076] hub 6-0:1.0: USB hub found
>> [    0.810086] hub 6-0:1.0: 3 ports detected
>> [    0.810362] ohci-pci 0000:00:14.5: OHCI PCI host controller
>> [    0.810368] ohci-pci 0000:00:14.5: new USB bus registered, assigned bus number 7
>> [    0.810387] ohci-pci 0000:00:14.5: irq 18, io mem 0xfe028000
>> [    0.870052] usb usb7: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 6.09
>> [    0.870056] usb usb7: New USB device strings: Mfr=3, Product=2, SerialNumber=1
>> [    0.870058] usb usb7: Product: OHCI PCI host controller
>> [    0.870059] usb usb7: Manufacturer: Linux 6.9.2-arch1-1.2 ohci_hcd
>> [    0.870061] usb usb7: SerialNumber: 0000:00:14.5
>> [    0.870224] hub 7-0:1.0: USB hub found
>> [    0.870233] hub 7-0:1.0: 2 ports detected
>> [    0.870434] usbcore: registered new interface driver usbserial_generic
>> [    0.870442] usbserial: USB Serial support registered for generic
>> [    0.870541] rtc_cmos 00:02: RTC can wake from S4
>> [    0.870777] rtc_cmos 00:02: registered as rtc0
>> [    0.870804] rtc_cmos 00:02: setting system clock to 2024-05-28T14:51:09 UTC (1716907869)
>> [    0.870840] rtc_cmos 00:02: alarms up to one month, 242 bytes nvram, hpet irqs
>> [    0.870893] amd_pstate: the _CPC object is not present in SBIOS or ACPI disabled
>> [    0.871046] ledtrig-cpu: registered to indicate activity on CPUs
>> [    0.871556] [drm] Initialized simpledrm 1.0.0 20200625 for simple-framebuffer.0 on minor 0
>> [    0.876504] Console: switching to colour frame buffer device 160x64
>> [    0.880130] simple-framebuffer simple-framebuffer.0: [drm] fb0: simpledrmdrmfb frame buffer device
>> [    0.880250] hid: raw HID events driver (C) Jiri Kosina
>> [    0.880368] drop_monitor: Initializing network drop monitor service
>> [    0.880708] NET: Registered PF_INET6 protocol family
>> [    0.888817] Segment Routing with IPv6
>> [    0.888821] RPL Segment Routing with IPv6
>> [    0.888841] In-situ OAM (IOAM) with IPv6
>> [    0.888871] NET: Registered PF_PACKET protocol family
>> [    0.888928] x86/pm: family 0x15 cpu detected, MSR saving is needed during suspending.
>> [    0.889431] microcode: Current revision: 0x06000852
>> [    0.889434] microcode: Updated early from: 0x06000822
>> [    0.889571] IPI shorthand broadcast: enabled
>> [    0.892436] sched_clock: Marking stable (892072218, -2517491)->(1803923840, -914369113)
>> [    0.892699] Timer migration: 1 hierarchy levels; 8 children per group; 1 crossnode level
>> [    0.892802] registered taskstats version 1
>> [    0.893127] Loading compiled-in X.509 certificates
>> [    0.897827] Loaded X.509 cert 'Build time autogenerated kernel key: d8f226d306ee433c4f9e55c6647f7453aebee28a'
>> [    0.900456] Key type .fscrypt registered
>> [    0.900458] Key type fscrypt-provisioning registered
>> [    0.901003] PM:   Magic number: 8:921:890
>> [    0.904937] RAS: Correctable Errors collector initialized.
>> [    0.917594] clk: Disabling unused clocks
>> [    0.917598] PM: genpd: Disabling unused power domains
>> [    0.948241] usb 2-1: New USB device found, idVendor=0bda, idProduct=b812, bcdDevice= 2.10
>> [    0.948246] usb 2-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
>> [    0.948248] usb 2-1: Product: USB3.0 802.11ac 1200M Adapter
>> [    0.948250] usb 2-1: Manufacturer: Realtek
>> [    0.948252] usb 2-1: SerialNumber: 123456
>> [    0.957220] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
>> [    0.957984] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
>> [    0.958027] ata3.00: ATA-8: TOSHIBA HDWD110, MS2OA8J0, max UDMA/133
>> [    0.958069] ata2.00: ATA-11: Apacer AS340 120GB, AP612PE0, max UDMA/133
>> [    0.958100] ata2.00: 234441648 sectors, multi 16: LBA48 NCQ (depth 32), AA
>> [    0.958298] ata3.00: 1953525168 sectors, multi 16: LBA48 NCQ (depth 32), AA
>> [    0.958709] ata2.00: configured for UDMA/133
>> [    0.959337] ata3.00: configured for UDMA/133
>> [    0.971555] scsi 1:0:0:0: Direct-Access     ATA      Apacer AS340 120 2PE0 PQ: 0 ANSI: 5
>> [    0.972039] sd 1:0:0:0: [sda] 234441648 512-byte logical blocks: (120 GB/112 GiB)
>> [    0.972044] scsi 2:0:0:0: Direct-Access     ATA      TOSHIBA HDWD110  A8J0 PQ: 0 ANSI: 5
>> [    0.972052] sd 1:0:0:0: [sda] Write Protect is off
>> [    0.972055] sd 1:0:0:0: [sda] Mode Sense: 00 3a 00 00
>> [    0.972072] sd 1:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
>> [    0.972104] sd 1:0:0:0: [sda] Preferred minimum I/O size 512 bytes
>> [    0.972382] sd 2:0:0:0: [sdb] 1953525168 512-byte logical blocks: (1.00 TB/932 GiB)
>> [    0.972385] sd 2:0:0:0: [sdb] 4096-byte physical blocks
>> [    0.972397] sd 2:0:0:0: [sdb] Write Protect is off
>> [    0.972400] sd 2:0:0:0: [sdb] Mode Sense: 00 3a 00 00
>> [    0.972418] sd 2:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
>> [    0.972450] sd 2:0:0:0: [sdb] Preferred minimum I/O size 4096 bytes
>> [    0.972747]  sda: sda1 sda2
>> [    0.972878] sd 1:0:0:0: [sda] Attached SCSI disk
>> [    0.979721]  sdb: sdb1 sdb2
>> [    0.979888] sd 2:0:0:0: [sdb] Attached SCSI disk
>> [    0.982113] Freeing unused decrypted memory: 2028K
>> [    0.982813] Freeing unused kernel image (initmem) memory: 3412K
>> [    0.982817] Write protecting the kernel read-only data: 32768k
>> [    0.983274] Freeing unused kernel image (rodata/data gap) memory: 1040K
>> [    1.024159] x86/mm: Checked W+X mappings: passed, no W+X pages found.
>> [    1.024163] rodata_test: all tests were successful
>> [    1.024167] Run /init as init process
>> [    1.024168]   with arguments:
>> [    1.024169]     /init
>> [    1.024171]   with environment:
>> [    1.024171]     HOME=/
>> [    1.024172]     TERM=linux
>> [    1.024173]     BOOT_IMAGE=/vmlinuz-linux
>> [    1.192020] xhci_hcd 0000:02:00.0: xHCI Host Controller
>> [    1.192030] xhci_hcd 0000:02:00.0: new USB bus registered, assigned bus number 8
>> [    1.192114] xhci_hcd 0000:02:00.0: hcc params 0x002841eb hci version 0x100 quirks 0x0000000000000890
>> [    1.192303] xhci_hcd 0000:02:00.0: xHCI Host Controller
>> [    1.192309] xhci_hcd 0000:02:00.0: new USB bus registered, assigned bus number 9
>> [    1.192314] xhci_hcd 0000:02:00.0: Host supports USB 3.0 SuperSpeed
>> [    1.192427] scsi host4: pata_atiixp
>> [    1.192590] scsi host5: pata_atiixp
>> [    1.192637] ata5: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0xfa00 irq 14 lpm-pol 0
>> [    1.192640] ata6: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xfa08 irq 15 lpm-pol 0
>> [    1.192805] usb usb8: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.09
>> [    1.192810] usb usb8: New USB device strings: Mfr=3, Product=2, SerialNumber=1
>> [    1.192812] usb usb8: Product: xHCI Host Controller
>> [    1.192814] usb usb8: Manufacturer: Linux 6.9.2-arch1-1.2 xhci-hcd
>> [    1.192816] usb usb8: SerialNumber: 0000:02:00.0
>> [    1.192970] hub 8-0:1.0: USB hub found
>> [    1.192982] hub 8-0:1.0: 1 port detected
>> [    1.193137] usb usb9: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 6.09
>> [    1.193141] usb usb9: New USB device strings: Mfr=3, Product=2, SerialNumber=1
>> [    1.193143] usb usb9: Product: xHCI Host Controller
>> [    1.193145] usb usb9: Manufacturer: Linux 6.9.2-arch1-1.2 xhci-hcd
>> [    1.193147] usb usb9: SerialNumber: 0000:02:00.0
>> [    1.193622] hub 9-0:1.0: USB hub found
>> [    1.193636] hub 9-0:1.0: 4 ports detected
>> [    1.280961] usb 1-3: new low-speed USB device number 2 using ohci-pci
>> [    1.437586] usb 8-1: new high-speed USB device number 2 using xhci_hcd
>> [    1.454253] tsc: Refined TSC clocksource calibration: 3322.063 MHz
>> [    1.454279] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x2fe2b689782, max_idle_ns: 440795272807 ns
>> [    1.454361] clocksource: Switched to clocksource tsc
>> [    1.471291] usb 1-3: New USB device found, idVendor=0c45, idProduct=7603, bcdDevice= 1.06
>> [    1.471296] usb 1-3: New USB device strings: Mfr=0, Product=2, SerialNumber=0
>> [    1.471298] usb 1-3: Product: USB Keyboard
>> [    1.494609] usbcore: registered new interface driver usbhid
>> [    1.494612] usbhid: USB HID core driver
>> [    1.500400] input: USB Keyboard as /devices/pci0000:00/0000:00:12.0/usb1/1-3/1-3:1.0/0003:0C45:7603.0001/input/input2
>> [    1.554498] hid-generic 0003:0C45:7603.0001: input,hidraw0: USB HID v1.11 Keyboard [USB Keyboard] on usb-0000:00:12.0-3/input0
>> [    1.554894] input: USB Keyboard Consumer Control as /devices/pci0000:00/0000:00:12.0/usb1/1-3/1-3:1.1/0003:0C45:7603.0002/input/input3
>> [    1.578903] usb 8-1: New USB device found, idVendor=2109, idProduct=3431, bcdDevice= 4.20
>> [    1.578907] usb 8-1: New USB device strings: Mfr=0, Product=1, SerialNumber=0
>> [    1.578909] usb 8-1: Product: USB2.0 Hub
>> [    1.579618] hub 8-1:1.0: USB hub found
>> [    1.579800] hub 8-1:1.0: 4 ports detected
>> [    1.611140] input: USB Keyboard System Control as /devices/pci0000:00/0000:00:12.0/usb1/1-3/1-3:1.1/0003:0C45:7603.0002/input/input4
>> [    1.611211] input: USB Keyboard as /devices/pci0000:00/0000:00:12.0/usb1/1-3/1-3:1.1/0003:0C45:7603.0002/input/input6
>> [    1.611349] hid-generic 0003:0C45:7603.0002: input,hiddev96,hidraw1: USB HID v1.11 Keyboard [USB Keyboard] on usb-0000:00:12.0-3/input1
>> [    2.100930] usb 4-1: new full-speed USB device number 2 using ohci-pci
>> [    2.295746] usb 4-1: New USB device found, idVendor=04d9, idProduct=a088, bcdDevice= 1.00
>> [    2.295758] usb 4-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
>> [    2.295764] usb 4-1: Product: USB Gaming Mouse
>> [    2.295769] usb 4-1: Manufacturer: RH
>> [    2.303143] input: RH USB Gaming Mouse as /devices/pci0000:00/0000:00:12.1/usb4/4-1/4-1:1.0/0003:04D9:A088.0003/input/input7
>> [    2.358069] hid-generic 0003:04D9:A088.0003: input,hidraw2: USB HID v1.10 Keyboard [RH USB Gaming Mouse] on usb-0000:00:12.1-1/input0
>> [    2.364463] input: RH USB Gaming Mouse as /devices/pci0000:00/0000:00:12.1/usb4/4-1/4-1:1.1/0003:04D9:A088.0004/input/input8
>> [    2.364541] input: RH USB Gaming Mouse System Control as /devices/pci0000:00/0000:00:12.1/usb4/4-1/4-1:1.1/0003:04D9:A088.0004/input/input9
>> [    2.421242] input: RH USB Gaming Mouse Consumer Control as /devices/pci0000:00/0000:00:12.1/usb4/4-1/4-1:1.1/0003:04D9:A088.0004/input/input10
>> [    2.421361] hid-generic 0003:04D9:A088.0004: input,hiddev97,hidraw3: USB HID v1.10 Mouse [RH USB Gaming Mouse] on usb-0000:00:12.1-1/input1
>> [    2.425111] hid-generic 0003:04D9:A088.0005: hiddev98,hidraw4: USB HID v1.10 Device [RH USB Gaming Mouse] on usb-0000:00:12.1-1/input2
>> [    2.964262] ata2.00: exception Emask 0x10 SAct 0x80 SErr 0x40d0002 action 0xe frozen
>> [    2.964274] ata2.00: irq_stat 0x00000040, connection status changed
>> [    2.964279] ata2: SError: { RecovComm PHYRdyChg CommWake 10B8B DevExch }
>> [    2.964288] ata2.00: failed command: READ FPDMA QUEUED
>> [    2.964291] ata2.00: cmd 60/08:38:80:ff:f1/00:00:0d:00:00/40 tag 7 ncq dma 4096 in
>>                         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 (ATA bus error)
>> [    2.964307] ata2.00: status: { DRDY }
>> [    2.964318] ata2: hard resetting link
>> [    3.860936] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
>> [    3.861698] ata2.00: configured for UDMA/133
>> [    3.871801] sd 1:0:0:0: [sda] tag#7 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
>> [    3.871805] sd 1:0:0:0: [sda] tag#7 Sense Key : Illegal Request [current] 
>> [    3.871808] sd 1:0:0:0: [sda] tag#7 Add. Sense: Unaligned write command
>> [    3.871810] sd 1:0:0:0: [sda] tag#7 CDB: Read(10) 28 00 0d f1 ff 80 00 00 08 00
>> [    3.871812] I/O error, dev sda, sector 233963392 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
>> [    3.871832] ata2: EH complete
>> [    4.047485] EXT4-fs (sda2): mounted filesystem 963daeed-0888-4658-9f17-18bd343dfb2a r/w with ordered data mode. Quota mode: none.
>> [    4.217266] systemd[1]: systemd 255.7-1-arch running in system mode (+PAM +AUDIT -SELINUX -APPARMOR -IMA +SMACK +SECCOMP +GCRYPT +GNUTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD +LIBCRYPTSETUP +LIBFDISK +PCRE2 +PWQUALITY +P11KIT +QRENCODE +TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD +BPF_FRAMEWORK +XKBCOMMON +UTMP -SYSVINIT default-hierarchy=unified)
>> [    4.217273] systemd[1]: Detected architecture x86-64.
>> [    4.801003] systemd[1]: bpf-lsm: LSM BPF program attached
>> [    4.877584] ata2.00: exception Emask 0x10 SAct 0x80000000 SErr 0x40d0002 action 0xe frozen
>> [    4.877597] ata2.00: irq_stat 0x00000040, connection status changed
>> [    4.877601] ata2: SError: { RecovComm PHYRdyChg CommWake 10B8B DevExch }
>> [    4.877613] ata2.00: failed command: READ FPDMA QUEUED
>> [    4.877616] ata2.00: cmd 60/08:f8:50:f9:08/00:00:07:00:00/40 tag 31 ncq dma 4096 in
>>                         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 (ATA bus error)
>> [    4.877632] ata2.00: status: { DRDY }
>> [    4.877639] ata2: hard resetting link
>> [    5.774299] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
>> [    5.775081] ata2.00: configured for UDMA/133
>> [    5.785188] ata2: EH complete
>> [    5.836831] systemd-fstab-generator[268]: Mount point  is not a valid path, ignoring.
>> [    5.837835] systemd-fstab-generator[268]: Mount point  is not a valid path, ignoring.
>> [    6.534243] random: crng init done
>> [    6.607583] ata2.00: exception Emask 0x10 SAct 0x6000000 SErr 0x40d0002 action 0xe frozen
>> [    6.607595] ata2.00: irq_stat 0x00000040, connection status changed
>> [    6.607600] ata2: SError: { RecovComm PHYRdyChg CommWake 10B8B DevExch }
>> [    6.607611] ata2.00: failed command: READ FPDMA QUEUED
>> [    6.607615] ata2.00: cmd 60/40:c8:28:3d:9c/00:00:01:00:00/40 tag 25 ncq dma 32768 in
>>                         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 (ATA bus error)
>> [    6.607630] ata2.00: status: { DRDY }
>> [    6.607635] ata2.00: failed command: READ FPDMA QUEUED
>> [    6.607638] ata2.00: cmd 60/08:d0:30:04:ad/00:00:01:00:00/40 tag 26 ncq dma 4096 in
>>                         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 (ATA bus error)
>> [    6.607652] ata2.00: status: { DRDY }
>> [    6.607660] ata2: hard resetting link
>> [    7.504453] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
>> [    7.505241] ata2.00: configured for UDMA/133
>> [    7.515397] sd 1:0:0:0: [sda] tag#25 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
>> [    7.515401] sd 1:0:0:0: [sda] tag#25 Sense Key : Illegal Request [current] 
>> [    7.515404] sd 1:0:0:0: [sda] tag#25 Add. Sense: Unaligned write command
>> [    7.515406] sd 1:0:0:0: [sda] tag#25 CDB: Read(10) 28 00 01 9c 3d 28 00 00 40 00
>> [    7.515407] I/O error, dev sda, sector 27016488 op 0x0:(READ) flags 0x80700 phys_seg 8 prio class 0
>> [    7.515417] sd 1:0:0:0: [sda] tag#26 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
>> [    7.515419] sd 1:0:0:0: [sda] tag#26 Sense Key : Illegal Request [current] 
>> [    7.515421] sd 1:0:0:0: [sda] tag#26 Add. Sense: Unaligned write command
>> [    7.515423] sd 1:0:0:0: [sda] tag#26 CDB: Read(10) 28 00 01 ad 04 30 00 00 08 00
>> [    7.515424] I/O error, dev sda, sector 28116016 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
>> [    7.515440] ata2: EH complete
>> [    7.529998] zram: Added device: zram0
>> [    7.691188] systemd[1]: Queued start job for default target Graphical Interface.
>> [    7.725534] systemd[1]: Created slice Slice /system/dirmngr.
>> [    7.725909] systemd[1]: Created slice Slice /system/getty.
>> [    7.726235] systemd[1]: Created slice Slice /system/gpg-agent.
>> [    7.726555] systemd[1]: Created slice Slice /system/gpg-agent-browser.
>> [    7.726882] systemd[1]: Created slice Slice /system/gpg-agent-extra.
>> [    7.727202] systemd[1]: Created slice Slice /system/gpg-agent-ssh.
>> [    7.727571] systemd[1]: Created slice Slice /system/keyboxd.
>> [    7.727960] systemd[1]: Created slice Slice /system/modprobe.
>> [    7.728334] systemd[1]: Created slice Slice /system/systemd-fsck.
>> [    7.728726] systemd[1]: Created slice Slice /system/systemd-zram-setup.
>> [    7.729003] systemd[1]: Created slice User and Session Slice.
>> [    7.729063] systemd[1]: Started Dispatch Password Requests to Console Directory Watch.
>> [    7.729108] systemd[1]: Started Forward Password Requests to Wall Directory Watch.
>> [    7.729268] systemd[1]: Set up automount Arbitrary Executable File Formats File System Automount Point.
>> [    7.729287] systemd[1]: Expecting device /dev/disk/by-uuid/03ce297b-4be8-4886-953d-2d2cc4bd0862...
>> [    7.729295] systemd[1]: Expecting device /dev/disk/by-uuid/6BB1-1CFA...
>> [    7.729302] systemd[1]: Expecting device /dev/zram0...
>> [    7.729313] systemd[1]: Reached target Local Encrypted Volumes.
>> [    7.729329] systemd[1]: Reached target Local Integrity Protected Volumes.
>> [    7.729358] systemd[1]: Reached target Path Units.
>> [    7.729374] systemd[1]: Reached target Remote File Systems.
>> [    7.729384] systemd[1]: Reached target Slice Units.
>> [    7.729414] systemd[1]: Reached target Local Verity Protected Volumes.
>> [    7.729483] systemd[1]: Listening on Device-mapper event daemon FIFOs.
>> [    7.729825] systemd[1]: Listening on LVM2 poll daemon socket.
>> [    7.731601] systemd[1]: Listening on Process Core Dump Socket.
>> [    7.731717] systemd[1]: Listening on Journal Socket (/dev/log).
>> [    7.731826] systemd[1]: Listening on Journal Socket.
>> [    7.731962] systemd[1]: Listening on Network Service Netlink Socket.
>> [    7.731983] systemd[1]: TPM2 PCR Extension (Varlink) was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
>> [    7.732283] systemd[1]: Listening on udev Control Socket.
>> [    7.732367] systemd[1]: Listening on udev Kernel Socket.
>> [    7.733670] systemd[1]: Mounting Huge Pages File System...
>> [    7.734432] systemd[1]: Mounting POSIX Message Queue File System...
>> [    7.735214] systemd[1]: Mounting Kernel Debug File System...
>> [    7.735940] systemd[1]: Mounting Kernel Trace File System...
>> [    7.737094] systemd[1]: Starting Create List of Static Device Nodes...
>> [    7.738109] systemd[1]: Starting Monitoring of LVM2 mirrors, snapshots etc. using dmeventd or progress polling...
>> [    7.739275] systemd[1]: Starting Load Kernel Module configfs...
>> [    7.741004] systemd[1]: Starting Load Kernel Module dm_mod...
>> [    7.743396] systemd[1]: Starting Load Kernel Module drm...
>> [    7.744638] systemd[1]: Starting Load Kernel Module fuse...
>> [    7.745618] systemd[1]: Starting Load Kernel Module loop...
>> [    7.745672] systemd[1]: File System Check on Root Device was skipped because of an unmet condition check (ConditionPathIsReadWrite=!/).
>> [    7.747541] systemd[1]: Starting Journal Service...
>> [    7.749286] systemd[1]: Starting Load Kernel Modules...
>> [    7.750456] systemd[1]: Starting Generate network units from Kernel command line...
>> [    7.750488] systemd[1]: TPM2 PCR Machine ID Measurement was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
>> [    7.752304] systemd[1]: Starting Remount Root and Kernel File Systems...
>> [    7.752407] systemd[1]: TPM2 SRK Setup (Early) was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
>> [    7.753791] systemd[1]: Starting Coldplug All udev Devices...
>> [    7.755944] systemd[1]: Mounted Huge Pages File System.
>> [    7.756096] systemd[1]: Mounted POSIX Message Queue File System.
>> [    7.756210] systemd[1]: Mounted Kernel Debug File System.
>> [    7.756338] systemd[1]: Mounted Kernel Trace File System.
>> [    7.756613] systemd[1]: Finished Create List of Static Device Nodes.
>> [    7.757040] systemd[1]: modprobe@configfs.service: Deactivated successfully.
>> [    7.757405] systemd[1]: Finished Load Kernel Module configfs.
>> [    7.757836] systemd[1]: modprobe@drm.service: Deactivated successfully.
>> [    7.760195] systemd[1]: Finished Load Kernel Module drm.
>> [    7.760583] systemd[1]: modprobe@fuse.service: Deactivated successfully.
>> [    7.760775] systemd[1]: Finished Load Kernel Module fuse.
>> [    7.763032] systemd[1]: Mounting FUSE Control File System...
>> [    7.764696] systemd[1]: Mounting Kernel Configuration File System...
>> [    7.765008] loop: module loaded
>> [    7.765817] systemd[1]: Starting Create Static Device Nodes in /dev gracefully...
>> [    7.766294] systemd[1]: modprobe@loop.service: Deactivated successfully.
>> [    7.766508] systemd[1]: Finished Load Kernel Module loop.
>> [    7.766833] systemd[1]: Finished Generate network units from Kernel command line.
>> [    7.773114] device-mapper: uevent: version 1.0.3
>> [    7.773226] device-mapper: ioctl: 4.48.0-ioctl (2023-03-01) initialised: dm-devel@lists.linux.dev
>> [    7.773364] systemd[1]: Mounted FUSE Control File System.
>> [    7.773500] systemd[1]: Mounted Kernel Configuration File System.
>> [    7.773999] systemd[1]: modprobe@dm_mod.service: Deactivated successfully.
>> [    7.774199] systemd[1]: Finished Load Kernel Module dm_mod.
>> [    7.774797] systemd[1]: Repartition Root Disk was skipped because no trigger condition checks were met.
>> [    7.777678] sd 1:0:0:0: Attached scsi generic sg0 type 0
>> [    7.777730] sd 2:0:0:0: Attached scsi generic sg1 type 0
>> [    7.782295] systemd-journald[292]: Collecting audit messages is disabled.
>> [    7.789658] Asymmetric key parser 'pkcs8' registered
>> [    7.790664] systemd[1]: Finished Load Kernel Modules.
>> [    7.791862] systemd[1]: Starting Apply Kernel Variables...
>> [    7.797660] EXT4-fs (sda2): re-mounted 963daeed-0888-4658-9f17-18bd343dfb2a r/w. Quota mode: none.
>> [    7.798776] systemd[1]: Finished Remount Root and Kernel File Systems.
>> [    7.799828] systemd[1]: Rebuild Hardware Database was skipped because no trigger condition checks were met.
>> [    7.800904] systemd[1]: Starting Load/Save OS Random Seed...
>> [    7.800930] systemd[1]: TPM2 SRK Setup was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
>> [    7.806934] systemd[1]: Finished Apply Kernel Variables.
>> [    7.820293] systemd[1]: Finished Load/Save OS Random Seed.
>> [    7.822716] systemd[1]: Finished Create Static Device Nodes in /dev gracefully.
>> [    7.823917] systemd[1]: Starting Create System Users...
>> [    7.853147] systemd[1]: Finished Create System Users.
>> [    7.854285] systemd[1]: Starting Create Static Device Nodes in /dev...
>> [    7.854815] systemd[1]: Started Journal Service.
>> [    7.866721] systemd-journald[292]: Received client request to flush runtime journal.
>> [    7.876074] systemd-journald[292]: /var/log/journal/ca3d73a04dc345538c9904a96756e41e/system.journal: Journal file uses a different sequence number ID, rotating.
>> [    7.876080] systemd-journald[292]: Rotating system journal.
>> [    8.006678] zram0: detected capacity change from 0 to 8388608
>> [    8.056885] mousedev: PS/2 mouse device common for all mice
>> [    8.058328] parport_pc 00:04: reported by Plug and Play ACPI
>> [    8.060958] parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE]
>> [    8.090400] input: PC Speaker as /devices/platform/pcspkr/input/input12
>> [    8.090811] ACPI Warning: SystemIO range 0x0000000000000B00-0x0000000000000B08 conflicts with OpRegion 0x0000000000000B00-0x0000000000000B0F (\SOR1) (20230628/utaddress-204)
>> [    8.090837] ACPI: OSL: Resource conflict; ACPI support missing from driver?
>> [    8.093857] cryptd: max_cpu_qlen set to 1000
>> [    8.095908] acpi_cpufreq: overriding BIOS provided _PSD data
>> [    8.099121] sp5100_tco: SP5100/SB800 TCO WatchDog Timer Driver
>> [    8.099423] sp5100-tco sp5100-tco: Failed to reserve MMIO or alternate MMIO region
>> [    8.099428] sp5100-tco sp5100-tco: probe with driver sp5100-tco failed with error -16
>> [    8.123581] r8169 0000:03:00.0: can't disable ASPM; OS doesn't have ASPM control
>> [    8.123771] AVX version of gcm_enc/dec engaged.
>> [    8.123835] AES CTR mode by8 optimization enabled
>> [    8.147638] r8169 0000:03:00.0 eth0: RTL8168g/8111g, e0:d5:5e:3b:15:1f, XID 4c0, IRQ 28
>> [    8.147648] r8169 0000:03:00.0 eth0: jumbo features [frames: 9194 bytes, tx checksumming: ko]
>> [    8.153349] r8169 0000:03:00.0 enp3s0: renamed from eth0
>> [    8.188043] ppdev: user-space parallel port driver
>> [    8.193397] Adding 4194300k swap on /dev/zram0.  Priority:100 extents:1 across:4194300k SSDsc
>> [    8.198244] snd_hda_intel 0000:01:00.1: Disabling MSI
>> [    8.198265] snd_hda_intel 0000:01:00.1: Handle vga_switcheroo audio client
>> [    8.226060] input: HDA NVidia HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:02.0/0000:01:00.1/sound/card1/input13
>> [    8.226734] input: HDA NVidia HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:02.0/0000:01:00.1/sound/card1/input14
>> [    8.226821] input: HDA NVidia HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:02.0/0000:01:00.1/sound/card1/input15
>> [    8.226880] input: HDA NVidia HDMI/DP,pcm=9 as /devices/pci0000:00/0000:00:02.0/0000:01:00.1/sound/card1/input16
>> [    8.241879] snd_hda_codec_realtek hdaudioC0D0: autoconfig for ALC892: line_outs=1 (0x14/0x0/0x0/0x0/0x0) type:line
>> [    8.241886] snd_hda_codec_realtek hdaudioC0D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
>> [    8.241889] snd_hda_codec_realtek hdaudioC0D0:    hp_outs=1 (0x1b/0x0/0x0/0x0/0x0)
>> [    8.241891] snd_hda_codec_realtek hdaudioC0D0:    mono: mono_out=0x0
>> [    8.241893] snd_hda_codec_realtek hdaudioC0D0:    dig-out=0x11/0x0
>> [    8.241895] snd_hda_codec_realtek hdaudioC0D0:    inputs:
>> [    8.241897] snd_hda_codec_realtek hdaudioC0D0:      Front Mic=0x19
>> [    8.241899] snd_hda_codec_realtek hdaudioC0D0:      Rear Mic=0x18
>> [    8.241901] snd_hda_codec_realtek hdaudioC0D0:      Line=0x1a
>> [    8.321663] input: HDA ATI SB Front Mic as /devices/pci0000:00/0000:00:14.2/sound/card0/input17
>> [    8.321807] input: HDA ATI SB Rear Mic as /devices/pci0000:00/0000:00:14.2/sound/card0/input18
>> [    8.321864] input: HDA ATI SB Line as /devices/pci0000:00/0000:00:14.2/sound/card0/input19
>> [    8.321932] input: HDA ATI SB Line Out as /devices/pci0000:00/0000:00:14.2/sound/card0/input20
>> [    8.321994] input: HDA ATI SB Front Headphone as /devices/pci0000:00/0000:00:14.2/sound/card0/input21
>> [    8.376761] kvm_amd: TSC scaling supported
>> [    8.376766] kvm_amd: Nested Virtualization enabled
>> [    8.376768] kvm_amd: Nested Paging enabled
>> [    8.376774] kvm_amd: LBR virtualization supported
>> [    8.916596] EXT4-fs (sdb1): mounted filesystem 03ce297b-4be8-4886-953d-2d2cc4bd0862 r/w with ordered data mode. Quota mode: none.
>> [    9.007654] ata2: limiting SATA link speed to 1.5 Gbps
>> [    9.007664] ata2.00: exception Emask 0x10 SAct 0x200000 SErr 0x40d0002 action 0xe frozen
>> [    9.007671] ata2.00: irq_stat 0x00000040, connection status changed
>> [    9.007676] ata2: SError: { RecovComm PHYRdyChg CommWake 10B8B DevExch }
>> [    9.007685] ata2.00: failed command: READ FPDMA QUEUED
>> [    9.007689] ata2.00: cmd 60/08:a8:78:9f:ae/00:00:02:00:00/40 tag 21 ncq dma 4096 in
>>                         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 (ATA bus error)
>> [    9.007704] ata2.00: status: { DRDY }
>> [    9.007713] ata2: hard resetting link
>> [    9.904302] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
>> [    9.905397] ata2.00: configured for UDMA/133
>> [    9.915594] sd 1:0:0:0: [sda] tag#21 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
>> [    9.915606] sd 1:0:0:0: [sda] tag#21 Sense Key : Illegal Request [current] 
>> [    9.915613] sd 1:0:0:0: [sda] tag#21 Add. Sense: Unaligned write command
>> [    9.915620] sd 1:0:0:0: [sda] tag#21 CDB: Read(10) 28 00 02 ae 9f 78 00 00 08 00
>> [    9.915624] I/O error, dev sda, sector 44998520 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
>> [    9.915657] ata2: EH complete
>> [   10.864909] NET: Registered PF_ALG protocol family
>> [   10.960863] Generic FE-GE Realtek PHY r8169-0-300:00: attached PHY driver (mii_bus:phy_addr=r8169-0-300:00, irq=MAC)
>> [   11.157627] r8169 0000:03:00.0 enp3s0: Link is Down
>> [   14.170915] ata2.00: exception Emask 0x10 SAct 0x10000000 SErr 0x40d0002 action 0xe frozen
>> [   14.170929] ata2.00: irq_stat 0x00000040, connection status changed
>> [   14.170934] ata2: SError: { RecovComm PHYRdyChg CommWake 10B8B DevExch }
>> [   14.170945] ata2.00: failed command: READ FPDMA QUEUED
>> [   14.170949] ata2.00: cmd 60/00:e0:00:39:7f/0a:00:01:00:00/40 tag 28 ncq dma 1310720 in
>>                         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 (ATA bus error)
>> [   14.170964] ata2.00: status: { DRDY }
>> [   14.170973] ata2: hard resetting link
>> [   15.067652] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
>> [   15.068694] ata2.00: configured for UDMA/133
>> [   15.078850] sd 1:0:0:0: [sda] tag#28 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
>> [   15.078861] sd 1:0:0:0: [sda] tag#28 Sense Key : Illegal Request [current] 
>> [   15.078868] sd 1:0:0:0: [sda] tag#28 Add. Sense: Unaligned write command
>> [   15.078875] sd 1:0:0:0: [sda] tag#28 CDB: Read(10) 28 00 01 7f 39 00 00 0a 00 00
>> [   15.078879] I/O error, dev sda, sector 25114880 op 0x0:(READ) flags 0x80700 phys_seg 36 prio class 0
>> [   15.078930] ata2: EH complete
>> [   15.660926] ata2.00: exception Emask 0x10 SAct 0x10000000 SErr 0x40d0002 action 0xe frozen
>> [   15.660939] ata2.00: irq_stat 0x00000040, connection status changed
>> [   15.660944] ata2: SError: { RecovComm PHYRdyChg CommWake 10B8B DevExch }
>> [   15.660955] ata2.00: failed command: WRITE FPDMA QUEUED
>> [   15.660959] ata2.00: cmd 61/10:e0:08:97:a2/00:00:08:00:00/40 tag 28 ncq dma 8192 out
>>                         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 (ATA bus error)
>> [   15.660974] ata2.00: status: { DRDY }
>> [   15.660982] ata2: hard resetting link
>> [   16.557602] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
>> [   16.558620] ata2.00: configured for UDMA/133
>> [   16.568804] ata2: EH complete
>> [   17.220916] ata2.00: exception Emask 0x10 SAct 0x8000 SErr 0x40d0002 action 0xe frozen
>> [   17.220930] ata2.00: irq_stat 0x00000040, connection status changed
>> [   17.220934] ata2: SError: { RecovComm PHYRdyChg CommWake 10B8B DevExch }
>> [   17.220944] ata2.00: failed command: READ FPDMA QUEUED
>> [   17.220947] ata2.00: cmd 60/10:78:48:a8:04/00:00:0b:00:00/40 tag 15 ncq dma 8192 in
>>                         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 (ATA bus error)
>> [   17.220963] ata2.00: status: { DRDY }
>> [   17.220972] ata2: hard resetting link
>> [   18.117578] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
>> [   18.118584] ata2.00: configured for UDMA/133
>> [   18.128737] sd 1:0:0:0: [sda] tag#15 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=1s
>> [   18.128748] sd 1:0:0:0: [sda] tag#15 Sense Key : Illegal Request [current] 
>> [   18.128755] sd 1:0:0:0: [sda] tag#15 Add. Sense: Unaligned write command
>> [   18.128761] sd 1:0:0:0: [sda] tag#15 CDB: Read(10) 28 00 0b 04 a8 48 00 00 10 00
>> [   18.128765] I/O error, dev sda, sector 184854600 op 0x0:(READ) flags 0x80700 phys_seg 2 prio class 0
>> [   18.128798] ata2: EH complete
>> [   18.298855] systemd-journald[292]: /var/log/journal/ca3d73a04dc345538c9904a96756e41e/user-1000.journal: Journal file uses a different sequence number ID, rotating.
>> [   20.120927] ata2.00: limiting speed to UDMA/100:PIO4
>> [   20.120938] ata2.00: exception Emask 0x10 SAct 0x100 SErr 0x40d0002 action 0xe frozen
>> [   20.120945] ata2.00: irq_stat 0x00000040, connection status changed
>> [   20.120949] ata2: SError: { RecovComm PHYRdyChg CommWake 10B8B DevExch }
>> [   20.120958] ata2.00: failed command: READ FPDMA QUEUED
>> [   20.120961] ata2.00: cmd 60/08:40:90:f8:87/00:00:04:00:00/40 tag 8 ncq dma 4096 in
>>                         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 (ATA bus error)
>> [   20.120976] ata2.00: status: { DRDY }
>> [   20.120987] ata2: hard resetting link
>> [   21.017651] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
>> [   21.018696] ata2.00: configured for UDMA/100
>> [   21.028886] ata2: EH complete
>> [   21.494246] ata2.00: exception Emask 0x10 SAct 0x100000 SErr 0x40d0002 action 0xe frozen
>> [   21.494258] ata2.00: irq_stat 0x00000040, connection status changed
>> [   21.494263] ata2: SError: { RecovComm PHYRdyChg CommWake 10B8B DevExch }
>> [   21.494273] ata2.00: failed command: READ FPDMA QUEUED
>> [   21.494277] ata2.00: cmd 60/00:a0:60:07:49/01:00:02:00:00/40 tag 20 ncq dma 131072 in
>>                         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 (ATA bus error)
>> [   21.494292] ata2.00: status: { DRDY }
>> [   21.494300] ata2: hard resetting link
>> [   22.390924] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
>> [   22.391922] ata2.00: configured for UDMA/100
>> [   22.402072] sd 1:0:0:0: [sda] tag#20 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
>> [   22.402083] sd 1:0:0:0: [sda] tag#20 Sense Key : Illegal Request [current] 
>> [   22.402090] sd 1:0:0:0: [sda] tag#20 Add. Sense: Unaligned write command
>> [   22.402097] sd 1:0:0:0: [sda] tag#20 CDB: Read(10) 28 00 02 49 07 60 00 01 00 00
>> [   22.402101] I/O error, dev sda, sector 38340448 op 0x0:(READ) flags 0x80700 phys_seg 27 prio class 0
>> [   22.402136] ata2: EH complete
>> [   23.767592] ata2.00: exception Emask 0x10 SAct 0x40040 SErr 0x40d0002 action 0xe frozen
>> [   23.767604] ata2.00: irq_stat 0x00000040, connection status changed
>> [   23.767609] ata2: SError: { RecovComm PHYRdyChg CommWake 10B8B DevExch }
>> [   23.767617] ata2.00: failed command: WRITE FPDMA QUEUED
>> [   23.767621] ata2.00: cmd 61/08:30:e0:36:cf/00:00:01:00:00/40 tag 6 ncq dma 4096 out
>>                         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 (ATA bus error)
>> [   23.767636] ata2.00: status: { DRDY }
>> [   23.767643] ata2.00: failed command: WRITE FPDMA QUEUED
>> [   23.767646] ata2.00: cmd 61/08:90:e8:03:40/00:00:02:00:00/40 tag 18 ncq dma 4096 out
>>                         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 (ATA bus error)
>> [   23.767660] ata2.00: status: { DRDY }
>> [   23.767668] ata2: hard resetting link
>> [   24.664348] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
>> [   24.665434] ata2.00: configured for UDMA/100
>> [   24.675629] ata2: EH complete
>> [   25.267591] ata2.00: exception Emask 0x10 SAct 0xe000 SErr 0x40d0002 action 0xe frozen
>> [   25.267605] ata2.00: irq_stat 0x00000040, connection status changed
>> [   25.267610] ata2: SError: { RecovComm PHYRdyChg CommWake 10B8B DevExch }
>> [   25.267619] ata2.00: failed command: READ FPDMA QUEUED
>> [   25.267623] ata2.00: cmd 60/68:68:a8:a9:50/00:00:05:00:00/40 tag 13 ncq dma 53248 in
>>                         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 (ATA bus error)
>> [   25.267638] ata2.00: status: { DRDY }
>> [   25.267643] ata2.00: failed command: READ FPDMA QUEUED
>> [   25.267647] ata2.00: cmd 60/b0:70:08:ac:50/02:00:05:00:00/40 tag 14 ncq dma 352256 in
>>                         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 (ATA bus error)
>> [   25.267662] ata2.00: status: { DRDY }
>> [   25.267666] ata2.00: failed command: READ FPDMA QUEUED
>> [   25.267670] ata2.00: cmd 60/f0:78:b8:af:50/03:00:05:00:00/40 tag 15 ncq dma 516096 in
>>                         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 (ATA bus error)
>> [   25.267683] ata2.00: status: { DRDY }
>> [   25.267691] ata2: hard resetting link
>> [   26.164282] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
>> [   26.165271] ata2.00: configured for UDMA/100
>> [   26.175428] sd 1:0:0:0: [sda] tag#13 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
>> [   26.175439] sd 1:0:0:0: [sda] tag#13 Sense Key : Illegal Request [current] 
>> [   26.175446] sd 1:0:0:0: [sda] tag#13 Add. Sense: Unaligned write command
>> [   26.175453] sd 1:0:0:0: [sda] tag#13 CDB: Read(10) 28 00 05 50 a9 a8 00 00 68 00
>> [   26.175457] I/O error, dev sda, sector 89172392 op 0x0:(READ) flags 0x80700 phys_seg 13 prio class 0
>> [   26.175501] sd 1:0:0:0: [sda] tag#14 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
>> [   26.175508] sd 1:0:0:0: [sda] tag#14 Sense Key : Illegal Request [current] 
>> [   26.175513] sd 1:0:0:0: [sda] tag#14 Add. Sense: Unaligned write command
>> [   26.175519] sd 1:0:0:0: [sda] tag#14 CDB: Read(10) 28 00 05 50 ac 08 00 02 b0 00
>> [   26.175522] I/O error, dev sda, sector 89173000 op 0x0:(READ) flags 0x80700 phys_seg 86 prio class 0
>> [   26.175547] sd 1:0:0:0: [sda] tag#15 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
>> [   26.175555] sd 1:0:0:0: [sda] tag#15 Sense Key : Illegal Request [current] 
>> [   26.175562] sd 1:0:0:0: [sda] tag#15 Add. Sense: Unaligned write command
>> [   26.175569] sd 1:0:0:0: [sda] tag#15 CDB: Read(10) 28 00 05 50 af b8 00 03 f0 00
>> [   26.175575] I/O error, dev sda, sector 89173944 op 0x0:(READ) flags 0x80700 phys_seg 126 prio class 0
>> [   26.175596] ata2: EH complete
>> [   26.520926] ata2.00: limiting speed to UDMA/33:PIO4
>> [   26.520936] ata2.00: exception Emask 0x10 SAct 0x8000 SErr 0x40d0002 action 0xe frozen
>> [   26.520943] ata2.00: irq_stat 0x00000040, connection status changed
>> [   26.520948] ata2: SError: { RecovComm PHYRdyChg CommWake 10B8B DevExch }
>> [   26.520957] ata2.00: failed command: WRITE FPDMA QUEUED
>> [   26.520960] ata2.00: cmd 61/20:78:98:78:d0/00:00:06:00:00/40 tag 15 ncq dma 16384 out
>>                         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 (ATA bus error)
>> [   26.520976] ata2.00: status: { DRDY }
>> [   26.520984] ata2: hard resetting link
>> [   27.417761] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
>> [   27.418764] ata2.00: configured for UDMA/33
>> [   27.428954] ata2: EH complete
>> [   32.727577] ata2.00: exception Emask 0x10 SAct 0x800000 SErr 0x40d0002 action 0xe frozen
>> [   32.727589] ata2.00: irq_stat 0x00000040, connection status changed
>> [   32.727594] ata2: SError: { RecovComm PHYRdyChg CommWake 10B8B DevExch }
>> [   32.727604] ata2.00: failed command: WRITE FPDMA QUEUED
>> [   32.727607] ata2.00: cmd 61/18:b8:c0:78:d0/00:00:06:00:00/40 tag 23 ncq dma 12288 out
>>                         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 (ATA bus error)
>> [   32.727622] ata2.00: status: { DRDY }
>> [   32.727631] ata2: hard resetting link
>> [   33.624294] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
>> [   33.625331] ata2.00: configured for UDMA/33
>> [   33.635482] ata2: EH complete
>> [   38.700920] ata2.00: exception Emask 0x10 SAct 0x1000000 SErr 0x40d0002 action 0xe frozen
>> [   38.700933] ata2.00: irq_stat 0x00000040, connection status changed
>> [   38.700938] ata2: SError: { RecovComm PHYRdyChg CommWake 10B8B DevExch }
>> [   38.700949] ata2.00: failed command: WRITE FPDMA QUEUED
>> [   38.700952] ata2.00: cmd 61/18:c0:e0:78:d0/00:00:06:00:00/40 tag 24 ncq dma 12288 out
>>                         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 (ATA bus error)
>> [   38.700967] ata2.00: status: { DRDY }
>> [   38.700976] ata2: hard resetting link
>> [   39.597747] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
>> [   39.598795] ata2.00: configured for UDMA/33
>> [   39.608942] ata2: EH complete
>> [   40.270908] ata2.00: exception Emask 0x10 SAct 0x80000 SErr 0x40d0002 action 0xe frozen
>> [   40.270921] ata2.00: irq_stat 0x00000040, connection status changed
>> [   40.270925] ata2: SError: { RecovComm PHYRdyChg CommWake 10B8B DevExch }
>> [   40.270935] ata2.00: failed command: READ FPDMA QUEUED
>> [   40.270939] ata2.00: cmd 60/00:98:40:9b:86/01:00:06:00:00/40 tag 19 ncq dma 131072 in
>>                         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 (ATA bus error)
>> [   40.270954] ata2.00: status: { DRDY }
>> [   40.270963] ata2: hard resetting link
>> [   41.167649] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
>> [   41.168644] ata2.00: configured for UDMA/33
>> [   41.178795] sd 1:0:0:0: [sda] tag#19 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
>> [   41.178806] sd 1:0:0:0: [sda] tag#19 Sense Key : Illegal Request [current] 
>> [   41.178813] sd 1:0:0:0: [sda] tag#19 Add. Sense: Unaligned write command
>> [   41.178819] sd 1:0:0:0: [sda] tag#19 CDB: Read(10) 28 00 06 86 9b 40 00 01 00 00
>> [   41.178823] I/O error, dev sda, sector 109484864 op 0x0:(READ) flags 0x80700 phys_seg 2 prio class 0
>> [   41.178856] ata2: EH complete
>> [   44.674255] ata2.00: exception Emask 0x10 SAct 0x3 SErr 0x40d0002 action 0xe frozen
>> [   44.674268] ata2.00: irq_stat 0x00000040, connection status changed
>> [   44.674273] ata2: SError: { RecovComm PHYRdyChg CommWake 10B8B DevExch }
>> [   44.674281] ata2.00: failed command: WRITE FPDMA QUEUED
>> [   44.674285] ata2.00: cmd 61/08:00:00:79:d0/00:00:06:00:00/40 tag 0 ncq dma 4096 out
>>                         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 (ATA bus error)
>> [   44.674300] ata2.00: status: { DRDY }
>> [   44.674305] ata2.00: failed command: WRITE FPDMA QUEUED
>> [   44.674308] ata2.00: cmd 61/50:08:08:79:d0/00:00:06:00:00/40 tag 1 ncq dma 40960 out
>>                         res 40/00:01:00:00:00/00:00:00:00:00/00 Emask 0x10 (ATA bus error)
>> [   44.674322] ata2.00: status: { DRDY }
>> [   44.674332] ata2: hard resetting link
>> [   45.570935] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
>> [   45.571973] ata2.00: configured for UDMA/33
>> [   45.582165] ata2: EH complete
>> [   46.387598] ata2.00: exception Emask 0x10 SAct 0x2000 SErr 0x40d0002 action 0xe frozen
>> [   46.387612] ata2.00: irq_stat 0x00000040, connection status changed
>> [   46.387617] ata2: SError: { RecovComm PHYRdyChg CommWake 10B8B DevExch }
>> [   46.387626] ata2.00: failed command: READ FPDMA QUEUED
>> [   46.387630] ata2.00: cmd 60/40:68:c0:65:7f/02:00:01:00:00/40 tag 13 ncq dma 294912 in
>>                         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 (ATA bus error)
>> [   46.387646] ata2.00: status: { DRDY }
>> [   46.387655] ata2: hard resetting link
>> [   47.284289] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
>> [   47.285281] ata2.00: configured for UDMA/33
>> [   47.295485] sd 1:0:0:0: [sda] tag#13 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
>> [   47.295497] sd 1:0:0:0: [sda] tag#13 Sense Key : Illegal Request [current] 
>> [   47.295504] sd 1:0:0:0: [sda] tag#13 Add. Sense: Unaligned write command
>> [   47.295510] sd 1:0:0:0: [sda] tag#13 CDB: Read(10) 28 00 01 7f 65 c0 00 02 40 00
>> [   47.295514] I/O error, dev sda, sector 25126336 op 0x0:(READ) flags 0x80700 phys_seg 59 prio class 0
>> [   47.295555] ata2: EH complete
>> [   48.940920] ata2.00: exception Emask 0x10 SAct 0x78000 SErr 0x40d0002 action 0xe frozen
>> [   48.940933] ata2.00: irq_stat 0x00000040, connection status changed
>> [   48.940937] ata2: SError: { RecovComm PHYRdyChg CommWake 10B8B DevExch }
>> [   48.940947] ata2.00: failed command: WRITE FPDMA QUEUED
>> [   48.940950] ata2.00: cmd 61/f8:78:08:a4:c0/01:00:09:00:00/40 tag 15 ncq dma 258048 out
>>                         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 (ATA bus error)
>> [   48.940965] ata2.00: status: { DRDY }
>> [   48.940970] ata2.00: failed command: WRITE FPDMA QUEUED
>> [   48.940973] ata2.00: cmd 61/d8:80:00:f8:c1/01:00:09:00:00/40 tag 16 ncq dma 241664 out
>>                         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 (ATA bus error)
>> [   48.940987] ata2.00: status: { DRDY }
>> [   48.940992] ata2.00: failed command: WRITE FPDMA QUEUED
>> [   48.940995] ata2.00: cmd 61/08:88:00:18:a1/00:00:01:00:00/40 tag 17 ncq dma 4096 out
>>                         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 (ATA bus error)
>> [   48.941008] ata2.00: status: { DRDY }
>> [   48.941012] ata2.00: failed command: WRITE FPDMA QUEUED
>> [   48.941015] ata2.00: cmd 61/08:90:08:18:a1/00:00:01:00:00/40 tag 18 ncq dma 4096 out
>>                         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 (ATA bus error)
>> [   48.941028] ata2.00: status: { DRDY }
>> [   48.941035] ata2: hard resetting link
>> [   49.837603] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
>> [   49.838650] ata2.00: configured for UDMA/33
>> [   49.848795] ata2: EH complete
>> [   50.860925] ata2.00: exception Emask 0x10 SAct 0xff0000 SErr 0x40d0002 action 0xe frozen
>> [   50.860939] ata2.00: irq_stat 0x00000040, connection status changed
>> [   50.860944] ata2: SError: { RecovComm PHYRdyChg CommWake 10B8B DevExch }
>> [   50.860953] ata2.00: failed command: WRITE FPDMA QUEUED
>> [   50.860957] ata2.00: cmd 61/08:80:10:f8:07/00:00:00:00:00/40 tag 16 ncq dma 4096 out
>>                         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 (ATA bus error)
>> [   50.860973] ata2.00: status: { DRDY }
>> [   50.860978] ata2.00: failed command: WRITE FPDMA QUEUED
>> [   50.860981] ata2.00: cmd 61/08:88:48:1b:09/00:00:00:00:00/40 tag 17 ncq dma 4096 out
>>                         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 (ATA bus error)
>> [   50.860995] ata2.00: status: { DRDY }
>> [   50.860999] ata2.00: failed command: WRITE FPDMA QUEUED
>> [   50.861002] ata2.00: cmd 61/08:90:18:1c:09/00:00:00:00:00/40 tag 18 ncq dma 4096 out
>>                         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 (ATA bus error)
>> [   50.861015] ata2.00: status: { DRDY }
>> [   50.861020] ata2.00: failed command: WRITE FPDMA QUEUED
>> [   50.861023] ata2.00: cmd 61/08:98:00:f8:c7/00:00:01:00:00/40 tag 19 ncq dma 4096 out
>>                         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 (ATA bus error)
>> [   50.861035] ata2.00: status: { DRDY }
>> [   50.861039] ata2.00: failed command: WRITE FPDMA QUEUED
>> [   50.861043] ata2.00: cmd 61/08:a0:80:f8:c7/00:00:01:00:00/40 tag 20 ncq dma 4096 out
>>                         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 (ATA bus error)
>> [   50.861055] ata2.00: status: { DRDY }
>> [   50.861059] ata2.00: failed command: WRITE FPDMA QUEUED
>> [   50.861062] ata2.00: cmd 61/08:a8:a0:f9:c7/00:00:01:00:00/40 tag 21 ncq dma 4096 out
>>                         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 (ATA bus error)
>> [   50.861075] ata2.00: status: { DRDY }
>> [   50.861079] ata2.00: failed command: WRITE FPDMA QUEUED
>> [   50.861082] ata2.00: cmd 61/08:b0:c8:fd:c7/00:00:01:00:00/40 tag 22 ncq dma 4096 out
>>                         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 (ATA bus error)
>> [   50.861094] ata2.00: status: { DRDY }
>> [   50.861098] ata2.00: failed command: WRITE FPDMA QUEUED
>> [   50.861101] ata2.00: cmd 61/08:b8:b8:f9:c8/00:00:01:00:00/40 tag 23 ncq dma 4096 out
>>                         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 (ATA bus error)
>> [   50.861114] ata2.00: status: { DRDY }
>> [   50.861121] ata2: hard resetting link
>> [   51.757643] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
>> [   51.758674] ata2.00: configured for UDMA/33
>> [   51.768836] ata2: EH complete
>> [    0.000000] Linux version 6.10.0-rc1-1.1-mainline (linux-mainline@archlinux) (gcc (GCC) 14.1.1 20240522, GNU ld (GNU Binutils) 2.42.0) #1 SMP PREEMPT_DYNAMIC Mon, 27 May 2024 19:28:34 +0000
>> [    0.000000] Command line: BOOT_IMAGE=/vmlinuz-linux-mainline root=UUID=963daeed-0888-4658-9f17-18bd343dfb2a rw zswap.enabled=0 rootfstype=ext4 loglevel=3 quiet
>> [    0.000000] BIOS-provided physical RAM map:
>> [    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009f7ff] usable
>> [    0.000000] BIOS-e820: [mem 0x000000000009f800-0x000000000009ffff] reserved
>> [    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
>> [    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000bfdeffff] usable
>> [    0.000000] BIOS-e820: [mem 0x00000000bfdf0000-0x00000000bfdf2fff] ACPI NVS
>> [    0.000000] BIOS-e820: [mem 0x00000000bfdf3000-0x00000000bfdfffff] ACPI data
>> [    0.000000] BIOS-e820: [mem 0x00000000bfe00000-0x00000000bfefffff] reserved
>> [    0.000000] BIOS-e820: [mem 0x00000000e0000000-0x00000000efffffff] reserved
>> [    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000ffffffff] reserved
>> [    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000043effffff] usable
>> [    0.000000] NX (Execute Disable) protection: active
>> [    0.000000] APIC: Static calls initialized
>> [    0.000000] SMBIOS 2.4 present.
>> [    0.000000] DMI: Gigabyte Technology Co., Ltd. GA-78LMT-USB3 R2/GA-78LMT-USB3 R2, BIOS F1 11/08/2017
>> [    0.000000] DMI: Memory slots populated: 2/4
>> [    0.000000] tsc: Fast TSC calibration using PIT
>> [    0.000000] tsc: Detected 3321.904 MHz processor
>> [    0.002898] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
>> [    0.002902] e820: remove [mem 0x000a0000-0x000fffff] usable
>> [    0.002908] last_pfn = 0x43f000 max_arch_pfn = 0x400000000
>> [    0.002917] total RAM covered: 3070M
>> [    0.003218] Found optimal setting for mtrr clean up
>> [    0.003219]  gran_size: 64K 	chunk_size: 4M 	num_reg: 3  	lose cover RAM: 0G
>> [    0.003224] MTRR map: 7 entries (4 fixed + 3 variable; max 21), built from 9 variable MTRRs
>> [    0.003226] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
>> [    0.004086] e820: update [mem 0xbfe00000-0xffffffff] usable ==> reserved
>> [    0.004096] last_pfn = 0xbfdf0 max_arch_pfn = 0x400000000
>> [    0.006997] found SMP MP-table at [mem 0x000f5ea0-0x000f5eaf]
>> [    0.007018] Using GB pages for direct mapping
>> [    0.007298] RAMDISK: [mem 0x31cc3000-0x34e58fff]
>> [    0.007401] ACPI: Early table checksum verification disabled
>> [    0.007406] ACPI: RSDP 0x00000000000F78B0 000014 (v00 GBT   )
>> [    0.007411] ACPI: RSDT 0x00000000BFDF3000 000040 (v01 GBT    GBTUACPI 42302E31 GBTU 01010101)
>> [    0.007417] ACPI: FACP 0x00000000BFDF3080 000074 (v01 GBT    GBTUACPI 42302E31 GBTU 01010101)
>> [    0.007423] ACPI: DSDT 0x00000000BFDF3100 0069E7 (v01 GBT    GBTUACPI 00001000 MSFT 03000000)
>> [    0.007427] ACPI: FACS 0x00000000BFDF0000 000040
>> [    0.007431] ACPI: MSDM 0x00000000BFDF9BC0 000055 (v03 GBT    GBTUACPI 42302E31 GBTU 01010101)
>> [    0.007435] ACPI: HPET 0x00000000BFDF9C40 000038 (v01 GBT    GBTUACPI 42302E31 GBTU 00000098)
>> [    0.007438] ACPI: MCFG 0x00000000BFDF9C80 00003C (v01 GBT    GBTUACPI 42302E31 GBTU 01010101)
>> [    0.007442] ACPI: TAMG 0x00000000BFDF9CC0 000022 (v01 GBT    GBT   B0 5455312E BG?? 00000101)
>> [    0.007446] ACPI: APIC 0x00000000BFDF9B00 0000BC (v01 GBT    GBTUACPI 42302E31 GBTU 01010101)
>> [    0.007450] ACPI: SSDT 0x00000000BFDF9D60 001714 (v01 AMD    POWERNOW 00000001 AMD  00000001)
>> [    0.007453] ACPI: Reserving FACP table memory at [mem 0xbfdf3080-0xbfdf30f3]
>> [    0.007454] ACPI: Reserving DSDT table memory at [mem 0xbfdf3100-0xbfdf9ae6]
>> [    0.007456] ACPI: Reserving FACS table memory at [mem 0xbfdf0000-0xbfdf003f]
>> [    0.007457] ACPI: Reserving MSDM table memory at [mem 0xbfdf9bc0-0xbfdf9c14]
>> [    0.007458] ACPI: Reserving HPET table memory at [mem 0xbfdf9c40-0xbfdf9c77]
>> [    0.007459] ACPI: Reserving MCFG table memory at [mem 0xbfdf9c80-0xbfdf9cbb]
>> [    0.007460] ACPI: Reserving TAMG table memory at [mem 0xbfdf9cc0-0xbfdf9ce1]
>> [    0.007462] ACPI: Reserving APIC table memory at [mem 0xbfdf9b00-0xbfdf9bbb]
>> [    0.007463] ACPI: Reserving SSDT table memory at [mem 0xbfdf9d60-0xbfdfb473]
>> [    0.007526] No NUMA configuration found
>> [    0.007527] Faking a node at [mem 0x0000000000000000-0x000000043effffff]
>> [    0.007531] NODE_DATA(0) allocated [mem 0x43effb000-0x43effffff]
>> [    0.007572] Zone ranges:
>> [    0.007572]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
>> [    0.007575]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
>> [    0.007576]   Normal   [mem 0x0000000100000000-0x000000043effffff]
>> [    0.007578]   Device   empty
>> [    0.007579] Movable zone start for each node
>> [    0.007580] Early memory node ranges
>> [    0.007581]   node   0: [mem 0x0000000000001000-0x000000000009efff]
>> [    0.007583]   node   0: [mem 0x0000000000100000-0x00000000bfdeffff]
>> [    0.007584]   node   0: [mem 0x0000000100000000-0x000000043effffff]
>> [    0.007587] Initmem setup node 0 [mem 0x0000000000001000-0x000000043effffff]
>> [    0.007593] On node 0, zone DMA: 1 pages in unavailable ranges
>> [    0.007635] On node 0, zone DMA: 97 pages in unavailable ranges
>> [    0.055259] On node 0, zone Normal: 528 pages in unavailable ranges
>> [    0.055335] On node 0, zone Normal: 4096 pages in unavailable ranges
>> [    0.055516] ACPI: PM-Timer IO Port: 0x4008
>> [    0.055528] ACPI: LAPIC_NMI (acpi_id[0x00] dfl dfl lint[0x1])
>> [    0.055530] ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])
>> [    0.055531] ACPI: LAPIC_NMI (acpi_id[0x02] dfl dfl lint[0x1])
>> [    0.055533] ACPI: LAPIC_NMI (acpi_id[0x03] dfl dfl lint[0x1])
>> [    0.055534] ACPI: LAPIC_NMI (acpi_id[0x04] dfl dfl lint[0x1])
>> [    0.055535] ACPI: LAPIC_NMI (acpi_id[0x05] dfl dfl lint[0x1])
>> [    0.055536] ACPI: LAPIC_NMI (acpi_id[0x06] dfl dfl lint[0x1])
>> [    0.055537] ACPI: LAPIC_NMI (acpi_id[0x07] dfl dfl lint[0x1])
>> [    0.055549] IOAPIC[0]: apic_id 2, version 33, address 0xfec00000, GSI 0-23
>> [    0.055552] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
>> [    0.055555] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
>> [    0.055559] ACPI: Using ACPI (MADT) for SMP configuration information
>> [    0.055561] ACPI: HPET id: 0x10b9a201 base: 0xfed00000
>> [    0.055570] CPU topo: Max. logical packages:   1
>> [    0.055572] CPU topo: Max. logical dies:       1
>> [    0.055573] CPU topo: Max. dies per package:   1
>> [    0.055578] CPU topo: Max. threads per core:   1
>> [    0.055579] CPU topo: Num. cores per package:     8
>> [    0.055580] CPU topo: Num. threads per package:   8
>> [    0.055580] CPU topo: Allowing 8 present CPUs plus 0 hotplug CPUs
>> [    0.055593] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
>> [    0.055595] PM: hibernation: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
>> [    0.055596] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000effff]
>> [    0.055598] PM: hibernation: Registered nosave memory: [mem 0x000f0000-0x000fffff]
>> [    0.055599] PM: hibernation: Registered nosave memory: [mem 0xbfdf0000-0xbfdf2fff]
>> [    0.055600] PM: hibernation: Registered nosave memory: [mem 0xbfdf3000-0xbfdfffff]
>> [    0.055601] PM: hibernation: Registered nosave memory: [mem 0xbfe00000-0xbfefffff]
>> [    0.055602] PM: hibernation: Registered nosave memory: [mem 0xbff00000-0xdfffffff]
>> [    0.055603] PM: hibernation: Registered nosave memory: [mem 0xe0000000-0xefffffff]
>> [    0.055604] PM: hibernation: Registered nosave memory: [mem 0xf0000000-0xfebfffff]
>> [    0.055605] PM: hibernation: Registered nosave memory: [mem 0xfec00000-0xffffffff]
>> [    0.055608] [mem 0xbff00000-0xdfffffff] available for PCI devices
>> [    0.055609] Booting paravirtualized kernel on bare hardware
>> [    0.055612] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 6370452778343963 ns
>> [    0.061591] setup_percpu: NR_CPUS:320 nr_cpumask_bits:8 nr_cpu_ids:8 nr_node_ids:1
>> [    0.062566] percpu: Embedded 66 pages/cpu s233472 r8192 d28672 u524288
>> [    0.062574] pcpu-alloc: s233472 r8192 d28672 u524288 alloc=1*2097152
>> [    0.062578] pcpu-alloc: [0] 0 1 2 3 [0] 4 5 6 7 
>> [    0.062599] Kernel command line: BOOT_IMAGE=/vmlinuz-linux-mainline root=UUID=963daeed-0888-4658-9f17-18bd343dfb2a rw zswap.enabled=0 rootfstype=ext4 loglevel=3 quiet
>> [    0.062678] Unknown kernel command line parameters "BOOT_IMAGE=/vmlinuz-linux-mainline", will be passed to user space.
>> [    0.065485] Dentry cache hash table entries: 2097152 (order: 12, 16777216 bytes, linear)
>> [    0.066928] Inode-cache hash table entries: 1048576 (order: 11, 8388608 bytes, linear)
>> [    0.067006] Fallback order for Node 0: 0 
>> [    0.067011] Built 1 zonelists, mobility grouping on.  Total pages: 4189582
>> [    0.067013] Policy zone: Normal
>> [    0.067423] mem auto-init: stack:all(zero), heap alloc:on, heap free:off, mlocked free:off
>> [    0.067430] software IO TLB: area num 8.
>> [    0.153788] Memory: 16301880K/16758328K available (18432K kernel code, 2176K rwdata, 13400K rodata, 3428K init, 3572K bss, 456188K reserved, 0K cma-reserved)
>> [    0.161940] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
>> [    0.162138] ftrace: allocating 50086 entries in 196 pages
>> [    0.173494] ftrace: allocated 196 pages with 3 groups
>> [    0.173657] Dynamic Preempt: full
>> [    0.173885] rcu: Preemptible hierarchical RCU implementation.
>> [    0.173887] rcu: 	RCU restricting CPUs from NR_CPUS=320 to nr_cpu_ids=8.
>> [    0.173888] rcu: 	RCU priority boosting: priority 1 delay 500 ms.
>> [    0.173890] 	Trampoline variant of Tasks RCU enabled.
>> [    0.173890] 	Rude variant of Tasks RCU enabled.
>> [    0.173891] 	Tracing variant of Tasks RCU enabled.
>> [    0.173892] rcu: RCU calculated value of scheduler-enlistment delay is 30 jiffies.
>> [    0.173893] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=8
>> [    0.173902] RCU Tasks: Setting shift to 3 and lim to 1 rcu_task_cb_adjust=1.
>> [    0.173905] RCU Tasks Rude: Setting shift to 3 and lim to 1 rcu_task_cb_adjust=1.
>> [    0.173907] RCU Tasks Trace: Setting shift to 3 and lim to 1 rcu_task_cb_adjust=1.
>> [    0.179570] NR_IRQS: 20736, nr_irqs: 488, preallocated irqs: 16
>> [    0.179784] rcu: srcu_init: Setting srcu_struct sizes based on contention.
>> [    0.179879] kfence: initialized - using 2097152 bytes for 255 objects at 0x(____ptrval____)-0x(____ptrval____)
>> [    0.179956] spurious 8259A interrupt: IRQ7.
>> [    0.179980] Console: colour dummy device 80x25
>> [    0.179984] printk: legacy console [tty0] enabled
>> [    0.180390] ACPI: Core revision 20240322
>> [    0.180614] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484873504 ns
>> [    0.180648] APIC: Switch to symmetric I/O mode setup
>> [    0.181152] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
>> [    0.197302] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x2fe21ff3be8, max_idle_ns: 440795205660 ns
>> [    0.197308] Calibrating delay loop (skipped), value calculated using timer frequency.. 6646.63 BogoMIPS (lpj=11073013)
>> [    0.197338] LVT offset 1 assigned for vector 0xf9
>> [    0.197343] Last level iTLB entries: 4KB 512, 2MB 1024, 4MB 512
>> [    0.197345] Last level dTLB entries: 4KB 1024, 2MB 1024, 4MB 512, 1GB 0
>> [    0.197350] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
>> [    0.197352] Spectre V2 : Mitigation: Retpolines
>> [    0.197353] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
>> [    0.197355] Spectre V2 : Spectre v2 / SpectreRSB : Filling RSB on VMEXIT
>> [    0.197356] Spectre V2 : Enabling Speculation Barrier for firmware calls
>> [    0.197357] RETBleed: Mitigation: untrained return thunk
>> [    0.197359] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
>> [    0.197361] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl
>> [    0.197365] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
>> [    0.197367] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
>> [    0.197368] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
>> [    0.197370] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
>> [    0.197372] x86/fpu: Enabled xstate features 0x7, context size is 832 bytes, using 'standard' format.
>> [    0.222663] Freeing SMP alternatives memory: 40K
>> [    0.222669] pid_max: default: 32768 minimum: 301
>> [    0.223427] LSM: initializing lsm=capability,landlock,lockdown,yama,bpf
>> [    0.224276] landlock: Up and running.
>> [    0.224279] Yama: becoming mindful.
>> [    0.224286] LSM support for eBPF active
>> [    0.224534] Mount-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
>> [    0.224574] Mountpoint-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
>> [    0.230788] APIC calibration not consistent with PM-Timer: 0ms instead of 100ms
>> [    0.230793] APIC delta adjusted to PM-Timer: 1259529 (1506)
>> [    0.230803] smpboot: CPU0: AMD FX(tm)-8300 Eight-Core Processor (family: 0x15, model: 0x2, stepping: 0x0)
>> [    0.231213] Performance Events: Fam15h core perfctr, AMD PMU driver.
>> [    0.231219] ... version:                0
>> [    0.231220] ... bit width:              48
>> [    0.231221] ... generic registers:      6
>> [    0.231222] ... value mask:             0000ffffffffffff
>> [    0.231224] ... max period:             00007fffffffffff
>> [    0.231225] ... fixed-purpose events:   0
>> [    0.231226] ... event mask:             000000000000003f
>> [    0.231331] signal: max sigframe size: 1776
>> [    0.231377] rcu: Hierarchical SRCU implementation.
>> [    0.231378] rcu: 	Max phase no-delay instances is 1000.
>> [    0.233728] MCE: In-kernel MCE decoding enabled.
>> [    0.233797] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
>> [    0.233938] smp: Bringing up secondary CPUs ...
>> [    0.233972] smpboot: x86: Booting SMP configuration:
>> [    0.233972] .... node  #0, CPUs:      #1 #2 #3 #4 #5 #6 #7
>> [    0.000830] call_irq_handler: 1.55 No irq handler for vector
>> [    0.000830] call_irq_handler: 2.55 No irq handler for vector
>> [    0.000830] call_irq_handler: 3.55 No irq handler for vector
>> [    0.000830] call_irq_handler: 4.55 No irq handler for vector
>> [    0.000830] call_irq_handler: 5.55 No irq handler for vector
>> [    0.000830] call_irq_handler: 6.55 No irq handler for vector
>> [    0.000830] call_irq_handler: 7.55 No irq handler for vector
>> [    0.261635] smp: Brought up 1 node, 8 CPUs
>> [    0.261635] smpboot: Total of 8 processors activated (53171.06 BogoMIPS)
>> [    0.265003] devtmpfs: initialized
>> [    0.265003] x86/mm: Memory block size: 128MB
>> [    0.268551] ACPI: PM: Registering ACPI NVS region [mem 0xbfdf0000-0xbfdf2fff] (12288 bytes)
>> [    0.268551] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 6370867519511994 ns
>> [    0.268551] futex hash table entries: 2048 (order: 5, 131072 bytes, linear)
>> [    0.268551] pinctrl core: initialized pinctrl subsystem
>> [    0.268551] PM: RTC time: 14:55:24, date: 2024-05-28
>> [    0.268691] NET: Registered PF_NETLINK/PF_ROUTE protocol family
>> [    0.269102] DMA: preallocated 2048 KiB GFP_KERNEL pool for atomic allocations
>> [    0.269371] DMA: preallocated 2048 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
>> [    0.269670] DMA: preallocated 2048 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
>> [    0.269684] audit: initializing netlink subsys (disabled)
>> [    0.270682] audit: type=2000 audit(1716908123.093:1): state=initialized audit_enabled=0 res=1
>> [    0.270802] thermal_sys: Registered thermal governor 'fair_share'
>> [    0.270804] thermal_sys: Registered thermal governor 'bang_bang'
>> [    0.270805] thermal_sys: Registered thermal governor 'step_wise'
>> [    0.270807] thermal_sys: Registered thermal governor 'user_space'
>> [    0.270808] thermal_sys: Registered thermal governor 'power_allocator'
>> [    0.270818] cpuidle: using governor ladder
>> [    0.270818] cpuidle: using governor menu
>> [    0.270818] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
>> [    0.271055] PCI: ECAM [mem 0xe0000000-0xefffffff] (base 0xe0000000) for domain 0000 [bus 00-ff]
>> [    0.271071] PCI: Using configuration type 1 for base access
>> [    0.271227] kprobes: kprobe jump-optimization is enabled. All kprobes are optimized if possible.
>> [    0.274047] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
>> [    0.274047] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
>> [    0.274047] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
>> [    0.274047] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
>> [    0.274068] Demotion targets for Node 0: null
>> [    0.274192] fbcon: Taking over console
>> [    0.274192] ACPI: Added _OSI(Module Device)
>> [    0.274192] ACPI: Added _OSI(Processor Device)
>> [    0.274192] ACPI: Added _OSI(3.0 _SCP Extensions)
>> [    0.274192] ACPI: Added _OSI(Processor Aggregator Device)
>> [    0.278725] ACPI: 2 ACPI AML tables successfully acquired and loaded
>> [    0.278998] ACPI Error: AE_NOT_FOUND, While resolving a named reference package element - LNKC (20240322/dspkginit-438)
>> [    0.279005] ACPI Error: AE_NOT_FOUND, While resolving a named reference package element - LNKD (20240322/dspkginit-438)
>> [    0.279010] ACPI Error: AE_NOT_FOUND, While resolving a named reference package element - LNKA (20240322/dspkginit-438)
>> [    0.279016] ACPI Error: AE_NOT_FOUND, While resolving a named reference package element - LNKB (20240322/dspkginit-438)
>> [    0.279028] ACPI Error: AE_NOT_FOUND, While resolving a named reference package element - LNKD (20240322/dspkginit-438)
>> [    0.279034] ACPI Error: AE_NOT_FOUND, While resolving a named reference package element - LNKA (20240322/dspkginit-438)
>> [    0.279040] ACPI Error: AE_NOT_FOUND, While resolving a named reference package element - LNKB (20240322/dspkginit-438)
>> [    0.279046] ACPI Error: AE_NOT_FOUND, While resolving a named reference package element - LNKC (20240322/dspkginit-438)
>> [    0.279057] ACPI Error: AE_NOT_FOUND, While resolving a named reference package element - LNKA (20240322/dspkginit-438)
>> [    0.279063] ACPI Error: AE_NOT_FOUND, While resolving a named reference package element - LNKB (20240322/dspkginit-438)
>> [    0.279069] ACPI Error: AE_NOT_FOUND, While resolving a named reference package element - LNKC (20240322/dspkginit-438)
>> [    0.279075] ACPI Error: AE_NOT_FOUND, While resolving a named reference package element - LNKD (20240322/dspkginit-438)
>> [    0.279086] ACPI Error: AE_NOT_FOUND, While resolving a named reference package element - LNKB (20240322/dspkginit-438)
>> [    0.279092] ACPI Error: AE_NOT_FOUND, While resolving a named reference package element - LNKC (20240322/dspkginit-438)
>> [    0.279097] ACPI Error: AE_NOT_FOUND, While resolving a named reference package element - LNKD (20240322/dspkginit-438)
>> [    0.279103] ACPI Error: AE_NOT_FOUND, While resolving a named reference package element - LNKA (20240322/dspkginit-438)
>> [    0.279114] ACPI Error: AE_NOT_FOUND, While resolving a named reference package element - LNKC (20240322/dspkginit-438)
>> [    0.279120] ACPI Error: AE_NOT_FOUND, While resolving a named reference package element - LNKD (20240322/dspkginit-438)
>> [    0.279126] ACPI Error: AE_NOT_FOUND, While resolving a named reference package element - LNKA (20240322/dspkginit-438)
>> [    0.279131] ACPI Error: AE_NOT_FOUND, While resolving a named reference package element - LNKB (20240322/dspkginit-438)
>> [    0.279142] ACPI Error: AE_NOT_FOUND, While resolving a named reference package element - LNKD (20240322/dspkginit-438)
>> [    0.279148] ACPI Error: AE_NOT_FOUND, While resolving a named reference package element - LNKA (20240322/dspkginit-438)
>> [    0.279153] ACPI Error: AE_NOT_FOUND, While resolving a named reference package element - LNKB (20240322/dspkginit-438)
>> [    0.279159] ACPI Error: AE_NOT_FOUND, While resolving a named reference package element - LNKC (20240322/dspkginit-438)
>> [    0.279170] ACPI Error: AE_NOT_FOUND, While resolving a named reference package element - LNKB (20240322/dspkginit-438)
>> [    0.279176] ACPI Error: AE_NOT_FOUND, While resolving a named reference package element - LNKC (20240322/dspkginit-438)
>> [    0.279181] ACPI Error: AE_NOT_FOUND, While resolving a named reference package element - LNKD (20240322/dspkginit-438)
>> [    0.279187] ACPI Error: AE_NOT_FOUND, While resolving a named reference package element - LNKA (20240322/dspkginit-438)
>> [    0.279198] ACPI Error: AE_NOT_FOUND, While resolving a named reference package element - LNKC (20240322/dspkginit-438)
>> [    0.279204] ACPI Error: AE_NOT_FOUND, While resolving a named reference package element - LNKD (20240322/dspkginit-438)
>> [    0.279209] ACPI Error: AE_NOT_FOUND, While resolving a named reference package element - LNKA (20240322/dspkginit-438)
>> [    0.279215] ACPI Error: AE_NOT_FOUND, While resolving a named reference package element - LNKB (20240322/dspkginit-438)
>> [    0.279226] ACPI Error: AE_NOT_FOUND, While resolving a named reference package element - LNKD (20240322/dspkginit-438)
>> [    0.279231] ACPI Error: AE_NOT_FOUND, While resolving a named reference package element - LNKA (20240322/dspkginit-438)
>> [    0.279237] ACPI Error: AE_NOT_FOUND, While resolving a named reference package element - LNKB (20240322/dspkginit-438)
>> [    0.279242] ACPI Error: AE_NOT_FOUND, While resolving a named reference package element - LNKC (20240322/dspkginit-438)
>> [    0.279254] ACPI Error: AE_NOT_FOUND, While resolving a named reference package element - LNKA (20240322/dspkginit-438)
>> [    0.279259] ACPI Error: AE_NOT_FOUND, While resolving a named reference package element - LNKB (20240322/dspkginit-438)
>> [    0.279265] ACPI Error: AE_NOT_FOUND, While resolving a named reference package element - LNKC (20240322/dspkginit-438)
>> [    0.279270] ACPI Error: AE_NOT_FOUND, While resolving a named reference package element - LNKD (20240322/dspkginit-438)
>> [    0.284061] ACPI: _OSC evaluation for CPUs failed, trying _PDC
>> [    0.284126] ACPI: Interpreter enabled
>> [    0.284126] ACPI: PM: (supports S0 S3 S4 S5)
>> [    0.284126] ACPI: Using IOAPIC for interrupt routing
>> [    0.284458] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
>> [    0.284460] PCI: Using E820 reservations for host bridge windows
>> [    0.284609] ACPI: Enabled 5 GPEs in block 00 to 1F
>> [    0.291651] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
>> [    0.291658] acpi PNP0A03:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI EDR HPX-Type3]
>> [    0.292037] PCI host bridge to bus 0000:00
>> [    0.292039] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
>> [    0.292042] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
>> [    0.292045] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000dffff window]
>> [    0.292047] pci_bus 0000:00: root bus resource [mem 0xc0000000-0xfebfffff window]
>> [    0.292050] pci_bus 0000:00: root bus resource [bus 00-ff]
>> [    0.292068] pci 0000:00:00.0: [1022:9600] type 00 class 0x060000 conventional PCI endpoint
>> [    0.292080] pci 0000:00:00.0: [Firmware Bug]: BAR 3: invalid; can't size
>> [    0.292159] pci 0000:00:02.0: [1022:9603] type 01 class 0x060400 PCIe Root Port
>> [    0.292172] pci 0000:00:02.0: PCI bridge to [bus 01]
>> [    0.292176] pci 0000:00:02.0:   bridge window [io  0xe000-0xefff]
>> [    0.292179] pci 0000:00:02.0:   bridge window [mem 0xfb000000-0xfcffffff]
>> [    0.292185] pci 0000:00:02.0:   bridge window [mem 0xc0000000-0xdfffffff 64bit pref]
>> [    0.292191] pci 0000:00:02.0: enabling Extended Tags
>> [    0.292219] pci 0000:00:02.0: PME# supported from D0 D3hot D3cold
>> [    0.292325] pci 0000:00:04.0: [1022:9604] type 01 class 0x060400 PCIe Root Port
>> [    0.292338] pci 0000:00:04.0: PCI bridge to [bus 02]
>> [    0.292342] pci 0000:00:04.0:   bridge window [io  0xd000-0xdfff]
>> [    0.292344] pci 0000:00:04.0:   bridge window [mem 0xfda00000-0xfdafffff]
>> [    0.292349] pci 0000:00:04.0:   bridge window [mem 0xfdf00000-0xfdffffff 64bit pref]
>> [    0.292355] pci 0000:00:04.0: enabling Extended Tags
>> [    0.292382] pci 0000:00:04.0: PME# supported from D0 D3hot D3cold
>> [    0.292485] pci 0000:00:06.0: [1022:9606] type 01 class 0x060400 PCIe Root Port
>> [    0.292498] pci 0000:00:06.0: PCI bridge to [bus 03]
>> [    0.292502] pci 0000:00:06.0:   bridge window [io  0xc000-0xcfff]
>> [    0.292504] pci 0000:00:06.0:   bridge window [mem 0xfde00000-0xfdefffff]
>> [    0.292509] pci 0000:00:06.0:   bridge window [mem 0xfdd00000-0xfddfffff 64bit pref]
>> [    0.292515] pci 0000:00:06.0: enabling Extended Tags
>> [    0.292542] pci 0000:00:06.0: PME# supported from D0 D3hot D3cold
>> [    0.292669] pci 0000:00:11.0: [1002:4390] type 00 class 0x01018f conventional PCI endpoint
>> [    0.292686] pci 0000:00:11.0: BAR 0 [io  0xff00-0xff07]
>> [    0.292696] pci 0000:00:11.0: BAR 1 [io  0xfe00-0xfe03]
>> [    0.292705] pci 0000:00:11.0: BAR 2 [io  0xfd00-0xfd07]
>> [    0.292714] pci 0000:00:11.0: BAR 3 [io  0xfc00-0xfc03]
>> [    0.292723] pci 0000:00:11.0: BAR 4 [io  0xfb00-0xfb0f]
>> [    0.292732] pci 0000:00:11.0: BAR 5 [mem 0xfe02f000-0xfe02f3ff]
>> [    0.292754] pci 0000:00:11.0: set SATA to AHCI mode
>> [    0.292864] pci 0000:00:12.0: [1002:4397] type 00 class 0x0c0310 conventional PCI endpoint
>> [    0.292883] pci 0000:00:12.0: BAR 0 [mem 0xfe02e000-0xfe02efff]
>> [    0.293014] pci 0000:00:12.1: [1002:4398] type 00 class 0x0c0310 conventional PCI endpoint
>> [    0.293031] pci 0000:00:12.1: BAR 0 [mem 0xfe02d000-0xfe02dfff]
>> [    0.293175] pci 0000:00:12.2: [1002:4396] type 00 class 0x0c0320 conventional PCI endpoint
>> [    0.293192] pci 0000:00:12.2: BAR 0 [mem 0xfe02c000-0xfe02c0ff]
>> [    0.293270] pci 0000:00:12.2: supports D1 D2
>> [    0.293272] pci 0000:00:12.2: PME# supported from D0 D1 D2 D3hot
>> [    0.293362] pci 0000:00:13.0: [1002:4397] type 00 class 0x0c0310 conventional PCI endpoint
>> [    0.293379] pci 0000:00:13.0: BAR 0 [mem 0xfe02b000-0xfe02bfff]
>> [    0.293512] pci 0000:00:13.1: [1002:4398] type 00 class 0x0c0310 conventional PCI endpoint
>> [    0.293529] pci 0000:00:13.1: BAR 0 [mem 0xfe02a000-0xfe02afff]
>> [    0.293665] pci 0000:00:13.2: [1002:4396] type 00 class 0x0c0320 conventional PCI endpoint
>> [    0.293682] pci 0000:00:13.2: BAR 0 [mem 0xfe029000-0xfe0290ff]
>> [    0.293760] pci 0000:00:13.2: supports D1 D2
>> [    0.293762] pci 0000:00:13.2: PME# supported from D0 D1 D2 D3hot
>> [    0.293857] pci 0000:00:14.0: [1002:4385] type 00 class 0x0c0500 conventional PCI endpoint
>> [    0.294016] pci 0000:00:14.1: [1002:439c] type 00 class 0x01018a conventional PCI endpoint
>> [    0.294033] pci 0000:00:14.1: BAR 0 [io  0x0000-0x0007]
>> [    0.294042] pci 0000:00:14.1: BAR 1 [io  0x0000-0x0003]
>> [    0.294051] pci 0000:00:14.1: BAR 2 [io  0x0000-0x0007]
>> [    0.294060] pci 0000:00:14.1: BAR 3 [io  0x0000-0x0003]
>> [    0.294069] pci 0000:00:14.1: BAR 4 [io  0xfa00-0xfa0f]
>> [    0.294089] pci 0000:00:14.1: BAR 0 [io  0x01f0-0x01f7]: legacy IDE quirk
>> [    0.294090] pci 0000:00:14.1: BAR 1 [io  0x03f6]: legacy IDE quirk
>> [    0.294092] pci 0000:00:14.1: BAR 2 [io  0x0170-0x0177]: legacy IDE quirk
>> [    0.294094] pci 0000:00:14.1: BAR 3 [io  0x0376]: legacy IDE quirk
>> [    0.294201] pci 0000:00:14.2: [1002:4383] type 00 class 0x040300 conventional PCI endpoint
>> [    0.294223] pci 0000:00:14.2: BAR 0 [mem 0xfe024000-0xfe027fff 64bit]
>> [    0.294288] pci 0000:00:14.2: PME# supported from D0 D3hot D3cold
>> [    0.294373] pci 0000:00:14.3: [1002:439d] type 00 class 0x060100 conventional PCI endpoint
>> [    0.294539] pci 0000:00:14.4: [1002:4384] type 01 class 0x060401 conventional PCI bridge
>> [    0.294570] pci 0000:00:14.4: PCI bridge to [bus 04] (subtractive decode)
>> [    0.294576] pci 0000:00:14.4:   bridge window [io  0xb000-0xbfff]
>> [    0.294579] pci 0000:00:14.4:   bridge window [mem 0xfdc00000-0xfdcfffff]
>> [    0.294585] pci 0000:00:14.4:   bridge window [mem 0xfdb00000-0xfdbfffff pref]
>> [    0.294675] pci 0000:00:14.5: [1002:4399] type 00 class 0x0c0310 conventional PCI endpoint
>> [    0.294692] pci 0000:00:14.5: BAR 0 [mem 0xfe028000-0xfe028fff]
>> [    0.294826] pci 0000:00:18.0: [1022:1600] type 00 class 0x060000 conventional PCI endpoint
>> [    0.294878] pci 0000:00:18.1: [1022:1601] type 00 class 0x060000 conventional PCI endpoint
>> [    0.294926] pci 0000:00:18.2: [1022:1602] type 00 class 0x060000 conventional PCI endpoint
>> [    0.294974] pci 0000:00:18.3: [1022:1603] type 00 class 0x060000 conventional PCI endpoint
>> [    0.295027] pci 0000:00:18.4: [1022:1604] type 00 class 0x060000 conventional PCI endpoint
>> [    0.295084] pci 0000:00:18.5: [1022:1605] type 00 class 0x060000 conventional PCI endpoint
>> [    0.295186] pci 0000:01:00.0: [10de:1c82] type 00 class 0x030000 PCIe Legacy Endpoint
>> [    0.295200] pci 0000:01:00.0: BAR 0 [mem 0xfb000000-0xfbffffff]
>> [    0.295211] pci 0000:01:00.0: BAR 1 [mem 0xc0000000-0xcfffffff 64bit pref]
>> [    0.295222] pci 0000:01:00.0: BAR 3 [mem 0xde000000-0xdfffffff 64bit pref]
>> [    0.295229] pci 0000:01:00.0: BAR 5 [io  0xef00-0xef7f]
>> [    0.295237] pci 0000:01:00.0: ROM [mem 0x00000000-0x0007ffff pref]
>> [    0.295267] pci 0000:01:00.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
>> [    0.295352] pci 0000:01:00.0: 32.000 Gb/s available PCIe bandwidth, limited by 2.5 GT/s PCIe x16 link at 0000:00:02.0 (capable of 126.016 Gb/s with 8.0 GT/s PCIe x16 link)
>> [    0.295433] pci 0000:01:00.1: [10de:0fb9] type 00 class 0x040300 PCIe Endpoint
>> [    0.295447] pci 0000:01:00.1: BAR 0 [mem 0xfcffc000-0xfcffffff]
>> [    0.295596] pci 0000:00:02.0: PCI bridge to [bus 01]
>> [    0.295643] pci 0000:02:00.0: [1106:3483] type 00 class 0x0c0330 PCIe Endpoint
>> [    0.295658] pci 0000:02:00.0: BAR 0 [mem 0xfdaff000-0xfdafffff 64bit]
>> [    0.295719] pci 0000:02:00.0: PME# supported from D0 D1 D2 D3hot D3cold
>> [    0.295791] pci 0000:00:04.0: PCI bridge to [bus 02]
>> [    0.295839] pci 0000:03:00.0: [10ec:8168] type 00 class 0x020000 PCIe Endpoint
>> [    0.295855] pci 0000:03:00.0: BAR 0 [io  0xce00-0xceff]
>> [    0.295875] pci 0000:03:00.0: BAR 2 [mem 0xfdeff000-0xfdefffff 64bit]
>> [    0.295889] pci 0000:03:00.0: BAR 4 [mem 0xfddfc000-0xfddfffff 64bit pref]
>> [    0.295971] pci 0000:03:00.0: supports D1 D2
>> [    0.295973] pci 0000:03:00.0: PME# supported from D0 D1 D2 D3hot D3cold
>> [    0.296102] pci 0000:00:06.0: PCI bridge to [bus 03]
>> [    0.296118] pci_bus 0000:04: extended config space not accessible
>> [    0.296180] pci 0000:00:14.4: PCI bridge to [bus 04] (subtractive decode)
>> [    0.296190] pci 0000:00:14.4:   bridge window [io  0x0000-0x0cf7 window] (subtractive decode)
>> [    0.296192] pci 0000:00:14.4:   bridge window [io  0x0d00-0xffff window] (subtractive decode)
>> [    0.296194] pci 0000:00:14.4:   bridge window [mem 0x000a0000-0x000dffff window] (subtractive decode)
>> [    0.296197] pci 0000:00:14.4:   bridge window [mem 0xc0000000-0xfebfffff window] (subtractive decode)
>> [    0.296492] ACPI: PCI: Interrupt link LNKA configured for IRQ 0
>> [    0.296494] ACPI: PCI: Interrupt link LNKA disabled
>> [    0.296554] ACPI: PCI: Interrupt link LNKB configured for IRQ 0
>> [    0.296556] ACPI: PCI: Interrupt link LNKB disabled
>> [    0.296615] ACPI: PCI: Interrupt link LNKC configured for IRQ 0
>> [    0.296617] ACPI: PCI: Interrupt link LNKC disabled
>> [    0.296675] ACPI: PCI: Interrupt link LNKD configured for IRQ 0
>> [    0.296677] ACPI: PCI: Interrupt link LNKD disabled
>> [    0.296736] ACPI: PCI: Interrupt link LNKE configured for IRQ 0
>> [    0.296738] ACPI: PCI: Interrupt link LNKE disabled
>> [    0.296796] ACPI: PCI: Interrupt link LNKF configured for IRQ 0
>> [    0.296797] ACPI: PCI: Interrupt link LNKF disabled
>> [    0.296855] ACPI: PCI: Interrupt link LNK0 configured for IRQ 0
>> [    0.296857] ACPI: PCI: Interrupt link LNK0 disabled
>> [    0.296915] ACPI: PCI: Interrupt link LNK1 configured for IRQ 0
>> [    0.296916] ACPI: PCI: Interrupt link LNK1 disabled
>> [    0.297713] iommu: Default domain type: Translated
>> [    0.297713] iommu: DMA domain TLB invalidation policy: lazy mode
>> [    0.297713] SCSI subsystem initialized
>> [    0.297713] libata version 3.00 loaded.
>> [    0.297713] ACPI: bus type USB registered
>> [    0.297713] usbcore: registered new interface driver usbfs
>> [    0.297713] usbcore: registered new interface driver hub
>> [    0.297713] usbcore: registered new device driver usb
>> [    0.297713] EDAC MC: Ver: 3.0.0
>> [    0.297713] NetLabel: Initializing
>> [    0.297713] NetLabel:  domain hash size = 128
>> [    0.297713] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
>> [    0.297713] NetLabel:  unlabeled traffic allowed by default
>> [    0.297713] mctp: management component transport protocol core
>> [    0.297713] NET: Registered PF_MCTP protocol family
>> [    0.297713] PCI: Using ACPI for IRQ routing
>> [    0.306985] PCI: pci_cache_line_size set to 64 bytes
>> [    0.307038] e820: reserve RAM buffer [mem 0x0009f800-0x0009ffff]
>> [    0.307040] e820: reserve RAM buffer [mem 0xbfdf0000-0xbfffffff]
>> [    0.307042] e820: reserve RAM buffer [mem 0x43f000000-0x43fffffff]
>> [    0.307357] pci 0000:01:00.0: vgaarb: setting as boot VGA device
>> [    0.307357] pci 0000:01:00.0: vgaarb: bridge control possible
>> [    0.307357] pci 0000:01:00.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
>> [    0.307357] vgaarb: loaded
>> [    0.307357] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0
>> [    0.307358] hpet0: 4 comparators, 32-bit 14.318180 MHz counter
>> [    0.310643] clocksource: Switched to clocksource tsc-early
>> [    0.310661] VFS: Disk quotas dquot_6.6.0
>> [    0.310661] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
>> [    0.310661] pnp: PnP ACPI init
>> [    0.310661] system 00:00: [io  0x04d0-0x04d1] has been reserved
>> [    0.310661] system 00:00: [io  0x0220-0x0225] has been reserved
>> [    0.310661] system 00:00: [io  0x0290-0x0294] has been reserved
>> [    0.311960] system 00:01: [io  0x4100-0x411f] has been reserved
>> [    0.311967] system 00:01: [io  0x0228-0x022f] has been reserved
>> [    0.311970] system 00:01: [io  0x040b] has been reserved
>> [    0.311972] system 00:01: [io  0x04d6] has been reserved
>> [    0.311974] system 00:01: [io  0x0c00-0x0c01] has been reserved
>> [    0.311976] system 00:01: [io  0x0c14] has been reserved
>> [    0.311978] system 00:01: [io  0x0c50-0x0c52] has been reserved
>> [    0.311980] system 00:01: [io  0x0c6c-0x0c6d] has been reserved
>> [    0.311982] system 00:01: [io  0x0c6f] has been reserved
>> [    0.311984] system 00:01: [io  0x0cd0-0x0cd1] has been reserved
>> [    0.311986] system 00:01: [io  0x0cd2-0x0cd3] has been reserved
>> [    0.311987] system 00:01: [io  0x0cd4-0x0cdf] has been reserved
>> [    0.311989] system 00:01: [io  0x4000-0x40fe] has been reserved
>> [    0.311995] system 00:01: [io  0x4210-0x4217] has been reserved
>> [    0.311997] system 00:01: [io  0x0b00-0x0b0f] has been reserved
>> [    0.311999] system 00:01: [io  0x0b10-0x0b1f] has been reserved
>> [    0.312001] system 00:01: [io  0x0b20-0x0b3f] has been reserved
>> [    0.312003] system 00:01: [mem 0x00000000-0x00000fff window] could not be reserved
>> [    0.312006] system 00:01: [mem 0xfee00400-0xfee00fff window] has been reserved
>> [    0.313070] system 00:05: [mem 0xe0000000-0xefffffff] has been reserved
>> [    0.313313] pnp 00:06: disabling [mem 0x000ce600-0x000cffff] because it overlaps 0000:01:00.0 BAR 6 [mem 0x000c0000-0x000dffff]
>> [    0.313336] system 00:06: [mem 0x000f0000-0x000f7fff] could not be reserved
>> [    0.313339] system 00:06: [mem 0x000f8000-0x000fbfff] could not be reserved
>> [    0.313341] system 00:06: [mem 0x000fc000-0x000fffff] could not be reserved
>> [    0.313343] system 00:06: [mem 0xbfdf0000-0xbfdfffff] could not be reserved
>> [    0.313346] system 00:06: [mem 0xffff0000-0xffffffff] has been reserved
>> [    0.313348] system 00:06: [mem 0x00000000-0x0009ffff] could not be reserved
>> [    0.313350] system 00:06: [mem 0x00100000-0xbfdeffff] could not be reserved
>> [    0.313352] system 00:06: [mem 0xbfe00000-0xbfefffff] has been reserved
>> [    0.313354] system 00:06: [mem 0xbff00000-0xbfffffff] could not be reserved
>> [    0.313357] system 00:06: [mem 0xfec00000-0xfec00fff] could not be reserved
>> [    0.313359] system 00:06: [mem 0xfee00000-0xfee00fff] could not be reserved
>> [    0.313361] system 00:06: [mem 0xfff80000-0xfffeffff] has been reserved
>> [    0.313386] pnp: PnP ACPI: found 7 devices
>> [    0.320151] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
>> [    0.320423] NET: Registered PF_INET protocol family
>> [    0.320747] IP idents hash table entries: 262144 (order: 9, 2097152 bytes, linear)
>> [    0.337449] tcp_listen_portaddr_hash hash table entries: 8192 (order: 5, 131072 bytes, linear)
>> [    0.337493] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
>> [    0.337664] TCP established hash table entries: 131072 (order: 8, 1048576 bytes, linear)
>> [    0.338080] TCP bind hash table entries: 65536 (order: 9, 2097152 bytes, linear)
>> [    0.338397] TCP: Hash tables configured (established 131072 bind 65536)
>> [    0.338622] MPTCP token hash table entries: 16384 (order: 6, 393216 bytes, linear)
>> [    0.338775] UDP hash table entries: 8192 (order: 6, 262144 bytes, linear)
>> [    0.338839] UDP-Lite hash table entries: 8192 (order: 6, 262144 bytes, linear)
>> [    0.338937] NET: Registered PF_UNIX/PF_LOCAL protocol family
>> [    0.338952] NET: Registered PF_XDP protocol family
>> [    0.338967] pci 0000:00:02.0: PCI bridge to [bus 01]
>> [    0.338971] pci 0000:00:02.0:   bridge window [io  0xe000-0xefff]
>> [    0.338975] pci 0000:00:02.0:   bridge window [mem 0xfb000000-0xfcffffff]
>> [    0.338978] pci 0000:00:02.0:   bridge window [mem 0xc0000000-0xdfffffff 64bit pref]
>> [    0.338982] pci 0000:00:04.0: PCI bridge to [bus 02]
>> [    0.338984] pci 0000:00:04.0:   bridge window [io  0xd000-0xdfff]
>> [    0.338987] pci 0000:00:04.0:   bridge window [mem 0xfda00000-0xfdafffff]
>> [    0.338990] pci 0000:00:04.0:   bridge window [mem 0xfdf00000-0xfdffffff 64bit pref]
>> [    0.338994] pci 0000:00:06.0: PCI bridge to [bus 03]
>> [    0.338996] pci 0000:00:06.0:   bridge window [io  0xc000-0xcfff]
>> [    0.338999] pci 0000:00:06.0:   bridge window [mem 0xfde00000-0xfdefffff]
>> [    0.339001] pci 0000:00:06.0:   bridge window [mem 0xfdd00000-0xfddfffff 64bit pref]
>> [    0.339006] pci 0000:00:14.4: PCI bridge to [bus 04]
>> [    0.339008] pci 0000:00:14.4:   bridge window [io  0xb000-0xbfff]
>> [    0.339013] pci 0000:00:14.4:   bridge window [mem 0xfdc00000-0xfdcfffff]
>> [    0.339017] pci 0000:00:14.4:   bridge window [mem 0xfdb00000-0xfdbfffff pref]
>> [    0.339024] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
>> [    0.339027] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
>> [    0.339029] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000dffff window]
>> [    0.339031] pci_bus 0000:00: resource 7 [mem 0xc0000000-0xfebfffff window]
>> [    0.339033] pci_bus 0000:01: resource 0 [io  0xe000-0xefff]
>> [    0.339034] pci_bus 0000:01: resource 1 [mem 0xfb000000-0xfcffffff]
>> [    0.339036] pci_bus 0000:01: resource 2 [mem 0xc0000000-0xdfffffff 64bit pref]
>> [    0.339038] pci_bus 0000:02: resource 0 [io  0xd000-0xdfff]
>> [    0.339040] pci_bus 0000:02: resource 1 [mem 0xfda00000-0xfdafffff]
>> [    0.339042] pci_bus 0000:02: resource 2 [mem 0xfdf00000-0xfdffffff 64bit pref]
>> [    0.339044] pci_bus 0000:03: resource 0 [io  0xc000-0xcfff]
>> [    0.339045] pci_bus 0000:03: resource 1 [mem 0xfde00000-0xfdefffff]
>> [    0.339047] pci_bus 0000:03: resource 2 [mem 0xfdd00000-0xfddfffff 64bit pref]
>> [    0.339049] pci_bus 0000:04: resource 0 [io  0xb000-0xbfff]
>> [    0.339051] pci_bus 0000:04: resource 1 [mem 0xfdc00000-0xfdcfffff]
>> [    0.339053] pci_bus 0000:04: resource 2 [mem 0xfdb00000-0xfdbfffff pref]
>> [    0.339055] pci_bus 0000:04: resource 4 [io  0x0000-0x0cf7 window]
>> [    0.339056] pci_bus 0000:04: resource 5 [io  0x0d00-0xffff window]
>> [    0.339058] pci_bus 0000:04: resource 6 [mem 0x000a0000-0x000dffff window]
>> [    0.339060] pci_bus 0000:04: resource 7 [mem 0xc0000000-0xfebfffff window]
>> [    0.358813] pci 0000:00:12.0: quirk_usb_early_handoff+0x0/0x730 took 19226 usecs
>> [    0.375500] pci 0000:00:12.1: quirk_usb_early_handoff+0x0/0x730 took 16282 usecs
>> [    0.392195] pci 0000:00:13.0: quirk_usb_early_handoff+0x0/0x730 took 16103 usecs
>> [    0.408890] pci 0000:00:13.1: quirk_usb_early_handoff+0x0/0x730 took 16292 usecs
>> [    0.425585] pci 0000:00:14.5: quirk_usb_early_handoff+0x0/0x730 took 16090 usecs
>> [    0.425616] pci 0000:01:00.1: extending delay after power-on from D3hot to 20 msec
>> [    0.425651] pci 0000:01:00.1: D0 power state depends on 0000:01:00.0
>> [    0.425850] PCI: CLS 64 bytes, default 64
>> [    0.425871] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
>> [    0.425872] software IO TLB: mapped [mem 0x00000000bbdf0000-0x00000000bfdf0000] (64MB)
>> [    0.425913] LVT offset 0 assigned for vector 0x400
>> [    0.425959] Trying to unpack rootfs image as initramfs...
>> [    0.431037] perf: AMD IBS detected (0x000000ff)
>> [    0.432658] Initialise system trusted keyrings
>> [    0.432672] Key type blacklist registered
>> [    0.432730] workingset: timestamp_bits=41 max_order=22 bucket_order=0
>> [    0.432739] zbud: loaded
>> [    0.433154] fuse: init (API version 7.40)
>> [    0.433398] integrity: Platform Keyring initialized
>> [    0.433404] integrity: Machine keyring initialized
>> [    0.448217] Key type asymmetric registered
>> [    0.448219] Asymmetric key parser 'x509' registered
>> [    0.448295] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 246)
>> [    0.448363] io scheduler mq-deadline registered
>> [    0.448365] io scheduler kyber registered
>> [    0.448421] io scheduler bfq registered
>> [    0.449310] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
>> [    0.449428] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
>> [    0.449459] ACPI: button: Power Button [PWRB]
>> [    0.449508] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
>> [    0.451942] ACPI: button: Power Button [PWRF]
>> [    0.452005] ACPI: \_PR_.C000: Found 2 idle states
>> [    0.452097] ACPI: \_PR_.C001: Found 2 idle states
>> [    0.452173] ACPI: \_PR_.C002: Found 2 idle states
>> [    0.452251] ACPI: \_PR_.C003: Found 2 idle states
>> [    0.452328] ACPI: \_PR_.C004: Found 2 idle states
>> [    0.452412] ACPI: \_PR_.C005: Found 2 idle states
>> [    0.452481] ACPI: \_PR_.C006: Found 2 idle states
>> [    0.452548] ACPI: \_PR_.C007: Found 2 idle states
>> [    0.452838] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
>> [    0.453015] 00:03: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
>> [    0.456260] Non-volatile memory driver v1.3
>> [    0.456262] Linux agpgart interface v0.103
>> [    0.456370] ACPI: bus type drm_connector registered
>> [    0.457223] ahci 0000:00:11.0: version 3.0
>> [    0.457443] ahci 0000:00:11.0: AHCI vers 0001.0100, 32 command slots, 3 Gbps, SATA mode
>> [    0.457447] ahci 0000:00:11.0: 4/4 ports implemented (port mask 0xf)
>> [    0.457450] ahci 0000:00:11.0: flags: 64bit ncq sntf ilck pm led clo pmp pio slum part ccc 
>> [    0.458045] scsi host0: ahci
>> [    0.458260] scsi host1: ahci
>> [    0.458401] scsi host2: ahci
>> [    0.458525] scsi host3: ahci
>> [    0.458578] ata1: SATA max UDMA/133 abar m1024@0xfe02f000 port 0xfe02f100 irq 22 lpm-pol 3
>> [    0.458582] ata2: SATA max UDMA/133 abar m1024@0xfe02f000 port 0xfe02f180 irq 22 lpm-pol 3
>> [    0.458584] ata3: SATA max UDMA/133 abar m1024@0xfe02f000 port 0xfe02f200 irq 22 lpm-pol 3
>> [    0.458587] ata4: SATA max UDMA/133 abar m1024@0xfe02f000 port 0xfe02f280 irq 22 lpm-pol 3
>> [    0.458798] ohci-pci 0000:00:12.0: OHCI PCI host controller
>> [    0.458805] ohci-pci 0000:00:12.0: new USB bus registered, assigned bus number 1
>> [    0.458845] ohci-pci 0000:00:12.0: irq 16, io mem 0xfe02e000
>> [    0.517654] usb usb1: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 6.10
>> [    0.517662] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
>> [    0.517665] usb usb1: Product: OHCI PCI host controller
>> [    0.517667] usb usb1: Manufacturer: Linux 6.10.0-rc1-1.1-mainline ohci_hcd
>> [    0.517669] usb usb1: SerialNumber: 0000:00:12.0
>> [    0.517928] hub 1-0:1.0: USB hub found
>> [    0.517940] hub 1-0:1.0: 3 ports detected
>> [    0.518219] ehci-pci 0000:00:12.2: EHCI Host Controller
>> [    0.518226] ehci-pci 0000:00:12.2: new USB bus registered, assigned bus number 2
>> [    0.518231] ehci-pci 0000:00:12.2: applying AMD SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
>> [    0.518242] ehci-pci 0000:00:12.2: debug port 1
>> [    0.518296] ehci-pci 0000:00:12.2: irq 17, io mem 0xfe02c000
>> [    0.524334] Freeing initrd memory: 50776K
>> [    0.530326] ehci-pci 0000:00:12.2: USB 2.0 started, EHCI 1.00
>> [    0.530446] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.10
>> [    0.530450] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
>> [    0.530452] usb usb2: Product: EHCI Host Controller
>> [    0.530454] usb usb2: Manufacturer: Linux 6.10.0-rc1-1.1-mainline ehci_hcd
>> [    0.530456] usb usb2: SerialNumber: 0000:00:12.2
>> [    0.530609] hub 2-0:1.0: USB hub found
>> [    0.530617] hub 2-0:1.0: 6 ports detected
>> [    0.597196] hub 1-0:1.0: USB hub found
>> [    0.597209] hub 1-0:1.0: 3 ports detected
>> [    0.597341] ehci-pci 0000:00:13.2: EHCI Host Controller
>> [    0.597348] ehci-pci 0000:00:13.2: new USB bus registered, assigned bus number 3
>> [    0.597353] ehci-pci 0000:00:13.2: applying AMD SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
>> [    0.597364] ehci-pci 0000:00:13.2: debug port 1
>> [    0.597414] ehci-pci 0000:00:13.2: irq 19, io mem 0xfe029000
>> [    0.610458] ehci-pci 0000:00:13.2: USB 2.0 started, EHCI 1.00
>> [    0.610575] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.10
>> [    0.610578] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
>> [    0.610581] usb usb3: Product: EHCI Host Controller
>> [    0.610583] usb usb3: Manufacturer: Linux 6.10.0-rc1-1.1-mainline ehci_hcd
>> [    0.610584] usb usb3: SerialNumber: 0000:00:13.2
>> [    0.610700] hub 3-0:1.0: USB hub found
>> [    0.610708] hub 3-0:1.0: 6 ports detected
>> [    0.610891] ohci-pci 0000:00:12.1: OHCI PCI host controller
>> [    0.610897] ohci-pci 0000:00:12.1: new USB bus registered, assigned bus number 4
>> [    0.610926] ohci-pci 0000:00:12.1: irq 16, io mem 0xfe02d000
>> [    0.671296] usb usb4: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 6.10
>> [    0.671300] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
>> [    0.671302] usb usb4: Product: OHCI PCI host controller
>> [    0.671304] usb usb4: Manufacturer: Linux 6.10.0-rc1-1.1-mainline ohci_hcd
>> [    0.671305] usb usb4: SerialNumber: 0000:00:12.1
>> [    0.671543] hub 4-0:1.0: USB hub found
>> [    0.671554] hub 4-0:1.0: 3 ports detected
>> [    0.671854] ohci-pci 0000:00:13.0: OHCI PCI host controller
>> [    0.671859] ohci-pci 0000:00:13.0: new USB bus registered, assigned bus number 5
>> [    0.671895] ohci-pci 0000:00:13.0: irq 18, io mem 0xfe02b000
>> [    0.731397] usb usb5: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 6.10
>> [    0.731401] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
>> [    0.731403] usb usb5: Product: OHCI PCI host controller
>> [    0.731404] usb usb5: Manufacturer: Linux 6.10.0-rc1-1.1-mainline ohci_hcd
>> [    0.731406] usb usb5: SerialNumber: 0000:00:13.0
>> [    0.731651] hub 5-0:1.0: USB hub found
>> [    0.731670] hub 5-0:1.0: 3 ports detected
>> [    0.731930] ohci-pci 0000:00:13.1: OHCI PCI host controller
>> [    0.731936] ohci-pci 0000:00:13.1: new USB bus registered, assigned bus number 6
>> [    0.731955] ohci-pci 0000:00:13.1: irq 18, io mem 0xfe02a000
>> [    0.772520] ata4: SATA link down (SStatus 0 SControl 300)
>> [    0.773799] ata1: SATA link down (SStatus 0 SControl 300)
>> [    0.783810] usb 2-1: new high-speed USB device number 2 using ehci-pci
>> [    0.791492] usb usb6: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 6.10
>> [    0.791497] usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
>> [    0.791499] usb usb6: Product: OHCI PCI host controller
>> [    0.791501] usb usb6: Manufacturer: Linux 6.10.0-rc1-1.1-mainline ohci_hcd
>> [    0.791503] usb usb6: SerialNumber: 0000:00:13.1
>> [    0.791683] hub 6-0:1.0: USB hub found
>> [    0.791697] hub 6-0:1.0: 3 ports detected
>> [    0.791966] ohci-pci 0000:00:14.5: OHCI PCI host controller
>> [    0.791972] ohci-pci 0000:00:14.5: new USB bus registered, assigned bus number 7
>> [    0.791991] ohci-pci 0000:00:14.5: irq 18, io mem 0xfe028000
>> [    0.851602] usb usb7: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 6.10
>> [    0.851606] usb usb7: New USB device strings: Mfr=3, Product=2, SerialNumber=1
>> [    0.851608] usb usb7: Product: OHCI PCI host controller
>> [    0.851610] usb usb7: Manufacturer: Linux 6.10.0-rc1-1.1-mainline ohci_hcd
>> [    0.851611] usb usb7: SerialNumber: 0000:00:14.5
>> [    0.851843] hub 7-0:1.0: USB hub found
>> [    0.851854] hub 7-0:1.0: 2 ports detected
>> [    0.852034] usbcore: registered new interface driver usbserial_generic
>> [    0.852041] usbserial: USB Serial support registered for generic
>> [    0.852130] rtc_cmos 00:02: RTC can wake from S4
>> [    0.852362] rtc_cmos 00:02: registered as rtc0
>> [    0.852387] rtc_cmos 00:02: setting system clock to 2024-05-28T14:55:25 UTC (1716908125)
>> [    0.852420] rtc_cmos 00:02: alarms up to one month, 242 bytes nvram, hpet irqs
>> [    0.852467] amd_pstate: the _CPC object is not present in SBIOS or ACPI disabled
>> [    0.852678] ledtrig-cpu: registered to indicate activity on CPUs
>> [    0.853181] [drm] Initialized simpledrm 1.0.0 20200625 for simple-framebuffer.0 on minor 0
>> [    0.858086] Console: switching to colour frame buffer device 160x64
>> [    0.861204] simple-framebuffer simple-framebuffer.0: [drm] fb0: simpledrmdrmfb frame buffer device
>> [    0.861268] hid: raw HID events driver (C) Jiri Kosina
>> [    0.861357] drop_monitor: Initializing network drop monitor service
>> [    0.861679] NET: Registered PF_INET6 protocol family
>> [    0.869644] Segment Routing with IPv6
>> [    0.869647] RPL Segment Routing with IPv6
>> [    0.869665] In-situ OAM (IOAM) with IPv6
>> [    0.869704] NET: Registered PF_PACKET protocol family
>> [    0.869756] x86/pm: family 0x15 cpu detected, MSR saving is needed during suspending.
>> [    0.870256] microcode: Current revision: 0x06000852
>> [    0.870258] microcode: Updated early from: 0x06000822
>> [    0.870396] IPI shorthand broadcast: enabled
>> [    0.873069] sched_clock: Marking stable (874176692, -2503248)->(1778689574, -907016130)
>> [    0.873227] Timer migration: 1 hierarchy levels; 8 children per group; 1 crossnode level
>> [    0.873326] registered taskstats version 1
>> [    0.873659] Loading compiled-in X.509 certificates
>> [    0.878261] Loaded X.509 cert 'Build time autogenerated kernel key: 06d3346cea79f18ad765f94d96c9d8cc480c5b54'
>> [    0.880699] Demotion targets for Node 0: null
>> [    0.880949] Key type .fscrypt registered
>> [    0.880951] Key type fscrypt-provisioning registered
>> [    0.881482] PM:   Magic number: 8:474:941
>> [    0.885072] RAS: Correctable Errors collector initialized.
>> [    0.899067] clk: Disabling unused clocks
>> [    0.899071] PM: genpd: Disabling unused power domains
>> [    0.935183] usb 2-1: New USB device found, idVendor=0bda, idProduct=b812, bcdDevice= 2.10
>> [    0.935188] usb 2-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
>> [    0.935191] usb 2-1: Product: USB3.0 802.11ac 1200M Adapter
>> [    0.935193] usb 2-1: Manufacturer: Realtek
>> [    0.935194] usb 2-1: SerialNumber: 123456
>> [    0.938653] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
>> [    0.938815] ata2.00: ATA-11: Apacer AS340 120GB, AP612PE0, max UDMA/133
>> [    0.938845] ata2.00: 234441648 sectors, multi 16: LBA48 NCQ (depth 32), AA
>> [    0.939449] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
>> [    0.939469] ata2.00: configured for UDMA/133
>> [    0.940170] ata3.00: ATA-8: TOSHIBA HDWD110, MS2OA8J0, max UDMA/133
>> [    0.940398] ata3.00: 1953525168 sectors, multi 16: LBA48 NCQ (depth 32), AA
>> [    0.941260] ata3.00: configured for UDMA/133
>> [    0.952301] scsi 1:0:0:0: Direct-Access     ATA      Apacer AS340 120 2PE0 PQ: 0 ANSI: 5
>> [    0.952706] sd 1:0:0:0: [sda] 234441648 512-byte logical blocks: (120 GB/112 GiB)
>> [    0.952718] sd 1:0:0:0: [sda] Write Protect is off
>> [    0.952720] sd 1:0:0:0: [sda] Mode Sense: 00 3a 00 00
>> [    0.952738] scsi 2:0:0:0: Direct-Access     ATA      TOSHIBA HDWD110  A8J0 PQ: 0 ANSI: 5
>> [    0.952745] sd 1:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
>> [    0.952783] sd 1:0:0:0: [sda] Preferred minimum I/O size 512 bytes
>> [    0.953078] sd 2:0:0:0: [sdb] 1953525168 512-byte logical blocks: (1.00 TB/932 GiB)
>> [    0.953081] sd 2:0:0:0: [sdb] 4096-byte physical blocks
>> [    0.953094] sd 2:0:0:0: [sdb] Write Protect is off
>> [    0.953097] sd 2:0:0:0: [sdb] Mode Sense: 00 3a 00 00
>> [    0.953119] sd 2:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
>> [    0.953155] sd 2:0:0:0: [sdb] Preferred minimum I/O size 4096 bytes
>> [    0.953410]  sda: sda1 sda2
>> [    0.953543] sd 1:0:0:0: [sda] Attached SCSI disk
>> [    0.974223]  sdb: sdb1 sdb2
>> [    0.974515] sd 2:0:0:0: [sdb] Attached SCSI disk
>> [    0.976712] Freeing unused decrypted memory: 2028K
>> [    0.977421] Freeing unused kernel image (initmem) memory: 3428K
>> [    0.977449] Write protecting the kernel read-only data: 32768k
>> [    0.977898] Freeing unused kernel image (rodata/data gap) memory: 936K
>> [    1.021479] x86/mm: Checked W+X mappings: passed, no W+X pages found.
>> [    1.021484] rodata_test: all tests were successful
>> [    1.021489] Run /init as init process
>> [    1.021490]   with arguments:
>> [    1.021492]     /init
>> [    1.021493]   with environment:
>> [    1.021494]     HOME=/
>> [    1.021495]     TERM=linux
>> [    1.021496]     BOOT_IMAGE=/vmlinuz-linux-mainline
>> [    1.195986] scsi host4: pata_atiixp
>> [    1.196167] scsi host5: pata_atiixp
>> [    1.196211] ata5: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0xfa00 irq 14 lpm-pol 0
>> [    1.196214] ata6: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xfa08 irq 15 lpm-pol 0
>> [    1.196565] xhci_hcd 0000:02:00.0: xHCI Host Controller
>> [    1.196572] xhci_hcd 0000:02:00.0: new USB bus registered, assigned bus number 8
>> [    1.196654] xhci_hcd 0000:02:00.0: hcc params 0x002841eb hci version 0x100 quirks 0x0000000000000890
>> [    1.196822] xhci_hcd 0000:02:00.0: xHCI Host Controller
>> [    1.196827] xhci_hcd 0000:02:00.0: new USB bus registered, assigned bus number 9
>> [    1.196830] xhci_hcd 0000:02:00.0: Host supports USB 3.0 SuperSpeed
>> [    1.196885] usb usb8: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.10
>> [    1.196888] usb usb8: New USB device strings: Mfr=3, Product=2, SerialNumber=1
>> [    1.196891] usb usb8: Product: xHCI Host Controller
>> [    1.196893] usb usb8: Manufacturer: Linux 6.10.0-rc1-1.1-mainline xhci-hcd
>> [    1.196895] usb usb8: SerialNumber: 0000:02:00.0
>> [    1.197034] hub 8-0:1.0: USB hub found
>> [    1.197044] hub 8-0:1.0: 1 port detected
>> [    1.197210] usb usb9: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 6.10
>> [    1.197213] usb usb9: New USB device strings: Mfr=3, Product=2, SerialNumber=1
>> [    1.197215] usb usb9: Product: xHCI Host Controller
>> [    1.197217] usb usb9: Manufacturer: Linux 6.10.0-rc1-1.1-mainline xhci-hcd
>> [    1.197218] usb usb9: SerialNumber: 0000:02:00.0
>> [    1.197369] hub 9-0:1.0: USB hub found
>> [    1.197379] hub 9-0:1.0: 4 ports detected
>> [    1.267596] usb 1-3: new low-speed USB device number 2 using ohci-pci
>> [    1.440864] usb 8-1: new high-speed USB device number 2 using xhci_hcd
>> [    1.450887] usb 1-3: New USB device found, idVendor=0c45, idProduct=7603, bcdDevice= 1.06
>> [    1.450899] usb 1-3: New USB device strings: Mfr=0, Product=2, SerialNumber=0
>> [    1.450905] usb 1-3: Product: USB Keyboard
>> [    1.454180] tsc: Refined TSC clocksource calibration: 3322.064 MHz
>> [    1.454188] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x2fe2b718c89, max_idle_ns: 440795253369 ns
>> [    1.454219] clocksource: Switched to clocksource tsc
>> [    1.474236] usbcore: registered new interface driver usbhid
>> [    1.474239] usbhid: USB HID core driver
>> [    1.480046] input: USB Keyboard as /devices/pci0000:00/0000:00:12.0/usb1/1-3/1-3:1.0/0003:0C45:7603.0001/input/input2
>> [    1.534698] hid-generic 0003:0C45:7603.0001: input,hidraw0: USB HID v1.11 Keyboard [USB Keyboard] on usb-0000:00:12.0-3/input0
>> [    1.535151] input: USB Keyboard Consumer Control as /devices/pci0000:00/0000:00:12.0/usb1/1-3/1-3:1.1/0003:0C45:7603.0002/input/input3
>> [    1.585891] usb 8-1: New USB device found, idVendor=2109, idProduct=3431, bcdDevice= 4.20
>> [    1.585895] usb 8-1: New USB device strings: Mfr=0, Product=1, SerialNumber=0
>> [    1.585897] usb 8-1: Product: USB2.0 Hub
>> [    1.586600] hub 8-1:1.0: USB hub found
>> [    1.586788] hub 8-1:1.0: 4 ports detected
>> [    1.590941] input: USB Keyboard System Control as /devices/pci0000:00/0000:00:12.0/usb1/1-3/1-3:1.1/0003:0C45:7603.0002/input/input4
>> [    1.591019] input: USB Keyboard as /devices/pci0000:00/0000:00:12.0/usb1/1-3/1-3:1.1/0003:0C45:7603.0002/input/input6
>> [    1.591157] hid-generic 0003:0C45:7603.0002: input,hiddev96,hidraw1: USB HID v1.11 Keyboard [USB Keyboard] on usb-0000:00:12.0-3/input1
>> [    2.087607] usb 4-1: new full-speed USB device number 2 using ohci-pci
>> [    2.124296] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
>> [    2.125160] ata2.00: configured for UDMA/133
>> [    2.282382] usb 4-1: New USB device found, idVendor=04d9, idProduct=a088, bcdDevice= 1.00
>> [    2.282394] usb 4-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
>> [    2.282400] usb 4-1: Product: USB Gaming Mouse
>> [    2.282405] usb 4-1: Manufacturer: RH
>> [    2.289786] input: RH USB Gaming Mouse as /devices/pci0000:00/0000:00:12.1/usb4/4-1/4-1:1.0/0003:04D9:A088.0003/input/input7
>> [    2.344706] hid-generic 0003:04D9:A088.0003: input,hidraw2: USB HID v1.10 Keyboard [RH USB Gaming Mouse] on usb-0000:00:12.1-1/input0
>> [    2.352036] input: RH USB Gaming Mouse as /devices/pci0000:00/0000:00:12.1/usb4/4-1/4-1:1.1/0003:04D9:A088.0004/input/input8
>> [    2.352104] input: RH USB Gaming Mouse System Control as /devices/pci0000:00/0000:00:12.1/usb4/4-1/4-1:1.1/0003:04D9:A088.0004/input/input9
>> [    2.407872] input: RH USB Gaming Mouse Consumer Control as /devices/pci0000:00/0000:00:12.1/usb4/4-1/4-1:1.1/0003:04D9:A088.0004/input/input10
>> [    2.407983] hid-generic 0003:04D9:A088.0004: input,hiddev97,hidraw3: USB HID v1.10 Mouse [RH USB Gaming Mouse] on usb-0000:00:12.1-1/input1
>> [    2.411756] hid-generic 0003:04D9:A088.0005: hiddev98,hidraw4: USB HID v1.10 Device [RH USB Gaming Mouse] on usb-0000:00:12.1-1/input2
>> [    2.950945] ata2.00: exception Emask 0x10 SAct 0x2 SErr 0x40d0002 action 0xe frozen
>> [    2.950958] ata2.00: irq_stat 0x00000040, connection status changed
>> [    2.950962] ata2: SError: { RecovComm PHYRdyChg CommWake 10B8B DevExch }
>> [    2.950970] ata2.00: failed command: READ FPDMA QUEUED
>> [    2.950974] ata2.00: cmd 60/08:08:80:ff:f1/00:00:0d:00:00/40 tag 1 ncq dma 4096 in
>>                         res 40/00:a0:00:00:00/00:00:00:00:00/40 Emask 0x10 (ATA bus error)
>> [    2.950989] ata2.00: status: { DRDY }
>> [    2.951000] ata2: hard resetting link
>> [    3.847612] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
>> [    3.848393] ata2.00: configured for UDMA/133
>> [    3.858578] sd 1:0:0:0: [sda] tag#1 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
>> [    3.858590] sd 1:0:0:0: [sda] tag#1 Sense Key : Illegal Request [current] 
>> [    3.858596] sd 1:0:0:0: [sda] tag#1 Add. Sense: Unaligned write command
>> [    3.858602] sd 1:0:0:0: [sda] tag#1 CDB: Read(10) 28 00 0d f1 ff 80 00 00 08 00
>> [    3.858606] I/O error, dev sda, sector 233963392 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
>> [    3.858640] ata2: EH complete
>> [    4.024750] EXT4-fs (sda2): mounted filesystem 963daeed-0888-4658-9f17-18bd343dfb2a r/w with ordered data mode. Quota mode: none.
>> [    4.189513] systemd[1]: systemd 255.7-1-arch running in system mode (+PAM +AUDIT -SELINUX -APPARMOR -IMA +SMACK +SECCOMP +GCRYPT +GNUTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD +LIBCRYPTSETUP +LIBFDISK +PCRE2 +PWQUALITY +P11KIT +QRENCODE +TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD +BPF_FRAMEWORK +XKBCOMMON +UTMP -SYSVINIT default-hierarchy=unified)
>> [    4.189520] systemd[1]: Detected architecture x86-64.
>> [    4.377855] systemd[1]: bpf-lsm: LSM BPF program attached
>> [    4.445714] systemd-fstab-generator[268]: Mount point  is not a valid path, ignoring.
>> [    4.446994] systemd-fstab-generator[268]: Mount point  is not a valid path, ignoring.
>> [    5.074228] random: crng init done
>> [    5.137593] ata2.00: exception Emask 0x10 SAct 0x6000 SErr 0x40d0002 action 0xe frozen
>> [    5.137605] ata2.00: irq_stat 0x00000040, connection status changed
>> [    5.137610] ata2: SError: { RecovComm PHYRdyChg CommWake 10B8B DevExch }
>> [    5.137619] ata2.00: failed command: READ FPDMA QUEUED
>> [    5.137623] ata2.00: cmd 60/40:68:28:3d:9c/00:00:01:00:00/40 tag 13 ncq dma 32768 in
>>                         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 (ATA bus error)
>> [    5.137638] ata2.00: status: { DRDY }
>> [    5.137643] ata2.00: failed command: READ FPDMA QUEUED
>> [    5.137646] ata2.00: cmd 60/08:70:30:04:ad/00:00:01:00:00/40 tag 14 ncq dma 4096 in
>>                         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 (ATA bus error)
>> [    5.137660] ata2.00: status: { DRDY }
>> [    5.137669] ata2: hard resetting link
>> [    6.034334] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
>> [    6.035116] ata2.00: configured for UDMA/133
>> [    6.045220] sd 1:0:0:0: [sda] tag#13 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
>> [    6.045224] sd 1:0:0:0: [sda] tag#13 Sense Key : Illegal Request [current] 
>> [    6.045227] sd 1:0:0:0: [sda] tag#13 Add. Sense: Unaligned write command
>> [    6.045229] sd 1:0:0:0: [sda] tag#13 CDB: Read(10) 28 00 01 9c 3d 28 00 00 40 00
>> [    6.045231] I/O error, dev sda, sector 27016488 op 0x0:(READ) flags 0x80700 phys_seg 2 prio class 0
>> [    6.045240] sd 1:0:0:0: [sda] tag#14 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
>> [    6.045242] sd 1:0:0:0: [sda] tag#14 Sense Key : Illegal Request [current] 
>> [    6.045243] sd 1:0:0:0: [sda] tag#14 Add. Sense: Unaligned write command
>> [    6.045245] sd 1:0:0:0: [sda] tag#14 CDB: Read(10) 28 00 01 ad 04 30 00 00 08 00
>> [    6.045246] I/O error, dev sda, sector 28116016 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
>> [    6.045260] ata2: EH complete
>> [    6.061330] zram: Added device: zram0
>> [    6.213738] systemd[1]: Queued start job for default target Graphical Interface.
>> [    6.268916] systemd[1]: Created slice Slice /system/dirmngr.
>> [    6.269281] systemd[1]: Created slice Slice /system/getty.
>> [    6.269601] systemd[1]: Created slice Slice /system/gpg-agent.
>> [    6.269932] systemd[1]: Created slice Slice /system/gpg-agent-browser.
>> [    6.270255] systemd[1]: Created slice Slice /system/gpg-agent-extra.
>> [    6.270601] systemd[1]: Created slice Slice /system/gpg-agent-ssh.
>> [    6.270969] systemd[1]: Created slice Slice /system/keyboxd.
>> [    6.271364] systemd[1]: Created slice Slice /system/modprobe.
>> [    6.271741] systemd[1]: Created slice Slice /system/systemd-fsck.
>> [    6.272139] systemd[1]: Created slice Slice /system/systemd-zram-setup.
>> [    6.272407] systemd[1]: Created slice User and Session Slice.
>> [    6.272473] systemd[1]: Started Dispatch Password Requests to Console Directory Watch.
>> [    6.272519] systemd[1]: Started Forward Password Requests to Wall Directory Watch.
>> [    6.272671] systemd[1]: Set up automount Arbitrary Executable File Formats File System Automount Point.
>> [    6.272689] systemd[1]: Expecting device /dev/disk/by-uuid/03ce297b-4be8-4886-953d-2d2cc4bd0862...
>> [    6.272696] systemd[1]: Expecting device /dev/disk/by-uuid/6BB1-1CFA...
>> [    6.272702] systemd[1]: Expecting device /dev/zram0...
>> [    6.272712] systemd[1]: Reached target Local Encrypted Volumes.
>> [    6.272732] systemd[1]: Reached target Local Integrity Protected Volumes.
>> [    6.272760] systemd[1]: Reached target Path Units.
>> [    6.272774] systemd[1]: Reached target Remote File Systems.
>> [    6.272786] systemd[1]: Reached target Slice Units.
>> [    6.272813] systemd[1]: Reached target Local Verity Protected Volumes.
>> [    6.272878] systemd[1]: Listening on Device-mapper event daemon FIFOs.
>> [    6.274451] systemd[1]: Listening on LVM2 poll daemon socket.
>> [    6.276124] systemd[1]: Listening on Process Core Dump Socket.
>> [    6.276243] systemd[1]: Listening on Journal Socket (/dev/log).
>> [    6.276352] systemd[1]: Listening on Journal Socket.
>> [    6.276491] systemd[1]: Listening on Network Service Netlink Socket.
>> [    6.276508] systemd[1]: TPM2 PCR Extension (Varlink) was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
>> [    6.276753] systemd[1]: Listening on udev Control Socket.
>> [    6.276841] systemd[1]: Listening on udev Kernel Socket.
>> [    6.278013] systemd[1]: Mounting Huge Pages File System...
>> [    6.278798] systemd[1]: Mounting POSIX Message Queue File System...
>> [    6.279574] systemd[1]: Mounting Kernel Debug File System...
>> [    6.280259] systemd[1]: Mounting Kernel Trace File System...
>> [    6.281428] systemd[1]: Starting Create List of Static Device Nodes...
>> [    6.282416] systemd[1]: Starting Monitoring of LVM2 mirrors, snapshots etc. using dmeventd or progress polling...
>> [    6.283594] systemd[1]: Starting Load Kernel Module configfs...
>> [    6.285440] systemd[1]: Starting Load Kernel Module dm_mod...
>> [    6.288313] systemd[1]: Starting Load Kernel Module drm...
>> [    6.289657] systemd[1]: Starting Load Kernel Module fuse...
>> [    6.290654] systemd[1]: Starting Load Kernel Module loop...
>> [    6.290721] systemd[1]: File System Check on Root Device was skipped because of an unmet condition check (ConditionPathIsReadWrite=!/).
>> [    6.293064] systemd[1]: Starting Journal Service...
>> [    6.296123] systemd[1]: Starting Load Kernel Modules...
>> [    6.297125] systemd[1]: Starting Generate network units from Kernel command line...
>> [    6.297157] systemd[1]: TPM2 PCR Machine ID Measurement was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
>> [    6.298301] systemd[1]: Starting Remount Root and Kernel File Systems...
>> [    6.298401] systemd[1]: TPM2 SRK Setup (Early) was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
>> [    6.300167] systemd[1]: Starting Coldplug All udev Devices...
>> [    6.302399] systemd[1]: Mounted Huge Pages File System.
>> [    6.302541] systemd[1]: Mounted POSIX Message Queue File System.
>> [    6.302700] systemd[1]: Mounted Kernel Debug File System.
>> [    6.302823] systemd[1]: Mounted Kernel Trace File System.
>> [    6.303130] systemd[1]: Finished Create List of Static Device Nodes.
>> [    6.303558] systemd[1]: modprobe@configfs.service: Deactivated successfully.
>> [    6.303804] systemd[1]: Finished Load Kernel Module configfs.
>> [    6.304234] systemd[1]: modprobe@drm.service: Deactivated successfully.
>> [    6.305011] systemd[1]: Finished Load Kernel Module drm.
>> [    6.305409] systemd[1]: modprobe@fuse.service: Deactivated successfully.
>> [    6.305623] systemd[1]: Finished Load Kernel Module fuse.
>> [    6.306920] systemd[1]: Mounting FUSE Control File System...
>> [    6.310967] systemd[1]: Mounting Kernel Configuration File System...
>> [    6.314384] systemd[1]: Starting Create Static Device Nodes in /dev gracefully...
>> [    6.314746] systemd[1]: Finished Generate network units from Kernel command line.
>> [    6.315728] loop: module loaded
>> [    6.315812] device-mapper: uevent: version 1.0.3
>> [    6.315927] device-mapper: ioctl: 4.48.0-ioctl (2023-03-01) initialised: dm-devel@lists.linux.dev
>> [    6.316131] systemd[1]: Mounted FUSE Control File System.
>> [    6.316526] systemd[1]: modprobe@loop.service: Deactivated successfully.
>> [    6.316727] systemd[1]: Finished Load Kernel Module loop.
>> [    6.317211] systemd[1]: modprobe@dm_mod.service: Deactivated successfully.
>> [    6.317462] systemd[1]: Finished Load Kernel Module dm_mod.
>> [    6.318137] systemd[1]: Mounted Kernel Configuration File System.
>> [    6.321272] systemd[1]: Repartition Root Disk was skipped because no trigger condition checks were met.
>> [    6.327810] systemd-journald[293]: Collecting audit messages is disabled.
>> [    6.330711] sd 1:0:0:0: Attached scsi generic sg0 type 0
>> [    6.330756] sd 2:0:0:0: Attached scsi generic sg1 type 0
>> [    6.337713] EXT4-fs (sda2): re-mounted 963daeed-0888-4658-9f17-18bd343dfb2a r/w. Quota mode: none.
>> [    6.338469] Asymmetric key parser 'pkcs8' registered
>> [    6.338877] systemd[1]: Finished Remount Root and Kernel File Systems.
>> [    6.339806] systemd[1]: Rebuild Hardware Database was skipped because no trigger condition checks were met.
>> [    6.340815] systemd[1]: Starting Load/Save OS Random Seed...
>> [    6.340851] systemd[1]: TPM2 SRK Setup was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
>> [    6.341146] systemd[1]: Finished Load Kernel Modules.
>> [    6.342097] systemd[1]: Starting Apply Kernel Variables...
>> [    6.359689] systemd[1]: Finished Apply Kernel Variables.
>> [    6.360781] systemd[1]: Finished Load/Save OS Random Seed.
>> [    6.365885] systemd[1]: Finished Create Static Device Nodes in /dev gracefully.
>> [    6.366977] systemd[1]: Starting Create System Users...
>> [    6.373038] systemd[1]: Finished Monitoring of LVM2 mirrors, snapshots etc. using dmeventd or progress polling.
>> [    6.394752] systemd[1]: Finished Create System Users.
>> [    6.395804] systemd[1]: Starting Create Static Device Nodes in /dev...
>> [    6.403417] systemd[1]: Started Journal Service.
>> [    6.426247] systemd-journald[293]: Received client request to flush runtime journal.
>> [    6.436701] systemd-journald[293]: /var/log/journal/ca3d73a04dc345538c9904a96756e41e/system.journal: Journal file uses a different sequence number ID, rotating.
>> [    6.436708] systemd-journald[293]: Rotating system journal.
>> [    6.561450] zram0: detected capacity change from 0 to 8388608
>> [    6.617585] mousedev: PS/2 mouse device common for all mice
>> [    6.624669] parport_pc 00:04: reported by Plug and Play ACPI
>> [    6.624743] parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE]
>> [    6.642312] ACPI Warning: SystemIO range 0x0000000000000B00-0x0000000000000B08 conflicts with OpRegion 0x0000000000000B00-0x0000000000000B0F (\SOR1) (20240322/utaddress-204)
>> [    6.642324] ACPI: OSL: Resource conflict; ACPI support missing from driver?
>> [    6.642621] acpi_cpufreq: overriding BIOS provided _PSD data
>> [    6.646974] input: PC Speaker as /devices/platform/pcspkr/input/input12
>> [    6.647702] cryptd: max_cpu_qlen set to 1000
>> [    6.662746] sp5100_tco: SP5100/SB800 TCO WatchDog Timer Driver
>> [    6.663343] sp5100-tco sp5100-tco: Failed to reserve MMIO or alternate MMIO region
>> [    6.663347] sp5100-tco sp5100-tco: probe with driver sp5100-tco failed with error -16
>> [    6.680483] r8169 0000:03:00.0: can't disable ASPM; OS doesn't have ASPM control
>> [    6.687332] AVX version of gcm_enc/dec engaged.
>> [    6.687380] AES CTR mode by8 optimization enabled
>> [    6.702811] r8169 0000:03:00.0 eth0: RTL8168g/8111g, e0:d5:5e:3b:15:1f, XID 4c0, IRQ 28
>> [    6.702821] r8169 0000:03:00.0 eth0: jumbo features [frames: 9194 bytes, tx checksumming: ko]
>> [    6.708344] r8169 0000:03:00.0 enp3s0: renamed from eth0
>> [    6.729580] ppdev: user-space parallel port driver
>> [    6.758079] Adding 4194300k swap on /dev/zram0.  Priority:100 extents:1 across:4194300k SSDsc
>> [    6.761064] snd_hda_intel 0000:01:00.1: Disabling MSI
>> [    6.761077] snd_hda_intel 0000:01:00.1: Handle vga_switcheroo audio client
>> [    6.794382] input: HDA NVidia HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:02.0/0000:01:00.1/sound/card1/input13
>> [    6.794484] input: HDA NVidia HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:02.0/0000:01:00.1/sound/card1/input14
>> [    6.794566] input: HDA NVidia HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:02.0/0000:01:00.1/sound/card1/input15
>> [    6.794649] input: HDA NVidia HDMI/DP,pcm=9 as /devices/pci0000:00/0000:00:02.0/0000:01:00.1/sound/card1/input16
>> [    6.806832] snd_hda_codec_realtek hdaudioC0D0: autoconfig for ALC892: line_outs=1 (0x14/0x0/0x0/0x0/0x0) type:line
>> [    6.806839] snd_hda_codec_realtek hdaudioC0D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
>> [    6.806842] snd_hda_codec_realtek hdaudioC0D0:    hp_outs=1 (0x1b/0x0/0x0/0x0/0x0)
>> [    6.806845] snd_hda_codec_realtek hdaudioC0D0:    mono: mono_out=0x0
>> [    6.806847] snd_hda_codec_realtek hdaudioC0D0:    dig-out=0x11/0x0
>> [    6.806849] snd_hda_codec_realtek hdaudioC0D0:    inputs:
>> [    6.806851] snd_hda_codec_realtek hdaudioC0D0:      Front Mic=0x19
>> [    6.806853] snd_hda_codec_realtek hdaudioC0D0:      Rear Mic=0x18
>> [    6.806855] snd_hda_codec_realtek hdaudioC0D0:      Line=0x1a
>> [    6.879588] input: HDA ATI SB Front Mic as /devices/pci0000:00/0000:00:14.2/sound/card0/input17
>> [    6.879697] input: HDA ATI SB Rear Mic as /devices/pci0000:00/0000:00:14.2/sound/card0/input18
>> [    6.879804] input: HDA ATI SB Line as /devices/pci0000:00/0000:00:14.2/sound/card0/input19
>> [    6.879915] input: HDA ATI SB Line Out as /devices/pci0000:00/0000:00:14.2/sound/card0/input20
>> [    6.879980] input: HDA ATI SB Front Headphone as /devices/pci0000:00/0000:00:14.2/sound/card0/input21
>> [    6.924297] kvm_amd: TSC scaling supported
>> [    6.924301] kvm_amd: Nested Virtualization enabled
>> [    6.924303] kvm_amd: Nested Paging enabled
>> [    6.924310] kvm_amd: LBR virtualization supported
>> [    7.482049] EXT4-fs (sdb1): mounted filesystem 03ce297b-4be8-4886-953d-2d2cc4bd0862 r/w with ordered data mode. Quota mode: none.
>> [    7.574255] ata2: limiting SATA link speed to 1.5 Gbps
>> [    7.574266] ata2.00: exception Emask 0x10 SAct 0x2000000 SErr 0x40d0002 action 0xe frozen
>> [    7.574273] ata2.00: irq_stat 0x00000040, connection status changed
>> [    7.574277] ata2: SError: { RecovComm PHYRdyChg CommWake 10B8B DevExch }
>> [    7.574288] ata2.00: failed command: READ FPDMA QUEUED
>> [    7.574292] ata2.00: cmd 60/08:c8:78:9f:ae/00:00:02:00:00/40 tag 25 ncq dma 4096 in
>>                         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 (ATA bus error)
>> [    7.574307] ata2.00: status: { DRDY }
>> [    7.574315] ata2: hard resetting link
>> [    8.471010] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
>> [    8.472037] ata2.00: configured for UDMA/133
>> [    8.482188] sd 1:0:0:0: [sda] tag#25 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
>> [    8.482199] sd 1:0:0:0: [sda] tag#25 Sense Key : Illegal Request [current] 
>> [    8.482205] sd 1:0:0:0: [sda] tag#25 Add. Sense: Unaligned write command
>> [    8.482211] sd 1:0:0:0: [sda] tag#25 CDB: Read(10) 28 00 02 ae 9f 78 00 00 08 00
>> [    8.482215] I/O error, dev sda, sector 44998520 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
>> [    8.482247] ata2: EH complete
>> [    9.485245] NET: Registered PF_ALG protocol family
>> [    9.584213] Generic FE-GE Realtek PHY r8169-0-300:00: attached PHY driver (mii_bus:phy_addr=r8169-0-300:00, irq=MAC)
>> [    9.774328] r8169 0000:03:00.0 enp3s0: Link is Down
>> [   13.954278] ata2.00: exception Emask 0x10 SAct 0x1 SErr 0x40d0002 action 0xe frozen
>> [   13.954291] ata2.00: irq_stat 0x00000040, connection status changed
>> [   13.954296] ata2: SError: { RecovComm PHYRdyChg CommWake 10B8B DevExch }
>> [   13.954304] ata2.00: failed command: WRITE FPDMA QUEUED
>> [   13.954307] ata2.00: cmd 61/10:00:e8:03:40/00:00:02:00:00/40 tag 0 ncq dma 8192 out
>>                         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 (ATA bus error)
>> [   13.954322] ata2.00: status: { DRDY }
>> [   13.954333] ata2: hard resetting link
>> [   14.850920] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
>> [   14.851963] ata2.00: configured for UDMA/133
>> [   14.862106] ata2: EH complete
>> [   15.427587] ata2.00: exception Emask 0x10 SAct 0x20000 SErr 0x40d0002 action 0xe frozen
>> [   15.427600] ata2.00: irq_stat 0x00000040, connection status changed
>> [   15.427604] ata2: SError: { RecovComm PHYRdyChg CommWake 10B8B DevExch }
>> [   15.427614] ata2.00: failed command: WRITE FPDMA QUEUED
>> [   15.427618] ata2.00: cmd 61/38:88:d8:63:d1/00:00:06:00:00/40 tag 17 ncq dma 28672 out
>>                         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 (ATA bus error)
>> [   15.427633] ata2.00: status: { DRDY }
>> [   15.427643] ata2: hard resetting link
>> [   16.324266] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
>> [   16.325269] ata2.00: configured for UDMA/133
>> [   16.335415] ata2: EH complete
>> [   16.717613] ata2.00: exception Emask 0x10 SAct 0x7800000f SErr 0x40d0002 action 0xe frozen
>> [   16.717625] ata2.00: irq_stat 0x00000040, connection status changed
>> [   16.717630] ata2: SError: { RecovComm PHYRdyChg CommWake 10B8B DevExch }
>> [   16.717637] ata2.00: failed command: WRITE FPDMA QUEUED
>> [   16.717641] ata2.00: cmd 61/08:00:c0:83:49/00:00:00:00:00/40 tag 0 ncq dma 4096 out
>>                         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 (ATA bus error)
>> [   16.717656] ata2.00: status: { DRDY }
>> [   16.717661] ata2.00: failed command: WRITE FPDMA QUEUED
>> [   16.717664] ata2.00: cmd 61/08:08:d0:83:49/00:00:00:00:00/40 tag 1 ncq dma 4096 out
>>                         res 40/00:a0:00:00:00/00:00:00:00:00/40 Emask 0x10 (ATA bus error)
>> [   16.717678] ata2.00: status: { DRDY }
>> [   16.717682] ata2.00: failed command: WRITE FPDMA QUEUED
>> [   16.717685] ata2.00: cmd 61/e0:10:e0:83:49/00:00:00:00:00/40 tag 2 ncq dma 114688 out
>>                         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 (ATA bus error)
>> [   16.717698] ata2.00: status: { DRDY }
>> [   16.717702] ata2.00: failed command: WRITE FPDMA QUEUED
>> [   16.717705] ata2.00: cmd 61/48:18:c8:84:49/00:00:00:00:00/40 tag 3 ncq dma 36864 out
>>                         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 (ATA bus error)
>> [   16.717717] ata2.00: status: { DRDY }
>> [   16.717724] ata2.00: failed command: WRITE FPDMA QUEUED
>> [   16.717727] ata2.00: cmd 61/08:d8:00:68:a0/00:00:0b:00:00/40 tag 27 ncq dma 4096 out
>>                         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 (ATA bus error)
>> [   16.717739] ata2.00: status: { DRDY }
>> [   16.717743] ata2.00: failed command: WRITE FPDMA QUEUED
>> [   16.717746] ata2.00: cmd 61/88:e0:10:83:49/00:00:00:00:00/40 tag 28 ncq dma 69632 out
>>                         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 (ATA bus error)
>> [   16.717759] ata2.00: status: { DRDY }
>> [   16.717763] ata2.00: failed command: WRITE FPDMA QUEUED
>> [   16.717766] ata2.00: cmd 61/08:e8:a0:83:49/00:00:00:00:00/40 tag 29 ncq dma 4096 out
>>                         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 (ATA bus error)
>> [   16.717778] ata2.00: status: { DRDY }
>> [   16.717782] ata2.00: failed command: WRITE FPDMA QUEUED
>> [   16.717785] ata2.00: cmd 61/08:f0:b0:83:49/00:00:00:00:00/40 tag 30 ncq dma 4096 out
>>                         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 (ATA bus error)
>> [   16.717797] ata2.00: status: { DRDY }
>> [   16.717803] ata2: hard resetting link
>> [   17.614259] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
>> [   17.615251] ata2.00: configured for UDMA/133
>> [   17.625418] ata2: EH complete
>> [   20.014269] ata2.00: limiting speed to UDMA/100:PIO4
>> [   20.014279] ata2.00: exception Emask 0x10 SAct 0x20000 SErr 0x40d0002 action 0xe frozen
>> [   20.014286] ata2.00: irq_stat 0x00000040, connection status changed
>> [   20.014290] ata2: SError: { RecovComm PHYRdyChg CommWake 10B8B DevExch }
>> [   20.014299] ata2.00: failed command: READ FPDMA QUEUED
>> [   20.014303] ata2.00: cmd 60/20:88:60:3d:5e/00:00:0b:00:00/40 tag 17 ncq dma 16384 in
>>                         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 (ATA bus error)
>> [   20.014318] ata2.00: status: { DRDY }
>> [   20.014327] ata2: hard resetting link
>> [   20.910918] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
>> [   20.911959] ata2.00: configured for UDMA/100
>> [   20.922108] sd 1:0:0:0: [sda] tag#17 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
>> [   20.922118] sd 1:0:0:0: [sda] tag#17 Sense Key : Illegal Request [current] 
>> [   20.922125] sd 1:0:0:0: [sda] tag#17 Add. Sense: Unaligned write command
>> [   20.922131] sd 1:0:0:0: [sda] tag#17 CDB: Read(10) 28 00 0b 5e 3d 60 00 00 20 00
>> [   20.922135] I/O error, dev sda, sector 190725472 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
>> [   20.922167] ata2: EH complete
>> [   22.487591] ata2.00: exception Emask 0x10 SAct 0x2000 SErr 0x40d0002 action 0xe frozen
>> [   22.487604] ata2.00: irq_stat 0x00000040, connection status changed
>> [   22.487609] ata2: SError: { RecovComm PHYRdyChg CommWake 10B8B DevExch }
>> [   22.487618] ata2.00: failed command: WRITE FPDMA QUEUED
>> [   22.487622] ata2.00: cmd 61/08:68:f0:03:40/00:00:02:00:00/40 tag 13 ncq dma 4096 out
>>                         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 (ATA bus error)
>> [   22.487637] ata2.00: status: { DRDY }
>> [   22.487647] ata2: hard resetting link
>> [   23.384251] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
>> [   23.385285] ata2.00: configured for UDMA/100
>> [   23.395434] ata2: EH complete
>> [   23.576270] systemd-journald[293]: /var/log/journal/ca3d73a04dc345538c9904a96756e41e/user-1000.journal: Journal file uses a different sequence number ID, rotating.
>> [   25.040943] ata2.00: exception Emask 0x10 SAct 0xd8 SErr 0x40d0002 action 0xe frozen
>> [   25.040957] ata2.00: irq_stat 0x00000040, connection status changed
>> [   25.040962] ata2: SError: { RecovComm PHYRdyChg CommWake 10B8B DevExch }
>> [   25.040970] ata2.00: failed command: READ FPDMA QUEUED
>> [   25.040974] ata2.00: cmd 60/08:18:88:f8:87/00:00:04:00:00/40 tag 3 ncq dma 4096 in
>>                         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 (ATA bus error)
>> [   25.040989] ata2.00: status: { DRDY }
>> [   25.040994] ata2.00: failed command: READ FPDMA QUEUED
>> [   25.040997] ata2.00: cmd 60/68:20:a8:a9:50/00:00:05:00:00/40 tag 4 ncq dma 53248 in
>>                         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 (ATA bus error)
>> [   25.041011] ata2.00: status: { DRDY }
>> [   25.041015] ata2.00: failed command: READ FPDMA QUEUED
>> [   25.041018] ata2.00: cmd 60/b0:30:08:ac:50/02:00:05:00:00/40 tag 6 ncq dma 352256 in
>>                         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 (ATA bus error)
>> [   25.041031] ata2.00: status: { DRDY }
>> [   25.041035] ata2.00: failed command: READ FPDMA QUEUED
>> [   25.041038] ata2.00: cmd 60/f0:38:b8:af:50/03:00:05:00:00/40 tag 7 ncq dma 516096 in
>>                         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 (ATA bus error)
>> [   25.041050] ata2.00: status: { DRDY }
>> [   25.041059] ata2: hard resetting link
>> [   25.907668] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
>> [   25.908712] ata2.00: configured for UDMA/100
>> [   25.918870] sd 1:0:0:0: [sda] tag#4 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
>> [   25.918881] sd 1:0:0:0: [sda] tag#4 Sense Key : Illegal Request [current] 
>> [   25.918888] sd 1:0:0:0: [sda] tag#4 Add. Sense: Unaligned write command
>> [   25.918894] sd 1:0:0:0: [sda] tag#4 CDB: Read(10) 28 00 05 50 a9 a8 00 00 68 00
>> [   25.918898] I/O error, dev sda, sector 89172392 op 0x0:(READ) flags 0x80700 phys_seg 13 prio class 0
>> [   25.918935] sd 1:0:0:0: [sda] tag#6 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
>> [   25.918951] sd 1:0:0:0: [sda] tag#6 Sense Key : Illegal Request [current] 
>> [   25.918958] sd 1:0:0:0: [sda] tag#6 Add. Sense: Unaligned write command
>> [   25.918965] sd 1:0:0:0: [sda] tag#6 CDB: Read(10) 28 00 05 50 ac 08 00 02 b0 00
>> [   25.918969] I/O error, dev sda, sector 89173000 op 0x0:(READ) flags 0x80700 phys_seg 86 prio class 0
>> [   25.918994] sd 1:0:0:0: [sda] tag#7 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
>> [   25.919001] sd 1:0:0:0: [sda] tag#7 Sense Key : Illegal Request [current] 
>> [   25.919007] sd 1:0:0:0: [sda] tag#7 Add. Sense: Unaligned write command
>> [   25.919014] sd 1:0:0:0: [sda] tag#7 CDB: Read(10) 28 00 05 50 af b8 00 03 f0 00
>> [   25.919018] I/O error, dev sda, sector 89173944 op 0x0:(READ) flags 0x80700 phys_seg 125 prio class 0
>> [   25.919037] ata2: EH complete
>> [   28.054255] ata2.00: exception Emask 0x10 SAct 0x180 SErr 0x40d0002 action 0xe frozen
>> [   28.054267] ata2.00: irq_stat 0x00000040, connection status changed
>> [   28.054272] ata2: SError: { RecovComm PHYRdyChg CommWake 10B8B DevExch }
>> [   28.054280] ata2.00: failed command: READ FPDMA QUEUED
>> [   28.054284] ata2.00: cmd 60/f8:38:00:25:88/00:00:04:00:00/40 tag 7 ncq dma 126976 in
>>                         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 (ATA bus error)
>> [   28.054299] ata2.00: status: { DRDY }
>> [   28.054304] ata2.00: failed command: READ FPDMA QUEUED
>> [   28.054307] ata2.00: cmd 60/08:40:f8:25:88/00:00:04:00:00/40 tag 8 ncq dma 4096 in
>>                         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 (ATA bus error)
>> [   28.054321] ata2.00: status: { DRDY }
>> [   28.054330] ata2: hard resetting link
>> [   28.950942] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
>> [   28.951968] ata2.00: configured for UDMA/100
>> [   28.962123] sd 1:0:0:0: [sda] tag#7 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
>> [   28.962133] sd 1:0:0:0: [sda] tag#7 Sense Key : Illegal Request [current] 
>> [   28.962139] sd 1:0:0:0: [sda] tag#7 Add. Sense: Unaligned write command
>> [   28.962145] sd 1:0:0:0: [sda] tag#7 CDB: Read(10) 28 00 04 88 25 00 00 00 f8 00
>> [   28.962149] I/O error, dev sda, sector 76031232 op 0x0:(READ) flags 0x80700 phys_seg 31 prio class 0
>> [   28.962186] ata2: EH complete
>> [   31.660931] ata2.00: limiting speed to UDMA/33:PIO4
>> [   31.660942] ata2.00: exception Emask 0x10 SAct 0x20000 SErr 0x40d0002 action 0xe frozen
>> [   31.660948] ata2.00: irq_stat 0x00000040, connection status changed
>> [   31.660952] ata2: SError: { RecovComm PHYRdyChg CommWake 10B8B DevExch }
>> [   31.660962] ata2.00: failed command: WRITE FPDMA QUEUED
>> [   31.660965] ata2.00: cmd 61/20:88:f8:68:d1/00:00:06:00:00/40 tag 17 ncq dma 16384 out
>>                         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 (ATA bus error)
>> [   31.660980] ata2.00: status: { DRDY }
>> [   31.660989] ata2: hard resetting link
>> [   32.557680] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
>> [   32.558714] ata2.00: configured for UDMA/33
>> [   32.568903] ata2: EH complete
>> [   33.154256] ata2.00: exception Emask 0x10 SAct 0x38800000 SErr 0x40d0002 action 0xe frozen
>> [   33.154269] ata2.00: irq_stat 0x00000040, connection status changed
>> [   33.154273] ata2: SError: { RecovComm PHYRdyChg CommWake 10B8B DevExch }
>> [   33.154284] ata2.00: failed command: WRITE FPDMA QUEUED
>> [   33.154287] ata2.00: cmd 61/b8:b8:20:be:98/01:00:09:00:00/40 tag 23 ncq dma 225280 out
>>                         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 (ATA bus error)
>> [   33.154302] ata2.00: status: { DRDY }
>> [   33.154308] ata2.00: failed command: WRITE FPDMA QUEUED
>> [   33.154311] ata2.00: cmd 61/08:d8:00:28:fc/00:00:0a:00:00/40 tag 27 ncq dma 4096 out
>>                         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 (ATA bus error)
>> [   33.154324] ata2.00: status: { DRDY }
>> [   33.154329] ata2.00: failed command: WRITE FPDMA QUEUED
>> [   33.154332] ata2.00: cmd 61/d8:e0:b0:8b:d6/01:00:08:00:00/40 tag 28 ncq dma 241664 out
>>                         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 (ATA bus error)
>> [   33.154345] ata2.00: status: { DRDY }
>> [   33.154349] ata2.00: failed command: WRITE FPDMA QUEUED
>> [   33.154352] ata2.00: cmd 61/08:e8:10:78:9b/00:00:04:00:00/40 tag 29 ncq dma 4096 out
>>                         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 (ATA bus error)
>> [   33.154364] ata2.00: status: { DRDY }
>> [   33.154371] ata2: hard resetting link
>> [   34.050956] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
>> [   34.051959] ata2.00: configured for UDMA/33
>> [   34.062160] ata2: EH complete
>> [   37.637589] ata2.00: exception Emask 0x10 SAct 0x10400 SErr 0x40d0002 action 0xe frozen
>> [   37.637602] ata2.00: irq_stat 0x00000040, connection status changed
>> [   37.637606] ata2: SError: { RecovComm PHYRdyChg CommWake 10B8B DevExch }
>> [   37.637615] ata2.00: failed command: WRITE FPDMA QUEUED
>> [   37.637618] ata2.00: cmd 61/18:50:20:69:d1/00:00:06:00:00/40 tag 10 ncq dma 12288 out
>>                         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 (ATA bus error)
>> [   37.637633] ata2.00: status: { DRDY }
>> [   37.637639] ata2.00: failed command: READ FPDMA QUEUED
>> [   37.637643] ata2.00: cmd 60/20:80:90:f5:26/00:00:02:00:00/40 tag 16 ncq dma 16384 in
>>                         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 (ATA bus error)
>> [   37.637656] ata2.00: status: { DRDY }
>> [   37.637664] ata2: hard resetting link
>> [   38.504247] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
>> [   38.505282] ata2.00: configured for UDMA/33
>> [   38.515438] sd 1:0:0:0: [sda] tag#16 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
>> [   38.515448] sd 1:0:0:0: [sda] tag#16 Sense Key : Illegal Request [current] 
>> [   38.515455] sd 1:0:0:0: [sda] tag#16 Add. Sense: Unaligned write command
>> [   38.515461] sd 1:0:0:0: [sda] tag#16 CDB: Read(10) 28 00 02 26 f5 90 00 00 20 00
>> [   38.515464] I/O error, dev sda, sector 36107664 op 0x0:(READ) flags 0x80700 phys_seg 4 prio class 0
>> [   38.515492] ata2: EH complete
>> [   40.834267] ata2.00: exception Emask 0x10 SAct 0x200000 SErr 0x40d0002 action 0xe frozen
>> [   40.834280] ata2.00: irq_stat 0x00000040, connection status changed
>> [   40.834285] ata2: SError: { RecovComm PHYRdyChg CommWake 10B8B DevExch }
>> [   40.834295] ata2.00: failed command: READ FPDMA QUEUED
>> [   40.834299] ata2.00: cmd 60/20:a8:f8:3c:35/00:00:02:00:00/40 tag 21 ncq dma 16384 in
>>                         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 (ATA bus error)
>> [   40.834314] ata2.00: status: { DRDY }
>> [   40.834323] ata2: hard resetting link
>> [   41.730960] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
>> [   41.732007] ata2.00: configured for UDMA/33
>> [   41.742199] sd 1:0:0:0: [sda] tag#21 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
>> [   41.742211] sd 1:0:0:0: [sda] tag#21 Sense Key : Illegal Request [current] 
>> [   41.742218] sd 1:0:0:0: [sda] tag#21 Add. Sense: Unaligned write command
>> [   41.742224] sd 1:0:0:0: [sda] tag#21 CDB: Read(10) 28 00 02 35 3c f8 00 00 20 00
>> [   41.742228] I/O error, dev sda, sector 37043448 op 0x0:(READ) flags 0x80700 phys_seg 4 prio class 0
>> [   41.742263] ata2: EH complete

-- 
Jens Axboe


