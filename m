Return-Path: <stable+bounces-132142-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9ADAA848EA
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 17:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 752521B603FC
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 15:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F59B1EB9E8;
	Thu, 10 Apr 2025 15:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LOpEsn13"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601B11E9B38
	for <stable@vger.kernel.org>; Thu, 10 Apr 2025 15:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744300415; cv=none; b=B4mSnRtlghyFXQzgmDrQuG56qg+D3kujBDTsfdlyzPBm8GlNoi7gNbp16oCBsDsBfzfVCtDb6U/92Lh9xMvy8wzER4BzbevbF2oXXuSWCgm9bsv41ASsAbnEs34ViNRD/ShKNreM8sQS9pbiyODg7iJN4jqdEeG6VDUAShhGmTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744300415; c=relaxed/simple;
	bh=lRMqFF8inLhkctx9sAjt4aiwRsYeKLWnIeO+H+OTpWI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bRMavUc17EseWwsVWw3f7dvoAUfJAVp4pgli1+o6PbNdMHGiq1G6w+JR9KSmYK9/wZ3cLt5l+mGeF0AMDU0aIYznBzES77Jvj3h8bmvdw8nMkAAkLZqCjE/CFZPkCiR8Berjn438cKreEO0kr5KRRpL8mzv2sHOs2adgo3mgemI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LOpEsn13; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 435A7C4CEDD;
	Thu, 10 Apr 2025 15:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744300414;
	bh=lRMqFF8inLhkctx9sAjt4aiwRsYeKLWnIeO+H+OTpWI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LOpEsn13SCIh4enNZUGEARrjCQJn/xKiTR5UpPYJb22/YP+4aA2E7R9atCI7yhJ7X
	 k38k5k6XGeqF+djSSVWFPQzJYcYPnG7XRPypqakGc6dQxzAyvN4h26Z6vfkdFypbBV
	 f0Q3PyPlI5KBFCI352y6W6OY3dzigbN5pfucvkw+7NY782XWL+F4C02s+6ASKNiTsq
	 2Ghv/HR7nwzSuln3id/rQvAyhH0ueuCHqYkRL0kv3aXcY3AAJeoKdEn8cqGKRl+6Zu
	 T+iyTGsSmQ8LfbesG29pUdr1TqYh+5ZyMYmWupLJRjUPPyzE+y1qHJiq375OqXZX9j
	 urNUHGXS1sIRg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	broonie@kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15 v3 02/11] KVM: arm64: Always start with clearing SVE flag on load
Date: Thu, 10 Apr 2025 11:53:32 -0400
Message-Id: <20250410112437-6c51badd1fa7bb35@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250408-stable-sve-5-15-v3-2-ca9a6b850f55@kernel.org>
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
ℹ️ This is part 02/11 of a series
❌ Build failures detected

The upstream commit SHA1 provided is correct: d52d165d67c5aa26c8c89909003c94a66492d23d

WARNING: Author mismatch between patch and upstream commit:
Backport author: Mark Brown<broonie@kernel.org>
Commit author: Marc Zyngier<maz@kernel.org>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  d52d165d67c5a ! 1:  ab39b2accf324 KVM: arm64: Always start with clearing SVE flag on load
    @@ Metadata
      ## Commit message ##
         KVM: arm64: Always start with clearing SVE flag on load
     
    +    [ Upstream commit d52d165d67c5aa26c8c89909003c94a66492d23d ]
    +
         On each vcpu load, we set the KVM_ARM64_HOST_SVE_ENABLED
         flag if SVE is enabled for EL0 on the host. This is used to restore
         the correct state on vpcu put.
    @@ Commit message
         Cc: stable@vger.kernel.org
         Reviewed-by: Mark Brown <broonie@kernel.org>
         Link: https://lore.kernel.org/r/20220528113829.1043361-2-maz@kernel.org
    +    Signed-off-by: Mark Brown <broonie@kernel.org>
     
      ## arch/arm64/kvm/fpsimd.c ##
     @@ arch/arm64/kvm/fpsimd.c: void kvm_arch_vcpu_load_fp(struct kvm_vcpu *vcpu)
    @@ arch/arm64/kvm/fpsimd.c: void kvm_arch_vcpu_load_fp(struct kvm_vcpu *vcpu)
     +	vcpu->arch.flags &= ~KVM_ARM64_HOST_SVE_ENABLED;
      	if (read_sysreg(cpacr_el1) & CPACR_EL1_ZEN_EL0EN)
      		vcpu->arch.flags |= KVM_ARM64_HOST_SVE_ENABLED;
    - 
    + }
---

NOTE: These results are for this patch alone. Full series testing will be
performed when all parts are received.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Failed    |

Build Errors:
Build error:
    Segmentation fault
    make: *** [Makefile:1231: vmlinux] Error 139
    make: Target '__all' not remade because of errors.

