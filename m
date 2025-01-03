Return-Path: <stable+bounces-106726-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 928DCA00CB2
	for <lists+stable@lfdr.de>; Fri,  3 Jan 2025 18:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D1A13A139B
	for <lists+stable@lfdr.de>; Fri,  3 Jan 2025 17:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A771FA25D;
	Fri,  3 Jan 2025 17:20:08 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9165312C499
	for <stable@vger.kernel.org>; Fri,  3 Jan 2025 17:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735924808; cv=none; b=WMw5aRAV/po0ksqf3RyC/FudJ3toDxK1IZTPiX/S1kGmvpWnwHk0+1W1rWLHV5PT8zu0q3E17n8vskAcHVboN8178YiWl5fJNvUY/RNdoX5mIzmtaaA0eBEhrVoudCJOWegA2O/NYUs/dMydjKRPTqTDm/caaLIMe6fyV+p9eVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735924808; c=relaxed/simple;
	bh=JXAryuHFFJF4QeChl/cx0GCVKft5ks3jN9AKKL2xAJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jvoe/quqr0jZ0w3i2otvD7k3JAUi6jJVspg0KK4KScybqam90ZPGL55dRusjz1J3tSI3+JQ/5np+tCGbwNWXqTD91CtrVzz9uuaCNfMZaLG+x+pQZkgslsc2VHn3+1nkvA45F1fpwWvXZQu9Coay4Nh1HhoLUIi75TfFWuGPyWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52A9BC4CECE;
	Fri,  3 Jan 2025 17:20:07 +0000 (UTC)
Date: Fri, 3 Jan 2025 17:20:05 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Marc Zyngier <maz@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mark Brown <broonie@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH] arm64: Filter out SVE hwcaps when FEAT_SVE isn't
 implemented
Message-ID: <Z3gcRczN67LsMVST@arm.com>
References: <20250103142635.1759674-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250103142635.1759674-1-maz@kernel.org>

On Fri, Jan 03, 2025 at 02:26:35PM +0000, Marc Zyngier wrote:
> The hwcaps code that exposes SVE features to userspace only
> considers ID_AA64ZFR0_EL1, while this is only valid when
> ID_AA64PFR0_EL1.SVE advertises that SVE is actually supported.
> 
> The expectations are that when ID_AA64PFR0_EL1.SVE is 0, the
> ID_AA64ZFR0_EL1 register is also 0. So far, so good.
> 
> Things become a bit more interesting if the HW implements SME.
> In this case, a few ID_AA64ZFR0_EL1 fields indicate *SME*
> features. And these fields overlap with their SVE interpretations.
> But the architecture says that the SME and SVE feature sets must
> match, so we're still hunky-dory.
> 
> This goes wrong if the HW implements SME, but not SVE. In this
> case, we end-up advertising some SVE features to userspace, even
> if the HW has none. That's because we never consider whether SVE
> is actually implemented. Oh well.
> 
> Fix it by restricting all SVE capabilities to ID_AA64PFR0_EL1.SVE
> being non-zero.
> 
> Reported-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: stable@vger.kernel.org

I'd add:

Fixes: 06a916feca2b ("arm64: Expose SVE2 features for userspace")

While at the time the code was correct, the architecture messed up our
assumptions with the introduction of SME.

> @@ -3022,6 +3027,13 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
>  		.matches = match,						\
>  	}
>  
> +#define HWCAP_CAP_MATCH_ID(match, reg, field, min_value, cap_type, cap)		\
> +	{									\
> +		__HWCAP_CAP(#cap, cap_type, cap)				\
> +		HWCAP_CPUID_MATCH(reg, field, min_value) 			\
> +		.matches = match,						\
> +	}

Do we actually need this macro?

> +
>  #ifdef CONFIG_ARM64_PTR_AUTH
>  static const struct arm64_cpu_capabilities ptr_auth_hwcap_addr_matches[] = {
>  	{
> @@ -3050,6 +3062,18 @@ static const struct arm64_cpu_capabilities ptr_auth_hwcap_gen_matches[] = {
>  };
>  #endif
>  
> +#ifdef CONFIG_ARM64_SVE
> +static bool has_sve(const struct arm64_cpu_capabilities *cap, int scope)
> +{
> +	u64 aa64pfr0 = __read_scoped_sysreg(SYS_ID_AA64PFR0_EL1, scope);
> +
> +	if (FIELD_GET(ID_AA64PFR0_EL1_SVE, aa64pfr0) < ID_AA64PFR0_EL1_SVE_IMP)
> +		return false;
> +
> +	return has_user_cpuid_feature(cap, scope);
> +}
> +#endif

We can name this has_sve_feature() and use it with the existing
HWCAP_CAP_MATCH() macro. I think it would look identical.

We might even be able to use system_supports_sve() directly and avoid
changing read_scoped_sysreg(). setup_user_features() is called in
smp_cpus_done() after setup_system_features(), so using
system_supports_sve() directly should be fine here.

-- 
Catalin

