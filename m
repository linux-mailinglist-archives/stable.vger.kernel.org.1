Return-Path: <stable+bounces-163411-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9801B0AD32
	for <lists+stable@lfdr.de>; Sat, 19 Jul 2025 03:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 123697A1BD6
	for <lists+stable@lfdr.de>; Sat, 19 Jul 2025 01:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBBEA149C6F;
	Sat, 19 Jul 2025 01:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F3r34Koq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956361482F5;
	Sat, 19 Jul 2025 01:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752887650; cv=none; b=MXFbtwN79Wg+KplKG3j3ffb2b0SETvtE+b0wz2gKUtYObz8w0l1OyEm8rzZST5dLBDE4JMttlWNv/EQvlBV7HSgQnGjirqmoWKPJcuiFqJiM2ElVwinjELao9/IMsQmparx1jvB5kGFMja/W7B+nZk/96k/BiAHEVlpGo7F/CrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752887650; c=relaxed/simple;
	bh=qASniwLCjnDxmwCrmEW2G2MHYNGCqFnGOxWd0s73/IM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=asbEK7dvIOP44TLnb1Y9j1smRjQQhy8uyKA4vosd4yvL0rNTnJ/eK9faF7/oF8yQE04MZDgfjIwmBOe0vmC/1BFZNuPnxHAo/jZFBlrmhFo4PpGqCLYD86YNhSjbZ+y+3vW9Km9PIkVXBzzI35G5t3SLS7UdsP1TxXo/1mHTipc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F3r34Koq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3AEBC4CEEB;
	Sat, 19 Jul 2025 01:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752887650;
	bh=qASniwLCjnDxmwCrmEW2G2MHYNGCqFnGOxWd0s73/IM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=F3r34Koqj7wPOb5bfsWOdEjA3CveGwZzRWv07DC7L1eazdivV/tsbB/fqyqvYz5oM
	 yEPlp2Xh7/BQJrOYwrlRLIm2C3G1epoBKHghlrll0tRNlmDu+mveuvz5am3zOx5HBe
	 my8YnNPGjuzMEHA4L0TiyRnBIg6wT/Hd4kuZidkAnUj/ZZsiH4BdRDzu9AzLcUGG2R
	 a0T/zG7ocnXd1rKlC96+atL/3tlpXtr08xROlI/E0wQJ/hTikgwmktINjJuER60oC9
	 7L2XUgsz+G1gHzeIwJrYUFyTx7xoTuTyEQZxSh7/7r9QX+Cc024dsQoZfwfUL4OsNF
	 vO2VbdHYjUT3A==
Message-ID: <664c5661-0fa8-41db-b55d-7f1f58e40142@kernel.org>
Date: Fri, 18 Jul 2025 20:14:08 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] drm/amd/display: backlight brightness set to 0 at
 amdgpu initialization
To: Lauri Tirkkonen <lauri@hacktheplanet.fi>
Cc: stable@vger.kernel.org, regressions@lists.linux.dev,
 amd-gfx@lists.freedesktop.org, Wayne Lin <wayne.lin@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <aHn33vgj8bM4s073@hacktheplanet.fi>
 <d92458bf-fc2b-47bf-b664-9609a3978646@kernel.org>
 <aHpb4ZTZ5FoOBUrZ@hacktheplanet.fi>
 <46de4f2a-8836-42cd-a621-ae3e782bf253@kernel.org>
 <aHru-sP7S2ufH7Im@hacktheplanet.fi>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <aHru-sP7S2ufH7Im@hacktheplanet.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/18/25 8:03 PM, Lauri Tirkkonen wrote:
