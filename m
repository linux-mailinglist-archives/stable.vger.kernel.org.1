Return-Path: <stable+bounces-247060-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mKQ5OWYWBWoUSQIAu9opvQ
	(envelope-from <stable+bounces-247060-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 02:25:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47CC153C542
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 02:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 98BA2304C06D
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 00:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90DF32765D4;
	Thu, 14 May 2026 00:24:37 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54DD274B58;
	Thu, 14 May 2026 00:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778718277; cv=none; b=rVE7giX4Ll0dfABuNbxCmf5ivxW647NSysRh7gnqJZD4j1+m29mBR6dAbetSBb5L59k3Typi054n0SboT8NbN37el5SuFW/Hl280zWVsVSLskI1WeXEwnwG7jchQGQjw0gTYaRdhK6i9gbiOBIRlRtb32iTmefJ89MFSSBSL78E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778718277; c=relaxed/simple;
	bh=cgbIM61BgxUEBei4guvyoixjyeeEQyOBVFPm2EctGi4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F1E3mHIXiDx0jErRV3BkMEUVB/Jstp8UE2T/Bj88d3ig8/ga5LJb2ABjeRnEgRf7tLyoAdCEsbbZzy6dGpIQEPd8xaMZWbX87iNdTXIdXbkcvZcee1fg4QZW9tOeXY3kUVJWvD1BkV6LMVEhDJOrjjpLU3MFzTz6quoFG0Ody/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf05.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 43B0F404E1;
	Thu, 14 May 2026 00:24:33 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf05.hostedemail.com (Postfix) with ESMTPA id 6248C20010;
	Thu, 14 May 2026 00:24:29 +0000 (UTC)
Date: Wed, 13 May 2026 20:24:32 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Tejun Heo <tj@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin
 Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>,
 Kyle McMartin <jkkm@meta.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Linux RT Development
 <linux-rt-devel@lists.linux.dev>, Clark Williams <williams@redhat.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, John Kacur
 <jkacur@redhat.com>
Subject: Re: [PATCH sched/core] sched/rt: Fix RT_PUSH_IPI soft lockup loop
Message-ID: <20260513202432.18dd7b9f@gandalf.local.home>
In-Reply-To: <20260513193914.1593369-1-tj@kernel.org>
References: <20260506235716.2530720-1-tj@kernel.org>
	<20260507141437.GJ3102624@noisy.programming.kicks-ass.net>
	<20260512113754.448c1f5b@gandalf.local.home>
	<056f95bc5805f7e161458984fff4b3cb@kernel.org>
	<20260512172847.5024e5e8@gandalf.local.home>
	<20260513193914.1593369-1-tj@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 98t38y7a374y8nf9qrijjju5yfc166gs
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/wd/7dUAYRIsETihoD5y9kDo7zpJbmqQs=
X-HE-Tag: 1778718269-115700
X-HE-Meta: U2FsdGVkX1+eaD+TvWZ5qpm5/YpoWNqmfJnUVIfCm49h3cFxWzM7m+XVgyoTOse0zeZ464L1dWkYZ1TIKVx1ghYZJxw9S/K3J0PvRU6ZbFnIoQc0nLBVXrmHsjItl/xHXAxKaiyj1gX34L+acKbCSOXXuuYl3Xf8Rz/4P+a5lEwYDUzsuFuerE2XIw0V8ikw6aoQcN1DYYxVUtGjfTax7H2WC51bDXilJbL9t3BPurcW/oivzMhbQlaryJN9hnhqwBZckRoJ66sOQqw6dLkyLtQnakqEEDu6hdjCo/gJJ/Dk6rnzloDqEzGuMjG6ifQFijUlGoYUO+S2/r3vUK2XjOOoFthgAuxFliXDP7ck16ijjheHd3gbag==
X-Rspamd-Queue-Id: 47CC153C542
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[goodmis.org : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rostedt@goodmis.org,stable@vger.kernel.org];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247060-lists,stable=lfdr.de];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Wed, 13 May 2026 09:39:14 -1000
Tejun Heo <tj@kernel.org> wrote:

