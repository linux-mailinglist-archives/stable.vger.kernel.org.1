Return-Path: <stable+bounces-94104-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AD489D3652
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 10:04:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D4FD283B7C
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 09:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E5016DC3C;
	Wed, 20 Nov 2024 09:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="R8TnYMIk"
X-Original-To: stable@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58ABDA932;
	Wed, 20 Nov 2024 09:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732093440; cv=none; b=hsB030JHOP5i791WveWjBXZeR2wJRk3u150Xy4754GVEN6Jw6zK4MRq6Vp2tfFppX79a2zqwJnm/VVPBdTKU03FnFODFPZm7HCU0WNHB+IrHO8+Yg7Er/vs4BpFXNYR84VDXbnUV71nQtA1j5NKLmWTiZLnrz1vtVOVFw2uUIZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732093440; c=relaxed/simple;
	bh=9X+mU1e98GUO9riOayBq4detdn+863adFnXVmtFwROA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KzdbLZYOAfBGv4sTRx6/xMhZUvFvw5nqdEdtqViY4Nr/IlOeNJtYv1LKsN/pAN+iMwj+Y8+drt5ut1l4Txx9HyWLdjfig3kwFQGiQiw+5Su48lwvy24Ip1HbuAo2q6UN3RsWyQjaSUR7yjdKdRjuzG8Ay7mK7vydcRyyIgg3zzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=R8TnYMIk; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Q6fZVPeJLh5zqpRAP7nrk/3zS0Fav8RZ7sccznXWyBw=; b=R8TnYMIkh8VDcvdPVWk4d7pQtU
	TOAE6b31pM1deknAVj1rMYdDjThBCBJGzLQNjscY8Cre7+ezAdCXXnBCM6+oHN4HjUZ6edAud18Up
	LS3MCDd6B4nno+9vicHrIdL1OevIgt2VJZ3Bw6X/RaDX3iG+/OWxvsmgBUES6IvajIWFF0MoKmJ3c
	80Ke2xpYGyLB5FdLbN5pgl3ufM7P8q9mN3V9j1/TQ3PQ02hzNtDVmblS6mNJCFyMUTTE+zcHVYB9j
	OjqXTJngfLG7lLKpmnNAFzFQgYTfBmCyx8A1ywotGgZiC4PAAYKI3SMmCSSMjFFT7oRA5sdaGFEdR
	nRVcUTeA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tDgcs-00000000SWT-4AsH;
	Wed, 20 Nov 2024 09:03:55 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 36E613006AB; Wed, 20 Nov 2024 10:03:54 +0100 (CET)
Date: Wed, 20 Nov 2024 10:03:54 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Chenbo Lu <chenbo.lu@jobyaviation.com>
Cc: stable@vger.kernel.org, regressions@lists.linux.dev, mingo@redhat.com,
	juri.lelli@redhat.com, linux-kernel@vger.kernel.org,
	vschneid@redhat.com
Subject: Re: Performance Degradation After Upgrading to Kernel 6.8
Message-ID: <20241120090354.GE19989@noisy.programming.kicks-ass.net>
References: <CACodVevaOp4f=Gg467_m-FAdQFceGQYr7_Ahtt6CfpDVQhAsjA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACodVevaOp4f=Gg467_m-FAdQFceGQYr7_Ahtt6CfpDVQhAsjA@mail.gmail.com>

On Tue, Nov 19, 2024 at 04:30:02PM -0800, Chenbo Lu wrote:
> Hello,
> 
> I am experiencing a significant performance degradation after
> upgrading my kernel from version 6.6 to 6.8 and would appreciate any
> insights or suggestions.
> 
> I am running a high-load simulation system that spawns more than 1000
> threads and the overall CPU usage is 30%+ . Most of the threads are
> using real-time
> scheduling (SCHED_RR), and the threads of a model are using
> SCHED_DEADLINE. After upgrading the kernel, I noticed that the
> execution time of my model has increased from 4.5ms to 6ms.
> 
> What I Have Done So Far:
> 1. I found this [bug
> report](https://bugzilla.kernel.org/show_bug.cgi?id=219366#c7) and
> reverted the commit efa7df3e3bb5da8e6abbe37727417f32a37fba47 mentioned
> in the post. Unfortunately, this did not resolve the issue.
> 2. I performed a git bisect and found that after these two commits
> related to scheduling (RT and deadline) were merged, the problem
> happened. They are 612f769edd06a6e42f7cd72425488e68ddaeef0a,
> 5fe7765997b139e2d922b58359dea181efe618f9

And yet you failed to Cc Valentin, the author of said commits :/

> After reverting these two commits, the model execution time improved
> to around 5 ms.
> 3. I revert two more commits, and the execution time is back to 4.7ms:
> 63ba8422f876e32ee564ea95da9a7313b13ff0a1,
> efa7df3e3bb5da8e6abbe37727417f32a37fba47
> 
> My questions are:
> 1.Has anyone else experienced similar performance degradation after
> upgrading to kernel 6.8?

This is 4 kernel releases back, I my memory isn't that long.

> 2.Can anyone explain why these two commits are causing the problem? I
> am not very familiar with the kernel code and would appreciate any
> insights.

There might be a race window between setting the tro and sending the
IPI, such that previously the extra IPIs would sooner find the newly
pushable task.

Valentin, would it make sense to set tro before enqueueing the pushable,
instead of after it?

