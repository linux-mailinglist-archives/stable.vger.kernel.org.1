Return-Path: <stable+bounces-125767-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B60AFA6C174
	for <lists+stable@lfdr.de>; Fri, 21 Mar 2025 18:27:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9449E189D4DD
	for <lists+stable@lfdr.de>; Fri, 21 Mar 2025 17:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C3122DF90;
	Fri, 21 Mar 2025 17:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="snSCACAN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85ED422D7B2
	for <stable@vger.kernel.org>; Fri, 21 Mar 2025 17:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742578024; cv=none; b=r+VHy5BG+nITmMoeyOsdwkyqyZujN0hd45cRTLDXfT6rh/XLdAht9qiY91xAdIYxtTo/5bHATY7eEDFjxxPmGUw/vQQlpGVH/hSeO0mDYZI8jBHwieiRzHksIyIgAUsc58px8pSktC9rujkgq90O+//r7VtVVumVACYagPn6ddE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742578024; c=relaxed/simple;
	bh=MGOedWaFPrz7j4K/nkhn/uQzak0DxKrB2M/mu48JD3Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FzBQaBj+xktQdCoSHczslIGUlSHABQJXAVpo1aFJwuVi/nCZM2t5Y2NYTxk68peDoHD7Aen5mEnh7U26eQVWS64bre6ArF3gq3cZvtDbrVKEv/hQuOz1rMOA8Cu8NrVAC7EpiUTHOOeC8V7boW4EU2TnT3Cb89qKI3I3q77+d0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=snSCACAN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ECA9C4CEE3;
	Fri, 21 Mar 2025 17:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742578024;
	bh=MGOedWaFPrz7j4K/nkhn/uQzak0DxKrB2M/mu48JD3Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=snSCACANKpoNKphTeU4ZmNNMwjSCFVI6DpWxO4BEa7WxXgp2+wzx6um7iLagGKnex
	 e7eFwzmMvzL5R6FmT6GdT5hhDQgd1Hj6SazGHZ7gcYsy6MvL52iBsLLejbuuetWb+X
	 urnO3y07YdmCUzdp8blFrfPk4EQKeZlQsV/hX9SmRdI+IYmr0hH2QRakZ+M7EX4fVj
	 CdMmP2Y7AF4lFCORL1wh/WHHzqD3YLDFPtieL8CVoN9kDfNYQDhD3+FOXzCc+7Iw1/
	 FGTfC9o5lIPTqea0Yc1O2ldDnq0smcYgTqGAIrSZLpyETm9dD5JK+/TDi7XrfQmrF7
	 BuaDQYH6qSO0g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.13 v2 8/8] KVM: arm64: Eagerly switch ZCR_EL{1,2}
Date: Fri, 21 Mar 2025 13:26:52 -0400
Message-Id: <20250321132313-863ae2f236f2561b@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250321-stable-sve-6-13-v2-8-3150e3370c40@kernel.org>
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

The upstream commit SHA1 provided is correct: 59419f10045bc955d2229819c7cf7a8b0b9c5b59

WARNING: Author mismatch between patch and upstream commit:
Backport author: Mark Brown<broonie@kernel.org>
Commit author: Mark Rutland<mark.rutland@arm.com>

