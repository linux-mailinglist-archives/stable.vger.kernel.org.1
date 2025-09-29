Return-Path: <stable+bounces-181870-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D13BA8E72
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 12:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C08BB3A909C
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 10:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E342FBDE9;
	Mon, 29 Sep 2025 10:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QdIItpR2"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8098D2D0C9D;
	Mon, 29 Sep 2025 10:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759142332; cv=none; b=C6MRBY1Q2zazGr/iIacxXUDOK90As+rd/nvWmRmFINkKD6G361ZcmYEYEJwT9SrlH0HDaoIvpMIEuCGVhuT+xwE335sqUypVkpUmUOZLQ/CRbRai1gnYls2pflUk0LHiDCjkvZy2EfzcvH+ULvVHRbslcxQP/HzDUikgg34sY04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759142332; c=relaxed/simple;
	bh=F7mFL/7BU9UP42iZ2FjhNNv6f/04qDku/YL69qE13wQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X3F6AtOx8nDK22JhVy5SY48OjmHQvps2jZDYdbJtpyKsgF4PDenR1ACvSasW+tVoqv1VAWXOeoXQVe4drjzut21PY0w2vjxshW0GGeoTDenTN5v7eeRUPErRMgquDRUNEEU1EZmdt7Cw/XqupXUJwHSsduFDjl6S3pgQOdUm8qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QdIItpR2; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Ih1+qq84NJQre4oDkV6+4HpON+I+D7HQ3EUsS5HOjGU=; b=QdIItpR2KZW8mc8iCJ9cnlI7lQ
	3fTaz2pMpeHL4RJSbR4P1H9C+TG0CIWfjOiQfOlWouFppdAtTtFSr+ZsovBLh7hiPzG5Zeok+gvne
	LqBFPQviJ9PgvaYjv2bNSgd/KTGN+rW4zV2OVTerMiv5qHVi+SjYtOgIdtL1CTtC3CdHl4RhA7TiE
	JFr3IWqalGINS3nt57/Puq8Q3ovj4Wo3CdV+U30urgiEZ7fHNLvYHUMGYBEcEXaHO9nu/s0keRMZl
	4Xe0kDqTBFhxCwcAQgeW23lt9jNRqyCIW8BhkH346ArVmsbOEt1ic+/v95YaF9gIIyDAiC9hcDTEQ
	nKmbd0NQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3BHA-00000000Cw1-03ji;
	Mon, 29 Sep 2025 10:38:37 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 212FF300359; Mon, 29 Sep 2025 12:38:36 +0200 (CEST)
Date: Mon, 29 Sep 2025 12:38:36 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: John Stultz <jstultz@google.com>, Matt Fleming <matt@readmodwrite.com>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org, kernel-team@cloudflare.com,
	Matt Fleming <mfleming@cloudflare.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Chris Arges <carges@cloudflare.com>, stable@vger.kernel.org
Subject: Re: [PATCH] Revert "sched/core: Tweak wait_task_inactive() to force
 dequeue sched_delayed tasks"
Message-ID: <20250929103836.GK3419281@noisy.programming.kicks-ass.net>
References: <20250925133310.1843863-1-matt@readmodwrite.com>
 <CANDhNCr+Q=mitFLQ0Xr8ZkZrJPVtgtu8BFaUSAVTZcAFf+VgsA@mail.gmail.com>
 <105ae6f1-f629-4fe7-9644-4242c3bed035@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <105ae6f1-f629-4fe7-9644-4242c3bed035@amd.com>

On Fri, Sep 26, 2025 at 08:13:09AM +0530, K Prateek Nayak wrote:

> > Peter: Those cfs_rq_throttled() exits in dequeue_entities() seem a
> > little odd, as the desired dequeue didn't really complete, but
> > dequeue_task_fair() will still return true indicating success - not
> > that too many places are checking the dequeue_task return. Is that
> > right?

Bah, i'm forever confused on the throttle cases there :/

> I think for most part until now it was harmless as we couldn't pick on
> a throttled hierarchy and other calls to dequeue_task(DEQUEUE_DELAYED)
> would later do a:
> 
>     queued = task_on_rq_queued(p);
>     ...
>     if (queued)
>         enqueue_task(p)
> 
> which would either lead to spuriously running a blocked task and it
> would block back again, or a wakeup would properly wakeup the queued
> task via ttwu_runnable() but wait_task_inactive() is interesting as
> it expects the dequeue will result in a block which never happens with
> throttled hierarchies. I'm impressed double dequeue doesn't result in
> any major splats!
> 
> Matt, if possible can you try the patch attached below to check if the
> bailout for throttled hierarchy is indeed the root cause. Thanks in
> advance.
> 
> P.S. the per-task throttle in tip:sched/core would get rid of all this
> but it would be good to have a fix via tip:sched/urgent to get it
> backported to v6.12 LTS and the newer stable kernels.

Yes, good riddance to that code :-)

> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 8ce56a8d507f..f0a4d9d7424d 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6969,6 +6969,7 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
>  	int h_nr_runnable = 0;
>  	struct cfs_rq *cfs_rq;
>  	u64 slice = 0;
> +	int ret = 0; /* XXX: Do we care if ret is 0 vs 1 since we only check ret < 0? */

Right, we don't appear to really need that.

>  
>  	if (entity_is_task(se)) {
>  		p = task_of(se);
> @@ -6998,7 +6999,7 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
>  
>  		/* end evaluation on encountering a throttled cfs_rq */
>  		if (cfs_rq_throttled(cfs_rq))
> -			return 0;
> +			goto out;
>  
>  		/* Don't dequeue parent if it has other entities besides us */
>  		if (cfs_rq->load.weight) {
> @@ -7039,7 +7040,7 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
>  
>  		/* end evaluation on encountering a throttled cfs_rq */
>  		if (cfs_rq_throttled(cfs_rq))
> -			return 0;
> +			goto out;
>  	}
>  
>  	sub_nr_running(rq, h_nr_queued);
> @@ -7048,6 +7049,8 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
>  	if (unlikely(!was_sched_idle && sched_idle_rq(rq)))
>  		rq->next_balance = jiffies;
>  
> +	ret = 1;
> +out:
>  	if (p && task_delayed) {
>  		WARN_ON_ONCE(!task_sleep);
>  		WARN_ON_ONCE(p->on_rq != 1);
> @@ -7063,7 +7066,7 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
>  		__block_task(rq, p);
>  	}
>  
> -	return 1;
> +	return ret;
>  }

So the difference is that we also do __block_task() when we get
throttled somewhere in the hierarchy. IIRC when I was looking at this, I
thought it wouldn't matter since it won't get picked anyway, on account
of the cfs_rq being blocked/detached, so who cares.

But yeah, this makes sense.

Patch logistics are going to be a pain -- .17 is closed and merge window
is open, which means Linus will have per-task throttle and /urgent don't
work no more.

At this point best we can do is a patch to stable with a note that
upstream is no longer affected due to rework or something.

