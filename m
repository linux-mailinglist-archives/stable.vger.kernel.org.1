Return-Path: <stable+bounces-109634-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A07A1813A
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 16:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AAF916BD1E
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 15:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15C41F471A;
	Tue, 21 Jan 2025 15:37:31 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1F981ACA
	for <stable@vger.kernel.org>; Tue, 21 Jan 2025 15:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737473851; cv=none; b=Fgi3uKkkXjy/MAQk0m8jqKXLYgc6y4ePdfKp2lleOrMGIIFq5h3tparR45u84OVjmfTL887wV1hz3ixfzsDNcFU8XiMEOvaP2SPr7e5NYRyCmOgsbtNFupR+vnqZjcSafbqf9nGkSlpB5coqDosAeck9PcQv8quNqt6zm+kpx6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737473851; c=relaxed/simple;
	bh=BTUKwmLOBJbI6ggPJgtDR5NKe16HQtO5l0DfjzZnc8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g0p/PNsEVlzvqkThNxHdKxfsHp6T96/kQaUb+ueY73skXpi8hdRChHIId0QNJtYDTkX4WyZ7hP3mvPyqEWIP/AfeFDaMuUiLgkN/Sjp3G0Dq3ob8VuzPRnmTJ6NaQg5HtUEW5uhp8qNn/uTiBulC4gEPdTdZwzAZ4a46YiUKgYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 99F5F1063;
	Tue, 21 Jan 2025 07:37:51 -0800 (PST)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A127A3F66E;
	Tue, 21 Jan 2025 07:37:20 -0800 (PST)
Date: Tue, 21 Jan 2025 15:37:13 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Marc Zyngier <maz@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, broonie@kernel.org,
	catalin.marinas@arm.com, eauger@redhat.com, fweimer@redhat.com,
	jeremy.linton@arm.com, oliver.upton@linux.dev, pbonzini@redhat.com,
	stable@vger.kernel.org, wilco.dijkstra@arm.com, will@kernel.org
Subject: Re: [PATCH] KVM: arm64/sve: Ensure SVE is trapped after guest exit
Message-ID: <Z4--YuG5SWrP_pW7@J2N7QTR9R3>
References: <20250121100026.3974971-1-mark.rutland@arm.com>
 <86r04wv2fv.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86r04wv2fv.wl-maz@kernel.org>

