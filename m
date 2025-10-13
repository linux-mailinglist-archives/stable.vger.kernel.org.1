Return-Path: <stable+bounces-184140-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D86BD1EB6
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 10:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D634D3A824A
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 08:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574662EB875;
	Mon, 13 Oct 2025 08:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eE8UCNOT"
X-Original-To: stable@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2B81B4156;
	Mon, 13 Oct 2025 08:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760342743; cv=none; b=G7ZWV3S6Q7LY3IeWyj/Fbn6U2UPEK/0OUZ8VbqO5YdexZ+XHTHA3EOUedttonakDi+uKLuW+WHkm6diT7ea8/2cPYXvzngwWF2kP4t9DxLh3GA4IvMwKVaweGwCayRSaDUhyK0kM2Sbg7MrEOv5UFGGgf3/cWQr3eMrF9UJ4vRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760342743; c=relaxed/simple;
	bh=EyY1vptLQ4Mh8m69V026ogvAbJnnK8hecewRxznrDdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g6vAY33x2AIyL5CbeSSzxmM5Hm8bdi0rC7NMU4hwj6+R7KY4buoQ7wF4Rfr7Qsh7RSDbRbN8TDu9sDDXy7yNrPutjSEiw4uRXvCLjBy5aXlc1GbTZmMUgo1wwYb/vnSW+NkJ+FcACLhMkz3QpJxlXeZnxNW4nbX7X53QPOeRh7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=eE8UCNOT; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=PhVyTJzr0MtR40Aa2Lc7JNLBbowuEgYIbKmkpnrAFlY=; b=eE8UCNOT/DVa91HJ1a7s7WL1gm
	SNoAD05RaLQX4b770TFFghp723QQRsx04hi3ATZYS0dR0LjGotK4aWPQccDHPg/75ujZ7ystx3cYh
	HeV1YJ+eR95DjLsorXEE3nPAhSZaT6Q67qAD7eJTdzxH9kMBUdJoL8A4FgvqCKi9aT1SGCicd3NLg
	kIPYpHpkujvSgk9hAHuGbhFLx6o2mL9jV5pO0lTF1W/vKlMXZdIUM+HIlVptxFiDHJKSorK789f1h
	cgpcGT7AuC5LB3WfyKMT8pHazGHCv4dfnWZFy9CrT/CS4gdLsPd67D/YAVdQCVYzO2AKRTzwab8Ik
	/IwF3gNg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8DYj-00000004Bwe-1Aii;
	Mon, 13 Oct 2025 08:05:33 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C403C300212; Mon, 13 Oct 2025 10:05:31 +0200 (CEST)
Date: Mon, 13 Oct 2025 10:05:31 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: Octavia Togami <octavia.togami@gmail.com>, stable@vger.kernel.org,
	regressions@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [REGRESSION] bisected: perf: hang when using async-profiler
 caused by perf: Fix the POLL_HUP delivery breakage
Message-ID: <20251013080531.GJ3245006@noisy.programming.kicks-ass.net>
References: <CAHPNGSQpXEopYreir+uDDEbtXTBvBvi8c6fYXJvceqtgTPao3Q@mail.gmail.com>
 <8aed5e69-57b1-4a01-b90c-56402eb27b37@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8aed5e69-57b1-4a01-b90c-56402eb27b37@linux.intel.com>

On Mon, Oct 13, 2025 at 10:34:27AM +0800, Mi, Dapeng wrote:

> It looks the issue described in the link
> (https://lore.kernel.org/all/20250606192546.915765-1-kan.liang@linux.intel.com/T/#u)
> happens again but in a different way. :(
> 
> As the commit message above link described,  cpu-clock (and task-clock) is
> a specific SW event which rely on hrtimer. The hrtimer handler calls
> __perf_event_overflow() and then event_stop (cpu_clock_event_stop()) and
> eventually call hrtimer_cancel() which traps into a dead loop which waits
> for the calling hrtimer handler finishes.
> 
> As the
> change (https://lore.kernel.org/all/20250606192546.915765-1-kan.liang@linux.intel.com/T/#u),
> it should be enough to just disable the event and don't need an extra event
> stop.
> 
> @Octavia, could you please check if the change below can fix this issue?
> Thanks.
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 7541f6f85fcb..883b0e1fa5d3 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -10343,7 +10343,20 @@ static int __perf_event_overflow(struct perf_event
> *event,
>                 ret = 1;
>                 event->pending_kill = POLL_HUP;
>                 perf_event_disable_inatomic(event);
> -               event->pmu->stop(event, 0);
> +
> +               /*
> +                * The cpu-clock and task-clock are two special SW events,
> +                * which rely on the hrtimer. The __perf_event_overflow()
> +                * is invoked from the hrtimer handler for these 2 events.
> +                * Avoid to call event_stop()->hrtimer_cancel() for these
> +                * 2 events since hrtimer_cancel() waits for the hrtimer
> +                * handler to finish, which would trigger a deadlock.
> +                * Only disabling the events is enough to stop the hrtimer.
> +                * See perf_swevent_cancel_hrtimer().
> +                */
> +               if (event->attr.config != PERF_COUNT_SW_CPU_CLOCK &&
> +                   event->attr.config != PERF_COUNT_SW_TASK_CLOCK)
> +                       event->pmu->stop(event, 0);

This is broken though; you cannot test config without first knowing
which PMU you're dealing with.

Also, that timer really should get stopped, we can't know for certain
this overflow is of the timer itself or not, it could be a related
event.

Something like the below might do -- but please carefully consider the
cases where hrtimer_try_to_cancel() might fail; in those cases we'll
have set HES_STOPPED and the hrtimer callback *SHOULD* observe this and
NORESTART.

But I didn't check all the details.

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 820127536e62..a91481d57841 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -11756,7 +11756,8 @@ static enum hrtimer_restart perf_swevent_hrtimer(struct hrtimer *hrtimer)
 
 	event = container_of(hrtimer, struct perf_event, hw.hrtimer);
 
-	if (event->state != PERF_EVENT_STATE_ACTIVE)
+	if (event->state != PERF_EVENT_STATE_ACTIVE ||
+	    event->hw.state & PERF_HES_STOPPED)
 		return HRTIMER_NORESTART;
 
 	event->pmu->read(event);
@@ -11810,7 +11811,7 @@ static void perf_swevent_cancel_hrtimer(struct perf_event *event)
 		ktime_t remaining = hrtimer_get_remaining(&hwc->hrtimer);
 		local64_set(&hwc->period_left, ktime_to_ns(remaining));
 
-		hrtimer_cancel(&hwc->hrtimer);
+		hrtimer_try_to_cancel(&hwc->hrtimer);
 	}
 }
 
@@ -11854,12 +11855,14 @@ static void cpu_clock_event_update(struct perf_event *event)
 
 static void cpu_clock_event_start(struct perf_event *event, int flags)
 {
+	event->hw.state = 0;
 	local64_set(&event->hw.prev_count, local_clock());
 	perf_swevent_start_hrtimer(event);
 }
 
 static void cpu_clock_event_stop(struct perf_event *event, int flags)
 {
+	event->hw.state = PERF_HES_STOPPED;
 	perf_swevent_cancel_hrtimer(event);
 	if (flags & PERF_EF_UPDATE)
 		cpu_clock_event_update(event);

