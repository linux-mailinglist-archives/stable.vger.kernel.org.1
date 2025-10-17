Return-Path: <stable+bounces-186334-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C673EBE9362
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 16:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A9123A8384
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 14:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A012F692B;
	Fri, 17 Oct 2025 14:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SA9YWphc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403242C3244
	for <stable@vger.kernel.org>; Fri, 17 Oct 2025 14:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760711532; cv=none; b=H/2QNmokMlse9feCXNx2UB9SKkWTYtxQlMGwSr5hYUXKZWnbZqn3Kl/BeCncrJg9YpUEkhDmognxjHnp4UIbg3Ivc5/ZjVshKAuE2DzC8m2ai65LWZ/dVTfl7S/RA+piVPk2gtbWca1CLCqV1NLPTQOFrV8wp3GvarHwu5WolCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760711532; c=relaxed/simple;
	bh=EyHh8zep6oSiFV1viJmzsrXIzsF4bCIqUm8a00qt+DI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Typ3NDqMn83axjtqheFC7xK7NktUBk7Ikdsrqev7i/9z4h+7F/GipLZFDch9UGzxKNM8f6BelbPBvkwUtoMHLgIYHi5HhFJtqvew/MS7bYunRQDF9meA2MgfeaAyneddBpKQTkhLYt8yew6o+LpFd+EomAH/0o81uEW08SlbSZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SA9YWphc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2986AC4CEFE;
	Fri, 17 Oct 2025 14:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760711531;
	bh=EyHh8zep6oSiFV1viJmzsrXIzsF4bCIqUm8a00qt+DI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SA9YWphcfkw4EYUMV8rdK2ni/Dvv7mhgCuomjaMOOI5d/UUVmBV7a9n5kMeK0Jpmz
	 D7xg7mwbiXkzF77/tJphsvqWTrk6JhBM0Xy70m44h0v2frIspHF7iyXE3cGHJ4kCTM
	 sqHNSm2JK8UnyfXmiVkZXkAoI8vu+NMex8EsosbmXT28nQaVS0ZDss6k4eZYNNfUXK
	 wZbCRiht1ojhpsoZSw/Pejec11t3AGhCrqzpJSECmjaLCSpgSWdK0xUsuusbPZBj9f
	 K4D2E290/jvKUdvPrJL/vX44L2QRlk8Ed7IHmBm+WRl9pOBd7qggoi51znCxEagDiU
	 WmnAxsxa00INg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Aakarsh Jain <aakarsh.jain@samsung.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/5] media: s5p-mfc: constify s5p_mfc_buf_size structures
Date: Fri, 17 Oct 2025 10:32:05 -0400
Message-ID: <20251017143208.3997488-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017143208.3997488-1-sashal@kernel.org>
References: <2025101646-unfunded-bootlace-0264@gregkh>
 <20251017143208.3997488-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit e8cc4c0bc2a660fed4ad57be6635d88ccc490a05 ]

Static "s5p_mfc_buf_size*" structures are not modified by the driver, so
they can be made const for code safety.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Aakarsh Jain <aakarsh.jain@samsung.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Stable-dep-of: 7fa37ba25a1d ("media: s5p-mfc: remove an unused/uninitialized variable")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../media/platform/samsung/s5p-mfc/s5p_mfc.c  | 20 +++++++++----------
 .../platform/samsung/s5p-mfc/s5p_mfc_cmd_v6.c |  2 +-
 .../platform/samsung/s5p-mfc/s5p_mfc_common.h |  4 ++--
 .../platform/samsung/s5p-mfc/s5p_mfc_dec.c    |  2 +-
 .../platform/samsung/s5p-mfc/s5p_mfc_opr_v5.c |  6 +++---
 .../platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c |  6 +++---
 6 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c
index e30e54935d79a..6af7b812c5df1 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c
@@ -1516,14 +1516,14 @@ static const struct dev_pm_ops s5p_mfc_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(s5p_mfc_suspend, s5p_mfc_resume)
 };
 
