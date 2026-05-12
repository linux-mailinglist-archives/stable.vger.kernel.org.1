Return-Path: <stable+bounces-245826-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eEyuCl1KA2pq3AEAu9opvQ
	(envelope-from <stable+bounces-245826-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 17:42:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6DC523E1C
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 17:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 712C03046EC6
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 15:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F1E3A4267;
	Tue, 12 May 2026 15:38:07 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EBF371068;
	Tue, 12 May 2026 15:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778600287; cv=none; b=PbhaDf0wv0Z+xrmfvYyxL6BMlhws8BCysePKIqylJiraSmk2LFgqOBCJK8XCU1qdN9zT7nNjno6bSiHyjHuAXgIx9btvW75fFmNAFAyoImHhkjTMvT15hsNEqySSZwGGPi62HjI7hj4xQBN8xONdnj9QpljcfwhpClgQdnq98VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778600287; c=relaxed/simple;
	bh=PEunEfBsFEd3BCqfKr0g9AtG5jN5mbPKWr8r6Zo34gM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UklSWqBxttl+Cy+xLz9x9zPUqRj0hbmEIJSlLSyaX3lt25pksVhrQyQNB2UzqL8H0GshjJOVhoC4USrt5kiLsRwZqDHerM3Zuw+9odRsVJvNxHdrWR4eXyR1q1MMFHC2VYItOMm27UE6kiCaPGeE/1L80OP14qoHARC/o1PpO94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf11.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 4C5228D5A9;
	Tue, 12 May 2026 15:38:02 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf11.hostedemail.com (Postfix) with ESMTPA id B8EBA20031;
	Tue, 12 May 2026 15:37:58 +0000 (UTC)
Date: Tue, 12 May 2026 11:37:54 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Tejun Heo <tj@kernel.org>, Ingo Molnar <mingo@redhat.com>, Juri Lelli
 <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall
 <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin Schneider
 <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, Kyle
 McMartin <jkkm@meta.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Linux RT Development
 <linux-rt-devel@lists.linux.dev>, Clark Williams <williams@redhat.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, John Kacur
 <jkacur@redhat.com>
Subject: Re: [PATCH sched/core] sched/rt: Fix RT_PUSH_IPI soft lockup loop
Message-ID: <20260512113754.448c1f5b@gandalf.local.home>
In-Reply-To: <20260507141437.GJ3102624@noisy.programming.kicks-ass.net>
References: <20260506235716.2530720-1-tj@kernel.org>
	<20260507141437.GJ3102624@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: ws3emhhjkuzmjgaei5qx1rk7n3p4m95y
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18EFwMW8A7e47eXGxsFyuycSny+GUknB/Y=
X-HE-Tag: 1778600278-40241
X-HE-Meta: U2FsdGVkX1+BtrksngkS2hZyMmbAs1ZwZg5hH9eYCwGA68RVDLr1qAnwLmzGkPv/t1p3eyObi+ryULiYmYZYr1GLDzmNOIsT+yqWafZSMS216tpWp4HylsG1yovlBsYSBmTSPsuNjUF4YPlDHlWQljpb6q9g/vhviHOCa3p/1hNRgGzZkePc0/XmFTJ2TORqxZ7nfpSkmo5mGGxTi/V0pSNpxnvOLDL/+fy4TTiFZDwKcmV8Qf/tHpn7LGStqBxas0owkvCIJLbgwNn9UJBz23qh8OvId644GkwIeVHjgXMaNHA1BWVeZ9phPs+vh5zLmfS6it9MGpaJCovUbi9zgmhYcm1twoV/JwA4wBerFJ69dPn4QEaEUc9CkMFEWuo6eLM3SDrLQh/ZaPCYtzJbKetYGrXDzPszj5WxPFCeXvVduylJwIphewmTJyHiJlwYffSyFJidwWvzulo77rI10toXlxyubbpBy/pCce2qFxOqN2wEyOkvWpsqfwPp8+hE/Vn6ayMKJ+Q=
X-Rspamd-Queue-Id: AC6DC523E1C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[goodmis.org : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	TAGGED_FROM(0.00)[bounces-245826-lists,stable=lfdr.de];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gandalf.local.home:mid]
X-Rspamd-Action: no action


[ Adding some RT folks ]

Also, Valentin, can you look at this, because I believe the issue was
introduced by your change (see below).

On Thu, 7 May 2026 16:14:37 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Wed, May 06, 2026 at 01:57:16PM -1000, Tejun Heo wrote:
> > push_rt_task() picks the highest pushable RT task next_task. If it
> > outranks rq->donor, the existing path calls resched_curr() and
> > returns 0, trusting local schedule() to pick next_task soon.
> > 
> > The RT_PUSH_IPI relay caller (rto_push_irq_work_func()) cannot rely
> > on that. When this CPU has a steady supply of softirq work (e.g.,
> > incoming packets), the next push IPI arrives before schedule() can
> > run. Other CPUs keep seeing this CPU as overloaded and keep sending
> > IPIs, this CPU keeps taking the same bail, and the loop repeats
> > until soft lockup.
> > 
> > Seen in production on hosts with sustained NET_RX softirq load:
> > the loop ran millions of iterations before tripping the soft-lockup
> > watchdog.
> > 
> > Skip the prio bail when called via the IPI relay (pull=true) so
> > push_rt_task() migrates next_task to another CPU. Verified with a
> > synthetic reproducer.
> > 
> > Fixes: b6366f048e0c ("sched/rt: Use IPI to trigger RT task push migration instead of pulling")

Wrong Fixes tag. That commit doesn't even have the code that you are
changing. I think the correct commit is:

 Fixes: 49bef33e4b87b ("sched/rt: Plug rt_mutex_setprio() vs push_rt_task() race")

Which adds that if statement that exits out of the code early.

> > Cc: Kyle McMartin <jkkm@meta.com>
> > Cc: stable@vger.kernel.org # v5.10+
> > Signed-off-by: Tejun Heo <tj@kernel.org>
> > ---
> > This looks minimal to me, but happy for suggestions. Thanks.
> > 
> >  kernel/sched/rt.c |    8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> > 
> > --- a/kernel/sched/rt.c
> > +++ b/kernel/sched/rt.c
> > @@ -1968,8 +1968,14 @@ retry:
> >  	 * It's possible that the next_task slipped in of
> >  	 * higher priority than current. If that's the case
> >  	 * just reschedule current.
> > +	 *
> > +	 * This doesn't work for the IPI relay caller (pull). When this CPU
> > +	 * has a steady supply of softirq work (e.g., incoming packets), the
> > +	 * next push IPI arrives before schedule() can run. Other CPUs keep
> > +	 * seeing it as overloaded and keep sending IPIs, this CPU keeps
> > +	 * taking the same bail, and the loop repeats until soft lockup.
> >  	 */
> > -	if (unlikely(next_task->prio < rq->donor->prio)) {
> > +	if (unlikely(next_task->prio < rq->donor->prio) && !pull) {
> >  		resched_curr(rq);
> >  		return 0;
> >  	}  
> 
> IIRC Steve has a test for this stuff. If this breaks things, an
> alternative is keeping a counter/limit on attempts or something.

IIRC, the test we had was simply cyclictest that we ran with the following
parameters. From commit b6366f048e0ca ("sched/rt: Use IPI to trigger RT
task push migration instead of pulling"), it states it runs:

   cyclictest --numa -p95 -m -d0 -i100

The above runs a thread on each CPU at priority 95 and will sleep for
100us. Each thread should wake up at the same time. You can read the commit
message for more details but the tl;dr; is that without the IPI push
request, if one of the CPUs ran another RT task besides cyclictest, then
all the others would then ask to pull from it when the other CPUs
cyclictest would sleep. Having over 100 CPUs send an IPI to pull a task
when only the first one would get it, caused a large latency. Especially
since it took the rq lock over and over again.

But, the code being fixed wasn't due to that commit, but due to the commit
that added the short cut of the logic. That commit fixes a race with the
normal call to push_rt_task() and I think the pull logic issue was a side
effect.

I agree with Tejun's change, it actually puts the logic for the IPI pull
back to what it was before commit 49bef33e4b87b. The bug was added by the
shortcut case to push_rt_task() that was only meant for the !pull scenario.
Adding !pull to the if conditional seems like the correct change.

Valentin, can you confirm please.

Please update the Fixes tag to point to the appropriate commit as well as
update the change log. With that:

Reviewed-by: Steven Rostedt <rostedt@goodmis.org>

-- Steve

