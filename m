Return-Path: <stable+bounces-59415-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0FE893282F
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 16:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DBE0B2294E
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 14:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661B819B58A;
	Tue, 16 Jul 2024 14:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="t98P7e/F"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F281DFD0
	for <stable@vger.kernel.org>; Tue, 16 Jul 2024 14:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721139713; cv=none; b=o8DVEZ+m8syTPhNr2KEfC33KWmsRh5tvmkPBF7XY0Hi2T9tWYfWwUs6I/C0fx5GVSr/H3TerEeZl0+fMUf51PvJ2r6yBVSV2W4Yl9tHaLpromiWeyjdpPVF4UUPhv9GFgnw/8CQMAlewNCxhl1AwTCRyexhSuJpSrmd0Pf176xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721139713; c=relaxed/simple;
	bh=xM6L05LshKjCJ+cYhVRNXmRPQC4beYkyAVZjqbNyQw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NBH5SA7r6hlEHDVrD+xRqZ7JBXV2ss/PaoL/hryzSKHVAEFcTlkMgcfKqmhJQmtYbQYnsdGbtFtNPoNd7qSfmF1UHh6tpEKd+uyvAEQGgJxQaSDpoYih0X/CDkDIeJ0zoWpEG4HhZTC4CXsj2pnYt+o6TQQL9r1duouQ62QjecE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=t98P7e/F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C21BC4AF0D;
	Tue, 16 Jul 2024 14:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721139712;
	bh=xM6L05LshKjCJ+cYhVRNXmRPQC4beYkyAVZjqbNyQw8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t98P7e/FcQ5OII2WTg5ARM4gNgOLGnA0Zt9xqmbZqAvIwdA60NKlbX4lcVzGqP7cv
	 ugQeEySUxAz1lLZSUykJ6vMXINNoPMOdD0OCljZu1DNqWvJQjLhrG4Iet9evCXoQf9
	 FSrDSIHGJIaRf/6OjAEAgThb2rLNY3PoL2Z+pg20=
Date: Tue, 16 Jul 2024 16:21:50 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: John Stultz <jstultz@google.com>
Cc: stable@vger.kernel.org, Jimmy Shiu <jimmyshiu@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Qais Yousef <qyousef@layalina.io>
Subject: Re: [PATCH 6.1] sched: Move psi_account_irqtime() out of
 update_rq_clock_task() hotpath
Message-ID: <2024071639-huff-outcast-21b0@gregkh>
References: <20240716004050.515306-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240716004050.515306-1-jstultz@google.com>

On Mon, Jul 15, 2024 at 05:40:39PM -0700, John Stultz wrote:
> commit ddae0ca2a8fe12d0e24ab10ba759c3fbd755ada8 upstream.
> 
> It was reported that in moving to 6.1, a larger then 10%
> regression was seen in the performance of
> clock_gettime(CLOCK_THREAD_CPUTIME_ID,...).
> 
> Using a simple reproducer, I found:
> 5.10:
> 100000000 calls in 24345994193 ns => 243.460 ns per call
> 100000000 calls in 24288172050 ns => 242.882 ns per call
> 100000000 calls in 24289135225 ns => 242.891 ns per call
> 
> 6.1:
> 100000000 calls in 28248646742 ns => 282.486 ns per call
> 100000000 calls in 28227055067 ns => 282.271 ns per call
> 100000000 calls in 28177471287 ns => 281.775 ns per call
> 
> The cause of this was finally narrowed down to the addition of
> psi_account_irqtime() in update_rq_clock_task(), in commit
> 52b1364ba0b1 ("sched/psi: Add PSI_IRQ to track IRQ/SOFTIRQ
> pressure").
> 
> In my initial attempt to resolve this, I leaned towards moving
> all accounting work out of the clock_gettime() call path, but it
> wasn't very pretty, so it will have to wait for a later deeper
> rework. Instead, Peter shared this approach:
> 
> Rework psi_account_irqtime() to use its own psi_irq_time base
> for accounting, and move it out of the hotpath, calling it
> instead from sched_tick() and __schedule().
> 
> In testing this, we found the importance of ensuring
> psi_account_irqtime() is run under the rq_lock, which Johannes
> Weiner helpfully explained, so also add some lockdep annotations
> to make that requirement clear.
> 
> With this change the performance is back in-line with 5.10:
> 6.1+fix:
> 100000000 calls in 24297324597 ns => 242.973 ns per call
> 100000000 calls in 24318869234 ns => 243.189 ns per call
> 100000000 calls in 24291564588 ns => 242.916 ns per call
> 
> Reported-by: Jimmy Shiu <jimmyshiu@google.com>
> Originally-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: John Stultz <jstultz@google.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>
> Reviewed-by: Qais Yousef <qyousef@layalina.io>
> Link: https://lore.kernel.org/r/20240618215909.4099720-1-jstultz@google.com
> Fixes: 52b1364ba0b1 ("sched/psi: Add PSI_IRQ to track IRQ/SOFTIRQ pressure")
> [jstultz: Fixed up minor collisions w/ 6.1-stable]
> Signed-off-by: John Stultz <jstultz@google.com>
> ---
>  kernel/sched/core.c  |  7 +++++--
>  kernel/sched/psi.c   | 21 ++++++++++++++++-----
>  kernel/sched/sched.h |  1 +
>  kernel/sched/stats.h | 11 ++++++++---
>  4 files changed, 30 insertions(+), 10 deletions(-)

Both backports now queued up, thanks.

greg k-h