Note: The patch differs from the upstream commit:
---
1:  59419f10045bc ! 1:  7fd4a8f975638 KVM: arm64: Eagerly switch ZCR_EL{1,2}
    @@ Metadata
      ## Commit message ##
         KVM: arm64: Eagerly switch ZCR_EL{1,2}
     
    +    [ Upstream commit 59419f10045bc955d2229819c7cf7a8b0b9c5b59 ]
    +
         In non-protected KVM modes, while the guest FPSIMD/SVE/SME state is live on the
         CPU, the host's active SVE VL may differ from the guest's maximum SVE VL:
     
    @@ Commit message
         Reviewed-by: Oliver Upton <oliver.upton@linux.dev>
         Link: https://lore.kernel.org/r/20250210195226.1215254-9-mark.rutland@arm.com
         Signed-off-by: Marc Zyngier <maz@kernel.org>
    +    Signed-off-by: Mark Brown <broonie@kernel.org>
     
      ## arch/arm64/kvm/fpsimd.c ##
     @@ arch/arm64/kvm/fpsimd.c: void kvm_arch_vcpu_put_fp(struct kvm_vcpu *vcpu)
    @@ arch/arm64/kvm/hyp/nvhe/hyp-main.c
      #include <asm/pgtable-types.h>
      #include <asm/kvm_asm.h>
     @@ arch/arm64/kvm/hyp/nvhe/hyp-main.c: static void handle___kvm_vcpu_run(struct kvm_cpu_context *host_ctxt)
    - 
    - 		sync_hyp_vcpu(hyp_vcpu);
    + 		pkvm_put_hyp_vcpu(hyp_vcpu);
      	} else {
    -+		struct kvm_vcpu *vcpu = kern_hyp_va(host_vcpu);
    -+
      		/* The host is fully trusted, run its vCPU directly. */
    --		ret = __kvm_vcpu_run(kern_hyp_va(host_vcpu));
    -+		fpsimd_lazy_switch_to_guest(vcpu);
    -+		ret = __kvm_vcpu_run(vcpu);
    -+		fpsimd_lazy_switch_to_host(vcpu);
    ++		fpsimd_lazy_switch_to_guest(host_vcpu);
    + 		ret = __kvm_vcpu_run(host_vcpu);
    ++		fpsimd_lazy_switch_to_host(host_vcpu);
      	}
    + 
      out:
    - 	cpu_reg(host_ctxt, 1) =  ret;
     @@ arch/arm64/kvm/hyp/nvhe/hyp-main.c: void handle_trap(struct kvm_cpu_context *host_ctxt)
      	case ESR_ELx_EC_SMC64:
      		handle_host_smc(host_ctxt);
      		break;
     -	case ESR_ELx_EC_SVE:
    --		cpacr_clear_set(0, CPACR_EL1_ZEN);
    +-		cpacr_clear_set(0, CPACR_ELx_ZEN);
     -		isb();
     -		sve_cond_update_zcr_vq(sve_vq_from_vl(kvm_host_sve_max_vl) - 1,
     -				       SYS_ZCR_EL2);
    @@ arch/arm64/kvm/hyp/nvhe/hyp-main.c: void handle_trap(struct kvm_cpu_context *hos
     
      ## arch/arm64/kvm/hyp/nvhe/switch.c ##
     @@ arch/arm64/kvm/hyp/nvhe/switch.c: static void __activate_cptr_traps(struct kvm_vcpu *vcpu)
    - 
    - static void __deactivate_cptr_traps(struct kvm_vcpu *vcpu)
      {
    --	struct kvm *kvm = kern_hyp_va(vcpu->kvm);
    --
    + 	u64 val = CPTR_EL2_TAM;	/* Same bit irrespective of E2H */
    + 
    ++	if (!guest_owns_fp_regs())
    ++		__activate_traps_fpsimd32(vcpu);
    ++
      	if (has_hvhe()) {
    - 		u64 val = CPACR_EL1_FPEN;
    + 		val |= CPACR_ELx_TTA;
      
    --		if (!kvm_has_sve(kvm) || !guest_owns_fp_regs())
    -+		if (cpus_have_final_cap(ARM64_SVE))
    - 			val |= CPACR_EL1_ZEN;
    - 		if (cpus_have_final_cap(ARM64_SME))
    - 			val |= CPACR_EL1_SMEN;
    -@@ arch/arm64/kvm/hyp/nvhe/switch.c: static void __deactivate_cptr_traps(struct kvm_vcpu *vcpu)
    +@@ arch/arm64/kvm/hyp/nvhe/switch.c: static void __activate_cptr_traps(struct kvm_vcpu *vcpu)
    + 			if (vcpu_has_sve(vcpu))
    + 				val |= CPACR_ELx_ZEN;
    + 		}
    ++
    ++		write_sysreg(val, cpacr_el1);
      	} else {
    - 		u64 val = CPTR_NVHE_EL2_RES1;
    + 		val |= CPTR_EL2_TTA | CPTR_NVHE_EL2_RES1;
      
    --		if (kvm_has_sve(kvm) && guest_owns_fp_regs())
    +@@ arch/arm64/kvm/hyp/nvhe/switch.c: static void __activate_cptr_traps(struct kvm_vcpu *vcpu)
    + 
    + 		if (!guest_owns_fp_regs())
    + 			val |= CPTR_EL2_TFP;
    ++
    ++		write_sysreg(val, cptr_el2);
    + 	}
    ++}
    + 
    +-	if (!guest_owns_fp_regs())
    +-		__activate_traps_fpsimd32(vcpu);
    ++static void __deactivate_cptr_traps(struct kvm_vcpu *vcpu)
    ++{
    ++	if (has_hvhe()) {
    ++		u64 val = CPACR_ELx_FPEN;
    ++
    ++		if (cpus_have_final_cap(ARM64_SVE))
    ++			val |= CPACR_ELx_ZEN;
    ++		if (cpus_have_final_cap(ARM64_SME))
    ++			val |= CPACR_ELx_SMEN;
    ++
    ++		write_sysreg(val, cpacr_el1);
    ++	} else {
    ++		u64 val = CPTR_NVHE_EL2_RES1;
    ++
     +		if (!cpus_have_final_cap(ARM64_SVE))
    - 			val |= CPTR_EL2_TZ;
    - 		if (!cpus_have_final_cap(ARM64_SME))
    - 			val |= CPTR_EL2_TSM;
    ++			val |= CPTR_EL2_TZ;
    ++		if (!cpus_have_final_cap(ARM64_SME))
    ++			val |= CPTR_EL2_TSM;
    + 
    +-	kvm_write_cptr_el2(val);
    ++		write_sysreg(val, cptr_el2);
    ++	}
    + }
    + 
    + static void __activate_traps(struct kvm_vcpu *vcpu)
    +@@ arch/arm64/kvm/hyp/nvhe/switch.c: static void __deactivate_traps(struct kvm_vcpu *vcpu)
    + 
    + 	write_sysreg(this_cpu_ptr(&kvm_init_params)->hcr_el2, hcr_el2);
    + 
    +-	kvm_reset_cptr_el2(vcpu);
    ++	__deactivate_cptr_traps(vcpu);
    + 	write_sysreg(__kvm_hyp_host_vector, vbar_el2);
    + }
    + 
     
      ## arch/arm64/kvm/hyp/vhe/switch.c ##
     @@ arch/arm64/kvm/hyp/vhe/switch.c: static int __kvm_vcpu_run_vhe(struct kvm_vcpu *vcpu)
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |

