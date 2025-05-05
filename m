Return-Path: <stable+bounces-140598-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A56AAA9ED
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54C2E7B3642
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E31337266F;
	Mon,  5 May 2025 22:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kH2BLxit"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45442BE0E8;
	Mon,  5 May 2025 22:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485236; cv=none; b=kq7+0s8VVKXdKG9erA06CDLVdzvMKYWwY0kz6a0Uqd2ggzTARexODDjHLSvbXox3+8shJKoLPOydf1MxPd7kcwwTo8aBliQvft9VhB3ti8nIadnnufQZe7Sq/W87DFyHSkO3/Hk0d3s7+p/Sk8EEOI1/hYTprfNoQv7NwhgP6Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485236; c=relaxed/simple;
	bh=98FQmpAUpXuvUdgOGxz4jofi+Xev3uvncrd6eCdYIKQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EX9VB0ymgCZCHJtbdj9laBctyw28PdsNNoPNCWu807nWcXSIUHaIcAnDBmyIatn9fK7l5ESJeSOP7RaZsRkqQWLfAwYz6WmiTEFv7wFXRLBoBb9Gf3rjBNInsmnsHYLMhX8yMGle0Q5AfXbSpNNg77h6yCLg1dVtW6rSY2qgUpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kH2BLxit; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39445C4CEED;
	Mon,  5 May 2025 22:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485235;
	bh=98FQmpAUpXuvUdgOGxz4jofi+Xev3uvncrd6eCdYIKQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kH2BLxitkNWyzr4GTSJl7wA2DqXLO67aUykwirWEr3Aio+uedQWA2XyDiiZZre599
	 zIXffCE5NdjsoMkNXmdU2Bn2b9HINYQcobY+ZoEvw+jo81Wpzl/bocRBJLoiqXvLOM
	 vXj51X/CFb7/MpQx+rOXHqmnQkARwBgTkN+kxrfM82/dvdRGpQjJW8Z8FYuU6hX7u3
	 hvtMRx5DQYvlaA2a/VkBRNVc+nTHB6GPZEw8jEx10S18V+9hCO5+Q2Pp1AzJ6loiAT
	 vBX21qluFG4UBgZrx/BuTT+PxTt0V3a+Sfhlpzue+pn5wK+YshppHdofOTkVA3wItL
	 GQ7G7Hlhmo+jw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	CK Hu <ck.hu@mediatek.com>,
	Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	p.zabel@pengutronix.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	matthias.bgg@gmail.com,
	dri-devel@lists.freedesktop.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.12 226/486] drm/mediatek: mtk_dpi: Add checks for reg_h_fre_con existence
Date: Mon,  5 May 2025 18:35:02 -0400
Message-Id: <20250505223922.2682012-226-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

[ Upstream commit 8c9da7cd0bbcc90ab444454fecf535320456a312 ]

In preparation for adding support for newer DPI instances which
do support direct-pin but do not have any H_FRE_CON register,
like the one found in MT8195 and MT8188, add a branch to check
if the reg_h_fre_con variable was declared in the mtk_dpi_conf
structure for the probed SoC DPI version.

As a note, this is useful specifically only for cases in which
the support_direct_pin variable is true, so mt8195-dpintf is
not affected by any issue.

Reviewed-by: CK Hu <ck.hu@mediatek.com>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Link: https://patchwork.kernel.org/project/dri-devel/patch/20250217154836.108895-6-angelogioacchino.delregno@collabora.com/
Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/mediatek/mtk_dpi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
index 9c11d3158324c..20a50180d4d49 100644
--- a/drivers/gpu/drm/mediatek/mtk_dpi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
@@ -410,12 +410,13 @@ static void mtk_dpi_config_swap_input(struct mtk_dpi *dpi, bool enable)
 
 static void mtk_dpi_config_2n_h_fre(struct mtk_dpi *dpi)
 {
-	mtk_dpi_mask(dpi, dpi->conf->reg_h_fre_con, H_FRE_2N, H_FRE_2N);
+	if (dpi->conf->reg_h_fre_con)
+		mtk_dpi_mask(dpi, dpi->conf->reg_h_fre_con, H_FRE_2N, H_FRE_2N);
 }
 
 static void mtk_dpi_config_disable_edge(struct mtk_dpi *dpi)
 {
-	if (dpi->conf->edge_sel_en)
+	if (dpi->conf->edge_sel_en && dpi->conf->reg_h_fre_con)
 		mtk_dpi_mask(dpi, dpi->conf->reg_h_fre_con, 0, EDGE_SEL_EN);
 }
 
-- 
2.39.5


