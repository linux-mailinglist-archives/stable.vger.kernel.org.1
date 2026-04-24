Return-Path: <stable+bounces-240998-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4FEBLMiT62m7OgAAu9opvQ
	(envelope-from <stable+bounces-240998-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 18:01:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E69746119A
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 18:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C2B9C300D33E
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 16:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB81D38BF6A;
	Fri, 24 Apr 2026 16:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nrr1iPsx"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE7D290DBB;
	Fri, 24 Apr 2026 16:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777046466; cv=none; b=CTDGRLKOrh7R05C13dEbMBWF90YcgzcKUiUQVCSr9SlQRABrP+aiK9vtX2bGTTsbmj31pQoSkawIwEE0OfXHjN7qdOgMb5WSY9ki02IB/8XdNWueyJZaoz4yZfPwGYL3RB3if5LTBlJ8vsKaqB3zsxDPn4ZZnHnSuW1p8u5SCtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777046466; c=relaxed/simple;
	bh=KBT7vvmv0IVOWGMiLj2J36zsnQ02LrEe5v671QjMNCw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LmW4iQN0G4N0bQGrzQgWlMPP1HCXuIQUKqrdT0fFgt+6Iah7YrRIW0i93fUJrDx/w6hmHe+OodyrTkISip68j2E78wRj7TyJTPjtzZpo1TF4OzeXwJobdeNlcxhou9ifTFmUqbdpyG9WL4VPduVz/8qp7dg3rotcSytrd4VlCtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nrr1iPsx; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777046465; x=1808582465;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KBT7vvmv0IVOWGMiLj2J36zsnQ02LrEe5v671QjMNCw=;
  b=nrr1iPsxtkaQlJrNyLSP9Kmi95jG4P9immba5yKMjalze8eXWbd5JCig
   x+ai28sfHPpIBVXH9pijo2aJj7X3OEfLoUCfx2RfVhrBHzB3Bs+nhHKdm
   XAMG5Nutb+vk1+O0pDhLviUXIY6RhyhZuRShbbkZDt8HZaNoWYJyvieef
   lRwpQZ0U0REniIcIGuB5yKaCFqR/mj6A4OokvkoTqPsjSdJbDreiB2ZYL
   NE6rNFOs3/bAYfWRM9RSwkCQwbZjcBFWeaw+Hp+gOQuOQ0PnQdJMUdY0I
   BUGpPrfceillq/8FycCKKaBmGNnIUocM8yztUO/EiiUfYihbf/VKNEO4s
   g==;
X-CSE-ConnectionGUID: Xjqyp5grQeq+/tdiKvxUeQ==
X-CSE-MsgGUID: YWZi8dhnRG+kHi0ZX4ndrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11766"; a="88728726"
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="88728726"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 09:01:04 -0700
X-CSE-ConnectionGUID: FYfcxKl3R+WAg9B6m7YpQQ==
X-CSE-MsgGUID: /KJGgbsCS4+oJ7yTlVrFHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="238048509"
Received: from unknown (HELO [10.241.240.162]) ([10.241.240.162])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 09:01:04 -0700
Message-ID: <9248da24-350e-412e-acaa-619356c3ff21@intel.com>
Date: Fri, 24 Apr 2026 09:01:02 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2] perf/x86/intel: Remove anythread_deprecated bit from
 perf_capabilities
To: Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Falcon Thomas <thomas.falcon@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>,
 Xudong Hao <xudong.hao@intel.com>, stable@vger.kernel.org
References: <20260423053306.3033331-1-dapeng1.mi@linux.intel.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <20260423053306.3033331-1-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 1E69746119A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-240998-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zide.chen@intel.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid]



On 4/22/2026 10:33 PM, Dapeng Mi wrote:
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

Reviewed-by:  Zide Chen <zide.chen@intel.com>


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


