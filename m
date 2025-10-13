Return-Path: <stable+bounces-184123-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 012FCBD13BB
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 04:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7CA83B9FFF
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 02:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3598827BF6C;
	Mon, 13 Oct 2025 02:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZLrRIuWy"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793DA1F419B;
	Mon, 13 Oct 2025 02:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760322875; cv=none; b=LLnB4Ul1wue77IxtI2d5F5zJMJDUG0ROHkRMVN806+8fK/tz8IywBe4YlTljpfN/chAXwK69rp/HoenXch3sHwQZMMqruUlYR3gJD0EW5s7JGHEbS6h0cYDzcKugedzGOGoslIScUf9Hi0buXVaf/Qxyh1cT9i+zi+L8lXZ0thU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760322875; c=relaxed/simple;
	bh=TSLfs+q7YskGZGNmRTRTUKheW9HvSTtIhUW6NnDpNyE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PAIEZH8JhG2s14Iul5DZj9dsMbMrjjkqrEZphnXfEwpTUr+wL9cPkAR3SDxbmeRUC02FyzyRdoUOXGeDQDj4TRzXP0UjYHRHAT6zFVUO+LxBPahty4sSHWuwpCBjtFbtqc6FjbrELi0t75UN91ChmqrvJraArmpbl2XFBiiNFEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZLrRIuWy; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760322873; x=1791858873;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TSLfs+q7YskGZGNmRTRTUKheW9HvSTtIhUW6NnDpNyE=;
  b=ZLrRIuWyVDUpze04AVNPSAgBYAwi9xJ4EzvmSt9zAQ4qKD/BUOMQPJ5s
   1gsWbPJ2Gbh/E3rcRTdlkX6pSWoEl8lGOgqLV9MG28TbzX6y+wGcFNN3n
   DRcw42QQCywev4pZgtP6uBw96QUvQmFGf/BZ8oOWtfa1YPWDxcBQpGuvr
   lc5UiCDV2PT+Qt6GTDtRoBlrGxqghPJ0JPKxM0QoVYWssWvm5hYd3T+Fj
   KFoDPvhbMD8fncXbFEuF2fMkyzuk1d3mITw2I+SQ/Gv1hA0LNcuI8nDhY
   fEnm8fDaCPMbVhbHgJnNHK3UJojjaMpn2E5/T7w+n4J88pdlT8DJ7eFVa
   w==;
X-CSE-ConnectionGUID: 8kZJKKu1R8K0mmcr5oH9KA==
X-CSE-MsgGUID: vV/ZvF6wTl6otMYqb4lNhg==
X-IronPort-AV: E=McAfee;i="6800,10657,11580"; a="73556159"
X-IronPort-AV: E=Sophos;i="6.19,224,1754982000"; 
   d="scan'208";a="73556159"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2025 19:34:32 -0700
X-CSE-ConnectionGUID: 4fkOBcSDQlKiAeNwM5t4IQ==
X-CSE-MsgGUID: PSSg5rfcSYuxWcMYViWVqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,224,1754982000"; 
   d="scan'208";a="181297334"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.232.209]) ([10.124.232.209])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2025 19:34:30 -0700
Message-ID: <8aed5e69-57b1-4a01-b90c-56402eb27b37@linux.intel.com>
Date: Mon, 13 Oct 2025 10:34:27 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] bisected: perf: hang when using async-profiler
 caused by perf: Fix the POLL_HUP delivery breakage
