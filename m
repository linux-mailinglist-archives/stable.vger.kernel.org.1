Return-Path: <stable+bounces-114707-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07DA9A2F800
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 19:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE4A93A6F10
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 18:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC46025E450;
	Mon, 10 Feb 2025 18:57:02 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380D425E444
	for <stable@vger.kernel.org>; Mon, 10 Feb 2025 18:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739213822; cv=none; b=nyEY8FzK6FPaRtopDanyT/xgDXXX7XRiyTGR6HYCO/mIe2n8+AredObXyVS7+WT6tBq+CrFrY/m81Hht75GoGxP0cPGLR6xkuLhS9bxDtD58RyUJ6ErwE3KL7YtZ4l2XHNpplwD7ZszwIHIP9NpFK90GnCTOd6soapG9zKndRw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739213822; c=relaxed/simple;
	bh=BV/j0szbMS+AKpEtgGQ0ZRsMB1+AGXw31OIe3ZPKRxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nlOJE8icDGyArgv1UgT90k68DO5laian2hoNbRTWiUKmvdVSMbD0iS8wX4/Mr4o5j30YRmklfuMhx5fLaJ2R/5rAOV/miGpQq6Og0NIpsv3+d+3gS0pzoyTxCjyd2Hdd2h3wpyCmA7Tx77iaoOwzgnGg8DG8c88X9Y6lt7HZfuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E80021477;
	Mon, 10 Feb 2025 10:57:18 -0800 (PST)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BE53E3F6A8;
	Mon, 10 Feb 2025 10:56:54 -0800 (PST)
Date: Mon, 10 Feb 2025 18:56:51 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, broonie@kernel.org,
	catalin.marinas@arm.com, eauger@redhat.com, eric.auger@redhat.com,
	fweimer@redhat.com, jeremy.linton@arm.com, maz@kernel.org,
	oliver.upton@linux.dev, pbonzini@redhat.com, stable@vger.kernel.org,
	tabba@google.com, wilco.dijkstra@arm.com
Subject: Re: [PATCH v2 8/8] KVM: arm64: Eagerly switch ZCR_EL{1,2}
Message-ID: <Z6pL81_yi98o2vtS@J2N7QTR9R3>
References: <20250206141102.954688-1-mark.rutland@arm.com>
 <20250206141102.954688-9-mark.rutland@arm.com>
 <20250210165325.GI7568@willie-the-truck>
 <Z6o1t7ys2qVaZ-7n@J2N7QTR9R3>
 <20250210182009.GB7926@willie-the-truck>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210182009.GB7926@willie-the-truck>

On Mon, Feb 10, 2025 at 06:20:09PM +0000, Will Deacon wrote:
> On Mon, Feb 10, 2025 at 05:21:59PM +0000, Mark Rutland wrote:
> > On Mon, Feb 10, 2025 at 04:53:27PM +0000, Will Deacon wrote:
> > > On Thu, Feb 06, 2025 at 02:11:02PM +0000, Mark Rutland wrote:
> > > > +static inline void fpsimd_lazy_switch_to_host(struct kvm_vcpu *vcpu)
> > > > +{
> > > > +	u64 zcr_el1, zcr_el2;
> > > > +
> > > > +	if (!guest_owns_fp_regs())
> > > > +		return;
> > > > +
> > > > +	if (vcpu_has_sve(vcpu)) {
> > > > +		zcr_el1 = read_sysreg_el1(SYS_ZCR);
> > > > +		__vcpu_sys_reg(vcpu, vcpu_sve_zcr_elx(vcpu)) = zcr_el1;
> > > > +
> > > > +		/*
> > > > +		 * The guest's state is always saved using the guest's max VL.
> > > > +		 * Ensure that the host has the guest's max VL active such that
> > > > +		 * the host can save the guest's state lazily, but don't
> > > > +		 * artificially restrict the host to the guest's max VL.
> > > > +		 */
> > > > +		if (has_vhe()) {
> > > > +			zcr_el2 = vcpu_sve_max_vq(vcpu) - 1;
> > > > +			write_sysreg_el2(zcr_el2, SYS_ZCR);
> > > > +		} else {
> > > > +			zcr_el2 = sve_vq_from_vl(kvm_host_sve_max_vl) - 1;
> > > > +			write_sysreg_el2(zcr_el2, SYS_ZCR);
> > > > +
> > > > +			zcr_el1 = vcpu_sve_max_vq(vcpu) - 1;
> > > > +			write_sysreg_el1(zcr_el1, SYS_ZCR);
> > > 
> > > Do we need an ISB before this to make sure that the CPTR traps have been
> > > deactivated properly?
> > 
> > Sorry, I had meant to add a comment here that this relies upon a
> > subtlety that avoids the need for the ISB.
> 
> Ah yes, it really all hinges on guest_owns_fp_regs() and so I think a
> comment would be helpful, thanks.
> 
> Just on this, though:
> 
> > When the guest owns the FP regs here, we know:
> > 
> > * If the guest doesn't have SVE, then we're not poking anything, and so
> >   no ISB is necessary.
> > 
> > * If the guest has SVE, then either:
> > 
> >   - The guest owned the FP regs when it was entered.
> > 
> >   - The guest *didn't* own the FP regs when it was entered, but acquired
> >     ownership via a trap which executed kvm_hyp_handle_fpsimd().
> > 
> >   ... and in either case, *after* disabling the traps there's been an
> >   ERET to the guest and an exception back to hyp, either of which
> >   provides the necessary context synchronization such that the traps are
> >   disabled here.
> 
> What about the case where we find that there's an interrupt pending on
> return to the guest? In that case, I think we elide the ERET and go back
> to the host (see the check of isr_el1 in hyp/entry.S).

Ah; I had missed that, and evidently I had not looked at the entry code.

Given that, I think the options are:

(a) Add an ISB after disabling the traps, before returning to the guest.

(b) Add an ISB in fpsimd_lazy_switch_to_host() above.

(c) Add an ISB in that sequence in hyp/entry.S, just before the ret, to
    ensure that __guest_enter() always provides a context
    synchronization event even when it doesn't enter the guest,
    regardless of ARM64_HAS_RAS_EXTN.

I think (c) is probably the nicest, since that avoids the need for
redundant barriers in the common case, and those short-circuited exits
are hopefully rare.

Obviously that would mean adding comments in both __guest_enter() and
fpsimd_lazy_switch_to_host().

Mark.

