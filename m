Return-Path: <stable+bounces-253419-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KEe2NGBYDmpG+AUAu9opvQ
	(envelope-from <stable+bounces-253419-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 02:57:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F1959D717
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 02:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D93CE309B9EA
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 00:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4339E27E05E;
	Thu, 21 May 2026 00:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fHkQIM0g"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE8222D4C3;
	Thu, 21 May 2026 00:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779324819; cv=none; b=I0Ph2zcDuq+MXw8sm9m6wNxzuwSlSAxQ6W9wv9xirtkCbWDV2vu1NszYJV95KUDrjjNKWps2exdFbLJNzT3DUnwluqXC2Nn84xKYIiIp/lvoDDLz+4SrI0gTRzevYeIIJi4NJgPqY1rAsHqxf6VV/nw1IRBb8VKlBHW9f6hihAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779324819; c=relaxed/simple;
	bh=8y/gk517uy/TpBzCs0mJezDZ/J7fdgYcUL7YmpL/8vw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i6WwtER+RUx0fG7oaNebo/y2eNosZHIyhlRhmGiIu9x6e1KH4UR/qTMI2bquHr17vYBMjHLTOquhYZWYlRty9eEdbP6hJnlOOhYI7M0al/G3jpJZOgXmc0LcRVxU3gqNt2scZSyxeKY6s3bXXapV/Gd16XZr+i9/k+v0YjSkc2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fHkQIM0g; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779324817; x=1810860817;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8y/gk517uy/TpBzCs0mJezDZ/J7fdgYcUL7YmpL/8vw=;
  b=fHkQIM0gESuuePmmc4RrlTzP2fcoJy0le9yHMWG5xfNescyAcpQg7p5P
   MKTxckoHsucH4jh3MuZ5qi8BiCgq9BfvCKr5y1TcqYgJ2eoMUHf3LeaSf
   Zma8qWZOeLOS9vaK+jlfHnru6JSc43l1ionhhr8YC78E7SOxVXi6cIg6N
   EnJ0LnaPNhucDVS5uVOHbxjKIIEwx7Es2KvENdrDFWJ1eIgNcYhi0Cof6
   gqaPATEJM6AhzTRXu3DSTyZ6J9K0n/0ksk2u2SUfqeuzl7v697lxw/k22
   6+KBKsd5AIFaUr52sURVeeBMQGv9zhaiWU9dMg2zx0GfTl5qEqyCVNCZ0
   A==;
X-CSE-ConnectionGUID: ZRNoqfIlQnm+oZ+5ehSgxg==
X-CSE-MsgGUID: H+OuWF2TSPOzDVMz/svLmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="97807182"
X-IronPort-AV: E=Sophos;i="6.23,245,1770624000"; 
   d="scan'208";a="97807182"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 17:53:36 -0700
X-CSE-ConnectionGUID: s8m3nWfMQ72++KraESakQQ==
X-CSE-MsgGUID: 2QcOv1svRyu0Ga30cIT3WQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,245,1770624000"; 
   d="scan'208";a="240230820"
Received: from unknown (HELO [10.238.3.164]) ([10.238.3.164])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 17:53:33 -0700
Message-ID: <7e8f94f4-4bf9-4a91-b2a5-db285a30037e@linux.intel.com>
Date: Thu, 21 May 2026 08:53:31 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2] perf/x86/intel: Remove anythread_deprecated bit from
 perf_capabilities
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Zide Chen <zide.chen@intel.com>, Falcon Thomas <thomas.falcon@intel.com>,
 Dapeng Mi <dapeng1.mi@intel.com>, Xudong Hao <xudong.hao@intel.com>,
 stable@vger.kernel.org
References: <20260423053306.3033331-1-dapeng1.mi@linux.intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260423053306.3033331-1-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-253419-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:email,intel.com:dkim]
X-Rspamd-Queue-Id: 41F1959D717
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Kindly ping. :)

