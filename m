Return-Path: <stable+bounces-181776-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A60BBA4505
	for <lists+stable@lfdr.de>; Fri, 26 Sep 2025 16:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F377624AF3
	for <lists+stable@lfdr.de>; Fri, 26 Sep 2025 14:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA9A19E992;
	Fri, 26 Sep 2025 14:57:46 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2AE38DE1
	for <stable@vger.kernel.org>; Fri, 26 Sep 2025 14:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758898666; cv=none; b=EUMOk95FwINf6H2RC/vv+oI3Lf7FBqmzKioYBAQvN1YISTY0ynMMnLY+SLGfeBZk4kwpks/xRdIODEm5281C0aBnIvBxfdYa8WOUxGDhNdotKh/nEQ3OptARyV8xh2r7gVRd3MnOQzWzY/Jz6ARsx76EIhfCzpEzuy8YtbL3m7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758898666; c=relaxed/simple;
	bh=j3vMRtxESWRtVayKwDp8jQjLw5IAmutI7MGPnjBNvls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MwoIjRrE1syiphNOLdP6eP/Qi0ORQv4kZG8Ptv+CrruZUkg+L0WxwSorwU/dZCBKEPXsEyXpCBSPFmTcHBk+t6s2vT/iHlP+VHjRHE8CPoDm3oQWitcrvq85E+kGTcenMPuXz4QgtxylHIjkeuMdzzcJ4QZunNqXuJ4/bRDsk0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-634a3327ff7so4020171a12.1
        for <stable@vger.kernel.org>; Fri, 26 Sep 2025 07:57:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758898661; x=1759503461;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YbxCBA+za2aU9LAN1kY2OXgRUl2tAd+WBSXZTT7RXfM=;
        b=MiGoqkcMjDNJd+n/jjEJmE5e1S0NJBtyftNaL+FKkO0Xnt3+XaDtaAgzVh5tG6umQR
         UOx8sJRTrsNGwbCq/Ek4U845E7plAh2GY7Nj+y5dXeVCfARLSRL+xoITCtJzG5cw9vJh
         UlrR1yFwimqU4dJjKdBnYq+AgFDhtZBs1t47e8Grui+R77YdS6aZs2gY03Gb/tCoH3Dp
         2BtX03JopOEmgsVeOMcjGnw56O60+IPkmsNwkCkP+zXH9b5rQAoBKfMEf3bpssBj1gM3
         XaWVQSWoXGbXbbi/Gv429qe6UHYZGk7nniN0GByogTp34eIcumSR4fz/a5FDpFZ4Fnpr
         bNsg==
X-Forwarded-Encrypted: i=1; AJvYcCXd8oExY0CBtmo70Q7OywSjZwkOY/YvYLiphOkVH+Oz2xqTZB+Y5aFpP5VfX/igKc0V4eK97l4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq0svG+jiWzEmasY/dcbyjN4MJeALXt1cuyT9Gmxnr4tOC+JWn
	SVl0VojmxKvxY/UVJYInOpTbedBx/ICAS6+PyoaV5Vfo+rE7B/TRUy/8
X-Gm-Gg: ASbGncuWkn6k43ZebZ4h7Hi+HI33jmXsbf1l6mCRkUb+j6hFso3B8UkEAIats/GQrMI
	hwWLgd5mkJpAZ8MjEnMzYbvOysZTWcctxjH/MjL+5DxeqqGiPCrI6fzFK+nXlKMiYy5iu8sRaOW
	snitR15OH8/4fmbqqndGenIeZlU+rz+jl70lxMu5GCVazumliYtX56nljZzEnoux2OGhIKoPYxR
	0s0W7893rzRZIbgjKK94CTWKbCU7ehmAG4GHaxbWS0co4cwW0RgP6LuMqhBpBu3dEPu6ZDiyLJO
	ii/BzB6MfjSjgdwW0QslO3CzlEoUd8f/1hQ1o0WqBkPBpqXqw7UvKn8fgZemcRV/8rXez1G9bF9
	EGg5JW+FMkVk95TcX6VCY
X-Google-Smtp-Source: AGHT+IFJ5vaVd12z0MzqA3OPXJyu5N914WM0qfDHwgfWzPCymaj/ZHDVBC9xFv25O0pSg4V04aQSNg==
X-Received: by 2002:a17:907:7faa:b0:afe:8761:e77a with SMTP id a640c23a62f3a-b34b79c4a58mr905875966b.19.1758898660315;
        Fri, 26 Sep 2025 07:57:40 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b35446f7834sm376798866b.65.2025.09.26.07.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 07:57:39 -0700 (PDT)
Date: Fri, 26 Sep 2025 07:57:37 -0700
From: Breno Leitao <leitao@debian.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Gu Bowen <gubowen5@huawei.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Waiman Long <llong@redhat.com>, stable@vger.kernel.org, linux-mm@kvack.org, 
	John Ogness <john.ogness@linutronix.de>, Lu Jialin <lujialin4@huawei.com>
Subject: Re: [PATCH v5] mm: Fix possible deadlock in kmemleak
Message-ID: <kuq7guzalpqj5bxe2vt6s3kirrq4sg5ozwcim6ewnzpxhuxm4l@yfgb44nbcisz>
References: <20250822073541.1886469-1-gubowen5@huawei.com>
 <5ohuscufoavyezhy6n5blotk4hovyd2e23pfqylrfwhpu45nby@jxwe6jmkwdzb>
 <aNVSsmY86yi-cV_e@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNVSsmY86yi-cV_e@arm.com>

hello Catalin,

On Thu, Sep 25, 2025 at 03:33:22PM +0100, Catalin Marinas wrote:
> On Fri, Sep 19, 2025 at 03:37:27AM -0700, Breno Leitao wrote:
> > On Fri, Aug 22, 2025 at 03:35:41PM +0800, Gu Bowen wrote:
> > > To solve this problem, switch to printk_safe mode before printing warning
> > > message, this will redirect all printk()-s to a special per-CPU buffer,
> > > which will be flushed later from a safe context (irq work), and this
> > > deadlock problem can be avoided.
> > 
> > I am still thinking about this problem, given I got another deadlock
> > issue that I was not able to debug further given I do not have the
> > crashdump.
> 
> Do you have some kernel log? I thought we covered all cases in
> kmemleak.c (well, might have missed some).

I do have, but, I do not have the vmcore anymore, thus, I was not able
to investigate much, but, here is a kernel message and dump of what all
CPUs were doing. Let me start with the lock/crash:

	watchdog: BUG: soft lockup - CPU#8 stuck for 23s! [kworker/u144:2:526241]
	CPU#8 Utilization every 4s during lockup:
		#1:  45% system,	 55% softirq,	  2% hardirq,	  0% idle
		#2:  39% system,	 61% softirq,	  2% hardirq,	  0% idle
		#3:  28% system,	 73% softirq,	  2% hardirq,	  0% idle
		#4:  49% system,	 51% softirq,	  2% hardirq,	  0% idle
		#5:  42% system,	 58% softirq,	  2% hardirq,	  0% idle
	Modules linked in: sunrpc(E) squashfs(E) sch_fq(E) tls(E) act_gact(E) tcp_diag(E) inet_diag(E) cls_bpf(E) intel_uncore_frequency(E) intel_uncore_frequency_common(E) skx_edac(E) skx_edac_common(E) nfit(E) libnvdimm(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) coretemp(E) kvm_intel(E) iTCO_wdt(E) iTCO_vendor_support(E) xhci_pci(E) kvm(E) acpi_cpufreq(E) irqbypass(E) i2c_i801(E) xhci_hcd(E) i2c_smbus(E) wmi(E) ipmi_si(E) ipmi_devintf(E) evdev(E) ipmi_msghandler(E) button(E) sch_fq_codel(E) bpf_preload(E) vhost_net(E) tun(E) vhost(E) vhost_iotlb(E) tap(E) mpls_gso(E) mpls_iptunnel(E) mpls_router(E) fou(E) loop(E) drm(E) backlight(E) drm_panel_orientation_quirks(E) autofs4(E) efivarfs(E)
	irq event stamp: 0
	hardirqs last  enabled at (0): [<0000000000000000>] 0x0
	hardirqs last disabled at (0): [<ffffffff812f4fb2>] copy_process+0x362/0x1410
	softirqs last  enabled at (0): [<ffffffff812f4fb2>] copy_process+0x362/0x1410
	softirqs last disabled at (0): [<0000000000000000>] 0x0
	CPU: 8 UID: 0 PID: 526241 Comm: kworker/u144:2 Kdump: loaded Tainted: G S          E    N  6.17.0-0_fbk701_debug_rc0_0_gf83ec76bf285 #1 PREEMPT(none) 
	Tainted: [S]=CPU_OUT_OF_SPEC, [E]=UNSIGNED_MODULE, [N]=TEST
	Hardware name: Quanta Twin Lakes MP/Twin Lakes Passive MP, BIOS F09_3A23 12/08/2020
	Workqueue: events_unbound btrfs_reclaim_bgs_work
	RIP: 0010:_raw_spin_unlock_irqrestore+0x5d/0xa0
	Code: e0 fe f7 c3 00 02 00 00 74 05 e8 4e 5d f0 fe 9c 8f 04 24 f7 04 24 00 02 00 00 75 35 f7 c3 00 02 00 00 74 01 fb bf 01 00 00 00 <e8> 4e b3 d9 fe 65 8b 05 57 00 35 02 85 c0 74 26 65 48 8b 05 33 00
	RSP: 0018:ffffc900004106d0 EFLAGS: 00000206
	RAX: 24717fb88e5a6f00 RBX: 0000000000000282 RCX: 24717fb88e5a6f00
	RDX: 0000000000000000 RSI: ffffffff82a3a8dc RDI: 0000000000000001
	RBP: 0000000000000000 R08: ffff888f1cb85ab1 R09: ffff888f1cb85ab8
	R10: ffff888f1cb85ab0 R11: ffff888f1cb85ac0 R12: ffffea003b1dc780
	R13: ffffea003b1dc780 R14: ffffffff83e0bfd0 R15: ffffffff823c3954
	FS:  0000000000000000(0000) GS:ffff88909fb25000(0000) knlGS:0000000000000000
	CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
	CR2: 00007f7e0ea1d1e0 CR3: 0000001073627001 CR4: 00000000007726f0
	PKRU: 55555554
	Call Trace:
	<IRQ>
	delete_object_full+0xba/0xe0
	kmem_cache_free+0x108/0x3a0
	? skb_release_data+0x132/0x150
	tcp_rcv_established+0x2b4/0x720
	tcp_v6_do_rcv+0x18e/0x520
	tcp_v6_rcv+0x10e5/0x1260
	? raw6_local_deliver+0x68/0x3e0
	ip6_protocol_deliver_rcu+0x358/0x5c0
	? NF_HOOK+0x36/0x1e0
	? ip6_input+0x160/0x160
	ip6_input_finish+0x58/0xf0
	? ip6_input+0x160/0x160
	NF_HOOK+0x170/0x1e0
	? lock_release+0x4a/0x3e0
	? ip6_dst_check+0x48/0x2b0
	? ip6_dst_check+0x19c/0x2b0
	? ip6_input+0x1a/0x160
	ip6_input+0xb5/0x160
	ip6_sublist_rcv+0x331/0x520
	? ip6_rcv_core+0x4b7/0x6a0
	ipv6_list_rcv+0x159/0x180
	__netif_receive_skb_list_core+0x1eb/0x260
	netif_receive_skb_list_internal+0x26b/0x380
	? netif_receive_skb_list_internal+0x74/0x380
	? dev_gro_receive+0x393/0x810
	? rcu_is_watching+0xd/0x50
	gro_complete+0x8a/0x290
	dev_gro_receive+0x6df/0x810
	gro_receive_skb+0xf6/0x2e0
	bnxt_rx_pkt+0x112e/0x17a0
	? lock_release+0x4a/0x3e0
	? irqtime_account_irq+0x71/0x100
	__bnxt_poll_work+0x195/0x390
	? debug_check_no_obj_freed+0x27b/0x2a0
	bnxt_poll+0x7f/0x320
	? rcu_is_watching+0xd/0x50
	? rcu_is_watching+0xd/0x50
	__napi_poll+0x28/0x130
	net_rx_action+0x233/0x4a0
	? ktime_get+0x25/0x110
	? sched_clock+0xc/0x20
	? sched_clock_cpu+0xc/0x1d0
	handle_softirqs+0x171/0x4f0
	? __irq_exit_rcu+0x76/0x160
	__irq_exit_rcu+0x76/0x160
	irq_exit_rcu+0xa/0x20
	sysvec_apic_timer_interrupt+0xa0/0xc0
	</IRQ>
	<TASK>
	asm_sysvec_apic_timer_interrupt+0x16/0x20
	RIP: 0010:_raw_spin_unlock_irqrestore+0x5d/0xa0
	Code: e0 fe f7 c3 00 02 00 00 74 05 e8 4e 5d f0 fe 9c 8f 04 24 f7 04 24 00 02 00 00 75 35 f7 c3 00 02 00 00 74 01 fb bf 01 00 00 00 <e8> 4e b3 d9 fe 65 8b 05 57 00 35 02 85 c0 74 26 65 48 8b 05 33 00
	RSP: 0018:ffffc9003c3ef9d0 EFLAGS: 00000206
	RAX: 24717fb88e5a6f00 RBX: 0000000000000282 RCX: 24717fb88e5a6f00
	RDX: ffff888c3074c5d8 RSI: ffffffff82a3a8dc RDI: 0000000000000001
	RBP: 0000000000000000 R08: ffff888c3074c5e0 R09: ffff888c3074c5e8
	R10: 0000000000000001 R11: 8080000000000000 R12: ffffea000a532e40
	R13: ffffea000a532e40 R14: ffffffff83e0bfd0 R15: ffffffff81b3a016
	? set_extent_bit.llvm.5807687024302053429+0x9b6/0xbd0
	delete_object_full+0xba/0xe0
	kmem_cache_free+0x108/0x3a0
	set_extent_bit.llvm.5807687024302053429+0x9b6/0xbd0
	? btrfs_lock_extent_bits+0x4a/0x2d0
	btrfs_set_extent_delalloc+0x14f/0x170
	relocate_file_extent_cluster+0x54b/0xa20
	relocate_block_group+0x346/0x4a0
	btrfs_relocate_block_group+0x22d/0x4b0
	btrfs_relocate_chunk+0x64/0x220
	btrfs_reclaim_bgs_work+0x375/0x630
	? process_scheduled_works+0x28a/0x670
	process_scheduled_works+0x2e8/0x670
	worker_thread+0x26a/0x380
	? pr_cont_work+0x1c0/0x1c0
	kthread+0x227/0x250
	? kthread_blkcg+0x30/0x30
	ret_from_fork+0x155/0x260
	? kthread_blkcg+0x30/0x30
	ret_from_fork_asm+0x11/0x20
	</TASK>
	Kernel panic - not syncing: softlockup: hung tasks


