Return-Path: <stable+bounces-124496-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF04BA6215A
	for <lists+stable@lfdr.de>; Sat, 15 Mar 2025 00:11:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FD7119C5CFC
	for <lists+stable@lfdr.de>; Fri, 14 Mar 2025 23:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5221C860B;
	Fri, 14 Mar 2025 23:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VYWlwBbV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BC21F92E
	for <stable@vger.kernel.org>; Fri, 14 Mar 2025 23:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741993873; cv=none; b=QxJserCWTqu5L3lPHAZ4AVZKAWMCq5RatPFETRR9LxGgNQ12GzRXUAbA+Mt1BVLmsq8squ2t908y8WaDUDO9bkLjeT67zaHVs68FGFkiCsrHAtJQksuLUM24l04J9fhLI+b7H7TvJ7OVzIHK8Xl82fKEZOS/4Up3uyEyuTsxBKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741993873; c=relaxed/simple;
	bh=aPT+lhtUr/oX6cGysk/Ts9Bwh8cuG+oVtrxG9DDdftg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PcoVUb3bQdnlFXbu1kl8w8Iy41akERAthLPey/HFa0rJkxy+JWFfUiNigfKHXXjBqvqdParZ/YHMKCnkcRns/7/1FQGZ3yarCBUbfJSu1BHKZxMWRI4DSM512GMs9p+0w4ETWXJasbrIhZ0qa6fEsUX5LLo613uo5/fuNAKAmfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VYWlwBbV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C98FBC4CEE3;
	Fri, 14 Mar 2025 23:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741993873;
	bh=aPT+lhtUr/oX6cGysk/Ts9Bwh8cuG+oVtrxG9DDdftg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VYWlwBbVZ9940Bdi29BS7NiHRUJL6/+WXOvxjnlNVoBE7uJbmsOBcSNPBnMcahY4G
	 RI36k6u6cxoEEPFbCEDHmPvoLB8Eo2iwQuU3uBEMgNjCuchUNJSzmpKWoW2WiAFyvS
	 p8RDi1D+FiT+9tB4o1CYTVfM6pClCsGJd5lkbWK2FMLD/sExUFy3n64tak/NpFR8ch
	 SEmLFM5KpXRoqhSheDod+Ngc4IlaEWp+DbDueRCdu5KEFpp5zmeafes6VZnVr1p08M
	 6q3Wiz/ZDJxjk8h3jjzezuNxnmzb8d1+qBEu/L0YyDmKKI2QoFq/W+SWOraEAiUxlY
	 6AvoRVpwa8zLg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12 8/8] KVM: arm64: Eagerly switch ZCR_EL{1,2}
Date: Fri, 14 Mar 2025 19:11:11 -0400
Message-Id: <20250314090006-0e6452c358d42d2f@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250314-stable-sve-6-12-v1-8-ddc16609d9ba@kernel.org>
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

Status in newer kernel trees:
6.13.y | Present (different SHA1: fd2ebd39b2e5)

Note: The patch differs from the upstream commit:
---
1:  59419f10045bc ! 1:  32574171f3382 KVM: arm64: Eagerly switch ZCR_EL{1,2}
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
      		sync_hyp_vcpu(hyp_vcpu);
    + 		pkvm_put_hyp_vcpu(hyp_vcpu);
      	} else {
     +		struct kvm_vcpu *vcpu = kern_hyp_va(host_vcpu);
     +
      		/* The host is fully trusted, run its vCPU directly. */
    --		ret = __kvm_vcpu_run(kern_hyp_va(host_vcpu));
    +-		ret = __kvm_vcpu_run(host_vcpu);
     +		fpsimd_lazy_switch_to_guest(vcpu);
     +		ret = __kvm_vcpu_run(vcpu);
     +		fpsimd_lazy_switch_to_host(vcpu);
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
    + 
    +@@ arch/arm64/kvm/hyp/nvhe/switch.c: static void __activate_cptr_traps(struct kvm_vcpu *vcpu)
    + 
    + 		if (!guest_owns_fp_regs())
    + 			val |= CPTR_EL2_TFP;
    ++
    ++		write_sysreg(val, cptr_el2);
    + 	}
    ++}
      
    --		if (kvm_has_sve(kvm) && guest_owns_fp_regs())
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
| stable/linux-6.12.y       |  Success    |  Success   |

