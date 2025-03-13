Return-Path: <stable+bounces-124297-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B8FA5F493
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 13:33:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9BDD3BDD05
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 12:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB547266EFE;
	Thu, 13 Mar 2025 12:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fOILSdsR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94A01DFED
	for <stable@vger.kernel.org>; Thu, 13 Mar 2025 12:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741869104; cv=none; b=LHO8PrSRsu7Pe5tojB9ShYVpedcjmkLXwVYLmDG9A+yPcCmYAqpfj5xiuUrZo13w0mrqsh/OH/nV1zc+zX8VOeghN+ngdjHd4UWE4bL5q4RKp0GAjVURKpAz7ghXdXazpd5i8w2MvOH0fKc9sKQOleWr2m8leJMsDci9mYJX84g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741869104; c=relaxed/simple;
	bh=uF1U6cx4cZNFjhWe0IQS0FNVEovFgWaChfAPS7eNUWA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=khuS0yxQ3Qqav0I4cXPLdLkhdm3b2LoivN/cSQckILSn93UbXMKube64BoliTOG1tVkY5J9bGRTb/ZqGZCDv7lExRkztSfInBhjpTVe2C3pyZxXYgCVmcT4w3QXhY4xnqLBU/YuaYrxJrFBMrTKX1IRtSBzUAAqBAJ2z5QjfKgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fOILSdsR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2E6DC4CEE5;
	Thu, 13 Mar 2025 12:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741869103;
	bh=uF1U6cx4cZNFjhWe0IQS0FNVEovFgWaChfAPS7eNUWA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fOILSdsRTormAdpq8LBXdWhBfZW07JUgnPfTXn6Y9HzUHt2NlkYeVmzzA4xtaWICO
	 VNyxwxfjw8AnkzQD5k5S9g/nlccsu8iGimpvJxq5J+CqrbcYSE4pPnMfR76L4nxAj3
	 5xiR29QsbgXVHkA3Q1eHOkslbjIRixcIgf12axa0deMoKwnL8HXQQusAWBREcQMdG9
	 s9u9SDJx9Su5f5XC3IXxi2z34+uLgGTNp9/ku9RRSx1O/eCqB7nQliGRsVzL2gHq6F
	 3Lqb4eBVbhTov1a/X7X65jdvZL9bUTDCw95A4+s2K4N209Ow7tlRm4PS3XLGjUNk8p
	 0Plldz/cXrMug==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.13 2/8] KVM: arm64: Unconditionally save+flush host FPSIMD/SVE/SME state
Date: Thu, 13 Mar 2025 08:31:41 -0400
Message-Id: <20250313054518-33853f58057cc3c5@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250312-stable-sve-6-13-v1-2-c7ba07a6f4f7@kernel.org>
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

Note: The patch differs from the upstream commit:
---
1:  fbc7e61195e23 ! 1:  e5f1987c70b10 KVM: arm64: Unconditionally save+flush host FPSIMD/SVE/SME state
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
     +	*host_data_ptr(fpsimd_state) = NULL;
     +	*host_data_ptr(fpmr_ptr) = NULL;
      
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
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.13.y       |  Success    |  Success   |

