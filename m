Return-Path: <stable+bounces-100671-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 209E59ED1F9
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 17:33:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBD2D188401B
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 16:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6E11D619D;
	Wed, 11 Dec 2024 16:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H+dd2xlp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F97538DE9
	for <stable@vger.kernel.org>; Wed, 11 Dec 2024 16:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733934795; cv=none; b=S72qdB4KvapH0syICxyCijRPHYGNm0Tzo4lelU24WEjW3a6pJNrpj3byF7dYF2B4r0PrYMBzqd2D+cKMHmm5ynvIIK+PhEtWzUce6tPlf5aHJ8grCkmf6+Jps5T/Trytud3y9U/sqvFz2loaOJVxW2CDoCBtVTvroiC8Z0r8n4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733934795; c=relaxed/simple;
	bh=8UJ/r1OdoHWMIvBuvxwQ81Fn0VLo0iDV2GbVFG0Beto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=semIR3hIEY60XM5bFmE3gkR5e5/7VdTNGQ8IRQVvZaoRkoWVZIkRMmLudwSitfg03Vp89IObI8GhmF1kWF0mwJnCwKhcwiHrC0eJ+nsNvZ3ooWhyujRyDzNMlTbjX3rq25BXKKK5YPqsvoonTO3hMTprlOwqzLS+gGjOZmLfrWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H+dd2xlp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34D31C4CEED;
	Wed, 11 Dec 2024 16:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733934793;
	bh=8UJ/r1OdoHWMIvBuvxwQ81Fn0VLo0iDV2GbVFG0Beto=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H+dd2xlpR9tqo+jaOgxaECgxP7QtdtiQq+IKCYSJkdn62lf25I6twDnkLgjEwbw5A
	 nltOqFrLW5Lj19/HWW+ef+Yb7jgb/Yh+RZG98QQ8EESVmDgkw1Y+yHwVb3lO5KrHwo
	 O7tSUk+2+H8g2hNy5IGUweK4FZ9on3GCmc1ULSaKNq/lAWCoVWCWQR359cIrz4d9MS
	 O6F1Is2FqowsCJ05Ur0ohUMscB18q7/ntd3wOSR5p0xN1i3KEqXY4rOnAVnFnUmGle
	 dDI9rARfvvneh2mG05PX8p4SMMhL3bzGhw7Ka01Ej1RsPUkUBFV6laVKmh1+jSx1vV
	 tblkUZbhOYZmQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] drm/amd/display: fix NULL checks for adev->dm.dc in amdgpu_dm_fini()
Date: Wed, 11 Dec 2024 11:33:11 -0500
Message-ID: <20241211111823-2c021c939f4457c9@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241211095643.2069433-1-jianqi.ren.cn@windriver.com>
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
1:  2a3cfb9a24a28 ! 1:  06214c2883f65 drm/amd/display: fix NULL checks for adev->dm.dc in amdgpu_dm_fini()
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

