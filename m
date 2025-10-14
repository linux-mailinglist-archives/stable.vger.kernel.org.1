Return-Path: <stable+bounces-185580-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84024BD797C
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 08:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8A451920F0A
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 06:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617A52D12F3;
	Tue, 14 Oct 2025 06:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f1Nxnvok"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6342D0C7D;
	Tue, 14 Oct 2025 06:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760424060; cv=none; b=g4mtig7wtC41VQpCr/BoQ8XY7/nLrthEDZCOohqxLmV7PJ2w0NG0a2ql2yXQ6a7Y8mEWUHqdZgXeoIAygTQjYpnzmmcP69npQAh5CwSVCcICbfUVFpuEOIG8+pH8CfMizL0S+LO0ywKx5IVmke97VvEEsOf51p9jA8WxxU1LgL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760424060; c=relaxed/simple;
	bh=UbvJP1d+EUOfRQE3e2UPylgXhug4miIG3KQOZgbFdig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YK19MDjM9ibmQ00ad3IZcTq0+84P1tH50eSBh9vY8PFOVMkObPVOu+00c7KXxAxzHmqvjsnwjwjMVec+6su8KcnKoG1NN+wBEdN8XLzT6TmVwybbKuza62sYUUfOyUitjL2BOzczs3AFxIDeVIQvLuMLJma8oAUTz7H33d4T08I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f1Nxnvok; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760424058; x=1791960058;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UbvJP1d+EUOfRQE3e2UPylgXhug4miIG3KQOZgbFdig=;
  b=f1NxnvokfzollGQng6BzBTU7WVgRHQTaaiKCuFr5Ex8B2U56styz3zgB
   LAm+xEQDxhTkikFgw3LkR8NG3E0KIGyTQAYv+EetTEcG4xq268n7P4brQ
   lxr1PmqhJfdbqzGJcOa0h4dCchHSiTfl9nRtuKy43u3YRPDUbOUmXmmQe
   2rK1C1qul3AAmceu4fpaT3rwiQRFF0vGLoKzLVi/pvwEj4wtkQG2J0AD3
   rSP3+jQWzmJuJXvLcbXzGPOiH46+kGE22cad+x1ZEmdNJq6VVXbWgs3UL
   04C+HSdyFEbFrFZ8QBSXVWr6ttULulMDQ9FBuafEsv+3WAa4svSTVZPjJ
   w==;
X-CSE-ConnectionGUID: 4qE7+R4HQsuEwnickZajYw==
X-CSE-MsgGUID: Fl1sRWagRFaUghM+rpgysA==
X-IronPort-AV: E=McAfee;i="6800,10657,11581"; a="85196826"
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; 
   d="scan'208";a="85196826"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 23:40:58 -0700
X-CSE-ConnectionGUID: yNkqmoKJTXutIJYiHYcagQ==
X-CSE-MsgGUID: NgXZOvb3SsO0G3f2x7KRVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; 
   d="scan'208";a="186056301"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.232.209]) ([10.124.232.209])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 23:40:56 -0700
Message-ID: <ad3ef789-3f12-4107-abad-cf7b4775e38d@linux.intel.com>
Date: Tue, 14 Oct 2025 14:40:52 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] bisected: perf: hang when using async-profiler
 caused by perf: Fix the POLL_HUP delivery breakage
To: Octavia Togami <octavia.togami@gmail.com>
Cc: stable@vger.kernel.org, regressions@lists.linux.dev,
 peterz@infradead.org, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org
References: <CAHPNGSQpXEopYreir+uDDEbtXTBvBvi8c6fYXJvceqtgTPao3Q@mail.gmail.com>
 <8aed5e69-57b1-4a01-b90c-56402eb27b37@linux.intel.com>
 <CAHPNGSTgahRhAg5eM=pnn45rw=TJzTz4AfeckcB2RcsPvxCeGg@mail.gmail.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <CAHPNGSTgahRhAg5eM=pnn45rw=TJzTz4AfeckcB2RcsPvxCeGg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 10/13/2025 2:55 PM, Octavia Togami wrote:
> That change appears to fix the problem on my end. I ran my reproducer
> and some other tests multiple times without issue.

@Octavia Thanks for checking this patch. But following Peter's comments, we
need to update the fix. So could you please re-test the below changes? Thanks.

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 7541f6f85fcb..ed236b8bbcaa 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -11773,7 +11773,8 @@ static enum hrtimer_restart
perf_swevent_hrtimer(struct hrtimer *hrtimer)

        event = container_of(hrtimer, struct perf_event, hw.hrtimer);

-       if (event->state != PERF_EVENT_STATE_ACTIVE)
+       if (event->state != PERF_EVENT_STATE_ACTIVE ||
+           event->hw.state & PERF_HES_STOPPED)
                return HRTIMER_NORESTART;

        event->pmu->read(event);
@@ -11827,7 +11828,7 @@ static void perf_swevent_cancel_hrtimer(struct
perf_event *event)
                ktime_t remaining = hrtimer_get_remaining(&hwc->hrtimer);
                local64_set(&hwc->period_left, ktime_to_ns(remaining));

-               hrtimer_cancel(&hwc->hrtimer);
+               hrtimer_try_to_cancel(&hwc->hrtimer);
        }
 }

