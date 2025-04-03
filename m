Return-Path: <stable+bounces-127685-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D46A7A713
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 17:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2894D3A3201
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 15:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31ED524CEE8;
	Thu,  3 Apr 2025 15:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TEhyVFEq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36FB223708
	for <stable@vger.kernel.org>; Thu,  3 Apr 2025 15:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743694727; cv=none; b=HqlC4FWHVEMXObjODJlZ8sgIwCI8LPQfByfFFjhRf3qmmOy2CGs02j4BDwd2a4x9Vhljso+ll7GDdCqfEUU+N8IuZnXc32l6ACnBVSW66tohlgd/5Cn/dkQ5yCtp4K8pCVhGwUFbgUpbDCs2VKwLtll8lzYEvv3Tvc7IuC9iREA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743694727; c=relaxed/simple;
	bh=54R6CMY7Unqjpi3d/YE2eshKdeXITHSKcb8UOBhq18I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LkAJeuyO854wiRfqR5S73cAwgq0403N5rX5f0biNpsb040g/SPg9j9U0o2OG7c+0ywEOdaAEGL97A4lytPu1g7D57215BsR1VHuYPudZYhDR9HXmwJydxK3HC0VyQODAlkv4HC4izd+7n9OkdMHa0LUDnuDY5xc6c1la07GVEPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TEhyVFEq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5817C4CEE3;
	Thu,  3 Apr 2025 15:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743694726;
	bh=54R6CMY7Unqjpi3d/YE2eshKdeXITHSKcb8UOBhq18I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TEhyVFEqzibqUcbbBOiQNaTPbzyqOMFHxDR7V5b6TNvK8a9OXiTcDz2xEJZyZT8Ik
	 rH2sibZNhtqgFtsuMVxv6FROCbi+T/2VMXysQNBJjMGQMdsX5oJzZ8+0ju1DCiQONo
	 S3xDeYkwQbedBOenpBh30ch4hZEMiEby057PKyvUdQvivTEnrgX+uRtFZVCPp29x2+
	 UgpQn8tjvhrM6IzgC2hmzkRPPvGLF724wzPF16yZi17r4BguxIXk7GSiTU7zGS9KU/
	 eMc9e2av1kEg9L2Hyex+XepC4bR9C5MFIweFqIgBgWfCKk/eQ4v3F3FUdCgQ6dNkEU
	 /N8zqoRAUJJIQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15 v2 05/10] arm64/fpsimd: Stop using TIF_SVE to manage register saving in KVM
Date: Thu,  3 Apr 2025 11:38:42 -0400
Message-Id: <20250403104636-f1bea3e319b763af@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250403-stable-sve-5-15-v2-5-30a36a78a20a@kernel.org>
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

The upstream commit SHA1 provided is correct: 62021cc36add7b2c015b837f7893f2fb4b8c2586

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  62021cc36add7 ! 1:  45bec98f19f58 arm64/fpsimd: Stop using TIF_SVE to manage register saving in KVM
    @@ Metadata
      ## Commit message ##
         arm64/fpsimd: Stop using TIF_SVE to manage register saving in KVM
     
    +    [ Upstream commit 62021cc36add7b2c015b837f7893f2fb4b8c2586 ]
    +
         Now that we are explicitly telling the host FP code which register state
         it needs to save we can remove the manipulation of TIF_SVE from the KVM
         code, simplifying it and allowing us to optimise our handling of normal
    @@ Commit message
         Reviewed-by: Marc Zyngier <maz@kernel.org>
         Link: https://lore.kernel.org/r/20221115094640.112848-5-broonie@kernel.org
         Signed-off-by: Will Deacon <will@kernel.org>
    +    [ Mark: trivial backport ]
    +    Signed-off-by: Mark Rutland <mark.rutland@arm.com>
    +    Signed-off-by: Mark Brown <broonie@kernel.org>
     
      ## arch/arm64/kernel/fpsimd.c ##
     @@ arch/arm64/kernel/fpsimd.c: static void task_fpsimd_load(void)
    -  * last, if KVM is involved this may be the guest VM context rather
    -  * than the host thread for the VM pointed to by current. This means
    -  * that we must always reference the state storage via last rather
    -- * than via current, other than the TIF_ flags which KVM will
    -- * carefully maintain for us.
    + 
    + /*
    +  * Ensure FPSIMD/SVE storage in memory for the loaded context is up to
    +- * date with respect to the CPU registers.
    ++ * date with respect to the CPU registers. Note carefully that the
    ++ * current context is the context last bound to the CPU stored in
    ++ * last, if KVM is involved this may be the guest VM context rather
    ++ * than the host thread for the VM pointed to by current. This means
    ++ * that we must always reference the state storage via last rather
     + * than via current, if we are saving KVM state then it will have
     + * ensured that the type of registers to save is set in last->to_save.
       */
    @@ arch/arm64/kernel/fpsimd.c: static void fpsimd_save(void)
      	if (test_thread_flag(TIF_FOREIGN_FPSTATE))
      		return;
      
    --	if (test_thread_flag(TIF_SVE)) {
    +-	if (IS_ENABLED(CONFIG_ARM64_SVE) &&
    +-	    test_thread_flag(TIF_SVE)) {
    +-		if (WARN_ON(sve_get_vl() != last->sve_vl)) {
     +	if ((last->to_save == FP_STATE_CURRENT && test_thread_flag(TIF_SVE)) ||
     +	    last->to_save == FP_STATE_SVE) {
    - 		save_sve_regs = true;
    - 		save_ffr = true;
    - 		vl = last->sve_vl;
    ++		save_sve_regs = true;
    ++		vl = last->sve_vl;
    ++	}
    ++
    ++	if (IS_ENABLED(CONFIG_ARM64_SVE) && save_sve_regs) {
    ++		/* Get the configured VL from RDVL, will account for SM */
    ++		if (WARN_ON(sve_get_vl() != vl)) {
    + 			/*
    + 			 * Can't save the user regs, so current would
    + 			 * re-enter user with corrupt state.
    +@@ arch/arm64/kernel/fpsimd.c: static void fpsimd_save(void)
    + 		}
      	}
      
    +-	if (test_thread_flag(TIF_SVE)) {
    +-		save_sve_regs = true;
    +-		vl = last->sve_vl;
    +-	}
    +-
     -	/*
     -	 * Validate that an explicitly specified state to save is
     -	 * consistent with the task state.
    @@ arch/arm64/kernel/fpsimd.c: static void fpsimd_save(void)
     -		break;
     -	}
     -
    - 	if (system_supports_sme()) {
    - 		u64 *svcr = last->svcr;
    - 
    + 	if (IS_ENABLED(CONFIG_ARM64_SVE) && save_sve_regs) {
    + 		sve_save_state((char *)last->sve_state +
    + 			       sve_ffr_offset(last->sve_vl),
     
      ## arch/arm64/kvm/fpsimd.c ##
     @@ arch/arm64/kvm/fpsimd.c: void kvm_arch_vcpu_ctxsync_fp(struct kvm_vcpu *vcpu)
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

