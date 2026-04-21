Return-Path: <stable+bounces-240016-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0N0QKBTK5ml40wEAu9opvQ
	(envelope-from <stable+bounces-240016-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 02:51:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E654352A6
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 02:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3FE473013EFF
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 00:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A211A681C;
	Tue, 21 Apr 2026 00:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AJJdheIR"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9784540DFA1;
	Tue, 21 Apr 2026 00:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776732685; cv=none; b=FvG5evL7JOxdiTsuFL1trkS5WUANuuOWnyPQ/mBDhXunMmRZBpYuwMengYXmNh+8/N0mtCDcUOUP7ugXJChwB+APq1RPLyB7VdJsAzrnrZ2J2g8hQQVdUO0MSaUTJlnoG3HFGQOBbWQO1J3bc9hiQ20gFL1dwpPlmu4+EIU8j5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776732685; c=relaxed/simple;
	bh=7xsug3MzVT3sa/rbi3MyvHMTLTWa19C7FdsnVZB5LBA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jzvAA5YZVpXtLyN1Qu+djeJ0g7Q1g9EwgajC77VMZLfhVwlF6Z8KzpNuqom0Mw+YyPP9Aei/rGG24pD2R8w1WqSvBc0qwQ2dV7GD+Z1LjB09L6voXz1DWngKjSZ0T+vhVhRj+Th58OvOXddHokPAtc1l6FraGQQceWlvhhFgYPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AJJdheIR; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776732684; x=1808268684;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7xsug3MzVT3sa/rbi3MyvHMTLTWa19C7FdsnVZB5LBA=;
  b=AJJdheIR8YorGGhH63Fkz1JzIFD24DAX2O0L5ZgRhczm0XdM7JPAi5hk
   0+zaSW20Uq+EFX8+iMiMuluvGDaPQ3ylN2+tCZv1ecmtTL9Cfb8ViaVOv
   hZg+Uzhh1loUR8fLdbN+PgLVBnF0X1R/LrRsvzpeabyKdIALSb1hI/xTc
   m1wT+58Z5drxjrexZMqns+7Inttqxdwx0yesZG/t3ofDV5pRPYBXUa0Aj
   AadDSHepzCDufVNuRIdBgIERRxdaHCGgWf3dt702Xwp/wgLnuQLCgMOXP
   ad10tHi2iL69XAqN8lh7seyngW9xY3JKa9DrxP4BqZZeFmyEFy83YVmyl
   A==;
X-CSE-ConnectionGUID: zV76Ew5gR6GDMGJVIIxcfQ==
X-CSE-MsgGUID: +33yshXcS1aDL123Nlo2qw==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="100317720"
X-IronPort-AV: E=Sophos;i="6.23,190,1770624000"; 
   d="scan'208";a="100317720"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 17:51:24 -0700
X-CSE-ConnectionGUID: 9VrBqzQ4TbSEK5ZV2rsACw==
X-CSE-MsgGUID: AGT141nnSWCAA/hZYbzhIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,190,1770624000"; 
   d="scan'208";a="228718544"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 17:51:19 -0700
Message-ID: <d93ccac4-d1c6-4d56-9714-33a32e5c4f48@linux.intel.com>
Date: Tue, 21 Apr 2026 08:51:16 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/x86/intel: Remove anythread_deprecated bit from
 perf_capabilities
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Zide Chen <zide.chen@intel.com>,
 Falcon Thomas <thomas.falcon@intel.com>, Xudong Hao <xudong.hao@intel.com>,
 stable@vger.kernel.org
References: <20260415021010.1248083-1-dapeng1.mi@linux.intel.com>
 <aeaZUZyILpy6HKnJ@google.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <aeaZUZyILpy6HKnJ@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-240016-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dapeng1.mi@linux.intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.intel.com:mid]
X-Rspamd-Queue-Id: 67E654352A6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 4/21/2026 5:23 AM, Namhyung Kim wrote:
> On Wed, Apr 15, 2026 at 10:10:10AM +0800, Dapeng Mi wrote:
>> AnyThread mode deprecation is enumerated by CPUID.0AH:EDX[15] instead of
>> PERF_CAPABILITIES MSR. It's not a good practice to define a bit to
>> represent "anythread deprecation" in perf_capabilities. It leads to the
>> anythread_deprecated bit could be overwritten by the real value of
>> PERF_CAPABILITIES MSR, just like the below code in update_pmu_cap() does.
>>
>> ```
>> if (!intel_pmu_broken_perf_cap()) {
>> 	/* Perf Metric (Bit 15) and PEBS via PT (Bit 16) are hybrid enumeration */
>> 	rdmsrq(MSR_IA32_PERF_CAPABILITIES, hybrid(pmu, intel_cap).capabilities);
>> }
>> ```
>>
>> It leads to the anythread_deprecated bit is cleared to 0 and the "any"
>> attribute is incorrectly shown in the /sys/devices/cpu/format/ folder on
>> these support Perfmon v6 platforms, like Clearwater Forest.
>>
>> ```
>> $grep . /sys/devices/cpu/format/*
>> /sys/devices/cpu/format/acr_mask:config2:0-63
>> /sys/devices/cpu/format/any:config:21
>> /sys/devices/cpu/format/cmask:config:24-31
>> ```
>>
>> So remove the anythread_deprecated bit from perf_capabilities structure
>> and directly depends on CPUID.0AH:EDX[15] to judge if anythread is
>> deprecated.
>>
>> Cc: stable@vger.kernel.org
>> Reported-by: Namhyung Kim <namhyung@kernel.org>
>> Fixes: cadbaa039b99 ("perf/x86/intel: Make anythread filter support conditional")
>> Acked-by: Namhyung Kim <namhyung@kernel.org>
>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> ---
>>  arch/x86/events/intel/core.c | 9 +++------
>>  arch/x86/events/perf_event.h | 2 +-
>>  2 files changed, 4 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>> index 793335c3ce78..450c63165a22 100644
>> --- a/arch/x86/events/intel/core.c
>> +++ b/arch/x86/events/intel/core.c
>> @@ -7612,11 +7612,8 @@ __init int intel_pmu_init(void)
>>  
>>  	x86_add_quirk(intel_arch_events_quirk); /* Install first, so it runs last */
>>  
>> -	if (version >= 5) {
>> -		x86_pmu.intel_cap.anythread_deprecated = edx.split.anythread_deprecated;
>> -		if (x86_pmu.intel_cap.anythread_deprecated)
>> -			pr_cont(" AnyThread deprecated, ");
>> -	}
>> +	if (version >= 5 && edx.split.anythread_deprecated)
>> +		pr_cont(" AnyThread deprecated, ");
>>  
>>  	/* The perf side of core PMU is ready to support the mediated vPMU. */
>>  	x86_get_pmu(smp_processor_id())->capabilities |= PERF_PMU_CAP_MEDIATED_VPMU;
>> @@ -8467,7 +8464,7 @@ __init int intel_pmu_init(void)
>>  				      &x86_pmu.intel_ctrl);
>>  
>>  	/* AnyThread may be deprecated on arch perfmon v5 or later */
>> -	if (x86_pmu.intel_cap.anythread_deprecated)
>> +	if (edx.split.anythread_deprecated)
> Do we need to check the version here as well?

hmm, it should be enough to only check the CPUID
"edx.split.anythread_deprecated" bit  in practice. But if we want to follow
the SDM 100%, the version check should be added here.

I would add an version check here. Thanks.


>
> Thanks,
> Namhyung
>
>
>>  		x86_pmu.format_attrs = intel_arch_formats_attr;
>>  

