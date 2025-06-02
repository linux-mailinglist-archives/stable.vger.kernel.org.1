Return-Path: <stable+bounces-148944-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BCB1ACADCC
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 14:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72F613BDFD8
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 12:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B9E20E713;
	Mon,  2 Jun 2025 12:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LnQbUZh+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA5F1C84B1
	for <stable@vger.kernel.org>; Mon,  2 Jun 2025 12:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748866116; cv=none; b=eYL/ZXE60bECeHwdnSdlLawkR5vKfHncPiWCKM9ayczmVvdykN1lJBQe6E3UEpli8RwmVSCMa+PZwp7Zj67Ww1z6+coenyk8GWmDmR9bl3D+g45kGdOjukobCZr+h4lS/ts9a7965To58Wsz6WI9g5S0M1gw5MYZoakYGQ1LME4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748866116; c=relaxed/simple;
	bh=RWnKqnsp/1FPSmsLUS6zSkCoSv/M0/RRRwTSRXV15KU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tHg1PRh0edhvOVgw9GT1QCZlBbWXJM9iYG0lJQ9oInmZXqkv2/tlgeN/BlYXtJQeCQ0IMhla14ukMsvTAI8gBVVeYdzOAMxKDrJUFs+qn0DNNi60spY2Eag0uZel2Ua9DmrlR3mF3qL3jdyQ8TYjiF9hq5SCYdkem5zbL7Mwgls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LnQbUZh+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3F5FC4CEEB;
	Mon,  2 Jun 2025 12:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748866116;
	bh=RWnKqnsp/1FPSmsLUS6zSkCoSv/M0/RRRwTSRXV15KU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LnQbUZh+AAvUo4bP4YVgd28E2selhWXfBfNabZ8fl/du2Tgf8mecvuCTqSgETjFlz
	 JtE30ZuJJgb4Vvs4wtvIPWWKZIT5R6R6efGyLeg4OIg2hi7cOiznQOJfGEDh6XeDK2
	 7CxyBla1qruWQUbcGwhOl29xpBHdvGxEFZthuK8YbbuYjqlb17vGOHyOU2Sn/Vmuz2
	 WsNz43tQtMcnbGnjz2gn0onTEPwyncVpjOtg/3UabypFZztPggeswuABynujt/kZpm
	 /qUBvR+vHJ59dyP5Bb7UkbjRPme0tBE58e/FTXXo+H6blgKs215F9fnlMQGM1EXY4n
	 /njeB8f4ynknA==
Date: Mon, 2 Jun 2025 13:08:31 +0100
From: Will Deacon <will@kernel.org>
To: Oliver Upton <oliver.upton@linux.dev>
Cc: linux-arm-kernel@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>,
	Mingwei Zhang <mizhang@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH] arm64: Add MIDR-based check for FEAT_ECBHB
Message-ID: <20250602120831.GC1227@willie-the-truck>
References: <20250522204148.4007406-1-oliver.upton@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250522204148.4007406-1-oliver.upton@linux.dev>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, May 22, 2025 at 01:41:48PM -0700, Oliver Upton wrote:
> Prior to commit e8cde32f111f ("arm64/cpufeatures/kvm: Add ARMv8.9
> FEAT_ECBHB bits in ID_AA64MMFR1 register") KVM was erroneously masking
> FEAT_ECBHB from VMs, giving the perception that safe implementations are
> actually vulnerable to Spectre-BHB. And, after commit e403e8538359
> ("arm64: errata: Assume that unknown CPUs _are_ vulnerable to Spectre
> BHB") guests are enabling the loop mitigation.
> 
> This broken virtual hardware is going to be around for some time, so do
> the ugly thing and check for revisions of Neoverse-V2 [1], Cortex-X3 [2],
> Cortex-A720 [3], and Neoverse-N3 [4] that are documented to have FEAT_ECBHB.
> 
> Cc: stable@vger.kernel.org
> Link: https://developer.arm.com/documentation/102375/0002
> Link: https://developer.arm.com/documentation/101593/0102
> Link: https://developer.arm.com/documentation/102530/0002
> Link: https://developer.arm.com/documentation/107997/0001
> Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
> ---
> 
> I thoroughly hate this but the alternative of nuking these busted VMs
> isn't exactly popular...
> 
>  arch/arm64/include/asm/cputype.h |  1 +
>  arch/arm64/kernel/proton-pack.c  | 16 ++++++++++++++++
>  2 files changed, 17 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
> index d1cc0571798b..5c6152e61cad 100644
> --- a/arch/arm64/include/asm/cputype.h
> +++ b/arch/arm64/include/asm/cputype.h
> @@ -282,6 +282,7 @@ struct midr_range {
>  #define MIDR_REV_RANGE(m, v, r_min, r_max) MIDR_RANGE(m, v, r_min, v, r_max)
>  #define MIDR_REV(m, v, r) MIDR_RANGE(m, v, r, v, r)
>  #define MIDR_ALL_VERSIONS(m) MIDR_RANGE(m, 0, 0, 0xf, 0xf)
> +#define MIDR_MIN_VERSION(m, v, r) MIDR_RANGE(m, v, r, 0xf, 0xf)
>  
>  static inline bool midr_is_cpu_model_range(u32 midr, u32 model, u32 rv_min,
>  					   u32 rv_max)
> diff --git a/arch/arm64/kernel/proton-pack.c b/arch/arm64/kernel/proton-pack.c
> index b198dde79e59..3d00d4c22d58 100644
> --- a/arch/arm64/kernel/proton-pack.c
> +++ b/arch/arm64/kernel/proton-pack.c
> @@ -962,8 +962,24 @@ static bool has_spectre_bhb_fw_mitigation(void)
>  
>  static bool supports_ecbhb(int scope)
>  {
> +	static const struct midr_range spectre_ecbhb_list[] = {
> +		MIDR_MIN_VERSION(MIDR_NEOVERSE_V2, 0, 2),
> +		MIDR_MIN_VERSION(MIDR_CORTEX_X3, 1, 1),
> +		MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N3),
> +		MIDR_MIN_VERSION(MIDR_CORTEX_A720, 0, 1),
> +		{},
> +	};
>  	u64 mmfr1;
>  
> +	/*
> +	 * Prior to commit e8cde32f111f ("arm64/cpufeatures/kvm: Add ARMv8.9
> +	 * FEAT_ECBHB bits in ID_AA64MMFR1 register"), KVM masked FEAT_ECBHB
> +	 * on implementations that actually have the feature. That sucks; infer
> +	 * presence of FEAT_ECBHB based on MIDR.
> +	 */
> +	if (is_midr_in_range_list(spectre_ecbhb_list))
> +		return true;
> +

I really don't think we want to go down this route.

If finer grained control of the spectre mitigations is needed, I think
extending the existing command-line options is probably the best bet
rather then inferring behaviours based on the MIDR.

Will

