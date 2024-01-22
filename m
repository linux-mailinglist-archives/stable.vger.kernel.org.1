Return-Path: <stable+bounces-15169-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A43838432
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 03:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B4042988F7
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65FDC6A027;
	Tue, 23 Jan 2024 02:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ambBDts5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BB466B3C;
	Tue, 23 Jan 2024 02:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705975324; cv=none; b=kUGHyoCNt3qUK7V82YugRTVE3s5MhmtHnds3Jcrgv5t2ViWZ9YQk4c/Bgl/hKXKCTsh83mUGm0yfCAfbDrFXIMzXK3XCZ72as8WdWrf5d3ldmrGpJwLAiWvg/2sj5ETlf6BOUKGVYJP0xeUVk8fcrgLFebE0yoXR4TvP8EYD140=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705975324; c=relaxed/simple;
	bh=VyfPP3V95l8jAqOplMdKzILCbwhWJ468zsoQOq45VTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EenmfOPs+CgF6i8T/wFmHDgKHCQP0RD2AnYMhb1I/nAgVQJZYTtcltsQsabsJKSdso3dfCWWiamx21TnY/u15btPxRB3+yLl+5xlVE5kvKsFknyhMxikqdOAl6Dv4kdqxS3ZWu2SX/pHFU1Q1XOQxRbuzWIlKF4N1866f2l+PPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ambBDts5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7CD4C43390;
	Tue, 23 Jan 2024 02:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705975324;
	bh=VyfPP3V95l8jAqOplMdKzILCbwhWJ468zsoQOq45VTo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ambBDts5L6U8sKrqz312oPLwlD6R3NE/JHqr1YDZ3KASXEK1R1OOEd2YxCO12ikfA
	 44c87s2JmNPCjgH9uQ3lSQ0ISsOmvlDEmjpYhepW8AQiclc+p0ucCN6e+RPPQsT/A3
	 K6+ppFv1u6aFpkVOpdyGBVZn6jtDLidI/nrVfp98=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	CK Hu <ck.hu@mediatek.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Hsiao Chien Sung <shawn.sung@mediatek.com>,
	Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 287/583] drm/mediatek: Fix underrun in VDO1 when switches off the layer
Date: Mon, 22 Jan 2024 15:55:38 -0800
Message-ID: <20240122235820.793408212@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235812.238724226@linuxfoundation.org>
References: <20240122235812.238724226@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hsiao Chien Sung <shawn.sung@mediatek.com>

[ Upstream commit 73b5ab27ab2ee616f2709dc212c2b0007894a12e ]

Do not reset Merge while using CMDQ because reset API doesn't
wait for frame done event as CMDQ does and could lead to
underrun when the layer is switching off.

Fixes: aaf94f7c3ae6 ("drm/mediatek: Add display merge async reset control")

Reviewed-by: CK Hu <ck.hu@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
Link: https://patchwork.kernel.org/project/dri-devel/patch/20231214055847.4936-23-shawn.sung@mediatek.com/
Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/mediatek/mtk_disp_merge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_merge.c b/drivers/gpu/drm/mediatek/mtk_disp_merge.c
index e525a6b9e5b0..22f768d923d5 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_merge.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_merge.c
@@ -103,7 +103,7 @@ void mtk_merge_stop_cmdq(struct device *dev, struct cmdq_pkt *cmdq_pkt)
 	mtk_ddp_write(cmdq_pkt, 0, &priv->cmdq_reg, priv->regs,
 		      DISP_REG_MERGE_CTRL);
 
-	if (priv->async_clk)
+	if (!cmdq_pkt && priv->async_clk)
 		reset_control_reset(priv->reset_ctl);
 }
 
-- 
2.43.0




