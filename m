Return-Path: <stable+bounces-49743-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F343B8FEEA8
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E843285B75
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D801C616B;
	Thu,  6 Jun 2024 14:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ykVAUNE+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBBA1991D7;
	Thu,  6 Jun 2024 14:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683687; cv=none; b=gOGHzDRNwFyih7mUXDvHzZTB7h37Gs/PrMTNHddMRcph/v92EcJR3NFFDDobgo2KnOpmhKI1ax5rnCQDn4m0+PR2Q8C2D2HMIBtj4Wm0gtgIh/EPVztP5OM+WQWOXXNXHvgKM7ANMp4tAZY1D0UJXtOR6uiarANxCeKpFlpH8BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683687; c=relaxed/simple;
	bh=5w/9+1MVGhow1fi1+wuxdeYulmf3QDff2aZaWoIHVJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GuD6Z0jldXBkxwekKV/5NgZZW3xbzXjtfPjNZqhmXHT8C316ItvTPyCrIosHJJt+Q1GH6DNCGkE46NTgo8dCOY1yQk42VHFzpao5HerXuu44P0/+JiWkPfXe+cXs7ZBGU+SzjOLQggfQlmfrOgRTBGjNTYhTtQJRc+XwTAdqFDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ykVAUNE+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F34DBC4AF09;
	Thu,  6 Jun 2024 14:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683687;
	bh=5w/9+1MVGhow1fi1+wuxdeYulmf3QDff2aZaWoIHVJw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ykVAUNE+yztXujwOgkGnJn2nwpBvQMReM34T8CoK3BPA4WNizggrHcyFzAFkwccwV
	 9+JvIAFK/X648vmCiowdjoMIIGvrtW1FJpTTQL5aFI8v/KQbAvyUYLVzPbSDhmBXyY
	 4ONHoIiBkL76tdbZoinNDz5iBXtSeaaiu8G48WCs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Irui Wang <irui.wang@mediatek.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 593/744] media: mediatek: vcodec: add encoder power management helper functions
Date: Thu,  6 Jun 2024 16:04:25 +0200
Message-ID: <20240606131751.492810321@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131732.440653204@linuxfoundation.org>
References: <20240606131732.440653204@linuxfoundation.org>
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

From: Irui Wang <irui.wang@mediatek.com>

[ Upstream commit 3568cb6556695af163e930a75b1ed8f6dfa848ba ]

Remove PM functions at start/stop streaming, add PM helper functions
to get PM before encoding frame start and put PM after encoding frame
done. Meanwhile, remove unnecessary clock operations.

Signed-off-by: Irui Wang <irui.wang@mediatek.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Stable-dep-of: c28d4921a1e3 ("media: mediatek: vcodec: fix possible unbalanced PM counter")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../mediatek/vcodec/encoder/mtk_vcodec_enc.c  | 21 +++----------------
 .../vcodec/encoder/mtk_vcodec_enc_pm.c        | 18 ++++++++++++++++
 .../vcodec/encoder/mtk_vcodec_enc_pm.h        |  3 ++-
 .../mediatek/vcodec/encoder/venc_drv_if.c     |  8 ++-----
 4 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc.c b/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc.c
