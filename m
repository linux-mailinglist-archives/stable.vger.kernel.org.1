Return-Path: <stable+bounces-244574-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iL0YGmue/Gn3RwAAu9opvQ
	(envelope-from <stable+bounces-244574-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 16:15:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C46C04E9EE6
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 16:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DD9323022568
	for <lists+stable@lfdr.de>; Thu,  7 May 2026 14:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D634237BE60;
	Thu,  7 May 2026 14:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pciDZxNw"
X-Original-To: stable@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C301C3F9F41;
	Thu,  7 May 2026 14:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778163292; cv=none; b=aCPKS8iN00e6aO5sfXt827fchuFwhQPo07RvHh7ZJK14c3nHkzmwPIROU0t6wAJIFGCxVkCgkQ71WcAnEtbBvJkJxj42GEvQzfhzrcleNackOiqNr+lbgwUlaeqASpt/6IZDkYm7J9PWmC0p8aPBGU6Rb6BVOvaLdHxjQazFDww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778163292; c=relaxed/simple;
	bh=d0wCw1VrxUtXRcCk4E3PnmCvbq6aFgQfYidgwCoyE/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kTtPYKZuUcs2OnnBA0ACN3LYvLfK9IuUFRkLtuw5O/rjCrqgJQhs/9QJubfrlnDunY442IZP8kYmZPyjHlS6LCW/25h1YODQadZSbJGZ/gKfrZu4/j99i0GdRiA2zthp6D27/jQZooWjV0KIyjutDLQZxhIV8sQ+e1ZnvFdq/qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pciDZxNw; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=tJlUIOe0/241qA24knswlPqJNMDU3HVIERWmx8tHuHs=; b=pciDZxNwKYhEH2yjt4q85BW2Ot
	JW0KHfN486pmE7VGRUkz87jt2d5+xjMUITZ1Rc5/LT8+JL4AHSRttkvCoqLoGaG2zwSmyhDTQ8WnG
	GIwy21RDdYNbxEGaR5PT/RxRrJzTNvRUDMPLyKbkjl1Pg449E3JJWja7IqxjO+wcIxBweNOwJR1W4
	BGs/TtL+6tXXuUDlPZ2KK/CW+TaDTs+UwwTLxIsl9+2sWiKyjIw5rzbNJDdAK1Jc3iCypw+l7PVeu
	SPK5ymH1x2VM6wBl0M3b/RYRlwiu3iLUZMtfJyjjARvPaGZS1CPTAn6Ll4SZ3u8ToN/OOK8tlVCxv
	hEBXjfKQ==;
Received: from 2001-1c00-8d85-4b00-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:4b00:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKzUs-00000003jZd-1Ut5;
	Thu, 07 May 2026 14:14:39 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1BC4F300882; Thu, 07 May 2026 16:14:37 +0200 (CEST)
Date: Thu, 7 May 2026 16:14:37 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Tejun Heo <tj@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Kyle McMartin <jkkm@meta.com>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH sched/core] sched/rt: Fix RT_PUSH_IPI soft lockup loop
Message-ID: <20260507141437.GJ3102624@noisy.programming.kicks-ass.net>
References: <20260506235716.2530720-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506235716.2530720-1-tj@kernel.org>
X-Rspamd-Queue-Id: C46C04E9EE6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=desiato.20200630];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244574-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peterz@infradead.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,noisy.programming.kicks-ass.net:mid]
X-Rspamd-Action: no action

On Wed, May 06, 2026 at 01:57:16PM -1000, Tejun Heo wrote:
> push_rt_task() picks the highest pushable RT task next_task. If it
> outranks rq->donor, the existing path calls resched_curr() and
> returns 0, trusting local schedule() to pick next_task soon.
> 
> The RT_PUSH_IPI relay caller (rto_push_irq_work_func()) cannot rely
> on that. When this CPU has a steady supply of softirq work (e.g.,
> incoming packets), the next push IPI arrives before schedule() can
> run. Other CPUs keep seeing this CPU as overloaded and keep sending
> IPIs, this CPU keeps taking the same bail, and the loop repeats
> until soft lockup.
> 
> Seen in production on hosts with sustained NET_RX softirq load:
> the loop ran millions of iterations before tripping the soft-lockup
> watchdog.
> 
> Skip the prio bail when called via the IPI relay (pull=true) so
> push_rt_task() migrates next_task to another CPU. Verified with a
> synthetic reproducer.
> 
> Fixes: b6366f048e0c ("sched/rt: Use IPI to trigger RT task push migration instead of pulling")
> Cc: Kyle McMartin <jkkm@meta.com>
> Cc: stable@vger.kernel.org # v5.10+
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
> This looks minimal to me, but happy for suggestions. Thanks.
> 
>  kernel/sched/rt.c |    8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -1968,8 +1968,14 @@ retry:
>  	 * It's possible that the next_task slipped in of
>  	 * higher priority than current. If that's the case
>  	 * just reschedule current.
> +	 *
> +	 * This doesn't work for the IPI relay caller (pull). When this CPU
> +	 * has a steady supply of softirq work (e.g., incoming packets), the
> +	 * next push IPI arrives before schedule() can run. Other CPUs keep
> +	 * seeing it as overloaded and keep sending IPIs, this CPU keeps
> +	 * taking the same bail, and the loop repeats until soft lockup.
>  	 */
> -	if (unlikely(next_task->prio < rq->donor->prio)) {
> +	if (unlikely(next_task->prio < rq->donor->prio) && !pull) {
>  		resched_curr(rq);
>  		return 0;
>  	}

IIRC Steve has a test for this stuff. If this breaks things, an
alternative is keeping a counter/limit on attempts or something.


--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1339,6 +1339,8 @@ struct rq {
 	unsigned int		nr_pinned;
 	unsigned int		push_busy;
 	struct cpu_stop_work	push_work;
+	unsigned int		rt_switches;
+	unsigned int		rt_push_resched;
 
 #ifdef CONFIG_SCHED_CORE
 	/* per rq */
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2941,6 +2941,13 @@ static int push_dl_task(struct rq *rq)
 	if (dl_task(rq->donor) &&
 	    dl_time_before(next_task->dl.deadline, rq->donor->dl.deadline) &&
 	    rq->curr->nr_cpus_allowed > 1) {
+		if (rq->rt_switches != rq->nr_switches) {
+			rq->rt_switches = rq->nr_switches;
+			rq->rt_push_resched = 0;
+		}
+		if (test_tsk_need_resched(rq->curr) && ++rq->rt_push_resched > 16)
+			return 1;
+
 		resched_curr(rq);
 		return 0;
 	}

