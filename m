Return-Path: <stable+bounces-125776-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45571A6C17C
	for <lists+stable@lfdr.de>; Fri, 21 Mar 2025 18:29:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBF5E3B96C5
	for <lists+stable@lfdr.de>; Fri, 21 Mar 2025 17:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B564224B1C;
	Fri, 21 Mar 2025 17:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BshjlUYa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF261BF33F
	for <stable@vger.kernel.org>; Fri, 21 Mar 2025 17:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742578136; cv=none; b=jPiPqiuV5NXCwomEMLoSPQF4rFtyuLsm3fHam1adUrqXhsr/ynN1OHr7UIC+zMUekZDKi1IDQploV/WLVtIxcgcZ8jhSaYac6+AtMlC2+91z3EruIeBCJ2GBgzbmNK1KVOl/y09jrbrythgmQu0oV5k1f5jWcr5BhtKE2d07b+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742578136; c=relaxed/simple;
	bh=DZxfrm5ZidtiSd+WyqRMcNR2zBwrCN3/gelZw6RbBLQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eFcXuQtS7a5Z5WiCovjSJZICmuFmGiU/omvcnbj9iYwg6WoU029x7KrsJUlEheHlTYUqYx9p5RGC5adNfLBNMHTeKNCvpSklH+Spac9qYt+bKUTn7lz+6knxHZrR0wrowu7yeKOVHCKf6spzI2r9LwCaTELaNIK0/8CV+kc1KWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BshjlUYa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C7FAC4CEE3;
	Fri, 21 Mar 2025 17:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742578135;
	bh=DZxfrm5ZidtiSd+WyqRMcNR2zBwrCN3/gelZw6RbBLQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BshjlUYaSbzn7zg/De1LPgMB0QRtLfYgfRWE3tze89S7kHftQPdbgnD+3V4u5y0Xn
	 InYwjq0x0s73ZUWYLSWNMbEh+q2xkMKrVhFiFLThZxTwSPnw19Z77LSZcZmLQfnR7K
	 yN3ipyeUOAFrzsoEyAbrZuk2EiOrdF5Q2lEL7H2nl+kWQ+oToqmITAEi/QJwfgzpUG
	 Pemn69My/Jd3QCwBTIYRLaYy8gSCsihxngd3nY/VQfeUSRLE+9dOVhVTBoWZxHlHqI
	 4t0M3PmaZiS/876MZYKox/x447WlPeKW7FGdFe1CL8zDAFJsfQt5A1CCmz+ANIaTtL
	 nC6Hus2phYFyg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12 v2 1/8] KVM: arm64: Calculate cptr_el2 traps on activating traps
Date: Fri, 21 Mar 2025 13:28:43 -0400
Message-Id: <20250321105451-9d201caa2870db2f@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250321-stable-sve-6-12-v2-1-417ca2278d18@kernel.org>
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

The upstream commit SHA1 provided is correct: 2fd5b4b0e7b440602455b79977bfa64dea101e6c

WARNING: Author mismatch between patch and upstream commit:
Backport author: Mark Brown<broonie@kernel.org>
Commit author: Fuad Tabba<tabba@google.com>

Status in newer kernel trees:
6.13.y | Present (different SHA1: 341a0c20c99b)

