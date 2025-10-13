Return-Path: <stable+bounces-184188-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 44CB2BD21DA
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 10:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AB0684ECF6E
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 08:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C562EC0B7;
	Mon, 13 Oct 2025 08:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lkUIJutH"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456962F90CE;
	Mon, 13 Oct 2025 08:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760344703; cv=none; b=TD7yJSTXWtJuK34JBBfsm83thGsVTlgkFP6N5JMcM2L7bQYvcfhSZuGrrnJergtQa8uzJypJ8WyNxOPdS/fk/q7EL89beX8I5HF+5Fot0Y+E9Wm0yBkBTdGN4ona8ZTQlKl/yNex3l9DahUVrsDcoOLoX4FKI4axoc4NmqwqZr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760344703; c=relaxed/simple;
	bh=26t7Q08DL+2PT4vvqMsKQUPvVz73YGp900Us8qtoeII=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q1jfAkSqnqLls9amXrpSEA6K8WbQIyvUc8T+K+9PNXwLdgpZxHmhWbVOpOl9Y4cx0DUnn6psA8p2L83U0MRKHgQvje4LRADtIxDW8Za+SS4DGPCyLMXv7R8hhXcvpxfrk46Gpt47vijcsi97PyP/x+7uPl+noRppjziNgwVrO2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lkUIJutH; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760344701; x=1791880701;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=26t7Q08DL+2PT4vvqMsKQUPvVz73YGp900Us8qtoeII=;
  b=lkUIJutHr9yY0H/ZYB3i2JISsNxIOfPMlTo3lDBpoVCyABBWHo6cmGGx
   q2JXr2O9kiLGcvJiQiDo/eC0+hNpDW9uohAJN0NRsaO6CA4Mo1A7Z4rgY
   TM3tpC5rlB2TbohWxmN79GFKSSw4aRor4+1d3Am4bf7zPk1a3icQodqmW
   +UMR5wFNcMZ4+CLH1TotzznxNSTOkr1HB3i8DbcgWkbAEe1vyeJnk6GPP
   1iMu5MqgrSdi0RzVMIZUGEDd/QTHqq8Po8XshtanPNHPY48ByaBfssWYE
   ImPv9PMxp0HuThN94j4STTsiRjZHp33qCfvBgENdwqxD/LfX1vh7vT13q
   g==;
X-CSE-ConnectionGUID: DlGtR1eORQWz1VTKepLVpQ==
X-CSE-MsgGUID: xaivkSxtQtKYH4So7K6qtw==
X-IronPort-AV: E=McAfee;i="6800,10657,11580"; a="66332243"
X-IronPort-AV: E=Sophos;i="6.19,225,1754982000"; 
   d="scan'208";a="66332243"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 01:38:20 -0700
X-CSE-ConnectionGUID: NM7kJcUdShCh09p123QYuA==
X-CSE-MsgGUID: 1AgSA781SSGWq/B2gxPzRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,225,1754982000"; 
   d="scan'208";a="212172484"
Received: from unknown (HELO [10.238.2.75]) ([10.238.2.75])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 01:38:18 -0700
Message-ID: <30c62dee-2219-4b39-94c7-b9cc81130c9e@linux.intel.com>
Date: Mon, 13 Oct 2025 16:38:15 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] bisected: perf: hang when using async-profiler
 caused by perf: Fix the POLL_HUP delivery breakage
To: Peter Zijlstra <peterz@infradead.org>
Cc: Octavia Togami <octavia.togami@gmail.com>, stable@vger.kernel.org,
 regressions@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org
References: <CAHPNGSQpXEopYreir+uDDEbtXTBvBvi8c6fYXJvceqtgTPao3Q@mail.gmail.com>
 <8aed5e69-57b1-4a01-b90c-56402eb27b37@linux.intel.com>
 <20251013080531.GJ3245006@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20251013080531.GJ3245006@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 10/13/2025 4:05 PM, Peter Zijlstra wrote:
