Return-Path: <stable+bounces-127694-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B78C0A7A724
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 17:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E658817710E
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 15:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3132505D2;
	Thu,  3 Apr 2025 15:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NUgQ8o9X"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE190250C0D
	for <stable@vger.kernel.org>; Thu,  3 Apr 2025 15:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743694767; cv=none; b=bxgF/Wdrl1MvlvA/UzqRhQxEtLHlkuRax85k0HMnnDAFG/U/FpioHprjaEkgwz6JmTYT2g9HmFtW2hFPLvxfP1sB+Osf0Dey2K/6/gcs+j+tW+Kwf8CeNGkdX1e3fAQXuP+8ydU4rcc0zIVaaGydL/zxzf3z5jwwO0zuMJivPmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743694767; c=relaxed/simple;
	bh=6FwvhDA46MMksSHHwpzw2zelKzj4fPF4RHok55E46UY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t4GK7NhodYr2SYsgSTN6yoLvfSvjWnaXVJll1onX284dR7E0kKblI/e8YN3i5kK0gmZyZbLbvx2szrZCs458jeKYGKoOxNBqj5dQ6OL1T/LoAiHlIJF7BbgGeis+adeOg3854JFGjk2SHB8yt0kHVe+Ge8YK7ItTqIR7SRN0K+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NUgQ8o9X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6323C4CEE3;
	Thu,  3 Apr 2025 15:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743694766;
	bh=6FwvhDA46MMksSHHwpzw2zelKzj4fPF4RHok55E46UY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NUgQ8o9Xeuo16oKZbip//cYxTqYgNuyf/2a9+rn6LtuWEVPkDXSJGeEn6NlbudJaN
	 AFqBc8F3HiOJ2iVpnfOUegeAKXsA/WdTVhN57E0GWv0sXW9WSsYKgoo6ylM2UoTbYX
	 GdMTuEt9waaESejR9JmWrqryzfV5bLQDJL/mJsEuTbjX0cj+bEIWBbY30q3PTfMRc7
	 lENsUrdSK9AjGC5MIrkTuboWS273XMEaBZUt1hZUzWwBcKNTsUCJLcsqp0QrcvCFJa
	 c9VUYuRpiqONrisLugKioWFWV9LK6JBglIQEBF0RLy78cMbZttmuVaBmL75RyQYQo8
	 VkPMkKzEMO/Mw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	broonie@kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15 v2 02/10] KVM: arm64: Discard any SVE state when entering KVM guests
Date: Thu,  3 Apr 2025 11:39:22 -0400
Message-Id: <20250403085850-45573ddb54f00a4f@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250403-stable-sve-5-15-v2-2-30a36a78a20a@kernel.org>
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
ℹ️ This is part 02/10 of a series
⚠️ Found follow-up fixes in mainline

The upstream commit SHA1 provided is correct: 93ae6b01bafee8fa385aa25ee7ebdb40057f6abe

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Not found

Found fixes commits:
fbc7e61195e2 KVM: arm64: Unconditionally save+flush host FPSIMD/SVE/SME state

Note: The patch differs from the upstream commit:
---
1:  93ae6b01bafee ! 1:  710abf6eb6613 KVM: arm64: Discard any SVE state when entering KVM guests
    @@ Metadata
      ## Commit message ##
         KVM: arm64: Discard any SVE state when entering KVM guests
     
    +    [ Upstream commit 93ae6b01bafee8fa385aa25ee7ebdb40057f6abe ]
    +
         Since 8383741ab2e773a99 (KVM: arm64: Get rid of host SVE tracking/saving)
         KVM has not tracked the host SVE state, relying on the fact that we
         currently disable SVE whenever we perform a syscall. This may not be true
    @@ Commit message
         Reviewed-by: Marc Zyngier <maz@kernel.org>
         Link: https://lore.kernel.org/r/20221115094640.112848-2-broonie@kernel.org
         Signed-off-by: Will Deacon <will@kernel.org>
    +    [ Mark: trivial backport to v6.1 ]
    +    Signed-off-by: Mark Rutland <mark.rutland@arm.com>
    +    Signed-off-by: Mark Brown <broonie@kernel.org>
     
      ## arch/arm64/include/asm/fpsimd.h ##
     @@ arch/arm64/include/asm/fpsimd.h: extern void fpsimd_signal_preserve_current_state(void);
    @@ arch/arm64/include/asm/fpsimd.h: extern void fpsimd_signal_preserve_current_stat
     +extern void fpsimd_kvm_prepare(void);
      
      extern void fpsimd_bind_state_to_cpu(struct user_fpsimd_state *state,
    - 				     void *sve_state, unsigned int sve_vl,
    + 				     void *sve_state, unsigned int sve_vl);
     
      ## arch/arm64/kernel/fpsimd.c ##
     @@ arch/arm64/kernel/fpsimd.c: void fpsimd_signal_preserve_current_state(void)
    @@ arch/arm64/kvm/fpsimd.c: int kvm_arch_vcpu_run_map_fp(struct kvm_vcpu *vcpu)
      	BUG_ON(!current->mm);
     -	BUG_ON(test_thread_flag(TIF_SVE));
      
    - 	if (!system_supports_fpsimd())
    - 		return;
    + 	vcpu->arch.flags &= ~KVM_ARM64_FP_ENABLED;
    + 	vcpu->arch.flags |= KVM_ARM64_FP_HOST;
      
     +	fpsimd_kvm_prepare();
     +
    - 	vcpu->arch.fp_state = FP_STATE_HOST_OWNED;
    - 
    - 	vcpu_clear_flag(vcpu, HOST_SVE_ENABLED);
    ++	vcpu->arch.flags &= ~KVM_ARM64_HOST_SVE_ENABLED;
    ++
    + 	if (read_sysreg(cpacr_el1) & CPACR_EL1_ZEN_EL0EN)
    + 		vcpu->arch.flags |= KVM_ARM64_HOST_SVE_ENABLED;
    + }
---

NOTE: These results are for this patch alone. Full series testing will be
performed when all parts are received.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