@@ -11871,12 +11872,14 @@ static void cpu_clock_event_update(struct
perf_event *event)

 static void cpu_clock_event_start(struct perf_event *event, int flags)
 {
+       event->hw.state = 0;
        local64_set(&event->hw.prev_count, local_clock());
        perf_swevent_start_hrtimer(event);
 }

 static void cpu_clock_event_stop(struct perf_event *event, int flags)
 {
+       event->hw.state = PERF_HES_STOPPED;
        perf_swevent_cancel_hrtimer(event);
        if (flags & PERF_EF_UPDATE)
                cpu_clock_event_update(event);
@@ -11950,12 +11953,14 @@ static void task_clock_event_update(struct
perf_event *event, u64 now)

 static void task_clock_event_start(struct perf_event *event, int flags)
 {
+       event->hw.state = 0;
        local64_set(&event->hw.prev_count, event->ctx->time);
        perf_swevent_start_hrtimer(event);
 }

 static void task_clock_event_stop(struct perf_event *event, int flags)
 {
+       event->hw.state = PERF_HES_STOPPED;
        perf_swevent_cancel_hrtimer(event);
        if (flags & PERF_EF_UPDATE)
                task_clock_event_update(event, event->ctx->time);


>
> On Sun, Oct 12, 2025 at 7:34 PM Mi, Dapeng <dapeng1.mi@linux.intel.com> wrote:
>>
>> On 10/11/2025 4:31 PM, Octavia Togami wrote:
>>> Using async-profiler
>>> (https://github.com/async-profiler/async-profiler/) on Linux
>>> 6.17.1-arch1-1 causes a complete hang of the CPU. This has been
>>> reported by many people at https://github.com/lucko/spark/issues/530.
>>> spark is a piece of software that uses async-profiler internally.
>>>
>>> As seen in https://github.com/lucko/spark/issues/530#issuecomment-3339974827,
>>> this was bisected to 18dbcbfabfffc4a5d3ea10290c5ad27f22b0d240 perf:
>>> Fix the POLL_HUP delivery breakage. Reverting this commit on 6.17.1
>>> fixed the issue for me.
>>>
>>> Steps to reproduce:
>>> 1. Get a copy of async-profiler. I tested both v3 (affects older spark
>>> versions) and v4.1 (latest at time of writing). Unarchive it, this is
>>> <async-profiler-dir>.
>>> 2. Set kernel parameters kernel.perf_event_paranoid=1 and
>>> kernel.kptr_restrict=0 as instructed by
>>> https://github.com/async-profiler/async-profiler/blob/fb673227c7fb311f872ce9566769b006b357ecbe/docs/GettingStarted.md
>>> 3. Install a version of Java that comes with jshell, i.e. Java 9 or
>>> newer. Note: jshell is used for ease of reproduction. Any Java
>>> application that is actively running will work.
>>> 4. Run `printf 'int acc; while (true) { acc++; }' | jshell -`. This
>>> will start an infinitely running Java process.
>>> 5. Run `jps` and take the PID next to the text RemoteExecutionControl
>>> -- this is the process that was just started.
>>> 6. Attach async-profiler to this process by running
>>> `<async-profiler-dir>/bin/asprof -d 1 <PID>`. This will run for one
>>> second, then the system should freeze entirely shortly thereafter.
>>>
>>> I triggered a sysrq crash while the system was frozen, and the output
>>> I found in journalctl afterwards is at
>>> https://gist.github.com/octylFractal/76611ee76060051e5efc0c898dd0949e
>>> I'm not sure if that text is actually from the triggered crash, but it
>>> seems relevant. If needed, please tell me how to get the actual crash
>>> report, I'm not sure where it is.
>>>
>>> I'm using an AMD Ryzen 9 5900X 12-Core Processor. Given that I've seen
>>> no Intel reports, it may be AMD specific. I don't have an Intel CPU on
>>> hand to test with.
>>>
>>> /proc/version: Linux version 6.17.1-arch1-1 (linux@archlinux) (gcc
>>> (GCC) 15.2.1 20250813, GNU ld (GNU Binutils) 2.45.0) #1 SMP
>>> PREEMPT_DYNAMIC Mon, 06 Oct 2025 18:48:29 +0000
>>> Operating System: Arch Linux
>>> uname -mi: x86_64 unknown
>> It looks the issue described in the link
>> (https://lore.kernel.org/all/20250606192546.915765-1-kan.liang@linux.intel.com/T/#u)
>> happens again but in a different way. :(
>>
>> As the commit message above link described,  cpu-clock (and task-clock) is
>> a specific SW event which rely on hrtimer. The hrtimer handler calls
>> __perf_event_overflow() and then event_stop (cpu_clock_event_stop()) and
>> eventually call hrtimer_cancel() which traps into a dead loop which waits
>> for the calling hrtimer handler finishes.
>>
>> As the
>> change (https://lore.kernel.org/all/20250606192546.915765-1-kan.liang@linux.intel.com/T/#u),
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
>>                 ret = 1;
>>                 event->pending_kill = POLL_HUP;
>>                 perf_event_disable_inatomic(event);
>> -               event->pmu->stop(event, 0);
>> +
>> +               /*
>> +                * The cpu-clock and task-clock are two special SW events,
>> +                * which rely on the hrtimer. The __perf_event_overflow()
>> +                * is invoked from the hrtimer handler for these 2 events.
>> +                * Avoid to call event_stop()->hrtimer_cancel() for these
>> +                * 2 events since hrtimer_cancel() waits for the hrtimer
>> +                * handler to finish, which would trigger a deadlock.
>> +                * Only disabling the events is enough to stop the hrtimer.
>> +                * See perf_swevent_cancel_hrtimer().
>> +                */
>> +               if (event->attr.config != PERF_COUNT_SW_CPU_CLOCK &&
>> +                   event->attr.config != PERF_COUNT_SW_TASK_CLOCK)
>> +                       event->pmu->stop(event, 0);
>>         }
>>
>>         if (event->attr.sigtrap) {
>>
>>

