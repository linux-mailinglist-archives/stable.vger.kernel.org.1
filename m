Return-Path: <stable+bounces-178026-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47462B4795F
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 09:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01ACF179755
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 07:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DFD31EDA1B;
	Sun,  7 Sep 2025 07:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0j4tuwNF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51F112D1F1
	for <stable@vger.kernel.org>; Sun,  7 Sep 2025 07:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757231009; cv=none; b=ZJdJTh6+2Y70xcleTWSQx4otFxHj7q8qRYhL10gjhotsWr2gdygcx0VwjXVu/Yg18Svy5tFQbyXJ7hU0dZGaMbSUY0Dzp9scI9kjkbzTI5m8J9r7V7QwjiPm8xDdeB2ZPEWQniFlTN1R8MRYoQV50KNt3DqKNxuVtuLBakVaV5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757231009; c=relaxed/simple;
	bh=G0qb5LavVFY48VANTUvFuaq8M3FW3K+pGxdqL1zoUEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iUk5olAb35JoKja8xmaWwd/FxjvczM7Q9VqIlqcNcz9wpPPct6H3mXWoklZFmpihmdgoSLIvgG7rrQnEM1KZ1PcbWd1oQQn0o2ULFoqgz1iM+Tx8Kkce74TuNI7e3WWLUNidoIAQyDYe+OSgMeieboo1GzSxcAn8eUbepVtyOC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0j4tuwNF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A042C4CEF0;
	Sun,  7 Sep 2025 07:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757231008;
	bh=G0qb5LavVFY48VANTUvFuaq8M3FW3K+pGxdqL1zoUEU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0j4tuwNFM+1zpLGoTfvUbbgDAavXYoS/G51LPnYlqVxYnOs5bI2ZRuFTzpMvMgi9R
	 r1QxwH62XGrvGiTAhd547by73x+Sxh+uWPDZRXlz9RLG0eByfEX4GLhxcuXsR+UOGp
	 oC7vjh9i5grJ/8b0N4YJif4zpozCdXOmTeFjZ3Ko=
Date: Sun, 7 Sep 2025 09:43:25 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Dapeng Mi <dapeng1.mi@linux.intel.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>
Subject: Re: [PATCH 6.12.y] perf/x86/intel: Don't clear perf metrics overflow
 bit unconditionally
Message-ID: <2025090752-wipe-ashen-bf0c@gregkh>
References: <2025042126-outgrow-kiln-e518@gregkh>
 <20250906143826.44231-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250906143826.44231-1-sashal@kernel.org>

On Sat, Sep 06, 2025 at 10:38:26AM -0400, Sasha Levin wrote:
> From: Dapeng Mi <dapeng1.mi@linux.intel.com>
> 
> [ Upstream commit a5f5e1238f4ff919816f69e77d2537a48911767b ]
> 
> The below code would always unconditionally clear other status bits like
> perf metrics overflow bit once PEBS buffer overflows:
> 
>         status &= intel_ctrl | GLOBAL_STATUS_TRACE_TOPAPMI;
> 
> This is incorrect. Perf metrics overflow bit should be cleared only when
> fixed counter 3 in PEBS counter group. Otherwise perf metrics overflow
> could be missed to handle.
> 
> Closes: https://lore.kernel.org/all/20250225110012.GK31462@noisy.programming.kicks-ass.net/
> Fixes: 7b2c05a15d29 ("perf/x86/intel: Generic support for hardware TopDown metrics")
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/r/20250415104135.318169-1-dapeng1.mi@linux.intel.com
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  arch/x86/events/intel/core.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 5e43d390f7a3d..063147d7161b6 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -3029,7 +3029,6 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
>  	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>  	int bit;
>  	int handled = 0;
> -	u64 intel_ctrl = hybrid(cpuc->pmu, intel_ctrl);
>  
>  	inc_irq_stat(apic_perf_irqs);
>  
> @@ -3073,7 +3072,6 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
>  		handled++;
>  		x86_pmu_handle_guest_pebs(regs, &data);
>  		static_call(x86_pmu_drain_pebs)(regs, &data);
> -		status &= intel_ctrl | GLOBAL_STATUS_TRACE_TOPAPMI;
>  
>  		/*
>  		 * PMI throttle may be triggered, which stops the PEBS event.
> @@ -3084,6 +3082,15 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
>  		 */
>  		if (pebs_enabled != cpuc->pebs_enabled)
>  			wrmsrl(MSR_IA32_PEBS_ENABLE, cpuc->pebs_enabled);
> +
> +		/*
> +		 * Above PEBS handler (PEBS counters snapshotting) has updated fixed
> +		 * counter 3 and perf metrics counts if they are in counter group,
> +		 * unnecessary to update again.
> +		 */
> +		if (cpuc->events[INTEL_PMC_IDX_FIXED_SLOTS] &&
> +		    is_pebs_counter_event_group(cpuc->events[INTEL_PMC_IDX_FIXED_SLOTS]))
> +			status &= ~GLOBAL_STATUS_PERF_METRICS_OVF_BIT;
>  	}
>  
>  	/*
> @@ -3103,6 +3110,8 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
>  		static_call(intel_pmu_update_topdown_event)(NULL);
>  	}
>  
> +	status &= hybrid(cpuc->pmu, intel_ctrl);
> +
>  	/*
>  	 * Checkpointed counters can lead to 'spurious' PMIs because the
>  	 * rollback caused by the PMI will have cleared the overflow status
> -- 
> 2.51.0
> 
> 

This breaks the build:

arch/x86/events/intel/core.c: In function ‘handle_pmi_common’:
arch/x86/events/intel/core.c:3092:21: error: implicit declaration of function ‘is_pebs_counter_event_group’ [-Wimplicit-function-declaration]
 3092 |                     is_pebs_counter_event_group(cpuc->events[INTEL_PMC_IDX_FIXED_SLOTS]))
      |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~

so I'll not apply it.

thanks,

greg k-h

