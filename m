Return-Path: <stable+bounces-124306-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A2FA5F49B
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 13:34:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 997E017FAF1
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 12:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08BE0267739;
	Thu, 13 Mar 2025 12:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MuTvvK5K"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0FB267735
	for <stable@vger.kernel.org>; Thu, 13 Mar 2025 12:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741869121; cv=none; b=AaN8JvuSzshqFau1TE83S3YPOB24K6+KJN5N9KOaKOoqLAl+CwO3FCmHAidjRUBzwKyhxTtoukgQJunqEiAJuWIC75o7se98m9mxEVUBIyeYwz8dIxK1pi4hNjjWyyvcGk87MjO6srnHVmW4mUX1/d0a1xuWmWFNaygvvilLCBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741869121; c=relaxed/simple;
	bh=1surSqogUMb54X+eflbJg3yTvNO/fz2yxzZVRDwgqww=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nJ1J1McmJ1Egfj2y2/ZuzO4OlH/rg4SHUZ81PgP5qseRvzCb5xYjvkHHrA5yXWvi7Ti8Bl3G8dT9JZ1VDvF7m/BtPwXQxZVntuvfGY0aVLU2CfjxoBZkRUstWrdhRGnOJSx5kF1Sr7+jVh5FRWE7v6FWFBZB1RbdukTR2t50w00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MuTvvK5K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 247BEC4CEDD;
	Thu, 13 Mar 2025 12:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741869121;
	bh=1surSqogUMb54X+eflbJg3yTvNO/fz2yxzZVRDwgqww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MuTvvK5KkV41z20dr9Nbd5ZUSJrFC903vJez4gf9TDJgOuxkWwS0L0vSfpwAllzzR
	 6ZlHR613xY2c2Dd+s7h2g2dTkwePH53vLE890/z/MBXoZ7q3ysFHLgOe6kAgAgRvAt
	 8ZPfNXl/+uP/Zmj/37W3Ix8gADNB9z+1/vWyPuDXoAcIoqLEIRAUHIT+QDhDOWpcxz
	 yQcsXC/ymai2vViF6DB2HfITWq+8UFca7PPDsdpybXPX7RJ/XjFkSs44Xco3ZNS+P+
	 OWxqvBKz7md2LuQQlQOgOPoafiwGLM8g+rYHPzcDG3NJJEmyZVsn7L1+l/zw7Booke
	 KB3QnboJj88Zw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.13 1/8] KVM: arm64: Calculate cptr_el2 traps on activating traps
Date: Thu, 13 Mar 2025 08:31:59 -0400
Message-Id: <20250313054232-becb62f2f2dd78b0@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250312-stable-sve-6-13-v1-1-c7ba07a6f4f7@kernel.org>
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

Note: The patch differs from the upstream commit:
---
1:  2fd5b4b0e7b44 ! 1:  06e6cdf67becb KVM: arm64: Calculate cptr_el2 traps on activating traps
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
    + 		mdcr_clear |= MDCR_EL2_E2TB_MASK;
    + 
    + 	vcpu->arch.mdcr_el2 |= mdcr_set;
    + 	vcpu->arch.mdcr_el2 &= ~mdcr_clear;
    +-	vcpu->arch.cptr_el2 |= cptr_set;
    + }
      
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
    + 
    + static void pkvm_vcpu_reset_hcr(struct kvm_vcpu *vcpu)
    +@@ arch/arm64/kvm/hyp/nvhe/pkvm.c: static void pkvm_vcpu_reset_hcr(struct kvm_vcpu *vcpu)
    +  */
    + static void pkvm_vcpu_init_traps(struct kvm_vcpu *vcpu)
    + {
     -	vcpu->arch.cptr_el2 = kvm_get_reset_cptr_el2(vcpu);
      	vcpu->arch.mdcr_el2 = 0;
      
      	pkvm_vcpu_reset_hcr(vcpu);
    -@@ arch/arm64/kvm/hyp/nvhe/pkvm.c: static int pkvm_vcpu_init_traps(struct pkvm_hyp_vcpu *hyp_vcpu)
    - 		return ret;
    - 
    - 	pvm_init_traps_hcr(vcpu);
    --	pvm_init_traps_cptr(vcpu);
    - 	pvm_init_traps_mdcr(vcpu);
    - 
    - 	return 0;
     @@ arch/arm64/kvm/hyp/nvhe/pkvm.c: int __pkvm_init_vcpu(pkvm_handle_t handle, struct kvm_vcpu *host_vcpu,
      		return ret;
      	}
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.13.y       |  Success    |  Success   |

