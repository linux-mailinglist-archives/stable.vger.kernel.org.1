Return-Path: <stable+bounces-137115-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 93856AA10E9
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 17:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEBB47A238D
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 15:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C9D23E35E;
	Tue, 29 Apr 2025 15:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Voz75BMs"
X-Original-To: stable@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D6B21771B;
	Tue, 29 Apr 2025 15:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745941800; cv=none; b=Hkvctj+KvOB9zKaxnjv7Ewl1lfztvePACCU1SGdjR2vUtREteDXfNDi7Z0jw6QotL7VMxy+RNNCBM03N+Gaz4i4vYifVIh1EY6OVyK3fgvVAnXpeUX/BO2LEwDJK6C2+4XJtPmEuNWHhAEh5symDRTnuMjDAzI3FJs0Ftkq9E/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745941800; c=relaxed/simple;
	bh=SWA30VtLEsbKUxXYuBVojhQkeXIFkAjMhnPUSK81HNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ThKqCPI6M5WQXUBMupaFZ36Eqs9audP549NWWTyN2OSxrVTCQPoclFvamaaWtXFHgRA+0IV/NO6lSy1SMG/i1A2n5q6DDHyWAscMLVSROa70FSiQS2jgsdQwbsDpxMweiF977kJidAEcLOaXqVnuEDn/q/sbbkme5Cb12qRhz7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Voz75BMs; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HzDcT6NzZ8VkLqeQVpl0smJGiuB7wxJtJRI/zTXIq3o=; b=Voz75BMsteZL0PPUQ+gTkryk1w
	BTron6lHlau6SX4sgZF045B6msd1Entzv7YViyHTQi6mIWw+zC8g+xCk2qofpU5AHKKZ84egJ8PCf
	yjRsR088SEdlP3X/a6G7CsLmv1ZSbDA2j64AAqTpcIAl6c85+T5cksz/NNQY1EdXTUi7eW4SqMSnS
	tgr03i5IRKr5JGpPNVVOXm1PcN1BtHeDqKDZ+nXbv/U5VoK/JEgzfLZrqGu8cOIjU9RLfJiHCniid
	JcyOmD53lTuzS8RZNDQrwbP4anvInd14bqybm4Ac7I0OZ4QzwaUM3bsoUAcJu+lhAVvUh1iiQgp9P
	y0fgdVdg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u9nDP-0000000DSQz-2ynT;
	Tue, 29 Apr 2025 15:49:47 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 26DD730057C; Tue, 29 Apr 2025 17:49:47 +0200 (CEST)
Date: Tue, 29 Apr 2025 17:49:46 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Jianzhou Zhao <luckd0g@163.com>
Cc: stable@vger.kernel.org, alexander.shishkin@linux.intel.com,
	mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	mark.rutland@arm.com, jolsa@kernel.org, irogers@google.com,
	adrian.hunter@intel.com, kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: possible deadlock in perf_ctx_lock  in  linux6.12.25(longterm
 maintenance)
Message-ID: <20250429154946.GA4439@noisy.programming.kicks-ass.net>
References: <77c2ee24.b63e.19681e979ea.Coremail.luckd0g@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77c2ee24.b63e.19681e979ea.Coremail.luckd0g@163.com>

On Tue, Apr 29, 2025 at 10:18:04PM +0800, Jianzhou Zhao wrote:
> Hello, I found a potential bug titled "   possible deadlock in perf_ctx_lock " with modified syzkaller in the Linux6.12.25(longterm maintenance, last updated on April 25, 2025)

Nah, you hit a WARN and then printk being lousy made it explode worse.

> WARNING: CPU: 0 PID: 15835 at kernel/trace/trace_event_perf.c:375 perf_trace_add+0x2da/0x390 kernel/trace/trace_event_perf.c:375
> Modules linked in:
> CPU: 0 UID: 0 PID: 15835 Comm: syz.9.499 Not tainted 6.12.25 #3
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> RIP: 0010:perf_trace_add+0x2da/0x390 kernel/trace/trace_event_perf.c:375
> Code: fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 75 64 48 89 ab f8 01 00 00 48 89 df e8 b1 ab 26 00 e9 f3 fd ff ff e8 37 87 f6 ff 90 <0f> 0b 90 41 bc ea ff ff ff e9 77 ff ff ff e8 23 c5 56 00 e9 8a fd
> RSP: 0018:ffffc9000713f7f0 EFLAGS: 00010006
> RAX: 0000000040000002 RBX: ffff88802a069880 RCX: ffffffff8195a68e
> RDX: ffff888045ec2500 RSI: ffffffff8195a839 RDI: ffffffff8deabf48
> RBP: 0000000000000000 R08: 0000000000000001 R09: fffff52000e27eef
> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> R13: ffffffff8deabee0 R14: ffff88802a069928 R15: ffff888051237200
> FS:  00007fe4fec1c640(0000) GS:ffff88802b800000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f50219e7bac CR3: 00000000743bc000 CR4: 0000000000752ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> PKRU: 80000000
> Call Trace:
>  <TASK>
>  event_sched_in+0x434/0xac0 kernel/events/core.c:2629
>  group_sched_in kernel/events/core.c:2662 [inline]
>  merge_sched_in+0x895/0x1570 kernel/events/core.c:3940
>  visit_groups_merge.constprop.0.isra.0+0x6d2/0x1250 kernel/events/core.c:3885
>  pmu_groups_sched_in kernel/events/core.c:3967 [inline]
>  __pmu_ctx_sched_in kernel/events/core.c:3979 [inline]
>  ctx_sched_in+0x5c1/0xa30 kernel/events/core.c:4030
>  perf_event_sched_in+0x5d/0x90 kernel/events/core.c:2760
>  perf_event_context_sched_in kernel/events/core.c:4077 [inline]
>  __perf_event_task_sched_in+0x33a/0x6f0 kernel/events/core.c:4106
>  perf_event_task_sched_in include/linux/perf_event.h:1524 [inline]
>  finish_task_switch.isra.0+0x5f9/0xcb0 kernel/sched/core.c:5201
>  context_switch kernel/sched/core.c:5335 [inline]
>  __schedule+0x1156/0x5b20 kernel/sched/core.c:6710
>  preempt_schedule_irq+0x51/0x90 kernel/sched/core.c:7032
>  irqentry_exit+0x36/0x90 kernel/entry/common.c:354
>  asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702

Not quite sure which of the WARNs that is, as I don't keep the stable
trees around and .12 is quite old by now.

Anyway, if you can reproduce I'll take a look.

