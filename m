Return-Path: <stable+bounces-240005-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eIkiMYmZ5mnCygEAu9opvQ
	(envelope-from <stable+bounces-240005-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 23:24:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37DE0433FAE
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 23:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7335D3001338
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 21:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008E4386453;
	Mon, 20 Apr 2026 21:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AxqZuYH7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66DF3446A6;
	Mon, 20 Apr 2026 21:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776720262; cv=none; b=KILgVpzY3wLmFCbAWzHl8tRqw7OiL/Ox/2ZNh+N/1F/A6SY7GjhlYRruAwbTMbRtfU3CliO0u7mW/lNIoxegcMvxoTjEU2AH8ZQnX4uRXnTtCyav/qdpW3ruMGPB0mc8kcpX0FymLbxBYsOwZmcZ+Kwltum2Bc6po/YzBRuV+m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776720262; c=relaxed/simple;
	bh=XXjHJeJYkMGslezJ9r92d2OSbcS656NkP6bYvjMlzoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eL2YrS5rpLo3n00O12KOMoNXiNP2XRXuLZ56GOxyi4u4n+Nc+hRHAHemtTM5U0NCVCzzdu3nDzut3c8YW0GXQQIuiVkdSAvGdI040vc20BJ1GU6yi97Eq+iMuaPdcnzx5kxvtD2VPF8skUmvIMG+5qwVSXmUPJt5CyPvQ75Czck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AxqZuYH7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCA77C19425;
	Mon, 20 Apr 2026 21:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776720262;
	bh=XXjHJeJYkMGslezJ9r92d2OSbcS656NkP6bYvjMlzoI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AxqZuYH7rotOTwgS/lxfPcih+KIisJ4IY7L2ol3wbWkwTquryJCReqkFvvkXG0nit
	 nEA62JQHBP5ctqJ0bOdrz04uhbXws8qUxSCg5wHrTlnTvW7b1t8sT8vMuHvsik0yNr
	 1AvrgOGuLViZR3pUyJmGQzOfr2svYr3I7CJ5GeAO5xKOFlvFEaLJ7uYCim8flvnrct
	 m799mhncdOYRqvXaTyO6cOpC5IyiQKcpjrSziC2KtoXkBE1FJ1MJBNwAK8CdW9/dPy
	 MlRihSXOwzstr/3U+pmbPI1GZO6Y9g7F4rvfbJm6v9lFalzEPRy3UMfs6BmY+ilWjy
	 UPKh4poBi9V7w==
Date: Mon, 20 Apr 2026 14:23:29 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Xudong Hao <xudong.hao@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH] perf/x86/intel: Remove anythread_deprecated bit from
 perf_capabilities
Message-ID: <aeaZUZyILpy6HKnJ@google.com>
References: <20260415021010.1248083-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260415021010.1248083-1-dapeng1.mi@linux.intel.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240005-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[namhyung@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 37DE0433FAE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 15, 2026 at 10:10:10AM +0800, Dapeng Mi wrote:
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
>  arch/x86/events/intel/core.c | 9 +++------
>  arch/x86/events/perf_event.h | 2 +-
>  2 files changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 793335c3ce78..450c63165a22 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -7612,11 +7612,8 @@ __init int intel_pmu_init(void)
>  
>  	x86_add_quirk(intel_arch_events_quirk); /* Install first, so it runs last */
>  
> -	if (version >= 5) {
> -		x86_pmu.intel_cap.anythread_deprecated = edx.split.anythread_deprecated;
> -		if (x86_pmu.intel_cap.anythread_deprecated)
> -			pr_cont(" AnyThread deprecated, ");
> -	}
> +	if (version >= 5 && edx.split.anythread_deprecated)
> +		pr_cont(" AnyThread deprecated, ");
>  
>  	/* The perf side of core PMU is ready to support the mediated vPMU. */
>  	x86_get_pmu(smp_processor_id())->capabilities |= PERF_PMU_CAP_MEDIATED_VPMU;
> @@ -8467,7 +8464,7 @@ __init int intel_pmu_init(void)
>  				      &x86_pmu.intel_ctrl);
>  
>  	/* AnyThread may be deprecated on arch perfmon v5 or later */
> -	if (x86_pmu.intel_cap.anythread_deprecated)
> +	if (edx.split.anythread_deprecated)

Do we need to check the version here as well?

Thanks,
Namhyung


>  		x86_pmu.format_attrs = intel_arch_formats_attr;
>  

