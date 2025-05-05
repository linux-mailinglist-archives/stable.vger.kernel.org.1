Return-Path: <stable+bounces-141242-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 179ECAAB68C
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 07:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E26857A9035
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EAC041A07A;
	Tue,  6 May 2025 00:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qM68aoWf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C402D3FA4;
	Mon,  5 May 2025 22:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485610; cv=none; b=U0xel/oiwqv4IcZxFybvQPnj5lbvMa8efdoqeKtQgY604mZud6UiSsM5nHzCDJR68Ebb3/TU6C0H9z2/kPBf2WDiUvQSCZg1wezVb+jyg0XWcm01touNdWQ6dsbz1TnhkcadImVnUN3Q3ZhphcRrvL4LAJqDMQ1sxgr42eYUr9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485610; c=relaxed/simple;
	bh=NwxOv2q6DfqaXrAsMJRJxmZQFCAHvhBTNPd6AMInCLc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b5K8R5mCdj2EDMNO2Zw2jrCBhLVSH4tZCK7Tu+8FxWkglWp4YcQsj6NHrVnSKJ+q/eL6rlub0HgU+53k+DEefIJDMbClUx6F/Ta0iQ9hUlfnS3Xzim3ufBaIyT3s93AOqxybFDMz6zCM7rwgkHZlGOFYG0dJEzn7kNX5qGXn5jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qM68aoWf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04471C4CEED;
	Mon,  5 May 2025 22:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485609;
	bh=NwxOv2q6DfqaXrAsMJRJxmZQFCAHvhBTNPd6AMInCLc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qM68aoWfXFall08/PYKDUaM0Tec9FmcqHvYj2TzzYAfIACzROarlB/XoeOFftyfJP
	 ybDBeU5cy52VnxG/kklG+EGlD6avQrM+Le8ml+ML8mt5SUgje1rlIY2IGj1BvJbdNZ
	 U5NzftsQ167w2PXBZZEmyuiQjISDbAbjxQgVqaL1FYbowv0Qy6whELwHgYmMT61pXB
	 t5AMuIzdsnmw6wbUPfn8AGwgxa0FAl4H9cl8W/Iocz4S3lcIhxne8lyuyuyAP77r4c
	 UTv1OauFWPpXOrEN47XwSRCMUrWiaZ/RRE/liAfvf60h5nxS8xbTy4lugx5JmQ0xQ9
	 nrQDGF2Wx6QrQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Stefan Wahren <wahrenst@gmx.net>,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
	Sasha Levin <sashal@kernel.org>,
	mwen@igalia.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.12 384/486] drm/v3d: Add clock handling
Date: Mon,  5 May 2025 18:37:40 -0400
Message-Id: <20250505223922.2682012-384-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Stefan Wahren <wahrenst@gmx.net>

[ Upstream commit 4dd40b5f9c3d89b67af0dbe059cf4a51aac6bf06 ]

Since the initial commit 57692c94dcbe ("drm/v3d: Introduce a new DRM driver
for Broadcom V3D V3.x+") the struct v3d_dev reserved a pointer for
an optional V3D clock. But there wasn't any code, which fetched it.
So add the missing clock handling before accessing any V3D registers.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
Reviewed-by: Maíra Canal <mcanal@igalia.com>
Signed-off-by: Maíra Canal <mcanal@igalia.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20250201125046.33030-1-wahrenst@gmx.net
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/v3d/v3d_drv.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_drv.c b/drivers/gpu/drm/v3d/v3d_drv.c
index d7ff1f5fa481f..7c17108da7d2d 100644
--- a/drivers/gpu/drm/v3d/v3d_drv.c
+++ b/drivers/gpu/drm/v3d/v3d_drv.c
@@ -286,11 +286,21 @@ static int v3d_platform_drm_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	v3d->clk = devm_clk_get_optional(dev, NULL);
+	if (IS_ERR(v3d->clk))
+		return dev_err_probe(dev, PTR_ERR(v3d->clk), "Failed to get V3D clock\n");
+
+	ret = clk_prepare_enable(v3d->clk);
+	if (ret) {
+		dev_err(&pdev->dev, "Couldn't enable the V3D clock\n");
+		return ret;
+	}
+
 	mmu_debug = V3D_READ(V3D_MMU_DEBUG_INFO);
 	mask = DMA_BIT_MASK(30 + V3D_GET_FIELD(mmu_debug, V3D_MMU_PA_WIDTH));
 	ret = dma_set_mask_and_coherent(dev, mask);
 	if (ret)
-		return ret;
+		goto clk_disable;
 
 	v3d->va_width = 30 + V3D_GET_FIELD(mmu_debug, V3D_MMU_VA_WIDTH);
 
@@ -310,28 +320,29 @@ static int v3d_platform_drm_probe(struct platform_device *pdev)
 		ret = PTR_ERR(v3d->reset);
 
 		if (ret == -EPROBE_DEFER)
-			return ret;
+			goto clk_disable;
 
 		v3d->reset = NULL;
 		ret = map_regs(v3d, &v3d->bridge_regs, "bridge");
 		if (ret) {
 			dev_err(dev,
 				"Failed to get reset control or bridge regs\n");
-			return ret;
+			goto clk_disable;
 		}
 	}
 
 	if (v3d->ver < 41) {
 		ret = map_regs(v3d, &v3d->gca_regs, "gca");
 		if (ret)
-			return ret;
+			goto clk_disable;
 	}
 
 	v3d->mmu_scratch = dma_alloc_wc(dev, 4096, &v3d->mmu_scratch_paddr,
 					GFP_KERNEL | __GFP_NOWARN | __GFP_ZERO);
 	if (!v3d->mmu_scratch) {
 		dev_err(dev, "Failed to allocate MMU scratch page\n");
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto clk_disable;
 	}
 
 	ret = v3d_gem_init(drm);
@@ -360,6 +371,8 @@ static int v3d_platform_drm_probe(struct platform_device *pdev)
 	v3d_gem_destroy(drm);
 dma_free:
 	dma_free_wc(dev, 4096, v3d->mmu_scratch, v3d->mmu_scratch_paddr);
+clk_disable:
+	clk_disable_unprepare(v3d->clk);
 	return ret;
 }
 
@@ -377,6 +390,8 @@ static void v3d_platform_drm_remove(struct platform_device *pdev)
 
 	dma_free_wc(v3d->drm.dev, 4096, v3d->mmu_scratch,
 		    v3d->mmu_scratch_paddr);
+
+	clk_disable_unprepare(v3d->clk);
 }
 
 static struct platform_driver v3d_platform_driver = {
-- 
2.39.5


