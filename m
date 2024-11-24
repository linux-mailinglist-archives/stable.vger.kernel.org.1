Return-Path: <stable+bounces-95220-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C87CA9D744B
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 16:05:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E794286340
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54091E32DE;
	Sun, 24 Nov 2024 13:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y1Eks06Y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24BE1E32DB;
	Sun, 24 Nov 2024 13:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456384; cv=none; b=iDU2fdhKJ7d8lgVy1nQaUkKkjYgDVy8j/iJTSJbPUvsRDxl+LCNhg10rrw9z/btjx56OpoDpu3R5YC0ESk7bcfX3U3R7lTuHd5UB28NW719ML2/+jfSPu8Fv05Tl6gT/Cj3n1Mz+h00vLaFhT5xIZJ0lvO3NNJk10qqeogsDo8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456384; c=relaxed/simple;
	bh=8IoLvwcyzeCWFjdki+mSfCqcwkMcpjAquu8mCJ5g4hc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WbQCHqmhAJ9NI6BtJh0DNl4AzycG4IA2pnBhV3+HtI6Q786ft2McIdbJ6c9LeqZxLRTx+kSHFLD/a2wLoKxoeAkxSmS0ypuoO6EDw+S7abAlGu8XuisAZ6CMUjEupmZJwy/mk4kM4d9L33zRy5ODYniZ8s+4/IOWyIaCyDYEopc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y1Eks06Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C64DC4CECC;
	Sun, 24 Nov 2024 13:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456384;
	bh=8IoLvwcyzeCWFjdki+mSfCqcwkMcpjAquu8mCJ5g4hc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y1Eks06YZF5Qno4zrYmT5FMCW3gdW9+9/6u/yFPfKv/24z70mPmE25vSUdc2bXDPR
	 aMaj/pPL3jf/GE8gmTK7VQL23lw0BD3dj7nhc7qUwHgzCK5susjsgnH7NXZqYun8+V
	 TDzX5hYgPHtMh/FHf77+5dfDr596688yLNqdHmmfswTQD5gYfk61V8Am/9J2nyY1bH
	 CQ4drioIYNRL42z/MJy0/rVyxUj9RiGUyXiPPjTkBZHDJfjF54/TC4w+nAAqetgXQK
	 J+VhxyK+txQtKtJb4NHL3/qSlAwdaoKz9PkmCm4OrqdDvvLOImli6eBl9kvK40WkIN
	 DRsG6YxCTDZWw==
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
	felix.kuehling@amd.com,
	Likun.Gao@amd.com,
	Philip.Yang@amd.com,
	mdaenzer@redhat.com,
	Arunpravin.PaneerSelvam@amd.com,
	Amaranath.Somalapuram@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.15 21/36] drm/amdgpu: refine error handling in amdgpu_ttm_tt_pin_userptr
Date: Sun, 24 Nov 2024 08:51:35 -0500
Message-ID: <20241124135219.3349183-21-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124135219.3349183-1-sashal@kernel.org>
References: <20241124135219.3349183-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.173
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
index 9a1b19e3d4378..ca00a2d5e38b5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -775,7 +775,7 @@ static int amdgpu_ttm_tt_pin_userptr(struct ttm_device *bdev,
 	/* Map SG to device */
 	r = dma_map_sgtable(adev->dev, ttm->sg, direction, 0);
 	if (r)
-		goto release_sg;
+		goto release_sg_table;
 
 	/* convert SG to linear array of pages and dma addresses */
 	drm_prime_sg_to_dma_addr_array(ttm->sg, gtt->ttm.dma_address,
@@ -783,6 +783,8 @@ static int amdgpu_ttm_tt_pin_userptr(struct ttm_device *bdev,
 
 	return 0;
 
+release_sg_table:
+	sg_free_table(ttm->sg);
 release_sg:
 	kfree(ttm->sg);
 	ttm->sg = NULL;
-- 
2.43.0


