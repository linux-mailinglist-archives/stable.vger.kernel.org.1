Return-Path: <stable+bounces-125770-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC88BA6C176
	for <lists+stable@lfdr.de>; Fri, 21 Mar 2025 18:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5DB63B20E3
	for <lists+stable@lfdr.de>; Fri, 21 Mar 2025 17:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDBC822D7B2;
	Fri, 21 Mar 2025 17:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mN7/IVsh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E205224B1C
	for <stable@vger.kernel.org>; Fri, 21 Mar 2025 17:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742578061; cv=none; b=TB8ZxxgSXsWks34s2LBRj9hTS3jgLWbGmc29q9dQ98FEUM4/ICHSSeurgmZWpXSLWJgn1Dcheihvcua9VLE/GGNQu1n+Mxa9nCLPaC3+a1jwBujsnmfe28pMpSpIK2Gcwx+EiJhc7gqDV5Ml5a6eSVPxo3KQd4UdsLlHX12piLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742578061; c=relaxed/simple;
	bh=RNsLT3GgZrR5A1lkMlRyQj5Ve9NlkA3iSrXm+d8yhZc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RvfxA7q8jwKmAhBWtKpi0eR5Zw1rowD05QpglOMJZQg9kz5liDZVxQc1WbMb1xnPagKtSS7GRZ82X5hmur9WzepT03nbOToptRKeod2F3PJG++Wa25GUt0stdiuDzAD0m8xIEJ5sJVKAMit2L/iNtaoqdmcEFaitKyD4p7LVPlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mN7/IVsh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2BD5C4CEEA;
	Fri, 21 Mar 2025 17:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742578061;
	bh=RNsLT3GgZrR5A1lkMlRyQj5Ve9NlkA3iSrXm+d8yhZc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mN7/IVsh1Kz8r8Pt2dNGeQPEDvZXhM0962Mp6pWD7kfpIDbIQ5oBCZGW+WPHRe83Y
	 0qMCSno/9qus+sXr/tHeA4arSsYQB/rMS/We1Knoj01wbdu66r1Hm4YqDMCoFvZXVF
	 5sYI4jiAXUqUO9StCdwnNfT63Pw0V4TxaNGYLizX/RYca5JlUHN+5JlocYINvNXrOe
	 cwGdhBJ6rN0OSz2DCSKAVIS+h8IQQxOdsZUMDjYzbxYulE7NOr81PfhWo1NPNcpSAH
	 0lBZO3BoIx0P1gLTTZh+2alVyHryuo5O9oPygf3mapJDRQi9PyBC+LdBsKLsFXHXcN
	 Pbi7u0ROyx/CQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12 v2 2/8] KVM: arm64: Unconditionally save+flush host FPSIMD/SVE/SME state
Date: Fri, 21 Mar 2025 13:27:29 -0400
Message-Id: <20250321110010-8daf998f41186e56@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250321-stable-sve-6-12-v2-2-417ca2278d18@kernel.org>
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

Note: The patch differs from the upstream commit:
---
1:  fbc7e61195e23 ! 1:  97c6fe39fcf56 KVM: arm64: Unconditionally save+flush host FPSIMD/SVE/SME state
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

