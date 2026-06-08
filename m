Return-Path: <stable+bounces-261943-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OFfNA/gcJmrBSQIAu9opvQ
	(envelope-from <stable+bounces-261943-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 08 Jun 2026 03:38:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 079E36521D6
	for <lists+stable@lfdr.de>; Mon, 08 Jun 2026 03:37:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=kIt7AGDR;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261943-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-261943-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 37B383002519
	for <lists+stable@lfdr.de>; Mon,  8 Jun 2026 01:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA012F5A29;
	Mon,  8 Jun 2026 01:37:52 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88634071CF;
	Mon,  8 Jun 2026 01:37:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780882672; cv=none; b=WVlJVsKPomUikaJaD1Uu4eyyjEcwNYQF5Qx7EFMH0CHxJ2qf5AktcoACyGVZyyl+0DZR1hg56TklDD0/XKDZ9rrzonBwySVZFxcyjfe6H3UfNGw1RA44ZyRetRf5ainTXD1DoNgEN6PXHFC7I8lKn1ORGago9F5kqbfAGwer6AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780882672; c=relaxed/simple;
	bh=fHlma5KECpLohBaWFsPmgwtR8FBoBLwy9+VgTW1777I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JF7KzbObnelTGntM9Bx4QZlQ5ePuZiQ8pEm3JazYVpjKgi0KPTbvHQDGy4SQaHYOq4VccU66vZxBo+2TcL2+PjOXDzEh1MzCoZEe8z6ENjZ7sZaAiELUctg2AQEnEJR87G4oIJMKD3KYL4qm+WdfdOixt5gnXgFjPnoX0eLrSvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kIt7AGDR; arc=none smtp.client-ip=198.175.65.18
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780882670; x=1812418670;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fHlma5KECpLohBaWFsPmgwtR8FBoBLwy9+VgTW1777I=;
  b=kIt7AGDROnTkywIpUrzB/6aSTMw3TVwfgnMhcdHyh8LZTqWv55vjNDF3
   7D6s9cqFGGVUPkOOrpk5ONARaNabNElpSestiHnkPIkVXP4sb8wVZidZE
   qzKTz3bZ4ZgbR86uaPynAQKE1tQZGDFHvgxEvgpM2nbTs4cX5eo3F5hPx
   NxUQzsj4C5YKkBzuhKWapcQf1lOierqiNWsi4u3ia8UKOO5o9cJ1JO+Qe
   mOtU+/3WqDNrHwEJqfbNZQ5Ua/b2BiABHMFgtH2DovPI1Z5iKJo9SgyBJ
   1pKVq6PcyVCo/qpU4G6dGrD/3lPVMbUndH/eLubdEEypOlE0eiynTUOap
   Q==;
X-CSE-ConnectionGUID: r+I7UjsSReGbKWFhcCIgLA==
X-CSE-MsgGUID: uaRgNERmQySi1g8h3oztQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11810"; a="81673773"
X-IronPort-AV: E=Sophos;i="6.24,193,1774335600"; 
   d="scan'208";a="81673773"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2026 18:37:49 -0700
X-CSE-ConnectionGUID: Tg7nJ1DdSbSxi/i/x/m1XQ==
X-CSE-MsgGUID: QUseja+xTHaAejQREFo8Pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,193,1774335600"; 
   d="scan'208";a="240956870"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2026 18:37:45 -0700
Message-ID: <4a2bdb92-11b5-46ab-83a4-9b58e71ca581@linux.intel.com>
Date: Mon, 8 Jun 2026 09:37:43 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] perf/x86/intel: Remove anythread_deprecated bit from
 perf_capabilities
To: "Falcon, Thomas" <thomas.falcon@intel.com>,
 "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
 "ak@linux.intel.com" <ak@linux.intel.com>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "acme@kernel.org" <acme@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
 "Hunter, Adrian" <adrian.hunter@intel.com>,
 "namhyung@kernel.org" <namhyung@kernel.org>, "Rogers, Ian"
 <irogers@google.com>, "Eranian, Stephane" <eranian@google.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "Chen, Zide" <zide.chen@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
 "Mi, Dapeng1" <dapeng1.mi@intel.com>, "Hao, Xudong" <xudong.hao@intel.com>
