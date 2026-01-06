Return-Path: <stable+bounces-204963-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EED79CF615D
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 01:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC2B53012BC9
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 00:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07142836F;
	Tue,  6 Jan 2026 00:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dOR4dlE3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFDE33EC
	for <stable@vger.kernel.org>; Tue,  6 Jan 2026 00:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767659513; cv=none; b=e/KoV+gEy24t8DwtMer18BBCQe1KTEOF5rtMIy/UWBkR9+KynWUhDrORtCHxrjRd2MmxHi6jK5UXQ6w4hb0UHg8eyU5524p+iILxriqpi3Z06/Mctesy5IXbaDC9kBGrLwRASUN1CIxyILcncGkazoOogXiq2YeuEjZKdoxsPxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767659513; c=relaxed/simple;
	bh=rN50dL9BndOkyfye+YqHPNsF2RDHNXKEX8tqAReI32U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NbvV88ZEzLz1xsz2w9MSbVoH2V6o+2dtPEDHM5iaWLPGKYFgHa8RyT1chOWoKanp0PmyHlcwCLVMlXG0V8EPhMY0SOMIZ/pAbT6edmSqUd1exvP7ZwVM70grNDxU00coLSU4ri0EzZtUVkVEFqTdjD2fsMtYWPTUtZDlJ+xDONk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dOR4dlE3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DB4CC16AAE;
	Tue,  6 Jan 2026 00:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767659513;
	bh=rN50dL9BndOkyfye+YqHPNsF2RDHNXKEX8tqAReI32U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dOR4dlE3Wj1MIsgB9PZ9jNG/x2+mrC+U9uKk+Qm8+767TTCKitksoMqASmVu9wREU
	 xerjghn4fhrg78KZilPl84rcxH/3VrpQ/xRNWQmue9+j3ut7VT1/MPJLaEwBw9CIYy
	 1M/I8wq0IQHuuoEt+xtRkjwu0/hwUXh9l/zZWCDDyi6MRw9JMD2879RoIkmNIf5WyK
	 dE/P6xIXSiGmN/2sLocqYG5h31lnPwtDLaAi4UYcZW7d90b31mawO//4SadVhfweQF
	 Fxxxj+euk55uokKIzdB0VCq11rcvqhSS4QoQ99TJ4ynlalwKPe5GaVuzjkTJnQ7Fp5
	 ucXd/WXB3pRIQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	Yunfei Dong <yunfei.dong@mediatek.com>,
	Fei Shao <fshao@chromium.org>,
	Tomasz Figa <tfiga@chromium.org>,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] media: mediatek: vcodec: Use spinlock for context list protection lock
Date: Mon,  5 Jan 2026 19:31:50 -0500
Message-ID: <20260106003150.2858570-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026010509-awning-unloaded-f3d0@gregkh>
References: <2026010509-awning-unloaded-f3d0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen-Yu Tsai <wenst@chromium.org>

[ Upstream commit a5844227e0f030d2af2d85d4aed10c5eca6ca176 ]

Previously a mutex was added to protect the encoder and decoder context
lists from unexpected changes originating from the SCP IP block, causing
the context pointer to go invalid, resulting in a NULL pointer
dereference in the IPI handler.

Turns out on the MT8173, the VPU IPI handler is called from hard IRQ
context. This causes a big warning from the scheduler. This was first
reported downstream on the ChromeOS kernels, but is also reproducible
on mainline using Fluster with the FFmpeg v4l2m2m decoders. Even though
the actual capture format is not supported, the affected code paths
are triggered.

Since this lock just protects the context list and operations on it are
very fast, it should be OK to switch to a spinlock.

