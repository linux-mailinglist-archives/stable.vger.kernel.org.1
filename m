Return-Path: <stable+bounces-65380-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C998947B83
	for <lists+stable@lfdr.de>; Mon,  5 Aug 2024 15:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 383642819C3
	for <lists+stable@lfdr.de>; Mon,  5 Aug 2024 13:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6335615746B;
	Mon,  5 Aug 2024 13:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kg4ikPJt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ahjw1xw3"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26CA1514C9;
	Mon,  5 Aug 2024 13:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722863146; cv=none; b=A/VnWmBEDI3MYH2ARbPbj3fGsPFdXfQitGMRhYyIIWrmcYjlWALq6AdJVFQOvGcOf2+cX2eemwegETdTlfUgUriyRXZdGPrvW7b+IBPt9qEUrn2OqA3rdbiKjFl3fiKYYG69nBYyRSP7QNX0DopBNoR98fiEcMC0QW/YLIihr8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722863146; c=relaxed/simple;
	bh=eFN2sPjVj5Yl+84tJnzvzW2EDQWSMAAqlSRg3KNu8UE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gzdhwzkZXTqstNCiC378sX3hszEwyjbCFLA1o7cZmb1II4kgtvQTdQ6mDk52L1aS1/PvU0aSLoaMZVKb1/YGnCPNCorbIFI/7YH7FWFFCBqGQK7d5L8SN1YQIrYtyCdfvdotmI5O8T4EJwTgwPXfRB3nJUlvNZkOFa7osyqMU+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kg4ikPJt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ahjw1xw3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722863143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+te1bapzfw1K0ACXvja14/L2YeBsUai9y6dAgdsVyfs=;
	b=kg4ikPJtXUVsT0uC1mLh6dKyr+y6H8wz1zNyFBgvZpjTKm0O1qUO7ZQhlCTaEY74SCt64I
	C+Dn1ALQz7pf3G0Ylg3YN4GwarHEovSWCmQvYs79me//GsVCmzNt2f62ni0zOf1ZEzueDI
	bqFktrgjwlgJccyEpBiZxAz0FvxS0PJjB4cFoPqwQnFAalqN8lvxwgcXHvX9LiX473vNUq
	JoWCbAJ4djAOyfAxQgCIhzMQ83xm8mn9wn3YhFyqFg+K/tlmrWgYph7KoCE2wJz6woZ90r
	yfg0reLK6fGi2YorzcChUk6Zv4E9u9LCnqRsva/rq4+t2G7CT+eDMKzq3q+hjg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722863143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+te1bapzfw1K0ACXvja14/L2YeBsUai9y6dAgdsVyfs=;
	b=Ahjw1xw3snzg3wiknX1wLQcRTZkcZgwxGwmNUfQz9AmQlm5S1SnDLMn5LxYSGRtBLCZGZ6
	30sl+5IuabXuc8Cg==
To: Felix Moessbauer <felix.moessbauer@siemens.com>,
 linux-kernel@vger.kernel.org
Cc: Frederic Weisbecker <frederic@kernel.org>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, jan.kiszka@siemens.com, Felix Moessbauer
 <felix.moessbauer@siemens.com>, stable@vger.kernel.org, Sebastian Andrzej
 Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 2/2] hrtimer: Ignore slack time for RT tasks in
 hrtimer_start_range_ns()
In-Reply-To: <20240805124116.21394-3-felix.moessbauer@siemens.com>
References: <20240805124116.21394-1-felix.moessbauer@siemens.com>
 <20240805124116.21394-3-felix.moessbauer@siemens.com>
Date: Mon, 05 Aug 2024 15:05:42 +0200
Message-ID: <87a5hr5dcp.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Aug 05 2024 at 14:41, Felix Moessbauer wrote:
> RT tasks do not have any timerslack, as this induces jitter. By
> that, the timer slack is already ignored in the nanosleep family and
> schedule_hrtimeout_range() (fixed in 0c52310f2600).
>
> The hrtimer_start_range_ns function is indirectly used by glibc-2.33+
> for timed waits on condition variables. These are sometimes used in
> RT applications for realtime queue processing. At least on the
> combination of kernel 5.10 and glibc-2.31, the timed wait on condition
> variables in rt tasks was precise (no slack), however glibc-2.33
> changed the internal wait implementation, exposing the kernel bug.

That's hardly a bug. It's an oversight.

> This patch makes the timer slack consistent across all hrtimer

"This patch" ....

> programming code, by ignoring the timerslack for rt tasks also in the
> last remaining location in hrtimer_start_range_ns().
>
> Similar to 0c52310f2600, this fix should be backported as well.

This is not part of the change log.

> Cc: stable@vger.kernel.org
> Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
> ---
>  kernel/time/hrtimer.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
> index 2b1469f61d9c..1b26e095114d 100644
> --- a/kernel/time/hrtimer.c
> +++ b/kernel/time/hrtimer.c
> @@ -1274,7 +1274,7 @@ static int __hrtimer_start_range_ns(struct hrtimer *timer, ktime_t tim,
>   * hrtimer_start_range_ns - (re)start an hrtimer
>   * @timer:	the timer to be added
>   * @tim:	expiry time
> - * @delta_ns:	"slack" range for the timer
> + * @delta_ns:	"slack" range for the timer for SCHED_OTHER tasks
>   * @mode:	timer mode: absolute (HRTIMER_MODE_ABS) or
>   *		relative (HRTIMER_MODE_REL), and pinned (HRTIMER_MODE_PINNED);
>   *		softirq based mode is considered for debug purpose only!
> @@ -1299,6 +1299,10 @@ void hrtimer_start_range_ns(struct hrtimer *timer, ktime_t tim,
>  
>  	base = lock_hrtimer_base(timer, &flags);
>  
> +	/* rt-tasks do not have a timer slack for obvious reasons */
> +	if (rt_task(current))
> +		delta_ns = 0;

        task_is_realtime()

please

Thanks,

        tglx