-static struct s5p_mfc_buf_size_v5 mfc_buf_size_v5 = {
+static const struct s5p_mfc_buf_size_v5 mfc_buf_size_v5 = {
 	.h264_ctx	= MFC_H264_CTX_BUF_SIZE,
 	.non_h264_ctx	= MFC_CTX_BUF_SIZE,
 	.dsc		= DESC_BUF_SIZE,
 	.shm		= SHARED_BUF_SIZE,
 };
 
-static struct s5p_mfc_buf_size buf_size_v5 = {
+static const struct s5p_mfc_buf_size buf_size_v5 = {
 	.fw	= MAX_FW_SIZE,
 	.cpb	= MAX_CPB_SIZE,
 	.priv	= &mfc_buf_size_v5,
@@ -1540,7 +1540,7 @@ static struct s5p_mfc_variant mfc_drvdata_v5 = {
 	.use_clock_gating = true,
 };
 
-static struct s5p_mfc_buf_size_v6 mfc_buf_size_v6 = {
+static const struct s5p_mfc_buf_size_v6 mfc_buf_size_v6 = {
 	.dev_ctx	= MFC_CTX_BUF_SIZE_V6,
 	.h264_dec_ctx	= MFC_H264_DEC_CTX_BUF_SIZE_V6,
 	.other_dec_ctx	= MFC_OTHER_DEC_CTX_BUF_SIZE_V6,
@@ -1548,7 +1548,7 @@ static struct s5p_mfc_buf_size_v6 mfc_buf_size_v6 = {
 	.other_enc_ctx	= MFC_OTHER_ENC_CTX_BUF_SIZE_V6,
 };
 
-static struct s5p_mfc_buf_size buf_size_v6 = {
+static const struct s5p_mfc_buf_size buf_size_v6 = {
 	.fw	= MAX_FW_SIZE_V6,
 	.cpb	= MAX_CPB_SIZE_V6,
 	.priv	= &mfc_buf_size_v6,
@@ -1569,7 +1569,7 @@ static struct s5p_mfc_variant mfc_drvdata_v6 = {
 	.num_clocks	= 1,
 };
 
-static struct s5p_mfc_buf_size_v6 mfc_buf_size_v7 = {
+static const struct s5p_mfc_buf_size_v6 mfc_buf_size_v7 = {
 	.dev_ctx	= MFC_CTX_BUF_SIZE_V7,
 	.h264_dec_ctx	= MFC_H264_DEC_CTX_BUF_SIZE_V7,
 	.other_dec_ctx	= MFC_OTHER_DEC_CTX_BUF_SIZE_V7,
@@ -1577,7 +1577,7 @@ static struct s5p_mfc_buf_size_v6 mfc_buf_size_v7 = {
 	.other_enc_ctx	= MFC_OTHER_ENC_CTX_BUF_SIZE_V7,
 };
 
-static struct s5p_mfc_buf_size buf_size_v7 = {
+static const struct s5p_mfc_buf_size buf_size_v7 = {
 	.fw	= MAX_FW_SIZE_V7,
 	.cpb	= MAX_CPB_SIZE_V7,
 	.priv	= &mfc_buf_size_v7,
@@ -1603,7 +1603,7 @@ static struct s5p_mfc_variant mfc_drvdata_v7_3250 = {
 	.num_clocks     = 2,
 };
 
-static struct s5p_mfc_buf_size_v6 mfc_buf_size_v8 = {
+static const struct s5p_mfc_buf_size_v6 mfc_buf_size_v8 = {
 	.dev_ctx	= MFC_CTX_BUF_SIZE_V8,
 	.h264_dec_ctx	= MFC_H264_DEC_CTX_BUF_SIZE_V8,
 	.other_dec_ctx	= MFC_OTHER_DEC_CTX_BUF_SIZE_V8,
@@ -1611,7 +1611,7 @@ static struct s5p_mfc_buf_size_v6 mfc_buf_size_v8 = {
 	.other_enc_ctx	= MFC_OTHER_ENC_CTX_BUF_SIZE_V8,
 };
 
-static struct s5p_mfc_buf_size buf_size_v8 = {
+static const struct s5p_mfc_buf_size buf_size_v8 = {
 	.fw	= MAX_FW_SIZE_V8,
 	.cpb	= MAX_CPB_SIZE_V8,
 	.priv	= &mfc_buf_size_v8,
@@ -1637,7 +1637,7 @@ static struct s5p_mfc_variant mfc_drvdata_v8_5433 = {
 	.num_clocks	= 3,
 };
 
-static struct s5p_mfc_buf_size_v6 mfc_buf_size_v10 = {
+static const struct s5p_mfc_buf_size_v6 mfc_buf_size_v10 = {
 	.dev_ctx        = MFC_CTX_BUF_SIZE_V10,
 	.h264_dec_ctx   = MFC_H264_DEC_CTX_BUF_SIZE_V10,
 	.other_dec_ctx  = MFC_OTHER_DEC_CTX_BUF_SIZE_V10,
@@ -1646,7 +1646,7 @@ static struct s5p_mfc_buf_size_v6 mfc_buf_size_v10 = {
 	.other_enc_ctx  = MFC_OTHER_ENC_CTX_BUF_SIZE_V10,
 };
 
-static struct s5p_mfc_buf_size buf_size_v10 = {
+static const struct s5p_mfc_buf_size buf_size_v10 = {
 	.fw     = MAX_FW_SIZE_V10,
 	.cpb    = MAX_CPB_SIZE_V10,
 	.priv   = &mfc_buf_size_v10,
diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd_v6.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd_v6.c
index f8588e52dfc82..25c4719a5dd05 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd_v6.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd_v6.c
@@ -32,7 +32,7 @@ static int s5p_mfc_cmd_host2risc_v6(struct s5p_mfc_dev *dev, int cmd,
 static int s5p_mfc_sys_init_cmd_v6(struct s5p_mfc_dev *dev)
 {
 	struct s5p_mfc_cmd_args h2r_args;
-	struct s5p_mfc_buf_size_v6 *buf_size = dev->variant->buf_size->priv;
+	const struct s5p_mfc_buf_size_v6 *buf_size = dev->variant->buf_size->priv;
 	int ret;
 
 	ret = s5p_mfc_hw_call(dev->mfc_ops, alloc_dev_context_buffer, dev);
diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h
index f33a755327ef0..6a47f3434c60d 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h
@@ -219,14 +219,14 @@ struct s5p_mfc_buf_size_v6 {
 struct s5p_mfc_buf_size {
 	unsigned int fw;
 	unsigned int cpb;
-	void *priv;
+	const void *priv;
 };
 
 struct s5p_mfc_variant {
 	unsigned int version;
 	unsigned int port_num;
 	u32 version_bit;
-	struct s5p_mfc_buf_size *buf_size;
+	const struct s5p_mfc_buf_size *buf_size;
 	const char	*fw_name[MFC_FW_MAX_VERSIONS];
 	const char	*clk_names[MFC_MAX_CLOCKS];
 	int		num_clocks;
diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_dec.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_dec.c
index 268ffe4da53c0..4dbe8792ac3d7 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_dec.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_dec.c
@@ -426,7 +426,7 @@ static int vidioc_s_fmt(struct file *file, void *priv, struct v4l2_format *f)
 	struct s5p_mfc_ctx *ctx = fh_to_ctx(priv);
 	int ret = 0;
 	struct v4l2_pix_format_mplane *pix_mp;
-	struct s5p_mfc_buf_size *buf_size = dev->variant->buf_size;
+	const struct s5p_mfc_buf_size *buf_size = dev->variant->buf_size;
 
 	mfc_debug_enter();
 	ret = vidioc_try_fmt(file, priv, f);
diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v5.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v5.c
index 28a06dc343fd5..13a3ff55e5479 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v5.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v5.c
@@ -34,7 +34,7 @@
 static int s5p_mfc_alloc_dec_temp_buffers_v5(struct s5p_mfc_ctx *ctx)
 {
 	struct s5p_mfc_dev *dev = ctx->dev;
-	struct s5p_mfc_buf_size_v5 *buf_size = dev->variant->buf_size->priv;
+	const struct s5p_mfc_buf_size_v5 *buf_size = dev->variant->buf_size->priv;
 	int ret;
 
 	ctx->dsc.size = buf_size->dsc;
@@ -200,7 +200,7 @@ static void s5p_mfc_release_codec_buffers_v5(struct s5p_mfc_ctx *ctx)
 static int s5p_mfc_alloc_instance_buffer_v5(struct s5p_mfc_ctx *ctx)
 {
 	struct s5p_mfc_dev *dev = ctx->dev;
-	struct s5p_mfc_buf_size_v5 *buf_size = dev->variant->buf_size->priv;
+	const struct s5p_mfc_buf_size_v5 *buf_size = dev->variant->buf_size->priv;
 	int ret;
 
 	if (ctx->codec_mode == S5P_MFC_CODEC_H264_DEC ||
@@ -345,7 +345,7 @@ static void s5p_mfc_enc_calc_src_size_v5(struct s5p_mfc_ctx *ctx)
 static void s5p_mfc_set_dec_desc_buffer(struct s5p_mfc_ctx *ctx)
 {
 	struct s5p_mfc_dev *dev = ctx->dev;
-	struct s5p_mfc_buf_size_v5 *buf_size = dev->variant->buf_size->priv;
+	const struct s5p_mfc_buf_size_v5 *buf_size = dev->variant->buf_size->priv;
 
 	mfc_write(dev, OFFSETA(ctx->dsc.dma), S5P_FIMV_SI_CH0_DESC_ADR);
 	mfc_write(dev, buf_size->dsc, S5P_FIMV_SI_CH0_DESC_SIZE);
diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
index c0df5ac9fcff2..70a62400908ed 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
@@ -333,7 +333,7 @@ static void s5p_mfc_release_codec_buffers_v6(struct s5p_mfc_ctx *ctx)
 static int s5p_mfc_alloc_instance_buffer_v6(struct s5p_mfc_ctx *ctx)
 {
 	struct s5p_mfc_dev *dev = ctx->dev;
-	struct s5p_mfc_buf_size_v6 *buf_size = dev->variant->buf_size->priv;
+	const struct s5p_mfc_buf_size_v6 *buf_size = dev->variant->buf_size->priv;
 	int ret;
 
 	mfc_debug_enter();
@@ -393,7 +393,7 @@ static void s5p_mfc_release_instance_buffer_v6(struct s5p_mfc_ctx *ctx)
 /* Allocate context buffers for SYS_INIT */
 static int s5p_mfc_alloc_dev_context_buffer_v6(struct s5p_mfc_dev *dev)
 {
-	struct s5p_mfc_buf_size_v6 *buf_size = dev->variant->buf_size->priv;
+	const struct s5p_mfc_buf_size_v6 *buf_size = dev->variant->buf_size->priv;
 	int ret;
 
 	mfc_debug_enter();
@@ -493,7 +493,7 @@ static int s5p_mfc_set_dec_stream_buffer_v6(struct s5p_mfc_ctx *ctx,
 {
 	struct s5p_mfc_dev *dev = ctx->dev;
 	const struct s5p_mfc_regs *mfc_regs = dev->mfc_regs;
-	struct s5p_mfc_buf_size *buf_size = dev->variant->buf_size;
+	const struct s5p_mfc_buf_size *buf_size = dev->variant->buf_size;
 
 	mfc_debug_enter();
 	mfc_debug(2, "inst_no: %d, buf_addr: 0x%08x,\n"
-- 
2.51.0