To: Octavia Togami <octavia.togami@gmail.com>, stable@vger.kernel.org
Cc: regressions@lists.linux.dev, peterz@infradead.org,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <CAHPNGSQpXEopYreir+uDDEbtXTBvBvi8c6fYXJvceqtgTPao3Q@mail.gmail.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <CAHPNGSQpXEopYreir+uDDEbtXTBvBvi8c6fYXJvceqtgTPao3Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 10/11/2025 4:31 PM, Octavia Togami wrote:
> Using async-profiler
> (https://github.com/async-profiler/async-profiler/) on Linux
> 6.17.1-arch1-1 causes a complete hang of the CPU. This has been
> reported by many people at https://github.com/lucko/spark/issues/530.
> spark is a piece of software that uses async-profiler internally.
>
> As seen in https://github.com/lucko/spark/issues/530#issuecomment-3339974827,
> this was bisected to 18dbcbfabfffc4a5d3ea10290c5ad27f22b0d240 perf:
> Fix the POLL_HUP delivery breakage. Reverting this commit on 6.17.1
> fixed the issue for me.
>
> Steps to reproduce:
> 1. Get a copy of async-profiler. I tested both v3 (affects older spark
> versions) and v4.1 (latest at time of writing). Unarchive it, this is
> <async-profiler-dir>.
> 2. Set kernel parameters kernel.perf_event_paranoid=1 and
> kernel.kptr_restrict=0 as instructed by
> https://github.com/async-profiler/async-profiler/blob/fb673227c7fb311f872ce9566769b006b357ecbe/docs/GettingStarted.md
> 3. Install a version of Java that comes with jshell, i.e. Java 9 or
> newer. Note: jshell is used for ease of reproduction. Any Java
> application that is actively running will work.
> 4. Run `printf 'int acc; while (true) { acc++; }' | jshell -`. This
> will start an infinitely running Java process.
> 5. Run `jps` and take the PID next to the text RemoteExecutionControl
> -- this is the process that was just started.
> 6. Attach async-profiler to this process by running
> `<async-profiler-dir>/bin/asprof -d 1 <PID>`. This will run for one
> second, then the system should freeze entirely shortly thereafter.
>
> I triggered a sysrq crash while the system was frozen, and the output
> I found in journalctl afterwards is at
> https://gist.github.com/octylFractal/76611ee76060051e5efc0c898dd0949e
> I'm not sure if that text is actually from the triggered crash, but it
> seems relevant. If needed, please tell me how to get the actual crash
> report, I'm not sure where it is.
>
> I'm using an AMD Ryzen 9 5900X 12-Core Processor. Given that I've seen
> no Intel reports, it may be AMD specific. I don't have an Intel CPU on
> hand to test with.
>
> /proc/version: Linux version 6.17.1-arch1-1 (linux@archlinux) (gcc
> (GCC) 15.2.1 20250813, GNU ld (GNU Binutils) 2.45.0) #1 SMP
> PREEMPT_DYNAMIC Mon, 06 Oct 2025 18:48:29 +0000
> Operating System: Arch Linux
> uname -mi: x86_64 unknown

It looks the issue described in the link
(https://lore.kernel.org/all/20250606192546.915765-1-kan.liang@linux.intel.com/T/#u)
happens again but in a different way. :(

As the commit message above link described,  cpu-clock (and task-clock) is
a specific SW event which rely on hrtimer. The hrtimer handler calls
__perf_event_overflow() and then event_stop (cpu_clock_event_stop()) and
eventually call hrtimer_cancel() which traps into a dead loop which waits
for the calling hrtimer handler finishes.

As the
change (https://lore.kernel.org/all/20250606192546.915765-1-kan.liang@linux.intel.com/T/#u),
it should be enough to just disable the event and don't need an extra event
stop.

@Octavia, could you please check if the change below can fix this issue?
Thanks.

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 7541f6f85fcb..883b0e1fa5d3 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10343,7 +10343,20 @@ static int __perf_event_overflow(struct perf_event
*event,
                ret = 1;
                event->pending_kill = POLL_HUP;
                perf_event_disable_inatomic(event);
-               event->pmu->stop(event, 0);
+
+               /*
+                * The cpu-clock and task-clock are two special SW events,
+                * which rely on the hrtimer. The __perf_event_overflow()
+                * is invoked from the hrtimer handler for these 2 events.
+                * Avoid to call event_stop()->hrtimer_cancel() for these
+                * 2 events since hrtimer_cancel() waits for the hrtimer
+                * handler to finish, which would trigger a deadlock.
+                * Only disabling the events is enough to stop the hrtimer.
+                * See perf_swevent_cancel_hrtimer().
+                */
+               if (event->attr.config != PERF_COUNT_SW_CPU_CLOCK &&
+                   event->attr.config != PERF_COUNT_SW_TASK_CLOCK)
+                       event->pmu->stop(event, 0);
        }

        if (event->attr.sigtrap) {



