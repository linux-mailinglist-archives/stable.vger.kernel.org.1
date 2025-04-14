Return-Path: <stable+bounces-132416-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6418BA87B84
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 11:08:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F773188DDC6
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 09:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1F225DCE3;
	Mon, 14 Apr 2025 09:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rOtHTB/a"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B8325A622;
	Mon, 14 Apr 2025 09:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744621723; cv=none; b=PkvP23TUHIYbjR6A28OJw+kWDGOdKDhEL8FehVs65R+g0gx9/vbCHd3bZ10XmBrkHym+XfIEEAm/lW7cSZZ2tE+Y/r4Smv4FbK/1OICUVOJ/T4+m6mSvG1MWcx5Nlofi//BbCuzdQazfy+wwb6UNKNvfkmyscdNaVvqqTPnYTY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744621723; c=relaxed/simple;
	bh=In9erdKEjFVkINEXwuH2VAurvdHZpC/9zxHLi/Zd7ow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZNKdBBc4dl98zfLreewrhLcdYPQ/ubP4NRibjO1ibSRySvvX3eywqKYwOIkB1tqH3FkyI5UJYmUmFgk1r/sE6JXUyNCmd37qfkrXRdW7u/Q8FrGVV7SzXm5mh8NXAuemKwR6REq5ZuucWkJvkth7BVWjmnArMW4kEWHPRLAoago=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rOtHTB/a; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=heKJMC1wrf6opHCwQhR4/CUPeEmuCtR7XwusV0V8Zq0=; b=rOtHTB/a7G+i4mnRCZZORquCIr
	sBsjplypZfeFnUjFv+z1SlqaxLK5ma7NT/i/r+1ga/KEjvfUfUyNH467XEW0cIcxa6xuGetuIWN6O
	mngIy4Jncgqpf4M6H7NgaKTkZfMVTYiuDagtXIggFAVB7g0uZHtVP/NNLwcYYjigHIjzXIcFjE1ek
	qABlZ4Zk8B6cNtAmxNYUs5BocS5bJCCUqJUqSUEfz4ghiikCN2djGZhVUaGqX5+g0f6QkarcP/Fl0
	Df+Dck44wnnSlhYJVdLnbO7MolWkz008PwOVJeWdqf4fYovpswJotEdyt70W798E06Rrf+1nnoWyy
	7Ikey53Q==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4Fnj-00000007uSG-3UPI;
	Mon, 14 Apr 2025 09:08:24 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id DAE6E3003AF; Mon, 14 Apr 2025 11:08:23 +0200 (CEST)
Date: Mon, 14 Apr 2025 11:08:23 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Rik van Riel <riel@surriel.com>
Cc: Pat Cody <pat@patcody.io>, mingo@redhat.com, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, linux-kernel@vger.kernel.org, patcody@meta.com,
	kernel-team@meta.com, stable@vger.kernel.org,
	Breno Leitao <leitao@debian.org>
Subject: Re: [PATCH] sched/fair: Add null pointer check to pick_next_entity()
Message-ID: <20250414090823.GB5600@noisy.programming.kicks-ass.net>
References: <20250320205310.779888-1-pat@patcody.io>
 <20250324115613.GD14944@noisy.programming.kicks-ass.net>
 <9d38c61098b426777c1a748cf1baf8e57c41c334.camel@surriel.com>
 <20250402180734.GX5880@noisy.programming.kicks-ass.net>
 <b40f830845f1f97aa4b686c5c1333ff1bf5d59b3.camel@surriel.com>
 <20250409152703.GL9833@noisy.programming.kicks-ass.net>
 <20250411105134.1f316982@fangorn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250411105134.1f316982@fangorn>

On Fri, Apr 11, 2025 at 10:51:34AM -0400, Rik van Riel wrote:
> On Wed, 9 Apr 2025 17:27:03 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> > On Wed, Apr 09, 2025 at 10:29:43AM -0400, Rik van Riel wrote:
> > > Our trouble workload still makes the scheduler crash
> > > with this patch.
> > > 
> > > I'll go put the debugging patch on our kernel.
> > > 
> > > Should I try to get debugging data with this patch
> > > part of the mix, or with the debugging patch just
> > > on top of what's in 6.13 already?  
> > 
> > Whatever is more convenient I suppose.
> > 
> > If you can dump the full tree that would be useful. Typically the
> > se::{vruntime,weight} and cfs_rq::{zero_vruntime,avg_vruntime,avg_load}
> > such that we can do full manual validation of the numbers.
> 
> Here is a dump of the scheduler tree of the crashing CPU.
> 
> Unfortunately the CPU crashed in pick_next_entity, and not in your
> debugging code. I'll add two more calls to avg_vruntime_validate(),
> one from avg_vruntime_update(), and one rfom __update_min_vruntime()
> when we skip the call to avg_vruntime_update(). The line numbers in
> the backtrace could be a clue.
> 
> I have edited the cgroup names to make things more readable, but everything
> else is untouched.

Hmm, I didn't think you guys used the cgroup stuff.

Anyway, given cgroups, which group pick is the one that went boom? Also,
what is curr (for that cgroup).

curr lives outside of the tree, but is included in the eligibility
consideration (when still on_rq and all that).

