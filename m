Return-Path: <stable+bounces-114705-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3FDA2F6C5
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 19:20:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 878A11881944
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 18:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752E4255E4C;
	Mon, 10 Feb 2025 18:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HHaCjUey"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E5425B690
	for <stable@vger.kernel.org>; Mon, 10 Feb 2025 18:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739211616; cv=none; b=DriWpAvS4IeAiXpq47VACAOTWLzVVtGt6cQNixEBwzQkpu9N4a9XE6jw+CB7AS9Q41EBmw4kXEY9CL/bmwYKSsw/u6meeUFEXcW7doCaTmP1EAkGbncqnW1irqIzS7kLb2vN7v0ZMCEUsqyO0744V7coNXkLlH+58XGvmVk6B8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739211616; c=relaxed/simple;
	bh=W3QAGc5LW3FYdLUn7iW7HNDDQXI4yVqVYSST3W+bEUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LFptmkSEakEqR/H4fRzxoB7p/1HsFBiYaPQ5A1NDws8GLUyCPyS1J5ogkMInzIjBobKUWfYeae3IPSfi53Ofvu2niF67mfvMUutv5ih44cZ+c+zD7ewbw4BsHbvdv5Tw95HxzEq+iV/26ZkMEN+TPAMEzFHlfn0eNjFGeO5jnaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HHaCjUey; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 427D2C4CED1;
	Mon, 10 Feb 2025 18:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739211615;
	bh=W3QAGc5LW3FYdLUn7iW7HNDDQXI4yVqVYSST3W+bEUg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HHaCjUeyImHZ6oNFBg92Mgwpw1VlhwyRXcVk5+i5KnHOxhoj+D8FKbbxReonNCz6b
	 ESPMZaTfyYTtSVgGDUFPbObpAvagpxDhS9xjOCWiYpdR15N3XTKvNRj+0A3biZWbC1
	 +U12EMiYZjVXVOnbYqujQXyHuGM5PwzkQnlpYz2x7eBwMU5RtcqPQCzKVQ3SPbqzxz
	 25X1KqKBieCA12R+tMkcoPE8VtVuZrOCafycAwIgJTuLizifrdxJ+g6UsUec5MbY/0
	 dGAGnTPgdlKFe3IDrbHdAwdktxM7x7mT3cCOn4E2xjHBPywSfLZZla8/OebUknXsxb
	 7WoMtL0BHqRQw==
Date: Mon, 10 Feb 2025 18:20:09 +0000
From: Will Deacon <will@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, broonie@kernel.org,
	catalin.marinas@arm.com, eauger@redhat.com, eric.auger@redhat.com,
	fweimer@redhat.com, jeremy.linton@arm.com, maz@kernel.org,
	oliver.upton@linux.dev, pbonzini@redhat.com, stable@vger.kernel.org,
	tabba@google.com, wilco.dijkstra@arm.com
Subject: Re: [PATCH v2 8/8] KVM: arm64: Eagerly switch ZCR_EL{1,2}
Message-ID: <20250210182009.GB7926@willie-the-truck>
References: <20250206141102.954688-1-mark.rutland@arm.com>
 <20250206141102.954688-9-mark.rutland@arm.com>
 <20250210165325.GI7568@willie-the-truck>
 <Z6o1t7ys2qVaZ-7n@J2N7QTR9R3>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6o1t7ys2qVaZ-7n@J2N7QTR9R3>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, Feb 10, 2025 at 05:21:59PM +0000, Mark Rutland wrote:
> On Mon, Feb 10, 2025 at 04:53:27PM +0000, Will Deacon wrote:
> > On Thu, Feb 06, 2025 at 02:11:02PM +0000, Mark Rutland wrote:
> > > +static inline void fpsimd_lazy_switch_to_host(struct kvm_vcpu *vcpu)
> > > +{
> > > +	u64 zcr_el1, zcr_el2;
> > > +
> > > +	if (!guest_owns_fp_regs())
> > > +		return;
> > > +
> > > +	if (vcpu_has_sve(vcpu)) {
> > > +		zcr_el1 = read_sysreg_el1(SYS_ZCR);
> > > +		__vcpu_sys_reg(vcpu, vcpu_sve_zcr_elx(vcpu)) = zcr_el1;
> > > +
> > > +		/*
> > > +		 * The guest's state is always saved using the guest's max VL.
> > > +		 * Ensure that the host has the guest's max VL active such that
> > > +		 * the host can save the guest's state lazily, but don't
> > > +		 * artificially restrict the host to the guest's max VL.
> > > +		 */
> > > +		if (has_vhe()) {
> > > +			zcr_el2 = vcpu_sve_max_vq(vcpu) - 1;
> > > +			write_sysreg_el2(zcr_el2, SYS_ZCR);
> > > +		} else {
> > > +			zcr_el2 = sve_vq_from_vl(kvm_host_sve_max_vl) - 1;
> > > +			write_sysreg_el2(zcr_el2, SYS_ZCR);
> > > +
> > > +			zcr_el1 = vcpu_sve_max_vq(vcpu) - 1;
> > > +			write_sysreg_el1(zcr_el1, SYS_ZCR);
> > 
> > Do we need an ISB before this to make sure that the CPTR traps have been
> > deactivated properly?
> 
> Sorry, I had meant to add a comment here that this relies upon a
> subtlety that avoids the need for the ISB.

Ah yes, it really all hinges on guest_owns_fp_regs() and so I think a
comment would be helpful, thanks.

Just on this, though:

> When the guest owns the FP regs here, we know:
> 
> * If the guest doesn't have SVE, then we're not poking anything, and so
>   no ISB is necessary.
> 
> * If the guest has SVE, then either:
> 
>   - The guest owned the FP regs when it was entered.
> 
>   - The guest *didn't* own the FP regs when it was entered, but acquired
>     ownership via a trap which executed kvm_hyp_handle_fpsimd().
> 
>   ... and in either case, *after* disabling the traps there's been an
>   ERET to the guest and an exception back to hyp, either of which
>   provides the necessary context synchronization such that the traps are
>   disabled here.

What about the case where we find that there's an interrupt pending on
return to the guest? In that case, I think we elide the ERET and go back
to the host (see the check of isr_el1 in hyp/entry.S).

Will

