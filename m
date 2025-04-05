Return-Path: <stable+bounces-128384-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F57A7C8F9
	for <lists+stable@lfdr.de>; Sat,  5 Apr 2025 13:57:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 644FA1894AF6
	for <lists+stable@lfdr.de>; Sat,  5 Apr 2025 11:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2011DC070;
	Sat,  5 Apr 2025 11:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GGZ6Z7FS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA048F64
	for <stable@vger.kernel.org>; Sat,  5 Apr 2025 11:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743854262; cv=none; b=TwrK81GJsSO43/jUtk8nfMNKNY0UmJ35+S7u/4UVAooh0vpk46sJhr9RSF+eCMUr43uDpqcdAqFHIAcgCu/NIlsd41SKM2Mfw58EjrEdZPMPOqfJ4TYzMbwCMG8Zonjq8DVuZXeM9bFbDeVYBCTLJtBHUhdIEJIGaIm+cpncndg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743854262; c=relaxed/simple;
	bh=+Z1qV6U25FbFpcUCZxwJfiinh+rInJ6lNZPx6QSauvI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m1x9zTAF0EG7FgyTYRO9kcHSS6vNxOe3YcnfIONLqx715HcgJovpFi3Wo8dc6rj7giVLjpYstYoWBexRFu/BkhowId047LnztAT8p5svYTh4p8WAqLiBFEt7tuCUAdcG52TYHbPHQF0t1ej7Y50mNEaiXlLJl8ldi3dDiEq63lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GGZ6Z7FS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A03AEC4CEE4;
	Sat,  5 Apr 2025 11:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743854262;
	bh=+Z1qV6U25FbFpcUCZxwJfiinh+rInJ6lNZPx6QSauvI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GGZ6Z7FSbCkcgB/lVYA1120Mtv+hkv5IBfM04H5svnxl8mmeSz5nxueLd97V4YtzF
	 W0SYsdnLkbUoLqGMjb5UJTIu2cnFtt3Z3gpW1yCKwJXhaKRoE+VgM4BWXRlGZHoo61
	 zenLPoB45Ws1y2wAYJOT41Vo8ClosVKNKALG5MCGpt91j6Xy0tauoImnI9PpSxm2kh
	 9+44Ktif8oxJMyBZSFBZQ7MITjuQi3TwA5fVnDHWmSS23ogLgVfv17pkNpu440lYMM
	 +ffVxlQ09L6GNCl2O+yaCTWaEld2ViGhUqfBVgDMgUAoL94GzvpN8kk4EtbKEy2zSQ
	 k1l9nkE9fXu0A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH RESEND 6.1 05/12] KVM: arm64: Unconditionally save+flush host FPSIMD/SVE/SME state
Date: Sat,  5 Apr 2025 07:57:40 -0400
Message-Id: <20250405015521-66b5d71f62fa5217@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250404-stable-sve-6-1-v1-5-cd5c9eb52d49@kernel.org>
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
6.14.y | Present (exact SHA1)
6.13.y | Present (different SHA1: 900b444be493)
6.12.y | Present (different SHA1: 79e140bba70b)
6.6.y | Present (different SHA1: 806d5c1e1d2e)

Note: The patch differs from the upstream commit:
---
1:  fbc7e61195e23 ! 1:  46b6201d09cb2 KVM: arm64: Unconditionally save+flush host FPSIMD/SVE/SME state
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
    @@ arch/arm64/kvm/fpsimd.c: void kvm_arch_vcpu_load_fp(struct kvm_vcpu *vcpu)
      
     -	fpsimd_kvm_prepare();
     -
    - 	/*
    --	 * We will check TIF_FOREIGN_FPSTATE just before entering the
    --	 * guest in kvm_arch_vcpu_ctxflush_fp() and override this to
    --	 * FP_STATE_FREE if the flag set.
    +-	vcpu->arch.fp_state = FP_STATE_HOST_OWNED;
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
    ++	vcpu->arch.fp_state = FP_STATE_FREE;
      
    - 	host_data_clear_flag(HOST_SVE_ENABLED);
    + 	vcpu_clear_flag(vcpu, HOST_SVE_ENABLED);
      	if (read_sysreg(cpacr_el1) & CPACR_EL1_ZEN_EL0EN)
     @@ arch/arm64/kvm/fpsimd.c: void kvm_arch_vcpu_load_fp(struct kvm_vcpu *vcpu)
    - 		host_data_clear_flag(HOST_SME_ENABLED);
    + 		vcpu_clear_flag(vcpu, HOST_SME_ENABLED);
      		if (read_sysreg(cpacr_el1) & CPACR_EL1_SMEN_EL0EN)
    - 			host_data_set_flag(HOST_SME_ENABLED);
    + 			vcpu_set_flag(vcpu, HOST_SME_ENABLED);
     -
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
     -		if (read_sysreg_s(SYS_SVCR) & (SVCR_SM_MASK | SVCR_ZA_MASK)) {
    --			*host_data_ptr(fp_owner) = FP_STATE_FREE;
    +-			vcpu->arch.fp_state = FP_STATE_FREE;
     -			fpsimd_save_and_flush_cpu_state();
     -		}
      	}
    + }
      
    - 	/*
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