This is the list of what each CPU was doing. The lines are based in 
commit f83ec76bf285bea5727f478a68b894f5543ca76e ("Linux 6.17-rc6")

	Crashing CPU: 8

	Running tasks:
	CPU: 3 PID: 37 COMM: ksoftirqd/3
	#0 queued_spin_lock_slowpath(lock=kmemleak_lock, node=0xffff8890241d4b00, tail=0x100000, next=0, __PTR=0xffff8890241d4b08) (kernel/locking/qspinlock.c:291:3)
	#1 queued_spin_lock (./include/asm-generic/qspinlock.h:114:2)
	#2 do_raw_spin_lock (kernel/locking/spinlock_debug.c:116:2)
	#3 __raw_spin_lock_irqsave(flags=130) (./include/linux/spinlock_api_smp.h:111:2)
	#4 _raw_spin_lock_irqsave(lock=kmemleak_lock) (kernel/locking/spinlock.c:162:9)
	#5 __find_and_get_object(ptr=0xffff888efe905c00[slab object: kmalloc-cg-128], alias=0, objflags=0) (mm/kmemleak.c:581:2)
	#6 paint_ptr(_entry_ptr=paint_ptr._entry, color=-1) (mm/kmemleak.c:928:11)
	#7 kvfree_call_rcu(__already_done=0, ptr=0xffff888efe905c00[slab object: kmalloc-cg-128]) (mm/slab_common.c:1987:2)
	#8 bpf_selem_free_list(__warned=0, selem=0xffff888efe905c00[slab object: kmalloc-cg-128], n=0xffff888f163abb28[slab object: kmalloc-cg-256+0x28], smap=0xffff8882ae87b000[slab object: kmalloc-cg-1k]) (kernel/bpf/bpf_local_storage.c:277:3)
	#9 bpf_local_storage_destroy(__warned=0, local_storage=0xffff888f21824f00[slab object: kmalloc-cg-256], storage_smap=0xffff8882ae87b000[slab object: kmalloc-cg-1k], flags=0x282) (kernel/bpf/bpf_local_storage.c:769:2)
	#10 bpf_sk_storage_free(__warned=0, sk_storage=0xffff888f21824f00[slab object: kmalloc-cg-256]) (net/core/bpf_sk_storage.c:59:2)
	#11 __sk_destruct(__warned=0, head=0xffff888c34b7aca8[slab object: TCPv6+0x4e8], sk=0xffff888c34b7a7c0[slab object: TCPv6], net=init_net, filter=0) (net/core/sock.c:2351:2)
	#12 skb_release_head_state(skb=0xffff888f25ce2600[slab object: skbuff_head_cache]) (net/core/skbuff.c:1138:3)
	#13 skb_release_all(reason=2) (net/core/skbuff.c:1149:2)
	#14 __kfree_skb (net/core/skbuff.c:1165:2)
	#15 kfree_skb_reason (./include/linux/skbuff.h:1275:2)
	#16 dev_kfree_skb_any_reason (net/core/dev.c:3442:3)
	#17 dev_consume_skb_any (./include/linux/netdevice.h:4148:2)
	#18 __bnxt_tx_int(bp=0xffff8882a1db4b80, txr=0xffff8882c067b000[slab object: kmalloc-4k], txq=0xffff8882a3220000, tx_bytes=0x4a3f, tx_pkts=236, rc=0, tx_buf=0xffffc90005bfe450[vmap: 0xffffc90005bfd000-0xffffc90005c12000 caller bnxt_alloc_ring+0x1e3]) (drivers/net/ethernet/broadcom/bnxt/bnxt.c:875:3)
	#19 bnxt_tx_int(bp=0xffff8882a1db4b80, bnapi=0xffff88828e490040, i=0, txr=0xffff8882c067b000[slab object: kmalloc-4k]) (drivers/net/ethernet/broadcom/bnxt/bnxt.c:895:12)
	#20 __bnxt_poll_work_done (drivers/net/ethernet/broadcom/bnxt/bnxt.c:3108:3)
	#21 bnxt_poll_work(bp=0xffff8882a1db4b80, cpr=0xffff88828e490268, budget=64, bnapi=0xffff88828e490040, rx_pkts=64) (drivers/net/ethernet/broadcom/bnxt/bnxt.c:3138:2)
	#22 bnxt_poll(napi=0xffff88828e490040, budget=64, bnapi=0xffff88828e490040, bp=0xffff8882a1db4b80, cpr=0xffff88828e490268, work_done=0) (drivers/net/ethernet/broadcom/bnxt/bnxt.c:3230:16)
	#23 __napi_poll(__print_once=0, __already_done=0, _entry_ptr=__napi_poll._entry, n=0xffff88828e490040, repoll=0xffffc900002f7d58[vmap stack: 37 (ksoftirqd/3) +0x3d58], weight=64, work=0) (net/core/dev.c:7506:10)
	#24 napi_poll(n=0xffff88828e490040, repoll=0xffffc900002f7d38[vmap stack: 37 (ksoftirqd/3) +0x3d38], do_repoll=0, have=0xffff88828e490040) (net/core/dev.c:7569:9)
	#25 net_rx_action(sd=0xffff8890241d5180, budget=0x12c, time_limit=0x1009ed990, n=0xffff88828e490040) (net/core/dev.c:7696:13)
	#26 handle_softirqs(_entry_ptr=handle_softirqs._entry, ksirqd=1, end=0xfffffffeff612670, old_flags=0x4208040, max_restart=10, pending=34, in_hardirq=1, h=softirq_vec+0x18, softirq_bit=2, vec_nr=3) (kernel/softirq.c:579:3)
	#27 run_ksoftirqd (kernel/softirq.c:968:3)
	#28 smpboot_thread_fn(data=0xffff8882881664b0[slab object: kmalloc-16], td=0xffff8882881664b0[slab object: kmalloc-16], ht=softirq_threads) (kernel/smpboot.c:160:4)
	#29 kthread(threadfn=smpboot_thread_fn, data=0xffff8882881664b0[slab object: kmalloc-16], self=0xffff888288a7ba00[slab object: kmalloc-512], ret=-4) (kernel/kthread.c:463:9)
	#30 ret_from_fork(regs=0xffffc900002f7f58[vmap stack: 37 (ksoftirqd/3) +0x3f58], fn=kthread, fn_arg=0xffff88828956fdc0[slab object: kmalloc-64]) (arch/x86/kernel/process.c:148:3)

	CPU: 5 PID: 0 COMM: swapper/5
	#0 get_stack_info_noinstr(stack=0xffffc900003748d8[vmap: 0xffffc90000371000-0xffffc90000376000 caller irq_init_percpu_irqstack+0x102], task=0xffff888289880000[slab object: task_struct], info=0xffffc90000374900[vmap: 0xffffc90000371000-0xffffc90000376000 caller irq_init_percpu_irqstack+0x102]) (arch/x86/kernel/dumpstack_64.c:172:0)
	#1 get_stack_info(__already_done=0, _entry_ptr=get_stack_info._entry, task=0xffff888289880000[slab object: task_struct], info=0xffffc90000374900[vmap: 0xffffc90000371000-0xffffc90000376000 caller irq_init_percpu_irqstack+0x102], visit_mask=0xffffc90000374920[vmap: 0xffffc90000371000-0xffffc90000376000 caller irq_init_percpu_irqstack+0x102]) (arch/x86/kernel/dumpstack_64.c:199:7)
	#2 __unwind_start(state=0xffffc90000374900[vmap: 0xffffc90000371000-0xffffc90000376000 caller irq_init_percpu_irqstack+0x102], first_frame=0xffffc90000374998[vmap: 0xffffc90000371000-0xffffc90000376000 caller irq_init_percpu_irqstack+0x102]) (arch/x86/kernel/unwind_orc.c:727:6)
	#3 unwind_start(state=0xffffc90000374900[vmap: 0xffffc90000371000-0xffffc90000376000 caller irq_init_percpu_irqstack+0x102], task=0xffff888289880000[slab object: task_struct], regs=0) (./arch/x86/include/asm/unwind.h:64:2)
	#4 arch_stack_walk(consume_entry=stack_trace_consume_entry, cookie=0xffffc900003749a8[vmap: 0xffffc90000371000-0xffffc90000376000 caller irq_init_percpu_irqstack+0x102], task=0xffff888289880000[slab object: task_struct], regs=0) (arch/x86/kernel/stacktrace.c:24:7)
	#5 stack_trace_save (kernel/stacktrace.c:122:2)
	#6 set_track_prepare (mm/kmemleak.c:655:15)
	#7 __alloc_object(_entry_ptr=__alloc_object._entry) (mm/kmemleak.c:701:25)
	#8 __create_object(ptr=0xffff888f205db700[slab object: skbuff_small_head]) (mm/kmemleak.c:779:11)
	#9 kmemleak_alloc_recursive(ptr=0xffff888f205db700[slab object: skbuff_small_head], min_count=1) (./include/linux/kmemleak.h:44:3)
	#10 slab_post_alloc_hook(s=0xffff88828a294900[slab object: kmem_cache], lru=0, flags=0x82820, size=1, p=0xffffc90000374af0[vmap: 0xffffc90000371000-0xffffc90000376000 caller irq_init_percpu_irqstack+0x102]) (mm/slub.c:4195:3)
	#11 slab_alloc_node(s=0xffff88828a294900[slab object: kmem_cache], lru=0, gfpflags=0x82820, addr=kmalloc_reserve+0x12d, orig_size=0x280, object=0xffff888f205db700[slab object: skbuff_small_head]) (mm/slub.c:4240:2)
	#12 kmem_cache_alloc_node_noprof(s=0xffff88828a294900[slab object: kmem_cache], gfpflags=0x82820, node=-1) (mm/slub.c:4292:14)
	#13 kmalloc_reserve(size=0xffffc90000374b84[vmap: 0xffffc90000371000-0xffffc90000376000 caller irq_init_percpu_irqstack+0x102], flags=0x2820, node=-1, pfmemalloc=0xffffc90000374b83[vmap: 0xffffc90000371000-0xffffc90000376000 caller irq_init_percpu_irqstack+0x102], ret_pfmemalloc=0, _old=0) (net/core/skbuff.c:578:9)
	#14 __alloc_skb(size=150, gfp_mask=0x2820, flags=6, node=-1, cache=0xffff88828a294700[slab object: kmem_cache], skb=0xffff888f1f491a00[slab object: skbuff_head_cache], pfmemalloc=0) (net/core/skbuff.c:669:9)
	#15 napi_alloc_skb(napi=0xffff88828e4919c0, len=150, gfp_mask=0x2820) (net/core/skbuff.c:811:9)
	#16 bnxt_copy_data(data=0xffff888f14b5d040, bp=0xffff8882a1db4b80, pdev=0xffff88829058f000[slab object: kmalloc-4k]) (drivers/net/ethernet/broadcom/bnxt/bnxt.c:1395:8)
	#17 bnxt_copy_skb(data=0xffff888f14b5d040) (drivers/net/ethernet/broadcom/bnxt/bnxt.c:1417:9)
	#18 bnxt_rx_pkt(__print_once=0, bp=0xffff8882a1db4b80, cpr=0xffff88828e491be8, raw_cons=0xffffc90000374d7c[vmap: 0xffffc90000371000-0xffffc90000376000 caller irq_init_percpu_irqstack+0x102], event=0xffffc90000374d7b[vmap: 0xffffc90000371000-0xffffc90000376000 caller irq_init_percpu_irqstack+0x102], bnapi=0xffff88828e4919c0, rxr=0xffff88828e48e280, dev=0xffff8882a1db4000, xdp_active=0, rc=0, rxcmp=0xffff8882956a8820, cmp_type=17, rxcmp1=0xffff8882956a8830, prod=0x8f52, cons=0xf53, rx_buf=0xffffc90005bb1fc8[vmap: 0xffffc90005b9b000-0xffffc90005bcc000 caller bnxt_alloc_ring+0x1e3], data=0xffff888f14b5d000, misc=0x560601, agg_bufs=0, flags=0x562411) (drivers/net/ethernet/broadcom/bnxt/bnxt.c:2245:10)
	#19 __bnxt_poll_work(bp=0xffff8882a1db4b80, cpr=0xffff88828e491be8, budget=64, bnapi=0xffff88828e4919c0, raw_cons=0x13b7482, rx_pkts=0, event=1, txcmp=0xffff8882956a8820) (drivers/net/ethernet/broadcom/bnxt/bnxt.c:3053:10)
	#20 bnxt_poll_work(bp=0xffff8882a1db4b80, cpr=0xffff88828e491be8, budget=64, bnapi=0xffff88828e4919c0) (drivers/net/ethernet/broadcom/bnxt/bnxt.c:3130:12)
	#21 bnxt_poll(napi=0xffff88828e4919c0, budget=64, bnapi=0xffff88828e4919c0, bp=0xffff8882a1db4b80, cpr=0xffff88828e491be8, work_done=0) (drivers/net/ethernet/broadcom/bnxt/bnxt.c:3230:16)
	#22 __napi_poll(__print_once=0, __already_done=0, _entry_ptr=__napi_poll._entry, n=0xffff88828e4919c0, repoll=0xffffc90000374ea8[vmap: 0xffffc90000371000-0xffffc90000376000 caller irq_init_percpu_irqstack+0x102], weight=64, work=0) (net/core/dev.c:7506:10)
	#23 napi_poll(n=0xffff88828e4919c0, repoll=0xffffc90000374e88[vmap: 0xffffc90000371000-0xffffc90000376000 caller irq_init_percpu_irqstack+0x102], do_repoll=0, have=0xffff88828e4919c0) (net/core/dev.c:7569:9)
	#24 net_rx_action(sd=0xffff8890242d5180, budget=0x12c, time_limit=0x1009ed9d6, n=0xffff88828e4919c0) (net/core/dev.c:7696:13)
	#25 handle_softirqs(_entry_ptr=handle_softirqs._entry, ksirqd=0, end=0xfffffffeff61262a, old_flags=0x4200042, max_restart=10, pending=8, in_hardirq=0, h=softirq_vec+0x18, softirq_bit=4, vec_nr=3) (kernel/softirq.c:579:3)
	#26 __do_softirq (kernel/softirq.c:613:2)
	#27 invoke_softirq (kernel/softirq.c:453:3)
	#28 __irq_exit_rcu (kernel/softirq.c:680:3)
	#29 irq_exit_rcu (kernel/softirq.c:696:2)
	#30 common_interrupt(regs=0xffffc9000017fdc8[vmap: 0xffffc9000017c000-0xffffc90000181000 caller copy_process+0x172]) (arch/x86/kernel/irq.c:318:1)
	#31 asm_common_interrupt (./arch/x86/include/asm/idtentry.h:693:0)
	#32 cpuidle_enter_state(__already_done=0, dev=0xffff8890242ddf88, drv=intel_idle_driver, index=2, time_start=0x9bf5c92f347, entered_state=2, time_end=0x9bf5c9548a9) (drivers/cpuidle/cpuidle.c:292:20)
	#33 cpuidle_enter(drv=intel_idle_driver, dev=0xffff8890242ddf88, index=2, ret=0) (drivers/cpuidle/cpuidle.c:389:9)
	#34 call_cpuidle(drv=intel_idle_driver, dev=0xffff8890242ddf88, next_state=2) (kernel/sched/idle.c:160:9)
	#35 cpuidle_idle_call(dev=0xffff8890242ddf88, drv=intel_idle_driver, next_state=2) (kernel/sched/idle.c:235:19)
	#36 do_idle(cpu=5) (kernel/sched/idle.c:330:4)
	#37 cpu_startup_entry(state=146) (kernel/sched/idle.c:428:3)
	#38 start_secondary (arch/x86/kernel/smpboot.c:315:2)

	CPU: 8 PID: 526241 COMM: kworker/u144:2
	#0 crash_setup_regs(newregs=0xffffc90000410328[vmap: 0xffffc9000040d000-0xffffc90000412000 caller irq_init_percpu_irqstack+0x102], oldregs=0) (./arch/x86/include/asm/kexec.h:108:15)
	#1 __crash_kexec(regs=0) (kernel/crash_core.c:133:4)
	#2 vpanic(_entry_ptr=vpanic._entry, _entry_ptr=vpanic._entry, _entry_ptr=vpanic._entry, i_next=0, state=0, _crash_kexec_post_notifiers=0) (kernel/panic.c:449:3)
	#3 panic (kernel/panic.c:566:2)
	#4 watchdog_timer_fn(_entry_ptr=watchdog_timer_fn._entry, regs=0xffffc90000410628[vmap: 0xffffc9000040d000-0xffffc90000412000 caller irq_init_percpu_irqstack+0x102], softlockup_all_cpu_backtrace=0, duration=23, flags=2) (kernel/watchdog.c:832:4)
	#5 __run_hrtimer(cpu_base=0xffff889024431c40, base=0xffff889024431cc0, timer=0xffff889024432c80, flags=130, fn=watchdog_timer_fn, expires_in_hardirq=0) (kernel/time/hrtimer.c:1761:12)
	#6 __hrtimer_run_queues(cpu_base=0xffff889024431c40, now=0x9be2bdcdb88, flags=130, base=0xffff889024431cc0, timer=0xffff889024432c80) (kernel/time/hrtimer.c:1825:4)
	#7 hrtimer_interrupt(__already_done=0, _entry_ptr=hrtimer_interrupt._entry, cpu_base=0xffff889024431c40, retries=0, flags=130, now=0x9be2bdcdb88, entry_time=0x9be2bdcdb88) (kernel/time/hrtimer.c:1887:2)
	#8 local_apic_timer_interrupt(evt=0xffff88902441be40) (arch/x86/kernel/apic/apic.c:1039:2)
	#9 __sysvec_apic_timer_interrupt(old_regs=0) (arch/x86/kernel/apic/apic.c:1056:2)
	#10 instr_sysvec_apic_timer_interrupt(regs=0xffffc90000410628[vmap: 0xffffc9000040d000-0xffffc90000412000 caller irq_init_percpu_irqstack+0x102]) (arch/x86/kernel/apic/apic.c:1050:1)
	#11 sysvec_apic_timer_interrupt(regs=0xffffc90000410628[vmap: 0xffffc9000040d000-0xffffc90000412000 caller irq_init_percpu_irqstack+0x102]) (arch/x86/kernel/apic/apic.c:1050:1)
	#12 asm_sysvec_apic_timer_interrupt (./arch/x86/include/asm/idtentry.h:702:0)
	#13 __raw_spin_unlock_irqrestore(lock=kmemleak_lock, flags=0x282) (./include/linux/spinlock_api_smp.h:152:2)
	#14 _raw_spin_unlock_irqrestore(lock=kmemleak_lock, flags=0x282) (kernel/locking/spinlock.c:194:2)
	#15 find_and_remove_object(alias=0, objflags=0, flags=0x282, object=0xffff88873889fa48[slab object: kmemleak_object]) (mm/kmemleak.c:637:2)
	#16 delete_object_full(objflags=0) (mm/kmemleak.c:839:11)
	#17 kmemleak_free_recursive(ptr=0xffff888ec771ec00[slab object: skbuff_head_cache]) (./include/linux/kmemleak.h:50:3)
	#18 slab_free_hook(s=0xffff88828a294700[slab object: kmem_cache], x=0xffff888ec771ec00[slab object: skbuff_head_cache], init=0, after_rcu_delay=0) (mm/slub.c:2347:2)
	#19 slab_free(s=0xffff88828a294700[slab object: kmem_cache], slab=0xffffea003b1dc780, object=0xffff888ec771ec00[slab object: skbuff_head_cache], addr=tcp_rcv_established+0x2b4) (mm/slub.c:4695:6)
	#20 kmem_cache_free(s=0xffff88828a294700[slab object: kmem_cache]) (mm/slub.c:4797:2)
	#21 tcp_rcv_established(sk=0xffff888c47b41a80[slab object: TCPv6], skb=0xffff888ec771ec00[slab object: skbuff_head_cache], reason=2, th=0xffff888f15bb1976[slab object: skbuff_small_head+0x76], len=32, delta=0, tcp_header_len=32) (net/ipv4/tcp_input.c:6121:5)
	#22 tcp_v6_do_rcv(__warned=0, sk=0xffff888c47b41a80[slab object: TCPv6], skb=0xffff888ec771ec00[slab object: skbuff_head_cache], np=0xffff888c47b426c0[slab object: TCPv6+0xc40], opt_skb=0, dst=0xffff88839f77c800[slab object: ip6_dst_cache]) (net/ipv6/tcp_ipv6.c:1647:3)
	#23 tcp_v6_rcv(skb=0xffff888ec771ec00[slab object: skbuff_head_cache], net=init_net, dif=2, sk=0xffff888c47b41a80[slab object: TCPv6], drop_reason=0, ret=0) (net/ipv6/tcp_ipv6.c:1916:9)
	#24 ip6_protocol_deliver_rcu(__warned=0, net=init_net, skb=0xffff888ec771ec00[slab object: skbuff_head_cache], nexthdr=6, have_final=1, reason=2, idev=0xffff88828a090800[slab object: kmalloc-cg-2k], ipprot=net_hotdata+0xf0) (net/ipv6/ip6_input.c:438:9)
	#25 ip6_input_finish (net/ipv6/ip6_input.c:489:2)
	#26 NF_HOOK(pf=10, net=init_net, sk=0, skb=0xffff888ec771ec00[slab object: skbuff_head_cache], in=0xffff8882a1db4000, out=0, okfn=ip6_input_finish, ret=1) (./include/linux/netfilter.h:318:9)
	#27 ip6_input(skb=0xffff888ec771ec00[slab object: skbuff_head_cache]) (net/ipv6/ip6_input.c:500:8)
	#28 dst_input(skb=0xffff888ec771ec00[slab object: skbuff_head_cache]) (./include/net/dst.h:471:9)
	#29 ip6_sublist_rcv_finish(head=0xffffc900004109d0[vmap: 0xffffc9000040d000-0xffffc90000412000 caller irq_init_percpu_irqstack+0x102], skb=0xffff888ec771ec00[slab object: skbuff_head_cache]) (net/ipv6/ip6_input.c:88:3)
	#30 ip6_list_rcv_finish(net=init_net, sk=0, head=0xffffc90000410a50[vmap: 0xffffc9000040d000-0xffffc90000412000 caller irq_init_percpu_irqstack+0x102], hint=0xffff888ec771f600[slab object: skbuff_head_cache], curr_dst=0xffff88839f77c800[slab object: ip6_dst_cache], skb=0xffffc90000410a50[vmap: 0xffffc9000040d000-0xffffc90000412000 caller irq_init_percpu_irqstack+0x102]) (net/ipv6/ip6_input.c:145:2)
	#31 ip6_sublist_rcv(head=0xffffc90000410a50[vmap: 0xffffc9000040d000-0xffffc90000412000 caller irq_init_percpu_irqstack+0x102], net=init_net) (net/ipv6/ip6_input.c:321:2)
	#32 ipv6_list_rcv(head=0xffffc90000410ac0[vmap: 0xffffc9000040d000-0xffffc90000412000 caller irq_init_percpu_irqstack+0x102], skb=0xffffc90000410ac0[vmap: 0xffffc9000040d000-0xffffc90000412000 caller irq_init_percpu_irqstack+0x102]) (net/ipv6/ip6_input.c:355:3)
	#33 __netif_receive_skb_list_ptype(head=0xffffc90000410ac0[vmap: 0xffffc9000040d000-0xffffc90000412000 caller irq_init_percpu_irqstack+0x102], pt_prev=ipv6_packet_type, orig_dev=0xffff8882a1db4000) (net/core/dev.c:6034:3)
	#34 __netif_receive_skb_list_core(head=0xffff88828e491f08, pt_curr=ipv6_packet_type, od_curr=0xffff8882a1db4000, skb=0xffff88828e491f08) (net/core/dev.c:6081:2)
	#35 __netif_receive_skb_list(head=0xffff88828e491f08, skb=0xffff88828e491f08) (net/core/dev.c:6133:3)
	#36 netif_receive_skb_list_internal(head=0xffff88828e491f08) (net/core/dev.c:6224:2)
	#37 gro_normal_list(gro=0xffff88828e491e40) (./include/net/gro.h:532:2)
	#38 gro_normal_one(gro=0xffff88828e491e40, skb=0xffff888ec771f800[slab object: skbuff_head_cache]) (./include/net/gro.h:552:3)
	#39 gro_complete(__warned=0, gro=0xffff88828e491e40, skb=0xffff888ec771f800[slab object: skbuff_head_cache]) (net/core/gro.c:286:2)
	#40 dev_gro_receive(__warned=0, gro=0xffff88828e491e40, skb=0xffff888ec771e900[slab object: skbuff_head_cache], bucket=7, gro_list=0xffff88828e491ef0, type=0xdd86, pp=0xffff888ec771f800[slab object: skbuff_head_cache]) (net/core/gro.c:529:3)
	#41 gro_receive_skb(gro=0xffff88828e491e40, skb=0xffff888ec771e900[slab object: skbuff_head_cache]) (net/core/gro.c:631:33)
	#42 bnxt_rx_pkt(__print_once=0, bp=0xffff8882a1db4b80, cpr=0xffff88828e492028, raw_cons=0xffffc90000410d7c[vmap: 0xffffc9000040d000-0xffffc90000412000 caller irq_init_percpu_irqstack+0x102], event=0xffffc90000410d7b[vmap: 0xffffc9000040d000-0xffffc90000412000 caller irq_init_percpu_irqstack+0x102], bnapi=0xffff88828e491e00, rxr=0xffff88828e48e840, dev=0xffff8882a1db4000, rc=0, rxcmp=0xffff88829e4b00a0, cmp_type=17, rxcmp1=0xffff88829e4b00b0, prod=0x435a, cons=0x35b, data=0xffff888f28925000, misc=0x560600, flags=0x33b2411, skb=0xffff888ec771e900[slab object: skbuff_head_cache]) (drivers/net/ethernet/broadcom/bnxt/bnxt.c:2343:2)
	#43 __bnxt_poll_work(bp=0xffff8882a1db4b80, cpr=0xffff88828e492028, budget=64, bnapi=0xffff88828e491e00, raw_cons=0x161830a, rx_pkts=8, event=17, txcmp=0xffff88829e4b00a0) (drivers/net/ethernet/broadcom/bnxt/bnxt.c:3053:10)
	#44 bnxt_poll_work(bp=0xffff8882a1db4b80, cpr=0xffff88828e492028, budget=64, bnapi=0xffff88828e491e00) (drivers/net/ethernet/broadcom/bnxt/bnxt.c:3130:12)
	#45 bnxt_poll(napi=0xffff88828e491e00, budget=64, bnapi=0xffff88828e491e00, bp=0xffff8882a1db4b80, cpr=0xffff88828e492028, work_done=0) (drivers/net/ethernet/broadcom/bnxt/bnxt.c:3230:16)
	#46 __napi_poll(__print_once=0, __already_done=0, _entry_ptr=__napi_poll._entry, n=0xffff88828e491e00, repoll=0xffffc90000410ea8[vmap: 0xffffc9000040d000-0xffffc90000412000 caller irq_init_percpu_irqstack+0x102], weight=64, work=0) (net/core/dev.c:7506:10)
	#47 napi_poll(n=0xffff88828e491e00, repoll=0xffffc90000410e88[vmap: 0xffffc9000040d000-0xffffc90000412000 caller irq_init_percpu_irqstack+0x102], do_repoll=0, have=0xffff88828e491e00) (net/core/dev.c:7569:9)
	#48 net_rx_action(sd=0xffff889024455180, budget=0x12c, time_limit=0x1009ed0fa, n=0xffff88828e491e00) (net/core/dev.c:7696:13)
	#49 handle_softirqs(_entry_ptr=handle_softirqs._entry, ksirqd=0, end=0xfffffffeff612f06, old_flags=0x4208060, max_restart=10, pending=0x208, in_hardirq=0, h=softirq_vec+0x18, softirq_bit=4, vec_nr=3) (kernel/softirq.c:579:3)
	#50 __do_softirq (kernel/softirq.c:613:2)
	#51 invoke_softirq (kernel/softirq.c:453:3)
	#52 __irq_exit_rcu (kernel/softirq.c:680:3)
	#53 irq_exit_rcu (kernel/softirq.c:696:2)
	#54 instr_sysvec_apic_timer_interrupt(regs=0xffffc9003c3ef928[vmap stack: 526241 (kworker/u144:2) +0x3928]) (arch/x86/kernel/apic/apic.c:1050:1)
	#55 sysvec_apic_timer_interrupt(regs=0xffffc9003c3ef928[vmap stack: 526241 (kworker/u144:2) +0x3928]) (arch/x86/kernel/apic/apic.c:1050:1)
	#56 asm_sysvec_apic_timer_interrupt (./arch/x86/include/asm/idtentry.h:702:0)
	#57 __raw_spin_unlock_irqrestore(lock=kmemleak_lock, flags=0x282) (./include/linux/spinlock_api_smp.h:152:2)
	#58 _raw_spin_unlock_irqrestore(lock=kmemleak_lock, flags=0x282) (kernel/locking/spinlock.c:194:2)
	#59 find_and_remove_object(alias=0, objflags=0, flags=0x282, object=0xffff888c3074dde8[slab object: kmemleak_object]) (mm/kmemleak.c:637:2)
	#60 delete_object_full(objflags=0) (mm/kmemleak.c:839:11)
	#61 kmemleak_free_recursive(ptr=0xffff888294cb9400[slab object: btrfs_extent_state]) (./include/linux/kmemleak.h:50:3)
	#62 slab_free_hook(s=0xffff88828da43300[slab object: kmem_cache], x=0xffff888294cb9400[slab object: btrfs_extent_state], init=0, after_rcu_delay=0) (mm/slub.c:2347:2)
	#63 slab_free(s=0xffff88828da43300[slab object: kmem_cache], slab=0xffffea000a532e40, object=0xffff888294cb9400[slab object: btrfs_extent_state], addr=set_extent_bit.llvm.5807687024302053429+0x9b6) (mm/slub.c:4695:6)
	#64 kmem_cache_free(s=0xffff88828da43300[slab object: kmem_cache]) (mm/slub.c:4797:2)
	#65 set_extent_bit(_entry_ptr=set_extent_bit._entry, _entry_ptr=set_extent_bit._entry, tree=0xffff8882beccc1e8[slab object: btrfs_inode+0xa8], end=0xf37bfff, failed_start=0, failed_state=0, prealloc=0xffff888294cb9400[slab object: btrfs_extent_state], ret=0, exclusive_bits=0) (fs/btrfs/extent-io-tree.c:1288:2)
	#66 btrfs_set_extent_bit(tree=0xffff8882beccc1e8[slab object: btrfs_inode+0xa8], end=0xf37bfff) (fs/btrfs/extent-io-tree.c:1297:9)
	#67 btrfs_set_extent_delalloc(end=0xf37bfff) (fs/btrfs/inode.c:2722:9)
	#68 relocate_one_folio(rc=0xffff888cef79f000[slab object: kmalloc-2k], ra=0xffff888f0c881c40[slab object: kmalloc-32], cluster=0xffff888cef79f128[slab object: kmalloc-2k+0x128], inode=0xffff8882beccc4e0[slab object: btrfs_inode+0x3a0], fs_info=0xffff88828a10c000, offset=0x2689d00000, folio=0xffffea0006669280, folio_start=0xf37b000, folio_end=0xf37bfff, cur=0xf37b000, cached_state=0xffff888294cb9300[slab object: btrfs_extent_state], extent_end=0x10180fff, clamped_start=0xf37b000, clamped_len=0x1000, clamped_end=0xf37bfff) (fs/btrfs/relocation.c:2889:9)
	#69 relocate_file_extent_cluster(rc=0xffff888cef79f000[slab object: kmalloc-2k], cluster=0xffff888cef79f128[slab object: kmalloc-2k+0x128], offset=0x2689d00000, cluster_nr=0, ret=0) (fs/btrfs/relocation.c:2979:9)
	#70 relocate_block_group(rc=0xffff888cef79f000[slab object: kmalloc-2k], fs_info=0xffff88828a10c000, trans=0xffff8882e407d790[free slab object: btrfs_trans_handle], path=0xffff8882e354d2a0[slab object: btrfs_path]) (fs/btrfs/relocation.c:3641:9)
	#71 btrfs_relocate_block_group(_entry_ptr=btrfs_relocate_block_group._entry, fs_info=0xffff88828a10c000, verbose=1, rw=1, err=0, bg=0xffff888c30852800[slab object: kmalloc-1k], rc=0xffff888cef79f000[slab object: kmalloc-2k]) (fs/btrfs/relocation.c:3997:9)
	#72 btrfs_relocate_chunk(fs_info=0xffff88828a10c000, chunk_offset=0x2689d00000, root=0xffff8882b5a88000[slab object: kmalloc-4k]) (fs/btrfs/volumes.c:3451:8)
	#73 btrfs_reclaim_bgs_work(work=0xffff88828a10dfb0, fs_info=0xffff88828a10c000, bg=0xffff888c30852800[slab object: kmalloc-1k], space_info=0xffff8882b5a92800[slab object: kmalloc-1k], reserved=0, used=0x10181000) (fs/btrfs/block-group.c:1981:9)
	#74 process_one_work(worker=0xffff8885d7f02f00[slab object: kmalloc-192], work=0xffff88828a10dfb0, pwq=0xffff888288208c00[slab object: pool_workqueue], pool=0xffff888284a60800[slab object: kmalloc-2k], work_data=0xffff888288208c05[slab object: pool_workqueue+0x5], rcu_start_depth=0, lockdep_start_depth=0) (kernel/workqueue.c:3236:2)
	#75 process_scheduled_works(worker=0xffff8885d7f02f00[slab object: kmalloc-192]) (kernel/workqueue.c:3319:3)
	#76 worker_thread(__worker=0xffff8885d7f02f00[slab object: kmalloc-192], worker=0xffff8885d7f02f00[slab object: kmalloc-192], pool=0xffff888284a60800[slab object: kmalloc-2k]) (kernel/workqueue.c:3400:4)
	#77 kthread(threadfn=worker_thread, data=0xffff8885d7f02f00[slab object: kmalloc-192], self=0xffff888753ef8400[slab object: kmalloc-512], ret=-4) (kernel/kthread.c:463:9)
	#78 ret_from_fork(regs=0xffffc9003c3eff58[vmap stack: 526241 (kworker/u144:2) +0x3f58], fn=kthread, fn_arg=0xffff88873b51ddc0[free slab object: kmalloc-64]) (arch/x86/kernel/process.c:148:3)

	CPU: 9 PID: 73 COMM: ksoftirqd/9
	#0 queued_spin_lock_slowpath(lock=kmemleak_lock, node=0xffff8890244d4b00, tail=0x280000) (kernel/locking/qspinlock.c:328:8)
	#1 queued_spin_lock (./include/asm-generic/qspinlock.h:114:2)
	#2 do_raw_spin_lock (kernel/locking/spinlock_debug.c:116:2)
	#3 __raw_spin_lock_irqsave(flags=0x282) (./include/linux/spinlock_api_smp.h:111:2)
	#4 _raw_spin_lock_irqsave(lock=kmemleak_lock) (kernel/locking/spinlock.c:162:9)
	#5 find_and_remove_object(ptr=0xffff888f22fb0c80[slab object: skbuff_small_head], alias=0) (mm/kmemleak.c:635:2)
	#6 delete_object_full(ptr=0xffff888f22fb0c80[slab object: skbuff_small_head]) (mm/kmemleak.c:839:11)
	#7 kmemleak_free_recursive(ptr=0xffff888f22fb0c80[slab object: skbuff_small_head]) (./include/linux/kmemleak.h:50:3)
	#8 slab_free_hook(s=0xffff88828a294900[slab object: kmem_cache], x=0xffff888f22fb0c80[slab object: skbuff_small_head], init=0, after_rcu_delay=0) (mm/slub.c:2347:2)
	#9 slab_free(s=0xffff88828a294900[slab object: kmem_cache], slab=0xffffea003c8bec00, object=0xffff888f22fb0c80[slab object: skbuff_small_head], addr=skb_release_data+0x132) (mm/slub.c:4695:6)
	#10 kmem_cache_free(s=0xffff88828a294900[slab object: kmem_cache]) (mm/slub.c:4797:2)
	#11 skb_release_data(skb=0xffff888f0da9ece0[slab object: skbuff_fclone_cache+0xe0], reason=2, shinfo=0xffff888f22fb0dc0[slab object: skbuff_small_head+0x140]) (net/core/skbuff.c:1086:2)
	#12 skb_release_all(skb=0xffff888f0da9ece0[slab object: skbuff_fclone_cache+0xe0], reason=2) (net/core/skbuff.c:1151:3)
	#13 __kfree_skb(skb=0xffff888f0da9ece0[slab object: skbuff_fclone_cache+0xe0]) (net/core/skbuff.c:1165:2)
	#14 kfree_skb_reason (./include/linux/skbuff.h:1275:2)
	#15 dev_kfree_skb_any_reason (net/core/dev.c:3442:3)
	#16 dev_consume_skb_any (./include/linux/netdevice.h:4148:2)
	#17 __bnxt_tx_int(bp=0xffff8882a1db4b80, txr=0xffff8882c067b300[slab object: kmalloc-4k+0x300], txq=0xffff8882a3220380, tx_bytes=0x146f6, tx_pkts=0x13f, rc=0, tx_buf=0xffffc90005c29be8[vmap: 0xffffc90005c27000-0xffffc90005c3c000 caller bnxt_alloc_ring+0x1e3]) (drivers/net/ethernet/broadcom/bnxt/bnxt.c:875:3)
	#18 bnxt_tx_int(bp=0xffff8882a1db4b80, bnapi=0xffff88828e4908c0, i=0, txr=0xffff8882c067b300[slab object: kmalloc-4k+0x300]) (drivers/net/ethernet/broadcom/bnxt/bnxt.c:895:12)
	#19 __bnxt_poll_work_done (drivers/net/ethernet/broadcom/bnxt/bnxt.c:3108:3)
	#20 bnxt_poll_work(bp=0xffff8882a1db4b80, cpr=0xffff88828e490ae8, budget=64, bnapi=0xffff88828e4908c0, rx_pkts=64) (drivers/net/ethernet/broadcom/bnxt/bnxt.c:3138:2)
	#21 bnxt_poll(napi=0xffff88828e4908c0, budget=64, bnapi=0xffff88828e4908c0, bp=0xffff8882a1db4b80, cpr=0xffff88828e490ae8, work_done=0) (drivers/net/ethernet/broadcom/bnxt/bnxt.c:3230:16)
	#22 __napi_poll(__print_once=0, __already_done=0, _entry_ptr=__napi_poll._entry, n=0xffff88828e4908c0, repoll=0xffffc9000042fd58[vmap stack: 73 (ksoftirqd/9) +0x3d58], weight=64, work=0) (net/core/dev.c:7506:10)
	#23 napi_poll(n=0xffff88828e4908c0, repoll=0xffffc9000042fd38[vmap stack: 73 (ksoftirqd/9) +0x3d38], do_repoll=0, have=0xffff88828e4908c0) (net/core/dev.c:7569:9)
	#24 net_rx_action(sd=0xffff8890244d5180, budget=0x12c, time_limit=0x1009ed992, n=0xffff88828e4908c0) (net/core/dev.c:7696:13)
	#25 handle_softirqs(_entry_ptr=handle_softirqs._entry, ksirqd=1, end=0xfffffffeff61266e, old_flags=0x4208040, max_restart=10, pending=8, in_hardirq=1, h=softirq_vec+0x18, softirq_bit=4, vec_nr=3) (kernel/softirq.c:579:3)
	#26 run_ksoftirqd (kernel/softirq.c:968:3)
	#27 smpboot_thread_fn(data=0xffff888288166810[slab object: kmalloc-16], td=0xffff888288166810[slab object: kmalloc-16], ht=softirq_threads) (kernel/smpboot.c:160:4)
	#28 kthread(threadfn=smpboot_thread_fn, data=0xffff888288166810[slab object: kmalloc-16], self=0xffff888289ac0c00[slab object: kmalloc-512], ret=-4) (kernel/kthread.c:463:9)
	#29 ret_from_fork(regs=0xffffc9000042ff58[vmap stack: 73 (ksoftirqd/9) +0x3f58], fn=kthread, fn_arg=0xffff88828998fa00[slab object: kmalloc-64]) (arch/x86/kernel/process.c:148:3)

	CPU: 11 PID: 7324 COMM: bar
	#0 queued_spin_lock_slowpath(lock=kmemleak_lock, node=0xffff8890245d4b00, tail=0x300000, next=0, __PTR=0xffff8890245d4b08) (kernel/locking/qspinlock.c:291:3)
	#1 queued_spin_lock (./include/asm-generic/qspinlock.h:114:2)
	#2 do_raw_spin_lock (kernel/locking/spinlock_debug.c:116:2)
	#3 __raw_spin_lock_irqsave(flags=0x282) (./include/linux/spinlock_api_smp.h:111:2)
	#4 _raw_spin_lock_irqsave(lock=kmemleak_lock) (kernel/locking/spinlock.c:162:9)
	#5 __create_object(ptr=0xffff888f0e530000[slab object: skbuff_fclone_cache], size=0x1c8, min_count=1, objflags=0) (mm/kmemleak.c:783:2)
	#6 kmemleak_alloc_recursive(ptr=0xffff888f0e530000[slab object: skbuff_fclone_cache], min_count=1) (./include/linux/kmemleak.h:44:3)
	#7 slab_post_alloc_hook(s=0xffff88828a294800[slab object: kmem_cache], lru=0, flags=0xcc0, size=1, p=0xffffc9000c93fa88[vmap stack: 7324 (ScribeIO0) +0x3a88]) (mm/slub.c:4195:3)
	#8 slab_alloc_node(s=0xffff88828a294800[slab object: kmem_cache], lru=0, gfpflags=0xcc0, addr=__alloc_skb+0x17e, orig_size=0x1c8, object=0xffff888f0e530000[slab object: skbuff_fclone_cache]) (mm/slub.c:4240:2)
	#9 kmem_cache_alloc_node_noprof(s=0xffff88828a294800[slab object: kmem_cache], gfpflags=0xcc0, node=-1) (mm/slub.c:4292:14)
	#10 __alloc_skb(gfp_mask=0xcc0, flags=1, node=-1, cache=0xffff88828a294800[slab object: kmem_cache], _old=0) (net/core/skbuff.c:659:9)
	#11 alloc_skb_fclone(size=0x100) (./include/linux/skbuff.h:1386:9)
	#12 tcp_stream_alloc_skb(sk=0xffff88866ca58000[slab object: TCPv6], force_schedule=1) (net/ipv4/tcp.c:892:8)
	#13 tcp_sendmsg_locked(sk=0xffff88866ca58000[slab object: TCPv6], msg=0xffffc9000c93fe68[vmap stack: 7324 (ScribeIO0) +0x3e68], binding=0, tp=0xffff88866ca58000[slab object: TCPv6], uarg=0, copied=0, mss_now=0x7c00, process_backlog=0, zc=0, skb=0) (net/ipv4/tcp.c:1198:10)
	#14 tcp_sendmsg(sk=0xffff88866ca58000[slab object: TCPv6], msg=0xffffc9000c93fe68[vmap stack: 7324 (ScribeIO0) +0x3e68], size=64) (net/ipv4/tcp.c:1393:8)
	#15 sock_sendmsg_nosec(sock=0xffff888d1bf33180[slab object: sock_inode_cache], msg=0xffffc9000c93fe68[vmap stack: 7324 (ScribeIO0) +0x3e68]) (net/socket.c:714:12)
	#16 __sock_sendmsg(sock=0xffff888d1bf33180[slab object: sock_inode_cache], msg=0xffffc9000c93fe68[vmap stack: 7324 (ScribeIO0) +0x3e68]) (net/socket.c:729:16)
	#17 ____sys_sendmsg(sock=0xffff888d1bf33180[slab object: sock_inode_cache], msg_sys=0xffffc9000c93fe68[vmap stack: 7324 (ScribeIO0) +0x3e68], used_address=0, ctl_buf=0xffffc9000c93fc68[vmap stack: 7324 (ScribeIO0) +0x3c68], ctl_len=0) (net/socket.c:2614:8)
	#18 ___sys_sendmsg(sock=0xffff888d1bf33180[slab object: sock_inode_cache], msg_sys=0xffffc9000c93fe68[vmap stack: 7324 (ScribeIO0) +0x3e68], flags=0x4040, used_address=0, allowed_msghdr_flags=0, iov=0, err=0) (net/socket.c:2668:8)
	#19 __sys_sendmsg(msg=0x7efd4fbf6170, flags=0x4040, forbid_cmsg_compat=1) (net/socket.c:2700:9)
	#20 __do_sys_sendmsg(msg=0x7efd4fbf6170, flags=0x4040) (net/socket.c:2705:9)
	#21 __se_sys_sendmsg(msg=0x7efd4fbf6170) (net/socket.c:2703:1)
	#22 __x64_sys_sendmsg (net/socket.c:2703:1)
	#23 do_syscall_x64(regs=0xffffc9000c93ff58[vmap stack: 7324 (ScribeIO0) +0x3f58], nr=46) (arch/x86/entry/syscall_64.c:63:14)
	#24 do_syscall_64(regs=0xffffc9000c93ff58[vmap stack: 7324 (ScribeIO0) +0x3f58], nr=46) (arch/x86/entry/syscall_64.c:94:7)
	#25 entry_SYSCALL_64 (arch/x86/entry/entry_64.S:121:0)

	CPU: 17 PID: 501192 COMM: blah
	#0 memset_orig (arch/x86/lib/memset_64.S:70:0)
	#1 INIT_HLIST_NODE (./include/linux/list.h:937:11)
	#2 inode_init_once (fs/inode.c:506:2)
	#3 setup_object(s=0xffff8882889e6600[slab object: kmem_cache]) (mm/slub.c:2475:3)
	#4 allocate_slab(s=0xffff8882889e6600[slab object: kmem_cache], slab=0xffffea003c025c00, shuffle=0, idx=8) (mm/slub.c:2697:11)
	#5 new_slab(s=0xffff8882889e6600[slab object: kmem_cache], node=-1) (mm/slub.c:2714:9)
	#6 ___slab_alloc(s=0xffff8882889e6600[slab object: kmem_cache], gfpflags=0xcc0, node=-1, addr=proc_alloc_inode.llvm.9965772860669215490+0xa7, c=0xffff8890248dba60, orig_size=0x4c8, slab=0) (mm/slub.c:3901:9)
	#7 __slab_alloc(s=0xffff8882889e6600[slab object: kmem_cache], gfpflags=0xcc0, node=-1, addr=proc_alloc_inode.llvm.9965772860669215490+0xa7, c=0xffff8890248dba60) (mm/slub.c:3992:6)
	#8 __slab_alloc_node(s=0xffff8882889e6600[slab object: kmem_cache], gfpflags=0xcc0, node=-1, addr=proc_alloc_inode.llvm.9965772860669215490+0xa7, orig_size=0x4c8, object=0) (mm/slub.c:4067:12)
	#9 slab_alloc_node(s=0xffff8882889e6600[slab object: kmem_cache], gfpflags=0xcc0, node=-1, addr=proc_alloc_inode.llvm.9965772860669215490+0xa7, orig_size=0x4c8, init=0) (mm/slub.c:4228:11)
	#10 kmem_cache_alloc_lru_noprof(s=0xffff8882889e6600[slab object: kmem_cache], lru=0xffff8883c24b67f8[slab object: kmalloc-4k+0x7f8], gfpflags=0xcc0) (mm/slub.c:4259:14)
	#11 proc_alloc_inode(_old=0) (fs/proc/inode.c:57:7)
	#12 alloc_inode(sb=0xffff8883c24b6000[slab object: kmalloc-4k], ops=proc_sops) (fs/inode.c:346:11)
	#13 new_inode (fs/inode.c:1145:10)
	#14 proc_pid_make_inode (fs/proc/base.c:1953:10)
	#15 proc_fd_instantiate(dentry=0xffff8882bee20000[slab object: dentry], ptr=0xffffc90036f07e10[vmap stack: 501192 (FuncSched) +0x3e10], data=0xffffc90036f07e10[vmap stack: 501192 (FuncSched) +0x3e10]) (fs/proc/fd.c:209:10)
	#16 proc_fill_cache(ctx=0xffffc90036f07e98[vmap stack: 501192 (FuncSched) +0x3e98], name=0xffffc90036f07e1d[vmap stack: 501192 (FuncSched) +0x3e1d], len=4, instantiate=proc_fd_instantiate, ptr=0xffffc90036f07e10[vmap stack: 501192 (FuncSched) +0x3e10], dir=0xffff8885fe54f6d8[slab object: dentry], type=0, ino=1, child=0xffff8882bee20000[slab object: dentry]) (fs/proc/base.c:2138:10)
	#17 proc_readfd_common(file=0xffff888cdfe75800[slab object: filp], ctx=0xffffc90036f07e98[vmap stack: 501192 (FuncSched) +0x3e98], instantiate=proc_fd_instantiate, p=0xffff888756c9a480[slab object: task_struct]) (fs/proc/fd.c:275:8)
	#18 iterate_dir(file=0xffff888cdfe75800[slab object: filp], ctx=0xffffc90036f07e98[vmap stack: 501192 (FuncSched) +0x3e98], res=-2, inode=0xffff88866ea5bed8[slab object: proc_inode_cache+0x48]) (fs/readdir.c:108:9)
	#19 __do_sys_getdents64(dirent=0x7fee18e75030, count=0x8000) (fs/readdir.c:410:10)
	#20 __se_sys_getdents64(dirent=0x7fee18e75030, count=0x8000) (fs/readdir.c:396:1)
	#21 do_syscall_x64(regs=0xffffc90036f07f58[vmap stack: 501192 (FuncSched) +0x3f58], nr=217) (arch/x86/entry/syscall_64.c:63:14)
	#22 do_syscall_64(regs=0xffffc90036f07f58[vmap stack: 501192 (FuncSched) +0x3f58], nr=217) (arch/x86/entry/syscall_64.c:94:7)
	#23 entry_SYSCALL_64 (arch/x86/entry/entry_64.S:121:0)

	CPU: 18 PID: 11401 COMM: blabla
	#0 stack_trace_consume_entry(cookie=0xffffc90021923a78[vmap stack: 11401 (below) +0x3a78], addr=do_sys_openat2+0x6c, c=0xffffc90021923a78[vmap stack: 11401 (below) +0x3a78]) (kernel/stacktrace.c:95:1)
	#1 arch_stack_walk(consume_entry=stack_trace_consume_entry, cookie=0xffffc90021923a78[vmap stack: 11401 (below) +0x3a78], task=0xffff8886352bc900[slab object: task_struct]) (arch/x86/kernel/stacktrace.c:27:17)
	#2 stack_trace_save (kernel/stacktrace.c:122:2)
	#3 set_track_prepare (mm/kmemleak.c:655:15)
	#4 __alloc_object(_entry_ptr=__alloc_object._entry) (mm/kmemleak.c:701:25)
	#5 __create_object(ptr=0xffff8882b2ec4e80[slab object: seq_file]) (mm/kmemleak.c:779:11)
	#6 kmemleak_alloc_recursive(ptr=0xffff8882b2ec4e80[slab object: seq_file], min_count=1) (./include/linux/kmemleak.h:44:3)
	#7 slab_post_alloc_hook(s=0xffff8882889e6500[slab object: kmem_cache], lru=0, flags=0xdc0, size=1, p=0xffffc90021923bb8[vmap stack: 11401 (below) +0x3bb8]) (mm/slub.c:4195:3)
	#8 slab_alloc_node(s=0xffff8882889e6500[slab object: kmem_cache], lru=0, gfpflags=0xdc0, node=-1, addr=single_open+0x12a, orig_size=232, object=0xffff8882b2ec4e80[slab object: seq_file]) (mm/slub.c:4240:2)
	#9 kmem_cache_alloc_noprof(s=0xffff8882889e6500[slab object: kmem_cache], gfpflags=0xdc0) (mm/slub.c:4247:14)
	#10 seq_open(file=0xffff888c5bd35e00[slab object: filp], op=0xffff8882b4c509e0[slab object: kmalloc-cg-32], _old=0) (fs/seq_file.c:63:6)
	#11 single_open(file=0xffff888c5bd35e00[slab object: filp], data=0xffff8883c9d943a8[slab object: proc_inode_cache+0x48], op=0xffff8882b4c509e0[slab object: kmalloc-cg-32], res=-12) (fs/seq_file.c:583:9)
	#12 do_dentry_open(f=0xffff888c5bd35e00[slab object: filp], open=proc_single_open, inode=0xffff8883c9d943a8[slab object: proc_inode_cache+0x48]) (fs/open.c:965:11)
	#13 vfs_open(file=0xffff888c5bd35e00[slab object: filp]) (fs/open.c:1095:8)
	#14 do_open(nd=0xffffc90021923d78[vmap stack: 11401 (below) +0x3d78], file=0xffff888c5bd35e00[slab object: filp], op=0xffffc90021923e94[vmap stack: 11401 (below) +0x3e94], open_flag=0x8000, idmap=nop_mnt_idmap) (fs/namei.c:3887:11)
	#15 path_openat(__warned=0, nd=0xffffc90021923d78[vmap stack: 11401 (below) +0x3d78], op=0xffffc90021923e94[vmap stack: 11401 (below) +0x3e94], flags=0x101, file=0xffff888c5bd35e00[slab object: filp]) (fs/namei.c:4046:12)
	#16 do_filp_open(op=0xffffc90021923e94[vmap stack: 11401 (below) +0x3e94], flags=1) (fs/namei.c:4073:9)
	#17 do_sys_openat2(dfd=-100, how=0xffffc90021923ed8[vmap stack: 11401 (below) +0x3ed8], tmp=0xffff88828c5bd000[slab object: names_cache], fd=158) (fs/open.c:1435:20)
	#18 do_sys_open (fs/open.c:1450:9)
	#19 __do_sys_openat (fs/open.c:1466:9)
	#20 __se_sys_openat (fs/open.c:1461:1)
	#21 __x64_sys_openat (fs/open.c:1461:1)
	#22 do_syscall_x64(regs=0xffffc90021923f58[vmap stack: 11401 (below) +0x3f58], nr=0x101) (arch/x86/entry/syscall_64.c:63:14)
	#23 do_syscall_64(regs=0xffffc90021923f58[vmap stack: 11401 (below) +0x3f58], nr=0x101) (arch/x86/entry/syscall_64.c:94:7)
	#24 entry_SYSCALL_64 (arch/x86/entry/entry_64.S:121:0)

	CPU: 20 PID: 7652 COMM: blabla
	#0 check_cb_ovld(rdp=0xffff889024a54b40) (kernel/rcu/tree.c:3084:6)
	#1 __call_rcu_common(head=0xffff888f268e7d80[slab object: kmemleak_object+0x80], lazy_in=0, flags=0x246, rdp=0xffff889024a54b40, lazy=0) (kernel/rcu/tree.c:3142:2)
	#2 call_rcu(head=0xffff888f268e7d80[slab object: kmemleak_object+0x80]) (kernel/rcu/tree.c:3243:2)
	#3 kmemleak_free_recursive(ptr=0xffff88871ff7a400[slab object: btrfs_extent_state]) (./include/linux/kmemleak.h:50:3)
	#4 slab_free_hook(s=0xffff88828da43300[slab object: kmem_cache], x=0xffff88871ff7a400[slab object: btrfs_extent_state], init=0, after_rcu_delay=0) (mm/slub.c:2347:2)
	#5 slab_free(s=0xffff88828da43300[slab object: kmem_cache], slab=0xffffea001c7fde80, object=0xffff88871ff7a400[slab object: btrfs_extent_state], addr=set_extent_bit.llvm.5807687024302053429+0x9b6) (mm/slub.c:4695:6)
	#6 kmem_cache_free(s=0xffff88828da43300[slab object: kmem_cache]) (mm/slub.c:4797:2)
	#7 set_extent_bit(_entry_ptr=set_extent_bit._entry, _entry_ptr=set_extent_bit._entry, tree=0xffff88866b2fa970[slab object: btrfs_inode+0xa8], end=0x1106fff, failed_start=0, failed_state=0, prealloc=0xffff88871ff7a400[slab object: btrfs_extent_state], ret=0, exclusive_bits=0) (fs/btrfs/extent-io-tree.c:1288:2)
	#8 btrfs_set_extent_bit(tree=0xffff88866b2fa970[slab object: btrfs_inode+0xa8], end=0x1106fff) (fs/btrfs/extent-io-tree.c:1297:9)
	#9 btrfs_set_extent_delalloc(end=0x1106fff) (fs/btrfs/inode.c:2722:9)
	#10 btrfs_dirty_folio(_entry_ptr=btrfs_dirty_folio._entry, _entry_ptr=btrfs_dirty_folio._entry, inode=0xffff88866b2fa8c8[slab object: btrfs_inode], folio=0xffffea0006ea5180, ret=0, fs_info=0xffff88828a10c000, end_pos=0x11063ac, extra_bits=0, isize=0x1106354, start_pos=0x1106000, num_bytes=0x1000, end_of_last_block=0x1106fff) (fs/btrfs/file.c:104:8)
	#11 copy_one_range(inode=0xffff88866b2fa8c8[slab object: btrfs_inode], iter=0xffffc9000d2c7e28[vmap stack: 7652 (Collection-25) +0x3e28], start=0x1106354, fs_info=0xffff88828a10c000, cached_state=0xffff88871ff7aa00[slab object: btrfs_extent_state], reserved_start=0x1106000, folio=0xffffea0006ea5180, only_release_metadata=0, bdp_flags=0, reserved_len=0x1000, extents_locked=1, copied=88) (fs/btrfs/file.c:1325:8)
	#12 btrfs_buffered_write(iocb=0xffffc9000d2c7e50[vmap stack: 7652 (Collection-25) +0x3e50], iter=0xffffc9000d2c7e28[vmap stack: 7652 (Collection-25) +0x3e28], inode=0xffff88866b2fac68[slab object: btrfs_inode+0x3a0], num_written=0, ilock_flags=0, old_isize=0x1106354, pos=0x1106354) (fs/btrfs/file.c:1389:9)
	#13 btrfs_do_write_iter(iocb=0xffffc9000d2c7e50[vmap stack: 7652 (Collection-25) +0x3e50]) (fs/btrfs/file.c:1463:17)
	#14 new_sync_write(filp=0xffff888c3b1ed680[slab object: filp], buf=0x7fea6a6f5f80, len=88, ppos=0xffffc9000d2c7eb8[vmap stack: 7652 (Collection-25) +0x3eb8]) (fs/read_write.c:593:8)
	#15 vfs_write(file=0xffff888c3b1ed680[slab object: filp], buf=0x7fea6a6f5f80, count=88, pos=0xffffc9000d2c7eb8[vmap stack: 7652 (Collection-25) +0x3eb8]) (fs/read_write.c:686:9)
	#16 ksys_write(buf=0x7fea6a6f5f80, count=88, ret=-9, ppos=0xffffc9000d2c7eb8[vmap stack: 7652 (Collection-25) +0x3eb8]) (fs/read_write.c:738:9)
	#17 do_syscall_x64(regs=0xffffc9000d2c7f58[vmap stack: 7652 (Collection-25) +0x3f58], nr=1) (arch/x86/entry/syscall_64.c:63:14)
	#18 do_syscall_64(regs=0xffffc9000d2c7f58[vmap stack: 7652 (Collection-25) +0x3f58], nr=1) (arch/x86/entry/syscall_64.c:94:7)
	#19 entry_SYSCALL_64 (arch/x86/entry/entry_64.S:121:0)

	CPU: 22 PID: 493448 COMM: blan
	#0 __lookup_object(_entry_ptr=__lookup_object._entry, ptr=0xffff888f3a251180[slab object: skbuff_small_head], alias=0, rb=0xffff888f1f155370[slab object: kmemleak_object+0x68]) (mm/kmemleak.c:426:2)
	#1 __find_and_remove_object(ptr=0xffff888f3a251180[slab object: skbuff_small_head], alias=0, objflags=0) (mm/kmemleak.c:617:11)
	#2 find_and_remove_object(ptr=0xffff888f3a251180[slab object: skbuff_small_head], alias=0, objflags=0, flags=0x282) (mm/kmemleak.c:636:11)
	#3 delete_object_full(ptr=0xffff888f3a251180[slab object: skbuff_small_head], objflags=0) (mm/kmemleak.c:839:11)
	#4 kmemleak_free_recursive(ptr=0xffff888f3a251180[slab object: skbuff_small_head]) (./include/linux/kmemleak.h:50:3)
	#5 slab_free_hook(s=0xffff88828a294900[slab object: kmem_cache], x=0xffff888f3a251180[slab object: skbuff_small_head], init=0, after_rcu_delay=0) (mm/slub.c:2347:2)
	#6 slab_free(s=0xffff88828a294900[slab object: kmem_cache], slab=0xffffea003ce89400, object=0xffff888f3a251180[slab object: skbuff_small_head], addr=skb_release_data+0x132) (mm/slub.c:4695:6)
	#7 kmem_cache_free(s=0xffff88828a294900[slab object: kmem_cache]) (mm/slub.c:4797:2)
	#8 skb_release_data(skb=0xffff88883e71dc00[slab object: skbuff_fclone_cache], reason=2, shinfo=0xffff888f3a2512c0[slab object: skbuff_small_head+0x140]) (net/core/skbuff.c:1086:2)
	#9 skb_release_all(skb=0xffff88883e71dc00[slab object: skbuff_fclone_cache], reason=2) (net/core/skbuff.c:1151:3)
	#10 __kfree_skb(skb=0xffff88883e71dc00[slab object: skbuff_fclone_cache]) (net/core/skbuff.c:1165:2)
	#11 tcp_wmem_free_skb(sk=0xffff888b18b20000[slab object: TCPv6], skb=0xffff88883e71dc00[slab object: skbuff_fclone_cache]) (./include/net/tcp.h:308:2)
	#12 tcp_rtx_queue_purge(sk=0xffff888b18b20000[slab object: TCPv6], p=0, skb=0xffff88883e71dc00[slab object: skbuff_fclone_cache]) (net/ipv4/tcp.c:3304:3)
	#13 tcp_write_queue_purge(sk=0xffff888b18b20000[slab object: TCPv6]) (net/ipv4/tcp.c:3317:2)
	#14 tcp_v4_destroy_sock(__warned=0, sk=0xffff888b18b20000[slab object: TCPv6], tp=0xffff888b18b20000[slab object: TCPv6]) (net/ipv4/tcp_ipv4.c:2564:2)
	#15 inet_csk_destroy_sock(sk=0xffff888b18b20000[slab object: TCPv6]) (net/ipv4/inet_connection_sock.c:1294:2)
	#16 __tcp_close(__warned=0, sk=0xffff888b18b20000[slab object: TCPv6]) (net/ipv4/tcp.c:3262:3)
	#17 tcp_close(sk=0xffff888b18b20000[slab object: TCPv6], timeout=0) (net/ipv4/tcp.c:3274:2)
	#18 inet_release(sock=0xffff888ec7d2f380[slab object: sock_inode_cache], sk=0xffff888b18b20000[slab object: TCPv6]) (net/ipv4/af_inet.c:435:3)
	#19 __sock_release(sock=0xffff888ec7d2f380[slab object: sock_inode_cache], inode=0xffff888ec7d2f440[slab object: sock_inode_cache+0xc0], ops=inet6_stream_ops, owner=0) (net/socket.c:649:3)
	#20 sock_close(inode=0xffff888ec7d2f440[slab object: sock_inode_cache+0xc0]) (net/socket.c:1439:2)
	#21 __fput(file=0xffff888c3b1ed800[slab object: filp], dentry=0xffff888736fa5728[slab object: dentry], mnt=0xffff88828a2dc320[slab object: mnt_cache+0x20], inode=0xffff888ec7d2f440[slab object: sock_inode_cache+0xc0], mode=0xc2e0003) (fs/file_table.c:468:3)
	#22 __do_sys_close(file=0xffff888c3b1ed800[slab object: filp], retval=0) (fs/open.c:1587:2)
	#23 __se_sys_close (fs/open.c:1572:1)
	#24 do_syscall_x64(regs=0xffffc9002b627f58[vmap stack: 493448 (SR_TLSConnectio) +0x3f58], nr=3) (arch/x86/entry/syscall_64.c:63:14)
	#25 do_syscall_64(regs=0xffffc9002b627f58[vmap stack: 493448 (SR_TLSConnectio) +0x3f58], nr=3) (arch/x86/entry/syscall_64.c:94:7)
	#26 entry_SYSCALL_64 (arch/x86/entry/entry_64.S:121:0)


	CPU: 24 PID: 4908 COMM: bla
	#0 csd_lock_wait_toolong(csd=0xffffc90009a3bc60[vmap stack: 4908 (dynoKernelMon) +0x3c60], ts0=0x9be54c8a8aa, cpu=-1, flags=17) (kernel/smp.c:241:14)
	#1 __csd_lock_wait(csd=0xffffc90009a3bc60[vmap stack: 4908 (dynoKernelMon) +0x3c60], nmessages=0, bug_id=0, ts0=0x9be54c8a8aa, ts1=0x9be54c8a8aa) (kernel/smp.c:328:7)
	#2 csd_lock_wait(csd=0xffffc90009a3bc60[vmap stack: 4908 (dynoKernelMon) +0x3c60]) (kernel/smp.c:338:3)
	#3 smp_call_function_single(func=__perf_event_read, info=0xffffc90009a3bcf8[vmap stack: 4908 (dynoKernelMon) +0x3cf8], wait=1, csd=0xffffc90009a3bc60[vmap stack: 4908 (dynoKernelMon) +0x3c60], err=0) (kernel/smp.c:687:3)
	#4 perf_event_read(event=0xffff88828a42d9a0[slab object: perf_event], group=0, ret=0) (kernel/events/core.c:4862:9)
	#5 __perf_event_read_value(event=0xffff88828a42d9a0[slab object: perf_event], enabled=0xffffc90009a3bda8[vmap stack: 4908 (dynoKernelMon) +0x3da8], running=0xffffc90009a3bda0[vmap stack: 4908 (dynoKernelMon) +0x3da0], total=0) (kernel/events/core.c:5890:8)
	#6 perf_read_one(event=0xffff88828a42d9a0[slab object: perf_event], read_format=7, buf=0x7f0b9b1bdf98, n=0, enabled=0, running=0) (kernel/events/core.c:6050:16)
	#7 __perf_read(event=0xffff88828a42d9a0[slab object: perf_event], buf=0x7f0b9b1bdf98, count=32, read_format=7) (kernel/events/core.c:6103:9)
	#8 perf_read(buf=0x7f0b9b1bdf98, count=32, event=0xffff88828a42d9a0[slab object: perf_event], ctx=0xffff88902443e370) (kernel/events/core.c:6120:8)
	#9 vfs_read(file=0xffff88833c218780[slab object: filp], buf=0x7f0b9b1bdf98, pos=0xffffc90009a3beb8[vmap stack: 4908 (dynoKernelMon) +0x3eb8]) (fs/read_write.c:570:9)
	#10 ksys_read(buf=0x7f0b9b1bdf98, count=32, ret=-9, ppos=0xffffc90009a3beb8[vmap stack: 4908 (dynoKernelMon) +0x3eb8]) (fs/read_write.c:715:9)
	#11 do_syscall_x64(regs=0xffffc90009a3bf58[vmap stack: 4908 (dynoKernelMon) +0x3f58], nr=0) (arch/x86/entry/syscall_64.c:63:14)
	#12 do_syscall_64(regs=0xffffc90009a3bf58[vmap stack: 4908 (dynoKernelMon) +0x3f58], nr=0) (arch/x86/entry/syscall_64.c:94:7)
	#13 entry_SYSCALL_64 (arch/x86/entry/entry_64.S:121:0)

	CPU: 28 PID: 480960 COMM: kworker/u144:17
	#0 csd_lock_wait_toolong(csd=0xffff88902445c880, ts0=0x9be2c355318, cpu=-1) (kernel/smp.c:238:23)
	#1 __csd_lock_wait(csd=0xffff88902445c880, nmessages=0, bug_id=0, ts0=0x9be2c355318, ts1=0x9be2c355318) (kernel/smp.c:328:7)
	#2 csd_lock_wait (kernel/smp.c:338:3)
	#3 smp_call_function_many_cond(mask=__cpu_online_mask, func=do_sync_core.llvm.7180805200076648557, info=0, scf_flags=3, this_cpu=28, cfd=0xffff889024e54d80) (kernel/smp.c:877:4)
	#4 on_each_cpu_cond_mask(cond_func=0, func=do_sync_core.llvm.7180805200076648557, info=0, mask=__cpu_online_mask, scf_flags=3) (kernel/smp.c:1044:2)
	#5 on_each_cpu(info=0, wait=1) (./include/linux/smp.h:71:2)
	#6 smp_text_poke_sync_each_cpu (arch/x86/kernel/alternative.c:2653:2)
	#7 smp_text_poke_batch_finish (arch/x86/kernel/alternative.c:2863:2)
	#8 arch_jump_label_transform_apply (arch/x86/kernel/jump_label.c:146:2)
	#9 __jump_label_update (kernel/jump_label.c:521:2)
	#10 static_key_enable_cpuslocked(key=kfence_allocation_key) (kernel/jump_label.c:210:3)
	#11 static_key_enable (kernel/jump_label.c:223:2)
	#12 toggle_allocation_gate (mm/kfence/core.c:850:2)
	#13 process_one_work(worker=0xffff88873925c840[slab object: kmalloc-192], work=kfence_timer, pwq=0xffff888288209a00[slab object: pool_workqueue], pool=0xffff888284a60800[slab object: kmalloc-2k], work_data=0xffff888288209a05[slab object: pool_workqueue+0x5], rcu_start_depth=0, lockdep_start_depth=0) (kernel/workqueue.c:3236:2)
	#14 process_scheduled_works(worker=0xffff88873925c840[slab object: kmalloc-192]) (kernel/workqueue.c:3319:3)
	#15 worker_thread(__worker=0xffff88873925c840[slab object: kmalloc-192], worker=0xffff88873925c840[slab object: kmalloc-192], pool=0xffff888284a60800[slab object: kmalloc-2k]) (kernel/workqueue.c:3400:4)
	#16 kthread(threadfn=worker_thread, data=0xffff88873925c840[slab object: kmalloc-192], self=0xffff888726e6d800[slab object: kmalloc-512], ret=-4) (kernel/kthread.c:463:9)
	#17 ret_from_fork(regs=0xffffc9002acdff58[vmap stack: 480960 (kworker/u144:17) +0x3f58], fn=kthread, fn_arg=0xffff88871eadab00[slab object: kmalloc-64]) (arch/x86/kernel/process.c:148:3)

	CPU: 31 PID: 353 COMM: kmemleak
	#0 queued_spin_lock_slowpath(lock=kmemleak_lock, node=0xffff889024fd4b00, tail=0x800000, next=0, __PTR=0xffff889024fd4b08) (kernel/locking/qspinlock.c:291:3)
	#1 queued_spin_lock (./include/asm-generic/qspinlock.h:114:2)
	#2 do_raw_spin_lock (kernel/locking/spinlock_debug.c:116:2)
	#3 __raw_spin_lock_irqsave(flags=134) (./include/linux/spinlock_api_smp.h:111:2)
	#4 _raw_spin_lock_irqsave(lock=kmemleak_lock) (kernel/locking/spinlock.c:162:9)
	#5 scan_block(start=0xffff88893ced2b60[slab object: lsm_inode_cache], end=0xffff88893ced2b79[slab object: lsm_inode_cache+0x19]) (mm/kmemleak.c:1530:2)
	#6 scan_object(object=0xffff888c3c736910[slab object: kmemleak_object], flags=0x282) (mm/kmemleak.c:1609:4)
	#7 scan_gray_list(object=0xffff888c3c736910[slab object: kmemleak_object]) (mm/kmemleak.c:1648:4)
	#8 kmemleak_scan(__warned=0, __warned=0, __warned=0, __warned=0, _entry_ptr=kmemleak_scan._entry, new_leaks=0) (mm/kmemleak.c:1800:2)
	#9 kmemleak_scan_thread(first_run=0, _entry_ptr=kmemleak_scan_thread._entry, _entry_ptr=kmemleak_scan_thread._entry, timeout=0x927c0) (mm/kmemleak.c:1903:3)
	#10 kthread(threadfn=kmemleak_scan_thread, data=0, self=0xffff88828ba5d200[slab object: kmalloc-512], ret=-4) (kernel/kthread.c:463:9)
	#11 ret_from_fork(regs=0xffffc90002177f58[vmap stack: 353 (kmemleak) +0x3f58], fn=kthread, fn_arg=0xffff8890063f0000[slab object: kmemleak_object]) (arch/x86/kernel/process.c:148:3)


