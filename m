Return-Path: <stable+bounces-127684-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C63C5A7A71A
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 17:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C64916486D
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 15:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9819B24EF7E;
	Thu,  3 Apr 2025 15:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WK8HXP/z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58AA524CEE5
	for <stable@vger.kernel.org>; Thu,  3 Apr 2025 15:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743694722; cv=none; b=DD5IQbs/tmgOZkmmtwQLiww4S2Y8SWUjFhuCAI9+MBY4UlSqP6BGPPQ5Aems84bT7j68CeE4OETOvBmtW3EKviV6DGOYbyGUCANvdAOIoLtR8/os6ite35Gd84nayeDn3g2K7FsQls0Kt+uUxfsdf/z53LSqbd+Z7pUN+yT3YfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743694722; c=relaxed/simple;
	bh=bz+D/XoQi3Wm8EtKycddwzGLKB7PULni0xqOYolBmCE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UKB2HBkS7lur4OcVT7bycB//2U1E3pfclu3qjN5rAqw9ZANkOjHxMbwFW/XTw0ve/b6kkz6woJUL5CRWlQdYKQnUS434itDczILviyEdcuMm05Zcco6fDbenKNQLYk+a/mwPhRHpoxnZ7VbZJAef0gYSx/wNmpkxNbu1Q3UMqGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WK8HXP/z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EAAAC4CEE3;
	Thu,  3 Apr 2025 15:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743694721;
	bh=bz+D/XoQi3Wm8EtKycddwzGLKB7PULni0xqOYolBmCE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WK8HXP/z8F9rtESKIijHgTI+ZupZCrA0zl5t3efjH1XfS4suCwZzyT4oqCQVYh09m
	 y6i3CMosDbB8pTR6f+EW9i/zHibFVJd/GnpegLd57U3fLU08eD+cRmznB9/5NymwPV
	 ThMGiRJlE8k5vRadkGMxZJPShnyrgwXT1HjR/bew1bxXx2Q2Cv9A14vlBgLDbvSWCV
	 89xcMMZeUQ89yMNLi84rxxzwjKh+VjRnvGImu085BEG3hLnqPtuw0zCuXBrQPkd3Yq
	 thVL6MlrzOwwFbINJg6hXUb/dHJlv074uTUMuxDERFRJoxZ6hkE8NM94xaexD6PxVS
	 Jv/exW62/89uQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	broonie@kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15 v2 01/10] KVM: arm64: Get rid of host SVE tracking/saving
Date: Thu,  3 Apr 2025 11:38:38 -0400
Message-Id: <20250403081043-11bc930a2f4bbcc3@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250403-stable-sve-5-15-v2-1-30a36a78a20a@kernel.org>
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
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (exact SHA1)

Found fixes commits:
d52d165d67c5 KVM: arm64: Always start with clearing SVE flag on load

Note: The patch differs from the upstream commit:
---
1:  8383741ab2e77 ! 1:  6e268fa161674 KVM: arm64: Get rid of host SVE tracking/saving
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