> nr_running = 3
> min_vruntime = 107772371139014
> avg_vruntime = -1277161882867784752
> avg_load = 786
> tasks_timeline = [
>   {
>     cgroup /A
>     weight = 10230 => 9

No vruntime, I'll assume !on_rq, but that makes avg_load above not match
:/ So something is off here.

>     rq = {
>       nr_running = 0
>       min_vruntime = 458975898004
>       avg_vruntime = 0
>       avg_load = 0
>       tasks_timeline = [
>       ]
>     }
>   },
>   {
>     cgroup /B
>     vruntime = 18445226958208703357
>     weight = 319394 => 311
>     rq = {
>       nr_running = 2
>       min_vruntime = 27468255210769
>       avg_vruntime = 0
>       avg_load = 93
>       tasks_timeline = [
>         {
>           cgroup /B/a
>           vruntime = 27468255210769
>           weight = 51569 => 50
>           rq = {
>             nr_running = 1
>             min_vruntime = 820449693961
>             avg_vruntime = 0
>             avg_load = 15
>             tasks_timeline = [
>               {
>                 task = 3653382 (fc0)
>                 vruntime = 820449693961
>                 weight = 15360 => 15
>               },
>             ]
>           }
>         },
>         {
>           cgroup /B/b
>           vruntime = 27468255210769
>           weight = 44057 => 43
>           rq = {
>             nr_running = 1
>             min_vruntime = 563178567930
>             avg_vruntime = 0
>             avg_load = 15
>             tasks_timeline = [
>               {
>                 task = 3706454 (fc0)
>                 vruntime = 563178567930
>                 weight = 15360 => 15
>               },
>             ]
>           }
>         },
>       ]
>     }
>   },
>   {
>     cgroup /C
>     vruntime = 18445539757376619550
>     weight = 477855 => 466
>     rq = {
>       nr_running = 0
>       min_vruntime = 17163581720739
>       avg_vruntime = 0
>       avg_load = 0
>       tasks_timeline = [
>       ]
>     }
>   },
> ]

So given the above, I've created the below files, and that gives:

$ ./vruntime < root.txt
  k: 0 w: 311 k*w: 0
  k: 312799167916193 w: 466 k*w: 145764412248945938
  v': 107772371139014 = v: 18445226958208703357 + d: 1624887871987273
  V': -1116773464285165183 = V: 145764412248945938 - d: 1624887871987273 * W: 777
min_vruntime: 107772371139014
avg_vruntime: -1116773464285165183
avg_load: 777

> One thing that stands out to me is how the vruntime of each of the
> entities on the CPU's cfs_rq are really large negative numbers.
> 
> vruntime = 18429030910682621789 equals 0xffc111f8d9ee675d
> 
> I do not know how those se->vruntime numbers got to that point,
> but they are a suggestive cause of the overflow.
> 
> I'll go comb through the se->vruntime updating code to see how those
> large numbers could end up as the vruntime for these sched entities.

As you can see from the output here, the large negative is the result
of min_vruntime being significantly ahead of the actual entities.

This can happen due to that monotonicity filter the thing has -- it
doesn't want to go backwards. Whereas the 0-lag point can move
backwards, seeing how it is the weighted average, and inserting a task
with positive lag will insert a task left of middle, moving the middle
left.

The zero_vruntime patch I gave earlier should avoid this particular
issue.


$ ./vruntime < B.txt
  k: 0 w: 50 k*w: 0
  k: 0 w: 43 k*w: 0
  v': 27468255210769 = v: 27468255210769 + d: 0
  V': 0 = V: 0 - d: 0 * W: 93
min_vruntime: 27468255210769
avg_vruntime: 0
avg_load: 93


C, B/a and B/b are not really interesting, they're single entries where
min_vruntime == vruntime and boring.

---8<---(root.txt)---8<---
entity 18445226958208703357     319394
entity 18445539757376619550     477855
group   107772371139014


---8<---(B.txt)---8<---
entity  27468255210769  51569
entity  27468255210769  44057
group   27468255210769


---8<---(vruntime.c)---8<---

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>

int main (int argc, char **argv)
{
        unsigned long V, W;
        unsigned long V0;
        bool init = false;

        for (;;) {
                unsigned long vruntime, weight;
                char type[32];

                int r = scanf("%s\t%lu\t%lu\n", &type, &vruntime, &weight);
                if (r == EOF)
                        break;

                if (!strcmp(type, "entity")) {
                        if (!init) {
                                V = W = 0;
                                V0 = vruntime;
                                init = true;
                        }

                        unsigned long k = vruntime - V0;
                        unsigned long w = weight / 1024;

                        V += k * w;
                        W += w;

                        printf("  k: %ld w: %lu k*w: %ld\n", k, w, k*w);
                }

                if (!strcmp(type, "group")) {
                        unsigned long d = vruntime - V0;

                        printf("  v': %lu = v: %lu + d: %lu\n", V0 + d, V0, d);
                        printf("  V': %ld = V: %ld - d: %ld * W: %lu\n",
                                        V - d * W, V, d, W);

                        V0 += d;
                        V -= d * W;
                }
        }

        printf("min_vruntime: %lu\n", V0);
        printf("avg_vruntime: %ld\n", V);
        printf("avg_load: %lu\n", W);

        return 0;
}


