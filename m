Return-Path: <stable+bounces-100191-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0629E98F6
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 15:35:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF2871887DCA
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 14:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C67A1B0413;
	Mon,  9 Dec 2024 14:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fG1drYgL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF8F23313D
	for <stable@vger.kernel.org>; Mon,  9 Dec 2024 14:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733754905; cv=none; b=XA0e0ulPgXgN3C6f7/OUIorHEJ10QOgVxQOeek4ilRF4UpQrYXMcKVqQVMs992x7vF7hAG9tb5ua/0RHsRiUCJWxTkuOag+HlwK1FZ/KnfzB5XEjxqpuTQ5VVkt8iMxdsM0zd2Znou/scMp6M2EDKMUWAOOeOcv3cvfamxSlrzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733754905; c=relaxed/simple;
	bh=LeisZuEp5IBKzX85/GHb4HetemV70411slNHwDSB9KA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CqKS/uLvuYbEsOzYrvGy2YA9sS4FZCrC7uTZl1toF7umebyoyn4M62AQb4QsgTnOS2wvaBekKmIVs0GTix4KENous9NrhpBpR3TW8lI8/jgBUL75Oic/8pJ4lCbty3rNweTEBM36f3i0Y8JGWXGrtXiHo9Xi8vIoOTXw+XV2jS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fG1drYgL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FB39C4CED1;
	Mon,  9 Dec 2024 14:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733754904;
	bh=LeisZuEp5IBKzX85/GHb4HetemV70411slNHwDSB9KA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fG1drYgLsc6IAukroYVrhDN2bCt6sGmd+4fL0A4viUQBEY6IWtZwSbcTZmcLEfINY
	 vsOzY73c64XpOwviJiQ1EQc/HcLOEqCBh+p/MTbzRUeg6y5Sj/zMNGY1HS9VsjB+9N
	 8U0FcnqrwhM7NNj0w1djihjpESGlRIeOL0HugVcqqkoeyB1smkolCc5yjNR7T46PBm
	 w/uDpPlvMQibLPEKEMa7ZTRUtQUZ8WmxQ89VhKJjFfl6jP7FRk5C+pRI91gCWdKxAP
	 LWwe3BDfP9xsUGcOGpRPEV0SxbskN1J32dykPDp+qySzbdQmOqu74bpPfq6ZTwQlot
	 ULoBgAXMYnN8Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] drm/amd/display: fix NULL checks for adev->dm.dc in amdgpu_dm_fini()
Date: Mon,  9 Dec 2024 09:35:02 -0500
Message-ID: <20241209074642-1f3d4bc49ccd06e0@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241209064137.3427197-1-jianqi.ren.cn@windriver.com>
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
1:  2a3cfb9a24a28 ! 1:  16b03dc13bb4e drm/amd/display: fix NULL checks for adev->dm.dc in amdgpu_dm_fini()
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

