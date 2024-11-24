Return-Path: <stable+bounces-95055-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 409FA9D756B
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 16:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A735B62D6A
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5FF3201279;
	Sun, 24 Nov 2024 13:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y/VwsT6K"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940B02010FF;
	Sun, 24 Nov 2024 13:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455828; cv=none; b=JoUGgLdwBuVJFs+Tl+NwGD4jRhHyHmYJcyKzKEx3dvI94PMFx72IgoxDCb+vcV1dOWRETU1CJsTHCKMqhuAIGW79Ly43GsPLyEsek6cGy7ndeLiTNhTcpY40eur+x6fsxVL49iiutsg3toPx7OABb3jRD9oDtMp5HH9gNtLcEkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455828; c=relaxed/simple;
	bh=21WVm3dO3/TO0fBAOe3DyGrgkuDjEUrcY21ZgfP+JRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l3+z7JXcySYJulBvpPcg+iW+f+2QqJbmlZWbQm6p1A5y7wQezp2d7TiJ0W4TmAVSjU+H5Te6ECqU+3KIDItddepkg84qYM4snKVEe43yQkjwQ1nFaULhYs2DWj0pGlcdVZf5sR/WLzouNOKG+9ZqXHwuaKm9xm/rd1FADgfy0Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y/VwsT6K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94F57C4CED3;
	Sun, 24 Nov 2024 13:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455828;
	bh=21WVm3dO3/TO0fBAOe3DyGrgkuDjEUrcY21ZgfP+JRg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y/VwsT6KqAxsxX8zH6NZ+jcln3devmJ54ntb+FjD/mzskImJ7esfWNH55K4An9NCn
	 5IDxVDPNG255L3UWcXKRPwsNVKHI+wkixXx91xInXrssAeudVRIemSvRduiXxxxIlV
	 ADeNRBDz4hM+glI1MDWmGioxiYDXyRQiylAhbMF7IQBcs+CG0ubwj2DR68CXTmtSi+
	 jrCx3DICHQxvzAi+b4JykYe16HdFsNQueCGsRqketSjWDQFc5QizEGEOR0QUrPfg37
	 5kYnRwVcbJVBCKAnXvbzEVHpFLrCFvKFyzCwjGisQDefqzxB8h04suBFSM3CKQU9Qo
	 CSHBhU7heUKhw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Lang Yu <lang.yu@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	Frank.Min@amd.com,
	mdaenzer@redhat.com,
	Hawking.Zhang@amd.com,
	Philip.Yang@amd.com,
	shashank.sharma@amd.com,
	Arunpravin.PaneerSelvam@amd.com,
	Amaranath.Somalapuram@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.11 52/87] drm/amdgpu: refine error handling in amdgpu_ttm_tt_pin_userptr
Date: Sun, 24 Nov 2024 08:38:30 -0500
Message-ID: <20241124134102.3344326-52-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124134102.3344326-1-sashal@kernel.org>
References: <20241124134102.3344326-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.10
Content-Transfer-Encoding: 8bit

From: Lang Yu <lang.yu@amd.com>

[ Upstream commit 46186667f98fb7158c98f4ff5da62c427761ffcd ]

Free sg table when dma_map_sgtable() failed to avoid memory leak.

Signed-off-by: Lang Yu <lang.yu@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index b8bc7fa8c3750..92b5d5aec8a83 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -812,7 +812,7 @@ static int amdgpu_ttm_tt_pin_userptr(struct ttm_device *bdev,
 	/* Map SG to device */
 	r = dma_map_sgtable(adev->dev, ttm->sg, direction, 0);
 	if (r)
-		goto release_sg;
+		goto release_sg_table;
 
 	/* convert SG to linear array of pages and dma addresses */
 	drm_prime_sg_to_dma_addr_array(ttm->sg, gtt->ttm.dma_address,
@@ -820,6 +820,8 @@ static int amdgpu_ttm_tt_pin_userptr(struct ttm_device *bdev,
 
 	return 0;
 
+release_sg_table:
+	sg_free_table(ttm->sg);
 release_sg:
 	kfree(ttm->sg);
 	ttm->sg = NULL;
-- 
2.43.0


