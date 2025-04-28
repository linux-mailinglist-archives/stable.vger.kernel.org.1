Return-Path: <stable+bounces-136968-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3960BA9FC49
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 23:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 131A5188BFCD
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 21:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864062101B7;
	Mon, 28 Apr 2025 21:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wylie.me.uk header.i=@wylie.me.uk header.b="iBx5lyIc"
X-Original-To: stable@vger.kernel.org
Received: from wylie.me.uk (wylie.me.uk [82.68.155.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C4220B7FD;
	Mon, 28 Apr 2025 21:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.68.155.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745876101; cv=none; b=M2hxj2Qb7948wIQNKjLjL9Xikupd7H/7cODubV/N6OFFs+wQCzRBiJ2fG9wIzDQYDkYmgbgITOaLykNnIaKnqcARKpG5yw2TeOMCy4Bn86ol42/zMm2wB7YpCqrE9DryalmEE0IykgoZoHywfQTTXatGGZrZZTIUIDxB5RBxlXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745876101; c=relaxed/simple;
	bh=vnWp8P/f82zW/1bRdFMUriUFJlEc3dQM6Nbaofozku4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rnc6pyRuRP9U+52FRKSaeZaorDWPROB5oGXCQeN1U9C62vezi00KghV0DTa5yWWegUnHIbfd5WFDP4xUqduOh/yEMQH9b12VMYx1qK4ltl7dOrrCvrv0D/5WhzPGbc+/aWMf9y9OjiNILRE1wqxdT9pHzmMJm6H/6A4mWk7FskI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wylie.me.uk; spf=pass smtp.mailfrom=wylie.me.uk; dkim=pass (2048-bit key) header.d=wylie.me.uk header.i=@wylie.me.uk header.b=iBx5lyIc; arc=none smtp.client-ip=82.68.155.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wylie.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wylie.me.uk
Received: from frodo.int.wylie.me.uk (frodo.int.wylie.me.uk [192.168.21.2])
	by wylie.me.uk (Postfix) with ESMTP id 6963212085B;
	Mon, 28 Apr 2025 22:34:37 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wylie.me.uk;
	s=mydkim006; t=1745876077;
	bh=vnWp8P/f82zW/1bRdFMUriUFJlEc3dQM6Nbaofozku4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=iBx5lyIcqldvfXJaDXiTx+hvApXWmAYoweADubDhW6wYf9f/8syoyYBMdrqj/14P2
	 BWZlcUR9FSeQjiZWxvgj6RcePHMcEcTRvo+HUE6HzfUmaCO5Q35SXyQvuX/DcZfztg
	 KnCei2lK4zXGIpptU0C1OYkZuFRq90p5L+uUoGx5IDZ6c4/+537p9/UPpmJdqDiZUi
	 V0wWjhmxhl888BJxeFUPBHKnOGEWRaZul3jFuE7XLDG8sAWGTVKoeFZ4e4PWU8ynNj
	 +i84o351vnt2qyC5JwiXCj8no6q2yGYv5+6TTySXMwHttjn+80Hn96VNzud9ksGhQ0
	 tWZPEv/1I+Y7A==
Date: Mon, 28 Apr 2025 22:34:36 +0100
From: "Alan J. Wylie" <alan@wylie.me.uk>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Holger =?UTF-8?B?SG9mZnN0w6R0dGU=?= <holger@applied-asynchrony.com>,
 Jamal Hadi Salim <jhs@mojatatu.com>, regressions@lists.linux.dev, Jiri
 Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Octavian Purdila <tavip@google.com>, Toke
 =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>,
 stable@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [REGRESSION] 6.14.3 panic - kernel NULL pointer dereference in
 htb_dequeue
Message-ID: <20250428223436.48529979@frodo.int.wylie.me.uk>
In-Reply-To: <aA/s3GBuDc5t1nY5@pop-os.localdomain>
References: <4e2a6522-d455-f0ce-c77d-b430c3047d7c@applied-asynchrony.com>
	<aAf/K7F9TmCJIT+N@pop-os.localdomain>
	<20250422214716.5e181523@frodo.int.wylie.me.uk>
	<aAgO59L0ccXl6kUs@pop-os.localdomain>
	<20250423105131.7ab46a47@frodo.int.wylie.me.uk>
	<aAlAakEUu4XSEdXF@pop-os.localdomain>
	<20250424135331.02511131@frodo.int.wylie.me.uk>
	<aA6BcLENWhE4pQCa@pop-os.localdomain>
	<20250427204254.6ae5cd4a@frodo.int.wylie.me.uk>
	<20250427213548.73efc7b9@frodo.int.wylie.me.uk>
	<aA/s3GBuDc5t1nY5@pop-os.localdomain>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
X-Clacks-Overhead: GNU Terry Pratchett
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Apr 2025 14:02:20 -0700
Cong Wang <xiyou.wangcong@gmail.com> wrote:

> I doubt it is related to iptables. I will try some TCP traffic on my
> side later, but I suspect this is related to the type of packets.
> 
> Meanwhile, since I still can't reproduce it here, do you mind applying
> both of my patches on top of -net and test again?
> 
> For your convenience, below is the combined patch of the previous two
> patches, which can be applied on -net.
> 
> Thanks!
> 
> ----->
> 
> diff --git a/net/sched/sch_htb.c b/net/sched/sch_htb.c
> index 4b9a639b642e..9d88fff120bc 100644
> --- a/net/sched/sch_htb.c
> +++ b/net/sched/sch_htb.c
> @@ -348,7 +348,8 @@ static void htb_add_to_wait_tree(struct htb_sched *q,
>   */
>  static inline void htb_next_rb_node(struct rb_node **n)
>  {
> -	*n = rb_next(*n);
> +	if (*n)
> +		*n = rb_next(*n);
>  }
>  
>  /**
> @@ -1487,7 +1488,8 @@ static void htb_qlen_notify(struct Qdisc *sch, unsigned long arg)
>  
>  	if (!cl->prio_activity)
>  		return;
> -	htb_deactivate(qdisc_priv(sch), cl);
> +	if (!cl->leaf.q->q.qlen)
> +		htb_deactivate(qdisc_priv(sch), cl);
>  }
>  
>  static inline int htb_parent_last_child(struct htb_class *cl)


With those patches applied, I've run 5 or 6 SpeedTests, no panics.

There's several WARNINGS in the log, though, about one per run.

I'm away from the keyboard tomorrow morning.

Hoping this has helped
Alan

$ ./scripts/decode_stacktrace.sh < bar vmlinux
Apr 28 22:22:20 bilbo kernel: ------------[ cut here ]------------
Apr 28 22:22:20 bilbo kernel: WARNING: CPU: 1 PID: 0 at htb_deactivate (net/sched/sch_htb.c:613 (discriminator 1)) sch_htb 
Apr 28 22:22:20 bilbo kernel: Modules linked in: sch_htb cls_u32 sch_ingress sch_cake ifb act_mirred xt_hl xt_nat ts_bm xt_string xt_TARPIT(O) xt_CT xt_tcpudp xt_helper nf_nat_ftp nf_conntrack_f>
Apr 28 22:22:20 bilbo kernel:  fb_io_fops snd_pcm cfbcopyarea crypto_simd i2c_algo_bit cdc_acm cryptd snd_timer fb at24 e1000 snd k10temp regmap_i2c font acpi_cpufreq soundcore fam15h_power liba>
Apr 28 22:22:20 bilbo kernel: CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Tainted: G           O        6.15.0-rc3-00109-gf73f05c6f711-dirty #2 PREEMPT(lazy)
Apr 28 22:22:20 bilbo kernel: Tainted: [O]=OOT_MODULE
Apr 28 22:22:20 bilbo kernel: Hardware name: Gigabyte Technology Co., Ltd. To be filled by O.E.M./970A-DS3P, BIOS FD 02/26/2016
Apr 28 22:22:20 bilbo kernel: RIP: 0010:htb_deactivate (net/sched/sch_htb.c:613 (discriminator 1)) sch_htb 
Apr 28 22:22:20 bilbo kernel: Code: d4 45 21 a4 87 08 01 00 00 48 83 c4 18 5b 5d 41 5c 41 5d 41 5e 41 5f e9 81 8c ae e0 90 53 83 be a8 01 00 00 00 48 89 f3 75 02 <0f> 0b 48 89 de e8 29 fe ff ff >
All code
========
   0:	d4                   	(bad)
   1:	45 21 a4 87 08 01 00 	and    %r12d,0x108(%r15,%rax,4)
   8:	00 
   9:	48 83 c4 18          	add    $0x18,%rsp
   d:	5b                   	pop    %rbx
   e:	5d                   	pop    %rbp
   f:	41 5c                	pop    %r12
  11:	41 5d                	pop    %r13
  13:	41 5e                	pop    %r14
  15:	41 5f                	pop    %r15
  17:	e9 81 8c ae e0       	jmp    0xffffffffe0ae8c9d
  1c:	90                   	nop
  1d:	53                   	push   %rbx
  1e:	83 be a8 01 00 00 00 	cmpl   $0x0,0x1a8(%rsi)
  25:	48 89 f3             	mov    %rsi,%rbx
  28:	75 02                	jne    0x2c
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	48 89 de             	mov    %rbx,%rsi
  2f:	e8 29 fe ff ff       	call   0xfffffffffffffe5d
	...

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	48 89 de             	mov    %rbx,%rsi
   5:	e8 29 fe ff ff       	call   0xfffffffffffffe33
	...
Apr 28 22:22:20 bilbo kernel: RSP: 0018:ffffc900000f4e50 EFLAGS: 00010246
Apr 28 22:22:20 bilbo kernel: RAX: ffff888148f88000 RBX: ffff888148f89000 RCX: ffff888148f891c8
Apr 28 22:22:20 bilbo kernel: RDX: ffff888148f89000 RSI: ffff888148f89000 RDI: ffff88811ce07180
Apr 28 22:22:20 bilbo kernel: RBP: 0000000000000000 R08: ffff88811ce072b0 R09: 000000000d22f2d3
Apr 28 22:22:20 bilbo kernel: R10: 0000000000001dad R11: ffffc900000f4ff8 R12: 0000000000000000
Apr 28 22:22:20 bilbo kernel: R13: ffff888148f89000 R14: 00000034c76615a5 R15: 0000000000000000
Apr 28 22:22:20 bilbo kernel: FS:  0000000000000000(0000) GS:ffff8884ac7df000(0000) knlGS:0000000000000000
Apr 28 22:22:20 bilbo kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Apr 28 22:22:20 bilbo kernel: CR2: 00007fb66c09f000 CR3: 0000000138968000 CR4: 00000000000406f0
Apr 28 22:22:20 bilbo kernel: Call Trace:
Apr 28 22:22:20 bilbo kernel:  <IRQ>
Apr 28 22:22:20 bilbo kernel: htb_dequeue (./include/net/sch_generic.h:821 (discriminator 1) net/sched/sch_htb.c:702 (discriminator 1) net/sched/sch_htb.c:933 (discriminator 1) net/sched/sch_htb.c:983 (discriminator 1)) sch_htb 
Apr 28 22:22:20 bilbo kernel: __qdisc_run (net/sched/sch_generic.c:293 net/sched/sch_generic.c:398 net/sched/sch_generic.c:416) 
Apr 28 22:22:20 bilbo kernel: ? timerqueue_del (lib/timerqueue.c:58) 
Apr 28 22:22:20 bilbo kernel: qdisc_run (./include/net/pkt_sched.h:128 ./include/net/pkt_sched.h:124) 
Apr 28 22:22:20 bilbo kernel: net_tx_action (net/core/dev.c:5535) 
Apr 28 22:22:20 bilbo kernel: handle_softirqs (./arch/x86/include/asm/atomic.h:23 ./include/linux/atomic/atomic-arch-fallback.h:457 ./include/linux/jump_label.h:262 ./include/trace/events/irq.h:142 kernel/softirq.c:580) 
Apr 28 22:22:20 bilbo kernel: __irq_exit_rcu (kernel/softirq.c:453 kernel/softirq.c:680) 
Apr 28 22:22:20 bilbo kernel: sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1049 (discriminator 35) arch/x86/kernel/apic/apic.c:1049 (discriminator 35)) 
Apr 28 22:22:20 bilbo kernel:  </IRQ>
Apr 28 22:22:20 bilbo kernel:  <TASK>
Apr 28 22:22:20 bilbo kernel: asm_sysvec_apic_timer_interrupt (./arch/x86/include/asm/idtentry.h:574) 
Apr 28 22:22:20 bilbo kernel: RIP: 0010:cpuidle_enter_state (drivers/cpuidle/cpuidle.c:292) 
Apr 28 22:22:20 bilbo kernel: Code: 08 58 6e 00 85 c0 7e 0b 8b 73 04 83 cf ff e8 b1 fd e4 ff 31 ff e8 9a 1a 97 ff 45 84 ff 74 07 31 ff e8 7e 3f 9c ff fb 45 85 ed <0f> 88 cc 00 00 00 49 63 c5 48 >
All code
========
   0:	08 58 6e             	or     %bl,0x6e(%rax)
   3:	00 85 c0 7e 0b 8b    	add    %al,-0x74f48140(%rbp)
   9:	73 04                	jae    0xf
   b:	83 cf ff             	or     $0xffffffff,%edi
   e:	e8 b1 fd e4 ff       	call   0xffffffffffe4fdc4
  13:	31 ff                	xor    %edi,%edi
  15:	e8 9a 1a 97 ff       	call   0xffffffffff971ab4
  1a:	45 84 ff             	test   %r15b,%r15b
  1d:	74 07                	je     0x26
  1f:	31 ff                	xor    %edi,%edi
  21:	e8 7e 3f 9c ff       	call   0xffffffffff9c3fa4
  26:	fb                   	sti
  27:	45 85 ed             	test   %r13d,%r13d
  2a:*	0f 88 cc 00 00 00    	js     0xfc		<-- trapping instruction
  30:	49 63 c5             	movslq %r13d,%rax
  33:	48                   	rex.W
	...

Code starting with the faulting instruction
===========================================
   0:	0f 88 cc 00 00 00    	js     0xd2
   6:	49 63 c5             	movslq %r13d,%rax
   9:	48                   	rex.W
	...
Apr 28 22:22:20 bilbo kernel: RSP: 0018:ffffc900000afe98 EFLAGS: 00000202
Apr 28 22:22:20 bilbo kernel: RAX: ffff8884ac7df000 RBX: ffff888101f0c000 RCX: 0000000000000000
Apr 28 22:22:20 bilbo kernel: RDX: 000000348d3ee395 RSI: fffffff068159bd4 RDI: 0000000000000000
Apr 28 22:22:20 bilbo kernel: RBP: 0000000000000002 R08: 0000000000000002 R09: 0000000000000013
Apr 28 22:22:20 bilbo kernel: R10: 0000000000000006 R11: 0000000000000671 R12: ffffffff81f9b660
Apr 28 22:22:20 bilbo kernel: R13: 0000000000000002 R14: 000000348d3ee395 R15: 0000000000000000
Apr 28 22:22:20 bilbo kernel: ? cpuidle_enter_state (drivers/cpuidle/cpuidle.c:286) 
Apr 28 22:22:20 bilbo kernel: cpuidle_enter (drivers/cpuidle/cpuidle.c:391 (discriminator 2)) 
Apr 28 22:22:20 bilbo kernel: do_idle (kernel/sched/idle.c:234 kernel/sched/idle.c:325) 
Apr 28 22:22:20 bilbo kernel: cpu_startup_entry (kernel/sched/idle.c:422) 
Apr 28 22:22:20 bilbo kernel: start_secondary (arch/x86/kernel/smpboot.c:315) 
Apr 28 22:22:20 bilbo kernel: common_startup_64 (arch/x86/kernel/head_64.S:419) 
Apr 28 22:22:20 bilbo kernel:  </TASK>
Apr 28 22:22:20 bilbo kernel: ---[ end trace 0000000000000000 ]---



-- 
Alan J. Wylie     https://www.wylie.me.uk/     mailto:<alan@wylie.me.uk>

Dance like no-one's watching. / Encrypt like everyone is.
Security is inversely proportional to convenience

