Return-Path: <stable+bounces-114703-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97CEDA2F66A
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 19:06:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65C083A2984
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 18:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C7925B693;
	Mon, 10 Feb 2025 18:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BiJ4BPF1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7FF25B661
	for <stable@vger.kernel.org>; Mon, 10 Feb 2025 18:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739210805; cv=none; b=CTxdUNqIx+SHNwMGTNuZREV9cun009LnpfnNBrXyMi9x2fm7v0X4RFGkpz/vztP/V+3x4Vg9CAmofvXffjPVD1/JZB+a9fKewWDW4ttsJnbubEImm7Knq2J+Ma681+qvJI/5rNhpcZqtd0Fh2TzEC5E7NXw+8C2GRkvBEcZafwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739210805; c=relaxed/simple;
	bh=rEjX/y5k2wIkN5VomTNPMfAyy9Yr49DktqV5dC3V3Fs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T9A1Er1+Ji8LOwksQIypCDy/RB42qNA/09y6X0lQa1B2KvblKeBJX7NFXXDgsk0t9D4nstRDUGgmG/LrVIeqiUwgk7nBYnDS46pXM8Ux3NqcRtUNLsg3RBZkc6s2sjk/5GFRqTlUUca94La509IaTnqy/hR9YbyVEGelPqcbZz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BiJ4BPF1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B5FBC4CED1;
	Mon, 10 Feb 2025 18:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739210804;
	bh=rEjX/y5k2wIkN5VomTNPMfAyy9Yr49DktqV5dC3V3Fs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BiJ4BPF1ex+vGFRQWPQoDOu3R1NRwt9+mBZRxPP7Uj8A+Z7uecAIz0D4UXwracO7b
	 YFpSEoplurLtGfL01oBZ1LoN6Qvn4UiRr8Lh9yt3PZGS/eZAQNYnOpb6eNoo+B4MID
	 0oZ26Z7UhL86B1XNPvV+9UZDZWTbT9hZRKkv2S2uHJX8Xyp9JXdOP5d8jQXtI/8kPW
	 29i6IavU1KcotYuCEcTIwOw2JfD3GD41s5R2f3VUhVeWUlsOoX2d3a6Z46BskeYLu9
	 F9LDS36eNh3y4IKiYgqTtVvmeT62v5cp+c1Z9FXqgDYLSc4mxOvpFLJ3UhlwGu53RH
	 PCxZDKYw1MtPg==
Date: Mon, 10 Feb 2025 18:06:38 +0000
From: Will Deacon <will@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, broonie@kernel.org,
	catalin.marinas@arm.com, eauger@redhat.com, eric.auger@redhat.com,
	fweimer@redhat.com, jeremy.linton@arm.com, maz@kernel.org,
	oliver.upton@linux.dev, pbonzini@redhat.com, stable@vger.kernel.org,
	tabba@google.com, wilco.dijkstra@arm.com
Subject: Re: [PATCH v2 2/8] KVM: arm64: Remove host FPSIMD saving for
 non-protected KVM
Message-ID: <20250210180637.GA7926@willie-the-truck>
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
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, Feb 10, 2025 at 04:59:56PM +0000, Mark Rutland wrote:
> On Mon, Feb 10, 2025 at 04:12:43PM +0000, Will Deacon wrote:
> > On Thu, Feb 06, 2025 at 02:10:56PM +0000, Mark Rutland wrote:
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
> 
> If that makes sense to you, I can go spin that as a subsequent cleanup
> atop this series.

That looks very clean, yes please! Don't forget to drop the part from
kvm_hyp_save_fpsimd_host() too.

Will

