Return-Path: <stable+bounces-114692-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE2AA2F47A
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 18:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66C7A1647CB
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 17:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82FA255E3D;
	Mon, 10 Feb 2025 17:00:07 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A56255E2C
	for <stable@vger.kernel.org>; Mon, 10 Feb 2025 17:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739206807; cv=none; b=uBotdizjj4x0vY1QuVr/BOG5d4TstjvTL6eye+DcUpjOSf0cZzaAdFaNP/vPCveDVfZiBEeY40i2Q6SKTCVABGZPhUds28hd00eKrZCMS6v5gYjtnt3QbwWxeJir5KHy8Ls7cKHeIMFJSqxXayrl3TVQNXwJ/qVF24++7/SGr7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739206807; c=relaxed/simple;
	bh=gEGlMyN4KxD8wEGW8cjK6yiEqE2H6pgZ7cF+GHA/cOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uzUYIbJVKBFImhtXqP5BP31apVsFBl3AwozB5b8rAzbQi3einsNq3aZCg6cJu3K9f5HM/RoyBoKDrs+LHcgPfQx9gEgimxnMxwpA0x1K2rEqwVz54ik3wLyJoGZvocfvWtGsSBHsUJB8xsgTR7oyowrE2rIa1xqilth/kFlDax4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 390341477;
	Mon, 10 Feb 2025 09:00:26 -0800 (PST)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5AEED3F58B;
	Mon, 10 Feb 2025 09:00:02 -0800 (PST)
Date: Mon, 10 Feb 2025 16:59:56 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, broonie@kernel.org,
	catalin.marinas@arm.com, eauger@redhat.com, eric.auger@redhat.com,
	fweimer@redhat.com, jeremy.linton@arm.com, maz@kernel.org,
	oliver.upton@linux.dev, pbonzini@redhat.com, stable@vger.kernel.org,
	tabba@google.com, wilco.dijkstra@arm.com
Subject: Re: [PATCH v2 2/8] KVM: arm64: Remove host FPSIMD saving for
 non-protected KVM
Message-ID: <Z6owjEPNaJ55e9LM@J2N7QTR9R3>
References: <20250206141102.954688-1-mark.rutland@arm.com>
 <20250206141102.954688-3-mark.rutland@arm.com>
 <20250210161242.GC7568@willie-the-truck>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210161242.GC7568@willie-the-truck>