Note: The patch differs from the upstream commit:
---
1:  2fd5b4b0e7b44 ! 1:  2e3cec78e1491 KVM: arm64: Calculate cptr_el2 traps on activating traps
    @@ Metadata
      ## Commit message ##
         KVM: arm64: Calculate cptr_el2 traps on activating traps
     
    +    [ Upstream commit 2fd5b4b0e7b440602455b79977bfa64dea101e6c ]
    +
         Similar to VHE, calculate the value of cptr_el2 from scratch on
         activate traps. This removes the need to store cptr_el2 in every
         vcpu structure. Moreover, some traps, such as whether the guest
    @@ Commit message
         Signed-off-by: Fuad Tabba <tabba@google.com>
         Link: https://lore.kernel.org/r/20241216105057.579031-13-tabba@google.com
         Signed-off-by: Marc Zyngier <maz@kernel.org>
    +    Signed-off-by: Mark Brown <broonie@kernel.org>
     
      ## arch/arm64/include/asm/kvm_host.h ##
     @@ arch/arm64/include/asm/kvm_host.h: struct kvm_vcpu_arch {
    @@ arch/arm64/kvm/arm.c: static int kvm_arch_vcpu_ioctl_vcpu_init(struct kvm_vcpu *
      	 * Handle the "start in power-off" case.
     
      ## arch/arm64/kvm/hyp/nvhe/pkvm.c ##
    -@@ arch/arm64/kvm/hyp/nvhe/pkvm.c: static void pvm_init_traps_hcr(struct kvm_vcpu *vcpu)
    - 	vcpu->arch.hcr_el2 = val;
    - }
    - 
    --static void pvm_init_traps_cptr(struct kvm_vcpu *vcpu)
    --{
    --	struct kvm *kvm = vcpu->kvm;
    --	u64 val = vcpu->arch.cptr_el2;
    --
    --	if (!has_hvhe()) {
    --		val |= CPTR_NVHE_EL2_RES1;
    --		val &= ~(CPTR_NVHE_EL2_RES0);
    +@@ arch/arm64/kvm/hyp/nvhe/pkvm.c: static void pvm_init_traps_aa64pfr0(struct kvm_vcpu *vcpu)
    + 	const u64 feature_ids = pvm_read_id_reg(vcpu, SYS_ID_AA64PFR0_EL1);
    + 	u64 hcr_set = HCR_RW;
    + 	u64 hcr_clear = 0;
    +-	u64 cptr_set = 0;
    +-	u64 cptr_clear = 0;
    + 
    + 	/* Protected KVM does not support AArch32 guests. */
    + 	BUILD_BUG_ON(FIELD_GET(ARM64_FEATURE_MASK(ID_AA64PFR0_EL1_EL0),
    +@@ arch/arm64/kvm/hyp/nvhe/pkvm.c: static void pvm_init_traps_aa64pfr0(struct kvm_vcpu *vcpu)
    + 	/* Trap AMU */
    + 	if (!FIELD_GET(ARM64_FEATURE_MASK(ID_AA64PFR0_EL1_AMU), feature_ids)) {
    + 		hcr_clear |= HCR_AMVOFFEN;
    +-		cptr_set |= CPTR_EL2_TAM;
     -	}
     -
    --	if (!kvm_has_feat(kvm, ID_AA64PFR0_EL1, AMU, IMP))
    --		val |= CPTR_EL2_TAM;
    --
    --	/* SVE can be disabled by userspace even if supported. */
    --	if (!vcpu_has_sve(vcpu)) {
    +-	/* Trap SVE */
    +-	if (!FIELD_GET(ARM64_FEATURE_MASK(ID_AA64PFR0_EL1_SVE), feature_ids)) {
     -		if (has_hvhe())
    --			val &= ~(CPACR_ELx_ZEN);
    +-			cptr_clear |= CPACR_ELx_ZEN;
     -		else
    --			val |= CPTR_EL2_TZ;
    --	}
    --
    --	/* No SME support in KVM. */
    --	BUG_ON(kvm_has_feat(kvm, ID_AA64PFR1_EL1, SME, IMP));
    --	if (has_hvhe())
    --		val &= ~(CPACR_ELx_SMEN);
    --	else
    --		val |= CPTR_EL2_TSM;
    --
    --	if (!kvm_has_feat(kvm, ID_AA64DFR0_EL1, TraceVer, IMP)) {
    +-			cptr_set |= CPTR_EL2_TZ;
    + 	}
    + 
    + 	vcpu->arch.hcr_el2 |= hcr_set;
    + 	vcpu->arch.hcr_el2 &= ~hcr_clear;
    +-	vcpu->arch.cptr_el2 |= cptr_set;
    +-	vcpu->arch.cptr_el2 &= ~cptr_clear;
    + }
    + 
    + /*
    +@@ arch/arm64/kvm/hyp/nvhe/pkvm.c: static void pvm_init_traps_aa64dfr0(struct kvm_vcpu *vcpu)
    + 	const u64 feature_ids = pvm_read_id_reg(vcpu, SYS_ID_AA64DFR0_EL1);
    + 	u64 mdcr_set = 0;
    + 	u64 mdcr_clear = 0;
    +-	u64 cptr_set = 0;
    + 
    + 	/* Trap/constrain PMU */
    + 	if (!FIELD_GET(ARM64_FEATURE_MASK(ID_AA64DFR0_EL1_PMUVer), feature_ids)) {
    +@@ arch/arm64/kvm/hyp/nvhe/pkvm.c: static void pvm_init_traps_aa64dfr0(struct kvm_vcpu *vcpu)
    + 	if (!FIELD_GET(ARM64_FEATURE_MASK(ID_AA64DFR0_EL1_TraceFilt), feature_ids))
    + 		mdcr_set |= MDCR_EL2_TTRF;
    + 
    +-	/* Trap Trace */
    +-	if (!FIELD_GET(ARM64_FEATURE_MASK(ID_AA64DFR0_EL1_TraceVer), feature_ids)) {
     -		if (has_hvhe())
    --			val |= CPACR_EL1_TTA;
    +-			cptr_set |= CPACR_EL1_TTA;
     -		else
    --			val |= CPTR_EL2_TTA;
    +-			cptr_set |= CPTR_EL2_TTA;
     -	}
     -
    --	vcpu->arch.cptr_el2 = val;
    --}
    --
    - static void pvm_init_traps_mdcr(struct kvm_vcpu *vcpu)
    - {
    - 	struct kvm *kvm = vcpu->kvm;
    -@@ arch/arm64/kvm/hyp/nvhe/pkvm.c: static int pkvm_vcpu_init_traps(struct pkvm_hyp_vcpu *hyp_vcpu)
    - 	struct kvm_vcpu *vcpu = &hyp_vcpu->vcpu;
    - 	int ret;
    + 	/* Trap External Trace */
    + 	if (!FIELD_GET(ARM64_FEATURE_MASK(ID_AA64DFR0_EL1_ExtTrcBuff), feature_ids))
    + 		mdcr_clear |= MDCR_EL2_E2TB_MASK << MDCR_EL2_E2TB_SHIFT;
      
    --	vcpu->arch.cptr_el2 = kvm_get_reset_cptr_el2(vcpu);
    - 	vcpu->arch.mdcr_el2 = 0;
    - 
    - 	pkvm_vcpu_reset_hcr(vcpu);
    -@@ arch/arm64/kvm/hyp/nvhe/pkvm.c: static int pkvm_vcpu_init_traps(struct pkvm_hyp_vcpu *hyp_vcpu)
    - 		return ret;
    + 	vcpu->arch.mdcr_el2 |= mdcr_set;
    + 	vcpu->arch.mdcr_el2 &= ~mdcr_clear;
    +-	vcpu->arch.cptr_el2 |= cptr_set;
    + }
      
    - 	pvm_init_traps_hcr(vcpu);
    --	pvm_init_traps_cptr(vcpu);
    - 	pvm_init_traps_mdcr(vcpu);
    + /*
    +@@ arch/arm64/kvm/hyp/nvhe/pkvm.c: static void pvm_init_trap_regs(struct kvm_vcpu *vcpu)
    + 	/* Clear res0 and set res1 bits to trap potential new features. */
    + 	vcpu->arch.hcr_el2 &= ~(HCR_RES0);
    + 	vcpu->arch.mdcr_el2 &= ~(MDCR_EL2_RES0);
    +-	if (!has_hvhe()) {
    +-		vcpu->arch.cptr_el2 |= CPTR_NVHE_EL2_RES1;
    +-		vcpu->arch.cptr_el2 &= ~(CPTR_NVHE_EL2_RES0);
    +-	}
    + }
      
    - 	return 0;
    + /*
     @@ arch/arm64/kvm/hyp/nvhe/pkvm.c: int __pkvm_init_vcpu(pkvm_handle_t handle, struct kvm_vcpu *host_vcpu,
      		return ret;
      	}
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