Fixes: 6467cda18c9f ("media: mediatek: vcodec: adding lock to protect decoder context list")
Fixes: afaaf3a0f647 ("media: mediatek: vcodec: adding lock to protect encoder context list")
Cc: Yunfei Dong <yunfei.dong@mediatek.com>
Cc: stable@vger.kernel.org
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: Fei Shao <fshao@chromium.org>
Reviewed-by: Tomasz Figa <tfiga@chromium.org>
Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
[ adapted file_to_dec_ctx() and file_to_enc_ctx() helper calls to equivalent fh_to_dec_ctx(file->private_data) and fh_to_enc_ctx(file->private_data) pattern ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../mediatek/vcodec/common/mtk_vcodec_fw_vpu.c       | 10 ++++++----
 .../mediatek/vcodec/decoder/mtk_vcodec_dec_drv.c     | 12 +++++++-----
 .../mediatek/vcodec/decoder/mtk_vcodec_dec_drv.h     |  2 +-
 .../platform/mediatek/vcodec/decoder/vdec_vpu_if.c   |  5 +++--
 .../mediatek/vcodec/encoder/mtk_vcodec_enc_drv.c     | 12 +++++++-----
 .../mediatek/vcodec/encoder/mtk_vcodec_enc_drv.h     |  2 +-
 .../platform/mediatek/vcodec/encoder/venc_vpu_if.c   |  5 +++--
 7 files changed, 28 insertions(+), 20 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_vpu.c b/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_vpu.c
index 42ce58c41e4f..22bd5f789019 100644
--- a/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_vpu.c
+++ b/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_vpu.c
@@ -47,30 +47,32 @@ static void mtk_vcodec_vpu_reset_dec_handler(void *priv)
 {
 	struct mtk_vcodec_dec_dev *dev = priv;
 	struct mtk_vcodec_dec_ctx *ctx;
+	unsigned long flags;
 
 	dev_err(&dev->plat_dev->dev, "Watchdog timeout!!");
 
-	mutex_lock(&dev->dev_ctx_lock);
+	spin_lock_irqsave(&dev->dev_ctx_lock, flags);
 	list_for_each_entry(ctx, &dev->ctx_list, list) {
 		ctx->state = MTK_STATE_ABORT;
 		mtk_v4l2_vdec_dbg(0, ctx, "[%d] Change to state MTK_STATE_ABORT", ctx->id);
 	}
-	mutex_unlock(&dev->dev_ctx_lock);
+	spin_unlock_irqrestore(&dev->dev_ctx_lock, flags);
 }
 
 static void mtk_vcodec_vpu_reset_enc_handler(void *priv)
 {
 	struct mtk_vcodec_enc_dev *dev = priv;
 	struct mtk_vcodec_enc_ctx *ctx;
+	unsigned long flags;
 
 	dev_err(&dev->plat_dev->dev, "Watchdog timeout!!");
 
-	mutex_lock(&dev->dev_ctx_lock);
+	spin_lock_irqsave(&dev->dev_ctx_lock, flags);
 	list_for_each_entry(ctx, &dev->ctx_list, list) {
 		ctx->state = MTK_STATE_ABORT;
 		mtk_v4l2_vdec_dbg(0, ctx, "[%d] Change to state MTK_STATE_ABORT", ctx->id);
 	}
-	mutex_unlock(&dev->dev_ctx_lock);
+	spin_unlock_irqrestore(&dev->dev_ctx_lock, flags);
 }
 
 static const struct mtk_vcodec_fw_ops mtk_vcodec_vpu_msg = {
diff --git a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.c b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.c
index 20c0b1acf618..69bd978e68a5 100644
--- a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.c
+++ b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.c
@@ -198,6 +198,7 @@ static int fops_vcodec_open(struct file *file)
 	struct mtk_vcodec_dec_ctx *ctx = NULL;
 	int ret = 0, i, hw_count;
 	struct vb2_queue *src_vq;
+	unsigned long flags;
 
 	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
 	if (!ctx)
@@ -268,9 +269,9 @@ static int fops_vcodec_open(struct file *file)
 
 	ctx->dev->vdec_pdata->init_vdec_params(ctx);
 
-	mutex_lock(&dev->dev_ctx_lock);
+	spin_lock_irqsave(&dev->dev_ctx_lock, flags);
 	list_add(&ctx->list, &dev->ctx_list);
-	mutex_unlock(&dev->dev_ctx_lock);
+	spin_unlock_irqrestore(&dev->dev_ctx_lock, flags);
 	mtk_vcodec_dbgfs_create(ctx);
 
 	mutex_unlock(&dev->dev_mutex);
@@ -295,6 +296,7 @@ static int fops_vcodec_release(struct file *file)
 {
 	struct mtk_vcodec_dec_dev *dev = video_drvdata(file);
 	struct mtk_vcodec_dec_ctx *ctx = fh_to_dec_ctx(file->private_data);
+	unsigned long flags;
 
 	mtk_v4l2_vdec_dbg(0, ctx, "[%d] decoder", ctx->id);
 	mutex_lock(&dev->dev_mutex);
@@ -313,9 +315,9 @@ static int fops_vcodec_release(struct file *file)
 	v4l2_ctrl_handler_free(&ctx->ctrl_hdl);
 
 	mtk_vcodec_dbgfs_remove(dev, ctx->id);
-	mutex_lock(&dev->dev_ctx_lock);
+	spin_lock_irqsave(&dev->dev_ctx_lock, flags);
 	list_del_init(&ctx->list);
-	mutex_unlock(&dev->dev_ctx_lock);
+	spin_unlock_irqrestore(&dev->dev_ctx_lock, flags);
 	kfree(ctx);
 	mutex_unlock(&dev->dev_mutex);
 	return 0;
@@ -382,7 +384,7 @@ static int mtk_vcodec_probe(struct platform_device *pdev)
 	for (i = 0; i < MTK_VDEC_HW_MAX; i++)
 		mutex_init(&dev->dec_mutex[i]);
 	mutex_init(&dev->dev_mutex);
-	mutex_init(&dev->dev_ctx_lock);
+	spin_lock_init(&dev->dev_ctx_lock);
 	spin_lock_init(&dev->irqlock);
 
 	snprintf(dev->v4l2_dev.name, sizeof(dev->v4l2_dev.name), "%s",
diff --git a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.h b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.h
index b3a59af7c8ac..255b011ed24f 100644
--- a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.h
+++ b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.h
@@ -271,7 +271,7 @@ struct mtk_vcodec_dec_dev {
 	/* decoder hardware mutex lock */
 	struct mutex dec_mutex[MTK_VDEC_HW_MAX];
 	struct mutex dev_mutex;
-	struct mutex dev_ctx_lock;
+	spinlock_t dev_ctx_lock;
 	struct workqueue_struct *decode_workqueue;
 
 	spinlock_t irqlock;
diff --git a/drivers/media/platform/mediatek/vcodec/decoder/vdec_vpu_if.c b/drivers/media/platform/mediatek/vcodec/decoder/vdec_vpu_if.c
index 145958206e38..40b97f114cf6 100644
--- a/drivers/media/platform/mediatek/vcodec/decoder/vdec_vpu_if.c
+++ b/drivers/media/platform/mediatek/vcodec/decoder/vdec_vpu_if.c
@@ -75,16 +75,17 @@ static void handle_get_param_msg_ack(const struct vdec_vpu_ipi_get_param_ack *ms
 static bool vpu_dec_check_ap_inst(struct mtk_vcodec_dec_dev *dec_dev, struct vdec_vpu_inst *vpu)
 {
 	struct mtk_vcodec_dec_ctx *ctx;
+	unsigned long flags;
 	int ret = false;
 
-	mutex_lock(&dec_dev->dev_ctx_lock);
+	spin_lock_irqsave(&dec_dev->dev_ctx_lock, flags);
 	list_for_each_entry(ctx, &dec_dev->ctx_list, list) {
 		if (!IS_ERR_OR_NULL(ctx) && ctx->vpu_inst == vpu) {
 			ret = true;
 			break;
 		}
 	}
-	mutex_unlock(&dec_dev->dev_ctx_lock);
+	spin_unlock_irqrestore(&dec_dev->dev_ctx_lock, flags);
 
 	return ret;
 }
diff --git a/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_drv.c b/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_drv.c
index 3cb8a1622222..6dcd6e904732 100644
--- a/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_drv.c
+++ b/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_drv.c
@@ -117,6 +117,7 @@ static int fops_vcodec_open(struct file *file)
 	struct mtk_vcodec_enc_ctx *ctx = NULL;
 	int ret = 0;
 	struct vb2_queue *src_vq;
+	unsigned long flags;
 
 	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
 	if (!ctx)
@@ -177,9 +178,9 @@ static int fops_vcodec_open(struct file *file)
 	mtk_v4l2_venc_dbg(2, ctx, "Create instance [%d]@%p m2m_ctx=%p ",
 			  ctx->id, ctx, ctx->m2m_ctx);
 
-	mutex_lock(&dev->dev_ctx_lock);
+	spin_lock_irqsave(&dev->dev_ctx_lock, flags);
 	list_add(&ctx->list, &dev->ctx_list);
-	mutex_unlock(&dev->dev_ctx_lock);
+	spin_unlock_irqrestore(&dev->dev_ctx_lock, flags);
 
 	mutex_unlock(&dev->dev_mutex);
 	mtk_v4l2_venc_dbg(0, ctx, "%s encoder [%d]", dev_name(&dev->plat_dev->dev),
@@ -204,6 +205,7 @@ static int fops_vcodec_release(struct file *file)
 {
 	struct mtk_vcodec_enc_dev *dev = video_drvdata(file);
 	struct mtk_vcodec_enc_ctx *ctx = fh_to_enc_ctx(file->private_data);
+	unsigned long flags;
 
 	mtk_v4l2_venc_dbg(1, ctx, "[%d] encoder", ctx->id);
 	mutex_lock(&dev->dev_mutex);
@@ -214,9 +216,9 @@ static int fops_vcodec_release(struct file *file)
 	v4l2_fh_exit(&ctx->fh);
 	v4l2_ctrl_handler_free(&ctx->ctrl_hdl);
 
-	mutex_lock(&dev->dev_ctx_lock);
+	spin_lock_irqsave(&dev->dev_ctx_lock, flags);
 	list_del_init(&ctx->list);
-	mutex_unlock(&dev->dev_ctx_lock);
+	spin_unlock_irqrestore(&dev->dev_ctx_lock, flags);
 	kfree(ctx);
 	mutex_unlock(&dev->dev_mutex);
 	return 0;
@@ -298,7 +300,7 @@ static int mtk_vcodec_probe(struct platform_device *pdev)
 
 	mutex_init(&dev->enc_mutex);
 	mutex_init(&dev->dev_mutex);
-	mutex_init(&dev->dev_ctx_lock);
+	spin_lock_init(&dev->dev_ctx_lock);
 	spin_lock_init(&dev->irqlock);
 
 	snprintf(dev->v4l2_dev.name, sizeof(dev->v4l2_dev.name), "%s",
diff --git a/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_drv.h b/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_drv.h
index 0bd85d0fb379..90b4f5ea0d6b 100644
--- a/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_drv.h
+++ b/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_drv.h
@@ -206,7 +206,7 @@ struct mtk_vcodec_enc_dev {
 	/* encoder hardware mutex lock */
 	struct mutex enc_mutex;
 	struct mutex dev_mutex;
-	struct mutex dev_ctx_lock;
+	spinlock_t dev_ctx_lock;
 	struct workqueue_struct *encode_workqueue;
 
 	int enc_irq;
diff --git a/drivers/media/platform/mediatek/vcodec/encoder/venc_vpu_if.c b/drivers/media/platform/mediatek/vcodec/encoder/venc_vpu_if.c
index 51bb7ee141b9..3c229b1f6b21 100644
--- a/drivers/media/platform/mediatek/vcodec/encoder/venc_vpu_if.c
+++ b/drivers/media/platform/mediatek/vcodec/encoder/venc_vpu_if.c
@@ -45,16 +45,17 @@ static void handle_enc_encode_msg(struct venc_vpu_inst *vpu, const void *data)
 static bool vpu_enc_check_ap_inst(struct mtk_vcodec_enc_dev *enc_dev, struct venc_vpu_inst *vpu)
 {
 	struct mtk_vcodec_enc_ctx *ctx;
+	unsigned long flags;
 	int ret = false;
 
-	mutex_lock(&enc_dev->dev_ctx_lock);
+	spin_lock_irqsave(&enc_dev->dev_ctx_lock, flags);
 	list_for_each_entry(ctx, &enc_dev->ctx_list, list) {
 		if (!IS_ERR_OR_NULL(ctx) && ctx->vpu_inst == vpu) {
 			ret = true;
 			break;
 		}
 	}
-	mutex_unlock(&enc_dev->dev_ctx_lock);
+	spin_unlock_irqrestore(&enc_dev->dev_ctx_lock, flags);
 
 	return ret;
 }
-- 
2.51.0


