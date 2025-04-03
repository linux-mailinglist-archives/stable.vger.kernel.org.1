Return-Path: <stable+bounces-127695-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BCF0A7A725
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 17:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D896177189
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 15:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE409250BED;
	Thu,  3 Apr 2025 15:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ihr12ySB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD992505D1
	for <stable@vger.kernel.org>; Thu,  3 Apr 2025 15:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743694772; cv=none; b=Z0qV/pWfA++hCdpmRLjA4ytk6QksuPtqbRgc7Prhi+iKAizqK+V58YTTbzEBTVOYJ1X95qgAEvKTC8e/fdv89bzVxWlOOq1muI5cACCoiaDW3f9Bw5JdUqC6dlgH4cQo6GOe0X0m3CihLSo6r7eQdksxJOw5/oOmRtbfmLgUb5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743694772; c=relaxed/simple;
	bh=0pvBOI31P0+F0qpB9tSvaLFIN1Yix/9O3pHZ8MitXQg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g7rmUv1wT3mdPkR7RZkio0kYiyCDsNeeS4BkFmxQzxwF6IK3+ke1tSPmfF/ieldYEBdOQTZ18x3fl/KD2w5WTnPD0qnwKUmSl+rlLANXbZMEARcE7qU9hIKj8HO81YrOuZuy/OXOO3Qg7xr2fRnSq7R3o+n4IN6ZrAZYE4Zfszw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ihr12ySB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B218C4CEE3;
	Thu,  3 Apr 2025 15:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743694770;
	bh=0pvBOI31P0+F0qpB9tSvaLFIN1Yix/9O3pHZ8MitXQg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ihr12ySBYcV7cb+RME/jpMO/rloLXgfsxEOA7BTPY7wxyeLpo6DxK/iubsrRRH5nK
	 p9i6qoKQhTQsl8fY6YeMD9QUJyz9HcWTJlkElEyE2NkenO1TLnOoFhCqTQ1rUofrzj
	 l0bPUB/BLUD4uzOEtwFIfwpiZFbQR06vq3hWQOX+eWE3ZQ0RahPGk3cyEsEwmcWxmO
	 IzPiLthSDUPSXUoGTPAG5WJcpm6YNVk7D8aUqmJvWc0R8Bml80xNVjCOeF7xqC4dJS
	 r+bM4pV2JvCy02AA/kIDqEa5XWCzVlV3fvEagcPh9fTdBx3h78qpWcSTDXTzLgeThb
	 9jaO/QtScVYjQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15 v2 06/10] KVM: arm64: Unconditionally save+flush host FPSIMD/SVE/SME state
Date: Thu,  3 Apr 2025 11:39:26 -0400
Message-Id: <20250403105408-8e55d56c8c27f17c@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250403-stable-sve-5-15-v2-6-30a36a78a20a@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

✅ All tests passed successfully. No issues detected.
No action required from the submitter.

The upstream commit SHA1 provided is correct: fbc7e61195e23f744814e78524b73b59faa54ab4

WARNING: Author mismatch between patch and upstream commit:
Backport author: Mark Brown<broonie@kernel.org>
Commit author: Mark Rutland<mark.rutland@arm.com>