> On Mon, Oct 13, 2025 at 10:34:27AM +0800, Mi, Dapeng wrote:
>
>> It looks the issue described in the link
>> (https://lore.kernel.org/all/20250606192546.915765-1-kan.liang@linux.intel.com/T/#u)
>> happens again but in a different way. :(
>>
>> As the commit message above link described,  cpu-clock (and task-clock) is
>> a specific SW event which rely on hrtimer. The hrtimer handler calls
>> __perf_event_overflow() and then event_stop (cpu_clock_event_stop()) and
>> eventually call hrtimer_cancel() which traps into a dead loop which waits
>> for the calling hrtimer handler finishes.
>>
>> As the
>> change (https://lore.kernel.org/all/20250606192546.915765-1-kan.liang@linux.intel.com/T/#u),
>> it should be enough to just disable the event and don't need an extra event
>> stop.
>>
>> @Octavia, could you please check if the change below can fix this issue?
>> Thanks.
>>
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index 7541f6f85fcb..883b0e1fa5d3 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -10343,7 +10343,20 @@ static int __perf_event_overflow(struct perf_event
>> *event,
>>                 ret = 1;
>>                 event->pending_kill = POLL_HUP;
>>                 perf_event_disable_inatomic(event);
>> -               event->pmu->stop(event, 0);
>> +
>> +               /*
>> +                * The cpu-clock and task-clock are two special SW events,
>> +                * which rely on the hrtimer. The __perf_event_overflow()
>> +                * is invoked from the hrtimer handler for these 2 events.
>> +                * Avoid to call event_stop()->hrtimer_cancel() for these
>> +                * 2 events since hrtimer_cancel() waits for the hrtimer
>> +                * handler to finish, which would trigger a deadlock.
>> +                * Only disabling the events is enough to stop the hrtimer.
>> +                * See perf_swevent_cancel_hrtimer().
>> +                */
>> +               if (event->attr.config != PERF_COUNT_SW_CPU_CLOCK &&
>> +                   event->attr.config != PERF_COUNT_SW_TASK_CLOCK)
>> +                       event->pmu->stop(event, 0);
> This is broken though; you cannot test config without first knowing
> which PMU you're dealing with.

Ah, yes. Just ignore this.


>
> Also, that timer really should get stopped, we can't know for certain
> this overflow is of the timer itself or not, it could be a related
> event.
>
> Something like the below might do -- but please carefully consider the
> cases where hrtimer_try_to_cancel() might fail; in those cases we'll
> have set HES_STOPPED and the hrtimer callback *SHOULD* observe this and
> NORESTART.
>
> But I didn't check all the details.

The only reason that hrtimer_try_to_cancel() could fail is that the hrtimer
callback is currently executing, so current change should be fine. 


>
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 820127536e62..a91481d57841 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -11756,7 +11756,8 @@ static enum hrtimer_restart perf_swevent_hrtimer(struct hrtimer *hrtimer)
>  
>  	event = container_of(hrtimer, struct perf_event, hw.hrtimer);
>  
> -	if (event->state != PERF_EVENT_STATE_ACTIVE)
> +	if (event->state != PERF_EVENT_STATE_ACTIVE ||
> +	    event->hw.state & PERF_HES_STOPPED)
>  		return HRTIMER_NORESTART;
>  
>  	event->pmu->read(event);
> @@ -11810,7 +11811,7 @@ static void perf_swevent_cancel_hrtimer(struct perf_event *event)
>  		ktime_t remaining = hrtimer_get_remaining(&hwc->hrtimer);
>  		local64_set(&hwc->period_left, ktime_to_ns(remaining));
>  
> -		hrtimer_cancel(&hwc->hrtimer);
> +		hrtimer_try_to_cancel(&hwc->hrtimer);
>  	}
>  }
>  
> @@ -11854,12 +11855,14 @@ static void cpu_clock_event_update(struct perf_event *event)
>  
>  static void cpu_clock_event_start(struct perf_event *event, int flags)
>  {
> +	event->hw.state = 0;
>  	local64_set(&event->hw.prev_count, local_clock());
>  	perf_swevent_start_hrtimer(event);
>  }
>  
>  static void cpu_clock_event_stop(struct perf_event *event, int flags)
>  {
> +	event->hw.state = PERF_HES_STOPPED;
>  	perf_swevent_cancel_hrtimer(event);
>  	if (flags & PERF_EF_UPDATE)
>  		cpu_clock_event_update(event);

Besides cpu-clock, task-clock should need similar change as well. I would
post a complete change later. 