On Mon, Feb 10, 2025 at 04:12:43PM +0000, Will Deacon wrote:
> On Thu, Feb 06, 2025 at 02:10:56PM +0000, Mark Rutland wrote:
> > Now that the host eagerly saves its own FPSIMD/SVE/SME state,
> > non-protected KVM never needs to save the host FPSIMD/SVE/SME state,
> > and the code to do this is never used. Protected KVM still needs to
> > save/restore the host FPSIMD/SVE state to avoid leaking guest state to
> > the host (and to avoid revealing to the host whether the guest used
> > FPSIMD/SVE/SME), and that code needs to be retained.
> > 
> > Remove the unused code and data structures.
> > 
> > To avoid the need for a stub copy of kvm_hyp_save_fpsimd_host() in the
> > VHE hyp code, the nVHE/hVHE version is moved into the shared switch
> > header, where it is only invoked when KVM is in protected mode.
> > 
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > Reviewed-by: Mark Brown <broonie@kernel.org>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Fuad Tabba <tabba@google.com>
> > Cc: Marc Zyngier <maz@kernel.org>
> > Cc: Mark Brown <broonie@kernel.org>
> > Cc: Oliver Upton <oliver.upton@linux.dev>
> > Cc: Will Deacon <will@kernel.org>
> > ---
> >  arch/arm64/include/asm/kvm_host.h       | 20 +++++-------------
> >  arch/arm64/kvm/arm.c                    |  8 -------
> >  arch/arm64/kvm/fpsimd.c                 |  2 --
> >  arch/arm64/kvm/hyp/include/hyp/switch.h | 25 ++++++++++++++++++++--
> >  arch/arm64/kvm/hyp/nvhe/hyp-main.c      |  2 +-
> >  arch/arm64/kvm/hyp/nvhe/switch.c        | 28 -------------------------
> >  arch/arm64/kvm/hyp/vhe/switch.c         |  8 -------
> >  7 files changed, 29 insertions(+), 64 deletions(-)
> 
> [...]
> 
> > diff --git a/arch/arm64/kvm/hyp/include/hyp/switch.h b/arch/arm64/kvm/hyp/include/hyp/switch.h
> > index f838a45665f26..c5b8a11ac4f50 100644
> > --- a/arch/arm64/kvm/hyp/include/hyp/switch.h
> > +++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
> > @@ -375,7 +375,28 @@ static inline void __hyp_sve_save_host(void)
> >  			 true);
> >  }
> >  
> > -static void kvm_hyp_save_fpsimd_host(struct kvm_vcpu *vcpu);
> > +static void kvm_hyp_save_fpsimd_host(struct kvm_vcpu *vcpu)
> > +{
> > +	/*
> > +	 * Non-protected kvm relies on the host restoring its sve state.
> > +	 * Protected kvm restores the host's sve state as not to reveal that
> > +	 * fpsimd was used by a guest nor leak upper sve bits.
> > +	 */
> > +	if (system_supports_sve()) {
> > +		__hyp_sve_save_host();
> > +
> > +		/* Re-enable SVE traps if not supported for the guest vcpu. */
> > +		if (!vcpu_has_sve(vcpu))
> > +			cpacr_clear_set(CPACR_EL1_ZEN, 0);
> > +
> > +	} else {
> > +		__fpsimd_save_state(host_data_ptr(host_ctxt.fp_regs));
> > +	}
> > +
> > +	if (kvm_has_fpmr(kern_hyp_va(vcpu->kvm)))
> > +		*host_data_ptr(fpmr) = read_sysreg_s(SYS_FPMR);
> > +}
> > +
> >  
> >  /*
> >   * We trap the first access to the FP/SIMD to save the host context and
> > @@ -425,7 +446,7 @@ static bool kvm_hyp_handle_fpsimd(struct kvm_vcpu *vcpu, u64 *exit_code)
> >  	isb();
> >  
> >  	/* Write out the host state if it's in the registers */
> > -	if (host_owns_fp_regs())
> > +	if (is_protected_kvm_enabled() && host_owns_fp_regs())
> >  		kvm_hyp_save_fpsimd_host(vcpu);
> 
> I wondered briefly whether this would allow us to clean up the CPACR
> handling a little and avoid the conditional SVE trap re-enabling inside
> kvm_hyp_save_fpsimd_host() but I couldn't come up with a clean way to
> do it without an additional ISB. Hrm.
> 
> Anyway, as far as the patch goes:
> 
> Acked-by: Will Deacon <will@kernel.org>

Thanks!

FWIW, I'd also considered that, and I'd concluded that if anything we
could do a subsequent simplification by pulling that out of
kvm_hyp_save_fpsimd_host() and have kvm_hyp_handle_fpsimd() do something
like:

| static inline bool kvm_hyp_handle_fpsimd(struct kvm_vcpu *vcpu, u64 *exit_code)
| {
| 	...
| 
| 	/* Valid trap */
| 
| 	/*
| 	 * Enable everything EL2 might need to save/restore state.
| 	 * Maybe each of the bits should depend on system_has_xxx()
| 	 */
| 	cpacr_clear_set(0, CPACR_EL1_FPEN | CPACR_EL1_ZEN | CPACR_EL1_SMEN */
| 	isb();
| 
| 	...
| 
| 	/* Write out the host state if it's in the registers */
| 	if (is_protected_kvm_enabled() && host_owns_fp_regs())
| 		kvm_hyp_save_fpsimd_host(vcpu);
| 	
| 	/* Restore guest state */
| 
| 	...
| 
| 	/*
| 	 * Enable traps for the VCPU. The ERET will cause the traps to
| 	 * take effect in the guest, so no ISB is necessary.
| 	 */
| 	cpacr_guest = CPACR_EL1_FPEN;
| 	if (vcpu_has_sve(vcpu))
| 		cpacr_guest |= CPACR_EL1_ZEN;
| 	if (vcpu_has_sme(vcpu))			// whenever we add this
| 		cpacr_guest |= CPACR_EL1_SMEN;
| 	cpacr_clear_set(CPACR_EL1_FPEN | CPACR_EL1_ZEN | CPACR_EL1_SMEN,
| 			cpacr_guest);
| 
| 	return true;
| }

... where we'd still have the CPACR write to re-enable traps, but it'd
be unconditional, and wouldn't need an extra ISB.

If that makes sense to you, I can go spin that as a subsequent cleanup
atop this series.

Mark.