> 
> > Should we have a wrapper around raw_spin_lock_irqsave(kmemleak_lock,
> > flags), that would defer printk at all? 
> > 
> > Then, we can simply replace the raw_spin_lock_irqsave() by the helper,
> > avoiding spreading these printk_deferred_enter() in the kmemleak code.
> > 
> > For instance, something as this completely untested code, just to show
> > the idea.
> > 
> > 	void kmemleak_lock(unsigned long *flags) {
> > 		printk_deferred_enter();
> > 		raw_spin_lock_irqsave(&kmemleak_lock, flags);
> > 	}
> > 
> > 	void kmemleak_lock(unsigned long flags) {
> > 		raw_spin_unlock_irqrestore(&kmemleak_lock, flags);
> > 		printk_deferred_exit();
> > 	}
> 
> The way we added the printk deferring recently is around the actual
> printk() calls. Given that you can't get an interrupt under
> raw_spin_lock_irqsave(), 


My concern is when printk() is called with kmemleak_lock held(). Something as:

raw_spin_lock_irqsave(&kmemleak_lock, flags);
   -> printk()


This is instant deadlock when netconsole is enabled. Given that
netconsole tries to allocate memory when flushing. Similarly to commit
47b0f6d8f0d2be ("mm/kmemleak: avoid deadlock by moving pr_warn() outside
kmemleak_lock").

The hack above would guarantee that  all printks() inside kmemleak_lock
critical area to be deferred, and not executed inline.

> I don't think printk_deferred_exit() would
> trigger a console flush. So we could simply add them around those
> kmemleak_warn() or pr_*() calls rather than together with the spinlocks.

AFAIK printk_deferred_exit() only tells printk that all further
printks() could be executed "inline", instead of being deferred to be
executed on a workqueue. This is done setting an per-cpu
`printk_context`.

While the patch above tells printk to defer all printk a workqueue when
it happens from inside kemleak_lock region.

> But we do need to be able to reproduce the problem and show that any
> potential patch fixes it.

ack!

Thanks for the reply,
--breno

