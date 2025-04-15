Return-Path: <stable+bounces-132713-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B28F8A8997C
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 12:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8BCE7A4A76
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 10:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE3228466C;
	Tue, 15 Apr 2025 10:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cRFVk8FA"
X-Original-To: stable@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964A728B514;
	Tue, 15 Apr 2025 10:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744711638; cv=none; b=iF60/46cANVgdAXut8r/BL/vYUuHmfgzcDlqn3RMoWTRCvWG9cPtfvU0CvbMCWVbTWZldVTtisE96g8GpA1tNvpXkxf3uRv6DJxubJiA4G+aMds+BPXIhEpRddHDXU+jP9/O2CWKbriiq5cRTqq9tXDm3c9v5kNdc1fO+kRCm6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744711638; c=relaxed/simple;
	bh=Xmw2n34HTb4CmV0vYYOlRSSM14jMZD0l23aArEVN+To=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sqdhYFijEIWdBaqheT5009mhPuUOlXT/nrQsbTI5iTkgf6fZEsllNWyPKyVDZt7V6CiRs0JHMX+ghcFJnH2aNnFQY/+6LxwKuQq0Fjd6aX+3U5vNWu3ZmGGNZsUodXsMCobWgghv3PZXpIteFVFouLGTmXMOuT9lRMpjMUIk6vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cRFVk8FA; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=AZx5onmI2NQY1J9fzQquw1HQjvetCCNAmNg5YhmLvG0=; b=cRFVk8FAvR3TLw0wem5NBg9fc5
	0giSMILFqUVkLFz5GEowmWoN5gMmzmKHA29MvegxhIuFr/jeqQ1iOr4JjTzp6yyjzzhnWWTgvfayN
	Nay/NK2b6A7sSlTjphAfUCubdyb37WVUYmjTOIPiBF9ZsWctlBAdMKm8oUTeNe8V9pQr+Mx2G+owS
	ZF4D2tozr6XLUIhNTWbVyXhdcl8mGmleQOUqfszq6EDaWCfkrLQgozJcu2mDyqnd/N8dmKzmsfQMu
	MFfnKdkpeSxMOZyg/2mQyqsLw0XkXFdzYlpAGoQiccbhiqIqrCLw49Ctr4Ywb1zT/KK0Ty0qX1NoG
	OxEHQY8w==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u4dC6-00000009qsv-24qo;
	Tue, 15 Apr 2025 10:07:06 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id ADAD2300619; Tue, 15 Apr 2025 12:07:05 +0200 (CEST)
Date: Tue, 15 Apr 2025 12:07:05 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Chris Mason <clm@meta.com>
Cc: Rik van Riel <riel@surriel.com>, Pat Cody <pat@patcody.io>,
	mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org,
	patcody@meta.com, kernel-team@meta.com, stable@vger.kernel.org,
	Breno Leitao <leitao@debian.org>
Subject: Re: [PATCH] sched/fair: Add null pointer check to pick_next_entity()
Message-ID: <20250415100705.GL5600@noisy.programming.kicks-ass.net>
References: <20250320205310.779888-1-pat@patcody.io>
 <20250324115613.GD14944@noisy.programming.kicks-ass.net>
 <9d38c61098b426777c1a748cf1baf8e57c41c334.camel@surriel.com>
 <20250402180734.GX5880@noisy.programming.kicks-ass.net>
 <b40f830845f1f97aa4b686c5c1333ff1bf5d59b3.camel@surriel.com>
 <20250409152703.GL9833@noisy.programming.kicks-ass.net>
 <20250411105134.1f316982@fangorn>
 <20250414090823.GB5600@noisy.programming.kicks-ass.net>
 <0049c6a0-8802-416c-9618-9d714c22af49@meta.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0049c6a0-8802-416c-9618-9d714c22af49@meta.com>

On Mon, Apr 14, 2025 at 11:38:15AM -0400, Chris Mason wrote:
> 
> 
> On 4/14/25 5:08 AM, Peter Zijlstra wrote:
> 
> [ math and such ]
> 
> 
> > The zero_vruntime patch I gave earlier should avoid this particular
> > issue.
> 
> Here's a crash with the zero runtime patch. 

