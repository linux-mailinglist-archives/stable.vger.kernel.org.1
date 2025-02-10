Return-Path: <stable+bounces-114696-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0D0A2F51D
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 18:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D217A3AA236
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 17:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F72C255E4C;
	Mon, 10 Feb 2025 17:22:07 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2323F255E49
	for <stable@vger.kernel.org>; Mon, 10 Feb 2025 17:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739208127; cv=none; b=bZstjg9YxYWSj8T8fMlYEWqxoIWDoYd46avWKXt6524IbEsgcuo9NsSY/8MKAmDaiksOlrkSl94+WhUWkC6hUlWGfD9gQrR8VoJOeGND582mjZVbziBFLiI8H2UL8ljqHuCzCAjMDUWT+JS0j3kQrq0dsVgmuXuSlWFK0SJA7UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739208127; c=relaxed/simple;
	bh=J+b3teOJ96VB98T8v05ziixP6IhO/vv2MEtW5qFIJEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uhLtaDBl/LALsXq8J0tCmJwFhqabQF59gj1YFBqMYwlslTOUOdG0ho/gssy9A+qBSweJ2SClIKfmWzPdCP3CoZTLYpPNsBwZX8pC6HnF3zlahLXQUlyROYBRA6YXo6yYfSr3P7xyVI3ohDM69QS/a36/kPmd9YJPf3iGoddhUVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CA1731477;
	Mon, 10 Feb 2025 09:22:25 -0800 (PST)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EBB193F58B;
	Mon, 10 Feb 2025 09:22:01 -0800 (PST)
Date: Mon, 10 Feb 2025 17:21:59 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, broonie@kernel.org,
	catalin.marinas@arm.com, eauger@redhat.com, eric.auger@redhat.com,
	fweimer@redhat.com, jeremy.linton@arm.com, maz@kernel.org,
	oliver.upton@linux.dev, pbonzini@redhat.com, stable@vger.kernel.org,
	tabba@google.com, wilco.dijkstra@arm.com
Subject: Re: [PATCH v2 8/8] KVM: arm64: Eagerly switch ZCR_EL{1,2}
Message-ID: <Z6o1t7ys2qVaZ-7n@J2N7QTR9R3>
References: <20250206141102.954688-1-mark.rutland@arm.com>
 <20250206141102.954688-9-mark.rutland@arm.com>
 <20250210165325.GI7568@willie-the-truck>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210165325.GI7568@willie-the-truck>

On Mon, Feb 10, 2025 at 04:53:27PM +0000, Will Deacon wrote:
> On Thu, Feb 06, 2025 at 02:11:02PM +0000, Mark Rutland wrote:
> > Fix this and make this a bit easier to reason about by always eagerly
> > switching ZCR_EL{1,2} at hyp during guest<->host transitions. With this
> > happening, there's no need to trap host SVE usage, and the nVHE/nVHVE
> 
> nit: nVHVE?
> 
> (also, note to Fuad: I think we're trapping FPSIMD/SVE from the host with
>  pKVM in Android, so we'll want to fix that when we take this patch via
>  -stable)
> 
> > __deactivate_cptr_traps() logic can be simplified enable host access to
> 
> nit: to enable
> 
> > all present FPSIMD/SVE/SME features.
> > 
> > In protected nVHE/hVHVE modes, the host's state is always saved/restored
> 
> nit: hVHVE
> 
> (something tells me these acronyms aren't particularly friendly!)

Aargh, sorry about those -- I've fixed those up and I'll give the series
another once-over.

[...]

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
> > +		write_sysreg_el2(zcr_el2, SYS_ZCR);
> > +
> > +		zcr_el1 = __vcpu_sys_reg(vcpu, vcpu_sve_zcr_elx(vcpu));
> > +		write_sysreg_el1(zcr_el1, SYS_ZCR);
> > +	}
> > +}
> > +
> > +static inline void fpsimd_lazy_switch_to_host(struct kvm_vcpu *vcpu)
> > +{
> > +	u64 zcr_el1, zcr_el2;
> > +
> > +	if (!guest_owns_fp_regs())
> > +		return;
> > +
> > +	if (vcpu_has_sve(vcpu)) {
> > +		zcr_el1 = read_sysreg_el1(SYS_ZCR);
> > +		__vcpu_sys_reg(vcpu, vcpu_sve_zcr_elx(vcpu)) = zcr_el1;
> > +
> > +		/*
> > +		 * The guest's state is always saved using the guest's max VL.
> > +		 * Ensure that the host has the guest's max VL active such that
> > +		 * the host can save the guest's state lazily, but don't
> > +		 * artificially restrict the host to the guest's max VL.
> > +		 */
> > +		if (has_vhe()) {
> > +			zcr_el2 = vcpu_sve_max_vq(vcpu) - 1;
> > +			write_sysreg_el2(zcr_el2, SYS_ZCR);
> > +		} else {
> > +			zcr_el2 = sve_vq_from_vl(kvm_host_sve_max_vl) - 1;
> > +			write_sysreg_el2(zcr_el2, SYS_ZCR);
> > +
> > +			zcr_el1 = vcpu_sve_max_vq(vcpu) - 1;
> > +			write_sysreg_el1(zcr_el1, SYS_ZCR);
> 
> Do we need an ISB before this to make sure that the CPTR traps have been
> deactivated properly?

Sorry, I had meant to add a comment here that this relies upon a
subtlety that avoids the need for the ISB.

When the guest owns the FP regs here, we know:

* If the guest doesn't have SVE, then we're not poking anything, and so
  no ISB is necessary.

* If the guest has SVE, then either:

  - The guest owned the FP regs when it was entered.

  - The guest *didn't* own the FP regs when it was entered, but acquired
    ownership via a trap which executed kvm_hyp_handle_fpsimd().

  ... and in either case, *after* disabling the traps there's been an
  ERET to the guest and an exception back to hyp, either of which
  provides the necessary context synchronization such that the traps are
  disabled here.

Does that make sense to you?

Mark.

