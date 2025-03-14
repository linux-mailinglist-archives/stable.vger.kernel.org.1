Return-Path: <stable+bounces-124484-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3384FA6214B
	for <lists+stable@lfdr.de>; Sat, 15 Mar 2025 00:10:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7225D46275B
	for <lists+stable@lfdr.de>; Fri, 14 Mar 2025 23:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551AA1C6FE4;
	Fri, 14 Mar 2025 23:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NLB8A3mH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130AC1A23B7
	for <stable@vger.kernel.org>; Fri, 14 Mar 2025 23:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741993821; cv=none; b=I1FpXoIu4LZ3h+/WN9gPvcSn3E13kNV9DLydvVJwXLva8vwmtQL2wLMJMHEFBM49JMTqFjWK1rwMdXpqgmjLHMx6urwNGzy2PaC9x3A9ah5wOIqtHwI3PxDDzeRhwk4NAAiYyCOZa40O1CxBmknLvECJiY6/8AUf/aaYUCc+/ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741993821; c=relaxed/simple;
	bh=1sHKX7ojc1dEZCW1FuEuFvdFUsuSkrDfeoXCjVHWfUc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BXEUKeYQN4CNFQ7kZwhoTEB6txmYBvNKvsDj759UQEBD1fClRWPqYjnl28CezAPCqSMkURT5uM0GFEJafpEGCMWrlWp1KA6VYo9PzcRsbGEBWBsg37XVr5xONZMJm8R5AwqgejgkLyfHj3k7x7vTW/6ATQk+HKPRJSQryi0T4fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NLB8A3mH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E7A4C4CEE3;
	Fri, 14 Mar 2025 23:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741993820;
	bh=1sHKX7ojc1dEZCW1FuEuFvdFUsuSkrDfeoXCjVHWfUc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NLB8A3mHaU+CCjcMLdudigu88Eym+gZJz3PHWEXICG1dmfWNdg9vYoz4g6iuqnPp4
	 /JTBmzcgdJGO20t2uHORlE2DcVoYFMYd/mfZOTe2YbARk+74LDahZJ1rtjxowbktHR
	 tzYHH0iFIP74meLOZRK39miHBuikVfmFS1kvhlmXhzlI7CcGd8v58grpN6far4rTQB
	 dgv7111Nu0ZHqEzFKs0LXLTFFPbpl+kxt3r6MmlpZrnNVD1WRnRL2fMTj30d/jIWWK
	 VOpcUaWY/w+H3B0DN16MvsmDOvF4wC1pDNu6qR7sXso9ZJJP7L7+UVOZHZsYm8BVTM
	 eywYfAFINQiYw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12 5/8] KVM: arm64: Remove VHE host restore of CPACR_EL1.SMEN
Date: Fri, 14 Mar 2025 19:10:19 -0400
Message-Id: <20250314085228-72d017a5d547b4d1@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250314-stable-sve-6-12-v1-5-ddc16609d9ba@kernel.org>
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

Status in newer kernel trees:
6.13.y | Present (different SHA1: 3c89e0ed8687)

Note: The patch differs from the upstream commit:
---
1:  407a99c4654e8 ! 1:  3c3460dc973ae KVM: arm64: Remove VHE host restore of CPACR_EL1.SMEN
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
| stable/linux-6.12.y       |  Success    |  Success   |