index 04948d3eb011a..eb381fa6e7d14 100644
--- a/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc.c
+++ b/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc.c
@@ -866,7 +866,7 @@ static int vb2ops_venc_start_streaming(struct vb2_queue *q, unsigned int count)
 {
 	struct mtk_vcodec_enc_ctx *ctx = vb2_get_drv_priv(q);
 	struct venc_enc_param param;
-	int ret, pm_ret;
+	int ret;
 	int i;
 
 	/* Once state turn into MTK_STATE_ABORT, we need stop_streaming
@@ -886,18 +886,12 @@ static int vb2ops_venc_start_streaming(struct vb2_queue *q, unsigned int count)
 			return 0;
 	}
 
-	ret = pm_runtime_resume_and_get(&ctx->dev->plat_dev->dev);
-	if (ret < 0) {
-		mtk_v4l2_venc_err(ctx, "pm_runtime_resume_and_get fail %d", ret);
-		goto err_start_stream;
-	}
-
 	mtk_venc_set_param(ctx, &param);
 	ret = venc_if_set_param(ctx, VENC_SET_PARAM_ENC, &param);
 	if (ret) {
 		mtk_v4l2_venc_err(ctx, "venc_if_set_param failed=%d", ret);
 		ctx->state = MTK_STATE_ABORT;
-		goto err_set_param;
+		goto err_start_stream;
 	}
 	ctx->param_change = MTK_ENCODE_PARAM_NONE;
 
@@ -910,18 +904,13 @@ static int vb2ops_venc_start_streaming(struct vb2_queue *q, unsigned int count)
 		if (ret) {
 			mtk_v4l2_venc_err(ctx, "venc_if_set_param failed=%d", ret);
 			ctx->state = MTK_STATE_ABORT;
-			goto err_set_param;
+			goto err_start_stream;
 		}
 		ctx->state = MTK_STATE_HEADER;
 	}
 
 	return 0;
 
-err_set_param:
-	pm_ret = pm_runtime_put(&ctx->dev->plat_dev->dev);
-	if (pm_ret < 0)
-		mtk_v4l2_venc_err(ctx, "pm_runtime_put fail %d", pm_ret);
-
 err_start_stream:
 	for (i = 0; i < q->num_buffers; ++i) {
 		struct vb2_buffer *buf = vb2_get_buffer(q, i);
@@ -1004,10 +993,6 @@ static void vb2ops_venc_stop_streaming(struct vb2_queue *q)
 	if (ret)
 		mtk_v4l2_venc_err(ctx, "venc_if_deinit failed=%d", ret);
 
-	ret = pm_runtime_put(&ctx->dev->plat_dev->dev);
-	if (ret < 0)
-		mtk_v4l2_venc_err(ctx, "pm_runtime_put fail %d", ret);
-
 	ctx->state = MTK_STATE_FREE;
 }
 
diff --git a/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_pm.c b/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_pm.c
index 3fce936e61b9f..a22b7dfc656e1 100644
--- a/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_pm.c
+++ b/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_pm.c
@@ -58,6 +58,24 @@ int mtk_vcodec_init_enc_clk(struct mtk_vcodec_enc_dev *mtkdev)
 	return 0;
 }
 
+void mtk_vcodec_enc_pw_on(struct mtk_vcodec_pm *pm)
+{
+	int ret;
+
+	ret = pm_runtime_resume_and_get(pm->dev);
+	if (ret)
+		dev_err(pm->dev, "pm_runtime_resume_and_get fail: %d", ret);
+}
+
+void mtk_vcodec_enc_pw_off(struct mtk_vcodec_pm *pm)
+{
+	int ret;
+
+	ret = pm_runtime_put(pm->dev);
+	if (ret && ret != -EAGAIN)
+		dev_err(pm->dev, "pm_runtime_put fail %d", ret);
+}
+
 void mtk_vcodec_enc_clock_on(struct mtk_vcodec_pm *pm)
 {
 	struct mtk_vcodec_clk *enc_clk = &pm->venc_clk;
diff --git a/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_pm.h b/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_pm.h
index e50be0575190a..157ea08ba9e36 100644
--- a/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_pm.h
+++ b/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_pm.h
@@ -10,7 +10,8 @@
 #include "mtk_vcodec_enc_drv.h"
 
 int mtk_vcodec_init_enc_clk(struct mtk_vcodec_enc_dev *dev);
-
+void mtk_vcodec_enc_pw_on(struct mtk_vcodec_pm *pm);
+void mtk_vcodec_enc_pw_off(struct mtk_vcodec_pm *pm);
 void mtk_vcodec_enc_clock_on(struct mtk_vcodec_pm *pm);
 void mtk_vcodec_enc_clock_off(struct mtk_vcodec_pm *pm);
 
diff --git a/drivers/media/platform/mediatek/vcodec/encoder/venc_drv_if.c b/drivers/media/platform/mediatek/vcodec/encoder/venc_drv_if.c
index 1bdaecdd64a79..c402a686f3cb2 100644
--- a/drivers/media/platform/mediatek/vcodec/encoder/venc_drv_if.c
+++ b/drivers/media/platform/mediatek/vcodec/encoder/venc_drv_if.c
@@ -32,9 +32,7 @@ int venc_if_init(struct mtk_vcodec_enc_ctx *ctx, unsigned int fourcc)
 	}
 
 	mtk_venc_lock(ctx);
-	mtk_vcodec_enc_clock_on(&ctx->dev->pm);
 	ret = ctx->enc_if->init(ctx);
-	mtk_vcodec_enc_clock_off(&ctx->dev->pm);
 	mtk_venc_unlock(ctx);
 
 	return ret;
@@ -46,9 +44,7 @@ int venc_if_set_param(struct mtk_vcodec_enc_ctx *ctx,
 	int ret = 0;
 
 	mtk_venc_lock(ctx);
-	mtk_vcodec_enc_clock_on(&ctx->dev->pm);
 	ret = ctx->enc_if->set_param(ctx->drv_handle, type, in);
-	mtk_vcodec_enc_clock_off(&ctx->dev->pm);
 	mtk_venc_unlock(ctx);
 
 	return ret;
@@ -68,10 +64,12 @@ int venc_if_encode(struct mtk_vcodec_enc_ctx *ctx,
 	ctx->dev->curr_ctx = ctx;
 	spin_unlock_irqrestore(&ctx->dev->irqlock, flags);
 
+	mtk_vcodec_enc_pw_on(&ctx->dev->pm);
 	mtk_vcodec_enc_clock_on(&ctx->dev->pm);
 	ret = ctx->enc_if->encode(ctx->drv_handle, opt, frm_buf,
 				  bs_buf, result);
 	mtk_vcodec_enc_clock_off(&ctx->dev->pm);
+	mtk_vcodec_enc_pw_off(&ctx->dev->pm);
 
 	spin_lock_irqsave(&ctx->dev->irqlock, flags);
 	ctx->dev->curr_ctx = NULL;
@@ -89,9 +87,7 @@ int venc_if_deinit(struct mtk_vcodec_enc_ctx *ctx)
 		return 0;
 
 	mtk_venc_lock(ctx);
-	mtk_vcodec_enc_clock_on(&ctx->dev->pm);
 	ret = ctx->enc_if->deinit(ctx->drv_handle);
-	mtk_vcodec_enc_clock_off(&ctx->dev->pm);
 	mtk_venc_unlock(ctx);
 
 	ctx->drv_handle = NULL;
-- 
2.43.0