> So, here's a capture from a synthetic reproducer that I think
> models the dynamic and reaches the same end state.

Synthetic capture is fine.

> 
> Test box, 192 CPUs, kernel without the fix:
> 
> - Per-target hrtimer (HRTIMER_MODE_REL_PINNED_HARD) fires every
>   750us. Each fire schedules one tasklet round-robin from a pool
>   of 20k distinct tasklets. Each tasklet body is a 500us cpu_relax
>   loop, standing in for "process one item of softirq work".

So you are running a softirq for 500us every 750us?

This basically prevents any task from running on these CPUs while the
softirq is executing.

> 
> - Storm driver: 190 SCHED_FIFO-50 nanosleep loops on non-target
>   CPUs drive tell_cpu_to_push from balance_rt. Two synthetic
>   psimon-shaped kthreads (FIFO 1) bound to the targets to pin
>   them into rto_mask.

What exactly are these synthetic kthreads doing. Have code to share?

> 
> Baseline (no storm helpers): ~85% softirq util, no lockup, runs
> indefinitely. The reproducer's baseline is higher than production -
> my guess is we need to scrape up against capacity to grow a backlog
> with the fixed-shape workload here, while production gets the same
> effect from bursty arrivals during brief slowdowns.
> 
> With the storm: walker IPI overhead stretches each tasklet body
> from 500us to ~1.1ms. Service rate drops below arrival, backlog
> grows ~430/s. After ~46s, one tasklet_action_common snapshot has
> ~20k tasklets which it processes serially in BH-disabled softirq
> context. That's ~22s uninterruptible, watchdog fires.

The IPI walker should only go to the CPUs with overloaded RT tasks. Are you
making all the CPUS have overloaded RT tasks?

> 
> Six soft-lockups in a 120s run:
> 
>   [61125.38] BUG: soft lockup - CPU#95 stuck for 22s! [kworker/95:0]
>   [61145.38] BUG: soft lockup - CPU#47 stuck for 45s! [migration/47]
>   [61173.38] BUG: soft lockup - CPU#47 stuck for 71s! [migration/47]
>   [61197.38] BUG: soft lockup - CPU#95 stuck for 22s! [migration/95]
>   [61209.38] BUG: soft lockup - CPU#47 stuck for 21s! [kworker/47:1]
>   [61225.38] BUG: soft lockup - CPU#95 stuck for 48s! [migration/95]
> 
> Stack at fire:
> 
>   rt_storm_wedge_fn+0x22/0xe0
>   tasklet_action_common+0x100/0x2b0
>   handle_softirqs+0xbe/0x280
>   __irq_exit_rcu+0x47/0x100
>   sysvec_apic_timer_interrupt+0x3a/0x80     <- watchdog hrtimer
>   asm_sysvec_apic_timer_interrupt+0x16/0x20
>   RIP: 0033:0x...     <- user task (rt_storm_hog)
> 
> Trace captured with your event list plus IPI:
> 
>   -e sched_switch -e sched_waking -e irq -e workqueue -e ipi
>   -e irq_vectors:call_function_single_entry/exit
>   -e irq_vectors:irq_work_entry/exit
>   -e irq_vectors:reschedule_entry/exit
>   -e irq_vectors:local_timer_entry/exit
> 
> Sliced to a 17s window around the first RCU stall + first
> soft-lockup, filtered to CPUs 47 and 95, gzipped text (~11MB):
> 
>   https://drive.google.com/file/d/11AN6dyvOWiZLVNEEuVtQieRyAxJYbCbt/view?usp=sharing
> 

So this is showing that the IPI logic is just extending the softirq work
load to something greater than the period of execution and causing a live
lock of softirqs.

This still doesn't explain to me why the current process is of a lower
priority than a waiting RT task.

I'm really starting to think you are fixing a symptom and not the cause.

-- Steve


