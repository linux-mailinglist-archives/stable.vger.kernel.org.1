Return-Path: <stable+bounces-125777-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47FF4A6C17D
	for <lists+stable@lfdr.de>; Fri, 21 Mar 2025 18:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83FBA1B60306
	for <lists+stable@lfdr.de>; Fri, 21 Mar 2025 17:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08DB122D7B2;
	Fri, 21 Mar 2025 17:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bRoLxTDg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBCA224B1C
	for <stable@vger.kernel.org>; Fri, 21 Mar 2025 17:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742578148; cv=none; b=E+JNGQM1gYaUHo+I0RWstkukvo1MYLBVaWMVBDU9Z9WtnxRY0vOWukYxs6Q4Yezhb9qqXep3/17qTdTcWbtgxnnk9lr1jHlqjCazkvOvbm0jRNigt38+v6BfZzSBDROmk4KDiAOxH9gX11bfEot+LVeYymdmT3jg1IwODB0uo5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742578148; c=relaxed/simple;
	bh=llkXDMjV7n1YOetlq+MNIbK4HQtu8VJyaIJ/GtBPVQE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X9GPZuSXcmaUvrkjUKC0v2osVY+u0xsgMB9c35fvpowOW/0/6fK/nhbNExMiZCSAc+7Npz26i+3Ru6NQxq2SaUT59NXgk06Vy93tZX4fNQKa7+n6o+GaEQGl/XRngCpUrZE0WAMDFyz+GBZejYFxrLpHtA/yWTOCtxkPwyl3b8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bRoLxTDg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE880C4CEE3;
	Fri, 21 Mar 2025 17:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742578148;
	bh=llkXDMjV7n1YOetlq+MNIbK4HQtu8VJyaIJ/GtBPVQE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bRoLxTDguwTXI4ovh1cR032juCc75iF3DNIac53S+lEEtb6VE9m1FLQ419l5KC5Y7
	 vrxq3ja1ngXMv97Cl/qXeHjrKGHSYCkOsBNs9ocbsCg+4XG+/rytNb+dAyFwE/PJ6i
	 KoGou7UneBbzEhG32sPh4W2Mvtu5CYSHsS2IMOH68+RPgt5XB5l9z9AMmLJwF277Ob
	 oe9+osXxnFBh34RVWLqRMIv8Qpx6z9MEA7LbdmX7AAan0XutzypQQKaFfX8aPrh/Jk
	 aScinW5eO+uSzfY6h/6XgVvsYdFOhuisGCdMcweAic3fBOywg430dQVDpEjFNWuRp7
	 BoXhLw//+mXCw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6 2/8] KVM: arm64: Unconditionally save+flush host FPSIMD/SVE/SME state
Date: Fri, 21 Mar 2025 13:28:56 -0400
Message-Id: <20250321114948-06a3584c009ef0d1@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250321-stable-sve-6-6-v1-2-0b3a6a14ea53@kernel.org>
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
6.13.y | Present (different SHA1: 8361da508047)
6.12.y | Present (different SHA1: 6942e1f47a00)

Note: The patch differs from the upstream commit:
---
1:  fbc7e61195e23 ! 1:  2d0c224eda446 KVM: arm64: Unconditionally save+flush host FPSIMD/SVE/SME state
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
    +    [ Mark: Handle vcpu/host flag conflict ]
    +    Signed-off-by: Mark Rutland <mark.rutland@arm.com>
    +    Signed-off-by: Mark Brown <broonie@kernel.org>
     
      ## arch/arm64/kernel/fpsimd.c ##
     @@ arch/arm64/kernel/fpsimd.c: void fpsimd_signal_preserve_current_state(void)
    @@ arch/arm64/kvm/fpsimd.c: void kvm_arch_vcpu_load_fp(struct kvm_vcpu *vcpu)
     +	 * When the host may use SME, fpsimd_save_and_flush_cpu_state() ensures
     +	 * that PSTATE.{SM,ZA} == {0,0}.
      	 */
    --	*host_data_ptr(fp_owner) = FP_STATE_HOST_OWNED;
    --	*host_data_ptr(fpsimd_state) = kern_hyp_va(&current->thread.uw.fpsimd_state);
    --	*host_data_ptr(fpmr_ptr) = kern_hyp_va(&current->thread.uw.fpmr);
    +-	vcpu->arch.fp_state = FP_STATE_HOST_OWNED;
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
     -		/*
     -		 * If PSTATE.SM is enabled then save any pending FP
    @@ arch/arm64/kvm/fpsimd.c: void kvm_arch_vcpu_load_fp(struct kvm_vcpu *vcpu)
     -		 * been saved, this is very unlikely to happen.
     -		 */
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
| stable/linux-6.12.y       |  Success    |  Success   |