Status in newer kernel trees:
6.13.y | Present (different SHA1: 314eed0b3ec1)
6.12.y | Present (different SHA1: f42151c41cd6)
6.6.y | Present (different SHA1: 7db8ea02c171)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  fbc7e61195e23 ! 1:  7138b0dfa0d0b KVM: arm64: Unconditionally save+flush host FPSIMD/SVE/SME state
    @@ Metadata
      ## Commit message ##
         KVM: arm64: Unconditionally save+flush host FPSIMD/SVE/SME state
     
    +    [ Upstream commit fbc7e61195e23f744814e78524b73b59faa54ab4 ]
    +
         There are several problems with the way hyp code lazily saves the host's
         FPSIMD/SVE state, including:
     
    @@ Commit message
         Reviewed-by: Oliver Upton <oliver.upton@linux.dev>
         Link: https://lore.kernel.org/r/20250210195226.1215254-2-mark.rutland@arm.com
         Signed-off-by: Marc Zyngier <maz@kernel.org>
    +    [ Mark: Handle vcpu/host flag conflict, remove host_data_ptr() ]
    +    Signed-off-by: Mark Rutland <mark.rutland@arm.com>
    +    Signed-off-by: Mark Brown <broonie@kernel.org>
     
      ## arch/arm64/kernel/fpsimd.c ##
     @@ arch/arm64/kernel/fpsimd.c: void fpsimd_signal_preserve_current_state(void)
    @@ arch/arm64/kernel/fpsimd.c: void fpsimd_signal_preserve_current_state(void)
     
      ## arch/arm64/kvm/fpsimd.c ##
     @@ arch/arm64/kvm/fpsimd.c: void kvm_arch_vcpu_load_fp(struct kvm_vcpu *vcpu)
    - 	if (!system_supports_fpsimd())
    - 		return;
    + 	vcpu->arch.flags &= ~KVM_ARM64_FP_ENABLED;
    + 	vcpu->arch.flags |= KVM_ARM64_FP_HOST;
      
     -	fpsimd_kvm_prepare();
     -
    - 	/*
    --	 * We will check TIF_FOREIGN_FPSTATE just before entering the
    --	 * guest in kvm_arch_vcpu_ctxflush_fp() and override this to
    --	 * FP_STATE_FREE if the flag set.
    +-	vcpu->arch.flags &= ~KVM_ARM64_HOST_SVE_ENABLED;
    ++	/*
     +	 * Ensure that any host FPSIMD/SVE/SME state is saved and unbound such
     +	 * that the host kernel is responsible for restoring this state upon
     +	 * return to userspace, and the hyp code doesn't need to save anything.
     +	 *
     +	 * When the host may use SME, fpsimd_save_and_flush_cpu_state() ensures
     +	 * that PSTATE.{SM,ZA} == {0,0}.
    - 	 */
    --	*host_data_ptr(fp_owner) = FP_STATE_HOST_OWNED;
    --	*host_data_ptr(fpsimd_state) = kern_hyp_va(&current->thread.uw.fpsimd_state);
    --	*host_data_ptr(fpmr_ptr) = kern_hyp_va(&current->thread.uw.fpmr);
    ++	 */
     +	fpsimd_save_and_flush_cpu_state();
    -+	*host_data_ptr(fp_owner) = FP_STATE_FREE;
    -+	*host_data_ptr(fpsimd_state) = NULL;
    -+	*host_data_ptr(fpmr_ptr) = NULL;
    ++	vcpu->arch.flags &= ~KVM_ARM64_FP_HOST;
      
    - 	host_data_clear_flag(HOST_SVE_ENABLED);
      	if (read_sysreg(cpacr_el1) & CPACR_EL1_ZEN_EL0EN)
    -@@ arch/arm64/kvm/fpsimd.c: void kvm_arch_vcpu_load_fp(struct kvm_vcpu *vcpu)
    - 		host_data_clear_flag(HOST_SME_ENABLED);
    - 		if (read_sysreg(cpacr_el1) & CPACR_EL1_SMEN_EL0EN)
    - 			host_data_set_flag(HOST_SME_ENABLED);
    --
    --		/*
    --		 * If PSTATE.SM is enabled then save any pending FP
    --		 * state and disable PSTATE.SM. If we leave PSTATE.SM
    --		 * enabled and the guest does not enable SME via
    --		 * CPACR_EL1.SMEN then operations that should be valid
    --		 * may generate SME traps from EL1 to EL1 which we
    --		 * can't intercept and which would confuse the guest.
    --		 *
    --		 * Do the same for PSTATE.ZA in the case where there
    --		 * is state in the registers which has not already
    --		 * been saved, this is very unlikely to happen.
    --		 */
    --		if (read_sysreg_s(SYS_SVCR) & (SVCR_SM_MASK | SVCR_ZA_MASK)) {
    --			*host_data_ptr(fp_owner) = FP_STATE_FREE;
    --			fpsimd_save_and_flush_cpu_state();
    --		}
    - 	}
    - 
    - 	/*
    + 		vcpu->arch.flags |= KVM_ARM64_HOST_SVE_ENABLED;
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

