Return-Path: <stable+bounces-50154-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10757903B8D
	for <lists+stable@lfdr.de>; Tue, 11 Jun 2024 14:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED895B25436
	for <lists+stable@lfdr.de>; Tue, 11 Jun 2024 12:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B864A176ACC;
	Tue, 11 Jun 2024 12:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="sV+DGDCP"
X-Original-To: stable@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECD01514FA;
	Tue, 11 Jun 2024 12:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718107675; cv=none; b=AOYUW1jKJqSGPLkU2Vj0Rcc80oJKGNYypvX8YUuxzRedDZmQ15YKfJcMJCd9eZI4ZcChBwrtsqiZHO3m93IzpXpeLwRQ8W1VBc8cTPMXuvdei6OFnw/fDojpqDBQuz7+gL8jTcYdpSR4kjxvSx+dZHUHEj174FYDssDsoaQhHG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718107675; c=relaxed/simple;
	bh=uYcfJNKIV2ofDBT4CJD/9cXPHKV+Rv1HJbGLnLsAm6U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eiXZEMK5OoWWwJxFOWKCe9XD9kNp0vsSNktHcafW5tLsL8EJNeJIL6Q8qizvrgV5JPmYkGtfCTyxiAu6YIxOK65OM9UMxSO5y11RiLyol9lh5go5/RNsnSiGpN5h2aGPJpe+1IoGFjMlvOqy45m+WaAIZjaWySVsa9YpUXSl/ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=sV+DGDCP; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=fIC0UgWlxbpfcXGZBxJ/QjoEf6QtYYWaAgxkHaVDjw0=;
	t=1718107671; x=1718539671; b=sV+DGDCPkpoEOke0nYgalP6hShplHH6akCrNdO+63mXWTo1
	muSRFIsbW3KBO9ElMHzewd1kwpqztCW25LLtjyekaFlhSu4iSwF1sJPaJynQ02C4ip+naQYfC5iJh
	/hxz3THHA2ElVD1DEBA1Y/ojYDIMi19t8/x1dBVAbqCGGtz/ldBat/bryYf9Y4SUy5V5qpqt6jDyd
	DzYSS7DahfGsFZpMTdISSe8nBqcIH1wjNBw4z0Kh2ZoOtzpi+WyBqyVP5UjdEDYWGbNf1cREAfotf
	5LkIMdWa64Azait4x/WP6jS+g7xe3wqMNp1qIyA84X+mccEbBpLntXGBXRU7BVLw==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sH0I1-00010v-K3; Tue, 11 Jun 2024 14:07:49 +0200
Message-ID: <48704859-47f7-435e-8a5f-bff333a60e98@leemhuis.info>
Date: Tue, 11 Jun 2024 14:07:49 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Plymouth not showing during boot on a rpi cm4 since kernel 5.15
To: Jonas Kvinge <jonaski@opensuse.org>, stable@vger.kernel.org
Cc: regressions@lists.linux.dev
References: <a3c17f5bf8bab1141ea9126277fb912d7d6efb18.camel@opensuse.org>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <a3c17f5bf8bab1141ea9126277fb912d7d6efb18.camel@opensuse.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1718107671;94fe9fc1;
X-HE-SMSGID: 1sH0I1-00010v-K3

[side note: anyone that replies, please drop the stable list, this has
nothing to do with the stable trees afaics]

On 11.06.24 13:51, Jonas Kvinge wrote:
> 
> A blank black screen is shown during boot instead of showing Plymouth.
> This is on a Raspberry Pi Compute Module 4 with a sourcekit.io board,
> this started happening since kernel 5.15. I'm using openSUSE Tumbleweed
> currently with kernel 6.9.3, I've tried both the default and vanilla
> kernel. If I press ESC once I can see the boot messages, if I press ESC
> again the plymouth logo is shown, so there it seems that something
> might be interrupting plymouth. The root partition is luks encrypted,
> it will wait for the password during boot, so it's easy to see whether
> plymouth initially shows or not.
> I've built kernel 5.14 on the same system, and confirmed plymouth
> works. I've also built kernel 5.15 and confirmed that it no longer
> works.

Are you sure you are running vanilla Linux kernels? From quick googling
it sounds like the cm4 is only supported since 5.16, but I might have
been mislead or something.

Anyway: to get some developer interested in this report, you might have
to perform a bisection
(https://docs.kernel.org/admin-guide/verify-bugs-and-bisect-regressions.html
) to find the change that broke things. But after all that time that
might not even help much. :-/

Ciao, Thorsten

