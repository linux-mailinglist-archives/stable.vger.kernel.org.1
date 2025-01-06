Return-Path: <stable+bounces-106835-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C59EA024C1
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 13:04:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAF9E1885045
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 12:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE9A1DDC0D;
	Mon,  6 Jan 2025 12:03:57 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA7F1DDA20
	for <stable@vger.kernel.org>; Mon,  6 Jan 2025 12:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736165037; cv=none; b=AWUgOVkLp5tgyDM3qdh6MqFT7t57pEnaVnVr1p9g33VF7RYYxdlowI99hge7ImyZzjk43UGF3nKIjidhoSfk1GPNlkQiVl6ZpfFxUaTo1Mtu+Z8PC2qz82xGFuXl+g8UGiFh7WBJbS0ZEyjPNCc4DNZmGaIoJtK5rGUVU14fs9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736165037; c=relaxed/simple;
	bh=g5BoqBuPuTfVMZDJJHTUPqIE8SvwtzGLgyMr2MHbzgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gBGZFUrBed9gszLBH1X/rNgUH8HOUaxTYMEjPwepPdAkUlwtz0UJY4nE7El6sEAYrxvKl3oMlNa1DCjgvbFyJFBtc5GKV6fPs0IttgphQmhICDgKN7poW4bBgSDx8ligbtKVAkaBfSDveyrU8ATe0NUas1IRGYp534ysaRP+lbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C614222D9;
	Mon,  6 Jan 2025 04:04:23 -0800 (PST)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 870B33F673;
	Mon,  6 Jan 2025 04:03:54 -0800 (PST)
Date: Mon, 6 Jan 2025 12:03:44 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Marc Zyngier <maz@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] arm64: Filter out SVE hwcaps when FEAT_SVE isn't
 implemented
Message-ID: <Z3vGeFUBd9YSIgg_@J2N7QTR9R3>
References: <20250103182255.1763739-1-maz@kernel.org>
 <Z3ulKMeKQcHFErgr@J2N7QTR9R3>
 <868qrop556.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <868qrop556.wl-maz@kernel.org>

On Mon, Jan 06, 2025 at 11:12:53AM +0000, Marc Zyngier wrote:
> On Mon, 06 Jan 2025 09:40:56 +0000,
> Mark Rutland <mark.rutland@arm.com> wrote:
> > 
> > On Fri, Jan 03, 2025 at 06:22:55PM +0000, Marc Zyngier wrote:
> > > The hwcaps code that exposes SVE features to userspace only
> > > considers ID_AA64ZFR0_EL1, while this is only valid when
> > > ID_AA64PFR0_EL1.SVE advertises that SVE is actually supported.
> > > 
> > > The expectations are that when ID_AA64PFR0_EL1.SVE is 0, the
> > > ID_AA64ZFR0_EL1 register is also 0. So far, so good.
> > > 
> > > Things become a bit more interesting if the HW implements SME.
> > > In this case, a few ID_AA64ZFR0_EL1 fields indicate *SME*
> > > features. And these fields overlap with their SVE interpretations.
> > > But the architecture says that the SME and SVE feature sets must
> > > match, so we're still hunky-dory.
> > > 
> > > This goes wrong if the HW implements SME, but not SVE. In this
> > > case, we end-up advertising some SVE features to userspace, even
> > > if the HW has none. That's because we never consider whether SVE
> > > is actually implemented. Oh well.
> > 
> > Ugh; this is a massive pain. :(
> > 
> > Was this found by inspection, or is some real software going wrong?
> 
> Catalin can comment on that -- I understand that he found existing SW
> latching on SVE2 being wrongly advertised as hwcaps.
> 
> > > Fix it by restricting all SVE capabilities to ID_AA64PFR0_EL1.SVE
> > > being non-zero.
> > 
> > Unfortunately, I'm not sure this fix is correct+complete.
> > 
> > We expose ID_AA64PFR0_EL1 and ID_AA64ZFR0_EL1 via ID register emulation,
> > so any userspace software reading ID_AA64ZFR0_EL1 will encounter the
> > same surprise. If we hide that I'm worried we might hide some SME-only
> > information that isn't exposed elsewhere, and I'm not sure we can
> > reasonably hide ID_AA64ZFR0_EL1 emulation for SME-only (more on that
> > below).
> 
> I don't understand where things go wrong. EL0 SW that looks at the ID
> registers should perform similar checks, and we are not trying to make
> things better on that front (we can't). Unless you invent time travel
> and fix the architecture 5 years ago... :-/

Fair enough; if we say software consuming ID_AA64ZFR0_EL1 must check
ID_AA64PFR0_EL1.SVE or ID_AA64PFR1_EL1.SME first, and we leave the
emulation of ID_AA64ZFR0_EL1 as-is, that's fine by me.

> The hwcaps are effectively demultiplexing the ID registers, and they
> have to be exact, which is what this patch provides (SVE2 doesn't get
> wrongly advertised when not present).

> > Secondly, all our HWCAP documentation is written in the form:
> > 
> > | HWCAP2_SVEBF16
> > |     Functionality implied by ID_AA64ZFR0_EL1.BF16 == 0b0001.
> > 
> > ... so while the architectural behaviour is a surprise, the kernel is
> > (techincallyy) behaving exactly as documented prior to this patch. Maybe
> > we need to change that documentation?
> 
> Again, I don't see what goes wrong here. BF16 is only implemented for
> SVE or SME+FA64, and FA64 requires SVE2. So at least for that one, we
> should be good.

That was probably a bad example. What I was trying to get at is that the
HWCAPs are behavind exactly *as documented*, but that's not what we
actually want them to describe. For example, SVE2 is described as:

| Functionality implied by ID_AA64ZFR0_EL1.SVEver == 0b0001.

... which is exactly what we check today, but that doesn't
architecturally imply FEAT_SVE2 on SME-only HW where it can apparently
be 0b0001 due to FEAT_SME alone.

So to match the code change we'd need to change that to something like:

| Functionality impled by ID_AA64PFR0_EL1 == 0b0001 and
| ID_AA64ZFR0_EL1.SVEver == 0b0001

... with similar for other hwcaps.

> > Do we have equivalent SME hwcaps for the relevant features?
> >
> > ... looking at:
> > 
> >   https://developer.arm.com/documentation/ddi0601/2024-12/AArch64-Registers/ID-AA64ZFR0-EL1--SVE-Feature-ID-Register-0?lang=en
> > 
> > ... I see that ID_AA64ZFR0_EL1.B16B16 >= 0b0010 implies the presence of
> > SME BFMUL and BFSCALE instructions, but I don't see something equivalent
> > in ID_AA64SMFR0_EL1 per:
> > 
> >   https://developer.arm.com/documentation/ddi0601/2024-12/AArch64-Registers/ID-AA64SMFR0-EL1--SME-Feature-ID-Register-0?lang=en
> > 
> > ... so I suspect ID_AA64ZFR0_EL1 might be the only source of truth for
> > this.
> 
> Indeed, and the SME HWCAPs are not doing the right thing either. Or
> rather, we have no way to tell userspace that BFMUL/BFSCALE are
> available.

To be clear, I'm happy to punt on adding SME-specific HWCAPs, I just
want to make sure we're agreed as to whether the existing HWCAPs should
be SVE-specific, which it sounds like we are?

Mark.

