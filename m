Return-Path: <stable+bounces-114064-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 785E9A2A5D1
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 11:28:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A2ED160AA2
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 10:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F53622686A;
	Thu,  6 Feb 2025 10:28:43 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188EA226553
	for <stable@vger.kernel.org>; Thu,  6 Feb 2025 10:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738837723; cv=none; b=rCf8yRBu4H1Z1sEwHyXSqnugoMzeA5dqEgZnj2hok+jFFCNV6Q5ZE9ekkQ2T6JIHSounlNhFuZQi8qbGZgUpFqi5Z2e6qrH25y1LiRBHqT//3G83HjiPpGCJjiPeGaRh4AH4ePIPzXt+qLOjZCEZu2fHrywardWF+33HjAyxDIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738837723; c=relaxed/simple;
	bh=7shIeqFxoByejGhwrum3zyYrt0zqqhRUn8TGl+XPb4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HeTUifo1wu39LpQRdl0bHHPsvjp5NVo/ixk5V4Rdagh91yBHhq80HZ7NwqgvyVobXzglLi5sPMPHoIllZbOeTRidw9LJaUuY6Beo0umvpXK6JztMZasqXjR6Cjxm7/7fQ3YK5B0mE23veOULHZAF87UQTPDeEAsFmAqBBRXZtpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7740112FC;
	Thu,  6 Feb 2025 02:29:03 -0800 (PST)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D961A3F63F;
	Thu,  6 Feb 2025 02:28:37 -0800 (PST)
Date: Thu, 6 Feb 2025 10:28:35 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Marc Zyngier <maz@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, broonie@kernel.org,
	catalin.marinas@arm.com, eauger@redhat.com, fweimer@redhat.com,
	jeremy.linton@arm.com, oliver.upton@linux.dev, pbonzini@redhat.com,
	stable@vger.kernel.org, tabba@google.com, wilco.dijkstra@arm.com,
	will@kernel.org
Subject: Re: [PATCH 8/8] KVM: arm64: Eagerly switch ZCR_EL{1,2}
Message-ID: <Z6SO0x-T4QRT31Y_@J2N7QTR9R3>
References: <20250204152100.705610-1-mark.rutland@arm.com>
 <20250204152100.705610-9-mark.rutland@arm.com>
 <861pwdvbd3.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <861pwdvbd3.wl-maz@kernel.org>

On Tue, Feb 04, 2025 at 06:00:24PM +0000, Marc Zyngier wrote:
> On Tue, 04 Feb 2025 15:21:00 +0000,
> Mark Rutland <mark.rutland@arm.com> wrote:

> > +static inline void fpsimd_lazy_switch_to_guest(struct kvm_vcpu *vcpu)
> > +{
> > +	u64 zcr_el1, zcr_el2;
> > +
> > +	if (!guest_owns_fp_regs())
> > +		return;
> > +
> > +	if (vcpu_has_sve(vcpu)) {
> > +		/* A guest hypervisor may restrict the effective max VL. */
> > +		if (vcpu_has_nv(vcpu) && !is_hyp_ctxt(vcpu))
> > +			zcr_el2 = __vcpu_sys_reg(vcpu, ZCR_EL2);
> > +		else
> > +			zcr_el2 = vcpu_sve_max_vq(vcpu) - 1;
> > +
> > +		sve_cond_update_zcr_vq(zcr_el2, SYS_ZCR_EL2);
> 
> Not a big deal, but I though I'd mention it here: Using ZCR_EL2 (or
> any other register using the _EL2 suffix) is a source of expensive
> traps with NV. We're much better off using the _EL1 accessor if we are
> running VHE, as this will involve no trap at all.
> 
> nVHE will of course trap, but using nVHE with SVE under NV is not
> something I'm prepared to give a damn about.

Ah, sorry. I had forgotten that wrinkle.

Given the compiler warnings reported by Mark Brown [1] and the kernel
test robot [2], I'll go spin a v2 with that cleaned up.

I'll use write_sysreg_el2() here, i.e.

	if (vcpu_has_sve(vcpu)) {
		/* A guest hypervisor may restrict the effective max VL. */
		if (vcpu_has_nv(vcpu) && !is_hyp_ctxt(vcpu))
			zcr_el2 = __vcpu_sys_reg(vcpu, ZCR_EL2);
		else
			zcr_el2 = vcpu_sve_max_vq(vcpu) - 1;

		write_sysreg_el2(scr_el2, SYS_ZCR);
	}

That'll use the preferred alias automatically, and it matches the style
used to write to ZCR_EL{1,12} immediately after.

Likewise for the other instances.

Mark.

[1] https://lore.kernel.org/linux-arm-kernel/b76803b7-c1b3-426b-a375-0c01b98142c9@sirena.org.uk/
[2] https://lore.kernel.org/oe-kbuild-all/202502061341.FvsCMKEH-lkp@intel.com/