References: <20260605011136.2043393-1-dapeng1.mi@linux.intel.com>
 <20260605011136.2043393-2-dapeng1.mi@linux.intel.com>
 <7fdb17e042719f77c382cbc47be2def2cda1bf51.camel@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <7fdb17e042719f77c382cbc47be2def2cda1bf51.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261943-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:thomas.falcon@intel.com,m:alexander.shishkin@linux.intel.com,m:ak@linux.intel.com,m:peterz@infradead.org,m:acme@kernel.org,m:mingo@redhat.com,m:adrian.hunter@intel.com,m:namhyung@kernel.org,m:irogers@google.com,m:eranian@google.com,m:stable@vger.kernel.org,m:zide.chen@intel.com,m:linux-kernel@vger.kernel.org,m:linux-perf-users@vger.kernel.org,m:dapeng1.mi@intel.com,m:xudong.hao@intel.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[dapeng1.mi@linux.intel.com,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[intel.com:+];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dapeng1.mi@linux.intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email,intel.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 079E36521D6


On 6/6/2026 1:04 AM, Falcon, Thomas wrote:
> On Fri, 2026-06-05 at 09:11 +0800, Dapeng Mi wrote:
>> AnyThread mode deprecation is enumerated by CPUID.0AH:EDX[15] instead
>> of
>> PERF_CAPABILITIES MSR. It's not a good practice to define a bit to
>> represent "anythread deprecation" in perf_capabilities. It leads to
>> the
>> anythread_deprecated bit could be overwritten by the real value of
>> PERF_CAPABILITIES MSR, just like the below code in update_pmu_cap()
>> does.
>>
>> ```
>> if (!intel_pmu_broken_perf_cap()) {
>> 	/* Perf Metric (Bit 15) and PEBS via PT (Bit 16) are hybrid
>> enumeration */
>> 	rdmsrq(MSR_IA32_PERF_CAPABILITIES, hybrid(pmu,
>> intel_cap).capabilities);
>> }
>> ```
>>
>> It leads to the anythread_deprecated bit is cleared to 0 and the
>> "any"
>> attribute is incorrectly shown in the /sys/devices/cpu/format/ folder
>> on
>> these support Perfmon v6 platforms, like Clearwater Forest.
>>
>> ```
>> $grep . /sys/devices/cpu/format/*
>> /sys/devices/cpu/format/acr_mask:config2:0-63
>> /sys/devices/cpu/format/any:config:21
>> /sys/devices/cpu/format/cmask:config:24-31
>> ```
>>
>> So remove the anythread_deprecated bit from perf_capabilities
>> structure
>> and directly depends on CPUID.0AH:EDX[15] to judge if anythread is
>> deprecated.
>>
>> Cc: stable@vger.kernel.org
>> Reported-by: Namhyung Kim <namhyung@kernel.org>
>> Fixes: cadbaa039b99 ("perf/x86/intel: Make anythread filter support
>> conditional")
>> Acked-by: Namhyung Kim <namhyung@kernel.org>
>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> Reviewed-by: Zide Chen <zide.chen@intel.com>
>> ---
>>
>> Original patch link:
>> https://lore.kernel.org/all/20260423053306.3033331-1-dapeng1.mi@linux.intel.com/
>>
>>  arch/x86/events/intel/core.c | 10 +++-------
>>  arch/x86/events/perf_event.h |  2 +-
>>  2 files changed, 4 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/x86/events/intel/core.c
>> b/arch/x86/events/intel/core.c
>> index 0217e701aeeb..ea3ab3050a3b 100644
>> --- a/arch/x86/events/intel/core.c
>> +++ b/arch/x86/events/intel/core.c
>> @@ -7946,12 +7946,6 @@ __init int intel_pmu_init(void)
>>  
>>  	x86_add_quirk(intel_arch_events_quirk); /* Install first, so
>> it runs last */
>>  
>> -	if (version >= 5) {
>> -		x86_pmu.intel_cap.anythread_deprecated =
>> edx.split.anythread_deprecated;
>> -		if (x86_pmu.intel_cap.anythread_deprecated)
>> -			pr_cont(" AnyThread deprecated, ");
>> -	}
>> -
>>  	/* The perf side of core PMU is ready to support the
>> mediated vPMU. */
>>  	x86_get_pmu(smp_processor_id())->capabilities |=
>> PERF_PMU_CAP_MEDIATED_VPMU;
>>  
>> @@ -8828,8 +8822,10 @@ __init int intel_pmu_init(void)
>>  				      &x86_pmu.intel_ctrl);
>>  
>>  	/* AnyThread may be deprecated on arch perfmon v5 or later
>> */
>> -	if (x86_pmu.intel_cap.anythread_deprecated)
>> +	if (version >= 5 && edx.split.anythread_deprecated) {
>>  		x86_pmu.format_attrs = intel_arch_formats_attr;
>> +		pr_cont("AnyThread deprecated, ");
> Is there a reason the leading space is missing here? Other than that,
> LGTM.

It's removed intentionally. The leading space is unnecessary and seems to
be long-term typo.

Thanks.


>
> Reviewed-by: Thomas Falcon <thomas.falcon@intel.com>
>
>> +	}
>>  
>>  	intel_pmu_check_event_constraints_all(NULL);
>>  
>> diff --git a/arch/x86/events/perf_event.h
>> b/arch/x86/events/perf_event.h
>> index eae24bb35dc1..5902a297daa1 100644
>> --- a/arch/x86/events/perf_event.h
>> +++ b/arch/x86/events/perf_event.h
>> @@ -668,7 +668,7 @@ union perf_capabilities {
>>  		u64	perf_metrics:1;
>>  		u64	pebs_output_pt_available:1;
>>  		u64	pebs_timing_info:1;
>> -		u64	anythread_deprecated:1;
>> +		u64	__reserved:1;
>>  		u64	rdpmc_metrics_clear:1;
>>  	};
>>  	u64	capabilities;

