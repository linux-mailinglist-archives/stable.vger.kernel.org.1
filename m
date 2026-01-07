Return-Path: <stable+bounces-206143-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8A0CFDC56
	for <lists+stable@lfdr.de>; Wed, 07 Jan 2026 13:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 94B0C304B07D
	for <lists+stable@lfdr.de>; Wed,  7 Jan 2026 12:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDCB33164DF;
	Wed,  7 Jan 2026 12:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D6Dk9rfN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828693164A1
	for <stable@vger.kernel.org>; Wed,  7 Jan 2026 12:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767789963; cv=none; b=d8xCGwvFxLVFLRV85VSxo6d+t90IPXY7qHg/jtCXT04Xx66ATrbfwrKW41BxRhNkxQyRlthdrQrN6i0zLDZ0gyCJmU9f8DjATNdGDiwxlCpmxgQdQHyNeZXGkIjNhyrFMvkiYuKsJZf0gQGq/L+1kjkl73DPs/cTw99P8utRTO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767789963; c=relaxed/simple;
	bh=jlOYhHRK9R/tiUBFn/5aMiOVbVgYLgaW8WWuQuDHDyo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tVKRTIk7cm2klcoeSLH3a5cTsQVm52uzC2i8WExd5nURHcB9EWjJUt1DokL67WjJGvuclnomv6lxQschAUZK/Wen1ppCmzgCVdqWeCRumejh+bqYDvu+9t/gCO6pE9akzhbovpwwTZw9NCCms2MyEIm+IN1T+tQhXVTgWwqzI+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D6Dk9rfN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43D2AC4CEF7;
	Wed,  7 Jan 2026 12:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767789963;
	bh=jlOYhHRK9R/tiUBFn/5aMiOVbVgYLgaW8WWuQuDHDyo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D6Dk9rfNyBY2aKla6SPPDhkI/YMc4hqHjhZae0c7zCr16KlXRgNxV39Y1LpF2Nm1h
	 Wc6tutntwGTkEq8tLbsUq6xL9NQeUafEeJpXRtdU8c2EVh6hdCFcH7p4yX8UZZ6L97
	 DacJKAjBRoaGmlKATr58DMKrdUwOyrmNax32/64SkdrdO0HNb1Ha4WDEKyw+NG9gsz
	 IBtAJ3a+e5yvBw3ovqWqx1w1oB81iP5i0JF8SeFJ1eG0e94H1x6YGPlpMYNpajBAUh
	 VXK4XU8Idps5XRYx66BGsnkb4FZRFIYaxH1Vh9mfScqxziQok0dXEULVBjCO0Ab/Rz
	 vWgJka2156PRQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	CK Hu <ck.hu@mediatek.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] drm/mediatek: Fix probe memory leak
Date: Wed,  7 Jan 2026 07:46:00 -0500
Message-ID: <20260107124600.3997704-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026010516-unfrosted-serotonin-e7b7@gregkh>
References: <2026010516-unfrosted-serotonin-e7b7@gregkh>
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
index 22d23668b484..82e727c21774 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
@@ -487,7 +487,7 @@ int mtk_ddp_comp_init(struct device_node *node, struct mtk_ddp_comp *comp,
 	    type == MTK_DISP_RDMA)
 		return 0;
 
-	priv = devm_kzalloc(comp->dev, sizeof(*priv), GFP_KERNEL);
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
-- 
2.51.0


