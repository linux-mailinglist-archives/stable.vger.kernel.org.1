Return-Path: <stable+bounces-111798-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C92A23C8D
	for <lists+stable@lfdr.de>; Fri, 31 Jan 2025 11:57:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78CAC3A911F
	for <lists+stable@lfdr.de>; Fri, 31 Jan 2025 10:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6FAD1B6D1F;
	Fri, 31 Jan 2025 10:57:04 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17E91B6CE9;
	Fri, 31 Jan 2025 10:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738321024; cv=none; b=Oq1ikV7Dne44GsIN2sVTVJPcNbyGjPGJQP9XK7w4JskQLy8vUBQUx2Tec7CF6j1UrKMeF8NQGSPTWTQ2AOG5Oz6K6RziS+IABgn11oXZV67y+4wLF+3K3ZcowQANlum697jjCrvFc1xNI5r+Rr8SqiG1Axgc926lysNwDiLz6ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738321024; c=relaxed/simple;
	bh=Ju62Gi05ZY1w2Y4MQ+7vJS2qhOAzNeduVZhHxWSdkoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fgULTJ9HUFj+wDEt2gGEzxZS1a2N3vJTk/zvFgrRd3cNpiKENn4o8rYKOucNsYl+sTLxdsBbZHKKnkgsRjsnedkAD1tWywWFFMpyUSrYNbbEmqqQNDhdJKHIGUSlTvcW6joqN23QbZAM35k9jOVUERKYhQdmewl444Cosm8LyBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8EEE1497;
	Fri, 31 Jan 2025 02:57:26 -0800 (PST)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B79BC3F63F;
	Fri, 31 Jan 2025 02:56:58 -0800 (PST)
Date: Fri, 31 Jan 2025 10:56:56 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Oliver Upton <oliver.upton@linux.dev>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Mark Brown <broonie@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>, James Morse <james.morse@arm.com>,
	stable@vger.kernel.org, Moritz Fischer <moritzf@google.com>,
	Pedro Martelletto <martelletto@google.com>,
	Jon Masters <jonmasters@google.com>
Subject: Re: [PATCH] arm64: Move storage of idreg overrides into mmuoff
 section
Message-ID: <Z5yseC1kCyTcwlMy@J2N7QTR9R3>
References: <20250130204614.64621-1-oliver.upton@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250130204614.64621-1-oliver.upton@linux.dev>

Hi Oliver,

On Thu, Jan 30, 2025 at 12:46:15PM -0800, Oliver Upton wrote:
> There are a few places where the idreg overrides are read w/ the MMU
> off, for example the VHE and hVHE checks in __finalise_el2. And while
> the infrastructure gets this _mostly_ right (i.e. does the appropriate
> cache maintenance), the placement of the data itself is problematic and
> could share a cache line with something else.
> 
> Depending on how unforgiving an implementation's handling of mismatched
> attributes is, this could lead to data corruption. In one observed case,
> the system_cpucaps shared a line with arm64_sw_feature_override and the
> cpucaps got nuked after entering the hyp stub...

This doesn't sound right. Non-cacheable/Device reads should not lead to
corruption of a cached copy regardless of whether that cached copy is
clean or dirty.

The corruption suggests that either we're performing a *write* with
mismatched attributes (in which case the use of .mmuoff.data.read below
isn't quite right), or we have a plan invalidate somewhere without a
clean (and e.g. something else might need to be moved into
.mmuoff.data.write).

Seconding Ard's point, I think we need to understand this scenario
better.

To be clear, I think moving all the overrides into .mmuoff.data.read
makes sense, but it doesn't explain the problem above, and it seems like
there must be a latent issue (which this might only mask rather than
solve).

Mark.

> Even though only a few overrides are read without the MMU on, just throw
> the whole lot into the mmuoff section and be done with it.
> 
> Cc: stable@vger.kernel.org # v5.15+
> Tested-by: Moritz Fischer <moritzf@google.com>
> Tested-by: Pedro Martelletto <martelletto@google.com>
> Reported-by: Jon Masters <jonmasters@google.com>
> Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
> ---
>  arch/arm64/kernel/cpufeature.c | 25 ++++++++++++++-----------
>  1 file changed, 14 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index d41128e37701..92506d9f90db 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -755,17 +755,20 @@ static const struct arm64_ftr_bits ftr_raz[] = {
>  #define ARM64_FTR_REG(id, table)		\
>  	__ARM64_FTR_REG_OVERRIDE(#id, id, table, &no_override)
>  
> -struct arm64_ftr_override id_aa64mmfr0_override;
> -struct arm64_ftr_override id_aa64mmfr1_override;
> -struct arm64_ftr_override id_aa64mmfr2_override;
> -struct arm64_ftr_override id_aa64pfr0_override;
> -struct arm64_ftr_override id_aa64pfr1_override;
> -struct arm64_ftr_override id_aa64zfr0_override;
> -struct arm64_ftr_override id_aa64smfr0_override;
> -struct arm64_ftr_override id_aa64isar1_override;
> -struct arm64_ftr_override id_aa64isar2_override;
> -
> -struct arm64_ftr_override arm64_sw_feature_override;
> +#define DEFINE_FTR_OVERRIDE(name)					\
> +	struct arm64_ftr_override __section(".mmuoff.data.read") name
> +
> +DEFINE_FTR_OVERRIDE(id_aa64mmfr0_override);
> +DEFINE_FTR_OVERRIDE(id_aa64mmfr1_override);
> +DEFINE_FTR_OVERRIDE(id_aa64mmfr2_override);
> +DEFINE_FTR_OVERRIDE(id_aa64pfr0_override);
> +DEFINE_FTR_OVERRIDE(id_aa64pfr1_override);
> +DEFINE_FTR_OVERRIDE(id_aa64zfr0_override);
> +DEFINE_FTR_OVERRIDE(id_aa64smfr0_override);
> +DEFINE_FTR_OVERRIDE(id_aa64isar1_override);
> +DEFINE_FTR_OVERRIDE(id_aa64isar2_override);
> +
> +DEFINE_FTR_OVERRIDE(arm64_sw_feature_override);
>  
>  static const struct __ftr_reg_entry {
>  	u32			sys_id;
> 
> base-commit: 1dd3393696efba1598aa7692939bba99d0cffae3
> -- 
> 2.39.5
> 
> 

