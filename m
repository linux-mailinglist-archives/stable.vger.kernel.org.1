Return-Path: <stable+bounces-36069-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98FE2899A13
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 11:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA05F1F22906
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 09:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE2616089C;
	Fri,  5 Apr 2024 09:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stwm.de header.i=@stwm.de header.b="PmPdsqso"
X-Original-To: stable@vger.kernel.org
Received: from email.studentenwerk.mhn.de (dresden.studentenwerk.mhn.de [141.84.225.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D362816130E
	for <stable@vger.kernel.org>; Fri,  5 Apr 2024 09:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.84.225.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712310943; cv=none; b=cVnGAMluyqHygziOxdUqMgcmJGZdPFq7LON2SNKqVyXV0ztyeIjXVcMPHAcvoEmt1W630sUA8WxgR0AFLWlqOj/c3THajVQypOmzsxSa45bj4YxE1RM6yd5NCRNcE0QPFlJmII2Yhgm+d95eiJ/k7/4gjl/hiaDJsM+UL6d4bT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712310943; c=relaxed/simple;
	bh=1QXChg8y4u1/YnRQEZMkKHy9tgRmcv8fD/uE+18p/Y8=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=PuzxT4OTzrA7InPwfMQZwfIW+FT1ymNSwRY5YcBaYpaMO9WMtxaKc+K4TkSQjMbjKZLNhEwVAxTHiUnXOJ2hG+Wk6VhMi9QDj9Ukv7Z3PL03ubywB/XsaR+0mHw5aO/hkJjasm8mJBNbauQm3A67q9kCD6FJObd1RKNEP7PMUVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stwm.de; spf=none smtp.mailfrom=stwm.de; dkim=pass (2048-bit key) header.d=stwm.de header.i=@stwm.de header.b=PmPdsqso; arc=none smtp.client-ip=141.84.225.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stwm.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=stwm.de
Received: from mailhub.studentenwerk.mhn.de (mailhub.studentenwerk.mhn.de [127.0.0.1])
	by email.studentenwerk.mhn.de (Postfix) with ESMTPS id 4V9v4M6CYdzRhTC;
	Fri,  5 Apr 2024 11:55:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwm.de; s=stwm-20170627;
	t=1712310931;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jaHOk/bD1HdWqqs2D7HDfxauzI8ZSXX25FdL47ql5I4=;
	b=PmPdsqsogB8l2+L43g+vnbdx9MKoVwtLi5HFFN6zEFlA5fQmtR3cQ4dR8NthGBAR0teQPc
	cWVig7CJ5zRJ+d+otSNTfybPgVWrEZb7gaxKFZpriyk9r1r4mw8F8hRMFiJCgnBvvGLPtY
	tfKJ5rbixu6jwqNL2OfC0Igz9HRts85ynGY+JUYLsdN4mEVHgAbtQ77Yxlo7ughcOGQMmQ
	rp9UQNOW01VOg2XYYEYzdfQu+CdXFRMHSVwOuHiZrW3+BRq9d75s+g8FLqzxSDs0CYbS9m
	u3F/+NbJyp/yC5e2DsUEeCxmm93tXFX70TRrXBjy9pWBjFIXbZr1/RmZ0OFLLw==
Received: from roundcube.studentenwerk.mhn.de (roundcube.studentenwerk.mhn.de [10.148.7.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mailhub.studentenwerk.mhn.de (Postfix) with ESMTPS id 4V9v4M640RzHnGf;
	Fri,  5 Apr 2024 11:55:31 +0200 (CEST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 05 Apr 2024 11:55:31 +0200
From: Wolfgang Walter <linux@stwm.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Subject: Re: stable v6.6.24 regression: boot fails: bisected to "x86/mpparse:
 Register APIC address only once"
In-Reply-To: <874jcg9msa.ffs@tglx>
References: <23da7f59519df267035b204622d32770@stwm.de>
 <2024040445-promotion-lumpiness-c6c8@gregkh> <874jcg9msa.ffs@tglx>
Message-ID: <1dda81aaf442ad83adf9d0f8a1dbed04@stwm.de>
X-Sender: linux@stwm.de
Organization: =?UTF-8?Q?Studierendenwerk_M=C3=BCnchen_Oberbayern?=
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit

Hello Thomas!

Am 2024-04-05 11:33, schrieb Thomas Gleixner:
> On Thu, Apr 04 2024 at 17:57, Greg Kroah-Hartman wrote:
>> On Thu, Apr 04, 2024 at 02:07:11PM +0200, Wolfgang Walter wrote:
>>> Reverting this commit in v6.6.24 solves the problem.
>> 
>> Is this also an issue in 6.9-rc1 or newer or 6.8.3 or newer?
> 
> Also can you please provide the boot dmesg from a working kernel?
> 
> Thanks,
> 
>         tglx

here is the output of dmesg after booting 6.6.24 with the one patch 
reverted:


[    0.000000] Linux version 6.6.24-genrouter32.pm+2.19 (root@sid-i386) 
(gcc (Debian 13.2.0-23) 13.2.0, GNU ld (GNU Binutils for Debian) 2.42) 
#1 PREEMPT_DYNAMIC Thu Apr  4 13:44:40 CEST 2024
[    0.000000] Disabled fast string operations
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] 
usable
[    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] 
reserved
[    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] 
reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000003fefffff] 
usable
[    0.000000] BIOS-e820: [mem 0x00000000e0000000-0x00000000efffffff] 
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed13000-0x00000000fed19fff] 
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed1c000-0x00000000fed1ffff] 
reserved
[    0.000000] BIOS-e820: [mem 0x00000000ffb00000-0x00000000ffffffff] 
reserved
[    0.000000] Notice: NX (Execute Disable) protection cannot be 
enabled: non-PAE kernel!
[    0.000000] APIC: Static calls initialized
[    0.000000] SMBIOS 2.3 present.
[    0.000000] DMI: To Be Filled By O.E.M. To Be Filled By O.E.M./To be 
filled by O.E.M., BIOS 080012  10/16/2008
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 1000.027 MHz processor
[    0.011020] e820: update [mem 0x00000000-0x00000fff] usable ==> 
reserved
[    0.011031] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.011047] last_pfn = 0x3ff00 max_arch_pfn = 0x100000
[    0.011063] MTRR map: 7 entries (5 fixed + 2 variable; max 21), built 
from 8 variable MTRRs
[    0.011069] x86/PAT: PAT not supported by the CPU.
[    0.011074] x86/PAT: Configuration [0-7]: WB  WT  UC- UC  WB  WT  UC- 
UC
[    0.011250] Warning only 887MB will be used.
[    0.011254] Use a HIGHMEM enabled kernel.
[    0.024603] found SMP MP-table at [mem 0x000ff780-0x000ff78f]
[    0.024628] initial memory mapped: [mem 0x00000000-0x023fffff]
[    0.024715] RAMDISK: [mem 0x3a593000-0x3fefffff]
[    0.024720] Allocated new RAMDISK: [mem 0x31e91000-0x377fd9c6]
[    0.189769] Move RAMDISK from [mem 0x3a593000-0x3feff9c6] to [mem 
0x31e91000-0x377fd9c6]
[    0.189796] ACPI: Early table checksum verification disabled
[    0.190798] ACPI BIOS Error (bug): A valid RSDP was not found 
(20230628/tbxfroot-222)
[    0.190822] 887MB LOWMEM available.
[    0.190825]   mapped low ram: 0 - 377fe000
[    0.190828]   low ram: 0 - 377fe000
[    0.190857] Zone ranges:
[    0.190858]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.190864]   Normal   [mem 0x0000000001000000-0x00000000377fdfff]
[    0.190870] Movable zone start for each node
[    0.190872] Early memory node ranges
[    0.190873]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.190879]   node   0: [mem 0x0000000000100000-0x000000003fefffff]
[    0.190884] Initmem setup node 0 [mem 
0x0000000000001000-0x000000003fefffff]
[    0.190914] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.191188] On node 0, zone DMA: 97 pages in unavailable ranges
[    0.206473] On node 0, zone Normal: 2 pages in unavailable ranges
[    0.206499] Reserving Intel graphics memory at [mem 
0x3ff00000-0x3fffffff]
[    0.206783] Intel MultiProcessor Specification v1.4
[    0.206786]     Virtual Wire compatibility mode.
[    0.206792] MPTABLE: OEM ID: Intel
[    0.206794] MPTABLE: Product ID: Alviso
[    0.206796] MPTABLE: APIC at: 0xFEE00000
[    0.206805] Processor #0 (Bootup-CPU)
[    0.206818] IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, GSI 
0-23
[    0.206833] Processors: 1
[    0.206865] [mem 0x40000000-0xdfffffff] available for PCI devices
[    0.206876] clocksource: refined-jiffies: mask: 0xffffffff 
max_cycles: 0xffffffff, max_idle_ns: 6370452778343963 ns
[    0.206955] pcpu-alloc: s0 r0 d32768 u32768 alloc=1*32768
[    0.206969] pcpu-alloc: [0] 0
[    0.206998] Kernel command line: BOOT_IMAGE=kernel initrd=system.gz 
init=/sbin/init ipv6.disable=1 dummy.numdummies=16 ide-core.nodma=1.0 
iommu=pt libata.dma=3 random.trust_cpu=on reboot=cold,force retbleed=off 
rootfstype=ramfs
[    0.207970] Unknown kernel command line parameters 
"BOOT_IMAGE=kernel", will be passed to user space.
[    0.208454] Dentry cache hash table entries: 131072 (order: 7, 524288 
bytes, linear)
[    0.208743] Inode-cache hash table entries: 65536 (order: 6, 262144 
bytes, linear)
[    0.208817] Built 1 zonelists, mobility grouping on.  Total pages: 
225008
[    0.208827] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.224800] Checking if this processor honours the WP bit even in 
supervisor mode...Ok.
[    0.224824] Memory: 789268K/908912K available (12924K kernel code, 
734K rwdata, 3016K rodata, 640K init, 272K bss, 119644K reserved, 0K 
cma-reserved)
[    0.272716] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=1, 
Nodes=1
[    0.274031] Dynamic Preempt: full
[    0.274441] rcu: Preemptible hierarchical RCU implementation.
[    0.274446] 	Trampoline variant of Tasks RCU enabled.
[    0.274448] 	Tracing variant of Tasks RCU enabled.
[    0.274451] rcu: RCU calculated value of scheduler-enlistment delay 
is 30 jiffies.
[    0.274474] NR_IRQS: 2304, nr_irqs: 48, preallocated irqs: 16
[    0.274818] rcu: srcu_init: Setting srcu_struct sizes based on 
contention.
[    0.279294] Console: colour VGA+ 80x25
[    0.279304] printk: console [tty0] enabled
[    0.284538] APIC: Switch to symmetric I/O mode setup
[    0.284675] ExtINT not setup in hardware but reported by MP table
[    0.285172] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=0 pin2=0
[    0.301203] clocksource: tsc-early: mask: 0xffffffffffffffff 
max_cycles: 0xe6a309e20b, max_idle_ns: 440795251594 ns
[    0.301330] Calibrating delay loop (skipped), value calculated using 
timer frequency.. 2000.38 BogoMIPS (lpj=3333423)
[    0.301454] Disabled fast string operations
[    0.301543] CPU0: Thermal monitoring enabled (TM1)
[    0.301653] Last level iTLB entries: 4KB 128, 2MB 0, 4MB 2
[    0.301724] Last level dTLB entries: 4KB 128, 2MB 0, 4MB 8, 1GB 0
[    0.301801] CPU: Intel(R) Celeron(R) M processor         1.00GHz 
(family: 0x6, model: 0xd, stepping: 0x8)
[    0.301908] Spectre V1 : Mitigation: usercopy/swapgs barriers and 
__user pointer sanitization
[    0.302009] Spectre V2 : Mitigation: Retpolines
[    0.302073] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling 
RSB on context switch
[    0.302167] Spectre V2 : Spectre v2 / SpectreRSB : Filling RSB on 
VMEXIT
[    0.302257] Speculative Store Bypass: Vulnerable
[    0.302321] L1TF: Kernel not compiled for PAE. No mitigation for L1TF
[    0.302391] MDS: Vulnerable: Clear CPU buffers attempted, no 
microcode
[    0.302482] MMIO Stale Data: Unknown: No mitigations
[    0.302551] x86/fpu: x87 FPU will use FXSAVE
[    0.303967] pid_max: default: 32768 minimum: 301
[    0.310878] Mount-cache hash table entries: 2048 (order: 1, 8192 
bytes, linear)
[    0.310983] Mountpoint-cache hash table entries: 2048 (order: 1, 8192 
bytes, linear)
[    0.317030] RCU Tasks: Setting shift to 0 and lim to 1 
rcu_task_cb_adjust=1.
[    0.317213] RCU Tasks Trace: Setting shift to 0 and lim to 1 
rcu_task_cb_adjust=1.
[    0.317365] Performance Events: p6 PMU driver.
[    0.317442] ... version:                0
[    0.317506] ... bit width:              32
[    0.317568] ... generic registers:      2
[    0.317630] ... value mask:             00000000ffffffff
[    0.317697] ... max period:             000000007fffffff
[    0.317764] ... fixed-purpose events:   0
[    0.317826] ... event mask:             0000000000000003
[    0.318055] signal: max sigframe size: 1440
[    0.318218] rcu: Hierarchical SRCU implementation.
[    0.318286] rcu: 	Max phase no-delay instances is 1000.
[    0.532964] devtmpfs: initialized
[    0.534649] clocksource: jiffies: mask: 0xffffffff max_cycles: 
0xffffffff, max_idle_ns: 6370867519511994 ns
[    0.534649] futex hash table entries: 256 (order: -1, 3072 bytes, 
linear)
[    0.536674] pinctrl core: initialized pinctrl subsystem
[    0.537989] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.539307] thermal_sys: Registered thermal governor 'fair_share'
[    0.539314] thermal_sys: Registered thermal governor 'bang_bang'
[    0.539387] thermal_sys: Registered thermal governor 'step_wise'
[    0.539455] thermal_sys: Registered thermal governor 'user_space'
[    0.539570] cpuidle: using governor ladder
[    0.542249] PCI: PCI BIOS revision 3.00 entry at 0xf0031, last bus=5
[    0.542330] PCI: Using configuration type 1 for base access
[    0.544781] cryptd: max_cpu_qlen set to 1000
[    0.547865] ACPI: Interpreter disabled.
[    0.548015] iommu: Default domain type: Passthrough (set via kernel 
command line)
[    0.548511] SCSI subsystem initialized
[    0.548741] libata version 3.00 loaded.
[    0.548905] usbcore: registered new interface driver usbfs
[    0.548996] usbcore: registered new interface driver hub
[    0.549083] usbcore: registered new device driver usb
[    0.549268] pps_core: LinuxPPS API ver. 1 registered
[    0.549336] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 
Rodolfo Giometti <giometti@linux.it>
[    0.549443] PTP clock support registered
[    0.549535] EDAC MC: Ver: 3.0.0
[    0.550594] PCI: Probing PCI hardware
[    0.550666] PCI: root bus 00: using default resources
[    0.550671] PCI: Probing PCI hardware (bus 00)
[    0.550720] PCI host bridge to bus 0000:00
[    0.550789] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
[    0.550864] pci_bus 0000:00: root bus resource [mem 
0x00000000-0xffffffff]
[    0.550958] pci_bus 0000:00: No busn resource found for root bus, 
will use [bus 00-ff]
[    0.551076] pci 0000:00:00.0: [8086:2590] type 00 class 0x060000
[    0.551362] pci 0000:00:02.0: [8086:2592] type 00 class 0x030000
[    0.551449] pci 0000:00:02.0: reg 0x10: [mem 0xfe680000-0xfe6fffff]
[    0.551527] pci 0000:00:02.0: reg 0x14: [io  0x9c00-0x9c07]
[    0.551603] pci 0000:00:02.0: reg 0x18: [mem 0xd0000000-0xdfffffff 
pref]
[    0.554659] pci 0000:00:02.0: reg 0x1c: [mem 0xfe640000-0xfe67ffff]
[    0.554758] pci 0000:00:02.0: Video device with shadowed ROM at [mem 
0x000c0000-0x000dffff]
[    0.554961] pci 0000:00:02.1: [8086:2792] type 00 class 0x038000
[    0.555047] pci 0000:00:02.1: reg 0x10: [mem 0xfe580000-0xfe5fffff]
[    0.555311] pci 0000:00:1c.0: [8086:2660] type 01 class 0x060400
[    0.555434] pci 0000:00:1c.0: enabling Extended Tags
[    0.555547] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.555759] pci 0000:00:1c.1: [8086:2662] type 01 class 0x060400
[    0.555880] pci 0000:00:1c.1: enabling Extended Tags
[    0.555992] pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
[    0.556170] pci 0000:00:1c.2: [8086:2664] type 01 class 0x060400
[    0.556290] pci 0000:00:1c.2: enabling Extended Tags
[    0.556400] pci 0000:00:1c.2: PME# supported from D0 D3hot D3cold
[    0.556593] pci 0000:00:1c.3: [8086:2666] type 01 class 0x060400
[    0.556713] pci 0000:00:1c.3: enabling Extended Tags
[    0.556824] pci 0000:00:1c.3: PME# supported from D0 D3hot D3cold
[    0.557018] pci 0000:00:1d.0: [8086:2658] type 00 class 0x0c0300
[    0.557140] pci 0000:00:1d.0: reg 0x20: [io  0x9880-0x989f]
[    0.557333] pci 0000:00:1d.7: [8086:265c] type 00 class 0x0c0320
[    0.557424] pci 0000:00:1d.7: reg 0x10: [mem 0xfe63bc00-0xfe63bfff]
[    0.558142] pci 0000:00:1d.7: PME# supported from D0 D3hot D3cold
[    0.558333] pci 0000:00:1e.0: [8086:2448] type 01 class 0x060401
[    0.558556] pci 0000:00:1f.0: [8086:2641] type 00 class 0x060100
[    0.558721] pci 0000:00:1f.0: Force enabled HPET at 0xfed00000
[    0.558734] pci 0000:00:1f.0: quirk: [io  0x0800-0x087f] claimed by 
ICH6 ACPI/GPIO/TCO
[    0.558835] pci 0000:00:1f.0: quirk: [io  0x0480-0x04bf] claimed by 
ICH6 GPIO
[    0.558932] pci 0000:00:1f.0: LPC Generic IO decode 2 PIO at 
0a00-0a0f
[    0.559142] pci 0000:00:1f.1: [8086:266f] type 00 class 0x01018a
[    0.559234] pci 0000:00:1f.1: reg 0x10: [io  0x0000-0x0007]
[    0.559314] pci 0000:00:1f.1: reg 0x14: [io  0x0000-0x0003]
[    0.559391] pci 0000:00:1f.1: reg 0x18: [io  0x0000-0x0007]
[    0.559468] pci 0000:00:1f.1: reg 0x1c: [io  0x0000-0x0003]
[    0.559546] pci 0000:00:1f.1: reg 0x20: [io  0xffa0-0xffaf]
[    0.559636] pci 0000:00:1f.1: legacy IDE quirk: reg 0x10: [io  
0x01f0-0x01f7]
[    0.559730] pci 0000:00:1f.1: legacy IDE quirk: reg 0x14: [io  
0x03f6]
[    0.559822] pci 0000:00:1f.1: legacy IDE quirk: reg 0x18: [io  
0x0170-0x0177]
[    0.559917] pci 0000:00:1f.1: legacy IDE quirk: reg 0x1c: [io  
0x0376]
[    0.560131] pci 0000:00:1f.2: [8086:2653] type 00 class 0x01018f
[    0.560220] pci 0000:00:1f.2: reg 0x10: [io  0x9800-0x9807]
[    0.560298] pci 0000:00:1f.2: reg 0x14: [io  0x9480-0x9483]
[    0.560375] pci 0000:00:1f.2: reg 0x18: [io  0x9400-0x9407]
[    0.560452] pci 0000:00:1f.2: reg 0x1c: [io  0x9080-0x9083]
[    0.560529] pci 0000:00:1f.2: reg 0x20: [io  0x9000-0x900f]
[    0.560605] pci 0000:00:1f.2: reg 0x24: [mem 0xfe63b800-0xfe63bbff]
[    0.560712] pci 0000:00:1f.2: PME# supported from D3hot
[    0.560871] pci 0000:00:1f.3: [8086:266a] type 00 class 0x0c0500
[    0.561003] pci 0000:00:1f.3: reg 0x20: [io  0x0400-0x041f]
[    0.561289] pci 0000:01:00.0: [8086:109a] type 00 class 0x020000
[    0.561352] pci 0000:01:00.0: reg 0x10: [mem 0xfe7e0000-0xfe7fffff]
[    0.561459] pci 0000:01:00.0: reg 0x18: [io  0xac00-0xac1f]
[    0.561683] pci 0000:01:00.0: PME# supported from D0 D3hot
[    0.561870] pci 0000:01:00.0: disabling ASPM on pre-1.1 PCIe device.  
You can enable it with 'pcie_aspm=force'
[    0.561995] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    0.562067] pci 0000:00:1c.0:   bridge window [io  0xa000-0xafff]
[    0.562141] pci 0000:00:1c.0:   bridge window [mem 
0xfe700000-0xfe7fffff]
[    0.562366] pci 0000:02:00.0: [8086:109a] type 00 class 0x020000
[    0.562473] pci 0000:02:00.0: reg 0x10: [mem 0xfe8e0000-0xfe8fffff]
[    0.562579] pci 0000:02:00.0: reg 0x18: [io  0xbc00-0xbc1f]
[    0.562801] pci 0000:02:00.0: PME# supported from D0 D3hot
[    0.563008] pci 0000:02:00.0: disabling ASPM on pre-1.1 PCIe device.  
You can enable it with 'pcie_aspm=force'
[    0.563133] pci 0000:00:1c.1: PCI bridge to [bus 02]
[    0.563204] pci 0000:00:1c.1:   bridge window [io  0xb000-0xbfff]
[    0.563277] pci 0000:00:1c.1:   bridge window [mem 
0xfe800000-0xfe8fffff]
[    0.563465] pci 0000:03:00.0: [8086:109a] type 00 class 0x020000
[    0.563571] pci 0000:03:00.0: reg 0x10: [mem 0xfe9e0000-0xfe9fffff]
[    0.563676] pci 0000:03:00.0: reg 0x18: [io  0xcc00-0xcc1f]
[    0.563900] pci 0000:03:00.0: PME# supported from D0 D3hot
[    0.564102] pci 0000:03:00.0: disabling ASPM on pre-1.1 PCIe device.  
You can enable it with 'pcie_aspm=force'
[    0.564226] pci 0000:00:1c.2: PCI bridge to [bus 03]
[    0.564297] pci 0000:00:1c.2:   bridge window [io  0xc000-0xcfff]
[    0.564369] pci 0000:00:1c.2:   bridge window [mem 
0xfe900000-0xfe9fffff]
[    0.564556] pci 0000:04:00.0: [8086:109a] type 00 class 0x020000
[    0.564684] pci 0000:04:00.0: reg 0x10: [mem 0xfeae0000-0xfeafffff]
[    0.564791] pci 0000:04:00.0: reg 0x18: [io  0xdc00-0xdc1f]
[    0.565014] pci 0000:04:00.0: PME# supported from D0 D3hot
[    0.565224] pci 0000:04:00.0: disabling ASPM on pre-1.1 PCIe device.  
You can enable it with 'pcie_aspm=force'
[    0.565349] pci 0000:00:1c.3: PCI bridge to [bus 04]
[    0.565420] pci 0000:00:1c.3:   bridge window [io  0xd000-0xdfff]
[    0.565493] pci 0000:00:1c.3:   bridge window [mem 
0xfea00000-0xfeafffff]
[    0.565612] pci_bus 0000:05: extended config space not accessible
[    0.565729] pci 0000:05:02.0: [8086:1229] type 00 class 0x020000
[    0.565820] pci 0000:05:02.0: reg 0x10: [mem 0xfebff000-0xfebfffff]
[    0.565901] pci 0000:05:02.0: reg 0x14: [io  0xec00-0xec3f]
[    0.565980] pci 0000:05:02.0: reg 0x18: [mem 0xfebc0000-0xfebdffff]
[    0.566086] pci 0000:05:02.0: reg 0x30: [mem 0xfebe0000-0xfebeffff 
pref]
[    0.566213] pci 0000:05:02.0: supports D1 D2
[    0.566278] pci 0000:05:02.0: PME# supported from D0 D1 D2 D3hot 
D3cold
[    0.566485] pci 0000:05:03.0: [8086:1229] type 00 class 0x020000
[    0.566577] pci 0000:05:03.0: reg 0x10: [mem 0xfebfe000-0xfebfefff]
[    0.566659] pci 0000:05:03.0: reg 0x14: [io  0xe880-0xe8bf]
[    0.566737] pci 0000:05:03.0: reg 0x18: [mem 0xfeba0000-0xfebbffff]
[    0.566844] pci 0000:05:03.0: reg 0x30: [mem 0xfeb90000-0xfeb9ffff 
pref]
[    0.566967] pci 0000:05:03.0: supports D1 D2
[    0.567032] pci 0000:05:03.0: PME# supported from D0 D1 D2 D3hot 
D3cold
[    0.567232] pci 0000:05:04.0: [8086:1229] type 00 class 0x020000
[    0.567324] pci 0000:05:04.0: reg 0x10: [mem 0xfebfd000-0xfebfdfff]
[    0.567406] pci 0000:05:04.0: reg 0x14: [io  0xe800-0xe83f]
[    0.567484] pci 0000:05:04.0: reg 0x18: [mem 0xfeb60000-0xfeb7ffff]
[    0.567590] pci 0000:05:04.0: reg 0x30: [mem 0xfeb80000-0xfeb8ffff 
pref]
[    0.567713] pci 0000:05:04.0: supports D1 D2
[    0.567778] pci 0000:05:04.0: PME# supported from D0 D1 D2 D3hot 
D3cold
[    0.568054] pci 0000:05:05.0: [8086:1229] type 00 class 0x020000
[    0.568146] pci 0000:05:05.0: reg 0x10: [mem 0xfebfc000-0xfebfcfff]
[    0.568228] pci 0000:05:05.0: reg 0x14: [io  0xe480-0xe4bf]
[    0.568306] pci 0000:05:05.0: reg 0x18: [mem 0xfeb40000-0xfeb5ffff]
[    0.568413] pci 0000:05:05.0: reg 0x30: [mem 0xfeb30000-0xfeb3ffff 
pref]
[    0.568537] pci 0000:05:05.0: supports D1 D2
[    0.568602] pci 0000:05:05.0: PME# supported from D0 D1 D2 D3hot 
D3cold
[    0.568836] pci 0000:00:1e.0: PCI bridge to [bus 05] (subtractive 
decode)
[    0.568935] pci 0000:00:1e.0:   bridge window [io  0xe000-0xefff]
[    0.569008] pci 0000:00:1e.0:   bridge window [mem 
0xfeb00000-0xfebfffff]
[    0.569105] pci 0000:00:1e.0:   bridge window [io  0x0000-0xffff] 
(subtractive decode)
[    0.569202] pci 0000:00:1e.0:   bridge window [mem 
0x00000000-0xffffffff] (subtractive decode)
[    0.569330] pci_bus 0000:00: busn_res: [bus 00-ff] end is updated to 
05
[    0.569488] pci 0000:00:1f.0: PIIX/ICH IRQ router [8086:2641]
[    0.569570] PCI: pci_cache_line_size set to 64 bytes
[    0.569657] e820: reserve RAM buffer [mem 0x0009fc00-0x0009ffff]
[    0.569664] e820: reserve RAM buffer [mem 0x3ff00000-0x3fffffff]
[    0.569799] pci 0000:00:02.0: vgaarb: setting as boot VGA device
[    0.569874] pci 0000:00:02.0: vgaarb: bridge control possible
[    0.569943] pci 0000:00:02.0: vgaarb: VGA device added: 
decodes=io+mem,owns=io+mem,locks=none
[    0.570053] vgaarb: loaded
[    0.570802] clocksource: hpet: mask: 0xffffffff max_cycles: 
0xffffffff, max_idle_ns: 133484882848 ns
[    0.570918] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.570998] hpet0: 3 comparators, 64-bit 14.318180 MHz counter
[    0.572394] clocksource: Switched to clocksource tsc-early
[    0.577309] VFS: Disk quotas dquot_6.6.0
[    0.577614] VFS: Dquot-cache hash table entries: 1024 (order 0, 4096 
bytes)
[    0.577809] pnp: PnP ACPI: disabled
[    0.583841] NET: Registered PF_INET protocol family
[    0.584175] IP idents hash table entries: 16384 (order: 5, 131072 
bytes, linear)
[    0.586329] tcp_listen_portaddr_hash hash table entries: 1024 (order: 
0, 4096 bytes, linear)
[    0.586448] Table-perturb hash table entries: 65536 (order: 6, 262144 
bytes, linear)
[    0.586549] TCP established hash table entries: 8192 (order: 3, 32768 
bytes, linear)
[    0.586690] TCP bind hash table entries: 8192 (order: 4, 65536 bytes, 
linear)
[    0.586898] TCP: Hash tables configured (established 8192 bind 8192)
[    0.587063] UDP hash table entries: 512 (order: 1, 8192 bytes, 
linear)
[    0.587178] UDP-Lite hash table entries: 512 (order: 1, 8192 bytes, 
linear)
[    0.587743] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.587845] NET: Registered PF_XDP protocol family
[    0.587933] pci 0000:00:1c.0: bridge window [mem 
0x00100000-0x000fffff 64bit pref] to [bus 01] add_size 200000 add_align 
100000
[    0.588053] pci 0000:00:1c.1: bridge window [mem 
0x00100000-0x000fffff 64bit pref] to [bus 02] add_size 200000 add_align 
100000
[    0.591818] pci 0000:00:1c.2: bridge window [mem 
0x00100000-0x000fffff 64bit pref] to [bus 03] add_size 200000 add_align 
100000
[    0.591932] pci 0000:00:1c.3: bridge window [mem 
0x00100000-0x000fffff 64bit pref] to [bus 04] add_size 200000 add_align 
100000
[    0.592067] pci 0000:00:1c.0: BAR 15: assigned [mem 
0x40000000-0x401fffff 64bit pref]
[    0.592170] pci 0000:00:1c.1: BAR 15: assigned [mem 
0x40200000-0x403fffff 64bit pref]
[    0.592268] pci 0000:00:1c.2: BAR 15: assigned [mem 
0x40400000-0x405fffff 64bit pref]
[    0.592366] pci 0000:00:1c.3: BAR 15: assigned [mem 
0x40600000-0x407fffff 64bit pref]
[    0.592468] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    0.592538] pci 0000:00:1c.0:   bridge window [io  0xa000-0xafff]
[    0.592615] pci 0000:00:1c.0:   bridge window [mem 
0xfe700000-0xfe7fffff]
[    0.592711] pci 0000:00:1c.0:   bridge window [mem 
0x40000000-0x401fffff 64bit pref]
[    0.592818] pci 0000:00:1c.1: PCI bridge to [bus 02]
[    0.592887] pci 0000:00:1c.1:   bridge window [io  0xb000-0xbfff]
[    0.592962] pci 0000:00:1c.1:   bridge window [mem 
0xfe800000-0xfe8fffff]
[    0.593057] pci 0000:00:1c.1:   bridge window [mem 
0x40200000-0x403fffff 64bit pref]
[    0.593157] pci 0000:00:1c.2: PCI bridge to [bus 03]
[    0.593225] pci 0000:00:1c.2:   bridge window [io  0xc000-0xcfff]
[    0.593299] pci 0000:00:1c.2:   bridge window [mem 
0xfe900000-0xfe9fffff]
[    0.593394] pci 0000:00:1c.2:   bridge window [mem 
0x40400000-0x405fffff 64bit pref]
[    0.593494] pci 0000:00:1c.3: PCI bridge to [bus 04]
[    0.593562] pci 0000:00:1c.3:   bridge window [io  0xd000-0xdfff]
[    0.593636] pci 0000:00:1c.3:   bridge window [mem 
0xfea00000-0xfeafffff]
[    0.593730] pci 0000:00:1c.3:   bridge window [mem 
0x40600000-0x407fffff 64bit pref]
[    0.593832] pci 0000:00:1e.0: PCI bridge to [bus 05]
[    0.593901] pci 0000:00:1e.0:   bridge window [io  0xe000-0xefff]
[    0.593974] pci 0000:00:1e.0:   bridge window [mem 
0xfeb00000-0xfebfffff]
[    0.594074] pci_bus 0000:00: resource 4 [io  0x0000-0xffff]
[    0.594144] pci_bus 0000:00: resource 5 [mem 0x00000000-0xffffffff]
[    0.594216] pci_bus 0000:01: resource 0 [io  0xa000-0xafff]
[    0.594285] pci_bus 0000:01: resource 1 [mem 0xfe700000-0xfe7fffff]
[    0.594357] pci_bus 0000:01: resource 2 [mem 0x40000000-0x401fffff 
64bit pref]
[    0.594451] pci_bus 0000:02: resource 0 [io  0xb000-0xbfff]
[    0.594520] pci_bus 0000:02: resource 1 [mem 0xfe800000-0xfe8fffff]
[    0.594592] pci_bus 0000:02: resource 2 [mem 0x40200000-0x403fffff 
64bit pref]
[    0.594686] pci_bus 0000:03: resource 0 [io  0xc000-0xcfff]
[    0.594755] pci_bus 0000:03: resource 1 [mem 0xfe900000-0xfe9fffff]
[    0.594826] pci_bus 0000:03: resource 2 [mem 0x40400000-0x405fffff 
64bit pref]
[    0.594921] pci_bus 0000:04: resource 0 [io  0xd000-0xdfff]
[    0.594990] pci_bus 0000:04: resource 1 [mem 0xfea00000-0xfeafffff]
[    0.595061] pci_bus 0000:04: resource 2 [mem 0x40600000-0x407fffff 
64bit pref]
[    0.595156] pci_bus 0000:05: resource 0 [io  0xe000-0xefff]
[    0.595225] pci_bus 0000:05: resource 1 [mem 0xfeb00000-0xfebfffff]
[    0.595297] pci_bus 0000:05: resource 4 [io  0x0000-0xffff]
[    0.595366] pci_bus 0000:05: resource 5 [mem 0x00000000-0xffffffff]
[    0.595510] pci 0000:00:1d.0: PCI->APIC IRQ transform: INT A -> IRQ 
23
[    0.595637] pci 0000:00:1d.7: PCI->APIC IRQ transform: INT A -> IRQ 
23
[    0.622820] pci 0000:00:1d.7: quirk_usb_early_handoff+0x0/0x7b8 took 
26553 usecs
[    0.623003] pci 0000:05:02.0: Firmware left e100 interrupts enabled; 
disabling
[    0.623110] pci 0000:05:03.0: Firmware left e100 interrupts enabled; 
disabling
[    0.623215] pci 0000:05:04.0: Firmware left e100 interrupts enabled; 
disabling
[    0.623320] pci 0000:05:05.0: Firmware left e100 interrupts enabled; 
disabling
[    0.623417] PCI: CLS 64 bytes, default 64
[    0.624577] Trying to unpack rootfs image as initramfs...
[    0.626321] platform rtc_cmos: registered platform RTC device (no PNP 
device found)
[    0.627096] PCLMULQDQ-NI instructions are not detected.
[    0.628431] Initialise system trusted keyrings
[    0.628563] Key type blacklist registered
[    0.632913] workingset: timestamp_bits=14 max_order=18 bucket_order=4
[    0.633032] zbud: loaded
[    0.804584] jitterentropy: Initialization failed with host not 
compliant with requirements: 9
[    0.804720] NET: Registered PF_ALG protocol family
[    0.804831] Key type asymmetric registered
[    0.804896] Asymmetric key parser 'x509' registered
[    0.804962] Asymmetric key parser 'pkcs8' registered
[    0.809525] Block layer SCSI generic (bsg) driver version 0.4 loaded 
(major 250)
[    0.809640] io scheduler mq-deadline registered
[    0.809706] io scheduler kyber registered
[    0.810011] io scheduler bfq registered
[    0.810475] xz_dec_test: module loaded
[    0.810541] xz_dec_test: Create a device node with 'mknod xz_dec_test 
c 249 0' and write .xz files to it.
[    0.810837] pcieport 0000:00:1c.0: PCI->APIC IRQ transform: INT A -> 
IRQ 16
[    0.811126] pcieport 0000:00:1c.1: PCI->APIC IRQ transform: INT B -> 
IRQ 17
[    0.811342] pcieport 0000:00:1c.2: PCI->APIC IRQ transform: INT C -> 
IRQ 18
[    0.811592] pcieport 0000:00:1c.3: PCI->APIC IRQ transform: INT D -> 
IRQ 19
[    0.816466] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    0.856166] serial8250: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 
115200) is a 16550A
[    0.862653] intel_rng: FWH not detected
[    0.879667] brd: module loaded
[    0.887530] loop: module loaded
[    0.888935] ahci 0000:00:1f.2: version 3.0
[    0.888974] ahci 0000:00:1f.2: PCI->APIC IRQ transform: INT B -> IRQ 
19
[    0.889157] ahci 0000:00:1f.2: forcing PORTS_IMPL to 0xf
[    0.889359] ahci 0000:00:1f.2: AHCI 0001.0000 32 slots 4 ports 1.5 
Gbps 0xf impl IDE mode
[    0.889818] ahci 0000:00:1f.2: flags: 64bit ncq pm led pmp slum part
[    0.894190] scsi host0: ahci
[    0.895209] scsi host1: ahci
[    0.896636] scsi host2: ahci
[    0.899524] scsi host3: ahci
[    0.899813] ata1: SATA max UDMA/133 abar m1024@0xfe63b800 port 
0xfe63b900 irq 19
[    0.899917] ata2: SATA max UDMA/133 abar m1024@0xfe63b800 port 
0xfe63b980 irq 19
[    0.900012] ata3: SATA max UDMA/133 abar m1024@0xfe63b800 port 
0xfe63ba00 irq 19
[    0.900106] ata4: SATA max UDMA/133 abar m1024@0xfe63b800 port 
0xfe63ba80 irq 19
[    0.900348] ata_piix 0000:00:1f.1: version 2.13
[    0.900384] ata_piix 0000:00:1f.1: PCI->APIC IRQ transform: INT A -> 
IRQ 18
[    0.901686] scsi host4: ata_piix
[    0.906225] scsi host5: ata_piix
[    0.906445] ata5: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0xffa0 
irq 14
[    0.906544] ata6: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xffa8 
irq 15
[    0.923847] wireguard: WireGuard 1.0.0 loaded. See www.wireguard.com 
for information.
[    0.923964] wireguard: Copyright (C) 2015-2019 Jason A. Donenfeld 
<Jason@zx2c4.com>. All Rights Reserved.
[    0.924066] MACsec IEEE 802.1AE
[    0.926078] tun: Universal TUN/TAP device driver, 1.6
[    0.933094] e100: Intel(R) PRO/100 Network Driver
[    0.933181] e100: Copyright(c) 1999-2006 Intel Corporation
[    0.933364] e100 0000:05:02.0: PCI->APIC IRQ transform: INT A -> IRQ 
16
[    0.987812] e100 0000:05:02.0 eth0: addr 0xfebff000, irq 16, MAC addr 
00:04:a7:0a:03:34
[    0.988102] e100 0000:05:03.0: PCI->APIC IRQ transform: INT A -> IRQ 
17
[    1.041393] e100 0000:05:03.0 eth1: addr 0xfebfe000, irq 17, MAC addr 
00:04:a7:0a:03:35
[    1.041687] e100 0000:05:04.0: PCI->APIC IRQ transform: INT A -> IRQ 
18
[    1.069493] ata5.01: CFA: TRANSCEND, 20080820, max UDMA/66
[    1.069592] ata5.01: 15662304 sectors, multi 0: LBA
[    1.096351] e100 0000:05:04.0 eth2: addr 0xfebfd000, irq 18, MAC addr 
00:04:a7:0a:03:36
[    1.096652] e100 0000:05:05.0: PCI->APIC IRQ transform: INT A -> IRQ 
19
[    1.149944] e100 0000:05:05.0 eth3: addr 0xfebfc000, irq 19, MAC addr 
00:04:a7:0a:03:37
[    1.150135] e1000: Intel(R) PRO/1000 Network Driver
[    1.150203] e1000: Copyright (c) 1999-2006 Intel Corporation.
[    1.150324] e1000e: Intel(R) PRO/1000 Network Driver
[    1.150392] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    1.150562] e1000e 0000:01:00.0: PCI->APIC IRQ transform: INT A -> 
IRQ 16
[    1.150776] e1000e 0000:01:00.0: Interrupt Throttling Rate (ints/sec) 
set to dynamic conservative mode
[    1.212807] ata3: SATA link down (SStatus 0 SControl 300)
[    1.212943] ata1: SATA link down (SStatus 0 SControl 300)
[    1.283565] e1000e 0000:01:00.0 eth4: (PCI Express:2.5GT/s:Width x1) 
00:04:a7:08:c5:b4
[    1.283690] e1000e 0000:01:00.0 eth4: Intel(R) PRO/1000 Network 
Connection
[    1.283855] e1000e 0000:01:00.0 eth4: MAC: 2, PHY: 2, PBA No: 
FFFFFF-0FF
[    1.292947] e1000e 0000:02:00.0: PCI->APIC IRQ transform: INT A -> 
IRQ 17
[    1.293182] e1000e 0000:02:00.0: Interrupt Throttling Rate (ints/sec) 
set to dynamic conservative mode
[    1.416968] e1000e 0000:02:00.0 eth5: (PCI Express:2.5GT/s:Width x1) 
00:04:a7:08:c5:b5
[    1.417093] e1000e 0000:02:00.0 eth5: Intel(R) PRO/1000 Network 
Connection
[    1.417257] e1000e 0000:02:00.0 eth5: MAC: 2, PHY: 2, PBA No: 
FFFFFF-0FF
[    1.419923] e1000e 0000:03:00.0: PCI->APIC IRQ transform: INT A -> 
IRQ 18
[    1.420164] e1000e 0000:03:00.0: Interrupt Throttling Rate (ints/sec) 
set to dynamic conservative mode
[    1.533895] e1000e 0000:03:00.0 eth6: (PCI Express:2.5GT/s:Width x1) 
00:04:a7:08:c5:b6
[    1.534017] e1000e 0000:03:00.0 eth6: Intel(R) PRO/1000 Network 
Connection
[    1.534181] e1000e 0000:03:00.0 eth6: MAC: 2, PHY: 2, PBA No: 
FFFFFF-0FF
[    1.534366] e1000e 0000:04:00.0: PCI->APIC IRQ transform: INT A -> 
IRQ 19
[    1.534606] e1000e 0000:04:00.0: Interrupt Throttling Rate (ints/sec) 
set to dynamic conservative mode
[    1.619873] tsc: Refined TSC clocksource calibration: 1000.035 MHz
[    1.619977] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 
0xe6a38202b4, max_idle_ns: 440795212232 ns
[    1.620090] clocksource: Switched to clocksource tsc
[    1.646800] e1000e 0000:04:00.0 eth7: (PCI Express:2.5GT/s:Width x1) 
00:04:a7:08:c5:b7
[    1.646925] e1000e 0000:04:00.0 eth7: Intel(R) PRO/1000 Network 
Connection
[    1.647089] e1000e 0000:04:00.0 eth7: MAC: 2, PHY: 2, PBA No: 
FFFFFF-0FF
[    1.647261] igb: Intel(R) Gigabit Ethernet Network Driver
[    1.647331] igb: Copyright (c) 2007-2014 Intel Corporation.
[    1.647452] Intel(R) 2.5G Ethernet Linux Driver
[    1.647519] Copyright(c) 2018 Intel Corporation.
[    1.647650] ixgbe: Intel(R) 10 Gigabit PCI Express Network Driver
[    1.647722] ixgbe: Copyright (c) 1999-2016 Intel Corporation.
[    1.648340] i40e: Intel(R) Ethernet Connection XL710 Network Driver
[    1.648420] i40e: Copyright (c) 2013 - 2019 Intel Corporation.
[    1.648674] sky2: driver version 1.30
[    1.650562] PPP generic driver version 2.4.2
[    1.650946] PPP BSD Compression module registered
[    1.651019] PPP Deflate Compression module registered
[    1.651087] NET: Registered PF_PPPOX protocol family
[    1.651181] PPTP driver version 0.8.5
[    1.653565] uhci_hcd 0000:00:1d.0: PCI->APIC IRQ transform: INT A -> 
IRQ 23
[    1.653715] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[    1.653961] ehci-pci 0000:00:1d.7: PCI->APIC IRQ transform: INT A -> 
IRQ 23
[    1.654360] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned 
bus number 1
[    1.654513] uhci_hcd 0000:00:1d.0: irq 23, io port 0x00009880
[    1.656722] hub 1-0:1.0: USB hub found
[    1.656819] hub 1-0:1.0: 2 ports detected
[    1.657352] usbcore: registered new interface driver usb-storage
[    1.657723] i8042: PNP: No PS/2 controller found.
[    1.657791] i8042: Probing ports directly.
[    1.660618] ehci-pci 0000:00:1d.7: EHCI Host Controller
[    1.660962] ehci-pci 0000:00:1d.7: new USB bus registered, assigned 
bus number 2
[    1.661085] ehci-pci 0000:00:1d.7: debug port 1
[    1.667498] serio: i8042 KBD port at 0x60,0x64 irq 1
[    1.667713] ehci-pci 0000:00:1d.7: irq 23, io mem 0xfe63bc00
[    1.667944] serio: i8042 AUX port at 0x60,0x64 irq 12
[    1.668674] mousedev: PS/2 mouse device common for all mice
[    1.669999] rtc_cmos rtc_cmos: registered as rtc0
[    1.670118] rtc_cmos rtc_cmos: setting system clock to 
2024-04-04T12:16:11 UTC (1712232971)
[    1.670293] rtc_cmos rtc_cmos: alarms up to one day, 114 bytes nvram, 
hpet irqs
[    1.670453] i2c_dev: i2c /dev entries driver
[    1.671299] hid: raw HID events driver (C) Jiri Kosina
[    1.671425] usbcore: registered new interface driver usbhid
[    1.671495] usbhid: USB HID core driver
[    1.671606] GACT probability on
[    1.671688] Mirror/redirect action on
[    1.671775] Simple TC action Loaded
[    1.672307] netem: version 1.3
[    1.672425] u32 classifier
[    1.672486]     Performance counters on
[    1.672547]     input device check on
[    1.672608]     Actions configured
[    1.673567] i801_smbus 0000:00:1f.3: PCI->APIC IRQ transform: INT B 
-> IRQ 19
[    1.673710] i801_smbus 0000:00:1f.3: SMBus using PCI interrupt
[    1.678014] xt_time: kernel timezone is -0000
[    1.678377] ipip: IPv4 and MPLS over IPv4 tunneling driver
[    1.679858] ehci-pci 0000:00:1d.7: USB 2.0 started, EHCI 1.00
[    1.680485] hub 2-0:1.0: USB hub found
[    1.680580] hub 2-0:1.0: 2 ports detected
[    1.680915] hub 1-0:1.0: USB hub found
[    1.681074] gre: GRE over IPv4 demultiplexor driver
[    1.681144] ip_gre: GRE over IPv4 tunneling driver
[    1.682280] IPv4 over IPsec tunneling driver
[    1.682741] Initializing XFRM netlink socket
[    1.682831] IPsec XFRM device driver
[    1.682905] IPv6: Loaded, but administratively disabled, reboot 
required to enable
[    1.682999] IPv6: ah6_init: can't add xfrm type
[    1.683064] IPv6: esp6_init: can't add xfrm type
[    1.683129] IPv6: ipcomp6_init: can't add xfrm type
[    1.683212] hub 1-0:1.0: 2 ports detected
[    1.697258] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[    1.697704] ip6_gre: GRE over IPv6 tunneling driver
[    1.698159] NET: Registered PF_PACKET protocol family
[    1.698243] NET: Registered PF_KEY protocol family
[    1.698358] Bridge firewalling registered
[    1.703300] NET: Registered PF_KCM protocol family
[    1.703536] l2tp_core: L2TP core driver, V2.0
[    1.703612] l2tp_ppp: PPPoL2TP kernel driver, V2.0
[    1.703678] l2tp_ip: L2TP IP encapsulation support (L2TPv3)
[    1.703761] l2tp_netlink: L2TP netlink interface
[    1.703872] l2tp_eth: L2TP ethernet pseudowire support (L2TPv3)
[    1.703941] l2tp_ip6: L2TP IP encapsulation support for IPv6 (L2TPv3)
[    1.704223] 8021q: 802.1Q VLAN Support v1.8
[    1.706569] microcode: Microcode Update Driver: v2.2.
[    1.739104] sched_clock: Marking stable (1726683808, 
9797698)->(1738705429, -2223923)
[    1.741745] Loading compiled-in X.509 certificates
[    1.757082] Key type .fscrypt registered
[    1.757171] Key type fscrypt-provisioning registered
[    1.913171] ata2: failed to resume link (SControl 0)
[    1.913283] ata2: SATA link down (SStatus 0 SControl 0)
[    1.919834] ata4: failed to resume link (SControl 0)
[    1.919932] ata4: SATA link down (SStatus 0 SControl 0)
[    1.923910] scsi 4:0:1:0: Direct-Access     ATA      TRANSCEND        
0820 PQ: 0 ANSI: 5
[    1.925035] sd 4:0:1:0: [sda] 15662304 512-byte logical blocks: (8.02 
GB/7.47 GiB)
[    1.925166] sd 4:0:1:0: [sda] Write Protect is off
[    1.925238] sd 4:0:1:0: [sda] Mode Sense: 00 3a 00 00
[    1.925272] sd 4:0:1:0: [sda] Write cache: disabled, read cache: 
enabled, doesn't support DPO or FUA
[    1.925408] sd 4:0:1:0: [sda] Preferred minimum I/O size 512 bytes
[    1.927769] sd 4:0:1:0: Attached scsi generic sg0 type 0
[    1.931553]  sda: sda1
[    1.932031] usb 2-1: new high-speed USB device number 2 using 
ehci-pci
[    1.935405] sd 4:0:1:0: [sda] Attached SCSI disk
[    2.082200] usb-storage 2-1:1.0: USB Mass Storage device detected
[    2.082722] scsi host6: usb-storage 2-1:1.0
[    2.409883] usb 1-2: new low-speed USB device number 2 using uhci_hcd
[    2.662968] input: HID 046a:0011 as 
/devices/pci0000:00/0000:00:1d.0/usb1/1-2/1-2:1.0/0003:046A:0011.0001/input/input2
[    2.716785] hid-generic 0003:046A:0011.0001: input,hidraw0: USB HID 
v1.11 Keyboard [HID 046a:0011] on usb-0000:00:1d.0-2/input0
[    3.087395] scsi 6:0:0:0: Direct-Access     Kingston DataTraveler 2.0 
1.00 PQ: 0 ANSI: 2
[    3.088289] sd 6:0:0:0: Attached scsi generic sg1 type 0
[    3.089735] sd 6:0:0:0: [sdb] 2007040 512-byte logical blocks: (1.03 
GB/980 MiB)
[    3.090611] sd 6:0:0:0: [sdb] Write Protect is off
[    3.090698] sd 6:0:0:0: [sdb] Mode Sense: 23 00 00 00
[    3.091359] sd 6:0:0:0: [sdb] No Caching mode page found
[    3.091439] sd 6:0:0:0: [sdb] Assuming drive cache: write through
[    3.096137]  sdb: sdb1
[    3.096573] sd 6:0:0:0: [sdb] Attached SCSI removable disk
[    7.560378] Freeing initrd memory: 91572K
[    7.631832] Key type encrypted registered
[    7.632260] gtp: GTP module loaded (pdp ctx size 60 bytes)
[    7.632782] clk: Disabling unused clocks
[    7.633622] Freeing unused kernel image (initmem) memory: 640K
[    7.633877] Write protecting kernel text and read-only data: 15944k
[    7.633957] rodata_test: all tests were successful
[    7.634036] Run /init as init process
[    7.634098]   with arguments:
[    7.634101]     /init
[    7.634104]   with environment:
[    7.634106]     HOME=/
[    7.634109]     TERM=linux
[    7.634112]     BOOT_IMAGE=kernel
[   12.186491] random: crng init done

Regards
-- 
Wolfgang Walter
Studierendenwerk München Oberbayern
Anstalt des öffentlichen Rechts

