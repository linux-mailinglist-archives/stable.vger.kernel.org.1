Return-Path: <stable+bounces-169635-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C084B27109
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 23:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09E65625CA9
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 21:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C562527702D;
	Thu, 14 Aug 2025 21:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="exw8xY8Q"
X-Original-To: stable@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC08A319878
	for <stable@vger.kernel.org>; Thu, 14 Aug 2025 21:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755208076; cv=none; b=jbCOLIY/Xuf1uB9JIfNHBJ79HOZsw/3B6+GhBXnsyjEWHVD7fZQPN+EeUomR9gOmBZSWFaC/UahstUE1F9uc9lOjlzMu4q4k7vdeV8VSY3u2zaLn6PV+wFTK5tnV8PDFyfp4mJ3DmQfx3odnaVJxgiLRbWDJ85+/c53P/9DgUk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755208076; c=relaxed/simple;
	bh=a4oORCPkRP32iLc6RfLQ65PTmvcm3nSF2tOrO+pgC14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P4SyD8771y/pm+MVtpa7pGnZ8AycUu7cweN7gBQRL/lO074iyj5gdqr4/Pmur8AsSHRs1RqIzjdn2EUybFkgwruUnnuF1th9k38teDymFG4lP60CkRBK6yxEm7nqTDJNhxt1XAB+bnPg3uKbCQotw6U8/2ddTEj/dWwLN85P8O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=exw8xY8Q; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 14 Aug 2025 14:47:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755208071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Bgz4jMotbYhVmm8fDGrcO1w7c2g/rXF4VKWnFn7z1m4=;
	b=exw8xY8QDafi0wzCGkxmK3tYjcABy5dq59L5B7PwRReJC+c8oPMWcefNljlQXLME0pBXBM
	2/ZL2/NdFKmCvwZRecORnyidNL4w6BRHjjXl2jUIwraRNf42ESmJ2B2HOXp89k0lmG41FF
	SxITVWleD2HUFQ/dVAuqZ3AU8fEsknM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH 6.15.y 1/5] KVM: arm64: Repaint pmcr_n into
 nr_pmu_counters
Message-ID: <aJ5ZfyyCHWXW9XdZ@linux.dev>
References: <2025081248-omission-talisman-0619@gregkh>
 <20250813211820.2074887-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813211820.2074887-1-sashal@kernel.org>
X-Migadu-Flow: FLOW_OUT

Hi Sasha,

Please drop this series, it affects code that is effectively dead prior
to 6.16.

Thanks,
Oliver

On Wed, Aug 13, 2025 at 05:18:16PM -0400, Sasha Levin wrote:
> From: Marc Zyngier <maz@kernel.org>
> 
> [ Upstream commit f12b54d7c24388886277598236b3eeea5c68eec4 ]
> 
> The pmcr_n field obviously refers to PMCR_EL0.N, but is generally used
> as the number of counters seen by the guest. Rename it accordingly.
> 
> Suggested-by: Oliver upton <oliver.upton@linux.dev>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Stable-dep-of: c6e35dff58d3 ("KVM: arm64: Check for SYSREGS_ON_CPU before accessing the CPU state")
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  arch/arm64/include/asm/kvm_host.h | 4 ++--
>  arch/arm64/kvm/pmu-emul.c         | 6 +++---
>  arch/arm64/kvm/sys_regs.c         | 4 ++--
>  3 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index 08ba91e6fb03..bea8ae1b1b02 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -359,8 +359,8 @@ struct kvm_arch {
>  
>  	cpumask_var_t supported_cpus;
>  
> -	/* PMCR_EL0.N value for the guest */
> -	u8 pmcr_n;
> +	/* Maximum number of counters for the guest */
> +	u8 nr_pmu_counters;
>  
>  	/* Iterator for idreg debugfs */
>  	u8	idreg_debugfs_iter;
> diff --git a/arch/arm64/kvm/pmu-emul.c b/arch/arm64/kvm/pmu-emul.c
> index a1bc10d7116a..60b5a5e4a6c5 100644
> --- a/arch/arm64/kvm/pmu-emul.c
> +++ b/arch/arm64/kvm/pmu-emul.c
> @@ -280,7 +280,7 @@ static u64 kvm_pmu_hyp_counter_mask(struct kvm_vcpu *vcpu)
>  		return 0;
>  
>  	hpmn = SYS_FIELD_GET(MDCR_EL2, HPMN, __vcpu_sys_reg(vcpu, MDCR_EL2));
> -	n = vcpu->kvm->arch.pmcr_n;
> +	n = vcpu->kvm->arch.nr_pmu_counters;
>  
>  	/*
>  	 * Programming HPMN to a value greater than PMCR_EL0.N is
> @@ -1032,7 +1032,7 @@ static void kvm_arm_set_pmu(struct kvm *kvm, struct arm_pmu *arm_pmu)
>  	lockdep_assert_held(&kvm->arch.config_lock);
>  
>  	kvm->arch.arm_pmu = arm_pmu;
> -	kvm->arch.pmcr_n = kvm_arm_pmu_get_max_counters(kvm);
> +	kvm->arch.nr_pmu_counters = kvm_arm_pmu_get_max_counters(kvm);
>  }
>  
>  /**
> @@ -1261,7 +1261,7 @@ u64 kvm_vcpu_read_pmcr(struct kvm_vcpu *vcpu)
>  {
>  	u64 pmcr = __vcpu_sys_reg(vcpu, PMCR_EL0);
>  
> -	return u64_replace_bits(pmcr, vcpu->kvm->arch.pmcr_n, ARMV8_PMU_PMCR_N);
> +	return u64_replace_bits(pmcr, vcpu->kvm->arch.nr_pmu_counters, ARMV8_PMU_PMCR_N);
>  }
>  
>  void kvm_pmu_nested_transition(struct kvm_vcpu *vcpu)
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index 5dde9285afc8..554490360ff6 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -785,7 +785,7 @@ static unsigned int pmu_visibility(const struct kvm_vcpu *vcpu,
>  static u64 reset_pmu_reg(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
>  {
>  	u64 mask = BIT(ARMV8_PMU_CYCLE_IDX);
> -	u8 n = vcpu->kvm->arch.pmcr_n;
> +	u8 n = vcpu->kvm->arch.nr_pmu_counters;
>  
>  	if (n)
>  		mask |= GENMASK(n - 1, 0);
> @@ -1217,7 +1217,7 @@ static int set_pmcr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r,
>  	 */
>  	if (!kvm_vm_has_ran_once(kvm) &&
>  	    new_n <= kvm_arm_pmu_get_max_counters(kvm))
> -		kvm->arch.pmcr_n = new_n;
> +		kvm->arch.nr_pmu_counters = new_n;
>  
>  	mutex_unlock(&kvm->arch.config_lock);
>  
> -- 
> 2.39.5
> 

