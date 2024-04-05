Return-Path: <stable+bounces-36099-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1AF899B38
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 12:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E3C31F229FD
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 10:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF0B16132B;
	Fri,  5 Apr 2024 10:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stwm.de header.i=@stwm.de header.b="WpSRq21W"
X-Original-To: stable@vger.kernel.org
Received: from email.studentenwerk.mhn.de (dresden.studentenwerk.mhn.de [141.84.225.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245C61474DC
	for <stable@vger.kernel.org>; Fri,  5 Apr 2024 10:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.84.225.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712314275; cv=none; b=KfZuZuZtIG/0qJJ/ZQzekidvTa/JNgHleNgGxEAbYyEoLQcZ/4rX1lVQ0n9KpV6+NImER+b6Nm/YjN2DrFeX84R/dQGScvfJvh3MVDcdwo/EROvPoF/UR3C01CLeCabn6fZ9XqAZ90gbYxw7c1c1IsRtat7paAAOu468nAWldr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712314275; c=relaxed/simple;
	bh=xe/4OgtkFkd+jSWAvdmD/1/ZY0PkRGoBvil6qLbyxow=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=ax3wFMaSGfzy4vovjGZGL5dQH6lJQzLzoyMx08OAl5hxP0mdO7YeybvmXwKkpHpMdEepOqQafaf4uDxGi/aIjcOPUAlVIdGc4adqUGmDnpdZsdLkaC2NGJhZslatIZRauJjsfunQ+tpF5iBDei9LWIY1Sp5KG3ewa3+Fy4RJwHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stwm.de; spf=none smtp.mailfrom=stwm.de; dkim=pass (2048-bit key) header.d=stwm.de header.i=@stwm.de header.b=WpSRq21W; arc=none smtp.client-ip=141.84.225.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stwm.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=stwm.de
Received: from mailhub.studentenwerk.mhn.de (mailhub.studentenwerk.mhn.de [127.0.0.1])
	by email.studentenwerk.mhn.de (Postfix) with ESMTPS id 4V9wJX6qpczRhTC;
	Fri,  5 Apr 2024 12:51:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwm.de; s=stwm-20170627;
	t=1712314268;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OTBZkgr8q5Jq00h98g3Puskwq/6AUcCj0fEbn0IKfCw=;
	b=WpSRq21Worq9EmTlmQ2S2Go3flA0frhm/ikghEvAEVAnPyKOv74n40UHHuCet5Di7HRUc4
	UihPGm8QwErr3AlHUtE2oPjakz2TVkyii1mSeR1FLWG+mv8RWQ9/JBC/nhiUvjfizHQHX5
	3Vb8VrsOmRsHTPiQmkDcF+PLM8GPfPgbVhCvKYoeQeVnCdx7q8h6mG1be8pGjw3Z3kFZLS
	9zvNoc5iKiAu0Gqorv2zi5OvM/zf3ndRPPEuxFL5tIO3TwnOBqmj+cXeNi56Ag2ZiIq88Y
	6LzNFL0Jxn/Y8HZzJgMAGr1AedNVPBn1ViLbubP0I3MBTAzrIV52KnCIq2boRg==
Received: from roundcube.studentenwerk.mhn.de (roundcube.studentenwerk.mhn.de [10.148.7.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mailhub.studentenwerk.mhn.de (Postfix) with ESMTPS id 4V9wJX6gTKzHnGf;
	Fri,  5 Apr 2024 12:51:08 +0200 (CEST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 05 Apr 2024 12:51:08 +0200
From: Wolfgang Walter <linux@stwm.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Subject: Re: stable v6.6.24 regression: boot fails: bisected to "x86/mpparse:
 Register APIC address only once"
In-Reply-To: <874jcg9msa.ffs@tglx>
References: <23da7f59519df267035b204622d32770@stwm.de>
 <2024040445-promotion-lumpiness-c6c8@gregkh> <874jcg9msa.ffs@tglx>
Message-ID: <9c8be4850b6bd9ba554c03f336680798@stwm.de>
X-Sender: linux@stwm.de
Organization: =?UTF-8?Q?Studierendenwerk_M=C3=BCnchen_Oberbayern?=
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit

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

here dmesg of 6.9-rc1 (which works fine):

[    0.000000] Linux version 6.9.0-rc1 (S-kernel@sid-i386) (gcc (Debian 
13.2.0-23) 13.2.0, GNU ld (GNU Binutils for Debian) 2.42) #1 
PREEMPT_DYNAMIC Fri Apr  5 12:12:01 CEST 2024
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
[    0.000000] tsc: Detected 999.965 MHz processor
[    0.011044] e820: update [mem 0x00000000-0x00000fff] usable ==> 
reserved
[    0.011055] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.011070] last_pfn = 0x3ff00 max_arch_pfn = 0x100000
[    0.011087] MTRR map: 7 entries (5 fixed + 2 variable; max 21), built 
from 8 variable MTRRs
[    0.011093] x86/PAT: PAT not supported by the CPU.
[    0.011099] x86/PAT: Configuration [0-7]: WB  WT  UC- UC  WB  WT  UC- 
UC
[    0.011283] Warning only 887MB will be used.
[    0.011286] Use a HIGHMEM enabled kernel.
[    0.024443] found SMP MP-table at [mem 0x000ff780-0x000ff78f]
[    0.024462] initial memory mapped: [mem 0x00000000-0x023fffff]
[    0.024545] RAMDISK: [mem 0x3a593000-0x3fefffff]
[    0.024550] Allocated new RAMDISK: [mem 0x31e91000-0x377fdc20]
[    0.184495] Move RAMDISK from [mem 0x3a593000-0x3feffc20] to [mem 
0x31e91000-0x377fdc20]
[    0.184522] ACPI: Early table checksum verification disabled
[    0.185291] ACPI BIOS Error (bug): A valid RSDP was not found 
(20230628/tbxfroot-222)
[    0.185316] Intel MultiProcessor Specification v1.4
[    0.185319]     Virtual Wire compatibility mode.
[    0.185324] MPTABLE: OEM ID: Intel
[    0.185328] MPTABLE: Product ID: Alviso
[    0.185330] MPTABLE: APIC at: 0xFEE00000
[    0.185338] 887MB LOWMEM available.
[    0.185341]   mapped low ram: 0 - 377fe000
[    0.185344]   low ram: 0 - 377fe000
[    0.185351] Zone ranges:
[    0.185353]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.185361]   Normal   [mem 0x0000000001000000-0x00000000377fdfff]
[    0.185367] Movable zone start for each node
[    0.185369] Early memory node ranges
[    0.185371]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.185376]   node   0: [mem 0x0000000000100000-0x000000003fefffff]
[    0.185382] Initmem setup node 0 [mem 
0x0000000000001000-0x000000003fefffff]
[    0.185411] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.185693] On node 0, zone DMA: 97 pages in unavailable ranges
[    0.201157] On node 0, zone Normal: 2 pages in unavailable ranges
[    0.201181] Reserving Intel graphics memory at [mem 
0x3ff00000-0x3fffffff]
[    0.201466] Intel MultiProcessor Specification v1.4
[    0.201472]     Virtual Wire compatibility mode.
[    0.201477] MPTABLE: OEM ID: Intel
[    0.201480] MPTABLE: Product ID: Alviso
[    0.201482] MPTABLE: APIC at: 0xFEE00000
[    0.201488] Processor #0 (Bootup-CPU)
[    0.201504] IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, GSI 
0-23
[    0.201517] Processors: 1
[    0.201521] CPU topo: Max. logical packages:   1
[    0.201524] CPU topo: Max. logical dies:       1
[    0.201527] CPU topo: Max. dies per package:   1
[    0.201529] CPU topo: Max. threads per core:   1
[    0.201535] CPU topo: Num. cores per package:     1
[    0.201538] CPU topo: Num. threads per package:   1
[    0.201540] CPU topo: Allowing 1 present CPUs plus 0 hotplug CPUs
[    0.201570] [mem 0x40000000-0xdfffffff] available for PCI devices
[    0.201581] clocksource: refined-jiffies: mask: 0xffffffff 
max_cycles: 0xffffffff, max_idle_ns: 6370452778343963 ns
[    0.201658] pcpu-alloc: s0 r0 d32768 u32768 alloc=1*32768
[    0.201673] pcpu-alloc: [0] 0
[    0.201697] Kernel command line: BOOT_IMAGE=kernel initrd=system.gz 
init=/sbin/init ipv6.disable=1 dummy.numdummies=16 ide-core.nodma=1.0 
iommu=pt libata.dma=3 random.trust_cpu=on reboot=cold,force retbleed=off
[    0.202541] Unknown kernel command line parameters 
"BOOT_IMAGE=kernel", will be passed to user space.
[    0.203023] Dentry cache hash table entries: 131072 (order: 7, 524288 
bytes, linear)
[    0.203310] Inode-cache hash table entries: 65536 (order: 6, 262144 
bytes, linear)
[    0.203384] Built 1 zonelists, mobility grouping on.  Total pages: 
225008
[    0.203394] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.219384] Checking if this processor honours the WP bit even in 
supervisor mode...Ok.
[    0.219411] Memory: 789208K/908912K available (12921K kernel code, 
739K rwdata, 3076K rodata, 632K init, 280K bss, 119704K reserved, 0K 
cma-reserved)
[    0.265600] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=1, 
Nodes=1
[    0.266886] Dynamic Preempt: full
[    0.267261] rcu: Preemptible hierarchical RCU implementation.
[    0.267267] 	Trampoline variant of Tasks RCU enabled.
[    0.267270] 	Tracing variant of Tasks RCU enabled.
[    0.267272] rcu: RCU calculated value of scheduler-enlistment delay 
is 30 jiffies.
[    0.267287] RCU Tasks: Setting shift to 0 and lim to 1 
rcu_task_cb_adjust=1.
[    0.267295] RCU Tasks Trace: Setting shift to 0 and lim to 1 
rcu_task_cb_adjust=1.
[    0.267304] NR_IRQS: 2304, nr_irqs: 48, preallocated irqs: 16
[    0.267620] rcu: srcu_init: Setting srcu_struct sizes based on 
contention.
[    0.272009] Console: colour VGA+ 80x25
[    0.272020] printk: legacy console [tty0] enabled
[    0.278176] APIC: Switch to symmetric I/O mode setup
[    0.278312] ExtINT not setup in hardware but reported by MP table
[    0.278804] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=0 pin2=0
[    0.294846] clocksource: tsc-early: mask: 0xffffffffffffffff 
max_cycles: 0x1cd3ebf4f53, max_idle_ns: 881590451058 ns
[    0.294970] Calibrating delay loop (skipped), value calculated using 
timer frequency.. 2000.26 BogoMIPS (lpj=3333216)
[    0.295096] Disabled fast string operations
[    0.295183] CPU0: Thermal monitoring enabled (TM1)
[    0.295295] Last level iTLB entries: 4KB 128, 2MB 0, 4MB 2
[    0.295368] Last level dTLB entries: 4KB 128, 2MB 0, 4MB 8, 1GB 0
[    0.295445] CPU: Intel(R) Celeron(R) M processor         1.00GHz 
(family: 0x6, model: 0xd, stepping: 0x8)
[    0.295554] Spectre V1 : Mitigation: usercopy/swapgs barriers and 
__user pointer sanitization
[    0.295655] Spectre V2 : Mitigation: Retpolines
[    0.295720] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling 
RSB on context switch
[    0.295815] Spectre V2 : Spectre v2 / SpectreRSB : Filling RSB on 
VMEXIT
[    0.295905] Speculative Store Bypass: Vulnerable
[    0.295972] L1TF: Kernel not compiled for PAE. No mitigation for L1TF
[    0.296043] MDS: Vulnerable: Clear CPU buffers attempted, no 
microcode
[    0.296133] MMIO Stale Data: Unknown: No mitigations
[    0.296201] x86/fpu: x87 FPU will use FXSAVE
[    0.297526] pid_max: default: 32768 minimum: 301
[    0.304402] Mount-cache hash table entries: 2048 (order: 1, 8192 
bytes, linear)
[    0.304509] Mountpoint-cache hash table entries: 2048 (order: 1, 8192 
bytes, linear)
[    0.310412] Performance Events: p6 PMU driver.
[    0.310502] ... version:                0
[    0.310565] ... bit width:              32
[    0.310628] ... generic registers:      2
[    0.310691] ... value mask:             00000000ffffffff
[    0.310758] ... max period:             000000007fffffff
[    0.310825] ... fixed-purpose events:   0
[    0.310887] ... event mask:             0000000000000003
[    0.311099] signal: max sigframe size: 1440
[    0.311261] rcu: Hierarchical SRCU implementation.
[    0.311332] rcu: 	Max phase no-delay instances is 1000.
[    0.524958] devtmpfs: initialized
[    0.524958] clocksource: jiffies: mask: 0xffffffff max_cycles: 
0xffffffff, max_idle_ns: 6370867519511994 ns
[    0.524958] futex hash table entries: 256 (order: -1, 3072 bytes, 
linear)
[    0.529440] pinctrl core: initialized pinctrl subsystem
[    0.530684] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.531926] thermal_sys: Registered thermal governor 'fair_share'
[    0.531934] thermal_sys: Registered thermal governor 'bang_bang'
[    0.532010] thermal_sys: Registered thermal governor 'step_wise'
[    0.532079] thermal_sys: Registered thermal governor 'user_space'
[    0.532186] cpuidle: using governor ladder
[    0.534781] PCI: PCI BIOS revision 3.00 entry at 0xf0031, last bus=5
[    0.534861] PCI: Using configuration type 1 for base access
[    0.537177] cryptd: max_cpu_qlen set to 1000
[    0.540234] ACPI: Interpreter disabled.
[    0.540350] iommu: Default domain type: Passthrough (set via kernel 
command line)
[    0.540820] SCSI subsystem initialized
[    0.540994] libata version 3.00 loaded.
[    0.541138] usbcore: registered new interface driver usbfs
[    0.541227] usbcore: registered new interface driver hub
[    0.541314] usbcore: registered new device driver usb
[    0.541510] pps_core: LinuxPPS API ver. 1 registered
[    0.541578] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 
Rodolfo Giometti <giometti@linux.it>
[    0.541639] PTP clock support registered
[    0.541731] EDAC MC: Ver: 3.0.0
[    0.545937] PCI: Probing PCI hardware
[    0.546008] PCI: root bus 00: using default resources
[    0.546014] PCI: Probing PCI hardware (bus 00)
[    0.546064] PCI host bridge to bus 0000:00
[    0.546131] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
[    0.546207] pci_bus 0000:00: root bus resource [mem 
0x00000000-0xffffffff]
[    0.546302] pci_bus 0000:00: No busn resource found for root bus, 
will use [bus 00-ff]
[    0.546422] pci 0000:00:00.0: [8086:2590] type 00 class 0x060000 
conventional PCI endpoint
[    0.546673] pci 0000:00:02.0: [8086:2592] type 00 class 0x030000 
conventional PCI endpoint
[    0.546786] pci 0000:00:02.0: BAR 0 [mem 0xfe680000-0xfe6fffff]
[    0.546863] pci 0000:00:02.0: BAR 1 [io  0x9c00-0x9c07]
[    0.546940] pci 0000:00:02.0: BAR 2 [mem 0xd0000000-0xdfffffff pref]
[    0.547017] pci 0000:00:02.0: BAR 3 [mem 0xfe640000-0xfe67ffff]
[    0.547111] pci 0000:00:02.0: Video device with shadowed ROM at [mem 
0x000c0000-0x000dffff]
[    0.547335] pci 0000:00:02.1: [8086:2792] type 00 class 0x038000 
conventional PCI endpoint
[    0.547447] pci 0000:00:02.1: BAR 0 [mem 0xfe580000-0xfe5fffff]
[    0.547702] pci 0000:00:1c.0: [8086:2660] type 01 class 0x060400 PCIe 
Root Port
[    0.548341] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    0.548416] pci 0000:00:1c.0:   bridge window [io  0xa000-0xafff]
[    0.548490] pci 0000:00:1c.0:   bridge window [mem 
0xfe700000-0xfe7fffff]
[    0.548605] pci 0000:00:1c.0: enabling Extended Tags
[    0.548717] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.548934] pci 0000:00:1c.1: [8086:2662] type 01 class 0x060400 PCIe 
Root Port
[    0.549064] pci 0000:00:1c.1: PCI bridge to [bus 02]
[    0.549136] pci 0000:00:1c.1:   bridge window [io  0xb000-0xbfff]
[    0.549209] pci 0000:00:1c.1:   bridge window [mem 
0xfe800000-0xfe8fffff]
[    0.549322] pci 0000:00:1c.1: enabling Extended Tags
[    0.549433] pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
[    0.549611] pci 0000:00:1c.2: [8086:2664] type 01 class 0x060400 PCIe 
Root Port
[    0.549740] pci 0000:00:1c.2: PCI bridge to [bus 03]
[    0.549812] pci 0000:00:1c.2:   bridge window [io  0xc000-0xcfff]
[    0.549885] pci 0000:00:1c.2:   bridge window [mem 
0xfe900000-0xfe9fffff]
[    0.549998] pci 0000:00:1c.2: enabling Extended Tags
[    0.550109] pci 0000:00:1c.2: PME# supported from D0 D3hot D3cold
[    0.550305] pci 0000:00:1c.3: [8086:2666] type 01 class 0x060400 PCIe 
Root Port
[    0.550434] pci 0000:00:1c.3: PCI bridge to [bus 04]
[    0.550506] pci 0000:00:1c.3:   bridge window [io  0xd000-0xdfff]
[    0.550579] pci 0000:00:1c.3:   bridge window [mem 
0xfea00000-0xfeafffff]
[    0.550692] pci 0000:00:1c.3: enabling Extended Tags
[    0.550801] pci 0000:00:1c.3: PME# supported from D0 D3hot D3cold
[    0.550997] pci 0000:00:1d.0: [8086:2658] type 00 class 0x0c0300 
conventional PCI endpoint
[    0.551147] pci 0000:00:1d.0: BAR 4 [io  0x9880-0x989f]
[    0.551336] pci 0000:00:1d.7: [8086:265c] type 00 class 0x0c0320 
conventional PCI endpoint
[    0.551454] pci 0000:00:1d.7: BAR 0 [mem 0xfe63bc00-0xfe63bfff]
[    0.551697] pci 0000:00:1d.7: PME# supported from D0 D3hot D3cold
[    0.551883] pci 0000:00:1e.0: [8086:2448] type 01 class 0x060401 
conventional PCI bridge
[    0.552013] pci 0000:00:1e.0: PCI bridge to [bus 05] (subtractive 
decode)
[    0.552110] pci 0000:00:1e.0:   bridge window [io  0xe000-0xefff]
[    0.552183] pci 0000:00:1e.0:   bridge window [mem 
0xfeb00000-0xfebfffff]
[    0.552415] pci 0000:00:1f.0: [8086:2641] type 00 class 0x060100 
conventional PCI endpoint
[    0.552610] pci 0000:00:1f.0: Force enabled HPET at 0xfed00000
[    0.552625] pci 0000:00:1f.0: quirk: [io  0x0800-0x087f] claimed by 
ICH6 ACPI/GPIO/TCO
[    0.552726] pci 0000:00:1f.0: quirk: [io  0x0480-0x04bf] claimed by 
ICH6 GPIO
[    0.552823] pci 0000:00:1f.0: LPC Generic IO decode 2 PIO at 
0a00-0a0f
[    0.553007] pci 0000:00:1f.1: [8086:266f] type 00 class 0x01018a 
conventional PCI endpoint
[    0.553125] pci 0000:00:1f.1: BAR 0 [io  0x0000-0x0007]
[    0.553203] pci 0000:00:1f.1: BAR 1 [io  0x0000-0x0003]
[    0.553279] pci 0000:00:1f.1: BAR 2 [io  0x0000-0x0007]
[    0.553356] pci 0000:00:1f.1: BAR 3 [io  0x0000-0x0003]
[    0.553434] pci 0000:00:1f.1: BAR 4 [io  0xffa0-0xffaf]
[    0.553522] pci 0000:00:1f.1: BAR 0 [io  0x01f0-0x01f7]: legacy IDE 
quirk
[    0.553616] pci 0000:00:1f.1: BAR 1 [io  0x03f6]: legacy IDE quirk
[    0.553687] pci 0000:00:1f.1: BAR 2 [io  0x0170-0x0177]: legacy IDE 
quirk
[    0.553781] pci 0000:00:1f.1: BAR 3 [io  0x0376]: legacy IDE quirk
[    0.553976] pci 0000:00:1f.2: [8086:2653] type 00 class 0x01018f 
conventional PCI endpoint
[    0.554093] pci 0000:00:1f.2: BAR 0 [io  0x9800-0x9807]
[    0.554170] pci 0000:00:1f.2: BAR 1 [io  0x9480-0x9483]
[    0.554247] pci 0000:00:1f.2: BAR 2 [io  0x9400-0x9407]
[    0.554323] pci 0000:00:1f.2: BAR 3 [io  0x9080-0x9083]
[    0.554398] pci 0000:00:1f.2: BAR 4 [io  0x9000-0x900f]
[    0.554474] pci 0000:00:1f.2: BAR 5 [mem 0xfe63b800-0xfe63bbff]
[    0.554579] pci 0000:00:1f.2: PME# supported from D3hot
[    0.554737] pci 0000:00:1f.3: [8086:266a] type 00 class 0x0c0500 
conventional PCI endpoint
[    0.554899] pci 0000:00:1f.3: BAR 4 [io  0x0400-0x041f]
[    0.555197] pci 0000:01:00.0: [8086:109a] type 00 class 0x020000 PCIe 
Endpoint
[    0.555331] pci 0000:01:00.0: BAR 0 [mem 0xfe7e0000-0xfe7fffff]
[    0.555437] pci 0000:01:00.0: BAR 2 [io  0xac00-0xac1f]
[    0.555658] pci 0000:01:00.0: PME# supported from D0 D3hot
[    0.555865] pci 0000:01:00.0: disabling ASPM on pre-1.1 PCIe device.  
You can enable it with 'pcie_aspm=force'
[    0.555997] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    0.556183] pci 0000:02:00.0: [8086:109a] type 00 class 0x020000 PCIe 
Endpoint
[    0.556314] pci 0000:02:00.0: BAR 0 [mem 0xfe8e0000-0xfe8fffff]
[    0.556419] pci 0000:02:00.0: BAR 2 [io  0xbc00-0xbc1f]
[    0.556640] pci 0000:02:00.0: PME# supported from D0 D3hot
[    0.556844] pci 0000:02:00.0: disabling ASPM on pre-1.1 PCIe device.  
You can enable it with 'pcie_aspm=force'
[    0.556971] pci 0000:00:1c.1: PCI bridge to [bus 02]
[    0.557136] pci 0000:03:00.0: [8086:109a] type 00 class 0x020000 PCIe 
Endpoint
[    0.557267] pci 0000:03:00.0: BAR 0 [mem 0xfe9e0000-0xfe9fffff]
[    0.557372] pci 0000:03:00.0: BAR 2 [io  0xcc00-0xcc1f]
[    0.557593] pci 0000:03:00.0: PME# supported from D0 D3hot
[    0.557792] pci 0000:03:00.0: disabling ASPM on pre-1.1 PCIe device.  
You can enable it with 'pcie_aspm=force'
[    0.557920] pci 0000:00:1c.2: PCI bridge to [bus 03]
[    0.558085] pci 0000:04:00.0: [8086:109a] type 00 class 0x020000 PCIe 
Endpoint
[    0.558214] pci 0000:04:00.0: BAR 0 [mem 0xfeae0000-0xfeafffff]
[    0.558329] pci 0000:04:00.0: BAR 2 [io  0xdc00-0xdc1f]
[    0.558553] pci 0000:04:00.0: PME# supported from D0 D3hot
[    0.558759] pci 0000:04:00.0: disabling ASPM on pre-1.1 PCIe device.  
You can enable it with 'pcie_aspm=force'
[    0.558888] pci 0000:00:1c.3: PCI bridge to [bus 04]
[    0.558987] pci_bus 0000:05: extended config space not accessible
[    0.559104] pci 0000:05:02.0: [8086:1229] type 00 class 0x020000 
conventional PCI endpoint
[    0.559223] pci 0000:05:02.0: BAR 0 [mem 0xfebff000-0xfebfffff]
[    0.559304] pci 0000:05:02.0: BAR 1 [io  0xec00-0xec3f]
[    0.559381] pci 0000:05:02.0: BAR 2 [mem 0xfebc0000-0xfebdffff]
[    0.559487] pci 0000:05:02.0: ROM [mem 0xfebe0000-0xfebeffff pref]
[    0.559590] pci 0000:05:02.0: supports D1 D2
[    0.559656] pci 0000:05:02.0: PME# supported from D0 D1 D2 D3hot 
D3cold
[    0.559882] pci 0000:05:03.0: [8086:1229] type 00 class 0x020000 
conventional PCI endpoint
[    0.560002] pci 0000:05:03.0: BAR 0 [mem 0xfebfe000-0xfebfefff]
[    0.560084] pci 0000:05:03.0: BAR 1 [io  0xe880-0xe8bf]
[    0.560162] pci 0000:05:03.0: BAR 2 [mem 0xfeba0000-0xfebbffff]
[    0.560267] pci 0000:05:03.0: ROM [mem 0xfeb90000-0xfeb9ffff pref]
[    0.560370] pci 0000:05:03.0: supports D1 D2
[    0.560436] pci 0000:05:03.0: PME# supported from D0 D1 D2 D3hot 
D3cold
[    0.560642] pci 0000:05:04.0: [8086:1229] type 00 class 0x020000 
conventional PCI endpoint
[    0.560761] pci 0000:05:04.0: BAR 0 [mem 0xfebfd000-0xfebfdfff]
[    0.560842] pci 0000:05:04.0: BAR 1 [io  0xe800-0xe83f]
[    0.560920] pci 0000:05:04.0: BAR 2 [mem 0xfeb60000-0xfeb7ffff]
[    0.561025] pci 0000:05:04.0: ROM [mem 0xfeb80000-0xfeb8ffff pref]
[    0.561130] pci 0000:05:04.0: supports D1 D2
[    0.561195] pci 0000:05:04.0: PME# supported from D0 D1 D2 D3hot 
D3cold
[    0.561404] pci 0000:05:05.0: [8086:1229] type 00 class 0x020000 
conventional PCI endpoint
[    0.561524] pci 0000:05:05.0: BAR 0 [mem 0xfebfc000-0xfebfcfff]
[    0.561632] pci 0000:05:05.0: BAR 1 [io  0xe480-0xe4bf]
[    0.561711] pci 0000:05:05.0: BAR 2 [mem 0xfeb40000-0xfeb5ffff]
[    0.561817] pci 0000:05:05.0: ROM [mem 0xfeb30000-0xfeb3ffff pref]
[    0.561920] pci 0000:05:05.0: supports D1 D2
[    0.561985] pci 0000:05:05.0: PME# supported from D0 D1 D2 D3hot 
D3cold
[    0.562216] pci 0000:00:1e.0: PCI bridge to [bus 05] (subtractive 
decode)
[    0.562322] pci 0000:00:1e.0:   bridge window [io  0x0000-0xffff] 
(subtractive decode)
[    0.562421] pci 0000:00:1e.0:   bridge window [mem 
0x00000000-0xffffffff] (subtractive decode)
[    0.562549] pci_bus 0000:00: busn_res: [bus 00-ff] end is updated to 
05
[    0.562710] pci 0000:00:1f.0: PIIX/ICH IRQ router [8086:2641]
[    0.562792] PCI: pci_cache_line_size set to 64 bytes
[    0.562880] e820: reserve RAM buffer [mem 0x0009fc00-0x0009ffff]
[    0.562888] e820: reserve RAM buffer [mem 0x3ff00000-0x3fffffff]
[    0.563020] pci 0000:00:02.0: vgaarb: setting as boot VGA device
[    0.563097] pci 0000:00:02.0: vgaarb: bridge control possible
[    0.563166] pci 0000:00:02.0: vgaarb: VGA device added: 
decodes=io+mem,owns=io+mem,locks=none
[    0.564971] vgaarb: loaded
[    0.565627] clocksource: hpet: mask: 0xffffffff max_cycles: 
0xffffffff, max_idle_ns: 133484882848 ns
[    0.565743] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.565821] hpet0: 3 comparators, 64-bit 14.318180 MHz counter
[    0.569359] clocksource: Switched to clocksource tsc-early
[    0.573946] VFS: Disk quotas dquot_6.6.0
[    0.574257] VFS: Dquot-cache hash table entries: 1024 (order 0, 4096 
bytes)
[    0.574450] pnp: PnP ACPI: disabled
[    0.580471] NET: Registered PF_INET protocol family
[    0.580783] IP idents hash table entries: 16384 (order: 5, 131072 
bytes, linear)
[    0.582635] tcp_listen_portaddr_hash hash table entries: 1024 (order: 
0, 4096 bytes, linear)
[    0.582758] Table-perturb hash table entries: 65536 (order: 6, 262144 
bytes, linear)
[    0.582859] TCP established hash table entries: 8192 (order: 3, 32768 
bytes, linear)
[    0.583006] TCP bind hash table entries: 8192 (order: 4, 65536 bytes, 
linear)
[    0.583210] TCP: Hash tables configured (established 8192 bind 8192)
[    0.583373] UDP hash table entries: 512 (order: 1, 8192 bytes, 
linear)
[    0.583688] UDP-Lite hash table entries: 512 (order: 1, 8192 bytes, 
linear)
[    0.584231] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.584346] NET: Registered PF_XDP protocol family
[    0.584437] pci 0000:00:1c.0: bridge window [mem 
0x00100000-0x000fffff 64bit pref] to [bus 01] add_size 200000 add_align 
100000
[    0.584557] pci 0000:00:1c.1: bridge window [mem 
0x00100000-0x000fffff 64bit pref] to [bus 02] add_size 200000 add_align 
100000
[    0.584670] pci 0000:00:1c.2: bridge window [mem 
0x00100000-0x000fffff 64bit pref] to [bus 03] add_size 200000 add_align 
100000
[    0.584781] pci 0000:00:1c.3: bridge window [mem 
0x00100000-0x000fffff 64bit pref] to [bus 04] add_size 200000 add_align 
100000
[    0.584916] pci 0000:00:1c.0: bridge window [mem 
0x40000000-0x401fffff 64bit pref]: assigned
[    0.585019] pci 0000:00:1c.1: bridge window [mem 
0x40200000-0x403fffff 64bit pref]: assigned
[    0.585119] pci 0000:00:1c.2: bridge window [mem 
0x40400000-0x405fffff 64bit pref]: assigned
[    0.585220] pci 0000:00:1c.3: bridge window [mem 
0x40600000-0x407fffff 64bit pref]: assigned
[    0.585325] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    0.585396] pci 0000:00:1c.0:   bridge window [io  0xa000-0xafff]
[    0.585472] pci 0000:00:1c.0:   bridge window [mem 
0xfe700000-0xfe7fffff]
[    0.585568] pci 0000:00:1c.0:   bridge window [mem 
0x40000000-0x401fffff 64bit pref]
[    0.585670] pci 0000:00:1c.1: PCI bridge to [bus 02]
[    0.585739] pci 0000:00:1c.1:   bridge window [io  0xb000-0xbfff]
[    0.585814] pci 0000:00:1c.1:   bridge window [mem 
0xfe800000-0xfe8fffff]
[    0.585909] pci 0000:00:1c.1:   bridge window [mem 
0x40200000-0x403fffff 64bit pref]
[    0.586011] pci 0000:00:1c.2: PCI bridge to [bus 03]
[    0.586079] pci 0000:00:1c.2:   bridge window [io  0xc000-0xcfff]
[    0.586154] pci 0000:00:1c.2:   bridge window [mem 
0xfe900000-0xfe9fffff]
[    0.586250] pci 0000:00:1c.2:   bridge window [mem 
0x40400000-0x405fffff 64bit pref]
[    0.586352] pci 0000:00:1c.3: PCI bridge to [bus 04]
[    0.586420] pci 0000:00:1c.3:   bridge window [io  0xd000-0xdfff]
[    0.586495] pci 0000:00:1c.3:   bridge window [mem 
0xfea00000-0xfeafffff]
[    0.587304] pci 0000:00:1c.3:   bridge window [mem 
0x40600000-0x407fffff 64bit pref]
[    0.587410] pci 0000:00:1e.0: PCI bridge to [bus 05]
[    0.587479] pci 0000:00:1e.0:   bridge window [io  0xe000-0xefff]
[    0.587556] pci 0000:00:1e.0:   bridge window [mem 
0xfeb00000-0xfebfffff]
[    0.587658] pci_bus 0000:00: resource 4 [io  0x0000-0xffff]
[    0.587729] pci_bus 0000:00: resource 5 [mem 0x00000000-0xffffffff]
[    0.587804] pci_bus 0000:01: resource 0 [io  0xa000-0xafff]
[    0.587874] pci_bus 0000:01: resource 1 [mem 0xfe700000-0xfe7fffff]
[    0.587946] pci_bus 0000:01: resource 2 [mem 0x40000000-0x401fffff 
64bit pref]
[    0.588042] pci_bus 0000:02: resource 0 [io  0xb000-0xbfff]
[    0.588111] pci_bus 0000:02: resource 1 [mem 0xfe800000-0xfe8fffff]
[    0.588184] pci_bus 0000:02: resource 2 [mem 0x40200000-0x403fffff 
64bit pref]
[    0.588279] pci_bus 0000:03: resource 0 [io  0xc000-0xcfff]
[    0.588349] pci_bus 0000:03: resource 1 [mem 0xfe900000-0xfe9fffff]
[    0.588422] pci_bus 0000:03: resource 2 [mem 0x40400000-0x405fffff 
64bit pref]
[    0.588518] pci_bus 0000:04: resource 0 [io  0xd000-0xdfff]
[    0.588588] pci_bus 0000:04: resource 1 [mem 0xfea00000-0xfeafffff]
[    0.588660] pci_bus 0000:04: resource 2 [mem 0x40600000-0x407fffff 
64bit pref]
[    0.588757] pci_bus 0000:05: resource 0 [io  0xe000-0xefff]
[    0.588827] pci_bus 0000:05: resource 1 [mem 0xfeb00000-0xfebfffff]
[    0.588899] pci_bus 0000:05: resource 4 [io  0x0000-0xffff]
[    0.588969] pci_bus 0000:05: resource 5 [mem 0x00000000-0xffffffff]
[    0.589113] pci 0000:00:1d.0: PCI->APIC IRQ transform: INT A -> IRQ 
23
[    0.589241] pci 0000:00:1d.7: PCI->APIC IRQ transform: INT A -> IRQ 
23
[    0.616749] pci 0000:00:1d.7: quirk_usb_early_handoff+0x0/0x7b4 took 
26869 usecs
[    0.616930] pci 0000:05:02.0: Firmware left e100 interrupts enabled; 
disabling
[    0.617039] pci 0000:05:03.0: Firmware left e100 interrupts enabled; 
disabling
[    0.617148] pci 0000:05:04.0: Firmware left e100 interrupts enabled; 
disabling
[    0.617255] pci 0000:05:05.0: Firmware left e100 interrupts enabled; 
disabling
[    0.617353] PCI: CLS 64 bytes, default 64
[    0.618461] Trying to unpack rootfs image as initramfs...
[    0.620263] platform rtc_cmos: registered platform RTC device (no PNP 
device found)
[    0.620698] PCLMULQDQ-NI instructions are not detected.
[    0.621945] Initialise system trusted keyrings
[    0.622052] Key type blacklist registered
[    0.626783] workingset: timestamp_bits=14 max_order=18 bucket_order=4
[    0.626892] zbud: loaded
[    0.897703] NET: Registered PF_ALG protocol family
[    0.897818] Key type asymmetric registered
[    0.897884] Asymmetric key parser 'x509' registered
[    0.897950] Asymmetric key parser 'pkcs8' registered
[    0.900111] Block layer SCSI generic (bsg) driver version 0.4 loaded 
(major 250)
[    0.900222] io scheduler mq-deadline registered
[    0.900288] io scheduler kyber registered
[    0.900583] io scheduler bfq registered
[    0.901244] xz_dec_test: module loaded
[    0.901313] xz_dec_test: Create a device node with 'mknod xz_dec_test 
c 249 0' and write .xz files to it.
[    0.901625] pcieport 0000:00:1c.0: PCI->APIC IRQ transform: INT A -> 
IRQ 16
[    0.903581] pcieport 0000:00:1c.1: PCI->APIC IRQ transform: INT B -> 
IRQ 17
[    0.903836] pcieport 0000:00:1c.2: PCI->APIC IRQ transform: INT C -> 
IRQ 18
[    0.904089] pcieport 0000:00:1c.3: PCI->APIC IRQ transform: INT D -> 
IRQ 19
[    0.905756] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    0.950115] serial8250: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 
115200) is a 16550A
[    0.954043] intel_rng: FWH not detected
[    0.970344] brd: module loaded
[    0.977815] loop: module loaded
[    0.980350] ahci 0000:00:1f.2: version 3.0
[    0.980390] ahci 0000:00:1f.2: PCI->APIC IRQ transform: INT B -> IRQ 
19
[    0.980570] ahci 0000:00:1f.2: forcing PORTS_IMPL to 0xf
[    0.980764] ahci 0000:00:1f.2: AHCI vers 0001.0000, 32 command slots, 
1.5 Gbps, IDE mode
[    0.980868] ahci 0000:00:1f.2: 4/4 ports implemented (port mask 0xf)
[    0.980940] ahci 0000:00:1f.2: flags: 64bit ncq pm led pmp slum part
[    0.987006] scsi host0: ahci
[    0.987923] scsi host1: ahci
[    0.988543] scsi host2: ahci
[    0.989193] scsi host3: ahci
[    0.989433] ata1: SATA max UDMA/133 abar m1024@0xfe63b800 port 
0xfe63b900 irq 19 lpm-pol 0
[    0.989540] ata2: SATA max UDMA/133 abar m1024@0xfe63b800 port 
0xfe63b980 irq 19 lpm-pol 0
[    0.989638] ata3: SATA max UDMA/133 abar m1024@0xfe63b800 port 
0xfe63ba00 irq 19 lpm-pol 0
[    0.989735] ata4: SATA max UDMA/133 abar m1024@0xfe63b800 port 
0xfe63ba80 irq 19 lpm-pol 0
[    0.990000] ata_piix 0000:00:1f.1: version 2.13
[    0.990038] ata_piix 0000:00:1f.1: PCI->APIC IRQ transform: INT A -> 
IRQ 18
[    0.994410] scsi host4: ata_piix
[    0.995439] scsi host5: ata_piix
[    0.995634] ata5: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0xffa0 
irq 14 lpm-pol 0
[    0.995734] ata6: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xffa8 
irq 15 lpm-pol 0
[    1.009487] wireguard: WireGuard 1.0.0 loaded. See www.wireguard.com 
for information.
[    1.009604] wireguard: Copyright (C) 2015-2019 Jason A. Donenfeld 
<Jason@zx2c4.com>. All Rights Reserved.
[    1.009711] MACsec IEEE 802.1AE
[    1.018561] tun: Universal TUN/TAP device driver, 1.6
[    1.026915] e100: Intel(R) PRO/100 Network Driver
[    1.027002] e100: Copyright(c) 1999-2006 Intel Corporation
[    1.027169] e100 0000:05:02.0: PCI->APIC IRQ transform: INT A -> IRQ 
16
[    1.087030] e100 0000:05:02.0 eth0: addr 0xfebff000, irq 16, MAC addr 
00:04:a7:0a:03:34
[    1.087256] e100 0000:05:03.0: PCI->APIC IRQ transform: INT A -> IRQ 
17
[    1.140370] e100 0000:05:03.0 eth1: addr 0xfebfe000, irq 17, MAC addr 
00:04:a7:0a:03:35
[    1.140588] e100 0000:05:04.0: PCI->APIC IRQ transform: INT A -> IRQ 
18
[    1.160414] ata5.01: CFA: TRANSCEND, 20080820, max UDMA/66
[    1.160513] ata5.01: 15662304 sectors, multi 0: LBA
[    1.194258] e100 0000:05:04.0 eth2: addr 0xfebfd000, irq 18, MAC addr 
00:04:a7:0a:03:36
[    1.194481] e100 0000:05:05.0: PCI->APIC IRQ transform: INT A -> IRQ 
19
[    1.247364] e100 0000:05:05.0 eth3: addr 0xfebfc000, irq 19, MAC addr 
00:04:a7:0a:03:37
[    1.247569] e1000: Intel(R) PRO/1000 Network Driver
[    1.247640] e1000: Copyright (c) 1999-2006 Intel Corporation.
[    1.247767] e1000e: Intel(R) PRO/1000 Network Driver
[    1.247834] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    1.247979] e1000e 0000:01:00.0: PCI->APIC IRQ transform: INT A -> 
IRQ 16
[    1.248202] e1000e 0000:01:00.0: Interrupt Throttling Rate (ints/sec) 
set to dynamic conservative mode
[    1.306756] ata3: SATA link down (SStatus 0 SControl 300)
[    1.306886] ata1: SATA link down (SStatus 0 SControl 300)
[    1.354230] e1000e 0000:01:00.0 eth4: (PCI Express:2.5GT/s:Width x1) 
00:04:a7:08:c5:b4
[    1.354353] e1000e 0000:01:00.0 eth4: Intel(R) PRO/1000 Network 
Connection
[    1.354517] e1000e 0000:01:00.0 eth4: MAC: 2, PHY: 2, PBA No: 
FFFFFF-0FF
[    1.354702] e1000e 0000:02:00.0: PCI->APIC IRQ transform: INT A -> 
IRQ 17
[    1.354926] e1000e 0000:02:00.0: Interrupt Throttling Rate (ints/sec) 
set to dynamic conservative mode
[    1.467667] e1000e 0000:02:00.0 eth5: (PCI Express:2.5GT/s:Width x1) 
00:04:a7:08:c5:b5
[    1.467790] e1000e 0000:02:00.0 eth5: Intel(R) PRO/1000 Network 
Connection
[    1.467954] e1000e 0000:02:00.0 eth5: MAC: 2, PHY: 2, PBA No: 
FFFFFF-0FF
[    1.468138] e1000e 0000:03:00.0: PCI->APIC IRQ transform: INT A -> 
IRQ 18
[    1.468366] e1000e 0000:03:00.0: Interrupt Throttling Rate (ints/sec) 
set to dynamic conservative mode
[    1.581384] e1000e 0000:03:00.0 eth6: (PCI Express:2.5GT/s:Width x1) 
00:04:a7:08:c5:b6
[    1.581511] e1000e 0000:03:00.0 eth6: Intel(R) PRO/1000 Network 
Connection
[    1.581676] e1000e 0000:03:00.0 eth6: MAC: 2, PHY: 2, PBA No: 
FFFFFF-0FF
[    1.581861] e1000e 0000:04:00.0: PCI->APIC IRQ transform: INT A -> 
IRQ 19
[    1.582109] e1000e 0000:04:00.0: Interrupt Throttling Rate (ints/sec) 
set to dynamic conservative mode
[    1.614020] tsc: Refined TSC clocksource calibration: 1000.035 MHz
[    1.614127] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 
0xe6a38202b4, max_idle_ns: 440795212232 ns
[    1.614239] clocksource: Switched to clocksource tsc
[    1.694304] e1000e 0000:04:00.0 eth7: (PCI Express:2.5GT/s:Width x1) 
00:04:a7:08:c5:b7
[    1.694426] e1000e 0000:04:00.0 eth7: Intel(R) PRO/1000 Network 
Connection
[    1.694590] e1000e 0000:04:00.0 eth7: MAC: 2, PHY: 2, PBA No: 
FFFFFF-0FF
[    1.694787] igb: Intel(R) Gigabit Ethernet Network Driver
[    1.694859] igb: Copyright (c) 2007-2014 Intel Corporation.
[    1.694974] Intel(R) 2.5G Ethernet Linux Driver
[    1.695039] Copyright(c) 2018 Intel Corporation.
[    1.695135] ixgbe: Intel(R) 10 Gigabit PCI Express Network Driver
[    1.695207] ixgbe: Copyright (c) 1999-2016 Intel Corporation.
[    1.695741] i40e: Intel(R) Ethernet Connection XL710 Network Driver
[    1.695823] i40e: Copyright (c) 2013 - 2019 Intel Corporation.
[    1.696061] sky2: driver version 1.30
[    1.697546] PPP generic driver version 2.4.2
[    1.698168] PPP BSD Compression module registered
[    1.698242] PPP Deflate Compression module registered
[    1.698310] NET: Registered PF_PPPOX protocol family
[    1.698404] PPTP driver version 0.8.5
[    1.701079] uhci_hcd 0000:00:1d.0: PCI->APIC IRQ transform: INT A -> 
IRQ 23
[    1.701232] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[    1.701471] ehci-pci 0000:00:1d.7: PCI->APIC IRQ transform: INT A -> 
IRQ 23
[    1.701899] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned 
bus number 1
[    1.702052] uhci_hcd 0000:00:1d.0: irq 23, io port 0x00009880
[    1.702763] hub 1-0:1.0: USB hub found
[    1.702854] hub 1-0:1.0: 2 ports detected
[    1.704774] ehci-pci 0000:00:1d.7: EHCI Host Controller
[    1.705229] ehci-pci 0000:00:1d.7: new USB bus registered, assigned 
bus number 2
[    1.705364] ehci-pci 0000:00:1d.7: debug port 1
[    1.707473] usbcore: registered new interface driver usb-storage
[    1.707825] i8042: PNP: No PS/2 controller found.
[    1.707892] i8042: Probing ports directly.
[    1.714921] serio: i8042 KBD port at 0x60,0x64 irq 1
[    1.715063] ehci-pci 0000:00:1d.7: irq 23, io mem 0xfe63bc00
[    1.715235] serio: i8042 AUX port at 0x60,0x64 irq 12
[    1.716149] mousedev: PS/2 mouse device common for all mice
[    1.716867] rtc_cmos rtc_cmos: registered as rtc0
[    1.716984] rtc_cmos rtc_cmos: setting system clock to 
2024-04-05T10:44:26 UTC (1712313866)
[    1.717205] rtc_cmos rtc_cmos: alarms up to one day, 114 bytes nvram, 
hpet irqs
[    1.717660] i2c_dev: i2c /dev entries driver
[    1.721521] hid: raw HID events driver (C) Jiri Kosina
[    1.721671] usbcore: registered new interface driver usbhid
[    1.721743] usbhid: USB HID core driver
[    1.721866] GACT probability on
[    1.721949] Mirror/redirect action on
[    1.722028] Simple TC action Loaded
[    1.722531] netem: version 1.3
[    1.722642] u32 classifier
[    1.722702]     Performance counters on
[    1.722763]     input device check on
[    1.722824]     Actions configured
[    1.723515] xt_time: kernel timezone is -0000
[    1.723842] ipip: IPv4 and MPLS over IPv4 tunneling driver
[    1.724217] i801_smbus 0000:00:1f.3: PCI->APIC IRQ transform: INT B 
-> IRQ 19
[    1.724357] i801_smbus 0000:00:1f.3: SMBus using PCI interrupt
[    1.727386] ehci-pci 0000:00:1d.7: USB 2.0 started, EHCI 1.00
[    1.728080] hub 2-0:1.0: USB hub found
[    1.728222] hub 2-0:1.0: 2 ports detected
[    1.728804] hub 1-0:1.0: USB hub found
[    1.729288] gre: GRE over IPv4 demultiplexor driver
[    1.729363] ip_gre: GRE over IPv4 tunneling driver
[    1.729757] hub 1-0:1.0: 2 ports detected
[    1.735716] IPv4 over IPsec tunneling driver
[    1.736224] Initializing XFRM netlink socket
[    1.736314] IPsec XFRM device driver
[    1.736388] IPv6: Loaded, but administratively disabled, reboot 
required to enable
[    1.736484] IPv6: ah6_init: can't add xfrm type
[    1.737442] IPv6: esp6_init: can't add xfrm type
[    1.737509] IPv6: ipcomp6_init: can't add xfrm type
[    1.745348] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[    1.745755] ip6_gre: GRE over IPv6 tunneling driver
[    1.746196] NET: Registered PF_PACKET protocol family
[    1.746278] NET: Registered PF_KEY protocol family
[    1.746391] Bridge firewalling registered
[    1.747571] NET: Registered PF_KCM protocol family
[    1.747764] l2tp_core: L2TP core driver, V2.0
[    1.747840] l2tp_ppp: PPPoL2TP kernel driver, V2.0
[    1.747905] l2tp_ip: L2TP IP encapsulation support (L2TPv3)
[    1.747986] l2tp_netlink: L2TP netlink interface
[    1.748089] l2tp_eth: L2TP ethernet pseudowire support (L2TPv3)
[    1.748159] l2tp_ip6: L2TP IP encapsulation support for IPv6 (L2TPv3)
[    1.748440] 8021q: 802.1Q VLAN Support v1.8
[    1.751499] microcode: Current revision: 0x00000000
[    1.780052] sched_clock: Marking stable (1766683546, 
10637291)->(1782065924, -4745087)
[    1.787675] Loading compiled-in X.509 certificates
[    1.801719] Key type .fscrypt registered
[    1.801808] Key type fscrypt-provisioning registered
[    1.977379] usb 2-1: new high-speed USB device number 2 using 
ehci-pci
[    2.007360] ata2: failed to resume link (SControl 0)
[    2.007466] ata2: SATA link down (SStatus 0 SControl 0)
[    2.007560] ata4: failed to resume link (SControl 0)
[    2.007637] ata4: SATA link down (SStatus 0 SControl 0)
[    2.014675] scsi 4:0:1:0: Direct-Access     ATA      TRANSCEND        
0820 PQ: 0 ANSI: 5
[    2.015504] sd 4:0:1:0: [sda] 15662304 512-byte logical blocks: (8.02 
GB/7.47 GiB)
[    2.015640] sd 4:0:1:0: [sda] Write Protect is off
[    2.015710] sd 4:0:1:0: [sda] Mode Sense: 00 3a 00 00
[    2.015740] sd 4:0:1:0: [sda] Write cache: disabled, read cache: 
enabled, doesn't support DPO or FUA
[    2.015878] sd 4:0:1:0: [sda] Preferred minimum I/O size 512 bytes
[    2.019446]  sda: sda1
[    2.019921] sd 4:0:1:0: [sda] Attached SCSI disk
[    2.024502] sd 4:0:1:0: Attached scsi generic sg0 type 0
[    2.127200] usb-storage 2-1:1.0: USB Mass Storage device detected
[    2.127715] scsi host6: usb-storage 2-1:1.0
[    2.404060] usb 1-2: new low-speed USB device number 2 using uhci_hcd
[    2.660713] input: HID 046a:0011 as 
/devices/pci0000:00/0000:00:1d.0/usb1/1-2/1-2:1.0/0003:046A:0011.0001/input/input2
[    2.724338] hid-generic 0003:046A:0011.0001: input,hidraw0: USB HID 
v1.11 Keyboard [HID 046a:0011] on usb-0000:00:1d.0-2/input0
[    3.134868] scsi 6:0:0:0: Direct-Access     Kingston DataTraveler 2.0 
1.00 PQ: 0 ANSI: 2
[    3.135709] sd 6:0:0:0: Attached scsi generic sg1 type 0
[    3.138335] sd 6:0:0:0: [sdb] 2007040 512-byte logical blocks: (1.03 
GB/980 MiB)
[    3.139098] sd 6:0:0:0: [sdb] Write Protect is off
[    3.139181] sd 6:0:0:0: [sdb] Mode Sense: 23 00 00 00
[    3.139853] sd 6:0:0:0: [sdb] No Caching mode page found
[    3.139937] sd 6:0:0:0: [sdb] Assuming drive cache: write through
[    3.147229]  sdb: sdb1
[    3.147571] sd 6:0:0:0: [sdb] Attached SCSI removable disk
[    7.764790] Freeing initrd memory: 91572K
[    7.855862] Key type encrypted registered
[    7.856266] gtp: GTP module loaded (pdp ctx size 60 bytes)
[    7.856513] clk: Disabling unused clocks
[    7.857122] Freeing unused kernel image (initmem) memory: 632K
[    7.857773] Write protecting kernel text and read-only data: 16000k
[    7.857865] rodata_test: all tests were successful
[    7.857942] Run /init as init process
[    7.858004]   with arguments:
[    7.858007]     /init
[    7.858010]   with environment:
[    7.858013]     HOME=/
[    7.858017]     TERM=linux
[    7.858020]     BOOT_IMAGE=kernel
[   12.323994] random: crng init done


-- 
Wolfgang Walter
Studierendenwerk München Oberbayern
Anstalt des öffentlichen Rechts

