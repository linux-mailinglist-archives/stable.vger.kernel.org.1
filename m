Return-Path: <stable+bounces-128388-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CCADA7C8FC
	for <lists+stable@lfdr.de>; Sat,  5 Apr 2025 13:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3762217642A
	for <lists+stable@lfdr.de>; Sat,  5 Apr 2025 11:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B730F1C28E;
	Sat,  5 Apr 2025 11:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="itapsCQa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D51EC2FD
	for <stable@vger.kernel.org>; Sat,  5 Apr 2025 11:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743854270; cv=none; b=aCmFsSANojCZOMZp5XKxyWCvtymje0JQbYlgdqFio8NTdBuMf+7aaSP5pSuEYR4cgQ11IdUv/FJrPGiZKTCiZKr4UiUgfYsEPoQA99YWwZc85xuhNibyQ5pTrsnBY58eoX/XUySMcegi5GhD0X9i8pLhipHEhCtQNaF37UytGak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743854270; c=relaxed/simple;
	bh=fS1Hlo0BUDaPguJfNpiuyNrZYXecvpkI6rXZ/nuYfJQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tXMI+Gvu9cbOlXhcIjcjHY93zgkwUGRdnL3VF5iyFLATxwdFO2diazLQMsBnVzU1HjOpn3RFM87kOmQqaJv7XElQgtCjqMiYaK6MSEjM/yhRMTHlvwl5xVrHaSM5BWvChvVbUnyXruxuvb1kh+yeUcxKID24Oh8faRe1AG1ElB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=itapsCQa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67CBEC4CEE4;
	Sat,  5 Apr 2025 11:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743854269;
	bh=fS1Hlo0BUDaPguJfNpiuyNrZYXecvpkI6rXZ/nuYfJQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=itapsCQaHEAqn/epK/As2iHpnI8IuK3sLVC6aqMNmX9n8WTrVBSVR0dQ7jEEZcac2
	 ljlmpNdAQ55iWpH0Rq8qPkLGOEB9LEpXqkaTFvuRaLMpeAO9VqSAxfNT9wAfAjCuKl
	 JUMhzeTXEdEiZCtPOmgfl0oEoZP7owXq3dp2AMds31FIAEZqbCn9wawTUguFNo4Yyn
	 z6Wp9+E5uS7cBNw5rF5Alkafk6JSunaDcz1TA25f+kC9UPegZjuL/xUsdJlKN+hbwi
	 SHo/BuaQw/jGC9aRxiTJqCl/X178z5M4xZVGeB8ohToPEXy+sWrdTg4FWKipG9zTPM
	 q9MCuM8Ld3u2Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH RESEND 6.1 10/12] KVM: arm64: Mark some header functions as inline
Date: Sat,  5 Apr 2025 07:57:48 -0400
Message-Id: <20250405024846-b7aeeb7ac291ed01@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250404-stable-sve-6-1-v1-10-cd5c9eb52d49@kernel.org>
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

The upstream commit SHA1 provided is correct: f9dd00de1e53a47763dfad601635d18542c3836d

WARNING: Author mismatch between patch and upstream commit:
Backport author: Mark Brown<broonie@kernel.org>
Commit author: Mark Rutland<mark.rutland@arm.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.13.y | Present (different SHA1: f32b2b45db8a)
6.12.y | Present (different SHA1: 4a397bf077e7)
6.6.y | Present (different SHA1: 93074abedecb)

Note: The patch differs from the upstream commit:
---
1:  f9dd00de1e53a ! 1:  6d0ff44404389 KVM: arm64: Mark some header functions as inline
    @@ Metadata
      ## Commit message ##
         KVM: arm64: Mark some header functions as inline
     
    +    [ Upstream commit f9dd00de1e53a47763dfad601635d18542c3836d ]
    +
         The shared hyp switch header has a number of static functions which
         might not be used by all files that include the header, and when unused
         they will provoke compiler warnings, e.g.
    @@ Commit message
         Reviewed-by: Oliver Upton <oliver.upton@linux.dev>
         Link: https://lore.kernel.org/r/20250210195226.1215254-8-mark.rutland@arm.com
         Signed-off-by: Marc Zyngier <maz@kernel.org>
    +    Signed-off-by: Mark Brown <broonie@kernel.org>
     
      ## arch/arm64/kvm/hyp/include/hyp/switch.h ##
    -@@ arch/arm64/kvm/hyp/include/hyp/switch.h: static inline bool __populate_fault_info(struct kvm_vcpu *vcpu)
    - 	return __get_fault_info(vcpu->arch.fault.esr_el2, &vcpu->arch.fault);
    - }
    - 
    --static bool kvm_hyp_handle_mops(struct kvm_vcpu *vcpu, u64 *exit_code)
    -+static inline bool kvm_hyp_handle_mops(struct kvm_vcpu *vcpu, u64 *exit_code)
    - {
    - 	*vcpu_pc(vcpu) = read_sysreg_el2(SYS_ELR);
    - 	arm64_mops_reset_regs(vcpu_gp_regs(vcpu), vcpu->arch.fault.esr_el2);
    -@@ arch/arm64/kvm/hyp/include/hyp/switch.h: static void kvm_hyp_save_fpsimd_host(struct kvm_vcpu *vcpu)
    +@@ arch/arm64/kvm/hyp/include/hyp/switch.h: static inline void __hyp_sve_restore_guest(struct kvm_vcpu *vcpu)
       * If FP/SIMD is not implemented, handle the trap and inject an undefined
       * instruction exception to the guest. Similarly for trapped SVE accesses.
       */
    @@ arch/arm64/kvm/hyp/include/hyp/switch.h: static void kvm_hyp_save_fpsimd_host(st
      {
      	bool sve_guest;
      	u8 esr_ec;
    -@@ arch/arm64/kvm/hyp/include/hyp/switch.h: static bool handle_ampere1_tcr(struct kvm_vcpu *vcpu)
    +@@ arch/arm64/kvm/hyp/include/hyp/switch.h: static bool kvm_hyp_handle_ptrauth(struct kvm_vcpu *vcpu, u64 *exit_code)
      	return true;
      }
      
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

