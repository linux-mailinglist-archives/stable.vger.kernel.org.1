Return-Path: <stable+bounces-106816-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD9EA0239D
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 11:57:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 986523A49C4
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 10:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88011DC982;
	Mon,  6 Jan 2025 10:57:19 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3B51DC1A7
	for <stable@vger.kernel.org>; Mon,  6 Jan 2025 10:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736161039; cv=none; b=fUhN0FDX61zd8tmaItqbCMiAFXCVjMuskZfOnWFInxQusqxEwXUJjLtT+zaNMzWErCAYtYOj0xMM02i1UproavQQOiKWv3LSEAQTZ9oyrvFCfq1c7MtzOMk7cjtyiNL/ZPCCoMpnMHpR6QEP/f2NSmZdvQgSmRW7yHRJEeVSKLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736161039; c=relaxed/simple;
	bh=IgNYAaMtVr381ogwKzq+7rVFLBo2p3kr8NDW1bzPsLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fBLCKxnLUAiclAnldhu5AvL/kiJTf/hkQ5R7UMDWOgZd5GUAEf7UjQGuXnSb/Iu9m2D0p+60yJB+whY3EeuAXHfFZK+zqC48oRZw8WDh607QdJGEuLgUdyRJFCXaeIOnTZghCupQ/3zeThotkKroo5LBxFYj2yhxjDnlJLVO1cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDAF6C4CED2;
	Mon,  6 Jan 2025 10:57:17 +0000 (UTC)
Date: Mon, 6 Jan 2025 10:57:15 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org,
	Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] arm64: Filter out SVE hwcaps when FEAT_SVE isn't
 implemented
Message-ID: <Z3u3C87U7LKJZ77B@arm.com>
References: <20250103182255.1763739-1-maz@kernel.org>
 <Z3ulKMeKQcHFErgr@J2N7QTR9R3>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z3ulKMeKQcHFErgr@J2N7QTR9R3>

On Mon, Jan 06, 2025 at 09:40:56AM +0000, Mark Rutland wrote:
> On Fri, Jan 03, 2025 at 06:22:55PM +0000, Marc Zyngier wrote:
> > The hwcaps code that exposes SVE features to userspace only
> > considers ID_AA64ZFR0_EL1, while this is only valid when
> > ID_AA64PFR0_EL1.SVE advertises that SVE is actually supported.
> > 
> > The expectations are that when ID_AA64PFR0_EL1.SVE is 0, the
> > ID_AA64ZFR0_EL1 register is also 0. So far, so good.
> > 
> > Things become a bit more interesting if the HW implements SME.
> > In this case, a few ID_AA64ZFR0_EL1 fields indicate *SME*
> > features. And these fields overlap with their SVE interpretations.
> > But the architecture says that the SME and SVE feature sets must
> > match, so we're still hunky-dory.
> > 
> > This goes wrong if the HW implements SME, but not SVE. In this
> > case, we end-up advertising some SVE features to userspace, even
> > if the HW has none. That's because we never consider whether SVE
> > is actually implemented. Oh well.
> 
> Ugh; this is a massive pain. :(
> 
> Was this found by inspection, or is some real software going wrong?

It goes wrong on M4 in a VM. The latest macOS (15.2 I think) enabled
those ID regs for guests and Linux user space started falling apart
(first one reported was a fairly recent JDK getting SIGILL when trying
to use the INCB instruction). Reported initially on the Parallels forum.

> > Fix it by restricting all SVE capabilities to ID_AA64PFR0_EL1.SVE
> > being non-zero.
> 
> Unfortunately, I'm not sure this fix is correct+complete.
> 
> We expose ID_AA64PFR0_EL1 and ID_AA64ZFR0_EL1 via ID register emulation,
> so any userspace software reading ID_AA64ZFR0_EL1 will encounter the
> same surprise. If we hide that I'm worried we might hide some SME-only
> information that isn't exposed elsewhere, and I'm not sure we can
> reasonably hide ID_AA64ZFR0_EL1 emulation for SME-only (more on that
> below).

Good point about the user also accessing these registers through
emulation.

> Secondly, all our HWCAP documentation is written in the form:
> 
> | HWCAP2_SVEBF16
> |     Functionality implied by ID_AA64ZFR0_EL1.BF16 == 0b0001.
> 
> ... so while the architectural behaviour is a surprise, the kernel is
> (techincallyy) behaving exactly as documented prior to this patch. Maybe
> we need to change that documentation?

The kernel is also reporting HWCAP2_SVE2 based on ID_AA64ZFR0_EL1.SVEver
which I don't think it should (my reading of the spec). I suspect that's
what's causing JDK failures.

> Do we have equivalent SME hwcaps for the relevant features?
> 
> ... looking at:
> 
>   https://developer.arm.com/documentation/ddi0601/2024-12/AArch64-Registers/ID-AA64ZFR0-EL1--SVE-Feature-ID-Register-0?lang=en
> 
> ... I see that ID_AA64ZFR0_EL1.B16B16 >= 0b0010 implies the presence of
> SME BFMUL and BFSCALE instructions, but I don't see something equivalent
> in ID_AA64SMFR0_EL1 per:
> 
>   https://developer.arm.com/documentation/ddi0601/2024-12/AArch64-Registers/ID-AA64SMFR0-EL1--SME-Feature-ID-Register-0?lang=en
> 
> ... so I suspect ID_AA64ZFR0_EL1 might be the only source of truth for
> this.
> 
> It is bizarre that ID_AA64SMFR0_EL1 doesn't follow the same format, and
> ID_AA64SMFR0_EL1.B16B16 is a single-bit field that cannot encode the
> same values as ID_AA64ZFR0_EL1.B16B16 (which is a 4-bit field).

Oh, I'm getting confused now. Do we have this information exposed twice
in the ID regs? I think in the kernel we use ZFR0 for SVE and SMFR0 for
the SME equivalent but the architecture is actually confusing with ZFR0
describing both SME and SVE features available. I guess at some point
the architects thought we can't have SME without SVE but changed their
mind and we haven't spotted.

-- 
Catalin

