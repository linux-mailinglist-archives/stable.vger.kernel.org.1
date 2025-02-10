Return-Path: <stable+bounces-114724-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39EB7A2F9AD
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 21:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 984D91883CE1
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 20:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D170B1F4611;
	Mon, 10 Feb 2025 20:03:14 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5481A25C703
	for <stable@vger.kernel.org>; Mon, 10 Feb 2025 20:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739217794; cv=none; b=qtXW9Z4bk+NBMHJ7o04CRY08j7O/LXK2JS3sv+m0TYf8pbBa8GIK0cPJLtMGKA80dofcfQ8qM/cDYH7U2OJ42dgqykLNlDRIuhzl5RUOj2wZZbp2gm3Fq9qUyuFrV76uZ1UiNgsQZgvJWxQwIF8N6p7kGY2iOb4FZxP5bbG91Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739217794; c=relaxed/simple;
	bh=nL6VKxbQCUIRxqnTZXMCDCfw+YN1nibOYI18IrifkTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G4qsDKbBKVKOD9tzUlF4W1FuEpSElAZ+YpLH1BSFJpu1sMbm8G0xSJL/aqm3564xgfqW8i/K2q1owSipVAXDmwyP6vgGqZGJycmrX+7yvSvCl/VZ54hXGamuCfLIljC0W2RBwP9eBIcRboBIyFvNb0PjMH5xv7vkrnIXvdhXizk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F7551477;
	Mon, 10 Feb 2025 12:03:34 -0800 (PST)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 496553F58B;
	Mon, 10 Feb 2025 12:03:10 -0800 (PST)
Date: Mon, 10 Feb 2025 20:03:04 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, broonie@kernel.org,
	catalin.marinas@arm.com, eauger@redhat.com, eric.auger@redhat.com,
	fweimer@redhat.com, jeremy.linton@arm.com, maz@kernel.org,
	oliver.upton@linux.dev, pbonzini@redhat.com, stable@vger.kernel.org,
	tabba@google.com, wilco.dijkstra@arm.com
Subject: Re: [PATCH v2 2/8] KVM: arm64: Remove host FPSIMD saving for
 non-protected KVM
Message-ID: <Z6pbeIsIMWexiDta@J2N7QTR9R3>
References: <20250206141102.954688-1-mark.rutland@arm.com>
 <20250206141102.954688-3-mark.rutland@arm.com>
 <20250210161242.GC7568@willie-the-truck>
 <Z6owjEPNaJ55e9LM@J2N7QTR9R3>
 <20250210180637.GA7926@willie-the-truck>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210180637.GA7926@willie-the-truck>

On Mon, Feb 10, 2025 at 06:06:38PM +0000, Will Deacon wrote:
> On Mon, Feb 10, 2025 at 04:59:56PM +0000, Mark Rutland wrote:
> > On Mon, Feb 10, 2025 at 04:12:43PM +0000, Will Deacon wrote:
> > > On Thu, Feb 06, 2025 at 02:10:56PM +0000, Mark Rutland wrote:
> > | static inline bool kvm_hyp_handle_fpsimd(struct kvm_vcpu *vcpu, u64 *exit_code)
> > | {
> > | 	...
> > | 
> > | 	/* Valid trap */
> > | 
> > | 	/*
> > | 	 * Enable everything EL2 might need to save/restore state.
> > | 	 * Maybe each of the bits should depend on system_has_xxx()
> > | 	 */
> > | 	cpacr_clear_set(0, CPACR_EL1_FPEN | CPACR_EL1_ZEN | CPACR_EL1_SMEN */
> > | 	isb();
> > | 
> > | 	...
> > | 
> > | 	/* Write out the host state if it's in the registers */
> > | 	if (is_protected_kvm_enabled() && host_owns_fp_regs())
> > | 		kvm_hyp_save_fpsimd_host(vcpu);
> > | 	
> > | 	/* Restore guest state */
> > | 
> > | 	...
> > | 
> > | 	/*
> > | 	 * Enable traps for the VCPU. The ERET will cause the traps to
> > | 	 * take effect in the guest, so no ISB is necessary.
> > | 	 */
> > | 	cpacr_guest = CPACR_EL1_FPEN;
> > | 	if (vcpu_has_sve(vcpu))
> > | 		cpacr_guest |= CPACR_EL1_ZEN;
> > | 	if (vcpu_has_sme(vcpu))			// whenever we add this
> > | 		cpacr_guest |= CPACR_EL1_SMEN;
> > | 	cpacr_clear_set(CPACR_EL1_FPEN | CPACR_EL1_ZEN | CPACR_EL1_SMEN,
> > | 			cpacr_guest);
> > | 
> > | 	return true;
> > | }
> > 
> > ... where we'd still have the CPACR write to re-enable traps, but it'd
> > be unconditional, and wouldn't need an extra ISB.
> > 
> > If that makes sense to you, I can go spin that as a subsequent cleanup
> > atop this series.
> 
> That looks very clean, yes please! Don't forget to drop the part from
> kvm_hyp_save_fpsimd_host() too.

Yep, that was the idea!

To avoid confusion: I've sent out v3 of this series *without* the
change, and I'll prepare that as a follow-up.

Mark.

