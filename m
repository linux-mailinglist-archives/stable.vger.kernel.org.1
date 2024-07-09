Return-Path: <stable+bounces-58745-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 440EE92BA0A
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 14:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A62FEB22030
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 12:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73EA215A874;
	Tue,  9 Jul 2024 12:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Acd2gVpd"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2EB14884D;
	Tue,  9 Jul 2024 12:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720529815; cv=none; b=Db18yoVya0KS8saYiXsASXYzrSIWuEdBag8qokvVXDrohi/jXCQO4ezkaRwKYZq/urcSmMGo281rmyuSYRgciZ3OUtaGtBJHt4jjIShe1zvK2wlKAv6IoNsxg3OlE85wCk8YdGWj86HJuEcDRZFmh6iIggSeSiFG60tejL9rGyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720529815; c=relaxed/simple;
	bh=BpaddSE7W7ZzNVLV1QawEuJbNjvJO6UyBjC9xbreOb0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KuwQGyLr+KCIzBaS7UtaJeX07mITH1DY4nmKd1AantSg4+OOWjHpZAICyrQgwzT3pfnN+yKnDHoMSoKQA7uyOk94KK1w6KvPoFFQQuU/sPLz12dBavLfbSnvvHspVJvDbyae2HpASiCiIzzmWla6NIl1S/jf7pf1EbLOVeIyBdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Acd2gVpd; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720529813; x=1752065813;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BpaddSE7W7ZzNVLV1QawEuJbNjvJO6UyBjC9xbreOb0=;
  b=Acd2gVpdmWFGWrjoU94PezBIBE0rfi6bK0APH6hmH6YWF/Z6PRm9+pFE
   UBnNfIQCCw+U90jMprrlQrhBsdEYWW1G1XJkKNy0Sbxvc/8AcpiIk6cG2
   NxfqtKZyTcWijJAHVoYTnSGK5u9nOrxD1vPNUs9HX4qzhRT42Hnn9k84y
   cEhPracu/tjdS/ap+aiHaYjg1QGAfETr+JqZd6hoM2yS/9TK/GbaG+we6
   bI/6qJWM3iDKIBa1YjnVzMoAYtcY9iXaOpmfDsDJErp3RqYe4dUC4r6xc
   hQn2DLB2MUMhYrhaxiM8lrFfj+K+ZKkzuqKlrdjVqiF6tn5pVfx9oAeKp
   w==;
X-CSE-ConnectionGUID: pXnWLL1lR5SGEeNUzlEKpw==
X-CSE-MsgGUID: q9wRkvUdRvCTuM9F6sxDhQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11127"; a="43203626"
X-IronPort-AV: E=Sophos;i="6.09,195,1716274800"; 
   d="scan'208";a="43203626"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2024 05:56:52 -0700
X-CSE-ConnectionGUID: hvPG8PXASlyDLgBfPEcc5A==
X-CSE-MsgGUID: GKklDMvuRdyarvnRH25HbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,195,1716274800"; 
   d="scan'208";a="52446798"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2024 05:56:52 -0700
Received: from [10.212.46.239] (unknown [10.212.46.239])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 7CF2120B8CFF;
	Tue,  9 Jul 2024 05:56:50 -0700 (PDT)
Message-ID: <7b6f3d35-02fc-46cc-9627-7ce748af5dac@linux.intel.com>
Date: Tue, 9 Jul 2024 08:56:49 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] perf/x86/intel: Add a distinct name for Granite
 Rapids
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@kernel.org, acme@kernel.org, namhyung@kernel.org,
 irogers@google.com, adrian.hunter@intel.com,
 alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
 ak@linux.intel.com, eranian@google.com, Ahmad Yasin <ahmad.yasin@intel.com>,
 stable@vger.kernel.org
References: <20240708193336.1192217-1-kan.liang@linux.intel.com>
 <20240708193336.1192217-3-kan.liang@linux.intel.com>
 <20240709095647.GH27299@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20240709095647.GH27299@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2024-07-09 5:56 a.m., Peter Zijlstra wrote:
> On Mon, Jul 08, 2024 at 12:33:35PM -0700, kan.liang@linux.intel.com wrote:
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> Currently, the Sapphire Rapids and Granite Rapids share the same PMU
>> name, sapphire_rapids. Because from the kernel’s perspective, GNR is
>> similar to SPR. The only key difference is that they support different
>> extra MSRs. The code path and the PMU name are shared.
>>
>> However, from end users' perspective, they are quite different. Besides
>> the extra MSRs, GNR has a newer PEBS format, supports Retire Latency,
>> supports new CPUID enumeration architecture, doesn't required the
>> load-latency AUX event, has additional TMA Level 1 Architectural Events,
>> etc. The differences can be enumerated by CPUID or the PERF_CAPABILITIES
>> MSR. They weren't reflected in the model-specific kernel setup.
>> But it is worth to have a distinct PMU name for GNR.
>>
>> Fixes: a6742cb90b56 ("perf/x86/intel: Fix the FRONTEND encoding on GNR and MTL")
>> Suggested-by: Ahmad Yasin <ahmad.yasin@intel.com>
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>> Cc: stable@vger.kernel.org
>> ---
>>  arch/x86/events/intel/core.c | 9 ++++++---
>>  1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>> index b61367991a16..7a9f931a1f48 100644
>> --- a/arch/x86/events/intel/core.c
>> +++ b/arch/x86/events/intel/core.c
>> @@ -6943,12 +6943,17 @@ __init int intel_pmu_init(void)
>>  	case INTEL_EMERALDRAPIDS_X:
>>  		x86_pmu.flags |= PMU_FL_MEM_LOADS_AUX;
>>  		x86_pmu.extra_regs = intel_glc_extra_regs;
>> +		pr_cont("Sapphire Rapids events, ");
>> +		name = "sapphire_rapids";
>>  		fallthrough;
>>  	case INTEL_GRANITERAPIDS_X:
>>  	case INTEL_GRANITERAPIDS_D:
>>  		intel_pmu_init_glc(NULL);
>> -		if (!x86_pmu.extra_regs)
>> +		if (!x86_pmu.extra_regs) {
>>  			x86_pmu.extra_regs = intel_rwc_extra_regs;
>> +			pr_cont("Granite Rapids events, ");
>> +			name = "granite_rapids";
>> +		}
>>  		x86_pmu.pebs_ept = 1;
>>  		x86_pmu.hw_config = hsw_hw_config;
>>  		x86_pmu.get_event_constraints = glc_get_event_constraints;
>> @@ -6959,8 +6964,6 @@ __init int intel_pmu_init(void)
>>  		td_attr = glc_td_events_attrs;
>>  		tsx_attr = glc_tsx_events_attrs;
>>  		intel_pmu_pebs_data_source_skl(true);
>> -		pr_cont("Sapphire Rapids events, ");
>> -		name = "sapphire_rapids";
>>  		break;
> 
> For some reason this didn't want to apply cleanly (something trivial),
> but since I had to edit it, my fingers slipped and I ended up with the
> below. That ok?

Yes, the patch looks good. Thanks!

Thanks,
Kan
> 
> ---
> Subject: perf/x86/intel: Add a distinct name for Granite Rapids
> From: Kan Liang <kan.liang@linux.intel.com>
> Date: Mon, 8 Jul 2024 12:33:35 -0700
> 
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> Currently, the Sapphire Rapids and Granite Rapids share the same PMU
> name, sapphire_rapids. Because from the kernel’s perspective, GNR is
> similar to SPR. The only key difference is that they support different
> extra MSRs. The code path and the PMU name are shared.
> 
> However, from end users' perspective, they are quite different. Besides
> the extra MSRs, GNR has a newer PEBS format, supports Retire Latency,
> supports new CPUID enumeration architecture, doesn't required the
> load-latency AUX event, has additional TMA Level 1 Architectural Events,
> etc. The differences can be enumerated by CPUID or the PERF_CAPABILITIES
> MSR. They weren't reflected in the model-specific kernel setup.
> But it is worth to have a distinct PMU name for GNR.
> 
> Fixes: a6742cb90b56 ("perf/x86/intel: Fix the FRONTEND encoding on GNR and MTL")
> Suggested-by: Ahmad Yasin <ahmad.yasin@intel.com>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: stable@vger.kernel.org
> Link: https://lkml.kernel.org/r/20240708193336.1192217-3-kan.liang@linux.intel.com
> ---
>  arch/x86/events/intel/core.c |   14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -6788,12 +6788,18 @@ __init int intel_pmu_init(void)
>  	case INTEL_FAM6_EMERALDRAPIDS_X:
>  		x86_pmu.flags |= PMU_FL_MEM_LOADS_AUX;
>  		x86_pmu.extra_regs = intel_glc_extra_regs;
> -		fallthrough;
> +		pr_cont("Sapphire Rapids events, ");
> +		name = "sapphire_rapids";
> +		goto glc_common;
> +
>  	case INTEL_FAM6_GRANITERAPIDS_X:
>  	case INTEL_FAM6_GRANITERAPIDS_D:
> +		x86_pmu.extra_regs = intel_rwc_extra_regs;
> +		pr_cont("Granite Rapids events, ");
> +		name = "granite_rapids";
> +
> +	glc_common:
>  		intel_pmu_init_glc(NULL);
> -		if (!x86_pmu.extra_regs)
> -			x86_pmu.extra_regs = intel_rwc_extra_regs;
>  		x86_pmu.pebs_ept = 1;
>  		x86_pmu.hw_config = hsw_hw_config;
>  		x86_pmu.get_event_constraints = glc_get_event_constraints;
> @@ -6804,8 +6810,6 @@ __init int intel_pmu_init(void)
>  		td_attr = glc_td_events_attrs;
>  		tsx_attr = glc_tsx_events_attrs;
>  		intel_pmu_pebs_data_source_skl(true);
> -		pr_cont("Sapphire Rapids events, ");
> -		name = "sapphire_rapids";
>  		break;
>  
>  	case INTEL_FAM6_ALDERLAKE:
> 