Thanks.


On 4/23/2026 1:33 PM, Dapeng Mi wrote:
> AnyThread mode deprecation is enumerated by CPUID.0AH:EDX[15] instead of
> PERF_CAPABILITIES MSR. It's not a good practice to define a bit to
> represent "anythread deprecation" in perf_capabilities. It leads to the
> anythread_deprecated bit could be overwritten by the real value of
> PERF_CAPABILITIES MSR, just like the below code in update_pmu_cap() does.
>
> ```
> if (!intel_pmu_broken_perf_cap()) {
> 	/* Perf Metric (Bit 15) and PEBS via PT (Bit 16) are hybrid enumeration */
> 	rdmsrq(MSR_IA32_PERF_CAPABILITIES, hybrid(pmu, intel_cap).capabilities);
> }
> ```
>
> It leads to the anythread_deprecated bit is cleared to 0 and the "any"
> attribute is incorrectly shown in the /sys/devices/cpu/format/ folder on
> these support Perfmon v6 platforms, like Clearwater Forest.
>
> ```
> $grep . /sys/devices/cpu/format/*
> /sys/devices/cpu/format/acr_mask:config2:0-63
> /sys/devices/cpu/format/any:config:21
> /sys/devices/cpu/format/cmask:config:24-31
> ```
>
> So remove the anythread_deprecated bit from perf_capabilities structure
> and directly depends on CPUID.0AH:EDX[15] to judge if anythread is
> deprecated.
>
> Cc: stable@vger.kernel.org
> Reported-by: Namhyung Kim <namhyung@kernel.org>
> Fixes: cadbaa039b99 ("perf/x86/intel: Make anythread filter support conditional")
> Acked-by: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> ---
>
> V2: Address Namhyung and Zide's comments.
>
> V1: https://lore.kernel.org/all/20260415021010.1248083-1-dapeng1.mi@linux.intel.com/
>
>  arch/x86/events/intel/core.c | 10 +++-------
>  arch/x86/events/perf_event.h |  2 +-
>  2 files changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 793335c3ce78..f57a2903e4d6 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -7612,12 +7612,6 @@ __init int intel_pmu_init(void)
>  
>  	x86_add_quirk(intel_arch_events_quirk); /* Install first, so it runs last */
>  
> -	if (version >= 5) {
> -		x86_pmu.intel_cap.anythread_deprecated = edx.split.anythread_deprecated;
> -		if (x86_pmu.intel_cap.anythread_deprecated)
> -			pr_cont(" AnyThread deprecated, ");
> -	}
> -
>  	/* The perf side of core PMU is ready to support the mediated vPMU. */
>  	x86_get_pmu(smp_processor_id())->capabilities |= PERF_PMU_CAP_MEDIATED_VPMU;
>  
> @@ -8467,8 +8461,10 @@ __init int intel_pmu_init(void)
>  				      &x86_pmu.intel_ctrl);
>  
>  	/* AnyThread may be deprecated on arch perfmon v5 or later */
> -	if (x86_pmu.intel_cap.anythread_deprecated)
> +	if (version >= 5 && edx.split.anythread_deprecated) {
>  		x86_pmu.format_attrs = intel_arch_formats_attr;
> +		pr_cont("AnyThread deprecated, ");
> +	}
>  
>  	intel_pmu_check_event_constraints_all(NULL);
>  
> diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
> index fad87d3c8b2c..01217c663dff 100644
> --- a/arch/x86/events/perf_event.h
> +++ b/arch/x86/events/perf_event.h
> @@ -660,7 +660,7 @@ union perf_capabilities {
>  		u64	perf_metrics:1;
>  		u64	pebs_output_pt_available:1;
>  		u64	pebs_timing_info:1;
> -		u64	anythread_deprecated:1;
> +		u64	__reserved:1;
>  		u64	rdpmc_metrics_clear:1;
>  	};
>  	u64	capabilities;

