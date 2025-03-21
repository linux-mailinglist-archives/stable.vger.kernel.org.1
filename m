Return-Path: <stable+bounces-125762-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2EFFA6C16F
	for <lists+stable@lfdr.de>; Fri, 21 Mar 2025 18:27:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D42DA1B60517
	for <lists+stable@lfdr.de>; Fri, 21 Mar 2025 17:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A437922DF8B;
	Fri, 21 Mar 2025 17:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DCsCMOO7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641C522DF84
	for <stable@vger.kernel.org>; Fri, 21 Mar 2025 17:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742577962; cv=none; b=br/ObM0eOn1i610TwD0OY7P0JmQjzAbVcQ8TlXslU0ZPbM5KQ+c5DJiPcf83lbqItR3OkfqgQXToWBI8a1D4/ptKT8kRU1yq9oTTj3tYS0tJRfm0Nd7/z1Yu61mZc31fh3iTUN8L4XtKh3aJC2F4Keai75KnR9PNjjqh9XnDC9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742577962; c=relaxed/simple;
	bh=b93nc/1/MrKJSB/9d8cQOy32gCElgKf2XQnmseKUGp4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CbsZ4BeyGYmtJS2Btasl8/8arPxeoo54qiUVaSi85kKXJ4jFTwwkXqyre4pvJETqgGLzHOKt7+GV86sEIWhGcMNQ/0S5LSQsduxS/u8FZaf2lwWNjjGhZpctyDxhgak9qpBMnjiPmM5Fa5j30TxlFbCJm5zgLcjgMG3vXF+rPlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DCsCMOO7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC9B0C4CEE3;
	Fri, 21 Mar 2025 17:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742577962;
	bh=b93nc/1/MrKJSB/9d8cQOy32gCElgKf2XQnmseKUGp4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DCsCMOO7BX7jPiAeLoZALotRBNCc0o6hBIPzRZbWkM2Z4TqSNGcPUB4+whNWRypyd
	 J6kL/eiV3DxsJqz81knzV9KpqX1Yc4D2ybw+dgBHztQsbuX6kSpnUfmqSQ3y0NiGzV
	 Ef7idCX3v1BlAUj1e3/5w9UWM020UEqr2fNMmfXT/miBXqJFrhVcVkbi99dT0wwTJH
	 tkoz7J4sRhJdHVo73rS8J5B8Q33KHm6JxMG0aYK9u8+TovSuSTUywoR62IHg8M90tH
	 tefEFfQVb7UNFQ8+mcoM3/OT9Uj1ENM0U7xw+rornseBiDrQau2FzA3jXh9DpHg1ZB
	 AdcZ0VFLxpDMQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.13 v2 5/8] KVM: arm64: Remove VHE host restore of CPACR_EL1.SMEN
Date: Fri, 21 Mar 2025 13:25:50 -0400
Message-Id: <20250321130421-1ddcf42f147b6176@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250321-stable-sve-6-13-v2-5-3150e3370c40@kernel.org>
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

The upstream commit SHA1 provided is correct: 407a99c4654e8ea65393f412c421a55cac539f5b

WARNING: Author mismatch between patch and upstream commit:
Backport author: Mark Brown<broonie@kernel.org>
Commit author: Mark Rutland<mark.rutland@arm.com>

Note: The patch differs from the upstream commit:
---
1:  407a99c4654e8 ! 1:  40ee524d99333 KVM: arm64: Remove VHE host restore of CPACR_EL1.SMEN
    @@ Metadata
      ## Commit message ##
         KVM: arm64: Remove VHE host restore of CPACR_EL1.SMEN
     
    +    [ Upstream commit 407a99c4654e8ea65393f412c421a55cac539f5b ]
    +
         When KVM is in VHE mode, the host kernel tries to save and restore the
         configuration of CPACR_EL1.SMEN (i.e. CPTR_EL2.SMEN when HCR_EL2.E2H=1)
         across kvm_arch_vcpu_load_fp() and kvm_arch_vcpu_put_fp(), since the
    @@ Commit message
         Reviewed-by: Oliver Upton <oliver.upton@linux.dev>
         Link: https://lore.kernel.org/r/20250210195226.1215254-5-mark.rutland@arm.com
         Signed-off-by: Marc Zyngier <maz@kernel.org>
    +    [Update for rework of flags storage -- broonie]
    +    Signed-off-by: Mark Brown <broonie@kernel.org>
     
      ## arch/arm64/include/asm/kvm_host.h ##
    -@@ arch/arm64/include/asm/kvm_host.h: struct cpu_sve_state {
    - struct kvm_host_data {
    - #define KVM_HOST_DATA_FLAG_HAS_SPE			0
    - #define KVM_HOST_DATA_FLAG_HAS_TRBE			1
    --#define KVM_HOST_DATA_FLAG_HOST_SME_ENABLED		3
    - #define KVM_HOST_DATA_FLAG_TRBE_ENABLED			4
    - #define KVM_HOST_DATA_FLAG_EL1_TRACING_CONFIGURED	5
    - 	unsigned long flags;
    +@@ arch/arm64/include/asm/kvm_host.h: struct kvm_vcpu_arch {
    + /* Save TRBE context if active  */
    + #define DEBUG_STATE_SAVE_TRBE	__vcpu_single_flag(iflags, BIT(6))
    + 
    +-/* SME enabled for EL0 */
    +-#define HOST_SME_ENABLED	__vcpu_single_flag(sflags, BIT(1))
    + /* Physical CPU not in supported_cpus */
    + #define ON_UNSUPPORTED_CPU	__vcpu_single_flag(sflags, BIT(2))
    + /* WFIT instruction trapped */
     
      ## arch/arm64/kvm/fpsimd.c ##
     @@ arch/arm64/kvm/fpsimd.c: void kvm_arch_vcpu_load_fp(struct kvm_vcpu *vcpu)
    @@ arch/arm64/kvm/fpsimd.c: void kvm_arch_vcpu_load_fp(struct kvm_vcpu *vcpu)
      	*host_data_ptr(fp_owner) = FP_STATE_FREE;
      
     -	if (system_supports_sme()) {
    --		host_data_clear_flag(HOST_SME_ENABLED);
    +-		vcpu_clear_flag(vcpu, HOST_SME_ENABLED);
     -		if (read_sysreg(cpacr_el1) & CPACR_EL1_SMEN_EL0EN)
    --			host_data_set_flag(HOST_SME_ENABLED);
    +-			vcpu_set_flag(vcpu, HOST_SME_ENABLED);
     -	}
     -
      	/*
    @@ arch/arm64/kvm/fpsimd.c: void kvm_arch_vcpu_put_fp(struct kvm_vcpu *vcpu)
     -	 */
     -	if (has_vhe() && system_supports_sme()) {
     -		/* Also restore EL0 state seen on entry */
    --		if (host_data_test_flag(HOST_SME_ENABLED))
    --			sysreg_clear_set(CPACR_EL1, 0, CPACR_EL1_SMEN);
    +-		if (vcpu_get_flag(vcpu, HOST_SME_ENABLED))
    +-			sysreg_clear_set(CPACR_EL1, 0, CPACR_ELx_SMEN);
     -		else
     -			sysreg_clear_set(CPACR_EL1,
     -					 CPACR_EL1_SMEN_EL0EN,
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |

