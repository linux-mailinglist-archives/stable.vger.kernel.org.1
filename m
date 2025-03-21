Return-Path: <stable+bounces-125764-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0349BA6C171
	for <lists+stable@lfdr.de>; Fri, 21 Mar 2025 18:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 739AE1898DA1
	for <lists+stable@lfdr.de>; Fri, 21 Mar 2025 17:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEAF222D7B9;
	Fri, 21 Mar 2025 17:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OKwFgirw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F06F224B1C
	for <stable@vger.kernel.org>; Fri, 21 Mar 2025 17:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742577987; cv=none; b=QrCYKQWLS8VoubIpTn0aidMzO8phfejWZfimVMFEX/eioWwbcnJbYpP4NaZAA0Hc2i3bXigMZ7RpTjnCWS9v31alEDfgmkT9+zjZfbWEUgm+0PYTdkTJGttpY5+fgQCGjY21IgHclx/P87xhaQD7BtopC+//F+KQWIie9mMW+DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742577987; c=relaxed/simple;
	bh=Ka2Tef3c8f9lci9NLWgfN+wNOiezghC6/v9AaEn0yto=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b+qMjs79gU/VxQWyAlYkqzzML5Dz7G2ClwEDufRVmuTGB28PV2WDOAJuV2A0aN3rz5R7sqXMYz/0gNSI8ej9Sape7T0PwQA7SYx0Ze14NtQMcedxlF8q+DxK8bade7TFdiu75rKE/G89k+hOr0b+uyuX3OOswtJfBj3wsa0dm1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OKwFgirw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F735C4CEE3;
	Fri, 21 Mar 2025 17:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742577987;
	bh=Ka2Tef3c8f9lci9NLWgfN+wNOiezghC6/v9AaEn0yto=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OKwFgirwql6NFW46frsTjWXYnUi9xW2Cl8CoDgpJ8Iv3jpjKum5OWyv9K4tTNIdRc
	 MHsVv0dYjNhuN0LrXHeRf7ThMCGaD8DBzgkzRklFBgFuWrW+rQws3T0in3fZSWN2w9
	 dUcBCkUkjDkghdRpxKTKxO9sKmyF2EmbWYb6zNsS2XehKMj2Q8AdoYNNIdjKmZhDKV
	 5N2sYEEJE29wbQ7r5u727KlZYuQkkgRnIC/naA7tbo21J+4bEmBR7VfwxjYbwgUARW
	 zRaYEywlyfRv0vTKTidbCm0IRJNqWZISRlaS9ka0vJKxBGuqrMy8Vqpwr8qmNK2KRc
	 9lVIqrmdmBoww==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	broonie@kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12 v2 3/8] KVM: arm64: Remove host FPSIMD saving for non-protected KVM
Date: Fri, 21 Mar 2025 13:26:14 -0400
Message-Id: <20250321110532-03d8d336d445d068@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250321-stable-sve-6-12-v2-3-417ca2278d18@kernel.org>
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
ℹ️ This is part 3/8 of a series
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: 8eca7f6d5100b6997df4f532090bc3f7e0203bef

WARNING: Author mismatch between patch and found commit:
Backport author: Mark Brown<broonie@kernel.org>
Commit author: Mark Rutland<mark.rutland@arm.com>

Status in newer kernel trees:
6.13.y | Present (different SHA1: b52b812b3867)

Note: The patch differs from the upstream commit:
---
1:  8eca7f6d5100b ! 1:  af977c6789959 KVM: arm64: Remove host FPSIMD saving for non-protected KVM
    @@ Commit message
         Reviewed-by: Oliver Upton <oliver.upton@linux.dev>
         Link: https://lore.kernel.org/r/20250210195226.1215254-3-mark.rutland@arm.com
         Signed-off-by: Marc Zyngier <maz@kernel.org>
    +    Signed-off-by: Mark Brown <broonie@kernel.org>
     
      ## arch/arm64/include/asm/kvm_host.h ##
     @@ arch/arm64/include/asm/kvm_host.h: struct kvm_host_data {
    @@ arch/arm64/kvm/fpsimd.c: void kvm_arch_vcpu_load_fp(struct kvm_vcpu *vcpu)
     -	*host_data_ptr(fpsimd_state) = NULL;
     -	*host_data_ptr(fpmr_ptr) = NULL;
      
    - 	host_data_clear_flag(HOST_SVE_ENABLED);
    + 	vcpu_clear_flag(vcpu, HOST_SVE_ENABLED);
      	if (read_sysreg(cpacr_el1) & CPACR_EL1_ZEN_EL0EN)
     
      ## arch/arm64/kvm/hyp/include/hyp/switch.h ##
    @@ arch/arm64/kvm/hyp/include/hyp/switch.h: static inline void __hyp_sve_save_host(
     +
     +		/* Re-enable SVE traps if not supported for the guest vcpu. */
     +		if (!vcpu_has_sve(vcpu))
    -+			cpacr_clear_set(CPACR_EL1_ZEN, 0);
    ++			cpacr_clear_set(CPACR_ELx_ZEN, 0);
     +
     +	} else {
     +		__fpsimd_save_state(host_data_ptr(host_ctxt.fp_regs));
    @@ arch/arm64/kvm/hyp/nvhe/switch.c: static bool kvm_handle_pvm_sys64(struct kvm_vc
     -
     -		/* Re-enable SVE traps if not supported for the guest vcpu. */
     -		if (!vcpu_has_sve(vcpu))
    --			cpacr_clear_set(CPACR_EL1_ZEN, 0);
    +-			cpacr_clear_set(CPACR_ELx_ZEN, 0);
     -
     -	} else {
     -		__fpsimd_save_state(*host_data_ptr(fpsimd_state));
---

NOTE: These results are for this patch alone. Full series testing will be
performed when all parts are received.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.13.y       |  Success    |  Success   |