On Tue, Jan 21, 2025 at 11:20:04AM +0000, Marc Zyngier wrote:
> Hi Mark,
> 
> On Tue, 21 Jan 2025 10:00:26 +0000,
> Mark Rutland <mark.rutland@arm.com> wrote:
> > 
> > There is a period of time after returning from a KVM_RUN ioctl where
> > userspace may use SVE without trapping, but the kernel can unexpectedly
> > discard the live SVE state. Eric Auger has observed this causing QEMU
> > crashes where SVE is used by memmove():
> > 
> >   https://issues.redhat.com/browse/RHEL-68997
> > 
> > The only state discarded is the user SVE state of the task which issued
> > the KVM_RUN ioctl. Other tasks are unaffected, plain FPSIMD state is
> > unaffected, and kernel state is unaffected.
> > 
> > This happens because fpsimd_kvm_prepare() incorrectly manipulates the
> > FPSIMD/SVE state. When the vCPU is loaded, fpsimd_kvm_prepare()
> > unconditionally clears TIF_SVE but does not reconfigure CPACR_EL1.ZEN to
> > trap userspace SVE usage. If the vCPU does not use FPSIMD/SVE and hyp
> > does not save the host's FPSIMD/SVE state, the kernel may return to
> > userspace with TIF_SVE clear while SVE is still enabled in
> > CPACR_EL1.ZEN. Subsequent userspace usage of SVE will not be trapped,
> > and the next save of userspace FPSIMD/SVE state will only store the
> > FPSIMD portion due to TIF_SVE being clear, discarding any SVE state.
> > 
> > The broken logic was originally introduced in commit:
> > 
> >   93ae6b01bafee8fa ("KVM: arm64: Discard any SVE state when entering KVM guests")
> > 
> > ... though at the time fp_user_discard() would reconfigure CPACR_EL1.ZEN
> > to trap subsequent SVE usage, masking the issue until that logic was
> > removed in commit:
> > 
> >   8c845e2731041f0f ("arm64/sve: Leave SVE enabled on syscall if we don't context switch")
> > 
> > Avoid this issue by reconfiguring CPACR_EL1.ZEN when clearing
> > TIF_SVE. At the same time, add a comment to explain why
> > current->thread.fp_type must be set even though the FPSIMD state is not
> > foreign. A similar issue exists when SME is enabled, and will require
> > further rework. As SME currently depends on BROKEN, a BUILD_BUG() and
> > comment are added for now, and this issue will need to be fixed properly
> > in a follow-up patch.
> > 
> > Commit 93ae6b01bafee8fa also introduced an unintended ptrace ABI change.
> > Unconditionally clearing TIF_SVE regardless of whether the state is
> > foreign discards saved SVE state created by ptrace after syscall entry.
> > Avoid this by only clearing TIF_SVE when the FPSIMD/SVE state is not
> > foreign. When the state is foreign, KVM hyp code does not need to save
> > any host state, and so this will not affect KVM.
> > 
> > There appear to be further issues with unintentional SVE state
> > discarding, largely impacting ptrace and signal handling, which will
> > need to be addressed in separate patches.
> > 
> > Reported-by: Eric Auger <eauger@redhat.com>
> > Reported-by: Wilco Dijkstra <wilco.dijkstra@arm.com>
> > Cc: stable@vger.kernel.org
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Florian Weimer <fweimer@redhat.com>
> > Cc: Jeremy Linton <jeremy.linton@arm.com>
> > Cc: Marc Zyngier <maz@kernel.org>
> > Cc: Mark Brown <broonie@kernel.org>
> > Cc: Oliver Upton <oliver.upton@linux.dev>
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Cc: Will Deacon <will@kernel.org>
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > ---
> >  arch/arm64/kernel/fpsimd.c | 20 ++++++++++++++++++--
> >  1 file changed, 18 insertions(+), 2 deletions(-)
> > 
> > I believe there are some other issues in this area, but I'm sending this
> > out on its own because I beleive the other issues are more complex while
> > this is self-contained, and people are actively hitting this case in
> > production.
> > 
> > I intend to follow-up with fixes for the other cases I mention in the
> > commit message, and for the SME case with the BUILD_BUG_ON().
> > 
> > Mark.
> > 
> > diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
> > index 8c4c1a2186cc5..e4053a90ed240 100644
> > --- a/arch/arm64/kernel/fpsimd.c
> > +++ b/arch/arm64/kernel/fpsimd.c
> > @@ -1711,8 +1711,24 @@ void fpsimd_kvm_prepare(void)
> >  	 */
> >  	get_cpu_fpsimd_context();
> >  
> > -	if (test_and_clear_thread_flag(TIF_SVE)) {
> > -		sve_to_fpsimd(current);
> > +	if (!test_thread_flag(TIF_FOREIGN_FPSTATE) &&
> > +	    test_and_clear_thread_flag(TIF_SVE)) {
> > +		sve_user_disable();
> 
> I'm pretty happy with this fix. However...
> 
> > +
> > +		/*
> > +		 * The KVM hyp code doesn't set fp_type when saving the host's
> > +		 * FPSIMD state. Set fp_type here in case the hyp code saves
> > +		 * the host state.
> 
> Should KVM do that? The comment seems to indicate that this is
> papering over yet another bug...

Yes; really this should be done at hyp (and at that point, hyp could
actually save the entire host SVE state), but that's a larger change and
more painful for backporting, which is why I didn't go that route. I'm
happy to go try to fix hyp to do that, or I can make the comment more
explicit that this is a bodge, if that's all you're after?

Alternatively, we could take the large hammer approach and always save
and unbind the host state prior to entering the guest, so that hyp
doesn't need to save anything. An unconditional call to
fpsimd_save_and_flush_cpu_state() would suffice, and that'd also
implicitly fix the SME issue below.

> > +		 *
> > +		 * If hyp code does not save the host state, then the host
> > +		 * state remains live on the CPU and saved fp_type is
> > +		 * irrelevant until it is overwritten by a later call to
> > +		 * fpsimd_save_user_state().
> 
> I'm not sure I understand this. If fp_type is irrelevant, surely it is
> *forever* irrelevant, not until something else happens. Or am I
> missing something?

Sorry, this was not very clear.

What this is trying to say is that *while the state is live on a CPU*
fp_type is irrelevant, and it's only meaningful when saving/restoring
state. As above, the only reason to set it here is so that *if* hyp
saves and unbinds the state, fp_type will accurately describe what the
hyp code saved.

The key thing is that there are two possibilities:

(1) The guest doesn't use FPSIMD/SVE, and no trap is taken to save the
    host state. In this case, fp_type is not consumed before the next
    time state has to be written back to memory (the act of which will
    set fp_type).

    So in this case, setting fp_type is redundant but benign.

(2) The guest *does* use FPSIMD/SVE, and a trap is taken to hyp to save
    the host state. In this case the hyp code will save the task's
    FPSIMD state to task->thread.uw.fpsimd_state, but will not update
    task->thread.fp_type accordingly, and:

    * If fp_type happened to be FP_STATE_FPSIMD, all is good and a later
      restore will load the state saved by the hyp code.

    * If fp_type happened to be FP_STATE_SVE, a later restore will load
      stale state from task->thread.sve_state.

... does that make sense?

> > +		 *
> > +		 * This is *NOT* sufficient when CONFIG_ARM64_SME=y, where
> > +		 * fp_type can be FP_STATE_SVE regardless of TIF_SVE.
> > +		 */
> > +		BUILD_BUG_ON(IS_ENABLED(CONFIG_ARM64_SME));
> 
> I'd rather not have this build-time failure, as this is very likely to
> annoy a lot of people. Instead, just make SME unselectable with KVM:

I'm happy to change this, but FWIW I'd used BUILD_BUG() here because it
kept that associated with the comment and logic, and because we disabled
SME in commit:

  81235ae0c846e1fb4 ("arm64: Kconfig: Make SME depend on BROKEN for now)"

... which was CC'd stable, and so this *shouldn't* blow up on anything
with that commit.

So I can:

(a) Add the dependency, as you suggest.

(b) Leave that as-is.

(c) Solve this in a different way so that we don't need a BUILD_BUG() or
    dependency. e.g. fix the SME case at the same time, at the cost of
    possibly needing to do a bit more work when backporting.

... any preference?

Mark.

> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 100570a048c5e..88bedf95a3662 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -2271,6 +2271,7 @@ config ARM64_SME
>  	default y
>  	depends on ARM64_SVE
>  	depends on BROKEN
> +	depends on !KVM
>  	help
>  	  The Scalable Matrix Extension (SME) is an extension to the AArch64
>  	  execution state which utilises a substantial subset of the SVE
> 
> Thanks,
> 
> 	M.
> 
> -- 
> Without deviation from the norm, progress is not possible.

