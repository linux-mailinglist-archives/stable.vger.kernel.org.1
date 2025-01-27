Return-Path: <stable+bounces-110881-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2B5A1DAC0
	for <lists+stable@lfdr.de>; Mon, 27 Jan 2025 17:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E3993A66B6
	for <lists+stable@lfdr.de>; Mon, 27 Jan 2025 16:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C77165F01;
	Mon, 27 Jan 2025 16:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NltkVsuU"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3A61632EF;
	Mon, 27 Jan 2025 16:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737996239; cv=none; b=P5ail1T+XFlPwc6dxv/gb7xHSlfNAswAtfYY6Hira9pTFKSG9NYNfRYdLQhDdWWeOKUzVgmgc+z+PzJxv/oGH9mFSW5CkWUO+MVnwheaJ3TZRNbBLyx6b3kY23HMsxWCGl+LYDyFc8hm0MaDrL1KevGhjjRnrbJypD5Tc3XJFr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737996239; c=relaxed/simple;
	bh=zi4O12kBcOOPKp1T3hbuhiWPGUNYKWFVD8cXQTLJC2o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ry1+bv2fiOWByPsJXIDz9yL6I23781+l9lpGKvjmrw8KrEpPr8fuOorJxTbIkmxDQiVj4iFlu5o/z5na2jgEXqtCr2wwgHIs7Qikhb640M8x9NWMJ/0XsFQ31QmwZ4t8RCOQBGjn7e2PLb92/cCCaPZNFrHO1K+j/uK3G8RExCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NltkVsuU; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737996237; x=1769532237;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zi4O12kBcOOPKp1T3hbuhiWPGUNYKWFVD8cXQTLJC2o=;
  b=NltkVsuU/MMo+Kq365IsfSdQ/UgXBtPi/OvVY1sANWa8+qI+bh/u/RPI
   UARMEic0WduAYJ5nGluwVgNmGR8qcJ+F0Z6TUIcEggw/7+dtGPWb0Tg3G
   6c2couN15X+AZzmblB4mvDassoS2mu+CAyuQAj/TccXfYf+L+9PE0/9XR
   KG/7VZafIsveceS4h4IXKQn15SonCeAjT2G1Yxf1DH3oFzDiceQho45p4
   lP+PxMJSGRxmggl50O/W+3Sz65q5MjVkhqnruw3bSwhTL4u68lcYNpD/z
   FWeZjKuT2Jsoehkj/A8hZUJRRy4kswCfecztFz6AWQPUZYYJJAUABPGXy
   g==;
X-CSE-ConnectionGUID: hwZqXOzdQACAym/F/O6ymg==
X-CSE-MsgGUID: aWGeg0y0Smu84exOE6ALyA==
X-IronPort-AV: E=McAfee;i="6700,10204,11328"; a="56005134"
X-IronPort-AV: E=Sophos;i="6.13,238,1732608000"; 
   d="scan'208";a="56005134"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2025 08:43:56 -0800
X-CSE-ConnectionGUID: d55GN29kTly2yPUqx8LTdw==
X-CSE-MsgGUID: Y6h/MPEOQwKPUnquNDORqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="145695181"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2025 08:43:56 -0800
Received: from [10.246.136.10] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.10])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 95B4220B5713;
	Mon, 27 Jan 2025 08:43:54 -0800 (PST)
Message-ID: <6d5c45b4-53ad-403f-9de3-a25b80a44e0e@linux.intel.com>
Date: Mon, 27 Jan 2025 11:43:53 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/20] perf/x86/intel: Fix ARCH_PERFMON_NUM_COUNTER_LEAF
To: Peter Zijlstra <peterz@infradead.org>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@intel.com>, stable@vger.kernel.org
References: <20250123140721.2496639-1-dapeng1.mi@linux.intel.com>
 <20250123140721.2496639-3-dapeng1.mi@linux.intel.com>
 <20250127162917.GM16742@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20250127162917.GM16742@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-01-27 11:29 a.m., Peter Zijlstra wrote:
> On Thu, Jan 23, 2025 at 02:07:03PM +0000, Dapeng Mi wrote:
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> The EAX of the CPUID Leaf 023H enumerates the mask of valid sub-leaves.
>> To tell the availability of the sub-leaf 1 (enumerate the counter mask),
>> perf should check the bit 1 (0x2) of EAS, rather than bit 0 (0x1).
>>
>> The error is not user-visible on bare metal. Because the sub-leaf 0 and
>> the sub-leaf 1 are always available. However, it may bring issues in a
>> virtualization environment when a VMM only enumerates the sub-leaf 0.
>>
>> Fixes: eb467aaac21e ("perf/x86/intel: Support Architectural PerfMon Extension leaf")
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>> Cc: stable@vger.kernel.org
>> ---
>>  arch/x86/events/intel/core.c      | 4 ++--
>>  arch/x86/include/asm/perf_event.h | 2 +-
>>  2 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>> index 5e8521a54474..12eb96219740 100644
>> --- a/arch/x86/events/intel/core.c
>> +++ b/arch/x86/events/intel/core.c
>> @@ -4966,8 +4966,8 @@ static void update_pmu_cap(struct x86_hybrid_pmu *pmu)
>>  	if (ebx & ARCH_PERFMON_EXT_EQ)
>>  		pmu->config_mask |= ARCH_PERFMON_EVENTSEL_EQ;
>>  
>> -	if (sub_bitmaps & ARCH_PERFMON_NUM_COUNTER_LEAF_BIT) {
>> -		cpuid_count(ARCH_PERFMON_EXT_LEAF, ARCH_PERFMON_NUM_COUNTER_LEAF,
>> +	if (sub_bitmaps & ARCH_PERFMON_NUM_COUNTER_LEAF) {
>> +		cpuid_count(ARCH_PERFMON_EXT_LEAF, ARCH_PERFMON_NUM_COUNTER_LEAF_BIT,
>>  			    &eax, &ebx, &ecx, &edx);
>>  		pmu->cntr_mask64 = eax;
>>  		pmu->fixed_cntr_mask64 = ebx;
>> diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
>> index adaeb8ca3a8a..71e2ae021374 100644
>> --- a/arch/x86/include/asm/perf_event.h
>> +++ b/arch/x86/include/asm/perf_event.h
>> @@ -197,7 +197,7 @@ union cpuid10_edx {
>>  #define ARCH_PERFMON_EXT_UMASK2			0x1
>>  #define ARCH_PERFMON_EXT_EQ			0x2
>>  #define ARCH_PERFMON_NUM_COUNTER_LEAF_BIT	0x1
>> -#define ARCH_PERFMON_NUM_COUNTER_LEAF		0x1
>> +#define ARCH_PERFMON_NUM_COUNTER_LEAF		BIT(ARCH_PERFMON_NUM_COUNTER_LEAF_BIT)
> 
> if you'll look around, you'll note this file uses BIT_ULL(), please stay
> consistent.

But they are used for a 64-bit register.
The ARCH_PERFMON_NUM_COUNTER_LEAF is for the CPUID enumeration, which is
a u32.

Thanks,
Kan



