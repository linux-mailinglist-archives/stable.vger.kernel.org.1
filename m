Return-Path: <stable+bounces-206139-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2585BCFD95F
	for <lists+stable@lfdr.de>; Wed, 07 Jan 2026 13:17:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 83EFD3001FD1
	for <lists+stable@lfdr.de>; Wed,  7 Jan 2026 12:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D32B3090D7;
	Wed,  7 Jan 2026 12:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qmPwWFgD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8CB258ECA
	for <stable@vger.kernel.org>; Wed,  7 Jan 2026 12:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767788224; cv=none; b=m4H2cMNHOFzde/tYJPqPL06WyWYDs1K9Q2oOhLp9FVHBqkLEuXQ6LPE8AXLptP7lf8emFVIvlkFU4jf9x1+VJHzol+B6VsT+R7Y9YGltUXzJwhuxhkQPe7X1Wt6YupBxmOGTQ0eHYKnPPC2gwL8NeTpS58jFay12AARPNqzmo6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767788224; c=relaxed/simple;
	bh=0Dp79+4JTCaPKkZg05yyu9nASFBQFMXIE7+114H2GUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ccKS2fsGkybGHS9Zuto4xJLYElVV/SwsMoCj/H/PXCwGYtiShpm3ZGuqwulI9iWvNioNI2aP2GBgGzdl0Pg02jJLivp4nDjBSbO3GRQHc2crNyDYO0O5DYP4TvQcWPuFUU5EWAGu6sYeBZ8IV9bMNa70+lJIruIwUPS/3UADFvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qmPwWFgD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBDF7C4CEF7;
	Wed,  7 Jan 2026 12:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767788222;
	bh=0Dp79+4JTCaPKkZg05yyu9nASFBQFMXIE7+114H2GUI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qmPwWFgDyrjWNekxijRZMbz6tjaUkyZiXhg3tKsSHDvJyaYmPz42irUGZHSbTLvED
	 ueQTQgOQJrnS9DZkEjNYxHLE7Y+Vvo3kqai5rYSTd6KC9tG1LSisgIw9tq6wPwLmMu
	 WVDP1Wnh8OwZanATOw7Jbnv8228Lt3SUlw+g/hmb1cQEVhfhfkMDdOSNyQZLig+k4g
	 0X7XMdhhn5H8epOfWeU9LjJ3PxQ3oFT94h+CYxqjJ5+i38f6USumjMvZZZyBVSNAYh
	 8+xFX+5/BLZavTQLOLVEWyG3C1deT244S2QEDX8Kmgh9DOQY1t0oBOvLC/GTp4WwfL
	 nCAzmYSAuaQEg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	CK Hu <ck.hu@mediatek.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] drm/mediatek: Fix probe memory leak
Date: Wed,  7 Jan 2026 07:17:00 -0500
Message-ID: <20260107121700.3993037-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026010514-divisible-liftoff-cf3d@gregkh>
References: <2026010514-divisible-liftoff-cf3d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johan Hovold <johan@kernel.org>

[ Upstream commit 5e49200593f331cd0629b5376fab9192f698e8ef ]

The Mediatek DRM driver allocates private data for components without a
platform driver but as the lifetime is tied to each component device,
the memory is never freed.

Tie the allocation lifetime to the DRM platform device so that the
memory is released on probe failure (e.g. probe deferral) and when the
driver is unbound.

Fixes: c0d36de868a6 ("drm/mediatek: Move clk info from struct mtk_ddp_comp to sub driver private data")
Cc: stable@vger.kernel.org	# 5.12
Cc: CK Hu <ck.hu@mediatek.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Link: https://patchwork.kernel.org/project/dri-devel/patch/20250923152340.18234-3-johan@kernel.org/
Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
index 6b6d5335c834..32f07e29e3c5 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
@@ -555,7 +555,7 @@ int mtk_ddp_comp_init(struct device_node *node, struct mtk_ddp_comp *comp,
 	    type == MTK_DSI)
 		return 0;
 
-	priv = devm_kzalloc(comp->dev, sizeof(*priv), GFP_KERNEL);
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
-- 
2.51.0


