Return-Path: <stable+bounces-99974-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B215A9E76CB
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 18:11:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 708AE1884F50
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 17:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D4A1F4E36;
	Fri,  6 Dec 2024 17:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PleZ+c4r"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B660D206274
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 17:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733505112; cv=none; b=c884jm82mr2z9+/O1+laKwq0vzVbBvW/XstRQBh3GHEWRB+SJil6kFdJyUFRinrToakffp2uGjVclOMDFjjBjcfzyvoitWykjjt9VJbFi/FIx/5CGF3jLcwgmlOctnPYpYmTpz1USi2Vnng7KlUvq889u2v43j+GhrbLCuPauz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733505112; c=relaxed/simple;
	bh=iqC3QCQuaJWpbiJnKX/uLEkfnk8dg4Ib3RDnce5CSRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ep3u8CqCXuWkUxK62o1+4wncrMjIjUc1rK7Q3n4hC5fLlcHJqqTGFNrRsc83zvDCWpQ+W0l+5cCUfyUo3/4V1QJo8ml+h0EtwZoh3wkEI9HYJsRNBlTQKXlO3ovE3Krk/v6B/ZsNhFPMR/hCRDjLdrW4rShWhHbUxJZY2GT8Phg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PleZ+c4r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C026C4CED1;
	Fri,  6 Dec 2024 17:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733505112;
	bh=iqC3QCQuaJWpbiJnKX/uLEkfnk8dg4Ib3RDnce5CSRA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PleZ+c4rU0kS/Rq2C4Wta7bAH1QQ8uw3jBOEvyfQ7Fje7RpFKwaoz9gXP3JAZ3vWR
	 64vYVlgvx/3x7T2WJELQkzNQZgxHsRvwifsknw9WAH1X2qK+u3GbyBzPQETvcX367K
	 gJcwdrayLfG7ine46GcORXEdQjbmTH5AbYZIt+rLj/dZS3ATFWyvup3GG+iOfU/Uvc
	 50Ipt7F2vnfc0Y14mJyJjSqCWchvrN0Posdg5KwMpaSPNwbOp6q78HMd8ekgH8hqky
	 5OyWoHOdR3egBKWjb7WQn2sJuKz/XeaS2cHTTGA/uLEl0lZbRQBsdXkDNaH5ZEi8+a
	 Ek43GlPbRKbxw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] drm/amd/display: fix NULL checks for adev->dm.dc in amdgpu_dm_fini()
Date: Fri,  6 Dec 2024 12:11:50 -0500
Message-ID: <20241206100537-ace2621a88a460fa@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241206033119.3139154-1-jianqi.ren.cn@windriver.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: 2a3cfb9a24a28da9cc13d2c525a76548865e182c

WARNING: Author mismatch between patch and upstream commit:
Backport author: <jianqi.ren.cn@windriver.com>
Commit author: Nikita Zhandarovich <n.zhandarovich@fintech.ru>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: e040f1fbe9ab)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  2a3cfb9a24a28 ! 1:  da3cc3fa89a29 drm/amd/display: fix NULL checks for adev->dm.dc in amdgpu_dm_fini()
    @@ Metadata
      ## Commit message ##
         drm/amd/display: fix NULL checks for adev->dm.dc in amdgpu_dm_fini()
     
    +    [ Upstream commit 2a3cfb9a24a28da9cc13d2c525a76548865e182c ]
    +
         Since 'adev->dm.dc' in amdgpu_dm_fini() might turn out to be NULL
         before the call to dc_enable_dmub_notifications(), check
         beforehand to ensure there will not be a possible NULL-ptr-deref
    @@ Commit message
         Fixes: 81927e2808be ("drm/amd/display: Support for DMUB AUX")
         Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
         Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
    +    Signed-off-by: Jianqi Ren <jianqi.ren.cn@windriver.com>
     
      ## drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c ##
     @@ drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c: static void amdgpu_dm_fini(struct amdgpu_device *adev)
    - 		adev->dm.hdcp_workqueue = NULL;
    - 	}
    + 		dc_deinit_callbacks(adev->dm.dc);
    + #endif
      
     -	if (adev->dm.dc)
     +	if (adev->dm.dc) {
    - 		dc_deinit_callbacks(adev->dm.dc);
    --
    --	if (adev->dm.dc)
      		dc_dmub_srv_destroy(&adev->dm.dc->ctx->dmub_srv);
     -
     -	if (dc_enable_dmub_notifications(adev->dm.dc)) {
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

