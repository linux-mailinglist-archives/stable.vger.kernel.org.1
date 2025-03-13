Return-Path: <stable+bounces-124303-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0898DA5F499
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 13:34:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6956A17F744
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 12:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1EC3266F09;
	Thu, 13 Mar 2025 12:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F29EHWb3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F950267709
	for <stable@vger.kernel.org>; Thu, 13 Mar 2025 12:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741869115; cv=none; b=PfusU9nlo0360cWcD7DdrkzUIrGgBObRVxYk+T5iTOU3u3nZ/8vXRC2vzx+aPc7Vll/CPV1T1kq95pY/N2D/eV/YphMiX7sLTfUkAF1NBcEDF48uiz50QbIFVgXYN1bgcFLQjOVeUkjKekhoFZW+QyAIf5bzYZnEoD9c+rLHxc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741869115; c=relaxed/simple;
	bh=YGhcgAHm+H548b173kIzmZ9g/2767txGIoHTJNoxK80=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CUtbpgXN42NRHNnrJnPH+Q2i3yB97EXIAH3d9KaCj+oOV/Y6mJFblECB6+ZWGmyBGq+erwxpvUYGbR2A31JhV+ljYgaV/tl8I0pRhDfmIakM+ZVN11/+MtDj+MVxtaiM01NY8CRN4vJpduFO9pfr1VY9HfCvHjFAyst3oQVoH48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F29EHWb3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E96DBC4CEDD;
	Thu, 13 Mar 2025 12:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741869115;
	bh=YGhcgAHm+H548b173kIzmZ9g/2767txGIoHTJNoxK80=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F29EHWb3N2bvXGpoqCYbVLAolLFpSZBDDPmn1Ix4KoxeLqdE7CcC4cgoccGj/NgB/
	 bpxoECT5RSmZwK0F7umBPA9yE/s4krER2JpCl2yDuu511F/06CtbfFAbt31izIm8IP
	 YEs/9EJ03jm2Za2RPvGrd6h79CSfrSkwn0gpyi3SYmYC4+MKLnAb0mOvEL2fr0gTVo
	 BrXkngmdgUGZ4E4Y47Y2GVuF/fWlSObd+lhl2UzgbboUglMYuRhPdwUprm+EabSagC
	 XuiZvJPEGkP9pTcnftj8rLw8owmzcaAZfDNPEGuAW/shcYDh3WYE9ZkVmm/pLJuKlm
	 nXSI0BWFJCh2w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.13 4/8] KVM: arm64: Remove VHE host restore of CPACR_EL1.ZEN
Date: Thu, 13 Mar 2025 08:31:53 -0400
Message-Id: <20250313055100-95a6a11f77db4b93@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250312-stable-sve-6-13-v1-4-c7ba07a6f4f7@kernel.org>
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

The upstream commit SHA1 provided is correct: 459f059be702056d91537b99a129994aa6ccdd35

WARNING: Author mismatch between patch and upstream commit:
Backport author: Mark Brown<broonie@kernel.org>
Commit author: Mark Rutland<mark.rutland@arm.com>

Note: The patch differs from the upstream commit:
---
1:  459f059be7020 ! 1:  8d7be4ee41d6e KVM: arm64: Remove VHE host restore of CPACR_EL1.ZEN
    @@ Metadata
      ## Commit message ##
         KVM: arm64: Remove VHE host restore of CPACR_EL1.ZEN
     
    +    [ Upstream commit 459f059be702056d91537b99a129994aa6ccdd35 ]
    +
         When KVM is in VHE mode, the host kernel tries to save and restore the
         configuration of CPACR_EL1.ZEN (i.e. CPTR_EL2.ZEN when HCR_EL2.E2H=1)
         across kvm_arch_vcpu_load_fp() and kvm_arch_vcpu_put_fp(), since the
    @@ Commit message
         Reviewed-by: Oliver Upton <oliver.upton@linux.dev>
         Link: https://lore.kernel.org/r/20250210195226.1215254-4-mark.rutland@arm.com
         Signed-off-by: Marc Zyngier <maz@kernel.org>
    +    [Rework for refactoring of where the flags are stored -- broonie]
    +    Signed-off-by: Mark Brown <broonie@kernel.org>
     
      ## arch/arm64/include/asm/kvm_host.h ##
    -@@ arch/arm64/include/asm/kvm_host.h: struct cpu_sve_state {
    - struct kvm_host_data {
    - #define KVM_HOST_DATA_FLAG_HAS_SPE			0
    - #define KVM_HOST_DATA_FLAG_HAS_TRBE			1
    --#define KVM_HOST_DATA_FLAG_HOST_SVE_ENABLED		2
    - #define KVM_HOST_DATA_FLAG_HOST_SME_ENABLED		3
    - #define KVM_HOST_DATA_FLAG_TRBE_ENABLED			4
    - #define KVM_HOST_DATA_FLAG_EL1_TRACING_CONFIGURED	5
    +@@ arch/arm64/include/asm/kvm_host.h: struct kvm_vcpu_arch {
    + /* Save TRBE context if active  */
    + #define DEBUG_STATE_SAVE_TRBE	__vcpu_single_flag(iflags, BIT(6))
    + 
    +-/* SVE enabled for host EL0 */
    +-#define HOST_SVE_ENABLED	__vcpu_single_flag(sflags, BIT(0))
    + /* SME enabled for EL0 */
    + #define HOST_SME_ENABLED	__vcpu_single_flag(sflags, BIT(1))
    + /* Physical CPU not in supported_cpus */
     
      ## arch/arm64/kvm/fpsimd.c ##
     @@ arch/arm64/kvm/fpsimd.c: void kvm_arch_vcpu_load_fp(struct kvm_vcpu *vcpu)
      	fpsimd_save_and_flush_cpu_state();
      	*host_data_ptr(fp_owner) = FP_STATE_FREE;
      
    --	host_data_clear_flag(HOST_SVE_ENABLED);
    +-	vcpu_clear_flag(vcpu, HOST_SVE_ENABLED);
     -	if (read_sysreg(cpacr_el1) & CPACR_EL1_ZEN_EL0EN)
    --		host_data_set_flag(HOST_SVE_ENABLED);
    +-		vcpu_set_flag(vcpu, HOST_SVE_ENABLED);
     -
      	if (system_supports_sme()) {
    - 		host_data_clear_flag(HOST_SME_ENABLED);
    + 		vcpu_clear_flag(vcpu, HOST_SME_ENABLED);
      		if (read_sysreg(cpacr_el1) & CPACR_EL1_SMEN_EL0EN)
     @@ arch/arm64/kvm/fpsimd.c: void kvm_arch_vcpu_put_fp(struct kvm_vcpu *vcpu)
      		 * when needed.
    @@ arch/arm64/kvm/fpsimd.c: void kvm_arch_vcpu_put_fp(struct kvm_vcpu *vcpu)
     -		 * for EL0.  To avoid spurious traps, restore the trap state
     -		 * seen by kvm_arch_vcpu_load_fp():
     -		 */
    --		if (host_data_test_flag(HOST_SVE_ENABLED))
    +-		if (vcpu_get_flag(vcpu, HOST_SVE_ENABLED))
     -			sysreg_clear_set(CPACR_EL1, 0, CPACR_EL1_ZEN_EL0EN);
     -		else
     -			sysreg_clear_set(CPACR_EL1, CPACR_EL1_ZEN_EL0EN, 0);
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.13.y       |  Success    |  Success   |

