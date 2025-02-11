Return-Path: <stable+bounces-114951-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F9BA3149F
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 20:08:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D6BD1889249
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 19:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70EC26215A;
	Tue, 11 Feb 2025 19:08:28 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D9C261594
	for <stable@vger.kernel.org>; Tue, 11 Feb 2025 19:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739300908; cv=none; b=d34gCpt+Kdda1JGwVNWfRQ+l6iZMu9BdJgBlotIp1gVHPUQZW7KL36+rYsIiNvkINk0Vkb5BC+c1gT1Tx4lJ70jIUKnBcOnPn90NrZ+t05xZrZIQzyMcfSPgjHd8aaz8KT3IdTMVABh/TBAJtQqdDbDcN4J+Wrs6ptQU6SkwhS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739300908; c=relaxed/simple;
	bh=trUef6wjL21v9ToDveEuYlqYl4OBqSeWpEKY2F+DBYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EyTvmFaWBQPvg0nTqP1P12wOfJDI8RscbDcQ7EoirgXVEObJGMQvcw/C1+pGA0EqnU5J9RmXU+3N2Y7dpk/kogXUq1/ACAURqSF94ACyObuTPh6ZlnzZHm+rMJ2TRoAZxBMGtdvNvSF7Vfx/3uRDvYWX+6bhAVjETkfB7EqdZSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 149FE13D5;
	Tue, 11 Feb 2025 11:08:47 -0800 (PST)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AE6023F58B;
	Tue, 11 Feb 2025 11:08:23 -0800 (PST)
Date: Tue, 11 Feb 2025 19:08:15 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, broonie@kernel.org,
	catalin.marinas@arm.com, eauger@redhat.com, eric.auger@redhat.com,
	fweimer@redhat.com, jeremy.linton@arm.com, maz@kernel.org,
	oliver.upton@linux.dev, pbonzini@redhat.com, stable@vger.kernel.org,
	tabba@google.com, wilco.dijkstra@arm.com
Subject: Re: [PATCH v2 2/8] KVM: arm64: Remove host FPSIMD saving for
 non-protected KVM
Message-ID: <Z6ugHxri_XlOMKWD@J2N7QTR9R3>
References: <20250206141102.954688-1-mark.rutland@arm.com>
 <20250206141102.954688-3-mark.rutland@arm.com>
 <20250210161242.GC7568@willie-the-truck>
 <Z6owjEPNaJ55e9LM@J2N7QTR9R3>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6owjEPNaJ55e9LM@J2N7QTR9R3>

On Mon, Feb 10, 2025 at 05:00:04PM +0000, Mark Rutland wrote:
> | static inline bool kvm_hyp_handle_fpsimd(struct kvm_vcpu *vcpu, u64 *exit_code)
> | {
> | 	...
> | 
> | 	/* Valid trap */
> | 
> | 	/*
> | 	 * Enable everything EL2 might need to save/restore state.
> | 	 * Maybe each of the bits should depend on system_has_xxx()
> | 	 */
> | 	cpacr_clear_set(0, CPACR_EL1_FPEN | CPACR_EL1_ZEN | CPACR_EL1_SMEN */
> | 	isb();
> | 
> | 	...
> | 
> | 	/* Write out the host state if it's in the registers */
> | 	if (is_protected_kvm_enabled() && host_owns_fp_regs())
> | 		kvm_hyp_save_fpsimd_host(vcpu);
> | 	
> | 	/* Restore guest state */
> | 
> | 	...
> | 
> | 	/*
> | 	 * Enable traps for the VCPU. The ERET will cause the traps to
> | 	 * take effect in the guest, so no ISB is necessary.
> | 	 */
> | 	cpacr_guest = CPACR_EL1_FPEN;
> | 	if (vcpu_has_sve(vcpu))
> | 		cpacr_guest |= CPACR_EL1_ZEN;
> | 	if (vcpu_has_sme(vcpu))			// whenever we add this
> | 		cpacr_guest |= CPACR_EL1_SMEN;
> | 	cpacr_clear_set(CPACR_EL1_FPEN | CPACR_EL1_ZEN | CPACR_EL1_SMEN,
> | 			cpacr_guest);
> | 
> | 	return true;
> | }
> 
> ... where we'd still have the CPACR write to re-enable traps, but it'd
> be unconditional, and wouldn't need an extra ISB.

I had a quick go at this, and there are a few things that I spotted that
got in the way, so I'm not going to spin that immediately, but I'd be
happy to in a short while. Notes below:

(1) I looked at using __activate_cptr_traps() and
    __deactivate_cptr_traps() rather than poking CPACR/CPTR directly,
    to ensure that this is kept in-sync with the regular guest<->host
    transitions, but that requires a bit of refactoring (e.g. moving
    those *back* into the common header), and potentially requires doing
    a bit of redundant work here, so I'm not sure whether that's
    actually preferable or not.

    If you have a strong preference either way as to doing that or
    poking CPACR/CPTR directly, knowing that would be helfpul.

(2) The cpacr_clear_set() function doesn't behave the same as
    sysreg_clear_set(), and doesn't handle the case where a field is in
    both the 'clr' and 'set' masks as is the case above. For example, if
    one writes the following to clear THEN set the FPEN field, disabling
    traps:

    | cpacr_clear_set(CPACR_EL1_FPEN, CPACR_EL1_FPEN);

    ... the VHE code looks good:

    | mrs     x0, cpacr_el1
    | orr     x1, x0, #0x300000		// set both FPEN bits
    | cmp     x0, x1
    | b.eq    <<skip_write>>
    | msr     cpacr_el1, x1

    ... but the nVHE code does the opposite:

    | mrs     x0, cptr_el2
    | orr     x1, x0, #0x400		// set TFP
    | tbnz    w0, #10, <<skip_write>>
    | msr     cptr_el2, x1

    Luckily this does the right thing for all existing users, but that'd
    need to be cleaned up.

(3) We should be able to get rid of the ISB when writing to FPEXC32_EL2.
    That register has no effect while in AArch64 state, and the ERET
    will synchronize it before AArch32 guest code can be executed.

    That should probably be factored out into save/restore functions
    that are used consistently.

Mark.