And indeed it doesn't have these massive (negative) avg_vruntime values.

> I'm trying to reproduce
> this outside of prod so we can crank up the iteration speed a bit.

Thanks.

Could you add which pick went boom for the next dump?



I am however, slightly confused by this output format.

It looks like it dumps the cfs_rq the first time it encounters it,
either through curr or through the tree.

So if I read this correct the root is something like:

> nr_running = 2
> zero_vruntime = 19194347104893960
> avg_vruntime = 6044054790
> avg_load = 2
> curr = {
>   cgroup urgent
>   vruntime = 24498183812106172
>   weight = 3561684 => 3478
> }
> tasks_timeline = [
>   {
>     cgroup optional
>     vruntime = 19194350126921355
>     weight = 1168 => 2
>   },
> ]

group  19194347104893960
curr   24498183812106172 3561684
entity 19194350126921355 1168

But if I run those numbers, I get avg_load == 1, seeing how 1168/1024 =
1. But the thing says it should be 2.

Similarly, my avg_vruntime is exactly half of what it says.

avg_vruntime: 3022027395
avg_load: 1

(seeing how 19194350126921355-19194347104893960 = 3022027395)

Anyway, with curr being significantly to the right of that, the 0-lag
point is well right of where optional sits. So this pick should be fine,
and result in 'optional' getting selected (curr is no longer eligible).

All the urgent/* groups have nr_running == 0, so are not interesting,
we'll not pick there.

NOTE: I'm inferring curr is on_rq, because nr_running == 2 and the tree
only has 1 entity in it. 

NOTE: if we ignore curr, then optional sits at exactly the 0-lag point,
with either sets of numbers and so should be eligible.


This then leaves us the optional/* groups.

>     cgroup optional
>     rq = {
>       nr_running = 2
>       zero_vruntime = 440280059357029
>       avg_vruntime = 476
>       avg_load = 688
>       tasks_timeline = [
>         {
>           cgroup optional/-610613050111295488
>           vruntime = 440280059333960
>           weight = 291271 => 284
>         },
>         {
>           cgroup optional/-610609318858457088
>           vruntime = 440280059373247
>           weight = 413911 => 404
>         },

group 440280059357029
entity 440280059333960 291271
entity 440280059373247 413911

Which gives:

avg_vruntime: 476
avg_load: 688

And that matches.

Next we have:

>           cgroup optional/-610613050111295488
>           rq = {
>             nr_running = 5
>             zero_vruntime = 65179829005
>             avg_vruntime = 0
>             avg_load = 75
>             tasks_timeline = [
>               {
>                 task = 261672 (fc0)
>                 vruntime = 65189926507
>                 weight = 15360 => 15
>               },
>               {
>                 task = 261332 (fc0)
>                 vruntime = 65189480962
>                 weight = 15360 => 15
>               },
>               {
>                 task = 261329 (enc1:0:vp9_fbv)
>                 vruntime = 65165843516
>                 weight = 15360 => 15
>               },
>               {
>                 task = 261334 (dec0:0:hevc_fbv)
>                 vruntime = 65174065035
>                 weight = 15360 => 15
>               },
>               {
>                 task = 261868 (fc0)
>                 vruntime = 65179829005
>                 weight = 15360 => 15
>               },
>             ]
>           }


avg_vruntime: 0
avg_load: 75

This again matches, leaving the bottom 3 tasks eligible.

And finally:

>           cgroup optional/-610609318858457088
>           rq = {
>             nr_running = 1
>             zero_vruntime = 22819875784
>             avg_vruntime = 0
>             avg_load = 15
>             tasks_timeline = [
>               {
>                 task = 273291 (fc0)
>                 vruntime = 22819875784
>                 weight = 15360 => 15
>               },
>             ]
>           }

Rather boring indeed, but the numbers appear correct.


So I'm not immediately seeing where it would go boom, but seeing how the
root group is the one with dodgy numbers, I would suspect that -- but
I'm not immediately seeing how... :-(

