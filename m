Return-Path: <stable+bounces-140239-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7450AAA6A8
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 390FD9836E6
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705A229115A;
	Mon,  5 May 2025 22:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M+fJhkjx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25DF8326C1F;
	Mon,  5 May 2025 22:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484481; cv=none; b=cXT3HlQVckCGytgxhrIMs70pleU6d7o5W/v/cmNZCFYLEUnagUUdT6tBv1P5P8D3QAkMG19yZ99osHtkQLP4zcBLNcLXUMnKNrlCVPW4/Tdo0xVAu9rtHi0CMN1rGOdz4iWRhX/KNVDhSZXgQ+ItYJQ9KaPaVHz0oZTWJMHCQ9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484481; c=relaxed/simple;
	bh=Ndhq7Ah5a8JM4KT/b1vNQtkecmeaxAhGA0wkS0lcSPU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LpgUFOGNDwvvinKJPLDVOie6SekGJNFBJGqd2DhDdtOw94nta2AYuoKlHVhINwxEgOJHtmr2firgot5GnPWnaZJxUv9uIxt9mjx+eChSaIZiihlDi2a00Go1nZof+xQOOKrjuwikC6wH/NClnDwipWpbZlLjM9BR5ACN6oGQpwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M+fJhkjx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5A16C4CEE4;
	Mon,  5 May 2025 22:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484481;
	bh=Ndhq7Ah5a8JM4KT/b1vNQtkecmeaxAhGA0wkS0lcSPU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M+fJhkjx1oYBByXj0tYo+cXMsUdtiQhLV9dsC17ky6bbgiyTovh7bFdxqA3z8TbSD
	 J63C3MNE+LU8KOtNKtbU5EtQdWuSNFo2zk7dNgfJi2dsVSBbZvbX3UVciIlrrEEFJB
	 dkasC36t535IAIIx3XOohLCVsq77Z3KY40IEzcsYR3cJNFYabxRRHzHxU8ORBFGVkp
	 vTrBoHF/V+OFGdBhYxLP1s5uM/JOUJi+t/6y6nilaGRc5wEbU+7XDs42m7tUMFh2OT
	 HqMbELNvV8fi4wIB1oi252KK/ESjiXfdG870cbS5NTqbG6MwW5xYJNmsGaML2jazqv
	 NGD26sjvhrJKg==
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
Subject: [PATCH AUTOSEL 6.14 491/642] drm/v3d: Add clock handling
Date: Mon,  5 May 2025 18:11:47 -0400
Message-Id: <20250505221419.2672473-491-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
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
index 930737a9347b6..852015214e971 100644
--- a/drivers/gpu/drm/v3d/v3d_drv.c
+++ b/drivers/gpu/drm/v3d/v3d_drv.c
@@ -295,11 +295,21 @@ static int v3d_platform_drm_probe(struct platform_device *pdev)
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
 
@@ -319,28 +329,29 @@ static int v3d_platform_drm_probe(struct platform_device *pdev)
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
@@ -369,6 +380,8 @@ static int v3d_platform_drm_probe(struct platform_device *pdev)
 	v3d_gem_destroy(drm);
 dma_free:
 	dma_free_wc(dev, 4096, v3d->mmu_scratch, v3d->mmu_scratch_paddr);
+clk_disable:
+	clk_disable_unprepare(v3d->clk);
 	return ret;
 }
 
@@ -386,6 +399,8 @@ static void v3d_platform_drm_remove(struct platform_device *pdev)
 
 	dma_free_wc(v3d->drm.dev, 4096, v3d->mmu_scratch,
 		    v3d->mmu_scratch_paddr);
+
+	clk_disable_unprepare(v3d->clk);
 }
 
 static struct platform_driver v3d_platform_driver = {
-- 
2.39.5


