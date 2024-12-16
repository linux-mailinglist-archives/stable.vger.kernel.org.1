Return-Path: <stable+bounces-104363-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1C39F3402
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 16:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEA6E7A1D4C
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 15:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67587136347;
	Mon, 16 Dec 2024 15:07:22 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940E73BBF2;
	Mon, 16 Dec 2024 15:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734361642; cv=none; b=ZD7pIVIsFgkL+hbtsNSaj67C98vHzKCyOBmKtkI/XdgJxuyacdWG/WA+ofh9GzyK662VkNHcTqFXL60zplotozwZlp6Vi8wirYPuvvdZlGt+/C9z1foDsW7vfdvDsR063DQVOVqHADzsivzMEGOXWvcPKGlDfmHhw66lH6JOjfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734361642; c=relaxed/simple;
	bh=SgZjk+8yBlOmzIWfRmxDyNI7Gzu9mkk24E08tKkr/gE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e9VgZoeZ3xo9+EEKpRZpO1nwZDEwWM9k01PYFRRKz3JPgVbam3vSoPhA8dABruflIUFqo5kjMtcOxIB4t1hKS5OWlubz99CO73kT8ohIhjPiDavMf8CPJaEddtDVRlxHh1eNsWeAPMQQ7x3U3u6Z7F793WHsYuC8kQ9xaWO+RCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 177A0113E;
	Mon, 16 Dec 2024 07:07:47 -0800 (PST)
Received: from J2N7QTR9R3.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D2FC93F528;
	Mon, 16 Dec 2024 07:07:17 -0800 (PST)
Date: Mon, 16 Dec 2024 15:07:15 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Marc Zyngier <maz@kernel.org>
Cc: Mark Brown <broonie@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Peter Collingbourne <pcc@google.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] arm64/sme: Move storage of reg_smidr to
 __cpuinfo_store_cpu()
Message-ID: <Z2BCI61c9QWG7mMB@J2N7QTR9R3.cambridge.arm.com>
References: <20241214-arm64-fix-boot-cpu-smidr-v1-1-0745c40772dd@kernel.org>
 <87a5cysfci.wl-maz@kernel.org>
 <Z2AfOZ82QG_ukWry@J2N7QTR9R3>
 <865xnjsnqo.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <865xnjsnqo.wl-maz@kernel.org>

On Mon, Dec 16, 2024 at 02:31:43PM +0000, Marc Zyngier wrote:
> On Mon, 16 Dec 2024 12:38:17 +0000,
> Mark Rutland <mark.rutland@arm.com> wrote:
> > I think that what we did in commit:
> > 
> >    892f7237b3ff ("arm64: Delay initialisation of cpuinfo_arm64::reg_{zcr,smcr}")
> > 
> > ... introduces an anti-pattern that'd be nice to avoid. That broke the
> > existing split of __cpuinfo_store_cpu() and init_cpu_features(), where
> > the former read the ID regs, and the latter set up the features
> > *without* altering the copy of the ID regs that was read. i.e.
> > init_cpu_features() shouldn't write to its info argument at all.
> > 
> > I understand that we have to do something as a bodge for broken FW which
> > traps SME, but I'd much rather we did that within __cpuinfo_store_cpu().
> 
> Honestly, I'd rather revert that patch, together with b3000e2133d8
> ("arm64: Add the arm64.nosme command line option"). I'm getting tired
> of the FW nonsense, and we are only allowing vendors to ship untested
> crap.
> 
> Furthermore, given the state of SME in the kernel, I don't think this
> is makes any difference. So maybe this is the right time to reset
> everything to a sane state.

Looking again, a revert does look to be the best option.

We removed reg_zcr and reg_smcr in v6.7 in commits:

  abef0695f9665c3d ("arm64/sve: Remove ZCR pseudo register from cpufeature code")
  391208485c3ad50f ("arm64/sve: Remove SMCR pseudo register from cpufeature code")

As of those commits, ZCR and SCMR no longer matter to
__cpuinfo_store_cpu(), and only SMIDR_EL1 remains...

Per ARM DDI 0487 L.a, accesses to SMIDR_EL1 never trap to EL3, so we can
read that safely as long as ID_AA64PFR1_EL1.SME indicates that SME is
implemented.

Which is to say that if we revert the remaining portion of 892f7237b3ff
and restore the read of SMIDR, that should be good as far back as v6.7,
which sounds good to me.

Mark.

> > Can we add something to check whether SME was disabled on the command
> > line, and use that in __cpuinfo_store_cpu(), effectively reverting
> > 892f7237b3ff?
> 
> Maybe, but that'd be before any sanitisation of the overrides, so it
> would have to severely limit its scope. Something like this, which I
> haven't tested:
> 
> diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
> index d79e88fccdfce..9e9295e045009 100644
> --- a/arch/arm64/kernel/cpuinfo.c
> +++ b/arch/arm64/kernel/cpuinfo.c
> @@ -492,10 +492,22 @@ void cpuinfo_store_cpu(void)
>  	update_cpu_features(smp_processor_id(), info, &boot_cpu_data);
>  }
>  
> +static void cpuinfo_apply_overrides(struct cpuinfo_arm64 *info)
> +{
> +	if (FIELD_GET(ID_AA64PFR0_EL1_SVE, id_aa64pfr0_override.mask) &&
> +	    !FIELD_GET(ID_AA64PFR0_EL1_SVE, id_aa64pfr0_override.val))
> +		info->reg_id_aa64pfr0 &= ~ID_AA64PFR0_EL1_SVE;
> +
> +	if (FIELD_GET(ID_AA64PFR1_EL1_SME, id_aa64pfr1_override.mask) &&
> +	    !FIELD_GET(ID_AA64PFR1_EL1_SME, id_aa64pfr1_override.val))
> +		info->reg_id_aa64pfr1 &= ~ID_AA64PFR1_EL1_SME;
> +}
> +
>  void __init cpuinfo_store_boot_cpu(void)
>  {
>  	struct cpuinfo_arm64 *info = &per_cpu(cpu_data, 0);
>  	__cpuinfo_store_cpu(info);
> +	cpuinfo_apply_overrides(info);
>  
>  	boot_cpu_data = *info;
>  	init_cpu_features(&boot_cpu_data);
> 
> But this will have ripple effects on the rest of the override code
> (the kernel messages are likely to be wrong).
> 
> 	M.
> 
> -- 
> Without deviation from the norm, progress is not possible.

