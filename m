Return-Path: <stable+bounces-106794-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E91A0220E
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 10:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AA2C3A2BD7
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 09:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD107603F;
	Mon,  6 Jan 2025 09:41:09 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AEDE2AE94
	for <stable@vger.kernel.org>; Mon,  6 Jan 2025 09:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736156469; cv=none; b=k8PNINlTqnQEe+4Donpxxs937HEhbMmHqHY5ZRhnFdyp/lea5YEM3vcVdJqup3KJWma5YiK7x++P4QFgCpHdoF+/AqYleelkxz4VXeDZzirkcJ6pDBQS/1HNcz+gEVgE8uSGKxC6x4tpRAVYC9Ky8nKOOlDVj+cQGEX9+GfAlQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736156469; c=relaxed/simple;
	bh=3Xto95uuq0NJdR6Nvb8lDSKViY420KOWCqhAyCSBTpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BWht2uNJJyDLMWiNnMKsHzPh6dU+yk+7wBe5s2pwnneb4VMyEYqOoWXs5M9RX+7EfKxvS2HVmJ+L7ZJ/PphFyHOKR2iwtiTb3MP+chGDtqEYg1L007EG02h4l70xPdHL9FXu9yBhb2LUzLx0uUt04DFRddbkz5lDFpm1THpzMao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 987071476;
	Mon,  6 Jan 2025 01:41:33 -0800 (PST)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8D1E83F673;
	Mon,  6 Jan 2025 01:41:03 -0800 (PST)
Date: Mon, 6 Jan 2025 09:40:56 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Marc Zyngier <maz@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] arm64: Filter out SVE hwcaps when FEAT_SVE isn't
 implemented
Message-ID: <Z3ulKMeKQcHFErgr@J2N7QTR9R3>
References: <20250103182255.1763739-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250103182255.1763739-1-maz@kernel.org>

On Fri, Jan 03, 2025 at 06:22:55PM +0000, Marc Zyngier wrote:
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

Ugh; this is a massive pain. :(

Was this found by inspection, or is some real software going wrong?

> Fix it by restricting all SVE capabilities to ID_AA64PFR0_EL1.SVE
> being non-zero.

Unfortunately, I'm not sure this fix is correct+complete.

We expose ID_AA64PFR0_EL1 and ID_AA64ZFR0_EL1 via ID register emulation,
so any userspace software reading ID_AA64ZFR0_EL1 will encounter the
same surprise. If we hide that I'm worried we might hide some SME-only
information that isn't exposed elsewhere, and I'm not sure we can
reasonably hide ID_AA64ZFR0_EL1 emulation for SME-only (more on that
below).

Secondly, all our HWCAP documentation is written in the form:

| HWCAP2_SVEBF16
|     Functionality implied by ID_AA64ZFR0_EL1.BF16 == 0b0001.

... so while the architectural behaviour is a surprise, the kernel is
(techincallyy) behaving exactly as documented prior to this patch. Maybe
we need to change that documentation?

Do we have equivalent SME hwcaps for the relevant features?

... looking at:

  https://developer.arm.com/documentation/ddi0601/2024-12/AArch64-Registers/ID-AA64ZFR0-EL1--SVE-Feature-ID-Register-0?lang=en

... I see that ID_AA64ZFR0_EL1.B16B16 >= 0b0010 implies the presence of
SME BFMUL and BFSCALE instructions, but I don't see something equivalent
in ID_AA64SMFR0_EL1 per:

  https://developer.arm.com/documentation/ddi0601/2024-12/AArch64-Registers/ID-AA64SMFR0-EL1--SME-Feature-ID-Register-0?lang=en

... so I suspect ID_AA64ZFR0_EL1 might be the only source of truth for
this.

It is bizarre that ID_AA64SMFR0_EL1 doesn't follow the same format, and
ID_AA64SMFR0_EL1.B16B16 is a single-bit field that cannot encode the
same values as ID_AA64ZFR0_EL1.B16B16 (which is a 4-bit field).

Even if we change Linux here, someone will need to chase up with the
architects to ensure this isn't made worse in future.

Mark.

> Fixes: 06a916feca2b ("arm64: Expose SVE2 features for userspace")
> Reported-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: stable@vger.kernel.org
> ---
>  arch/arm64/kernel/cpufeature.c | 40 +++++++++++++++++++++++-----------
>  1 file changed, 27 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 6ce71f444ed84..6874aca5da9df 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -3022,6 +3022,13 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
>  		.matches = match,						\
>  	}
>  
> +#define HWCAP_CAP_MATCH_ID(match, reg, field, min_value, cap_type, cap)		\
> +	{									\
> +		__HWCAP_CAP(#cap, cap_type, cap)				\
> +		HWCAP_CPUID_MATCH(reg, field, min_value) 			\
> +		.matches = match,						\
> +	}
> +
>  #ifdef CONFIG_ARM64_PTR_AUTH
>  static const struct arm64_cpu_capabilities ptr_auth_hwcap_addr_matches[] = {
>  	{
> @@ -3050,6 +3057,13 @@ static const struct arm64_cpu_capabilities ptr_auth_hwcap_gen_matches[] = {
>  };
>  #endif
>  
> +#ifdef CONFIG_ARM64_SVE
> +static bool has_sve_feature(const struct arm64_cpu_capabilities *cap, int scope)
> +{
> +	return system_supports_sve() && has_user_cpuid_feature(cap, scope);
> +}
> +#endif
> +
>  static const struct arm64_cpu_capabilities arm64_elf_hwcaps[] = {
>  	HWCAP_CAP(ID_AA64ISAR0_EL1, AES, PMULL, CAP_HWCAP, KERNEL_HWCAP_PMULL),
>  	HWCAP_CAP(ID_AA64ISAR0_EL1, AES, AES, CAP_HWCAP, KERNEL_HWCAP_AES),
> @@ -3092,19 +3106,19 @@ static const struct arm64_cpu_capabilities arm64_elf_hwcaps[] = {
>  	HWCAP_CAP(ID_AA64MMFR2_EL1, AT, IMP, CAP_HWCAP, KERNEL_HWCAP_USCAT),
>  #ifdef CONFIG_ARM64_SVE
>  	HWCAP_CAP(ID_AA64PFR0_EL1, SVE, IMP, CAP_HWCAP, KERNEL_HWCAP_SVE),
> -	HWCAP_CAP(ID_AA64ZFR0_EL1, SVEver, SVE2p1, CAP_HWCAP, KERNEL_HWCAP_SVE2P1),
> -	HWCAP_CAP(ID_AA64ZFR0_EL1, SVEver, SVE2, CAP_HWCAP, KERNEL_HWCAP_SVE2),
> -	HWCAP_CAP(ID_AA64ZFR0_EL1, AES, IMP, CAP_HWCAP, KERNEL_HWCAP_SVEAES),
> -	HWCAP_CAP(ID_AA64ZFR0_EL1, AES, PMULL128, CAP_HWCAP, KERNEL_HWCAP_SVEPMULL),
> -	HWCAP_CAP(ID_AA64ZFR0_EL1, BitPerm, IMP, CAP_HWCAP, KERNEL_HWCAP_SVEBITPERM),
> -	HWCAP_CAP(ID_AA64ZFR0_EL1, B16B16, IMP, CAP_HWCAP, KERNEL_HWCAP_SVE_B16B16),
> -	HWCAP_CAP(ID_AA64ZFR0_EL1, BF16, IMP, CAP_HWCAP, KERNEL_HWCAP_SVEBF16),
> -	HWCAP_CAP(ID_AA64ZFR0_EL1, BF16, EBF16, CAP_HWCAP, KERNEL_HWCAP_SVE_EBF16),
> -	HWCAP_CAP(ID_AA64ZFR0_EL1, SHA3, IMP, CAP_HWCAP, KERNEL_HWCAP_SVESHA3),
> -	HWCAP_CAP(ID_AA64ZFR0_EL1, SM4, IMP, CAP_HWCAP, KERNEL_HWCAP_SVESM4),
> -	HWCAP_CAP(ID_AA64ZFR0_EL1, I8MM, IMP, CAP_HWCAP, KERNEL_HWCAP_SVEI8MM),
> -	HWCAP_CAP(ID_AA64ZFR0_EL1, F32MM, IMP, CAP_HWCAP, KERNEL_HWCAP_SVEF32MM),
> -	HWCAP_CAP(ID_AA64ZFR0_EL1, F64MM, IMP, CAP_HWCAP, KERNEL_HWCAP_SVEF64MM),
> +	HWCAP_CAP_MATCH_ID(has_sve_feature, ID_AA64ZFR0_EL1, SVEver, SVE2p1, CAP_HWCAP, KERNEL_HWCAP_SVE2P1),
> +	HWCAP_CAP_MATCH_ID(has_sve_feature, ID_AA64ZFR0_EL1, SVEver, SVE2, CAP_HWCAP, KERNEL_HWCAP_SVE2),
> +	HWCAP_CAP_MATCH_ID(has_sve_feature, ID_AA64ZFR0_EL1, AES, IMP, CAP_HWCAP, KERNEL_HWCAP_SVEAES),
> +	HWCAP_CAP_MATCH_ID(has_sve_feature, ID_AA64ZFR0_EL1, AES, PMULL128, CAP_HWCAP, KERNEL_HWCAP_SVEPMULL),
> +	HWCAP_CAP_MATCH_ID(has_sve_feature, ID_AA64ZFR0_EL1, BitPerm, IMP, CAP_HWCAP, KERNEL_HWCAP_SVEBITPERM),
> +	HWCAP_CAP_MATCH_ID(has_sve_feature, ID_AA64ZFR0_EL1, B16B16, IMP, CAP_HWCAP, KERNEL_HWCAP_SVE_B16B16),
> +	HWCAP_CAP_MATCH_ID(has_sve_feature, ID_AA64ZFR0_EL1, BF16, IMP, CAP_HWCAP, KERNEL_HWCAP_SVEBF16),
> +	HWCAP_CAP_MATCH_ID(has_sve_feature, ID_AA64ZFR0_EL1, BF16, EBF16, CAP_HWCAP, KERNEL_HWCAP_SVE_EBF16),
> +	HWCAP_CAP_MATCH_ID(has_sve_feature, ID_AA64ZFR0_EL1, SHA3, IMP, CAP_HWCAP, KERNEL_HWCAP_SVESHA3),
> +	HWCAP_CAP_MATCH_ID(has_sve_feature, ID_AA64ZFR0_EL1, SM4, IMP, CAP_HWCAP, KERNEL_HWCAP_SVESM4),
> +	HWCAP_CAP_MATCH_ID(has_sve_feature, ID_AA64ZFR0_EL1, I8MM, IMP, CAP_HWCAP, KERNEL_HWCAP_SVEI8MM),
> +	HWCAP_CAP_MATCH_ID(has_sve_feature, ID_AA64ZFR0_EL1, F32MM, IMP, CAP_HWCAP, KERNEL_HWCAP_SVEF32MM),
> +	HWCAP_CAP_MATCH_ID(has_sve_feature, ID_AA64ZFR0_EL1, F64MM, IMP, CAP_HWCAP, KERNEL_HWCAP_SVEF64MM),
>  #endif
>  #ifdef CONFIG_ARM64_GCS
>  	HWCAP_CAP(ID_AA64PFR1_EL1, GCS, IMP, CAP_HWCAP, KERNEL_HWCAP_GCS),
> -- 
> 2.39.2
> 

