Return-Path: <stable+bounces-126024-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6BE6A6F426
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 12:34:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CC67188640F
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 11:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F212255E51;
	Tue, 25 Mar 2025 11:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jg6w2TuX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8AABA36
	for <stable@vger.kernel.org>; Tue, 25 Mar 2025 11:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742902429; cv=none; b=Ew6BGxRANdiQAO8EpE9T37gAeeCopte1LaHZr6y7A0igUxAayf4dhdyuHGRvInwM8FQ/b0d6+heLAmkw8fVfS9xDckf1L9PR4akFHfb5tWNBDUxzgAjHe0a428JHRdsI35ZbclWckqJ8hYgatDJf1DDsJ0bVYVFCEbMxKZmtpTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742902429; c=relaxed/simple;
	bh=0rrqszwN3gK/zQw5ehiXPcCG2Z9xrvPgIAsuC4cjM+Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CCPaA35I1foXkigd//T9gM8lwtm4rzdjGXttdRm73bt4adiHKmIjThYFI8404+TtASohKOkMQSs9dYIe8CRzM3TmGV0+rIKwAFkOIZr2E+eUnJ/oBIhjw1KDAzYxlKG5DPm3Ml2yP5BSqGWdV+ZMKqWIcAWW6PSzwl24EbXD3Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jg6w2TuX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70F4DC4CEE4;
	Tue, 25 Mar 2025 11:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742902428;
	bh=0rrqszwN3gK/zQw5ehiXPcCG2Z9xrvPgIAsuC4cjM+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jg6w2TuXw0f4azsU0t3Tqha0zuH8iQp9wziyouWT9lywy+vBckqd1AlSsp33pQNG9
	 3xkdBqgCaKTJfGE+g15p1XKSJQML/f+B6c04MfaV3ycQVR3BZBs5oacnXnAnUIA6NO
	 kPXEUz9fv3fo2GYjaLpFn+nVRwsEFLqo7KRZOUXlxPxMosEcDuSXK+0oXhaYlIRKC2
	 kz3Jhf3ZLnXRgch3stEabn8vthSnFZrDQPmpjl2rlnyw2Qo1CIJgCAuOCfJ/hDM1r7
	 +TscRi7jgZbLp7pf3eBL3oVjcuAMOGJx/Dbq4tIPQ2sMofzaS8zApWTZDEuDDWhknJ
	 Ag9oEBckH/LIg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: bin.lan.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] drm/amdgpu: fix use-after-free bug
Date: Tue, 25 Mar 2025 07:33:47 -0400
Message-Id: <20250324213830-1c1fdba41792047b@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250324072712.761233-1-bin.lan.cn@windriver.com>
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

The upstream commit SHA1 provided is correct: 22207fd5c80177b860279653d017474b2812af5e

WARNING: Author mismatch between patch and upstream commit:
Backport author: bin.lan.cn@windriver.com
Commit author: Vitaly Prosyak<vitaly.prosyak@amd.com>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: e87e08c94c95)

Note: The patch differs from the upstream commit:
---
1:  22207fd5c8017 ! 1:  e10d8c3a85ee4 drm/amdgpu: fix use-after-free bug
    @@ Metadata
      ## Commit message ##
         drm/amdgpu: fix use-after-free bug
     
    +    [ Upstream commit 22207fd5c80177b860279653d017474b2812af5e ]
    +
         The bug can be triggered by sending a single amdgpu_gem_userptr_ioctl
         to the AMDGPU DRM driver on any ASICs with an invalid address and size.
         The bug was reported by Joonkyo Jung <joonkyoj@yonsei.ac.kr>.
    @@ Commit message
         Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
         Reviewed-by: Christian König <christian.koenig@amd.com>
         Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
    +    [ drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c is renamed from
    +      drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c since
    +      d9483ecd327b ("drm/amdgpu: rename the files for HMM handling").
    +      The path is changed accordingly to apply the patch on 6.1.y. ]
    +    Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
    +    Signed-off-by: He Zhe <zhe.he@windriver.com>
     
    - ## drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c ##
    -@@ drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c: static const struct mmu_interval_notifier_ops amdgpu_hmm_hsa_ops = {
    + ## drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c ##
    +@@ drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c: static const struct mmu_interval_notifier_ops amdgpu_mn_hsa_ops = {
       */
    - int amdgpu_hmm_register(struct amdgpu_bo *bo, unsigned long addr)
    + int amdgpu_mn_register(struct amdgpu_bo *bo, unsigned long addr)
      {
     +	int r;
     +
    @@ drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c: static const struct mmu_interval_notifi
     -		return mmu_interval_notifier_insert(&bo->notifier, current->mm,
     +		r = mmu_interval_notifier_insert(&bo->notifier, current->mm,
      						    addr, amdgpu_bo_size(bo),
    - 						    &amdgpu_hmm_hsa_ops);
    + 						    &amdgpu_mn_hsa_ops);
     -	return mmu_interval_notifier_insert(&bo->notifier, current->mm, addr,
     -					    amdgpu_bo_size(bo),
    --					    &amdgpu_hmm_gfx_ops);
    +-					    &amdgpu_mn_gfx_ops);
     +	else
     +		r = mmu_interval_notifier_insert(&bo->notifier, current->mm, addr,
     +							amdgpu_bo_size(bo),
    -+							&amdgpu_hmm_gfx_ops);
    ++							&amdgpu_mn_gfx_ops);
     +	if (r)
     +		/*
     +		 * Make sure amdgpu_hmm_unregister() doesn't call
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

