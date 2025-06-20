Return-Path: <stable+bounces-155176-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20BDCAE218F
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 19:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34C166A36B0
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 17:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC632F3625;
	Fri, 20 Jun 2025 17:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hRnmX8U4"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68962F2733;
	Fri, 20 Jun 2025 17:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750441554; cv=none; b=Pa8brITB+G8nA/WI17RDWJf/FcfTGZDg41OH9oRpB86v7dAQo22242fECVt2AdkVqgblGTTUfBRtsYMPpoS3og577957NkpD7Kpmv0sVuaXMiwu6CRpssilSoC+ubGEvEd9AYbH5rZG1GZihW//y3O+nOrBZ2le+yAYd8FyFgzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750441554; c=relaxed/simple;
	bh=Q5xcuc5LpUVIJp7rJ+mvTGK/9L6VUKk8iNuSXuyBZpQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gvnFjkdJZHWT+kI5vxLSN9hVHR6mhwnEvN5xvP8GIhsVRgKXKsId/KSl0+J67f5m6cn9B9U9aweEVPblqQ4saKzzzq0/GM7HUevtvvdOX3PBjYrBqBs/aK570ofKkpKRzV+cZSezVohP4tML2vyPUVovrKp1rl/0PIwMvnAZGq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hRnmX8U4; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750441553; x=1781977553;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Q5xcuc5LpUVIJp7rJ+mvTGK/9L6VUKk8iNuSXuyBZpQ=;
  b=hRnmX8U4EZ8LOdNWF58qAP8rkCJ/6IflhS6aajYO1CYyPxoxo/LO4fi4
   OTFpwb40fn42bnZW0ZdsvdJDZxMpEjeYYuYFIUlztF+gLPGrziDxA/LKv
   lJK/mrvXt/RCFETgaEoGttYAyF+5MnlMbxjfg0HQ+3zCke/a0QHEDRXND
   gbdHRhkpjnxOnF5hVADE1T3cW5QxpGATl7tRpUXCqPAq6B1YCWg8KEvfJ
   Pqv5B4WNuXU8j1/eZXo2Bjh+dFoD2WDvawlbfC6GflKfh8LmVnmivtTKs
   IFER70x1TwlCZhjJvLy4NN/cXRkWfyUWFmVKpTGY5m1/6a+pOY9LywwkI
   A==;
X-CSE-ConnectionGUID: HQvVh0i7T6uxDqmZvAC6+w==
X-CSE-MsgGUID: 23iN9X3vTyePkb5ft0OtTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="51829067"
X-IronPort-AV: E=Sophos;i="6.16,252,1744095600"; 
   d="scan'208";a="51829067"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2025 10:45:52 -0700
X-CSE-ConnectionGUID: ih5UK2r6Tu68RTd+c9HBSw==
X-CSE-MsgGUID: uZhv6h3ZQsOyY1fiai1NUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,252,1744095600"; 
   d="scan'208";a="151272219"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2025 10:45:52 -0700
Received: from [10.246.136.52] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id A10EB20B5736;
	Fri, 20 Jun 2025 10:45:50 -0700 (PDT)
Message-ID: <bbdb6e1a-546a-4ed9-9d91-8d334fd5cc7b@linux.intel.com>
Date: Fri, 20 Jun 2025 13:45:49 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/x86/intel: Fix unchecked PEBS_ENABLE MSR access
 error
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
 namhyung@kernel.org, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org
Cc: Vince Weaver <vincent.weaver@maine.edu>, stable@vger.kernel.org
References: <20250620110406.3782402-1-kan.liang@linux.intel.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20250620110406.3782402-1-kan.liang@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Peter and Ingo,

On 2025-06-20 7:04 a.m., kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> perf_fuzzzer reported an unchecked MSR access error.
> 
> [12646.001692] unchecked MSR access error: WRMSR to 0x3f1
> (tried to write 0x0001000000000001) at
> rIP: 0xffffffffa98932af (native_write_msr+0xf/0x20)
> [12646.001698] Call Trace:
> [12646.001700]  <TASK>
> [12646.001700]  intel_pmu_pebs_enable_all+0x2c/0x40
> [12646.001703]  intel_pmu_enable_all+0xe/0x20
> [12646.001705]  ctx_resched+0x227/0x280
> [12646.001708]  event_function+0x8f/0xd0
> 
> Thank Vince very much for providing a small reproducible test case.
> https://lore.kernel.org/lkml/d12d4300-9926-5e58-6515-a53cb5c7bee0@maine.edu/
> 
> The error is because perf mistakenly creates a precise Topdown perf
> metrics event, INTEL_TD_METRIC_RETIRING, which uses the idx 48
> internally.
> The Topdown perf metrics events never be a precise event (PEBS). Any
> illegal creation should be filtered out by the intel_pmu_hw_config.
> However, the is_available_metric_event() failed to detect the Topdown
> perf metrics event. The filter is not applied.
> 
> To detect an event, the pure event encoding should be used, rather than
> the whole event->attr.config. Only check the pure event encoding in
> is_available_metric_event.
> 
> Fixes: 1ab5f235c176 ("perf/x86/intel: Filter unsupported Topdown metrics event")
> Reported-by: Vince Weaver <vincent.weaver@maine.edu>
> Closes: https://lore.kernel.org/lkml/14d3167e-4dad-f68e-822f-21cd86eab873@maine.edu/
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> Cc: stable@vger.kernel.org

Please also apply the tested-by from Vince if the patch looks good to you.
Tested-by: Vince Weaver <vincent.weaver@maine.edu>
https://lore.kernel.org/lkml/5a53490f-d4ec-85f7-4175-e148e02c3e67@maine.edu/

Thanks,
Kan> ---
>  arch/x86/events/intel/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 8f2e36ad89db..bf5ca4cb232b 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -4082,7 +4082,7 @@ static int core_pmu_hw_config(struct perf_event *event)
>  static bool is_available_metric_event(struct perf_event *event)
>  {
>  	return is_metric_event(event) &&
> -		event->attr.config <= INTEL_TD_METRIC_AVAILABLE_MAX;
> +	       (event->attr.config & INTEL_ARCH_EVENT_MASK) <= INTEL_TD_METRIC_AVAILABLE_MAX;
>  }
>  
>  static inline bool is_mem_loads_event(struct perf_event *event)


