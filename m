Return-Path: <stable+bounces-125768-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D46A6C16E
	for <lists+stable@lfdr.de>; Fri, 21 Mar 2025 18:27:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA58A3B27EA
	for <lists+stable@lfdr.de>; Fri, 21 Mar 2025 17:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33B922D7B2;
	Fri, 21 Mar 2025 17:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aSXwa702"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947991DEFFC
	for <stable@vger.kernel.org>; Fri, 21 Mar 2025 17:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742578036; cv=none; b=PVGq7Cc8CTC5MpBRKCUVAAxZ5NbkCDGI99CB1a+Ka82yblERKBeW32MqTAhC4MA9VUvJ+1WCyTxYPVYCzYZBFxIjH/K/oCXq82r4HKgK38dYp8pMNZz3CKnC7D3NdQr1LJwF5ssIRd0eZNK6VTBJPkXBzsQz9yxBjVo/zYaCw0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742578036; c=relaxed/simple;
	bh=8Tpi+DRwKds4Fw4EI3ZEpNEw6Sv+5nCMA0bNZNtXt38=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bagIQtw7Nrm+Pme7KRjVv8rLxSHQ8hITDAya3to2Zky/BN5gDX8IAmS/+nzAhAv+WtODBHK838SlZJlesLf4tnD5JmDSV7Zo2u4cHAIRFIGXH1JGghilIYiHMfJD1XY2oEDBsRR5cJk4DV0WDP+iZ3ecpUPHFKJG4QT7JEXtSH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aSXwa702; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03693C4CEE3;
	Fri, 21 Mar 2025 17:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742578036;
	bh=8Tpi+DRwKds4Fw4EI3ZEpNEw6Sv+5nCMA0bNZNtXt38=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aSXwa702ishMWgk61U9K7GczK9UTj7YlEbmRp4gcSCu3JkKtza7+FSUgc69H9cNS5
	 plXmnPImFRf+EaCBwtPcpvq5LVimzdwUQD2jmxqNCScisoH+RHD8JKexBQfVNLqC6R
	 mqV1wNboCKpMshfcEU+zjc/90HM+OoZUjx/ey973nuFCWyz29b2cP6ZVMtHq4TPHL6
	 G6BtCB1pyckmRMznQR2OKDUqxh2Jq656A3pKdd00GfUAfP5xwP27Db9XFn9RMTIT6V
	 AneIY2u3FIG4KNBQ/H9Ar3i6FxRLqu5O3gXl6gzlqx7H7SC66rtrWtHo4nHB835D1v
	 JKlUYO8LdWtzQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6 7/8] KVM: arm64: Mark some header functions as inline
Date: Fri, 21 Mar 2025 13:27:04 -0400
Message-Id: <20250321123044-15c5536f8478b50d@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250321-stable-sve-6-6-v1-7-0b3a6a14ea53@kernel.org>
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
6.13.y | Present (different SHA1: 315c35c0aeff)
6.12.y | Present (different SHA1: bb7146694891)

Note: The patch differs from the upstream commit:
---
1:  f9dd00de1e53a ! 1:  57de9b6af7aaf KVM: arm64: Mark some header functions as inline
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
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

