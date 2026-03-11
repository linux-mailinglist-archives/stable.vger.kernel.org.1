Return-Path: <stable+bounces-224627-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mHZtAcfNsGkKnQIAu9opvQ
	(envelope-from <stable+bounces-224627-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 03:04:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E7825A9A4
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 03:04:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 839E4306C7F4
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 02:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91233164C5;
	Wed, 11 Mar 2026 02:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FZS0oghd"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AF733987;
	Wed, 11 Mar 2026 02:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773194662; cv=none; b=SvTfFaVshmTB+5ogwUt4GswRG/a4T549z/8BVrHNutGg4Zu7cLEtzyfRc2FDD/ijjiDNvPJG6roGBCKzWak9RqpPsecWN2Yy0XWRwXYlghbCfwjfYMuqJXq9wedZ95/EZrAJoOBOoy9haiy3K/yQ6vfrcp6SlvRGypnD8TP9QH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773194662; c=relaxed/simple;
	bh=tuNIUkv+nBaiu23oHhdDDLb7hyiBMWKegBoRvv8EHkQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kDxmV+/nZhkhbqfW0PIvrme5EpEMIIWFi/siiqhi2SQEAdWQrhSutuyLdQrVw5xIHkpuWYk10HRxB3eoGml7oO/yqR/7D0dylKI4xnjP38EZmTgyIeE37fLd+UGXG+PQhZptwJk5Pgju3R1FzViPsHXxxsSUJ5atNVAc9JxF/x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FZS0oghd; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773194661; x=1804730661;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tuNIUkv+nBaiu23oHhdDDLb7hyiBMWKegBoRvv8EHkQ=;
  b=FZS0oghd6Z675ftvnUglVw+QC3zg9E8O3/UgzRG44ygYPhkJF+ikU/bV
   Yf881aliOS8KQX8FpqAaaMCs1XaIa9djq5imVa0UQ/bgTkucD7uTFGv32
   3DOcXhnaL9vfjjzVzrq/qEOBQdXYdgBrq9tH86/oVWrRLq2Zf+w2RadaB
   Qf9VxK3UdQLk4XWozB4EylOdsi8KxiHG0VsMMyFvcnyPXbba9ZCItWc8s
   giIRFALWhmZPQQKRjRJtlffSgwf1jv/KQ+UYT5aIPN63Yep4UhufKxGVJ
   DA2rb+5+tOnutKLkEvbiSVBuG7VmR6HB0q95TOdGi2vKlOenFFV4q4c1w
   Q==;
X-CSE-ConnectionGUID: v4D2bAaASSuIzUbVeX/ndw==
X-CSE-MsgGUID: waCyBG4+TZONoRMm3YgWcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="61826979"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="61826979"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 19:04:19 -0700
X-CSE-ConnectionGUID: gzD6Yt7gRCyl9im/m4hSFA==
X-CSE-MsgGUID: Q/hdL9z7TQC1GyPdYogNEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="258226895"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 19:04:13 -0700
Message-ID: <a0a1d8ab-85cd-411c-b8e2-9e7e2f7136fd@linux.intel.com>
Date: Wed, 11 Mar 2026 10:04:10 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf/x86: Move event pointer setup earlier in
 x86_pmu_enable()
To: Breno Leitao <leitao@debian.org>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, Thomas Gleixner <tglx@kernel.org>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com, stable@vger.kernel.org
References: <20260310-perf-v2-1-4a3156fce43c@debian.org>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260310-perf-v2-1-4a3156fce43c@debian.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 81E7825A9A4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	TAGGED_FROM(0.00)[bounces-224627-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dapeng1.mi@linux.intel.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,msgid.link:url]
X-Rspamd-Action: no action


On 3/10/2026 6:13 PM, Breno Leitao wrote:
> A production AMD EPYC system crashed with a NULL pointer dereference
> in the PMU NMI handler:
>
>   BUG: kernel NULL pointer dereference, address: 0000000000000198
>   RIP: x86_perf_event_update+0xc/0xa0
>   Call Trace:
>    <NMI>
>    amd_pmu_v2_handle_irq+0x1a6/0x390
>    perf_event_nmi_handler+0x24/0x40
>
> The faulting instruction is `cmpq $0x0, 0x198(%rdi)` with RDI=0,
> corresponding to the `if (unlikely(!hwc->event_base))` check in
> x86_perf_event_update() where hwc = &event->hw and event is NULL.
>
> drgn inspection of the vmcore on CPU 106 showed a mismatch between
> cpuc->active_mask and cpuc->events[]:
>
>   active_mask: 0x1e (bits 1, 2, 3, 4)
>   events[1]:   0xff1100136cbd4f38  (valid)
>   events[2]:   0x0                 (NULL, but active_mask bit 2 set)
>   events[3]:   0xff1100076fd2cf38  (valid)
>   events[4]:   0xff1100079e990a90  (valid)
>
> The event that should occupy events[2] was found in event_list[2]
> with hw.idx=2 and hw.state=0x0, confirming x86_pmu_start() had run
> (which clears hw.state and sets active_mask) but events[2] was
> never populated.
>
> Another event (event_list[0]) had hw.state=0x7 (STOPPED|UPTODATE|ARCH),
> showing it was stopped when the PMU rescheduled events, confirming the
> throttle-then-reschedule sequence occurred.
>
> The root cause is commit 7e772a93eb61 ("perf/x86: Fix NULL event access
> and potential PEBS record loss") which moved the cpuc->events[idx]
> assignment out of x86_pmu_start() and into step 2 of x86_pmu_enable(),
> after the PERF_HES_ARCH check. This broke any path that calls
> pmu->start() without going through x86_pmu_enable() -- specifically
> the unthrottle path:
>
>   perf_adjust_freq_unthr_events()
>     -> perf_event_unthrottle_group()
>       -> perf_event_unthrottle()
>         -> event->pmu->start(event, 0)
>           -> x86_pmu_start()     // sets active_mask but not events[]
>
> The race sequence is:
>
>   1. A group of perf events overflows, triggering group throttle via
>      perf_event_throttle_group(). All events are stopped: active_mask
>      bits cleared, events[] preserved (x86_pmu_stop no longer clears
>      events[] after commit 7e772a93eb61).
>
>   2. While still throttled (PERF_HES_STOPPED), x86_pmu_enable() runs
>      due to other scheduling activity. Stopped events that need to
>      move counters get PERF_HES_ARCH set and events[old_idx] cleared.
>      In step 2 of x86_pmu_enable(), PERF_HES_ARCH causes these events
>      to be skipped -- events[new_idx] is never set.
>
>   3. The timer tick unthrottles the group via pmu->start(). Since
>      commit 7e772a93eb61 removed the events[] assignment from
>      x86_pmu_start(), active_mask[new_idx] is set but events[new_idx]
>      remains NULL.
>
>   4. A PMC overflow NMI fires. The handler iterates active counters,
>      finds active_mask[2] set, reads events[2] which is NULL, and
>      crashes dereferencing it.
>
> Move the cpuc->events[hwc->idx] assignment in x86_pmu_enable() to
> before the PERF_HES_ARCH check, so that events[] is populated even
> for events that are not immediately started. This ensures the
> unthrottle path via pmu->start() always finds a valid event pointer.
>
> Fixes: 7e772a93eb61 ("perf/x86: Fix NULL event access and potential PEBS record loss")
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Cc: stable@vger.kernel.org
> ---
> Changes in v2:
> - Move event pointer setup earlier in x86_pmu_enable() (peterz)
> - Rewrote the patch title, given the new approach
> - Link to v1: https://patch.msgid.link/20260309-perf-v1-1-601ffb531893@debian.org
> ---
>  arch/x86/events/core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index 03ce1bc7ef2ea..54b4c315d927f 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -1372,6 +1372,8 @@ static void x86_pmu_enable(struct pmu *pmu)
>  			else if (i < n_running)
>  				continue;
>  
> +			cpuc->events[hwc->idx] = event;
> +
>  			if (hwc->state & PERF_HES_ARCH)
>  				continue;
>  
> @@ -1379,7 +1381,6 @@ static void x86_pmu_enable(struct pmu *pmu)
>  			 * if cpuc->enabled = 0, then no wrmsr as
>  			 * per x86_pmu_enable_event()
>  			 */
> -			cpuc->events[hwc->idx] = event;
>  			x86_pmu_start(event, PERF_EF_RELOAD);
>  		}
>  		cpuc->n_added = 0;

Just think twice, it seems the change could slightly break the logic of
current PEBS counter snapshot logic. 

Currently the function intel_perf_event_update_pmc() needs to filter out
these uninitialized counter by checking if the event is NULL as below
comments and code show.

```

     * - An event is stopped for some reason, e.g., throttled.
     *   During this period, another event is added and takes the
     *   counter of the stopped event. The stopped event is assigned
     *   to another new and uninitialized counter, since the
     *   x86_pmu_start(RELOAD) is not invoked for a stopped event.
     *   The PEBS__DATA_CFG is updated regardless of the event state.
     *   The uninitialized counter can be recorded in a PEBS record.
     *   But the cpuc->events[uninitialized_counter] is always NULL,
     *   because the event is stopped. The uninitialized value is
     *   safely dropped.
     */
    if (!event)
        return;

```

Once we have this change, then the original index of a stopped event could
be assigned to a new event. In these case, although the new event is still
not activated, the cpuc->events[original_index] has been initialized and
won't be NULL. So intel_perf_event_update_pmc() could update the cached
count value to wrong event.

I suppose we have two ways to fix this issue.

1. Move "cpuc->events[idx] = event" into x86_pmu_start(), just like what
the v1 patch does.

2. Check cpuc->active_mask in intel_perf_event_update_pmc() as well, but
the side effect is that the cached counter snapshots for the stopped events
have to be dropped and it has no chance to update the count value for these
stopped events even though the HW index of these stopped events are not
occupied by other new events.

Peter, how's your idea on this? Thanks.


>
> ---
> base-commit: 0bcac7b11262557c990da1ac564d45777eb6b005
> change-id: 20260309-perf-fd32da0317a8
>
> Best regards,
> --  
> Breno Leitao <leitao@debian.org>
>

