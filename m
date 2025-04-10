Return-Path: <stable+bounces-132157-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF42A84901
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 17:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76DC59C1B60
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 15:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A80E1EA7FF;
	Thu, 10 Apr 2025 15:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YB1gIFC2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DB81E9B2F
	for <stable@vger.kernel.org>; Thu, 10 Apr 2025 15:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744300483; cv=none; b=uIgiYQUdrbpw5+nCt/BRpU+IH2y8fevgYb70EcqUX4mYAKsNfPIdczsiD9zQI1lQNWlHpFdaSFDBKRwQj91JuwhiBTsmwnPaHUPTqHCn8XsENh+XNfvxDy2c9c2V+InSA/CbXu9BHkmWv7SxqnGu/xQDApewl9gtNANS+n1EQXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744300483; c=relaxed/simple;
	bh=rx2CApgANnHfGMYlVjM4RpWy1nL+iXSBlNg7Xa0fX2E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SeHSchnh2R11LWN9nQWXtm9KziAn2v6cQp8BxXKL0dgMEQl47cGrjp4/OET4R1TO7xtzPbrObxggjvhRqPnr5FNc+EYESQJ67yYDHFbZwYTntAh3mGAu92ZH8CUP7m5BMMsUJCA/aI4/aESzA5Lz/yZpKz1CYj/Kjz7iN78X0nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YB1gIFC2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6AFBC4CEE9;
	Thu, 10 Apr 2025 15:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744300483;
	bh=rx2CApgANnHfGMYlVjM4RpWy1nL+iXSBlNg7Xa0fX2E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YB1gIFC2UAievYGEc9lV2UeWthvKcL7JYt8oKUOQoITMBHMFclNy16Aad0s0n+Iov
	 57B7ph8qg6NNn6vxs4bbun6RU1nrSASUxR/HkbFMRwM7XYmzF4iMC/t87Re45Pf5bn
	 EKQp169hEvyUYqdPUBvsr4b4pkPRiKD4fT2EBwo6vREO0/FDjaU5u3KDx7hsuLA5N5
	 VI63llmfHhwkxs2bdN9JHRKkWk11Ub3831S0l3O2yMvu1ouL3jcZ691pkOEbv9NXiK
	 9lOdSMhQf+TSNSRbq7pdLJz1YnOW55cmGC5obrYngIdvaE+qulbIF2CWLLGopUbhkJ
	 VJioNN2hTwsOg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	broonie@kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15 v3 01/11] KVM: arm64: Get rid of host SVE tracking/saving
Date: Thu, 10 Apr 2025 11:54:41 -0400
Message-Id: <20250410112209-863d60ce97fc4e9f@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250408-stable-sve-5-15-v3-1-ca9a6b850f55@kernel.org>
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
⚠️ Found follow-up fixes in mainline

The upstream commit SHA1 provided is correct: 8383741ab2e773a992f1f0f8acdca5e7a4687c49

WARNING: Author mismatch between patch and upstream commit:
Backport author: Mark Brown<broonie@kernel.org>
Commit author: Marc Zyngier<maz@kernel.org>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (exact SHA1)

Found fixes commits:
d52d165d67c5 KVM: arm64: Always start with clearing SVE flag on load

Note: The patch differs from the upstream commit:
---
1:  8383741ab2e77 ! 1:  e6a9fd27335d3 KVM: arm64: Get rid of host SVE tracking/saving
    @@ Metadata
      ## Commit message ##
         KVM: arm64: Get rid of host SVE tracking/saving
     
    +    [ Upstream commit 8383741ab2e773a992f1f0f8acdca5e7a4687c49 ]
    +
         The SVE host tracking in KVM is pretty involved. It relies on a
         set of flags tracking the ownership of the SVE register, as well
         as that of the EL0 access.
    @@ Commit message
     
         Reviewed-by: Mark Brown <broonie@kernel.org>
         Signed-off-by: Marc Zyngier <maz@kernel.org>
    +    Signed-off-by: Mark Brown <broonie@kernel.org>
     
      ## arch/arm64/include/asm/kvm_host.h ##
     @@ arch/arm64/include/asm/kvm_host.h: struct kvm_vcpu_arch {
    @@ arch/arm64/kvm/fpsimd.c: void kvm_arch_vcpu_put_fp(struct kvm_vcpu *vcpu)
     
      ## arch/arm64/kvm/hyp/include/hyp/switch.h ##
     @@ arch/arm64/kvm/hyp/include/hyp/switch.h: static inline bool __populate_fault_info(struct kvm_vcpu *vcpu)
    - 	return __get_fault_info(vcpu->arch.fault.esr_el2, &vcpu->arch.fault);
    + 	return __get_fault_info(esr, &vcpu->arch.fault);
      }
      
     -static inline void __hyp_sve_save_host(struct kvm_vcpu *vcpu)
    @@ arch/arm64/kvm/hyp/include/hyp/switch.h: static inline bool __populate_fault_inf
      {
      	sve_cond_update_zcr_vq(vcpu_sve_max_vq(vcpu) - 1, SYS_ZCR_EL2);
     @@ arch/arm64/kvm/hyp/include/hyp/switch.h: static inline void __hyp_sve_restore_guest(struct kvm_vcpu *vcpu)
    -  */
    - static bool kvm_hyp_handle_fpsimd(struct kvm_vcpu *vcpu, u64 *exit_code)
    + /* Check for an FPSIMD/SVE trap and handle as appropriate */
    + static inline bool __hyp_handle_fpsimd(struct kvm_vcpu *vcpu)
      {
     -	bool sve_guest, sve_host;
     +	bool sve_guest;
    @@ arch/arm64/kvm/hyp/include/hyp/switch.h: static inline void __hyp_sve_restore_gu
     -
     +	sve_guest = vcpu_has_sve(vcpu);
      	esr_ec = kvm_vcpu_trap_get_class(vcpu);
    - 
    - 	/* Don't handle SVE traps for non-SVE vcpus here: */
    -@@ arch/arm64/kvm/hyp/include/hyp/switch.h: static bool kvm_hyp_handle_fpsimd(struct kvm_vcpu *vcpu, u64 *exit_code)
    + 	if (esr_ec != ESR_ELx_EC_FP_ASIMD &&
    + 	    esr_ec != ESR_ELx_EC_SVE)
    +@@ arch/arm64/kvm/hyp/include/hyp/switch.h: static inline bool __hyp_handle_fpsimd(struct kvm_vcpu *vcpu)
      	isb();
      
      	if (vcpu->arch.flags & KVM_ARM64_FP_HOST) {
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

