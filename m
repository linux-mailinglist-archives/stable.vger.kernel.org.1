Return-Path: <stable+bounces-247074-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ms5EFgkdBWrfSgIAu9opvQ
	(envelope-from <stable+bounces-247074-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 02:53:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7FB53C74E
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 02:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E36E303FDC1
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 00:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB532F3600;
	Thu, 14 May 2026 00:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S2rwyA8I"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D5E22A4EE;
	Thu, 14 May 2026 00:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778720003; cv=none; b=r6i5D9mUxEpyQx21CmkMgahquz7SSd7ALK0xe7ftLqRk7MyYc9IBZcT7Al/n7p1NgDtg9Esc/iqrQ/i0z1nvVCtNrxnHlI9G0AFzwX+cr+v5LczxTNZ/VVzg4St0fNBIWLIldRuv84qnVcBHtetEgbyH8LSglRAkq9pezS5LrJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778720003; c=relaxed/simple;
	bh=tIZqnUSBTfvu8MvGTUzCx4rW3xP45eov3BgjVPVinTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UprOXCddRcMybLgc2Y7hiUs46lSaEuhHsFg6mNI4fUJREOYdbgelMtnc6GGwqR4M9aK2wcY28hCiZ4ALK4R678jFNuyO7GsBGAQscwxqbb4go49Gmm1I5sAwKxNQMR1AutFL8Eks0Cb0hJ3Tx36v++iGvWt8Aoy8IfkmEVIC/tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S2rwyA8I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54EA8C19425;
	Thu, 14 May 2026 00:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778720002;
	bh=tIZqnUSBTfvu8MvGTUzCx4rW3xP45eov3BgjVPVinTA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S2rwyA8IbRA3O4IpvBHu1zfGKqXbXYJc/YlKOllKzF4ltDIlkWrF0b6KCWdNbF3+l
	 xo1bvJnsQ49FWixDMSvtFTHeLmWV4QOVcy28QKmxHF7rNzxHit9DG+dl1GHx9jaN40
	 ZyOx/mP6I1dJtnueYXe7LFitI0/rpojK4kefZYpkbjEwqNUtsYADcjoh+bpy4g0+xQ
	 uqZLrp1zbmDBtGw5dkt6E5pM4gzPaBTTRDvVDhKSctkIoMmGjZfhT6oTRXSMySAszX
	 vun4RCeRk5PPjztHszHibR9x+hwz30IpaTyqPAlWrHGrBsi+OTMKLJWWVlxAevpkXT
	 mwQ6b7Gicw7nw==
Date: Wed, 13 May 2026 14:53:21 -1000
From: Tejun Heo <tj@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Kyle McMartin <jkkm@meta.com>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Linux RT Development <linux-rt-devel@lists.linux.dev>,
	Clark Williams <williams@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH sched/core] sched/rt: Fix RT_PUSH_IPI soft lockup loop
Message-ID: <agUdAatmlqQc1NS_@slm.duckdns.org>
References: <20260506235716.2530720-1-tj@kernel.org>
 <20260507141437.GJ3102624@noisy.programming.kicks-ass.net>
 <20260512113754.448c1f5b@gandalf.local.home>
 <056f95bc5805f7e161458984fff4b3cb@kernel.org>
 <20260512172847.5024e5e8@gandalf.local.home>
 <20260513193914.1593369-1-tj@kernel.org>
 <20260513202432.18dd7b9f@gandalf.local.home>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260513202432.18dd7b9f@gandalf.local.home>
X-Rspamd-Queue-Id: AB7FB53C74E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247074-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hello,

On Wed, May 13, 2026 at 08:24:32PM -0400, Steven Rostedt wrote:
> > - Per-target hrtimer (HRTIMER_MODE_REL_PINNED_HARD) fires every
> >   750us. Each fire schedules one tasklet round-robin from a pool
> >   of 20k distinct tasklets. Each tasklet body is a 500us cpu_relax
> >   loop, standing in for "process one item of softirq work".
> 
> So you are running a softirq for 500us every 750us?
> 
> This basically prevents any task from running on these CPUs while the
> softirq is executing.

Hmmm? The utilization is high at around 70%. It can still run something and
wouldn't lock up. The prod repro case isn't this high. More like 30-40%.
It's just difficult to make syntheric repro reliable with that.

> > - Storm driver: 190 SCHED_FIFO-50 nanosleep loops on non-target
> >   CPUs drive tell_cpu_to_push from balance_rt. Two synthetic
> >   psimon-shaped kthreads (FIFO 1) bound to the targets to pin
> >   them into rto_mask.
> 
> What exactly are these synthetic kthreads doing. Have code to share?

It's just looping set number of times. Here's the slop:

 https://gist.github.com/htejun/ba43a0a7bc6f6503602ada850f45ce4d

> The IPI walker should only go to the CPUs with overloaded RT tasks. Are you
> making all the CPUS have overloaded RT tasks?

Only 2 cpus are overloaded. I don't know why it used FIFO threads on CPUs
that aren't overloaded. It's just using that to pulse CPUs to trigger
need_pull_rt_task().

> So this is showing that the IPI logic is just extending the softirq work
> load to something greater than the period of execution and causing a live
> lock of softirqs.
> 
> This still doesn't explain to me why the current process is of a lower
> priority than a waiting RT task.

1. The CPU was running a fair task.

2. IRQ triggers which creates softirq work.

3. Either IRQ, softirq or another CPU wakes up multiple RT tasks to the CPU.

4. The CPU enters softirq.

5. Other CPUs keep sending pull IPIs, slowing softirq processing.

6. Before softirq processing finishes, another IRQ happens which creates
   more softirq work. Go back to 4.

> I'm really starting to think you are fixing a symptom and not the cause.

It seems relatively straightforward to me. The CPU was relatively loaded
with irq/softirq. While in irq context, RT tasks wake up to it and then the
CPU gets hammered by pull IPIs to the point where it's constantly chasing
new softirq work and thus can't leave irq context in a reasonable amount of
time. What am I missing?

Thanks.

-- 
tejun

