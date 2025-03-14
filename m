Return-Path: <stable+bounces-124495-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA01A62159
	for <lists+stable@lfdr.de>; Sat, 15 Mar 2025 00:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B85AF88353C
	for <lists+stable@lfdr.de>; Fri, 14 Mar 2025 23:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93FBE1A23B7;
	Fri, 14 Mar 2025 23:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CfSbgoFu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552DF1F92E
	for <stable@vger.kernel.org>; Fri, 14 Mar 2025 23:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741993871; cv=none; b=TPrWgsIMLKNynMjFKeIXDV9LR1mKT7/d/4yH1gFmlZws7Yv9Q4UYGGhFjH/IdpPBabLPNWuafkvHe+eSesVPZz9AuRUa6M5Gso9UpDnJb8QMKHYLggPbbdEEWcrEkJk+lRiDj9hwE2SBO9ePkrLFHk5ZxKOui+hGow2gCOls+8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741993871; c=relaxed/simple;
	bh=hERtVaHaCG2RMhpUtBqrLvHIn7iSzxot7CJN0Sl0iQs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HF2D5ZggAGqLUBZRkxkrCXfuIu2zxX6vTSrVL+IrFS8DaTX+Bd5rlrCf3f3nTcDiIV5P0QYTe+mRnUb8WDOUhdwpwpV2ooNwBVgCGnNR2bLMpgCK6SzHpMKjmm/nEWQUH9CFaDq8F+nlxMPvi4UuYHTlrJKxX2SlcUzPXt5hlak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CfSbgoFu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9F01C4CEE3;
	Fri, 14 Mar 2025 23:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741993871;
	bh=hERtVaHaCG2RMhpUtBqrLvHIn7iSzxot7CJN0Sl0iQs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CfSbgoFuqk0rMS6hmla+j91NVMCvG+zpUlu/xRSUcPuHkH5x5edvTD4xwMZfo3WH8
	 aIXR3yihMTuc+qZpCqIxxJb8AAyYxM9pZG9a97EfpuwbLDu3bocbLzLXL64Wax1ZKt
	 UYNMWb47IgNNsBZjSrs7cPpB1etofBAxhyL+s5HdvwjwULDnFVPzP6h7MZLcvRDxD6
	 Ru6EhkDdDnkjNgbTJuPBGFtfDbeJhiDkdhdiW2leh6AMXWSjf0hUkLqPuAQiTF1Vqm
	 YJEixy+iw07+XCWHBmrtrmnZegRVok5/t3joRhAgW/tBQB6g4jbwPcxchCI4Mh2avm
	 DzXYTtlf2NpWQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	broonie@kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12 3/8] KVM: arm64: Remove host FPSIMD saving for non-protected KVM
Date: Fri, 14 Mar 2025 19:11:09 -0400
Message-Id: <20250314084725-0c105bceb70fd6d3@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250314-stable-sve-6-12-v1-3-ddc16609d9ba@kernel.org>
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
6.13.y | Present (different SHA1: 2d6142ad07ee)

Note: The patch differs from the upstream commit:
---
1:  8eca7f6d5100b ! 1:  ae25b9d3534b3 KVM: arm64: Remove host FPSIMD saving for non-protected KVM
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
| stable/linux-6.12.y       |  Success    |  Success   |

