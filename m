Return-Path: <stable+bounces-58283-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D79F692B487
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 11:57:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 061E81C223DC
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 09:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8446712FF72;
	Tue,  9 Jul 2024 09:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WI3uKerU"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647501553A7;
	Tue,  9 Jul 2024 09:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720519017; cv=none; b=f5qdqwxbx/p2hRZ4gfrFfYa6abPWxC3M3EU/cEKQuIf/1qSyEAAHAQEI19+GesoNwkKciIVIFdkv33qcs80x3UJ/s5FT7VCBD1rC+pk7H8xHF2xzEd4BzvmlYWnBB40/WZ1QevaAUmC0SkyOTc264861bPZKQ4cimCT+10Gfssg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720519017; c=relaxed/simple;
	bh=AryC27Iplz1ssVBjEWUzknmertonuyW96fY+K4ppFs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LIDvxGRwsonWPIbYAQdCfoVTKKuJvMXKY4n5/GMgxma+c+ctTpt9t3lslT6FB6J/hg+EZ5XPVYAuqH482RHDeM2UUxHANDeqSwaFquC4EkmbFIeluUrun/c4PxfqYxuPjDlTlcjukozghTa9i0H7L/E14DrR7KWmknOidZkAgWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WI3uKerU; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=oOcvWdh89egIfpm66gTq/7OvE4snUwjTKuuUb76jk3c=; b=WI3uKerU0x4O7Gsyf2VsTxRuqN
	kcTOoke5UWtf6FFmCRTI84u0slVP25Ds41D8Jm2lhULR6f98QrsZD2omXH669KL7JSVnw/a2331Jf
	4ujle3odot4++n2oOOUdGXROSxMsd/1/Inq+W9hfeHzhUGRSxrbUNxMQrB4zZr8fBKodrFC2U3ngf
	F5twmU0Y8U71keifCmqMZYVx7CUQBxSifIq5ljBx+lvnPEU/40B0XRpHfLdOkb54raiqLAyLi+miI
	D2NNrdLB7oaUwI40fnlC1YbWM1W5eGuUpkW/178UCrHE+A57HEucODUuyab9NqY7MEcFwRi8b5noV
	kHQ7dLTQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sR7aa-00000007lHE-26hK;
	Tue, 09 Jul 2024 09:56:48 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B5B793006B7; Tue,  9 Jul 2024 11:56:47 +0200 (CEST)
Date: Tue, 9 Jul 2024 11:56:47 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: kan.liang@linux.intel.com
Cc: mingo@kernel.org, acme@kernel.org, namhyung@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
	ak@linux.intel.com, eranian@google.com,
	Ahmad Yasin <ahmad.yasin@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH 2/3] perf/x86/intel: Add a distinct name for Granite
 Rapids
Message-ID: <20240709095647.GH27299@noisy.programming.kicks-ass.net>
References: <20240708193336.1192217-1-kan.liang@linux.intel.com>
 <20240708193336.1192217-3-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240708193336.1192217-3-kan.liang@linux.intel.com>

On Mon, Jul 08, 2024 at 12:33:35PM -0700, kan.liang@linux.intel.com wrote:
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
> Cc: stable@vger.kernel.org
> ---
>  arch/x86/events/intel/core.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index b61367991a16..7a9f931a1f48 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -6943,12 +6943,17 @@ __init int intel_pmu_init(void)
>  	case INTEL_EMERALDRAPIDS_X:
>  		x86_pmu.flags |= PMU_FL_MEM_LOADS_AUX;
>  		x86_pmu.extra_regs = intel_glc_extra_regs;
> +		pr_cont("Sapphire Rapids events, ");
> +		name = "sapphire_rapids";
>  		fallthrough;
>  	case INTEL_GRANITERAPIDS_X:
>  	case INTEL_GRANITERAPIDS_D:
>  		intel_pmu_init_glc(NULL);
> -		if (!x86_pmu.extra_regs)
> +		if (!x86_pmu.extra_regs) {
>  			x86_pmu.extra_regs = intel_rwc_extra_regs;
> +			pr_cont("Granite Rapids events, ");
> +			name = "granite_rapids";
> +		}
>  		x86_pmu.pebs_ept = 1;
>  		x86_pmu.hw_config = hsw_hw_config;
>  		x86_pmu.get_event_constraints = glc_get_event_constraints;
> @@ -6959,8 +6964,6 @@ __init int intel_pmu_init(void)
>  		td_attr = glc_td_events_attrs;
>  		tsx_attr = glc_tsx_events_attrs;
>  		intel_pmu_pebs_data_source_skl(true);
> -		pr_cont("Sapphire Rapids events, ");
> -		name = "sapphire_rapids";
>  		break;

For some reason this didn't want to apply cleanly (something trivial),
but since I had to edit it, my fingers slipped and I ended up with the
below. That ok?

---
Subject: perf/x86/intel: Add a distinct name for Granite Rapids
From: Kan Liang <kan.liang@linux.intel.com>
Date: Mon, 8 Jul 2024 12:33:35 -0700

From: Kan Liang <kan.liang@linux.intel.com>

Currently, the Sapphire Rapids and Granite Rapids share the same PMU
name, sapphire_rapids. Because from the kernel’s perspective, GNR is
similar to SPR. The only key difference is that they support different
extra MSRs. The code path and the PMU name are shared.

However, from end users' perspective, they are quite different. Besides
the extra MSRs, GNR has a newer PEBS format, supports Retire Latency,
supports new CPUID enumeration architecture, doesn't required the
load-latency AUX event, has additional TMA Level 1 Architectural Events,
etc. The differences can be enumerated by CPUID or the PERF_CAPABILITIES
MSR. They weren't reflected in the model-specific kernel setup.
But it is worth to have a distinct PMU name for GNR.

Fixes: a6742cb90b56 ("perf/x86/intel: Fix the FRONTEND encoding on GNR and MTL")
Suggested-by: Ahmad Yasin <ahmad.yasin@intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20240708193336.1192217-3-kan.liang@linux.intel.com
---
 arch/x86/events/intel/core.c |   14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -6788,12 +6788,18 @@ __init int intel_pmu_init(void)
 	case INTEL_FAM6_EMERALDRAPIDS_X:
 		x86_pmu.flags |= PMU_FL_MEM_LOADS_AUX;
 		x86_pmu.extra_regs = intel_glc_extra_regs;
-		fallthrough;
+		pr_cont("Sapphire Rapids events, ");
+		name = "sapphire_rapids";
+		goto glc_common;
+
 	case INTEL_FAM6_GRANITERAPIDS_X:
 	case INTEL_FAM6_GRANITERAPIDS_D:
+		x86_pmu.extra_regs = intel_rwc_extra_regs;
+		pr_cont("Granite Rapids events, ");
+		name = "granite_rapids";
+
+	glc_common:
 		intel_pmu_init_glc(NULL);
-		if (!x86_pmu.extra_regs)
-			x86_pmu.extra_regs = intel_rwc_extra_regs;
 		x86_pmu.pebs_ept = 1;
 		x86_pmu.hw_config = hsw_hw_config;
 		x86_pmu.get_event_constraints = glc_get_event_constraints;
@@ -6804,8 +6810,6 @@ __init int intel_pmu_init(void)
 		td_attr = glc_td_events_attrs;
 		tsx_attr = glc_tsx_events_attrs;
 		intel_pmu_pebs_data_source_skl(true);
-		pr_cont("Sapphire Rapids events, ");
-		name = "sapphire_rapids";
 		break;
 
 	case INTEL_FAM6_ALDERLAKE:

