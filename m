Return-Path: <stable+bounces-72707-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 320019683A3
	for <lists+stable@lfdr.de>; Mon,  2 Sep 2024 11:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54F0E1C222B2
	for <lists+stable@lfdr.de>; Mon,  2 Sep 2024 09:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F74F1D2791;
	Mon,  2 Sep 2024 09:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KFVkMLnr"
X-Original-To: stable@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120A815C15E;
	Mon,  2 Sep 2024 09:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725270668; cv=none; b=Kyz3tXokax0QoqIG+s2a205tackxT+zqiH57x9OLgOVK95YeRN1U/ZkpJH7Mzu5lV6Dr4H7gDC2vqCAmpwr/N3R2zTjtm83HQLAiEohSDP6ZJUuuTKjqa+dR6t3suJMXeA6XR7y4dAW0ik/R7qdNZiRDFv1opml6mqPCf3bowaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725270668; c=relaxed/simple;
	bh=vK3X2eh5jgaDvYS5+wA6Y3V4gUEsx93OdhdgDcslbPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qbYMOueYCLujAfD22fOtOg/XmcagkfwTkNNSMdScJ2ewPgw+1p3nyqLGXpFkfOCJp1Yrj+iJHBWdpqSkAySieUJEe88VcdbiyOczzZudtQtgMLztYCzdXf0NzYb8HTpCjcKI/njQ96OE7DQ6ine2u9/7ACGe1ltyyXVCOidVQSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KFVkMLnr; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=h0wfIOWK5PRLKNr57WCqFk3j0F/4/yO4rPKo+XkKcec=; b=KFVkMLnrmNrPO9JKH/tbWmfHXv
	oVcNQTZwm/BCzRqRvbs20mnJO/Y2vVH0aabd/ut5qmIC0RK+7M79tTY1TiIbt02JddtZMaC8iFR6J
	/8zE9GiNx8vyqR8V677UZl2yESaWTD8b9P9TtUesYi3Yf/Fm1iLWnPqySSOXA7+AS76c6LlQvOwNL
	RTcGC6X9SKi++J0KltbzVZEp1Qb+cqMsgb4ij7Jz+yFtMoSpnkYJmfnTp/towemkw9t24DVRH1Nzm
	/ipm7ktGaGt/niNR6v8vSGJBtmgNUVv5/NlHblGnA1QoU7ec/b6d9RYC1+3vSZzgVOdx6zF8I4hBQ
	1KeZpFZg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sl3i2-0000000C7iW-3l0v;
	Mon, 02 Sep 2024 09:50:55 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 583BE300642; Mon,  2 Sep 2024 11:50:54 +0200 (CEST)
Date: Mon, 2 Sep 2024 11:50:54 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Luo Gengkun <luogengkun@huaweicloud.com>
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v5 2/2] perf/core: Fix incorrect time diff in tick adjust
 period
Message-ID: <20240902095054.GD4723@noisy.programming.kicks-ass.net>
References: <20240831074316.2106159-1-luogengkun@huaweicloud.com>
 <20240831074316.2106159-3-luogengkun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240831074316.2106159-3-luogengkun@huaweicloud.com>

On Sat, Aug 31, 2024 at 07:43:16AM +0000, Luo Gengkun wrote:
> Perf events has the notion of sampling frequency which is implemented in
> software by dynamically adjusting the counter period so that samples occur
> at approximately the target frequency.  Period adjustment is done in 2
> places:
>  - when the counter overflows (and a sample is recorded)
>  - each timer tick, when the event is active
> The later case is slightly flawed because it assumes that the time since
> the last timer-tick period adjustment is 1 tick, whereas the event may not
> have been active (e.g. for a task that is sleeping).
> 
> Fix by using jiffies to determine the elapsed time in that case.
> 
> Signed-off-by: Luo Gengkun <luogengkun@huaweicloud.com>
> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  include/linux/perf_event.h |  1 +
>  kernel/events/core.c       | 12 +++++++++---
>  2 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 1a8942277dda..d29b7cf971a1 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -265,6 +265,7 @@ struct hw_perf_event {
>  	 * State for freq target events, see __perf_event_overflow() and
>  	 * perf_adjust_freq_unthr_context().
>  	 */
> +	u64				freq_tick_stamp;
>  	u64				freq_time_stamp;
>  	u64				freq_count_stamp;
>  #endif
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index a9395bbfd4aa..183291e0d070 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -55,6 +55,7 @@
>  #include <linux/pgtable.h>
>  #include <linux/buildid.h>
>  #include <linux/task_work.h>
> +#include <linux/jiffies.h>
>  
>  #include "internal.h"
>  
> @@ -4120,9 +4121,11 @@ static void perf_adjust_freq_unthr_events(struct list_head *event_list)
>  {
>  	struct perf_event *event;
>  	struct hw_perf_event *hwc;
> -	u64 now, period = TICK_NSEC;
> +	u64 now, period, tick_stamp;
>  	s64 delta;
>  
> +	tick_stamp = jiffies64_to_nsecs(get_jiffies_64());
> +
>  	list_for_each_entry(event, event_list, active_list) {
>  		if (event->state != PERF_EVENT_STATE_ACTIVE)
>  			continue;
> @@ -4148,6 +4151,9 @@ static void perf_adjust_freq_unthr_events(struct list_head *event_list)
>  		 */
>  		event->pmu->stop(event, PERF_EF_UPDATE);
>  
> +		period = tick_stamp - hwc->freq_tick_stamp;
> +		hwc->freq_tick_stamp = tick_stamp;
> +
>  		now = local64_read(&event->count);
>  		delta = now - hwc->freq_count_stamp;
>  		hwc->freq_count_stamp = now;
> @@ -4157,9 +4163,9 @@ static void perf_adjust_freq_unthr_events(struct list_head *event_list)
>  		 * reload only if value has changed
>  		 * we have stopped the event so tell that
>  		 * to perf_adjust_period() to avoid stopping it
> -		 * twice.
> +		 * twice. And skip if it is the first tick adjust period.
>  		 */
> -		if (delta > 0)
> +		if (delta > 0 && likely(period != tick_stamp))
>  			perf_adjust_period(event, period, delta, false);
>  
>  		event->pmu->start(event, delta > 0 ? PERF_EF_RELOAD : 0);

This one I'm less happy with.. that condition 'period != tick_stamp'
doesn't make sense to me. That's only false if hwc->freq_tick_stamp ==
0, which it will only be once after event creation. Even through the
Changelog babbles about event scheduling.

Also, that all should then be written something like:

	if (delta > 0 && ...) {
		perf_adjust_period(...);
		adjusted = true;
	}

	event->pmu->start(event, adjusted ? PERF_EF_RELOAD : 0);

