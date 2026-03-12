Return-Path: <stable+bounces-224780-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id vcW+CQcbsmnjIgAAu9opvQ
	(envelope-from <stable+bounces-224780-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 02:46:47 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 756AD26BFE8
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 02:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D07E306160B
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 01:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866E73750DE;
	Thu, 12 Mar 2026 01:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fxjyI7vS"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94EC12820C6;
	Thu, 12 Mar 2026 01:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773279993; cv=none; b=FttIf1AGQ7jNEnc24Cp9HKNMs9++U4Kuc0+EHwP5f+5sHExhRWp5jPSFLvNtQNEgSiXRMIOS32DHVT64qnohDx9YX59GK0HDJApf1lDn4cK0qFbKFCnPejHgztedLQvkbG0JRVakLrU9lLrZIiDGudDQFI0UQsCNnoZiX7aEux8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773279993; c=relaxed/simple;
	bh=YVMTsCpUknRm8seB/lZR+5bmbilX60hT8sRjcsOU0DY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fUnnWXKcJi/D2vTmmUHMsKylxa9W2LIT+huVWyGWZ2eHA/No16sDRN+Rq7dUf9N7nkKuj08AF58RMJDWw8KWcJpB0hkDA4EwTU481aq1VPG0MmLJNDUhYqZLQug13b9exYx5yazWkRgBmpmburKy0SLH32hdwH9dbiWIMTmAyt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fxjyI7vS; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773279992; x=1804815992;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=YVMTsCpUknRm8seB/lZR+5bmbilX60hT8sRjcsOU0DY=;
  b=fxjyI7vSdukD0yMzdrhdX+St39JQ3rJM7AZpRR7XMM0+h4LSIxNVM6UM
   OKo+Xdk37lGZ2fkESkJraTzWudGFn5zank+UP2TgwTiwU0iW8PY4iPSbE
   m1oKwkjTymW2gpyYgYnJX6pEVK/s7j0Xd0QKAifp0gyIeUNhdjqXt1IOs
   SL9TBDVl926nNCIAs5DrJ7HDrO5nbdVXRq7zXRP0Lgvl0SZe5NhcfNqHI
   Keg6e7hFa6o2o0MmcNEbvhXUV+McBKlldZTAcjY4ZuwinEzHoj+HinuNt
   2MQibUrdAgeVS18RN4M8LR1hQ2i5egmPD8vB94S6PCyJsCq+W3cnUjl7r
   w==;
X-CSE-ConnectionGUID: +PpOrGh+Tjm+wglwQnYSHg==
X-CSE-MsgGUID: 4Wja1aU4Sl241OOyNSfn0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11726"; a="76973742"
X-IronPort-AV: E=Sophos;i="6.23,115,1770624000"; 
   d="scan'208";a="76973742"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 18:46:31 -0700
X-CSE-ConnectionGUID: kpLvnhOkQIWjTWz0ibo3tA==
X-CSE-MsgGUID: wrNx/MB9Rmmc1SsGSpzISA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,115,1770624000"; 
   d="scan'208";a="251158990"
Received: from unknown (HELO [10.238.3.214]) ([10.238.3.214])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 18:46:25 -0700
Message-ID: <9b39df21-c35a-42b0-9e1f-ad7aec6a636c@linux.intel.com>
Date: Thu, 12 Mar 2026 09:46:23 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf/x86: Move event pointer setup earlier in
 x86_pmu_enable()
To: Peter Zijlstra <peterz@infradead.org>, Ian Rogers <irogers@google.com>
Cc: Breno Leitao <leitao@debian.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 James Clark <james.clark@linaro.org>, Thomas Gleixner <tglx@kernel.org>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com, stable@vger.kernel.org
References: <20260310-perf-v2-1-4a3156fce43c@debian.org>
 <a0a1d8ab-85cd-411c-b8e2-9e7e2f7136fd@linux.intel.com>
 <CAP-5=fWAzaKNO0wmAA89ovJLFgxCWQ3khnyWFotnaSAGiugv+A@mail.gmail.com>
 <20260311173509.GR606826@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260311173509.GR606826@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	TAGGED_FROM(0.00)[bounces-224780-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dapeng1.mi@linux.intel.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,linux.intel.com:mid]
X-Rspamd-Queue-Id: 756AD26BFE8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 3/12/2026 1:35 AM, Peter Zijlstra wrote:
> On Wed, Mar 11, 2026 at 09:37:08AM -0700, Ian Rogers wrote:
>
>> Fwiw, an AI review was saying something similar to me. 
> How do you guys get this AI stuff to say anything sensible at all about
> the code? Every time I try, it is telling me the most abject nonsense.
> I've wasted hours of my life trying to guide it to known bugs, in vain.

Base on my experience, the quality of AI generated comments are impacted by
2 factors, one is the AI model, the other is prompt.

Currently I use Github copilot (Claude model) to do some AI reviews. Claude
seems to be the best model for reviewing. Although most of AI review
comments are not 100% accurate, it indeed can point out some potential
issues or gave some clue about the issues. 

About the Prompt, there is a project
https://github.com/masoncl/review-prompts which gathers the review prompt
for Linux kernel. I learnt a lot prompts from it. 


>
>> I wonder if the
>> issue with NMI storms exists already via another path:
>>
>> By populating cpuc->events[idx] here, even for events that skip
>> x86_pmu_start() due to the PERF_HES_ARCH check, can this lead to PEBS
>> data corruption?
>>
>> For Intel PEBS, intel_pmu_pebs_late_setup() iterates over cpuc->event_list
>> and enables PEBS_DATA_CFG for this counter index regardless of its stopped
>> state. If the PMU hardware generates PEBS records for this uninitialized
>> counter, or if there are leftover PEBS records from the counter's previous
>> occupant (since x86_pmu_stop() does not drain the PEBS buffer),
>> intel_perf_event_update_pmc() will now find a non-NULL event pointer.
>> Will it incorrectly process these leftover records and attribute them
>> to the stopped event?
> Yes.
>
>> Additionally, does this change leave the unthrottled event's hardware
>> counter uninitialized?
> Also yes.
>
>> When x86_pmu_enable() moves a throttled event to a new counter, it sets
>> PERF_HES_ARCH and skips calling x86_pmu_start(event, PERF_EF_RELOAD).
>> Later, when the timer tick unthrottles the event, it calls
>> perf_event_unthrottle(), which invokes event->pmu->start(event, 0).
>> In x86_pmu_start(), because flags == 0 (lacking PERF_EF_RELOAD),
>> x86_pmu_set_period() is skipped. Will the newly assigned hardware counter
>> be enabled without being programmed with the event's period, potentially
>> causing it to start from a garbage value and leading to incorrect sampling
>> intervals or NMI storms?
> Don't think you can get NMI storms this way. If the PMI trips, we'll do
> set_period and that should fix it up.
>
> So just wrong counting.