> On Fri, Jul 18 2025 12:13:30 -0500, Mario Limonciello wrote:
>> On 7/18/2025 9:36 AM, Lauri Tirkkonen wrote:
>>> On Fri, Jul 18 2025 08:10:06 -0500, Mario Limonciello wrote:
>>>> Do you by chance have an OLED panel?  I believe what's going on is that
>>>> userspace is writing zero or near zero and on OLED panels with older kernels
>>>> this means non-visible.
>>>
>>> Yes, this is an OLED panel. But I don't believe it's userspace writing
>>> anything at this point in the boot; before the bisected commit,
>>> brightness was set to 32 (out of max 255) on this hardware when I
>>> checked from the initramfs rescue shell. At the bisected commit, it's 0
>>> (out of max 255).
>>>
>>>> There is another commit that fixes the behavior that is probably missing.
>>>
>>> Which commit is that? It's not in 6.15.7?
>>>
>>
>> https://github.com/torvalds/linux/commit/39d81457ad3417a98ac826161f9ca0e642677661
>>
>> No; it's not currently backported.  Assuming it helps your issue I think
>> it's a good argument to backport.
> 
> I cherry-picked this on top of 6.15.7.
> 
> It doesn't help much; it's possible to make out that the panel is not
> completely back, but even in a dark room it's so dim that it's very
> difficult to read anything. /sys/class/backlight/amdgpu_bl1/brightness
> is 0 and max_brightness is 399000.
> 
> So to reiterate: before 6c56c8ec6f9762c33bd22f31d43af4194d12da53,
> brightness when amdgpu is loaded got set to 32/255 (about 12.5%). After,
> it gets set to 0.
> 
> I also added dump_stack() to amdgpu_dm_backlight_set_level as you've
> suggested on the issue linked from the above commit, and it shows that
> brightness is set to 0 in a stacktrace starting from __do_sys_init_module. So
> I would say it is not userspace setting it to 0. dmesg follows.
> 
> [    0.000000] Linux version 6.15.7+ (lotheac@elecman.lotheac.fi) (gcc (Alpine 14.3.0) 14.3.0, GNU ld (GNU Binutils) 2.44) #8 SMP PREEMPT_DYNAMIC Sat Jul 19 09:15:51 JST 2025
> [    0.000000] Command line: initrd=/initramfs-vanilla rootfstype=zfs root=ZFS=z/e/ROOT/alpine rw kexec_load_disabled=0
> [    0.000000] BIOS-provided physical RAM map:
> [    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009efff] usable
> [    0.000000] BIOS-e820: [mem 0x000000000009f000-0x000000000009ffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000009bfffff] usable
> [    0.000000] BIOS-e820: [mem 0x0000000009c00000-0x0000000009d90fff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000009d91000-0x0000000009efffff] usable
> [    0.000000] BIOS-e820: [mem 0x0000000009f00000-0x0000000009f0efff] ACPI NVS
> [    0.000000] BIOS-e820: [mem 0x0000000009f0f000-0x00000000c717dfff] usable
> [    0.000000] BIOS-e820: [mem 0x00000000c717e000-0x00000000cb37dfff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000cb37e000-0x00000000cd37dfff] ACPI NVS
> [    0.000000] BIOS-e820: [mem 0x00000000cd37e000-0x00000000cd3fdfff] ACPI data
> [    0.000000] BIOS-e820: [mem 0x00000000cd3fe000-0x00000000ce7fffff] usable
> [    0.000000] BIOS-e820: [mem 0x00000000ce800000-0x00000000cfffffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000f8000000-0x00000000fbffffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fde00000-0x00000000fdefffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fe000000-0x00000000fe0fffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fed80000-0x00000000fed80fff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000100000000-0x00000003ae2fffff] usable
> [    0.000000] BIOS-e820: [mem 0x00000003ae300000-0x000000042fffffff] reserved
> [    0.000000] NX (Execute Disable) protection: active
> [    0.000000] APIC: Static calls initialized
> [    0.000000] efi: EFI v2.7 by Phoenix Technologies Ltd.
> [    0.000000] efi: ACPI=0xcd3fd000 ACPI 2.0=0xcd3fd014 SMBIOS=0xc9266000 SMBIOS 3.0=0xc9259000 TPMFinalLog=0xcd223000 MEMATTR=0xc4030018 ESRT=0xc5926198 INITRD=0xad969f18 RNG=0xcd3fc018 TPMEventLog=0xcd3f2018
> [    0.000000] random: crng init done
> [    0.000000] efi: Remove mem74: MMIO range=[0xfde00000-0xfdefffff] (1MB) from e820 map
> [    0.000000] e820: remove [mem 0xfde00000-0xfdefffff] reserved
> [    0.000000] efi: Remove mem75: MMIO range=[0xfe000000-0xfe0fffff] (1MB) from e820 map
> [    0.000000] e820: remove [mem 0xfe000000-0xfe0fffff] reserved
> [    0.000000] efi: Not removing mem76: MMIO range=[0xfed80000-0xfed80fff] (4KB) from e820 map
> [    0.000000] SMBIOS 3.3.0 present.
> [    0.000000] DMI: LENOVO 82N5/LNVNB161216, BIOS GZCN32WW 12/08/2022
> [    0.000000] DMI: Memory slots populated: 2/2
> [    0.000000] tsc: Fast TSC calibration using PIT
> [    0.000000] tsc: Detected 3194.101 MHz processor
> [    0.000009] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
> [    0.000010] e820: remove [mem 0x000a0000-0x000fffff] usable
> [    0.000016] last_pfn = 0x3ae300 max_arch_pfn = 0x400000000
> [    0.000021] MTRR map: 6 entries (3 fixed + 3 variable; max 20), built from 9 variable MTRRs
> [    0.000022] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT
> [    0.000364] last_pfn = 0xce800 max_arch_pfn = 0x400000000
> [    0.003489] esrt: Reserving ESRT space from 0x00000000c5926198 to 0x00000000c59261f8.
> [    0.003496] e820: update [mem 0xc5926000-0xc5926fff] usable ==> reserved
> [    0.003511] Using GB pages for direct mapping
> [    0.003810] Secure boot disabled
> [    0.003811] RAMDISK: [mem 0x7a96c000-0x7fffffff]
> [    0.003814] ACPI: Early table checksum verification disabled
> [    0.003816] ACPI: RSDP 0x00000000CD3FD014 000024 (v02 LENOVO)
> [    0.003819] ACPI: XSDT 0x00000000CD3FB188 0000E4 (v01 LENOVO CB-01    00000003 PTEC 00000002)
> [    0.003823] ACPI: FACP 0x00000000C7F7F000 000114 (v06 LENOVO CB-01    00000003 PTEC 00000002)
> [    0.003826] ACPI: DSDT 0x00000000C7F73000 008D88 (v01 LENOVO AMD      00001000 INTL 20180313)
> [    0.003828] ACPI: FACS 0x00000000CC980000 000040
> [    0.003829] ACPI: SSDT 0x00000000C929B000 000CE7 (v01 LENOVO UsbCTabl 00000001 INTL 20180313)
> [    0.003831] ACPI: SSDT 0x00000000C928E000 007229 (v02 LENOVO AmdTable 00000002 MSFT 04000000)
> [    0.003832] ACPI: IVRS 0x00000000C926B000 0001A4 (v02 LENOVO CB-01    00000001 PTEC 00000002)
> [    0.003834] ACPI: MSDM 0x00000000C9198000 000055 (v03 LENOVO CB-01    00000000 PTEC 00000002)
> [    0.003835] ACPI: BATB 0x00000000C9182000 00004A (v02 LENOVO CB-01    00000000 PTEC 00000002)
> [    0.003837] ACPI: SLIC 0x00000000C7F80000 000176 (v01 LENOVO CB-01    00000002 PTEC 00000002)
> [    0.003838] ACPI: HPET 0x00000000C7F7E000 000038 (v01 LENOVO CB-01    00000001 PTEC 00000002)
> [    0.003840] ACPI: APIC 0x00000000C7F7D000 000138 (v02 LENOVO CB-01    00000000 PTEC 00000002)
> [    0.003841] ACPI: MCFG 0x00000000C7F7C000 00003C (v01 LENOVO CB-01    00000001 PTEC 00000002)
> [    0.003843] ACPI: VFCT 0x00000000C7F65000 00D884 (v01 LENOVO CB-01    00000001 PTEC 00000002)
> [    0.003844] ACPI: SSDT 0x00000000C7F5F000 005354 (v02 LENOVO AmdTable 00000001 AMD  00000001)
> [    0.003845] ACPI: CRAT 0x00000000C7F5E000 000EC0 (v01 LENOVO CB-01    00000001 PTEC 00000002)
> [    0.003847] ACPI: CDIT 0x00000000C7F5D000 000029 (v01 LENOVO CB-01    00000001 PTEC 00000002)
> [    0.003848] ACPI: SSDT 0x00000000C7F5C000 00053A (v01 LENOVO Tpm2Tabl 00009999 INTL 20180313)
> [    0.003850] ACPI: TPM2 0x00000000C7F5B000 000038 (v04 LENOVO CB-01    00000002 PTEC 00000002)
> [    0.003851] ACPI: FPDT 0x00000000C7F5A000 000034 (v01 LENOVO CB-01    00000002 PTEC 00000002)
> [    0.003853] ACPI: SSDT 0x00000000C7F59000 000149 (v01 LENOVO AmdTable 00000001 INTL 20180313)
> [    0.003854] ACPI: SSDT 0x00000000C7F57000 0014BB (v01 LENOVO AmdTable 00000001 INTL 20180313)
> [    0.003856] ACPI: SSDT 0x00000000C7F55000 001580 (v01 LENOVO AmdTable 00000001 INTL 20180313)
> [    0.003857] ACPI: SSDT 0x00000000C7F51000 003B08 (v01 LENOVO AmdTable 00000001 INTL 20180313)
> [    0.003859] ACPI: BGRT 0x00000000C7F50000 000038 (v01 LENOVO CB-01    00000002 PTEC 00000002)
> [    0.003860] ACPI: UEFI 0x00000000CC97E000 0000DA (v01 LENOVO CB-01    00000001 PTEC 00000002)
> [    0.003862] ACPI: SSDT 0x00000000C929A000 0009B5 (v01 LENOVO AmdTable 00000001 INTL 20180313)
> [    0.003863] ACPI: Reserving FACP table memory at [mem 0xc7f7f000-0xc7f7f113]
> [    0.003864] ACPI: Reserving DSDT table memory at [mem 0xc7f73000-0xc7f7bd87]
> [    0.003864] ACPI: Reserving FACS table memory at [mem 0xcc980000-0xcc98003f]
> [    0.003865] ACPI: Reserving SSDT table memory at [mem 0xc929b000-0xc929bce6]
> [    0.003865] ACPI: Reserving SSDT table memory at [mem 0xc928e000-0xc9295228]
> [    0.003866] ACPI: Reserving IVRS table memory at [mem 0xc926b000-0xc926b1a3]
> [    0.003866] ACPI: Reserving MSDM table memory at [mem 0xc9198000-0xc9198054]
> [    0.003867] ACPI: Reserving BATB table memory at [mem 0xc9182000-0xc9182049]
> [    0.003867] ACPI: Reserving SLIC table memory at [mem 0xc7f80000-0xc7f80175]
> [    0.003868] ACPI: Reserving HPET table memory at [mem 0xc7f7e000-0xc7f7e037]
> [    0.003868] ACPI: Reserving APIC table memory at [mem 0xc7f7d000-0xc7f7d137]
> [    0.003869] ACPI: Reserving MCFG table memory at [mem 0xc7f7c000-0xc7f7c03b]
> [    0.003869] ACPI: Reserving VFCT table memory at [mem 0xc7f65000-0xc7f72883]
> [    0.003870] ACPI: Reserving SSDT table memory at [mem 0xc7f5f000-0xc7f64353]
> [    0.003870] ACPI: Reserving CRAT table memory at [mem 0xc7f5e000-0xc7f5eebf]
> [    0.003871] ACPI: Reserving CDIT table memory at [mem 0xc7f5d000-0xc7f5d028]
> [    0.003871] ACPI: Reserving SSDT table memory at [mem 0xc7f5c000-0xc7f5c539]
> [    0.003872] ACPI: Reserving TPM2 table memory at [mem 0xc7f5b000-0xc7f5b037]
> [    0.003872] ACPI: Reserving FPDT table memory at [mem 0xc7f5a000-0xc7f5a033]
> [    0.003873] ACPI: Reserving SSDT table memory at [mem 0xc7f59000-0xc7f59148]
> [    0.003873] ACPI: Reserving SSDT table memory at [mem 0xc7f57000-0xc7f584ba]
> [    0.003874] ACPI: Reserving SSDT table memory at [mem 0xc7f55000-0xc7f5657f]
> [    0.003874] ACPI: Reserving SSDT table memory at [mem 0xc7f51000-0xc7f54b07]
> [    0.003875] ACPI: Reserving BGRT table memory at [mem 0xc7f50000-0xc7f50037]
> [    0.003875] ACPI: Reserving UEFI table memory at [mem 0xcc97e000-0xcc97e0d9]
> [    0.003876] ACPI: Reserving SSDT table memory at [mem 0xc929a000-0xc929a9b4]
> [    0.003927] No NUMA configuration found
> [    0.003928] Faking a node at [mem 0x0000000000000000-0x00000003ae2fffff]
> [    0.003931] NODE_DATA(0) allocated [mem 0x3ae2fad40-0x3ae2fffff]
> [    0.003954] Zone ranges:
> [    0.003954]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
> [    0.003955]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
> [    0.003956]   Normal   [mem 0x0000000100000000-0x00000003ae2fffff]
> [    0.003957]   Device   empty
> [    0.003958] Movable zone start for each node
> [    0.003958] Early memory node ranges
> [    0.003959]   node   0: [mem 0x0000000000001000-0x000000000009efff]
> [    0.003960]   node   0: [mem 0x0000000000100000-0x0000000009bfffff]
> [    0.003960]   node   0: [mem 0x0000000009d91000-0x0000000009efffff]
> [    0.003961]   node   0: [mem 0x0000000009f0f000-0x00000000c717dfff]
> [    0.003961]   node   0: [mem 0x00000000cd3fe000-0x00000000ce7fffff]
> [    0.003962]   node   0: [mem 0x0000000100000000-0x00000003ae2fffff]
> [    0.003964] Initmem setup node 0 [mem 0x0000000000001000-0x00000003ae2fffff]
> [    0.003968] On node 0, zone DMA: 1 pages in unavailable ranges
> [    0.003982] On node 0, zone DMA: 97 pages in unavailable ranges
> [    0.004100] On node 0, zone DMA32: 401 pages in unavailable ranges
> [    0.007542] On node 0, zone DMA32: 15 pages in unavailable ranges
> [    0.007763] On node 0, zone DMA32: 25216 pages in unavailable ranges
> [    0.021377] On node 0, zone Normal: 6144 pages in unavailable ranges
> [    0.021437] On node 0, zone Normal: 7424 pages in unavailable ranges
> [    0.021543] ACPI: PM-Timer IO Port: 0x408
> [    0.021552] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
> [    0.021553] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
> [    0.021553] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
> [    0.021554] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
> [    0.021554] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
> [    0.021555] ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])
> [    0.021555] ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
> [    0.021556] ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])
> [    0.021556] ACPI: LAPIC_NMI (acpi_id[0x08] high edge lint[0x1])
> [    0.021556] ACPI: LAPIC_NMI (acpi_id[0x09] high edge lint[0x1])
> [    0.021557] ACPI: LAPIC_NMI (acpi_id[0x0a] high edge lint[0x1])
> [    0.021557] ACPI: LAPIC_NMI (acpi_id[0x0b] high edge lint[0x1])
> [    0.021558] ACPI: LAPIC_NMI (acpi_id[0x0c] high edge lint[0x1])
> [    0.021558] ACPI: LAPIC_NMI (acpi_id[0x0d] high edge lint[0x1])
> [    0.021559] ACPI: LAPIC_NMI (acpi_id[0x0e] high edge lint[0x1])
> [    0.021559] ACPI: LAPIC_NMI (acpi_id[0x0f] high edge lint[0x1])
> [    0.021572] IOAPIC[0]: apic_id 32, version 33, address 0xfec00000, GSI 0-23
> [    0.021576] IOAPIC[1]: apic_id 33, version 33, address 0xfec01000, GSI 24-55
> [    0.021578] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
> [    0.021580] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
> [    0.021583] ACPI: Using ACPI (MADT) for SMP configuration information
> [    0.021584] ACPI: HPET id: 0x43538210 base: 0xfed00000
> [    0.021594] e820: update [mem 0xc303c000-0xc329bfff] usable ==> reserved
> [    0.021607] CPU topo: Max. logical packages:   1
> [    0.021607] CPU topo: Max. logical dies:       1
> [    0.021607] CPU topo: Max. dies per package:   1
> [    0.021611] CPU topo: Max. threads per core:   2
> [    0.021612] CPU topo: Num. cores per package:     8
> [    0.021612] CPU topo: Num. threads per package:  16
> [    0.021613] CPU topo: Allowing 16 present CPUs plus 0 hotplug CPUs
> [    0.021630] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
> [    0.021632] PM: hibernation: Registered nosave memory: [mem 0x0009f000-0x000fffff]
> [    0.021633] PM: hibernation: Registered nosave memory: [mem 0x09c00000-0x09d90fff]
> [    0.021634] PM: hibernation: Registered nosave memory: [mem 0x09f00000-0x09f0efff]
> [    0.021635] PM: hibernation: Registered nosave memory: [mem 0xc303c000-0xc329bfff]
> [    0.021636] PM: hibernation: Registered nosave memory: [mem 0xc5926000-0xc5926fff]
> [    0.021638] PM: hibernation: Registered nosave memory: [mem 0xc717e000-0xcd3fdfff]
> [    0.021639] PM: hibernation: Registered nosave memory: [mem 0xce800000-0xffffffff]
> [    0.021640] [mem 0xd0000000-0xf7ffffff] available for PCI devices
> [    0.021641] Booting paravirtualized kernel on bare hardware
> [    0.021643] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
> [    0.025163] setup_percpu: NR_CPUS:256 nr_cpumask_bits:16 nr_cpu_ids:16 nr_node_ids:1
> [    0.025539] percpu: Embedded 56 pages/cpu s189784 r8192 d31400 u262144
> [    0.025544] pcpu-alloc: s189784 r8192 d31400 u262144 alloc=1*2097152
> [    0.025546] pcpu-alloc: [0] 00 01 02 03 04 05 06 07 [0] 08 09 10 11 12 13 14 15
> [    0.025564] Kernel command line: initrd=/initramfs-vanilla rootfstype=zfs root=ZFS=z/e/ROOT/alpine rw kexec_load_disabled=0
> [    0.025601] Unknown kernel command line parameters "kexec_load_disabled=0", will be passed to user space.
> [    0.025619] printk: log buffer data + meta data: 131072 + 458752 = 589824 bytes
> [    0.026701] Dentry cache hash table entries: 2097152 (order: 12, 16777216 bytes, linear)
> [    0.027282] Inode-cache hash table entries: 1048576 (order: 11, 8388608 bytes, linear)
> [    0.027401] software IO TLB: area num 16.
> [    0.036358] Fallback order for Node 0: 0
> [    0.036364] Built 1 zonelists, mobility grouping on.  Total pages: 3630718
> [    0.036365] Policy zone: Normal
> [    0.036536] mem auto-init: stack:all(zero), heap alloc:on, heap free:off
> [    0.058155] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=16, Nodes=1
> [    0.058158] kmemleak: Kernel memory leak detector disabled
> [    0.065961] ftrace: allocating 42971 entries in 168 pages
> [    0.065962] ftrace: allocated 168 pages with 3 groups
> [    0.066540] Dynamic Preempt: voluntary
> [    0.066590] rcu: Preemptible hierarchical RCU implementation.
> [    0.066590] rcu: 	RCU restricting CPUs from NR_CPUS=256 to nr_cpu_ids=16.
> [    0.066591] 	Trampoline variant of Tasks RCU enabled.
> [    0.066592] 	Rude variant of Tasks RCU enabled.
> [    0.066592] 	Tracing variant of Tasks RCU enabled.
> [    0.066593] rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
> [    0.066593] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=16
> [    0.066604] RCU Tasks: Setting shift to 4 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=16.
> [    0.066606] RCU Tasks Rude: Setting shift to 4 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=16.
> [    0.066608] RCU Tasks Trace: Setting shift to 4 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=16.
> [    0.070344] NR_IRQS: 16640, nr_irqs: 1096, preallocated irqs: 16
> [    0.070534] rcu: srcu_init: Setting srcu_struct sizes based on contention.
> [    0.070631] kfence: initialized - using 2097152 bytes for 255 objects at 0x(____ptrval____)-0x(____ptrval____)
> [    0.070664] Console: colour dummy device 80x25
> [    0.070666] printk: legacy console [tty0] enabled
> [    0.070917] ACPI: Core revision 20240827
> [    0.071030] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484873504 ns
> [    0.071048] APIC: Switch to symmetric I/O mode setup
> [    0.071557] AMD-Vi: ivrs, add hid:AMDI0020, uid:\_SB.FUR0, rdevid:0xa0
> [    0.071560] AMD-Vi: ivrs, add hid:AMDI0020, uid:\_SB.FUR1, rdevid:0xa0
> [    0.071564] AMD-Vi: ivrs, add hid:AMDI0020, uid:\_SB.FUR2, rdevid:0xa0
> [    0.071566] AMD-Vi: ivrs, add hid:AMDI0020, uid:\_SB.FUR3, rdevid:0xa0
> [    0.071568] AMD-Vi: Using global IVHD EFR:0x206d73ef22254ade, EFR2:0x0
> [    0.072602] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
> [    0.077054] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x2e0a8595913, max_idle_ns: 440795360129 ns
> [    0.077059] Calibrating delay loop (skipped), value calculated using timer frequency.. 6388.20 BogoMIPS (lpj=3194101)
> [    0.077075] x86/cpu: User Mode Instruction Prevention (UMIP) activated
> [    0.077097] LVT offset 1 assigned for vector 0xf9
> [    0.077155] LVT offset 2 assigned for vector 0xf4
> [    0.077172] Last level iTLB entries: 4KB 512, 2MB 512, 4MB 256
> [    0.077174] Last level dTLB entries: 4KB 2048, 2MB 2048, 4MB 1024, 1GB 0
> [    0.077177] process: using mwait in idle threads
> [    0.077180] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
> [    0.077183] Spectre V2 : Mitigation: Retpolines
> [    0.077185] Spectre V2 : Spectre v2 / SpectreRSB: Filling RSB on context switch and VMEXIT
> [    0.077187] Spectre V2 : Enabling Restricted Speculation for firmware calls
> [    0.077189] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
> [    0.077192] Spectre V2 : User space: Mitigation: STIBP always-on protection
> [    0.077194] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl
> [    0.077197] Speculative Return Stack Overflow: IBPB-extending microcode not applied!
> [    0.077199] Speculative Return Stack Overflow: WARNING: See https://kernel.org/doc/html/latest/admin-guide/hw-vuln/srso.html for mitigation options.
> [    0.077199] Speculative Return Stack Overflow: Vulnerable: Safe RET, no microcode
> [    0.077204] Transient Scheduler Attacks: Vulnerable: Clear CPU buffers attempted, no microcode
> [    0.077209] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
> [    0.077211] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
> [    0.077213] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
> [    0.077214] x86/fpu: Supporting XSAVE feature 0x200: 'Protection Keys User registers'
> [    0.077216] x86/fpu: Supporting XSAVE feature 0x800: 'Control-flow User registers'
> [    0.077218] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
> [    0.077220] x86/fpu: xstate_offset[9]:  832, xstate_sizes[9]:    8
> [    0.077221] x86/fpu: xstate_offset[11]:  840, xstate_sizes[11]:   16
> [    0.077223] x86/fpu: Enabled xstate features 0xa07, context size is 856 bytes, using 'compacted' format.
> [    0.099150] Freeing SMP alternatives memory: 40K
> [    0.099155] pid_max: default: 32768 minimum: 301
> [    0.102089] LSM: initializing lsm=lockdown,capability,landlock,yama
> [    0.102171] landlock: Up and running.
> [    0.102174] Yama: becoming mindful.
> [    0.102220] Mount-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
> [    0.102240] Mountpoint-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
> [    0.205463] smpboot: CPU0: AMD Ryzen 7 5800H with Radeon Graphics (family: 0x19, model: 0x50, stepping: 0x0)
> [    0.205702] Performance Events: Fam17h+ core perfctr, AMD PMU driver.
> [    0.205712] ... version:                0
> [    0.205715] ... bit width:              48
> [    0.205718] ... generic registers:      6
> [    0.205721] ... value mask:             0000ffffffffffff
> [    0.205724] ... max period:             00007fffffffffff
> [    0.205727] ... fixed-purpose events:   0
> [    0.205730] ... event mask:             000000000000003f
> [    0.205822] signal: max sigframe size: 3376
> [    0.205855] rcu: Hierarchical SRCU implementation.
> [    0.205859] rcu: 	Max phase no-delay instances is 400.
> [    0.205911] Timer migration: 2 hierarchy levels; 8 children per group; 2 crossnode level
> [    0.208523] MCE: In-kernel MCE decoding enabled.
> [    0.208573] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
> [    0.208733] smp: Bringing up secondary CPUs ...
> [    0.208876] smpboot: x86: Booting SMP configuration:
> [    0.208881] .... node  #0, CPUs:        #2  #4  #6  #8 #10 #12 #14  #1  #3  #5  #7  #9 #11 #13 #15
> [    0.220158] Spectre V2 : Update user space SMT mitigation: STIBP always-on
> [    0.228088] smp: Brought up 1 node, 16 CPUs
> [    0.228088] smpboot: Total of 16 processors activated (102211.23 BogoMIPS)
> [    0.229223] Memory: 14042864K/14522872K available (15140K kernel code, 2091K rwdata, 10372K rodata, 3652K init, 4060K bss, 461188K reserved, 0K cma-reserved)
> [    0.229458] devtmpfs: initialized
> [    0.229458] x86/mm: Memory block size: 128MB
> [    0.231762] ACPI: PM: Registering ACPI NVS region [mem 0x09f00000-0x09f0efff] (61440 bytes)
> [    0.231762] ACPI: PM: Registering ACPI NVS region [mem 0xcb37e000-0xcd37dfff] (33554432 bytes)
> [    0.232456] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
> [    0.232456] posixtimers hash table entries: 8192 (order: 5, 131072 bytes, linear)
> [    0.232456] futex hash table entries: 4096 (order: 6, 262144 bytes, linear)
> [    0.232456] pinctrl core: initialized pinctrl subsystem
> [    0.233077] NET: Registered PF_NETLINK/PF_ROUTE protocol family
> [    0.233224] audit: initializing netlink subsys (disabled)
> [    0.233233] audit: type=2000 audit(1752885617.162:1): state=initialized audit_enabled=0 res=1
> [    0.233233] thermal_sys: Registered thermal governor 'fair_share'
> [    0.233233] thermal_sys: Registered thermal governor 'bang_bang'
> [    0.233233] thermal_sys: Registered thermal governor 'step_wise'
> [    0.233233] cpuidle: using governor ladder
> [    0.233233] cpuidle: using governor menu
> [    0.233305] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
> [    0.233322] PCI: ECAM [mem 0xf8000000-0xfbffffff] (base 0xf8000000) for domain 0000 [bus 00-3f]
> [    0.233338] PCI: Using configuration type 1 for base access
> [    0.233462] kprobes: kprobe jump-optimization is enabled. All kprobes are optimized if possible.
> [    0.235108] HugeTLB: allocation took 0ms with hugepage_allocation_threads=4
> [    0.235108] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
> [    0.235108] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
> [    0.235108] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
> [    0.235108] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
> [    0.236119] fbcon: Taking over console
> [    0.236167] ACPI: Added _OSI(Module Device)
> [    0.236171] ACPI: Added _OSI(Processor Device)
> [    0.236175] ACPI: Added _OSI(Processor Aggregator Device)
> [    0.250109] ACPI: 10 ACPI AML tables successfully acquired and loaded
> [    0.251735] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
> [    0.253498] ACPI: EC: EC started
> [    0.253502] ACPI: EC: interrupt blocked
> [    0.261933] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
> [    0.261939] ACPI: \_SB_.PCI0.LPC0.EC0_: Boot DSDT EC used to handle transactions
> [    0.261943] ACPI: Interpreter enabled
> [    0.261959] ACPI: PM: (supports S0 S3 S4 S5)
> [    0.261962] ACPI: Using IOAPIC for interrupt routing
> [    0.262131] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
> [    0.262137] PCI: Using E820 reservations for host bridge windows
> [    0.263512] ACPI: \_SB_.PCI0.GPP4.WL00.WRST: New power resource
> [    0.263602] ACPI: \_SB_.PCI0.GPP6.P0NV: New power resource
> [    0.264612] ACPI: \_SB_.PCI0.GP17.XHC1.RHUB.HSP4.BTPR: New power resource
> [    0.269188] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
> [    0.269199] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
> [    0.269288] acpi PNP0A08:00: _OSC: platform does not support [SHPCHotplug AER LTR]
> [    0.269438] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME PCIeCapability]
> [    0.269451] acpi PNP0A08:00: [Firmware Info]: ECAM [mem 0xf8000000-0xfbffffff] for domain 0000 [bus 00-3f] only partially covers this bridge
> [    0.269745] PCI host bridge to bus 0000:00
> [    0.269753] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000effff window]
> [    0.269759] pci_bus 0000:00: root bus resource [mem 0xd0000000-0xf7ffffff window]
> [    0.269764] pci_bus 0000:00: root bus resource [mem 0xfc000000-0xfdffffff window]
> [    0.269768] pci_bus 0000:00: root bus resource [mem 0x430000000-0xffffffffff window]
> [    0.269773] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
> [    0.269778] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
> [    0.269782] pci_bus 0000:00: root bus resource [bus 00-ff]
> [    0.269800] pci 0000:00:00.0: [1022:1630] type 00 class 0x060000 conventional PCI endpoint
> [    0.269909] pci 0000:00:00.2: [1022:1631] type 00 class 0x080600 conventional PCI endpoint
> [    0.270019] pci 0000:00:01.0: [1022:1632] type 00 class 0x060000 conventional PCI endpoint
> [    0.270138] pci 0000:00:02.0: [1022:1632] type 00 class 0x060000 conventional PCI endpoint
> [    0.270255] pci 0000:00:02.2: [1022:1634] type 01 class 0x060400 PCIe Root Port
> [    0.270277] pci 0000:00:02.2: PCI bridge to [bus 01]
> [    0.270284] pci 0000:00:02.2:   bridge window [io  0x2000-0x2fff]
> [    0.270290] pci 0000:00:02.2:   bridge window [mem 0xfd500000-0xfd5fffff]
> [    0.270351] pci 0000:00:02.2: PME# supported from D0 D3hot D3cold
> [    0.270465] pci 0000:00:02.4: [1022:1634] type 01 class 0x060400 PCIe Root Port
> [    0.270486] pci 0000:00:02.4: PCI bridge to [bus 02]
> [    0.270494] pci 0000:00:02.4:   bridge window [mem 0xfd400000-0xfd4fffff]
> [    0.270554] pci 0000:00:02.4: PME# supported from D0 D3hot D3cold
> [    0.270672] pci 0000:00:08.0: [1022:1632] type 00 class 0x060000 conventional PCI endpoint
> [    0.270778] pci 0000:00:08.1: [1022:1635] type 01 class 0x060400 PCIe Root Port
> [    0.270798] pci 0000:00:08.1: PCI bridge to [bus 03]
> [    0.270805] pci 0000:00:08.1:   bridge window [io  0x1000-0x1fff]
> [    0.270810] pci 0000:00:08.1:   bridge window [mem 0xfd000000-0xfd3fffff]
> [    0.270820] pci 0000:00:08.1:   bridge window [mem 0x460000000-0x4701fffff 64bit pref]
> [    0.270831] pci 0000:00:08.1: enabling Extended Tags
> [    0.270876] pci 0000:00:08.1: PME# supported from D0 D3hot D3cold
> [    0.271034] pci 0000:00:14.0: [1022:790b] type 00 class 0x0c0500 conventional PCI endpoint
> [    0.271175] pci 0000:00:14.3: [1022:790e] type 00 class 0x060100 conventional PCI endpoint
> [    0.271346] pci 0000:00:18.0: [1022:166a] type 00 class 0x060000 conventional PCI endpoint
> [    0.271428] pci 0000:00:18.1: [1022:166b] type 00 class 0x060000 conventional PCI endpoint
> [    0.271510] pci 0000:00:18.2: [1022:166c] type 00 class 0x060000 conventional PCI endpoint
> [    0.271591] pci 0000:00:18.3: [1022:166d] type 00 class 0x060000 conventional PCI endpoint
> [    0.271677] pci 0000:00:18.4: [1022:166e] type 00 class 0x060000 conventional PCI endpoint
> [    0.271766] pci 0000:00:18.5: [1022:166f] type 00 class 0x060000 conventional PCI endpoint
> [    0.271848] pci 0000:00:18.6: [1022:1670] type 00 class 0x060000 conventional PCI endpoint
> [    0.271929] pci 0000:00:18.7: [1022:1671] type 00 class 0x060000 conventional PCI endpoint
> [    0.272091] pci 0000:01:00.0: [10ec:8852] type 00 class 0x028000 PCIe Endpoint
> [    0.272159] pci 0000:01:00.0: BAR 0 [io  0x2000-0x20ff]
> [    0.272169] pci 0000:01:00.0: BAR 2 [mem 0xfd500000-0xfd5fffff 64bit]
> [    0.272285] pci 0000:01:00.0: supports D1 D2
> [    0.272289] pci 0000:01:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> [    0.272501] pci 0000:00:02.2: PCI bridge to [bus 01]
> [    0.272791] pci 0000:02:00.0: [144d:a808] type 00 class 0x010802 PCIe Endpoint
> [    0.272837] pci 0000:02:00.0: BAR 0 [mem 0xfd400000-0xfd403fff 64bit]
> [    0.272983] pci 0000:02:00.0: 16.000 Gb/s available PCIe bandwidth, limited by 5.0 GT/s PCIe x4 link at 0000:00:02.4 (capable of 31.504 Gb/s with 8.0 GT/s PCIe x4 link)
> [    0.273326] pci 0000:00:02.4: PCI bridge to [bus 02]
> [    0.273424] pci 0000:03:00.0: [1002:1638] type 00 class 0x030000 PCIe Legacy Endpoint
> [    0.273458] pci 0000:03:00.0: BAR 0 [mem 0x460000000-0x46fffffff 64bit pref]
> [    0.273464] pci 0000:03:00.0: BAR 2 [mem 0x470000000-0x4701fffff 64bit pref]
> [    0.273470] pci 0000:03:00.0: BAR 4 [io  0x1000-0x10ff]
> [    0.273474] pci 0000:03:00.0: BAR 5 [mem 0xfd300000-0xfd37ffff]
> [    0.273483] pci 0000:03:00.0: enabling Extended Tags
> [    0.273550] pci 0000:03:00.0: PME# supported from D1 D2 D3hot D3cold
> [    0.273676] pci 0000:03:00.1: [1002:1637] type 00 class 0x040300 PCIe Legacy Endpoint
> [    0.273707] pci 0000:03:00.1: BAR 0 [mem 0xfd3c8000-0xfd3cbfff]
> [    0.273720] pci 0000:03:00.1: enabling Extended Tags
> [    0.273759] pci 0000:03:00.1: PME# supported from D1 D2 D3hot D3cold
> [    0.273855] pci 0000:03:00.2: [1022:15df] type 00 class 0x108000 PCIe Endpoint
> [    0.273887] pci 0000:03:00.2: BAR 2 [mem 0xfd200000-0xfd2fffff]
> [    0.273893] pci 0000:03:00.2: BAR 5 [mem 0xfd3cc000-0xfd3cdfff]
> [    0.273902] pci 0000:03:00.2: enabling Extended Tags
> [    0.274026] pci 0000:03:00.3: [1022:1639] type 00 class 0x0c0330 PCIe Endpoint
> [    0.274061] pci 0000:03:00.3: BAR 0 [mem 0xfd000000-0xfd0fffff 64bit]
> [    0.274073] pci 0000:03:00.3: enabling Extended Tags
> [    0.274114] pci 0000:03:00.3: PME# supported from D0 D3hot D3cold
> [    0.274217] pci 0000:03:00.4: [1022:1639] type 00 class 0x0c0330 PCIe Endpoint
> [    0.274250] pci 0000:03:00.4: BAR 0 [mem 0xfd100000-0xfd1fffff 64bit]
> [    0.274262] pci 0000:03:00.4: enabling Extended Tags
> [    0.274304] pci 0000:03:00.4: PME# supported from D0 D3hot D3cold
> [    0.274403] pci 0000:03:00.5: [1022:15e2] type 00 class 0x048000 PCIe Endpoint
> [    0.274434] pci 0000:03:00.5: BAR 0 [mem 0xfd380000-0xfd3bffff]
> [    0.274446] pci 0000:03:00.5: enabling Extended Tags
> [    0.274485] pci 0000:03:00.5: PME# supported from D0 D3hot D3cold
> [    0.274578] pci 0000:03:00.6: [1022:15e3] type 00 class 0x040300 PCIe Endpoint
> [    0.274609] pci 0000:03:00.6: BAR 0 [mem 0xfd3c0000-0xfd3c7fff]
> [    0.274622] pci 0000:03:00.6: enabling Extended Tags
> [    0.274660] pci 0000:03:00.6: PME# supported from D0 D3hot D3cold
> [    0.274798] pci 0000:00:08.1: PCI bridge to [bus 03]
> [    0.275169] ACPI: PCI: Interrupt link LNKA configured for IRQ 0
> [    0.275236] ACPI: PCI: Interrupt link LNKB configured for IRQ 0
> [    0.275286] ACPI: PCI: Interrupt link LNKC configured for IRQ 0
> [    0.275348] ACPI: PCI: Interrupt link LNKD configured for IRQ 0
> [    0.275405] ACPI: PCI: Interrupt link LNKE configured for IRQ 0
> [    0.275451] ACPI: PCI: Interrupt link LNKF configured for IRQ 0
> [    0.275497] ACPI: PCI: Interrupt link LNKG configured for IRQ 0
> [    0.275543] ACPI: PCI: Interrupt link LNKH configured for IRQ 0
> [    0.276807] ACPI: EC: interrupt unblocked
> [    0.276811] ACPI: EC: event unblocked
> [    0.276816] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
> [    0.276820] ACPI: EC: GPE=0x3
> [    0.276823] ACPI: \_SB_.PCI0.LPC0.EC0_: Boot DSDT EC initialization complete
> [    0.276827] ACPI: \_SB_.PCI0.LPC0.EC0_: EC: Used to handle transactions and events
> [    0.276888] iommu: Default domain type: Translated
> [    0.276892] iommu: DMA domain TLB invalidation policy: lazy mode
> [    0.276993] pps_core: LinuxPPS API ver. 1 registered
> [    0.276997] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
> [    0.277004] PTP clock support registered
> [    0.277074] EDAC MC: Ver: 3.0.0
> [    0.277353] efivars: Registered efivars operations
> [    0.277353] PCI: Using ACPI for IRQ routing
> [    0.279819] PCI: pci_cache_line_size set to 64 bytes
> [    0.280077] e820: reserve RAM buffer [mem 0x0009f000-0x0009ffff]
> [    0.280080] e820: reserve RAM buffer [mem 0x09c00000-0x0bffffff]
> [    0.280081] e820: reserve RAM buffer [mem 0x09f00000-0x0bffffff]
> [    0.280083] e820: reserve RAM buffer [mem 0xc303c000-0xc3ffffff]
> [    0.280084] e820: reserve RAM buffer [mem 0xc5926000-0xc7ffffff]
> [    0.280085] e820: reserve RAM buffer [mem 0xc717e000-0xc7ffffff]
> [    0.280087] e820: reserve RAM buffer [mem 0xce800000-0xcfffffff]
> [    0.280088] e820: reserve RAM buffer [mem 0x3ae300000-0x3afffffff]
> [    0.280131] pci 0000:03:00.0: vgaarb: setting as boot VGA device
> [    0.280131] pci 0000:03:00.0: vgaarb: bridge control possible
> [    0.280131] pci 0000:03:00.0: vgaarb: VGA device added: decodes=io+mem,owns=none,locks=none
> [    0.280131] vgaarb: loaded
> [    0.280131] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
> [    0.280131] hpet0: 3 comparators, 32-bit 14.318180 MHz counter
> [    0.282092] clocksource: Switched to clocksource tsc-early
> [    0.282228] VFS: Disk quotas dquot_6.6.0
> [    0.282239] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
> [    0.282288] pnp: PnP ACPI init
> [    0.282413] system 00:00: [mem 0xfec00000-0xfec01fff] could not be reserved
> [    0.282419] system 00:00: [mem 0xfee00000-0xfee00fff] has been reserved
> [    0.282424] system 00:00: [mem 0xf8000000-0xfbffffff] has been reserved
> [    0.282646] system 00:03: [io  0x0400-0x04cf] has been reserved
> [    0.282651] system 00:03: [io  0x04d0-0x04d1] has been reserved
> [    0.282655] system 00:03: [io  0x04d6] has been reserved
> [    0.282659] system 00:03: [io  0x0c00-0x0c01] has been reserved
> [    0.282664] system 00:03: [io  0x0c14] has been reserved
> [    0.282668] system 00:03: [io  0x0c50-0x0c52] has been reserved
> [    0.282672] system 00:03: [io  0x0c6c] has been reserved
> [    0.282676] system 00:03: [io  0x0c6f] has been reserved
> [    0.282680] system 00:03: [io  0x0cd0-0x0cdb] has been reserved
> [    0.282757] system 00:04: [mem 0x000e0000-0x000fffff] could not be reserved
> [    0.282763] system 00:04: [mem 0xff000000-0xffffffff] has been reserved
> [    0.282768] system 00:04: [mem 0xfec10000-0xfec1001f] has been reserved
> [    0.282772] system 00:04: [mem 0xfed00000-0xfed003ff] has been reserved
> [    0.282777] system 00:04: [mem 0xfed61000-0xfed613ff] has been reserved
> [    0.282782] system 00:04: [mem 0xfed80000-0xfed80fff] has been reserved
> [    0.283028] pnp: PnP ACPI: found 5 devices
> [    0.289103] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
> [    0.289205] NET: Registered PF_INET protocol family
> [    0.289385] IP idents hash table entries: 262144 (order: 9, 2097152 bytes, linear)
> [    0.299597] tcp_listen_portaddr_hash hash table entries: 8192 (order: 5, 131072 bytes, linear)
> [    0.299619] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
> [    0.299680] TCP established hash table entries: 131072 (order: 8, 1048576 bytes, linear)
> [    0.299877] TCP bind hash table entries: 65536 (order: 9, 2097152 bytes, linear)
> [    0.299969] TCP: Hash tables configured (established 131072 bind 65536)
> [    0.300070] MPTCP token hash table entries: 16384 (order: 6, 393216 bytes, linear)
> [    0.300125] UDP hash table entries: 8192 (order: 7, 524288 bytes, linear)
> [    0.300185] UDP-Lite hash table entries: 8192 (order: 7, 524288 bytes, linear)
> [    0.300255] NET: Registered PF_UNIX/PF_LOCAL protocol family
> [    0.300266] NET: Registered PF_XDP protocol family
> [    0.300276] pci 0000:00:02.2: PCI bridge to [bus 01]
> [    0.300282] pci 0000:00:02.2:   bridge window [io  0x2000-0x2fff]
> [    0.300288] pci 0000:00:02.2:   bridge window [mem 0xfd500000-0xfd5fffff]
> [    0.300296] pci 0000:00:02.4: PCI bridge to [bus 02]
> [    0.300301] pci 0000:00:02.4:   bridge window [mem 0xfd400000-0xfd4fffff]
> [    0.300310] pci 0000:00:08.1: PCI bridge to [bus 03]
> [    0.300314] pci 0000:00:08.1:   bridge window [io  0x1000-0x1fff]
> [    0.300320] pci 0000:00:08.1:   bridge window [mem 0xfd000000-0xfd3fffff]
> [    0.300325] pci 0000:00:08.1:   bridge window [mem 0x460000000-0x4701fffff 64bit pref]
> [    0.300333] pci_bus 0000:00: resource 4 [mem 0x000a0000-0x000effff window]
> [    0.300337] pci_bus 0000:00: resource 5 [mem 0xd0000000-0xf7ffffff window]
> [    0.300342] pci_bus 0000:00: resource 6 [mem 0xfc000000-0xfdffffff window]
> [    0.300346] pci_bus 0000:00: resource 7 [mem 0x430000000-0xffffffffff window]
> [    0.300351] pci_bus 0000:00: resource 8 [io  0x0000-0x0cf7 window]
> [    0.300355] pci_bus 0000:00: resource 9 [io  0x0d00-0xffff window]
> [    0.300359] pci_bus 0000:01: resource 0 [io  0x2000-0x2fff]
> [    0.300363] pci_bus 0000:01: resource 1 [mem 0xfd500000-0xfd5fffff]
> [    0.300367] pci_bus 0000:02: resource 1 [mem 0xfd400000-0xfd4fffff]
> [    0.300371] pci_bus 0000:03: resource 0 [io  0x1000-0x1fff]
> [    0.300375] pci_bus 0000:03: resource 1 [mem 0xfd000000-0xfd3fffff]
> [    0.300379] pci_bus 0000:03: resource 2 [mem 0x460000000-0x4701fffff 64bit pref]
> [    0.300703] pci 0000:03:00.1: D0 power state depends on 0000:03:00.0
> [    0.300712] pci 0000:03:00.3: extending delay after power-on from D3hot to 20 msec
> [    0.300937] pci 0000:03:00.4: extending delay after power-on from D3hot to 20 msec
> [    0.301031] PCI: CLS 32 bytes, default 64
> [    0.301052] pci 0000:00:00.2: AMD-Vi: IOMMU performance counters supported
> [    0.301090] Trying to unpack rootfs image as initramfs...
> [    0.301131] pci 0000:00:00.0: Adding to iommu group 0
> [    0.301155] pci 0000:00:01.0: Adding to iommu group 1
> [    0.301178] pci 0000:00:02.0: Adding to iommu group 2
> [    0.301195] pci 0000:00:02.2: Adding to iommu group 3
> [    0.301211] pci 0000:00:02.4: Adding to iommu group 4
> [    0.301235] pci 0000:00:08.0: Adding to iommu group 5
> [    0.301249] pci 0000:00:08.1: Adding to iommu group 5
> [    0.301274] pci 0000:00:14.0: Adding to iommu group 6
> [    0.301288] pci 0000:00:14.3: Adding to iommu group 6
> [    0.301339] pci 0000:00:18.0: Adding to iommu group 7
> [    0.301353] pci 0000:00:18.1: Adding to iommu group 7
> [    0.301368] pci 0000:00:18.2: Adding to iommu group 7
> [    0.301382] pci 0000:00:18.3: Adding to iommu group 7
> [    0.301397] pci 0000:00:18.4: Adding to iommu group 7
> [    0.301412] pci 0000:00:18.5: Adding to iommu group 7
> [    0.301426] pci 0000:00:18.6: Adding to iommu group 7
> [    0.301441] pci 0000:00:18.7: Adding to iommu group 7
> [    0.301457] pci 0000:01:00.0: Adding to iommu group 8
> [    0.301474] pci 0000:02:00.0: Adding to iommu group 9
> [    0.301488] pci 0000:03:00.0: Adding to iommu group 5
> [    0.301497] pci 0000:03:00.1: Adding to iommu group 5
> [    0.301505] pci 0000:03:00.2: Adding to iommu group 5
> [    0.301514] pci 0000:03:00.3: Adding to iommu group 5
> [    0.301522] pci 0000:03:00.4: Adding to iommu group 5
> [    0.301530] pci 0000:03:00.5: Adding to iommu group 5
> [    0.301539] pci 0000:03:00.6: Adding to iommu group 5
> [    0.302676] AMD-Vi: Extended features (0x206d73ef22254ade, 0x0): PPR X2APIC NX GT IA GA PC GA_vAPIC
> [    0.302689] AMD-Vi: Interrupt remapping enabled
> [    0.302692] AMD-Vi: X2APIC enabled
> [    0.557333] Freeing initrd memory: 88656K
> [    0.582458] AMD-Vi: Virtual APIC enabled
> [    0.582472] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
> [    0.582479] software IO TLB: mapped [mem 0x00000000bbd25000-0x00000000bfd25000] (64MB)
> [    0.582539] LVT offset 0 assigned for vector 0x400
> [    0.582686] perf: AMD IBS detected (0x000003ff)
> [    0.582699] perf/amd_iommu: Detected AMD IOMMU #0 (2 banks, 4 counters/bank).
> [    0.583825] Initialise system trusted keyrings
> [    0.583899] workingset: timestamp_bits=40 max_order=22 bucket_order=0
> [    0.592412] Key type asymmetric registered
> [    0.592416] Asymmetric key parser 'x509' registered
> [    0.592436] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 246)
> [    0.592474] io scheduler mq-deadline registered
> [    0.592478] io scheduler kyber registered
> [    0.592489] io scheduler bfq registered
> [    0.593709] pcieport 0000:00:02.2: PME: Signaling with IRQ 28
> [    0.593852] pcieport 0000:00:02.4: PME: Signaling with IRQ 29
> [    0.594012] pcieport 0000:00:08.1: PME: Signaling with IRQ 30
> [    0.594642] Monitor-Mwait will be used to enter C-1 state
> [    0.596668] Estimated ratio of average max frequency by base frequency (times 1024): 1226
> [    0.596697] ERST DBG: ERST support is disabled.
> [    0.596803] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
> [    0.600086] brd: module loaded
> [    0.600168] i8042: PNP: PS/2 Controller [PNP0303:KBC0] at 0x60,0x64 irq 1
> [    0.600175] i8042: PNP: PS/2 appears to have AUX port disabled, if this is incorrect please boot with i8042.nopnp
> [    0.602808] serio: i8042 KBD port at 0x60,0x64 irq 1
> [    0.602951] rtc_cmos 00:01: RTC can wake from S4
> [    0.603286] rtc_cmos 00:01: registered as rtc0
> [    0.603323] rtc_cmos 00:01: setting system clock to 2025-07-19T00:40:18 UTC (1752885618)
> [    0.603372] rtc_cmos 00:01: alarms up to one month, y3k, 114 bytes nvram
> [    0.604501] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input0
> [    0.604865] gre: GRE over IPv4 demultiplexor driver
> [    0.604895] NET: Registered PF_INET6 protocol family
> [    0.609478] Segment Routing with IPv6
> [    0.609497] In-situ OAM (IOAM) with IPv6
> [    0.609521] can: controller area network core
> [    0.609533] NET: Registered PF_CAN protocol family
> [    0.609570] Key type dns_resolver registered
> [    0.610894] microcode: Current revision: 0x0a50000b
> [    0.611196] resctrl: L3 allocation detected
> [    0.611200] resctrl: MB allocation detected
> [    0.611203] resctrl: L3 monitoring detected
> [    0.611228] IPI shorthand broadcast: enabled
> [    0.613259] sched_clock: Marking stable (612345939, 496876)->(629869745, -17026930)
> [    0.613417] registered taskstats version 1
> [    0.613581] Loading compiled-in X.509 certificates
> [    0.616012] Loaded X.509 cert 'Build time autogenerated kernel key: cd098da60231253ee2a3e4fce4706c3ed89cb023'
> [    0.618721] Demotion targets for Node 0: null
> [    0.618762] Key type .fscrypt registered
> [    0.618765] Key type fscrypt-provisioning registered
> [    0.621872] clk: Disabling unused clocks
> [    0.621878] PM: genpd: Disabling unused power domains
> [    0.623152] Freeing unused kernel image (initmem) memory: 3652K
> [    0.623246] Write protecting the kernel read-only data: 28672k
> [    0.623682] Freeing unused kernel image (text/rodata gap) memory: 1240K
> [    0.623971] Freeing unused kernel image (rodata/data gap) memory: 1916K
> [    0.623987] Run /init as init process
> [    0.623991]   with arguments:
> [    0.623992]     /init
> [    0.623994]   with environment:
> [    0.623995]     HOME=/
> [    0.623996]     TERM=linux
> [    0.623997]     kexec_load_disabled=0
> [    0.630307] Alpine Init 3.12.0-r1
> [    0.630368] Setting keymap fi-nodeadkeys.bmap.gz...
> [    0.638667] Setting keymap fi-nodeadkeys.bmap.gz: ok.
> [    0.638779] Loading boot drivers...
> [    0.644527] loop: module loaded
> [    0.668601] ACPI: bus type drm_connector registered
> [    0.681149] [drm] Initialized simpledrm 1.0.0 for simple-framebuffer.0 on minor 0
> [    0.689425] Console: switching to colour frame buffer device 180x56
> [    0.694766] simple-framebuffer simple-framebuffer.0: [drm] fb0: simpledrmdrmfb frame buffer device
> [    0.701394] Loading boot drivers: ok.
> [    0.702710] Mounting root...
> [    0.753008] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input1
> [    0.753281] ACPI: button: Lid Switch [LID]
> [    0.753389] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input2
> [    0.753519] ACPI: button: Power Button [PWRB]
> [    0.753628] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input3
> [    0.758225] ACPI: button: Power Button [PWRF]
> [    0.828352] ACPI: battery: Slot [BAT0] (battery present)
> [    0.840167] ACPI: video: Video Device [VGA] (multi-head: yes  rom: no  post: no)
> [    0.840518] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:04/LNXVIDEO:00/input/input4
> [    0.843104] Linux agpgart interface v0.103
> [    2.380958] tsc: Refined TSC clocksource calibration: 3193.991 MHz
> [    2.381005] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x2e0a1d90b63, max_idle_ns: 440795344833 ns
> [    2.381919] clocksource: Switched to clocksource tsc
> [    2.396781] [drm] amdgpu kernel modesetting enabled.
> [    2.399011] amdgpu: Virtual CRAT table created for CPU
> [    2.399118] amdgpu: Topology: Add CPU node
> [    2.399278] amdgpu 0000:03:00.0: enabling device (0006 -> 0007)
> [    2.399424] [drm] initializing kernel modesetting (RENOIR 0x1002:0x1638 0x17AA:0x3805 0xC5).
> [    2.476346] [drm] register mmio base: 0xFD300000
> [    2.476416] [drm] register mmio size: 524288
> [    2.481286] amdgpu 0000:03:00.0: amdgpu: detected ip block number 0 <soc15_common>
> [    2.481336] amdgpu 0000:03:00.0: amdgpu: detected ip block number 1 <gmc_v9_0>
> [    2.481399] amdgpu 0000:03:00.0: amdgpu: detected ip block number 2 <vega10_ih>
> [    2.481438] amdgpu 0000:03:00.0: amdgpu: detected ip block number 3 <psp>
> [    2.481473] amdgpu 0000:03:00.0: amdgpu: detected ip block number 4 <smu>
> [    2.481514] amdgpu 0000:03:00.0: amdgpu: detected ip block number 5 <dm>
> [    2.481558] amdgpu 0000:03:00.0: amdgpu: detected ip block number 6 <gfx_v9_0>
> [    2.483049] amdgpu 0000:03:00.0: amdgpu: detected ip block number 7 <sdma_v4_0>
> [    2.484099] amdgpu 0000:03:00.0: amdgpu: detected ip block number 8 <vcn_v2_0>
> [    2.485041] amdgpu 0000:03:00.0: amdgpu: detected ip block number 9 <jpeg_v2_0>
> [    2.485990] amdgpu 0000:03:00.0: amdgpu: Fetched VBIOS from VFCT
> [    2.487143] amdgpu: ATOM BIOS: 113-CEZANNE-017
> [    2.499685] Console: switching to colour dummy device 80x25
> [    2.517837] amdgpu 0000:03:00.0: vgaarb: deactivate vga console
> [    2.517849] amdgpu 0000:03:00.0: amdgpu: Trusted Memory Zone (TMZ) feature enabled
> [    2.517860] amdgpu 0000:03:00.0: amdgpu: MODE2 reset
> [    2.517966] [drm] vm size is 262144 GB, 4 levels, block size is 9-bit, fragment size is 9-bit
> [    2.517981] amdgpu 0000:03:00.0: amdgpu: VRAM: 2048M 0x000000F400000000 - 0x000000F47FFFFFFF (2048M used)
> [    2.517992] amdgpu 0000:03:00.0: amdgpu: GART: 1024M 0x0000000000000000 - 0x000000003FFFFFFF
> [    2.518006] [drm] Detected VRAM RAM=2048M, BAR=2048M
> [    2.518013] [drm] RAM width 128bits DDR4
> [    2.518227] [drm] amdgpu: 2048M of VRAM memory ready
> [    2.518235] [drm] amdgpu: 6912M of GTT memory ready.
> [    2.518261] [drm] GART: num cpu pages 262144, num gpu pages 262144
> [    2.518407] [drm] PCIE GART of 1024M enabled.
> [    2.518413] [drm] PTB located at 0x000000F47FC00000
> [    2.518830] [drm] Loading DMUB firmware via PSP: version=0x0101002B
> [    2.519373] amdgpu 0000:03:00.0: amdgpu: Found VCN firmware Version ENC: 1.24 DEC: 8 VEP: 0 Revision: 3
> [    3.234109] amdgpu 0000:03:00.0: amdgpu: reserve 0x400000 from 0xf47f400000 for PSP TMR
> [    3.319242] amdgpu 0000:03:00.0: amdgpu: RAS: optional ras ta ucode is not available
> [    3.329927] amdgpu 0000:03:00.0: amdgpu: RAP: optional rap ta ucode is not available
> [    3.329937] amdgpu 0000:03:00.0: amdgpu: SECUREDISPLAY: securedisplay ta ucode is not available
> [    3.330410] amdgpu 0000:03:00.0: amdgpu: SMU is initialized successfully!
> [    3.331548] [drm] Display Core v3.2.325 initialized on DCN 2.1
> [    3.331556] [drm] DP-HDMI FRL PCON supported
> [    3.332109] [drm] DMUB hardware initialized: version=0x0101002B
> [    3.443761] ACPI Warning: \_SB.PCI0.GP17.VGA.LCD._DDC: Return type mismatch - found Package, expected Integer/Buffer (20240827/nspredef-254)
> [    3.443910] amdgpu 0000:03:00.0: amdgpu: [drm] Using ACPI provided EDID for eDP-1
> [    3.694244] [drm] kiq ring mec 2 pipe 1 q 0
> [    3.700509] kfd kfd: amdgpu: Allocated 3969056 bytes on gart
> [    3.700529] kfd kfd: amdgpu: Total number of KFD nodes to be created: 1
> [    3.700683] amdgpu: Virtual CRAT table created for GPU
> [    3.700964] amdgpu: Topology: Add dGPU node [0x1638:0x1002]
> [    3.700970] kfd kfd: amdgpu: added device 1002:1638
> [    3.701011] amdgpu 0000:03:00.0: amdgpu: SE 1, SH per SE 1, CU per SH 8, active_cu_number 8
> [    3.701021] amdgpu 0000:03:00.0: amdgpu: ring gfx uses VM inv eng 0 on hub 0
> [    3.701028] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 1 on hub 0
> [    3.701035] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 4 on hub 0
> [    3.701042] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 5 on hub 0
> [    3.701048] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 6 on hub 0
> [    3.701055] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 7 on hub 0
> [    3.701062] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 8 on hub 0
> [    3.701068] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 9 on hub 0
> [    3.701075] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 10 on hub 0
> [    3.701082] amdgpu 0000:03:00.0: amdgpu: ring kiq_0.2.1.0 uses VM inv eng 11 on hub 0
> [    3.701089] amdgpu 0000:03:00.0: amdgpu: ring sdma0 uses VM inv eng 0 on hub 8
> [    3.701095] amdgpu 0000:03:00.0: amdgpu: ring vcn_dec uses VM inv eng 1 on hub 8
> [    3.701102] amdgpu 0000:03:00.0: amdgpu: ring vcn_enc0 uses VM inv eng 4 on hub 8
> [    3.701108] amdgpu 0000:03:00.0: amdgpu: ring vcn_enc1 uses VM inv eng 5 on hub 8
> [    3.701115] amdgpu 0000:03:00.0: amdgpu: ring jpeg_dec uses VM inv eng 6 on hub 8
> [    3.768646] amdgpu 0000:03:00.0: amdgpu: Runtime PM not available
> [    3.769113] amdgpu 0000:03:00.0: amdgpu: [drm] Using custom brightness curve
> [    3.769485] [drm] Initialized amdgpu 3.63.0 for 0000:03:00.0 on minor 1
> [    3.794448] fbcon: amdgpudrmfb (fb0) is primary device
> [    3.794839] [drm] pre_validate_dsc:1627 MST_DSC dsc precompute is not needed
> [    5.049680] backlight: 0
> [    5.049686] CPU: 3 UID: 0 PID: 688 Comm: nlplug-findfs Not tainted 6.15.7+ #8 PREEMPT(voluntary)
> [    5.049691] Hardware name: LENOVO 82N5/LNVNB161216, BIOS GZCN32WW 12/08/2022
> [    5.049693] Call Trace:
> [    5.049695]  <TASK>
> [    5.049696]  dump_stack_lvl+0x5d/0x90
> [    5.049704]  amdgpu_dm_backlight_set_level+0x3f/0x375 [amdgpu]
> [    5.050121]  ? srso_alias_return_thunk+0x5/0xfbef5
> [    5.050125]  ? srso_alias_return_thunk+0x5/0xfbef5
> [    5.050128]  ? drm_connector_list_iter_end+0x3c/0x60 [drm]
> [    5.050162]  amdgpu_dm_atomic_commit_tail.cold+0x112/0x206 [amdgpu]
> [    5.050487]  ? srso_alias_return_thunk+0x5/0xfbef5
> [    5.050490]  ? srso_alias_return_thunk+0x5/0xfbef5
> [    5.050493]  ? kfree+0x1c9/0x350
> [    5.050500]  ? srso_alias_return_thunk+0x5/0xfbef5
> [    5.050502]  ? dma_resv_get_fences+0xb1/0x2b0
> [    5.050511]  ? srso_alias_return_thunk+0x5/0xfbef5
> [    5.050513]  ? amdgpu_dm_plane_helper_prepare_fb+0x18c/0x2d0 [amdgpu]
> [    5.050843]  ? srso_alias_return_thunk+0x5/0xfbef5
> [    5.050846]  ? amdgpu_dm_plane_helper_prepare_fb+0x1df/0x2d0 [amdgpu]
> [    5.051159]  commit_tail+0x94/0x130 [drm_kms_helper]
> [    5.051170]  drm_atomic_helper_commit+0x126/0x150 [drm_kms_helper]
> [    5.051179]  drm_atomic_commit+0xb1/0xf0 [drm]
> [    5.051206]  ? __pfx___drm_printfn_info+0x10/0x10 [drm]
> [    5.051226]  drm_client_modeset_commit_atomic+0x209/0x250 [drm]
> [    5.051252]  drm_client_modeset_commit_locked+0x5a/0x170 [drm]
> [    5.051271]  ? srso_alias_return_thunk+0x5/0xfbef5
> [    5.051274]  drm_client_modeset_commit+0x25/0x50 [drm]
> [    5.051293]  __drm_fb_helper_restore_fbdev_mode_unlocked+0xa2/0xe0 [drm_kms_helper]
> [    5.051303]  drm_fb_helper_set_par+0x30/0x50 [drm_kms_helper]
> [    5.051311]  fbcon_init+0x29e/0x560
> [    5.051316]  visual_init+0xce/0x130
> [    5.051319]  do_bind_con_driver.isra.0+0x1f9/0x310
> [    5.051324]  do_take_over_console+0x16c/0x1a0
> [    5.051328]  do_fbcon_takeover+0x66/0xf0
> [    5.051331]  fbcon_fb_registered+0x4f/0x70
> [    5.051333]  do_register_framebuffer+0x190/0x270
> [    5.051339]  register_framebuffer+0x21/0x40
> [    5.051342]  __drm_fb_helper_initial_config_and_unlock+0x36b/0x4f0 [drm_kms_helper]
> [    5.051353]  drm_fbdev_client_hotplug+0x6b/0xa0 [drm_client_lib]
> [    5.051356]  ? srso_alias_return_thunk+0x5/0xfbef5
> [    5.051359]  drm_client_register+0x79/0xc0 [drm]
> [    5.051380]  drm_fbdev_client_setup+0xa8/0x17a [drm_client_lib]
> [    5.051383]  drm_client_setup+0x48/0x60 [drm_client_lib]
> [    5.051386]  amdgpu_pci_probe+0x304/0x470 [amdgpu]
> [    5.051589]  local_pci_probe+0x45/0x90
> [    5.051594]  pci_device_probe+0xd8/0x250
> [    5.051597]  ? srso_alias_return_thunk+0x5/0xfbef5
> [    5.051599]  ? sysfs_do_create_link_sd+0x6e/0xf0
> [    5.051604]  really_probe+0xde/0x350
> [    5.051608]  ? pm_runtime_barrier+0x54/0x90
> [    5.051612]  ? __pfx___driver_attach+0x10/0x10
> [    5.051615]  __driver_probe_device+0x78/0x120
> [    5.051619]  driver_probe_device+0x1f/0xa0
> [    5.051622]  __driver_attach+0xca/0x1e0
> [    5.051626]  bus_for_each_dev+0x8e/0xf0
> [    5.051630]  bus_add_driver+0x11d/0x200
> [    5.051634]  driver_register+0x72/0xe0
> [    5.051637]  ? __pfx_amdgpu_init+0x10/0x10 [amdgpu]
> [    5.051833]  do_one_initcall+0x5a/0x320
> [    5.051839]  do_init_module+0x60/0x240
> [    5.051843]  __do_sys_init_module+0x18a/0x1c0
> [    5.051850]  do_syscall_64+0x82/0x180
> [    5.051866]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [    5.051869] RIP: 0033:0x7f3f059b4a08
> [    5.051872] Code: 48 83 ec 08 89 d2 b8 45 01 00 00 0f 05 48 89 c7 e8 95 eb ff ff 48 83 c4 08 c3 e9 de 2d 01 00 48 83 ec 08 b8 af 00 00 00 0f 05 <48> 89 c7 e8 78 eb ff ff 48 83 c4 08 c3 48 83 ec 08 89 f6 b8 b0 00
> [    5.051874] RSP: 002b:00007fff30155530 EFLAGS: 00000206 ORIG_RAX: 00000000000000af
> [    5.051877] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f3f059b4a08
> [    5.051879] RDX: 00007f3f059320ff RSI: 0000000001d654b1 RDI: 00007f3efe160440
> [    5.051880] RBP: 00007f3f057b6e90 R08: 0000000000000062 R09: 0000000000000005
> [    5.051881] R10: 0000000000000002 R11: 0000000000000206 R12: 00007f3efe160440
> [    5.051882] R13: 0000000000020000 R14: 00007f3f059320ff R15: 0000000000000000
> [    5.051887]  </TASK>
> [    5.087594] Console: switching to colour frame buffer device 180x56
> [    5.153575] amdgpu 0000:03:00.0: [drm] fb0: amdgpudrmfb frame buffer device
> [    5.182340] nvme 0000:02:00.0: platform quirk: setting simple suspend
> [    5.183377] nvme nvme0: pci function 0000:02:00.0
> [    5.190866] nvme nvme0: missing or invalid SUBNQN field.
> [    5.191890] nvme nvme0: D3 entry latency set to 8 seconds
> [    5.209143] nvme nvme0: 16/0/0 default/read/poll queues
> [    5.214187]  nvme0n1: p1 p2
> [    5.228883] ACPI: bus type USB registered
> [    5.229732] usbcore: registered new interface driver usbfs
> [    5.230360] usbcore: registered new interface driver hub
> [    5.230906] usbcore: registered new device driver usb
> [    5.244672] xhci_hcd 0000:03:00.3: xHCI Host Controller
> [    5.245411] xhci_hcd 0000:03:00.3: new USB bus registered, assigned bus number 1
> [    5.246113] xhci_hcd 0000:03:00.3: hcc params 0x0268ffe5 hci version 0x110 quirks 0x0000020000000010
> [    5.246985] xhci_hcd 0000:03:00.3: xHCI Host Controller
> [    5.247486] xhci_hcd 0000:03:00.3: new USB bus registered, assigned bus number 2
> [    5.247998] xhci_hcd 0000:03:00.3: Host supports USB 3.1 Enhanced SuperSpeed
> [    5.248557] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.15
> [    5.249069] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    5.249570] usb usb1: Product: xHCI Host Controller
> [    5.250078] usb usb1: Manufacturer: Linux 6.15.7+ xhci-hcd
> [    5.250593] usb usb1: SerialNumber: 0000:03:00.3
> [    5.251241] hub 1-0:1.0: USB hub found
> [    5.251759] hub 1-0:1.0: 4 ports detected
> [    5.252462] usb usb2: We don't know the algorithms for LPM for this host, disabling LPM.
> [    5.253010] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 6.15
> [    5.253537] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    5.254042] usb usb2: Product: xHCI Host Controller
> [    5.254528] usb usb2: Manufacturer: Linux 6.15.7+ xhci-hcd
> [    5.255035] usb usb2: SerialNumber: 0000:03:00.3
> [    5.256469] hub 2-0:1.0: USB hub found
> [    5.257022] hub 2-0:1.0: 2 ports detected
> [    5.257770] xhci_hcd 0000:03:00.4: xHCI Host Controller
> [    5.258314] xhci_hcd 0000:03:00.4: new USB bus registered, assigned bus number 3
> [    5.258939] xhci_hcd 0000:03:00.4: hcc params 0x0268ffe5 hci version 0x110 quirks 0x0000020000000010
> [    5.259811] xhci_hcd 0000:03:00.4: xHCI Host Controller
> [    5.260383] xhci_hcd 0000:03:00.4: new USB bus registered, assigned bus number 4
> [    5.260940] xhci_hcd 0000:03:00.4: Host supports USB 3.1 Enhanced SuperSpeed
> [    5.261526] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.15
> [    5.262085] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    5.262650] usb usb3: Product: xHCI Host Controller
> [    5.263206] usb usb3: Manufacturer: Linux 6.15.7+ xhci-hcd
> [    5.263781] usb usb3: SerialNumber: 0000:03:00.4
> [    5.264579] hub 3-0:1.0: USB hub found
> [    5.265326] hub 3-0:1.0: 4 ports detected
> [    5.266170] usb usb4: We don't know the algorithms for LPM for this host, disabling LPM.
> [    5.266757] usb usb4: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 6.15
> [    5.267301] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    5.267834] usb usb4: Product: xHCI Host Controller
> [    5.268339] usb usb4: Manufacturer: Linux 6.15.7+ xhci-hcd
> [    5.268850] usb usb4: SerialNumber: 0000:03:00.4
> [    5.269490] hub 4-0:1.0: USB hub found
> [    5.270016] hub 4-0:1.0: 2 ports detected
> [    5.274072] piix4_smbus 0000:00:14.0: SMBus Host Controller at 0xb00, revision 0
> [    5.274798] piix4_smbus 0000:00:14.0: Using register 0x02 for SMBus port selection
> [    5.276564] piix4_smbus 0000:00:14.0: Auxiliary SMBus Host Controller at 0xb20
> [    5.277535] i2c i2c-11: Successfully instantiated SPD at 0x50
> [    5.278533] i2c i2c-11: Successfully instantiated SPD at 0x51
> [    5.320690] Mounting root: failed.
> [    5.486859] usb 1-3: new high-speed USB device number 2 using xhci_hcd
> [    5.503175] usb 3-1: new high-speed USB device number 2 using xhci_hcd
> [    5.626257] usb 1-3: New USB device found, idVendor=13d3, idProduct=5419, bcdDevice=20.03
> [    5.627886] usb 1-3: New USB device strings: Mfr=3, Product=1, SerialNumber=2
> [    5.628727] usb 1-3: Product: Integrated Camera
> [    5.629489] usb 1-3: Manufacturer: Azurewave
> [    5.630263] usb 1-3: SerialNumber: 0000
> [    5.633158] usb 3-1: New USB device found, idVendor=291a, idProduct=5423, bcdDevice= 0.0b
> [    5.634329] usb 3-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> [    5.635173] usb 3-1: Product: 4-Port USB 2.0 Hub
> [    5.635959] usb 3-1: Manufacturer: Generic
> [    5.677895] hub 3-1:1.0: USB hub found
> [    5.680441] hub 3-1:1.0: 5 ports detected
> [    5.743712] usb 4-1: new SuperSpeed Plus Gen 2x1 USB device number 2 using xhci_hcd
> [    5.768077] usb 4-1: New USB device found, idVendor=291a, idProduct=8383, bcdDevice= 0.0b
> [    5.769112] usb 4-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> [    5.769697] usb 4-1: Product: 4-Port USB 3.0 Hub
> [    5.770230] usb 4-1: Manufacturer: Generic
> [    5.790424] hub 4-1:1.0: USB hub found
> [    5.793074] hub 4-1:1.0: 4 ports detected
> [    5.878853] usb 3-4: new full-speed USB device number 3 using xhci_hcd
> [    6.032891] usb 3-4: New USB device found, idVendor=0bda, idProduct=4852, bcdDevice= 0.00
> [    6.034126] usb 3-4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [    6.034936] usb 3-4: Product: Bluetooth Radio
> [    6.035714] usb 3-4: Manufacturer: Realtek
> [    6.036474] usb 3-4: SerialNumber: 00e04c000001
> [    6.100818] usb 3-1.1: new high-speed USB device number 4 using xhci_hcd
> [    6.213550] usb 3-1.1: New USB device found, idVendor=0bda, idProduct=5411, bcdDevice= 1.01
> [    6.214820] usb 3-1.1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> [    6.215619] usb 3-1.1: Product: USB2.1 Hub
> [    6.216388] usb 3-1.1: Manufacturer: Generic
> [    6.254729] hub 3-1.1:1.0: USB hub found
> [    6.258156] hub 3-1.1:1.0: 5 ports detected
> [    6.286047] usb 4-1.1: new SuperSpeed USB device number 3 using xhci_hcd
> [    6.309966] usb 4-1.1: New USB device found, idVendor=0bda, idProduct=0411, bcdDevice= 1.01
> [    6.311010] usb 4-1.1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> [    6.311573] usb 4-1.1: Product: USB3.2 Hub
> [    6.312109] usb 4-1.1: Manufacturer: Generic
> [    6.350952] hub 4-1.1:1.0: USB hub found
> [    6.352416] hub 4-1.1:1.0: 4 ports detected
> [    6.431870] usb 3-1.5: new high-speed USB device number 5 using xhci_hcd
> [    6.533092] usb 3-1.5: New USB device found, idVendor=0bda, idProduct=5450, bcdDevice= 1.01
> [    6.534673] usb 3-1.5: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> [    6.535468] usb 3-1.5: Product: BillBoard Device
> [    6.536231] usb 3-1.5: Manufacturer: Realtek
> [    6.630908] usb 4-1.1.3: new SuperSpeed USB device number 4 using xhci_hcd
> [    6.652183] usb 4-1.1.3: New USB device found, idVendor=2537, idProduct=1081, bcdDevice= 1.00
> [    6.652932] usb 4-1.1.3: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [    6.653494] usb 4-1.1.3: Product: NS1081
> [    6.654019] usb 4-1.1.3: Manufacturer: Norelsys
> [    6.654526] usb 4-1.1.3: SerialNumber: 0123456789ABCDE
> [    6.734069] usb 4-1.1.4: new SuperSpeed USB device number 5 using xhci_hcd
> [    6.755623] usb 4-1.1.4: New USB device found, idVendor=0bda, idProduct=8153, bcdDevice=30.00
> [    6.756377] usb 4-1.1.4: New USB device strings: Mfr=1, Product=2, SerialNumber=6
> [    6.756925] usb 4-1.1.4: Product: USB 10/100/1000 LAN
> [    6.757444] usb 4-1.1.4: Manufacturer: Realtek
> [    6.757936] usb 4-1.1.4: SerialNumber: 000001
> [   16.584770] usbcore: registered new device driver r8152-cfgselector
> [   16.686373] r8152-cfgselector 4-1.1.4: reset SuperSpeed USB device number 5 using xhci_hcd
> [   16.753096] r8152 4-1.1.4:1.0: Direct firmware load for rtl_nic/rtl8153a-4.fw failed with error -2
> [   16.753930] r8152 4-1.1.4:1.0: unable to load firmware patch rtl_nic/rtl8153a-4.fw (-2)
> [   16.790337] r8152 4-1.1.4:1.0 eth0: v1.12.13
> [   16.791455] usbcore: registered new interface driver r8152
> [   20.206410] r8152 4-1.1.4:1.0 eth0: carrier on
> [   29.260158] NET: Registered PF_PACKET protocol family
> 
OK, I think we need to do two things to figure out what's going on.

1) Let's shift over to 6.16-rc6.  Once we've got a handle on the 
situation there we can iron out if there are other patches missing or 
this is also broken for you in 6.16.  If it's not working as expected 
there either we need it fixed there first anyway.

2) The starting brightness I don't expect to be "0".  We need to see 
what values were read out from the firmware. There is a debugging 
message we can catch if you boot with drm.debug=0x106.  Keep in mind you 
probably need to increase log_buf_len if your ring buffer is set too 
small too.

https://github.com/torvalds/linux/commit/4b61b8a390511a1864f26cc42bab72881e93468d

PS: I would rather you add logs into a gist, pastebin or a bug somewhere 
if you can.