> I've compared the source for the 5.14 and 5.14 kernel and can see that
> there has been some work done to the firmware framebuffer stuff.
> Could anyone hint any possible source code changes that might have
> caused this, I can try source code changes but I need some advice where
> to go from here.
> 
> I'm using the following cmdline options:
> systemd.show_status=0 vt.global_cursor_default=0 plymouth.ignore-
> serial-consoles video=HDMI-A-1:1920x1080M@60,rotate=90 fsck.mode=force
> fsck.repair=yes cgroup_enable=memory swapaccount=1 net.ifnames=0
> rd.neednet=1 ip=192.168.250.20::192.168.250.200:255.255.255.0::eth0:off
> quiet splash
> 
> Boot log:
> 
> <6>[    0.000000] [    T0] Booting Linux on physical CPU 0x0000000000
> [0x410fd083]
> <5>[    0.000000] [    T0] Linux version 6.9.3-7.g97b471a-vanilla
> (geeko@buildhost) (gcc (SUSE Linux) 13.3.0, GNU ld (GNU Binutils;
> openSUSE Tumbleweed) 2.42.0.20240130-3) #1 SMP PREEMPT_DYNAMIC Wed Jun
> 5 05:47:57 UTC 2024 (97b471a)
> <6>[    0.000000] [    T0] KASLR enabled
> <5>[    0.000000] [    T0] random: crng init done
> <6>[    0.000000] [    T0] Machine model: Raspberry Pi Compute Module 4
> Rev 1.0
> <6>[    0.000000] [    T0] efi: EFI v2.10 by Das U-Boot
> <6>[    0.000000] [    T0] efi: TPMFinalLog=0x3cad3040
> RTPROP=0x3cad1040 SMBIOS 3.0=0x3db45000 TPMEventLog=0x2f00f040
> RNG=0x3a87b040 MEMRESERVE=0x2f00e040 
> <6>[    0.000000] [    T0] Reserved memory: created CMA memory pool at
> 0x000000002ae00000, size 64 MiB
> <6>[    0.000000] [    T0] OF: reserved mem: initialized node
> linux,cma, compatible id shared-dma-pool
> <6>[    0.000000] [    T0] OF: reserved mem:
> 0x000000002ae00000..0x000000002edfffff (65536 KiB) map reusable
> linux,cma
> <6>[    0.000000] [    T0] OF: reserved mem:
> 0x000000003ef643e0..0x000000003ef645df (0 KiB) nomap non-reusable
> nvram@1
> <6>[    0.000000] [    T0] OF: reserved mem:
> 0x000000003ef64620..0x000000003ef647d2 (0 KiB) nomap non-reusable
> nvram@0
> <6>[    0.000000] [    T0] NUMA: No NUMA configuration found
> <6>[    0.000000] [    T0] NUMA: Faking a node at [mem
> 0x0000000000000000-0x00000000fbffffff]
> <6>[    0.000000] [    T0] NUMA: NODE_DATA [mem 0xfb7e5ac0-0xfb7eafff]
> <6>[    0.000000] [    T0] Zone ranges:
> <6>[    0.000000] [    T0]   DMA      [mem 0x0000000000000000-
> 0x000000003fffffff]
> <6>[    0.000000] [    T0]   DMA32    [mem 0x0000000040000000-
> 0x00000000fbffffff]
> <6>[    0.000000] [    T0]   Normal   empty
> <6>[    0.000000] [    T0]   Device   empty
> <6>[    0.000000] [    T0] Movable zone start for each node
> <6>[    0.000000] [    T0] Early memory node ranges
> <6>[    0.000000] [    T0]   node   0: [mem 0x0000000000000000-
> 0x0000000000000fff]
> <6>[    0.000000] [    T0]   node   0: [mem 0x0000000000001000-
> 0x000000003cad0fff]
> <6>[    0.000000] [    T0]   node   0: [mem 0x000000003cad1000-
> 0x000000003cad1fff]
> <6>[    0.000000] [    T0]   node   0: [mem 0x000000003cad2000-
> 0x000000003cad2fff]
> <6>[    0.000000] [    T0]   node   0: [mem 0x000000003cad3000-
> 0x000000003cae3fff]
> <6>[    0.000000] [    T0]   node   0: [mem 0x000000003cae4000-
> 0x000000003caf5fff]
> <6>[    0.000000] [    T0]   node   0: [mem 0x000000003caf6000-
> 0x000000003cb17fff]
> <6>[    0.000000] [    T0]   node   0: [mem 0x000000003cb18000-
> 0x000000003db44fff]
> <6>[    0.000000] [    T0]   node   0: [mem 0x000000003db45000-
> 0x000000003db45fff]
> <6>[    0.000000] [    T0]   node   0: [mem 0x000000003db46000-
> 0x000000003df2ffff]
> <6>[    0.000000] [    T0]   node   0: [mem 0x000000003df30000-
> 0x000000003df3ffff]
> <6>[    0.000000] [    T0]   node   0: [mem 0x000000003df40000-
> 0x000000003dffffff]
> <6>[    0.000000] [    T0]   node   0: [mem 0x000000003ef64000-
> 0x000000003ef64fff]
> <6>[    0.000000] [    T0]   node   0: [mem 0x0000000040000000-
> 0x00000000fbffffff]
> <6>[    0.000000] [    T0] Initmem setup node 0 [mem
> 0x0000000000000000-0x00000000fbffffff]
> <6>[    0.000000] [    T0] On node 0, zone DMA: 3940 pages in
> unavailable ranges
> <6>[    0.000000] [    T0] On node 0, zone DMA32: 4251 pages in
> unavailable ranges
> <6>[    0.000000] [    T0] On node 0, zone DMA32: 16384 pages in
> unavailable ranges
> <6>[    0.000000] [    T0] percpu: Embedded 34 pages/cpu s101672 r8192
> d29400 u139264
> <7>[    0.000000] [    T0] pcpu-alloc: s101672 r8192 d29400 u139264
> alloc=34*4096
> <7>[    0.000000] [    T0] pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3 
> <6>[    0.000000] [    T0] Detected PIPT I-cache on CPU0
> <6>[    0.000000] [    T0] CPU features: detected: Spectre-v2
> <6>[    0.000000] [    T0] CPU features: detected: Spectre-v3a
> <6>[    0.000000] [    T0] CPU features: detected: Spectre-v4
> <6>[    0.000000] [    T0] CPU features: detected: Spectre-BHB
> <6>[    0.000000] [    T0] CPU features: kernel page table isolation
> forced ON by KASLR
> <6>[    0.000000] [    T0] CPU features: detected: Kernel page table
> isolation (KPTI)
> <6>[    0.000000] [    T0] CPU features: detected: ARM erratum 1742098
> <6>[    0.000000] [    T0] CPU features: detected: ARM errata 1165522,
> 1319367, or 1530923
> <6>[    0.000000] [    T0] alternatives: applying boot alternatives
> <5>[    0.000000] [    T0] Kernel command line: BOOT_IMAGE=/Image-
> 6.9.3-7.g97b471a-vanilla root=UUID=6d048af7-a4ba-4e50-8808-d686e13c286e
> systemd.show_status=0 vt.global_cursor_default=0 plymouth.ignore-
> serial-consoles video=HDMI-A-1:1920x1080M@60,rotate=90 fsck.mode=force
> fsck.repair=yes cgroup_enable=memory swapaccount=1 net.ifnames=0
> rd.neednet=1 ip=192.168.250.20::192.168.250.200:255.255.255.0::eth0:off
> quiet splash
> <5>[    0.000000] [    T0] Unknown kernel command line parameters
> "splash BOOT_IMAGE=/Image-6.9.3-7.g97b471a-vanilla cgroup_enable=memory
> ip=192.168.250.20::192.168.250.200:255.255.255.0::eth0:off", will be
> passed to user space.
> <6>[    0.000000] [    T0] Dentry cache hash table entries: 524288
> (order: 10, 4194304 bytes, linear)
> <6>[    0.000000] [    T0] Inode-cache hash table entries: 262144
> (order: 9, 2097152 bytes, linear)
> <6>[    0.000000] [    T0] Fallback order for Node 0: 0 
> <6>[    0.000000] [    T0] Built 1 zonelists, mobility grouping on. 
> Total pages: 1007873
> <6>[    0.000000] [    T0] Policy zone: DMA32
> <6>[    0.000000] [    T0] mem auto-init: stack:off, heap alloc:off,
> heap free:off
> <6>[    0.000000] [    T0] software IO TLB: area num 4.
> <6>[    0.000000] [    T0] software IO TLB: mapped [mem
> 0x000000003687b000-0x000000003a87b000] (64MB)
> <6>[    0.000000] [    T0] Memory: 935900K/4096004K available (15680K
> kernel code, 3632K rwdata, 15504K rodata, 10880K init, 1192K bss,
> 226888K reserved, 65536K cma-reserved)
> <6>[    0.000000] [    T0] SLUB: HWalign=64, Order=0-3, MinObjects=0,
> CPUs=4, Nodes=1
> <6>[    0.000000] [    T0] ftrace: allocating 51996 entries in 204
> pages
> <6>[    0.000000] [    T0] ftrace: allocated 204 pages with 4 groups
> <6>[    0.000000] [    T0] trace event string verifier disabled
> <6>[    0.000000] [    T0] Dynamic Preempt: voluntary
> <6>[    0.000000] [    T0] rcu: Preemptible hierarchical RCU
> implementation.
> <6>[    0.000000] [    T0] rcu:         RCU event tracing is enabled.
> <6>[    0.000000] [    T0] rcu:         RCU restricting CPUs from
> NR_CPUS=480 to nr_cpu_ids=4.
> <6>[    0.000000] [    T0]      Trampoline variant of Tasks RCU
> enabled.
> <6>[    0.000000] [    T0]      Rude variant of Tasks RCU enabled.
> <6>[    0.000000] [    T0]      Tracing variant of Tasks RCU enabled.
> <6>[    0.000000] [    T0] rcu: RCU calculated value of scheduler-
> enlistment delay is 30 jiffies.
> <6>[    0.000000] [    T0] rcu: Adjusting geometry for
> rcu_fanout_leaf=16, nr_cpu_ids=4
> <6>[    0.000000] [    T0] RCU Tasks: Setting shift to 2 and lim to 1
> rcu_task_cb_adjust=1.
> <6>[    0.000000] [    T0] RCU Tasks Rude: Setting shift to 2 and lim
> to 1 rcu_task_cb_adjust=1.
> <6>[    0.000000] [    T0] RCU Tasks Trace: Setting shift to 2 and lim
> to 1 rcu_task_cb_adjust=1.
> <6>[    0.000000] [    T0] NR_IRQS: 64, nr_irqs: 64, preallocated irqs:
> 0
> <6>[    0.000000] [    T0] Root IRQ handler: gic_handle_irq
> <6>[    0.000000] [    T0] GIC: Using split EOI/Deactivate mode
> <6>[    0.000000] [    T0] rcu: srcu_init: Setting srcu_struct sizes
> based on contention.
> <6>[    0.000000] [    T0] arch_timer: cp15 timer(s) running at
> 54.00MHz (phys).
> <6>[    0.000000] [    T0] clocksource: arch_sys_counter: mask:
> 0xffffffffffffff max_cycles: 0xc743ce346, max_idle_ns: 440795203123 ns
> <6>[    0.000000] [    T0] sched_clock: 56 bits at 54MHz, resolution
> 18ns, wraps every 4398046511102ns
> <6>[    0.000358] [    T0] Console: colour dummy device 80x25
> <6>[    0.000366] [    T0] printk: legacy console [tty0] enabled
> <6>[    0.000498] [    T0] Calibrating delay loop (skipped), value
> calculated using timer frequency.. 108.50 BogoMIPS (lpj=180000)
> <6>[    0.000509] [    T0] pid_max: default: 32768 minimum: 301
> <6>[    0.000620] [    T0] LSM: initializing
> lsm=lockdown,capability,landlock,yama,apparmor,tomoyo,bpf,ima,evm
> <6>[    0.000653] [    T0] landlock: Up and running.
> <6>[    0.000656] [    T0] Yama: becoming mindful.
> <6>[    0.000727] [    T0] AppArmor: AppArmor initialized
> <6>[    0.000732] [    T0] TOMOYO Linux initialized
> <6>[    0.000756] [    T0] LSM support for eBPF active
> <6>[    0.000882] [    T0] Mount-cache hash table entries: 8192 (order:
> 4, 65536 bytes, linear)
> <6>[    0.000911] [    T0] Mountpoint-cache hash table entries: 8192
> (order: 4, 65536 bytes, linear)
> <6>[    0.002423] [    T1] rcu: Hierarchical SRCU implementation.
> <6>[    0.002433] [    T1] rcu:         Max phase no-delay instances is
> 1000.
> <6>[    0.004884] [    T1] Remapping and enabling EFI services.
> <6>[    0.005182] [    T1] smp: Bringing up secondary CPUs ...
> <6>[    0.005537] [    T0] Detected PIPT I-cache on CPU1
> <6>[    0.005612] [    T0] CPU1: Booted secondary processor
> 0x0000000001 [0x410fd083]
> <6>[    0.006029] [    T0] Detected PIPT I-cache on CPU2
> <6>[    0.006072] [    T0] CPU2: Booted secondary processor
> 0x0000000002 [0x410fd083]
> <6>[    0.006446] [    T0] Detected PIPT I-cache on CPU3
> <6>[    0.006492] [    T0] CPU3: Booted secondary processor
> 0x0000000003 [0x410fd083]
> <6>[    0.006554] [    T1] smp: Brought up 1 node, 4 CPUs
> <6>[    0.006562] [    T1] SMP: Total of 4 processors activated.
> <6>[    0.006565] [    T1] CPU: All CPU(s) started at EL2
> <6>[    0.006578] [    T1] CPU features: detected: 32-bit EL0 Support
> <6>[    0.006581] [    T1] CPU features: detected: 32-bit EL1 Support
> <6>[    0.006586] [    T1] CPU features: detected: CRC32 instructions
> <6>[    0.006623] [    T1] alternatives: applying system-wide
> alternatives
> <6>[    0.007201] [    T1] CPU features: emulated: Privileged Access
> Never (PAN) using TTBR0_EL1 switching
> <6>[    0.064229] [   T36] node 0 deferred pages initialised in 57ms
> <6>[    0.065222] [    T1] devtmpfs: initialized
> <6>[    0.071159] [    T1] clocksource: jiffies: mask: 0xffffffff
> max_cycles: 0xffffffff, max_idle_ns: 6370867519511994 ns
> <6>[    0.071185] [    T1] futex hash table entries: 1024 (order: 4,
> 65536 bytes, linear)
> <6>[    0.072303] [    T1] pinctrl core: initialized pinctrl subsystem
> <6>[    0.073590] [    T1] SMBIOS 3.7.0 present.
> <6>[    0.073606] [    T1] DMI: raspberrypi rpi/rpi, BIOS 2024.04
> 04/01/2024
> <6>[    0.075227] [    T1] NET: Registered PF_NETLINK/PF_ROUTE protocol
> family
> <6>[    0.075784] [    T1] DMA: preallocated 512 KiB GFP_KERNEL pool
> for atomic allocations
> <6>[    0.075860] [    T1] DMA: preallocated 512 KiB GFP_KERNEL|GFP_DMA
> pool for atomic allocations
> <6>[    0.075963] [    T1] DMA: preallocated 512 KiB
> GFP_KERNEL|GFP_DMA32 pool for atomic allocations
> <6>[    0.075991] [    T1] audit: initializing netlink subsys
> (disabled)
> <5>[    0.076120] [   T40] audit: type=2000 audit(0.073:1):
> state=initialized audit_enabled=0 res=1
> <6>[    0.076970] [    T1] thermal_sys: Registered thermal governor
> 'fair_share'
> <6>[    0.076977] [    T1] thermal_sys: Registered thermal governor
> 'bang_bang'
> <6>[    0.076981] [    T1] thermal_sys: Registered thermal governor
> 'step_wise'
> <6>[    0.076984] [    T1] thermal_sys: Registered thermal governor
> 'user_space'
> <6>[    0.077024] [    T1] cpuidle: using governor ladder
> <6>[    0.077040] [    T1] cpuidle: using governor menu
> <6>[    0.077215] [    T1] hw-breakpoint: found 6 breakpoint and 4
> watchpoint registers.
> <6>[    0.077271] [    T1] ASID allocator initialised with 32768
> entries
> <6>[    0.078175] [    T1] Serial: AMBA PL011 UART driver
> <6>[    0.087446] [    T1] platform fd500000.pcie: Fixed dependency
> cycle(s) with /scb/pcie@7d500000
> <6>[    0.089363] [    T1] Modules: 2G module region forced by
> RANDOMIZE_MODULE_REGION_FULL
> <6>[    0.089370] [    T1] Modules: 0 pages in range for non-PLT usage
> <6>[    0.089372] [    T1] Modules: 512496 pages in range for PLT usage
> <6>[    0.090092] [    T1] HugeTLB: registered 1.00 GiB page size, pre-
> allocated 0 pages
> <6>[    0.090101] [    T1] HugeTLB: 0 KiB vmemmap can be freed for a
> 1.00 GiB page
> <6>[    0.090105] [    T1] HugeTLB: registered 32.0 MiB page size, pre-
> allocated 0 pages
> <6>[    0.090108] [    T1] HugeTLB: 0 KiB vmemmap can be freed for a
> 32.0 MiB page
> <6>[    0.090112] [    T1] HugeTLB: registered 2.00 MiB page size, pre-
> allocated 0 pages
> <6>[    0.090115] [    T1] HugeTLB: 0 KiB vmemmap can be freed for a
> 2.00 MiB page
> <6>[    0.090119] [    T1] HugeTLB: registered 64.0 KiB page size, pre-
> allocated 0 pages
> <6>[    0.090122] [    T1] HugeTLB: 0 KiB vmemmap can be freed for a
> 64.0 KiB page
> <6>[    0.090423] [    T1] Demotion targets for Node 0: null
> <6>[    0.091381] [    T1] ACPI: Interpreter disabled.
> <6>[    0.092096] [    T1] iommu: Default domain type: Translated
> <6>[    0.092104] [    T1] iommu: DMA domain TLB invalidation policy:
> strict mode
> <6>[    0.092487] [    T1] pps_core: LinuxPPS API ver. 1 registered
> <6>[    0.092492] [    T1] pps_core: Software ver. 5.3.6 - Copyright
> 2005-2007 Rodolfo Giometti <giometti@linux.it>
> <6>[    0.092500] [    T1] PTP clock support registered
> <6>[    0.092593] [    T1] EDAC MC: Ver: 3.0.0
> <7>[    0.092662] [    T1] EDAC DEBUG: edac_mc_sysfs_init: device mc
> created
> <6>[    0.092847] [    T1] scmi_core: SCMI protocol bus registered
> <6>[    0.092972] [    T1] efivars: Registered efivars operations
> <6>[    0.094022] [    T1] NetLabel: Initializing
> <6>[    0.094030] [    T1] NetLabel:  domain hash size = 128
> <6>[    0.094034] [    T1] NetLabel:  protocols = UNLABELED CIPSOv4
> CALIPSO
> <6>[    0.094067] [    T1] NetLabel:  unlabeled traffic allowed by
> default
> <6>[    0.094077] [    T1] mctp: management component transport
> protocol core
> <6>[    0.094080] [    T1] NET: Registered PF_MCTP protocol family
> <6>[    0.094306] [    T1] vgaarb: loaded
> <6>[    0.094671] [    T1] clocksource: Switched to clocksource
> arch_sys_counter
> <5>[    0.108260] [    T1] VFS: Disk quotas dquot_6.6.0
> <6>[    0.108307] [    T1] VFS: Dquot-cache hash table entries: 512
> (order 0, 4096 bytes)
> <6>[    0.108792] [    T1] AppArmor: AppArmor Filesystem Enabled
> <6>[    0.108849] [    T1] pnp: PnP ACPI: disabled
> <6>[    0.113405] [    T1] NET: Registered PF_INET protocol family
> <6>[    0.113664] [    T1] IP idents hash table entries: 65536 (order:
> 7, 524288 bytes, linear)
> <6>[    0.146412] [    T1] tcp_listen_portaddr_hash hash table entries:
> 2048 (order: 3, 32768 bytes, linear)
> <6>[    0.146444] [    T1] Table-perturb hash table entries: 65536
> (order: 6, 262144 bytes, linear)
> <6>[    0.146455] [    T1] TCP established hash table entries: 32768
> (order: 6, 262144 bytes, linear)
> <6>[    0.146583] [    T1] TCP bind hash table entries: 32768 (order:
> 8, 1048576 bytes, linear)
> <6>[    0.147149] [    T1] TCP: Hash tables configured (established
> 32768 bind 32768)
> <6>[    0.147453] [    T1] MPTCP token hash table entries: 4096 (order:
> 4, 98304 bytes, linear)
> <6>[    0.147636] [    T1] UDP hash table entries: 2048 (order: 4,
> 65536 bytes, linear)
> <6>[    0.147668] [    T1] UDP-Lite hash table entries: 2048 (order: 4,
> 65536 bytes, linear)
> <6>[    0.147842] [    T1] NET: Registered PF_UNIX/PF_LOCAL protocol
> family
> <6>[    0.147872] [    T1] NET: Registered PF_XDP protocol family
> <6>[    0.147886] [    T1] PCI: CLS 0 bytes, default 64
> <6>[    0.148223] [   T39] Trying to unpack rootfs image as
> initramfs...
> <6>[    0.153907] [    T1] kvm [1]: nv: 477 coarse grained trap
> handlers
> <6>[    0.154159] [    T1] kvm [1]: IPA Size Limit: 44 bits
> <6>[    0.155921] [    T1] kvm [1]: vgic interrupt IRQ9
> <6>[    0.155963] [    T1] kvm [1]: Hyp nVHE mode initialized
> successfully
> <5>[    0.157312] [    T1] Initialise system trusted keyrings
> <5>[    0.157359] [    T1] Key type blacklist registered
> <6>[    0.157638] [    T1] workingset: timestamp_bits=40 max_order=20
> bucket_order=0
> <6>[    0.157735] [    T1] zbud: loaded
> <5>[    0.158334] [    T1] integrity: Platform Keyring initialized
> <5>[    0.158348] [    T1] integrity: Machine keyring initialized
> <5>[    0.183784] [    T1] Key type asymmetric registered
> <5>[    0.183804] [    T1] Asymmetric key parser 'x509' registered
> <6>[    0.829023] [   T39] Freeing initrd memory: 32296K
> <6>[    0.865817] [    T1] Block layer SCSI generic (bsg) driver
> version 0.4 loaded (major 245)
> <6>[    0.866035] [    T1] io scheduler mq-deadline registered
> <6>[    0.866049] [    T1] io scheduler kyber registered
> <6>[    0.866124] [    T1] io scheduler bfq registered
> <6>[    0.874900] [    T1] irq_brcmstb_l2: registered L2 intc
> (/soc/interrupt-controller@7ef00100, parent irq: 14)
> <6>[    0.884657] [    T1] shpchp: Standard Hot Plug PCI Controller
> Driver version: 0.4
> <6>[    0.918906] [    T1] Serial: 8250/16550 driver, 32 ports, IRQ
> sharing enabled
> <6>[    0.934371] [    T1] Serial: AMBA driver
> <6>[    0.935313] [    T1] msm_serial: driver initialized
> <6>[    0.935836] [    T1] SuperH (H)SCI(F) driver initialized
> <6>[    0.939843] [    T1] [drm] Initialized simpledrm 1.0.0 20200625
> for 3e3cf000.framebuffer on minor 0
> <6>[    0.983402] [    T1] Console: switching to colour frame buffer
> device 240x67
> <6>[    1.011580] [    T1] simple-framebuffer 3e3cf000.framebuffer:
> [drm] fb0: simpledrmdrmfb frame buffer device
> <6>[    1.019647] [    T1] bcm2835-power bcm2835-power: Broadcom
> BCM2835 power domains driver
> <6>[    1.023693] [    T1] mousedev: PS/2 mouse device common for all
> mice
> <6>[    1.036569] [    T1] ledtrig-cpu: registered to indicate activity
> on CPUs
> <6>[    1.037948] [    T1] hid: raw HID events driver (C) Jiri Kosina
> <6>[    1.038626] [    T1] bcm2835-mbox fe00b880.mailbox: mailbox
> enabled
> <6>[    1.041971] [    T1] hw perfevents: enabled with armv8_cortex_a72
> PMU driver, 7 counters available
> <6>[    1.043470] [   T57] watchdog: Delayed init of the lockup
> detector failed: -19
> <6>[    1.043486] [   T57] watchdog: Hard watchdog permanently disabled
> <6>[    1.045427] [    T1] drop_monitor: Initializing network drop
> monitor service
> <6>[    1.045952] [    T1] NET: Registered PF_INET6 protocol family
> <6>[    1.081273] [    T1] Segment Routing with IPv6
> <6>[    1.081298] [    T1] RPL Segment Routing with IPv6
> <6>[    1.081410] [    T1] In-situ OAM (IOAM) with IPv6
> <6>[    1.091616] [    T1] Timer migration: 1 hierarchy levels; 8
> children per group; 1 crossnode level
> <6>[    1.091891] [    T1] registered taskstats version 1
> <5>[    1.092579] [    T1] Loading compiled-in X.509 certificates
> <5>[    1.187159] [    T1] Loaded X.509 cert
> 'home:jonaski:branches:Kernel:stable OBS Project:
> 55cdf0a4c28fecb638eae5caa71d52cf4f6d6805'
> <6>[    1.198548] [    T1] page_owner is disabled
> <5>[    1.199030] [    T1] Key type .fscrypt registered
> <5>[    1.199042] [    T1] Key type fscrypt-provisioning registered
> <5>[    1.357163] [    T1] Key type encrypted registered
> <6>[    1.357209] [    T1] AppArmor: AppArmor sha256 policy hashing
> enabled
> <6>[    1.357432] [    T1] ima: secureboot mode disabled
> <6>[    1.357454] [    T1] ima: No TPM chip found, activating TPM-
> bypass!
> <5>[    1.357483] [    T1] Loading compiled-in module X.509
> certificates
> <5>[    1.360660] [    T1] Loaded X.509 cert
> 'home:jonaski:branches:Kernel:stable OBS Project:
> 55cdf0a4c28fecb638eae5caa71d52cf4f6d6805'
> <6>[    1.360680] [    T1] ima: Allocated hash algorithm: sha256
> <6>[    1.360735] [    T1] ima: No architecture policies found
> <6>[    1.360801] [    T1] evm: Initialising EVM extended attributes:
> <6>[    1.360808] [    T1] evm: security.selinux
> <6>[    1.360816] [    T1] evm: security.SMACK64 (disabled)
> <6>[    1.360823] [    T1] evm: security.SMACK64EXEC (disabled)
> <6>[    1.360831] [    T1] evm: security.SMACK64TRANSMUTE (disabled)
> <6>[    1.360838] [    T1] evm: security.SMACK64MMAP (disabled)
> <6>[    1.360844] [    T1] evm: security.apparmor
> <6>[    1.360851] [    T1] evm: security.ima
> <6>[    1.360857] [    T1] evm: security.capability
> <6>[    1.360864] [    T1] evm: HMAC attrs: 0x1
> <6>[    2.084050] [   T10] uart-pl011 fe201000.serial: there is not
> valid maps for state default
> <6>[    2.085027] [   T10] fe201000.serial: ttyAMA0 at MMIO 0xfe201000
> (irq = 22, base_baud = 0) is a PL011 rev2
> <6>[    2.085084] [   T10] printk: legacy console [ttyAMA0] enabled
> <6>[    2.087488] [   T10] raspberrypi-firmware soc:firmware: Attached
> to firmware from 2024-03-21T14:32:15
> <6>[    2.195723] [    T1] clk: Disabling unused clocks
> <6>[    2.195798] [    T1] PM: genpd: Disabling unused power domains
> <6>[    2.215712] [    T1] Freeing unused kernel memory: 10880K
> <6>[    2.215898] [    T1] Run /init as init process
> <7>[    2.215908] [    T1]   with arguments:
> <7>[    2.215919] [    T1]     /init
> <7>[    2.215928] [    T1]     splash
> <7>[    2.215937] [    T1]   with environment:
> <7>[    2.215946] [    T1]     HOME=/
> <7>[    2.215954] [    T1]     TERM=linux
> <7>[    2.215961] [    T1]     BOOT_IMAGE=/Image-6.9.3-7.g97b471a-
> vanilla
> <7>[    2.215969] [    T1]     cgroup_enable=memory
> <7>[    2.215977] [    T1]    
> ip=192.168.250.20::192.168.250.200:255.255.255.0::eth0:off
> <30>[    2.253126] [    T1] systemd[1]: System time before build time,
> advancing clock.
> <5>[    2.281872] [  T151] efivarfs: module verification failed:
> signature and/or required key missing - tainting kernel
> <30>[    2.305348] [    T1] systemd[1]: systemd
> 255.7+suse.33.g603cd1d4d8 running in system mode (+PAM +AUDIT +SELINUX
> +APPARMOR +IMA -SMACK +SECCOMP +GCRYPT +GNUTLS +OPENSSL +ACL +BLKID
> +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD +LIBCRYPTSETUP +LIBFDISK
> +PCRE2 +PWQUALITY +P11KIT +QRENCODE +TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD
> +BPF_FRAMEWORK -XKBCOMMON -UTMP +SYSVINIT default-hierarchy=unified)
> <30>[    2.305415] [    T1] systemd[1]: Detected architecture arm64.
> <30>[    2.305448] [    T1] systemd[1]: Running in initrd.
> <30>[    2.306785] [    T1] systemd[1]: Hostname set to
> <edge.vendanor.com>.
> <30>[    3.171494] [    T1] systemd[1]: bpf-lsm: LSM BPF program
> attached
> <28>[    3.511526] [    T1] systemd[1]:
> /usr/lib/systemd/system/plymouth-start.service:15: Unit uses
> KillMode=none. This is unsafe, as it disables systemd's process
> lifecycle management for the service. Please update the service to use
> a safer KillMode=, such as 'mixed' or 'control-group'. Support for
> KillMode=none is deprecated and will eventually be removed.
> <30>[    3.607987] [    T1] systemd[1]: Queued start job for default
> target Initrd Default Target.
> <30>[    3.668149] [    T1] systemd[1]: Created slice Slice
> /system/systemd-cryptsetup.
> <30>[    3.669051] [    T1] systemd[1]: Started Forward Password
> Requests to Clevis Directory Watch.
> <30>[    3.669176] [    T1] systemd[1]: Expecting device /dev/disk/by-
> uuid/0024-3B73...
> <30>[    3.669291] [    T1] systemd[1]: Expecting device /dev/disk/by-
> uuid/4fb99d03-eec8-4a6c-8d46-e14a6afd975a...
> <30>[    3.669357] [    T1] systemd[1]: Expecting device /dev/disk/by-
> uuid/6d048af7-a4ba-4e50-8808-d686e13c286e...
> <30>[    3.669415] [    T1] systemd[1]: Expecting device /dev/disk/by-
> uuid/d72be4f2-ee91-456d-901f-541085d3bab5...
> <30>[    3.669525] [    T1] systemd[1]: Reached target Local Encrypted
> Volumes (Pre).
> <30>[    3.669698] [    T1] systemd[1]: Reached target Initrd /usr File
> System.
> <30>[    3.669886] [    T1] systemd[1]: Reached target Slice Units.
> <30>[    3.670017] [    T1] systemd[1]: Reached target Swaps.
> <30>[    3.670147] [    T1] systemd[1]: Reached target Timer Units.
> <30>[    3.671004] [    T1] systemd[1]: Listening on D-Bus System
> Message Bus Socket.
> <30>[    3.672037] [    T1] systemd[1]: Listening on Journal Socket
> (/dev/log).
> <30>[    3.673001] [    T1] systemd[1]: Listening on Journal Socket.
> <30>[    3.673982] [    T1] systemd[1]: Listening on udev Control
> Socket.
> <30>[    3.674769] [    T1] systemd[1]: Listening on udev Kernel
> Socket.
> <30>[    3.674920] [    T1] systemd[1]: Reached target Socket Units.
> <30>[    3.681511] [    T1] systemd[1]: Starting Create List of Static
> Device Nodes...
> <30>[    3.688347] [    T1] systemd[1]: Starting OpenSSH server
> daemon...
> <30>[    3.701281] [    T1] systemd[1]: Starting Journal Service...
> <30>[    3.702926] [    T1] systemd[1]: Load Kernel Modules was skipped
> because no trigger condition checks were met.
> <30>[    3.712656] [    T1] systemd[1]: Starting Apply Kernel
> Variables...
> <28>[    3.727266] [  T192] (sshd)[192]: sshd.service: Referenced but
> unset environment variable evaluates to an empty string: CRYPTO_POLICY,
> OPTIONS
> <30>[    3.730682] [    T1] systemd[1]: Starting Virtual Console
> Setup...
> <30>[    3.748356] [    T1] systemd[1]: Finished Create List of Static
> Device Nodes.
> <30>[    3.765890] [    T1] systemd[1]: Starting Create Static Device
> Nodes in /dev gracefully...
> <30>[    3.815443] [    T1] systemd[1]: Started OpenSSH server daemon.
> <30>[    3.854949] [    T1] systemd[1]: Finished Apply Kernel
> Variables.
> <46>[    3.854956] [  T193] systemd-journald[193]: Collecting audit
> messages is disabled.
> <30>[    3.885141] [    T1] systemd[1]: Finished Create Static Device
> Nodes in /dev gracefully.
> <30>[    3.919285] [    T1] systemd[1]: Starting Create Static Device
> Nodes in /dev...
> <30>[    3.920143] [    T1] systemd[1]: Started Journal Service.
> <6>[    5.335317] [  T359] device-mapper: uevent: version 1.0.3
> <6>[    5.335795] [  T359] device-mapper: ioctl: 4.48.0-ioctl (2023-03-
> 01) initialised: dm-devel@lists.linux.dev
> <6>[    7.392918] [  T402] brcm-pcie fd500000.pcie: host bridge
> /scb/pcie@7d500000 ranges:
> <6>[    7.392969] [  T402] brcm-pcie fd500000.pcie:   No bus range
> found for /scb/pcie@7d500000, using [bus 00-ff]
> <6>[    7.393016] [  T402] brcm-pcie fd500000.pcie:      MEM
> 0x0600000000..0x063fffffff -> 0x00c0000000
> <6>[    7.393060] [  T402] brcm-pcie fd500000.pcie:   IB MEM
> 0x0000000000..0x00ffffffff -> 0x0400000000
> <4>[    7.394148] [  T404] usb_phy_generic phy: dummy supplies not
> allowed for exclusive requests
> <6>[    7.395629] [  T402] brcm-pcie fd500000.pcie: PCI host bridge to
> bus 0000:00
> <6>[    7.395677] [  T402] pci_bus 0000:00: root bus resource [bus 00-
> ff]
> <6>[    7.395696] [  T402] pci_bus 0000:00: root bus resource [mem
> 0x600000000-0x63fffffff] (bus address [0xc0000000-0xffffffff])
> <6>[    7.395774] [  T402] pci 0000:00:00.0: [14e4:2711] type 01 class
> 0x060400 PCIe Root Port
> <6>[    7.395814] [  T402] pci 0000:00:00.0: PCI bridge to [bus 00]
> <6>[    7.395834] [  T402] pci 0000:00:00.0:   bridge window [mem
> 0x00000000-0x000fffff]
> <6>[    7.395856] [  T402] pci 0000:00:00.0:   bridge window [mem
> 0x00000000-0x000fffff 64bit pref]
> <6>[    7.395964] [  T402] pci 0000:00:00.0: PME# supported from D0
> D3hot
> <6>[    7.406098] [  T391] sdhci: Secure Digital Host Controller
> Interface driver
> <6>[    7.406125] [  T391] sdhci: Copyright(c) Pierre Ossman
> <6>[    7.408558] [  T391] sdhci-pltfm: SDHCI platform and OF driver
> helper
> <6>[    7.426114] [  T380] bcmgenet fd580000.ethernet: GENET 5.0 EPHY:
> 0x0000
> <6>[    7.430848] [  T402] pci 0000:00:00.0: bridge configuration
> invalid ([bus 00-00]), reconfiguring
> <4>[    7.441980] [  T402] pci_bus 0000:01: supply vpcie3v3 not found,
> using dummy regulator
> <4>[    7.466937] [  T402] pci_bus 0000:01: supply vpcie3v3aux not
> found, using dummy regulator
> <4>[    7.467156] [  T402] pci_bus 0000:01: supply vpcie12v not found,
> using dummy regulator
> <6>[    7.479045] [  T390] usbcore: registered new interface driver
> usbfs
> <6>[    7.479187] [  T390] usbcore: registered new interface driver hub
> <6>[    7.479300] [  T390] usbcore: registered new device driver usb
> <6>[    7.509038] [  T399] brcmstb-i2c fef04500.i2c:  @97500hz
> registered in polling mode
> <6>[    7.517689] [  T399] brcmstb-i2c fef09500.i2c:  @97500hz
> registered in polling mode
> <4>[    7.525260] [  T390] dwc2 fe980000.usb: supply vusb_d not found,
> using dummy regulator
> <4>[    7.525684] [  T390] dwc2 fe980000.usb: supply vusb_a not found,
> using dummy regulator
> <3>[    7.535829] [  T392] spi_gpio fe204000.spi: cs1 >= max 1
> <3>[    7.541308] [  T392] spi_master spi0: spi_device register error
> /soc/spi@7e204000/slb9670@1
> <4>[    7.549875] [  T392] spi_master spi0: Failed to create SPI device
> for /soc/spi@7e204000/slb9670@1
> <6>[    7.579851] [  T390] dwc2 fe980000.usb: DWC OTG Controller
> <6>[    7.579921] [  T390] dwc2 fe980000.usb: new USB bus registered,
> assigned bus number 1
> <6>[    7.579994] [  T390] dwc2 fe980000.usb: irq 33, io mem 0xfe980000
> <6>[    7.580337] [  T390] usb usb1: New USB device found,
> idVendor=1d6b, idProduct=0002, bcdDevice= 6.09
> <6>[    7.580361] [  T390] usb usb1: New USB device strings: Mfr=3,
> Product=2, SerialNumber=1
> <6>[    7.580374] [  T390] usb usb1: Product: DWC OTG Controller
> <6>[    7.580385] [  T390] usb usb1: Manufacturer: Linux 6.9.3-
> 7.g97b471a-vanilla dwc2_hsotg
> <6>[    7.580396] [  T390] usb usb1: SerialNumber: fe980000.usb
> <6>[    7.581857] [  T390] hub 1-0:1.0: USB hub found
> <6>[    7.581980] [  T390] hub 1-0:1.0: 1 port detected
> <6>[    7.597667] [  T387] bcm2835-wdt bcm2835-wdt: Broadcom BCM2835
> watchdog timer
> <6>[    7.705269] [  T380] unimac-mdio unimac-mdio.-19: Broadcom UniMAC
> MDIO bus
> <6>[    7.816306] [   T52] [drm] Initialized v3d 1.0.0 20180419 for
> fec00000.v3d on minor 1
> <4>[    7.825784] [  T403] SPI driver tpm_tis_spi has no spi_device_id
> for atmel,attpm20p
> <6>[    7.845559] [   T10] tpm_tis_spi spi0.0: 2.0 TPM (device-id 0x1B,
> rev-id 22)
> <3>[    7.848212] [  T402] brcm-pcie fd500000.pcie: link down
> <6>[    7.858150] [  T402] pci_bus 0000:01: busn_res: [bus 01-ff] end
> is updated to 01
> <6>[    7.858222] [  T402] pci 0000:00:00.0: PCI bridge to [bus 01]
> <6>[    7.859355] [  T402] pcieport 0000:00:00.0: PME: Signaling with
> IRQ 36
> <6>[    7.861571] [  T402] pcieport 0000:00:00.0: AER: enabled with IRQ
> 36
> <6>[    7.864052] [  T402] pci_bus 0000:01: busn_res: [bus 01] is
> released
> <6>[    7.878838] [  T402] pci_bus 0000:00: busn_res: [bus 00-ff] is
> released
> <6>[    7.914801] [   T39] mmc0: SDHCI controller on fe340000.mmc
> [fe340000.mmc] using ADMA
> <6>[    7.928182] [  T200] usb 1-1: new high-speed USB device number 2
> using dwc2
> <6>[    8.016123] [   T67] mmc0: new DDR MMC card at address 0001
> <6>[    8.055816] [  T402] mmcblk0: mmc0:0001 BJTD4R 29.1 GiB
> <6>[    8.084872] [  T402]  mmcblk0: p1 p2 p3
> <6>[    8.125251] [  T200] usb 1-1: New USB device found,
> idVendor=1a40, idProduct=0101, bcdDevice= 1.00
> <6>[    8.125294] [  T200] usb 1-1: New USB device strings: Mfr=0,
> Product=1, SerialNumber=0
> <6>[    8.125310] [  T200] usb 1-1: Product: USB2.0 HUB
> <6>[    8.129607] [  T384] Console: switching to colour dummy device
> 80x25
> <6>[    8.131854] [  T402] mmcblk0boot0: mmc0:0001 BJTD4R 4.00 MiB
> <6>[    8.135059] [  T200] hub 1-1:1.0: USB hub found
> <6>[    8.135236] [  T200] hub 1-1:1.0: 4 ports detected
> <6>[    8.140226] [  T402] mmcblk0boot1: mmc0:0001 BJTD4R 4.00 MiB
> <6>[    8.143873] [  T402] mmcblk0rpmb: mmc0:0001 BJTD4R 4.00 MiB,
> chardev (511:0)
> <6>[    8.206770] [  T409] bcmgenet fd580000.ethernet: configuring
> instance for external RGMII (RX delay)
> <6>[    8.212070] [  T384] vc4-drm gpu: bound fe400000.hvs (ops
> vc4_hvs_ops [vc4])
> <6>[    8.219857] [  T384] Registered IR keymap rc-cec
> <6>[    8.220247] [  T384] rc rc0: vc4-hdmi-0 as
> /devices/platform/soc/fef00700.hdmi/rc/rc0
> <6>[    8.221469] [  T384] input: vc4-hdmi-0 as
> /devices/platform/soc/fef00700.hdmi/rc/rc0/input0
> <6>[    8.236751] [  T384] vc4-drm gpu: bound fef00700.hdmi (ops
> vc4_hdmi_ops [vc4])
> <6>[    8.245330] [  T384] Registered IR keymap rc-cec
> <6>[    8.245582] [  T384] rc rc1: vc4-hdmi-1 as
> /devices/platform/soc/fef05700.hdmi/rc/rc1
> <6>[    8.245828] [  T384] input: vc4-hdmi-1 as
> /devices/platform/soc/fef05700.hdmi/rc/rc1/input1
> <6>[    8.261604] [  T384] vc4-drm gpu: bound fef05700.hdmi (ops
> vc4_hdmi_ops [vc4])
> <6>[    8.262160] [  T384] vc4-drm gpu: bound fe004000.txp (ops
> vc4_txp_ops [vc4])
> <6>[    8.271495] [  T384] vc4-drm gpu: bound fe206000.pixelvalve (ops
> vc4_crtc_ops [vc4])
> <6>[    8.272063] [  T384] vc4-drm gpu: bound fe207000.pixelvalve (ops
> vc4_crtc_ops [vc4])
> <6>[    8.272469] [  T384] vc4-drm gpu: bound fe20a000.pixelvalve (ops
> vc4_crtc_ops [vc4])
> <6>[    8.272738] [  T384] vc4-drm gpu: bound fe216000.pixelvalve (ops
> vc4_crtc_ops [vc4])
> <6>[    8.273109] [  T384] vc4-drm gpu: bound fec12000.pixelvalve (ops
> vc4_crtc_ops [vc4])
> <6>[    8.274095] [  T354] bcmgenet fd580000.ethernet eth0: Link is
> Down
> <6>[    8.285705] [  T384] [drm] Initialized vc4 0.0.0 20140616 for gpu
> on minor 2
> <6>[    8.343940] [  T384] Console: switching to colour frame buffer
> device 135x120
> <6>[    8.343999] [  T384] vc4-drm gpu: [drm] fb0: vc4drmfb frame
> buffer device
> <6>[    8.748102] [  T200] usb 1-1.1: new full-speed USB device number
> 3 using dwc2
> <6>[    8.940552] [  T200] usb 1-1.1: New USB device found,
> idVendor=0eef, idProduct=c002, bcdDevice=46.0c
> <6>[    8.940592] [  T200] usb 1-1.1: New USB device strings: Mfr=1,
> Product=2, SerialNumber=0
> <6>[    8.940608] [  T200] usb 1-1.1: Product: eGalaxTouch P80H46 8046
> vCM-156G012 k4.02.146
> <6>[    8.940620] [  T200] usb 1-1.1: Manufacturer: eGalax Inc.
> <6>[    8.977940] [  T398] usbcore: registered new interface driver
> usbhid
> <6>[    8.977975] [  T398] usbhid: USB HID core driver
> <6>[    8.996268] [  T398] input: eGalax Inc. eGalaxTouch P80H46 8046
> vCM-156G012 k4.02.146 Touchscreen as
> /devices/platform/soc/fe980000.usb/usb1/1-1/1-1.1/1-
> 1.1:1.0/0003:0EEF:C002.0001/input/input2
> <6>[    8.996952] [  T398] input: eGalax Inc. eGalaxTouch P80H46 8046
> vCM-156G012 k4.02.146 Mouse as
> /devices/platform/soc/fe980000.usb/usb1/1-1/1-1.1/1-
> 1.1:1.0/0003:0EEF:C002.0001/input/input4
> <6>[    8.997776] [  T398] hid-generic 0003:0EEF:C002.0001:
> input,hiddev96,hidraw0: USB HID v1.11 Mouse [eGalax Inc. eGalaxTouch
> P80H46 8046 vCM-156G012 k4.02.146] on usb-fe980000.usb-1.1/input0
> <6>[    9.113181] [  T398] input: eGalax Inc. eGalaxTouch P80H46 8046
> vCM-156G012 k4.02.146 as /devices/platform/soc/fe980000.usb/usb1/1-1/1-
> 1.1/1-1.1:1.0/0003:0EEF:C002.0001/input/input5
> <6>[    9.113802] [  T398] input: eGalax Inc. eGalaxTouch P80H46 8046
> vCM-156G012 k4.02.146 Mouse as
> /devices/platform/soc/fe980000.usb/usb1/1-1/1-1.1/1-
> 1.1:1.0/0003:0EEF:C002.0001/input/input7
> <6>[    9.114547] [  T398] hid-multitouch 0003:0EEF:C002.0001:
> input,hiddev96,hidraw0: USB HID v1.11 Mouse [eGalax Inc. eGalaxTouch
> P80H46 8046 vCM-156G012 k4.02.146] on usb-fe980000.usb-1.1/input0
> <6>[    9.118105] [  T200] usb 1-1.3: new low-speed USB device number 4
> using dwc2
> <6>[    9.327403] [  T200] usb 1-1.3: New USB device found,
> idVendor=413c, idProduct=2106, bcdDevice= 1.50
> <6>[    9.327443] [  T200] usb 1-1.3: New USB device strings: Mfr=1,
> Product=2, SerialNumber=0
> <6>[    9.327459] [  T200] usb 1-1.3: Product: Dell QuietKey Keyboard
> <6>[    9.327471] [  T200] usb 1-1.3: Manufacturer: Dell
> <6>[    9.342011] [  T200] input: Dell Dell QuietKey Keyboard as
> /devices/platform/soc/fe980000.usb/usb1/1-1/1-1.3/1-
> 1.3:1.0/0003:413C:2106.0002/input/input8
> <6>[    9.398881] [  T200] hid-generic 0003:413C:2106.0002:
> input,hidraw1: USB HID v1.10 Keyboard [Dell Dell QuietKey Keyboard] on
> usb-fe980000.usb-1.3/input0
> <6>[   12.322278] [  T200] bcmgenet fd580000.ethernet eth0: Link is Up
> - 1Gbps/Full - flow control rx/tx
> <6>[   12.368848] [  T638] NET: Registered PF_PACKET protocol family
> <5>[  138.103537] [T11913] Key type trusted registered
> <6>[  150.196724] [T11996] EXT4-fs (dm-0): orphan cleanup on readonly
> fs
> <6>[  150.197829] [T11996] EXT4-fs (dm-0): mounted filesystem 6d048af7-
> a4ba-4e50-8808-d686e13c286e ro with ordered data mode. Quota mode:
> none.
> <46>[  151.091791] [  T193] systemd-journald[193]: Received SIGTERM
> from PID 1 (systemd).
> <30>[  152.162765] [    T1] systemd[1]: systemd
> 255.7+suse.33.g603cd1d4d8 running in system mode (+PAM +AUDIT +SELINUX
> +APPARMOR +IMA -SMACK +SECCOMP +GCRYPT +GNUTLS +OPENSSL +ACL +BLKID
> +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD +LIBCRYPTSETUP +LIBFDISK
> +PCRE2 +PWQUALITY +P11KIT +QRENCODE +TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD
> +BPF_FRAMEWORK -XKBCOMMON -UTMP +SYSVINIT default-hierarchy=unified)
> <30>[  152.162840] [    T1] systemd[1]: Detected architecture arm64.
> <30>[  152.171999] [    T1] systemd[1]: Hostname set to
> <edge.in.jkvinge.net>.
> <30>[  153.231448] [    T1] systemd[1]: bpf-lsm: LSM BPF program
> attached
> <28>[  153.677707] [    T1] systemd[1]:
> /usr/lib/systemd/system/plymouth-start.service:15: Unit uses
> KillMode=none. This is unsafe, as it disables systemd's process
> lifecycle management for the service. Please update the service to use
> a safer KillMode=, such as 'mixed' or 'control-group'. Support for
> KillMode=none is deprecated and will eventually be removed.
> <30>[  154.796586] [    T1] systemd[1]: systemd-ask-password-
> plymouth.service: Deactivated successfully.
> <30>[  154.802434] [    T1] systemd[1]: initrd-switch-root.service:
> Deactivated successfully.
> <30>[  154.804241] [    T1] systemd[1]: Stopped Switch Root.
> <30>[  154.817018] [    T1] systemd[1]: systemd-journald.service:
> Scheduled restart job, restart counter is at 1.
> <30>[  154.824516] [    T1] systemd[1]: Created slice Slice
> /system/getty.
> <30>[  154.830142] [    T1] systemd[1]: Created slice Slice
> /system/serial-getty.
> <30>[  154.835786] [    T1] systemd[1]: Created slice Slice
> /system/systemd-fsck.
> <30>[  154.839473] [    T1] systemd[1]: Created slice User and Session
> Slice.
> <30>[  154.840537] [    T1] systemd[1]: Started Forward Password
> Requests to Clevis Directory Watch.
> <30>[  154.841002] [    T1] systemd[1]: Dispatch Password Requests to
> Console Directory Watch was skipped because of an unmet condition check
> (ConditionPathExists=!/run/plymouth/pid).
> <30>[  154.842485] [    T1] systemd[1]: Set up automount Arbitrary
> Executable File Formats File System Automount Point.
> <30>[  154.843063] [    T1] systemd[1]: Expecting device
> /dev/mmcblk0p1...
> <30>[  154.843413] [    T1] systemd[1]: Expecting device
> /dev/mmcblk0p2...
> <30>[  154.843741] [    T1] systemd[1]: Expecting device
> /dev/ttyAMA0...
> <30>[  154.844151] [    T1] systemd[1]: Reached target Block Device
> Preparation for /dev/mapper/rpi_rootfs.
> <30>[  154.844545] [    T1] systemd[1]: Reached target Local Encrypted
> Volumes (Pre).
> <30>[  154.844986] [    T1] systemd[1]: Reached target Local Encrypted
> Volumes.
> <30>[  154.845456] [    T1] systemd[1]: Stopped target Switch Root.
> <30>[  154.845829] [    T1] systemd[1]: Stopped target Initrd File
> Systems.
> <30>[  154.846155] [    T1] systemd[1]: Stopped target Initrd Root File
> System.
> <30>[  154.846526] [    T1] systemd[1]: Reached target Local Integrity
> Protected Volumes.
> <30>[  154.846997] [    T1] systemd[1]: Reached target Remote File
> Systems.
> <30>[  154.847370] [    T1] systemd[1]: Reached target Slice Units.
> <30>[  154.847782] [    T1] systemd[1]: Reached target Swaps.
> <30>[  154.848180] [    T1] systemd[1]: Reached target System Time Set.
> <30>[  154.848678] [    T1] systemd[1]: Reached target Local Verity
> Protected Volumes.
> <30>[  154.849773] [    T1] systemd[1]: Listening on Device-mapper
> event daemon FIFOs.
> <30>[  154.851164] [    T1] systemd[1]: Listening on LVM2 poll daemon
> socket.
> <30>[  154.852431] [    T1] systemd[1]: Listening on Syslog Socket.
> <30>[  154.862042] [    T1] systemd[1]: Listening on Process Core Dump
> Socket.
> <30>[  154.864745] [    T1] systemd[1]: Listening on udev Control
> Socket.
> <30>[  154.866181] [    T1] systemd[1]: Listening on udev Kernel
> Socket.
> <30>[  154.891895] [    T1] systemd[1]: Mounting Huge Pages File
> System...
> <30>[  154.900590] [    T1] systemd[1]: Mounting POSIX Message Queue
> File System...
> <30>[  154.909511] [    T1] systemd[1]: Mounting Kernel Debug File
> System...
> <30>[  154.922318] [    T1] systemd[1]: Mounting Kernel Trace File
> System...
> <30>[  154.942203] [    T1] systemd[1]: Mounting Temporary Directory
> /tmp...
> <30>[  154.964271] [    T1] systemd[1]: Starting Load AppArmor
> profiles...
> <30>[  154.983420] [    T1] systemd[1]: Starting Restore the current
> clock...
> <30>[  155.006356] [    T1] systemd[1]: Starting Create List of Static
> Device Nodes...
> <30>[  155.023319] [    T1] systemd[1]: Starting Monitoring of LVM2
> mirrors, snapshots etc. using dmeventd or progress polling...
> <28>[  155.031630] [T12045] (-hwclock)[12045]: fake-hwclock-
> load.service: Referenced but unset environment variable evaluates to an
> empty string: FORCE
> <30>[  155.038405] [    T1] systemd[1]: Starting Load Kernel Module
> configfs...
> <30>[  155.053587] [    T1] systemd[1]: Starting Load Kernel Module
> dm_mod...
> <30>[  155.070949] [    T1] systemd[1]: Starting Load Kernel Module
> drm...
> <30>[  155.083645] [    T1] systemd[1]: Starting Load Kernel Module
> efi_pstore...
> <30>[  155.100025] [    T1] systemd[1]: Starting Load Kernel Module
> fuse...
> <30>[  155.109422] [    T1] systemd[1]: Starting Load Kernel Module
> loop...
> <30>[  155.125746] [    T1] systemd[1]: Starting Load Kernel Module
> nvme_fabrics...
> <30>[  155.126678] [    T1] systemd[1]: plymouth-switch-root.service:
> Deactivated successfully.
> <30>[  155.127420] [    T1] systemd[1]: Stopped Plymouth switch root
> service.
> <30>[  155.195776] [    T1] systemd[1]: Starting Journal Service...
> <30>[  155.202726] [    T1] systemd[1]: Load Kernel Modules was skipped
> because no trigger condition checks were met.
> <30>[  155.219798] [    T1] systemd[1]: Starting Remount Root and
> Kernel File Systems...
> <30>[  155.239486] [    T1] systemd[1]: Starting Coldplug All udev
> Devices...
> <30>[  155.255716] [    T1] systemd[1]: Starting Uncomplicated
> firewall...
> <30>[  155.277282] [    T1] systemd[1]: Mounted Huge Pages File System.
> <30>[  155.279894] [    T1] systemd[1]: Mounted POSIX Message Queue
> File System.
> <30>[  155.283026] [    T1] systemd[1]: Mounted Kernel Debug File
> System.
> <30>[  155.287035] [    T1] systemd[1]: Mounted Kernel Trace File
> System.
> <30>[  155.289334] [    T1] systemd[1]: Mounted Temporary Directory
> /tmp.
> <30>[  155.293127] [    T1] systemd[1]: Finished Create List of Static
> Device Nodes.
> <30>[  155.297911] [    T1] systemd[1]: modprobe@configfs.service:
> Deactivated successfully.
> <30>[  155.305037] [    T1] systemd[1]: Finished Load Kernel Module
> configfs.
> <30>[  155.376238] [    T1] systemd[1]: Starting Create Static Device
> Nodes in /dev gracefully...
> <30>[  155.401293] [    T1] systemd[1]: modprobe@efi_pstore.service:
> Deactivated successfully.
> <30>[  155.408599] [    T1] systemd[1]: Finished Load Kernel Module
> efi_pstore.
> <30>[  155.413813] [    T1] systemd[1]: modprobe@drm.service:
> Deactivated successfully.
> <30>[  155.415613] [    T1] systemd[1]: Finished Load Kernel Module
> drm.
> <6>[  155.426796] [T12063] EXT4-fs (dm-0): re-mounted 6d048af7-a4ba-
> 4e50-8808-d686e13c286e r/w. Quota mode: none.
> <30>[  155.442647] [    T1] systemd[1]: modprobe@dm_mod.service:
> Deactivated successfully.
> <30>[  155.444180] [    T1] systemd[1]: Finished Load Kernel Module
> dm_mod.
> <30>[  155.449343] [    T1] systemd[1]: Finished Remount Root and
> Kernel File Systems.
> <30>[  155.458998] [    T1] systemd[1]: Rebuild Hardware Database was
> skipped because of an unmet condition check
> (ConditionNeedsUpdate=/etc).
> <30>[  155.459507] [    T1] systemd[1]: Platform Persistent Storage
> Archival was skipped because of an unmet condition check
> (ConditionDirectoryNotEmpty=/sys/fs/pstore).
> <6>[  155.483100] [T12052] fuse: init (API version 7.40)
> <46>[  155.500993] [T12055] systemd-journald[12055]: Collecting audit
> messages is disabled.
> <30>[  155.502978] [    T1] systemd[1]: Starting Load/Save OS Random
> Seed...
> <30>[  155.513806] [    T1] systemd[1]: modprobe@fuse.service:
> Deactivated successfully.
> <30>[  155.525265] [    T1] systemd[1]: Finished Load Kernel Module
> fuse.
> <30>[  155.558487] [    T1] systemd[1]: Mounting FUSE Control File
> System...
> <30>[  155.560064] [    T1] systemd[1]: Started Journal Service.
> <6>[  155.577583] [T12053] loop: module loaded
> <46>[  155.834000] [T12055] systemd-journald[12055]: Received client
> request to flush runtime journal.
> <5>[  155.933343] [   T40] audit: type=1400 audit(1718104978.413:2):
> apparmor="STATUS" operation="profile_load" profile="unconfined"
> name="1password" pid=12103 comm="apparmor_parser"
> <5>[  155.934102] [   T40] audit: type=1400 audit(1718104978.413:3):
> apparmor="STATUS" operation="profile_load" profile="unconfined"
> name="QtWebEngineProcess" pid=12108 comm="apparmor_parser"
> <5>[  155.935906] [   T40] audit: type=1400 audit(1718104978.416:4):
> apparmor="STATUS" operation="profile_load" profile="unconfined"
> name="Discord" pid=12105 comm="apparmor_parser"
> <5>[  155.938548] [   T40] audit: type=1400 audit(1718104978.420:5):
> apparmor="STATUS" operation="profile_load" profile="unconfined"
> name=4D6F6E676F444220436F6D70617373 pid=12107 comm="apparmor_parser"
> <5>[  155.968297] [   T40] audit: type=1400 audit(1718104978.446:6):
> apparmor="STATUS" operation="profile_load" profile="unconfined"
> name="buildah" pid=12114 comm="apparmor_parser"
> <5>[  155.969673] [   T40] audit: type=1400 audit(1718104978.450:7):
> apparmor="STATUS" operation="profile_load" profile="unconfined"
> name="brave" pid=12113 comm="apparmor_parser"
> <5>[  155.970620] [   T40] audit: type=1400 audit(1718104978.450:8):
> apparmor="STATUS" operation="profile_load" profile="unconfined"
> name="busybox" pid=12115 comm="apparmor_parser"
> <5>[  155.994709] [   T40] audit: type=1400 audit(1718104978.473:9):
> apparmor="STATUS" operation="profile_load" profile="unconfined"
> name="ch-run" pid=12120 comm="apparmor_parser"
> <5>[  156.000298] [   T40] audit: type=1400 audit(1718104978.480:10):
> apparmor="STATUS" operation="profile_load" profile="unconfined"
> name="cam" pid=12118 comm="apparmor_parser"
> <5>[  156.005328] [   T40] audit: type=1400 audit(1718104978.483:11):
> apparmor="STATUS" operation="profile_load" profile="unconfined"
> name="ch-checkns" pid=12119 comm="apparmor_parser"
> <46>[  156.018365] [T12055] systemd-journald[12055]:
> /var/log/journal/e9a50eb23c21432da70186dbf116ace5/system.journal:
> Realtime clock jumped backwards relative to last journal entry,
> rotating.
> <46>[  156.018446] [T12055] systemd-journald[12055]: Rotating system
> journal.
> <6>[  159.080252] [T12364] EXT4-fs (mmcblk0p2): mounted filesystem
> d72be4f2-ee91-456d-901f-541085d3bab5 r/w with ordered data mode. Quota
> mode: none.
> <6>[  159.965411] [T12294] iproc-rng200 fe104000.rng: hwrng registered
> <4>[  159.983633] [T12291] vchiq: module is from the staging directory,
> the quality is unknown, you have been warned.
> <6>[  160.048385] [T12291] bcm2835_vchiq fe00b840.mailbox: there is not
> valid maps for state default
> <4>[  161.016879] [T12330] snd_bcm2835: module is from the staging
> directory, the quality is unknown, you have been warned.
> <6>[  161.036589] [T12330] bcm2835-audio bcm2835-audio: card created
> with 8 channels
> <6>[  161.043201] [T12329] mc: Linux media interface: v0.10
> <6>[  161.092787] [T12329] videodev: Linux video capture interface:
> v2.00
> <4>[  161.141923] [T12329] bcm2835_mmal_vchiq: module is from the
> staging directory, the quality is unknown, you have been warned.
> <4>[  161.157121] [T12329] bcm2835_v4l2: module is from the staging
> directory, the quality is unknown, you have been warned.
> 
> 
> Jonas
> 
> 
> 

