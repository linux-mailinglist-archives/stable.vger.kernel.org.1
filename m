Return-Path: <stable+bounces-124301-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD188A5F497
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 13:34:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9E1217EFE4
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 12:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B1D2676C7;
	Thu, 13 Mar 2025 12:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qa5YdlIR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FC6267706
	for <stable@vger.kernel.org>; Thu, 13 Mar 2025 12:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741869111; cv=none; b=kEUVwCRMz96L2MNHFeJsGf+23iwyCDReOcfsmjpDu/I3N9TE/W+LtdOHwdRHmZuvDHQCJexu4LVzM2M3TcE2nBtEgzTwFLeNXmGooFrMLeiig7Mhss1zB10IwYVTteoy4WxU9PTVBeh384jSRe+kddp0BCl8zMxI3o2zqSXqd6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741869111; c=relaxed/simple;
	bh=k05LHEr09xlcm8gTbLv4Pck9+TSdFqq6CZyDcb9jcS4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f9+koaYwHzge2iANNWRO9oCidcz+E30pH6g/tIWMMroROwNEyj6xK/Q43eANeDzIM5wy5hC2Y4/PPBSK1WYAUOPV62ZKnIeU2qM62+xhoVKuSalsP6OdppWchTq0/eDShaU3V1ispMa0HRyaPnqsHRjCgBSqs721BC9BfpZKhu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qa5YdlIR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1DA1C4CEE5;
	Thu, 13 Mar 2025 12:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741869111;
	bh=k05LHEr09xlcm8gTbLv4Pck9+TSdFqq6CZyDcb9jcS4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qa5YdlIRV/pKZ8TXMTu92HEIG3tJmL4ITGBoWvZd3myu/Y2n4Gifkj9eQ865g9vV6
	 x4fFko3O0ui5EbHj8U8VMaZ4T5DzJwUwtf2OrSv03Hywm4WOq5mqgR1qbook8SgI7I
	 ICZiDmEOaYV2CYHISVJba5cAGatYT4RieZE/KOKOpwFhszgJkAAbsPcyhC/UTWHr1U
	 d90XwUGQAEE/yYnxwYU2pdVT/96qVXaJJyTDVrH1DW7gnk+749gg6Cy1hv/NysdU/W
	 qNtn+bIFlvOMP+CoieCR7sdS7p9w3bbOADziL7BkdE3N9+zYJOGI4y+zAtB2cx72gZ
	 hikmhNlCdP6Bg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	broonie@kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.13 8/8] KVM: arm64: Eagerly switch ZCR_EL{1,2}
Date: Thu, 13 Mar 2025 08:31:49 -0400
Message-Id: <20250313060224-0a74afe43b371b77@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250312-stable-sve-6-13-v1-8-c7ba07a6f4f7@kernel.org>
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

Summary of potential issues:
ℹ️ This is part 8/8 of a series
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: 59419f10045bc955d2229819c7cf7a8b0b9c5b59

WARNING: Author mismatch between patch and found commit:
Backport author: Mark Brown<broonie@kernel.org>
Commit author: Mark Rutland<mark.rutland@arm.com>

Note: The patch differs from the upstream commit:
---
1:  59419f10045bc ! 1:  5c95d50c2deb9 KVM: arm64: Eagerly switch ZCR_EL{1,2}
    @@ Commit message
         Reviewed-by: Oliver Upton <oliver.upton@linux.dev>
         Link: https://lore.kernel.org/r/20250210195226.1215254-9-mark.rutland@arm.com
         Signed-off-by: Marc Zyngier <maz@kernel.org>
    +    (cherry picked from commit 59419f10045bc955d2229819c7cf7a8b0b9c5b59)
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
      
    --		if (kvm_has_sve(kvm) && guest_owns_fp_regs())
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

NOTE: These results are for this patch alone. Full series testing will be
performed when all parts are received.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.13.y       |  Success    |  Success   |

