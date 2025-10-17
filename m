Return-Path: <stable+bounces-186344-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C18BE9557
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 16:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53D4442755D
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 14:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED46C3370FE;
	Fri, 17 Oct 2025 14:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TYtp1Tcs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D793370FC
	for <stable@vger.kernel.org>; Fri, 17 Oct 2025 14:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760712544; cv=none; b=JbAmKZfLTMwxHRZOeotWIXZ1XOenpRyHkVM5w42xyUCV/MhR25GE6MHVDyMrGlNp5kXp7gFNqyTpeMxYe5VCIyNXuHQEdLGJS36OjRDQQPf92ONG+lFam0ZR9RXN9D1woyAQmC6bQE2IhvPcoTihlnU5Xvr9rKC0bA4i84+7H08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760712544; c=relaxed/simple;
	bh=WoUBdqFTE9UmV7ZhEnpi4eP0g5PbpFrqE+Jba5bnMV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PNlENoloZBD5eLjcrx+OYiaxYm5dMR5v09ItXrzfrFKQma0pyA0ni/EJaTdzoPmjK1iDtHmgjwAEs6RJr9adL7fyyfm4yMYndLz1MD1ZBZtNXDwZ0Qkkt0X6RZ7JSn8vaxmNTkVB+CaCFVNlte4JFMcUw2wBvRYDfoieDfRQLmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TYtp1Tcs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3129C4CEF9;
	Fri, 17 Oct 2025 14:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760712544;
	bh=WoUBdqFTE9UmV7ZhEnpi4eP0g5PbpFrqE+Jba5bnMV0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TYtp1TcsZJGI46mnKaprRkeayaAiSpMPmRQi8Urx9EqOOC4LwbUFTEB5CPepuM7jm
	 vwqNiHky6LQVkqOsFLBNaAeNq8odooWjjtz0Di2sDzXUjtyKDNSJNGj/ZlAtIIAJD4
	 jrBDHO/XCVHqUeUV6SR9lNUsCsB9kBasEBQzLV4XLribzmWwlHzH10zOeOKO2LZOmw
	 H2DBfMNFGL5DzIs7XrPYSc7VCBHxWKgDBYqmnALhb4QJP3POdAzkJ9J+tgAgGGJkzd
	 f0SD3Wav/BXCKd2eXDwbKMtfFxDtClOPTNgvfgIKPybZtiU1JO0jSwjqc3S70hAa9N
	 ZsXV88ZXaP6wQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Aakarsh Jain <aakarsh.jain@samsung.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/5] media: s5p-mfc: constify s5p_mfc_buf_size structures
Date: Fri, 17 Oct 2025 10:48:57 -0400
Message-ID: <20251017144900.4007781-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017144900.4007781-1-sashal@kernel.org>
References: <2025101646-overtake-starch-c0ab@gregkh>
 <20251017144900.4007781-1-sashal@kernel.org>
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
index 007c7dbee0377..5b42fa8d87a6a 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c
@@ -1503,14 +1503,14 @@ static const struct dev_pm_ops s5p_mfc_pm_ops = {
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
@@ -1527,7 +1527,7 @@ static struct s5p_mfc_variant mfc_drvdata_v5 = {
 	.use_clock_gating = true,
 };
 
-static struct s5p_mfc_buf_size_v6 mfc_buf_size_v6 = {
+static const struct s5p_mfc_buf_size_v6 mfc_buf_size_v6 = {
 	.dev_ctx	= MFC_CTX_BUF_SIZE_V6,
 	.h264_dec_ctx	= MFC_H264_DEC_CTX_BUF_SIZE_V6,
 	.other_dec_ctx	= MFC_OTHER_DEC_CTX_BUF_SIZE_V6,
@@ -1535,7 +1535,7 @@ static struct s5p_mfc_buf_size_v6 mfc_buf_size_v6 = {
 	.other_enc_ctx	= MFC_OTHER_ENC_CTX_BUF_SIZE_V6,
 };
 
-static struct s5p_mfc_buf_size buf_size_v6 = {
+static const struct s5p_mfc_buf_size buf_size_v6 = {
 	.fw	= MAX_FW_SIZE_V6,
 	.cpb	= MAX_CPB_SIZE_V6,
 	.priv	= &mfc_buf_size_v6,
@@ -1556,7 +1556,7 @@ static struct s5p_mfc_variant mfc_drvdata_v6 = {
 	.num_clocks	= 1,
 };
 
-static struct s5p_mfc_buf_size_v6 mfc_buf_size_v7 = {
+static const struct s5p_mfc_buf_size_v6 mfc_buf_size_v7 = {
 	.dev_ctx	= MFC_CTX_BUF_SIZE_V7,
 	.h264_dec_ctx	= MFC_H264_DEC_CTX_BUF_SIZE_V7,
 	.other_dec_ctx	= MFC_OTHER_DEC_CTX_BUF_SIZE_V7,
@@ -1564,7 +1564,7 @@ static struct s5p_mfc_buf_size_v6 mfc_buf_size_v7 = {
 	.other_enc_ctx	= MFC_OTHER_ENC_CTX_BUF_SIZE_V7,
 };
 
-static struct s5p_mfc_buf_size buf_size_v7 = {
+static const struct s5p_mfc_buf_size buf_size_v7 = {
 	.fw	= MAX_FW_SIZE_V7,
 	.cpb	= MAX_CPB_SIZE_V7,
 	.priv	= &mfc_buf_size_v7,
@@ -1590,7 +1590,7 @@ static struct s5p_mfc_variant mfc_drvdata_v7_3250 = {
 	.num_clocks     = 2,
 };
 
-static struct s5p_mfc_buf_size_v6 mfc_buf_size_v8 = {
+static const struct s5p_mfc_buf_size_v6 mfc_buf_size_v8 = {
 	.dev_ctx	= MFC_CTX_BUF_SIZE_V8,
 	.h264_dec_ctx	= MFC_H264_DEC_CTX_BUF_SIZE_V8,
 	.other_dec_ctx	= MFC_OTHER_DEC_CTX_BUF_SIZE_V8,
@@ -1598,7 +1598,7 @@ static struct s5p_mfc_buf_size_v6 mfc_buf_size_v8 = {
 	.other_enc_ctx	= MFC_OTHER_ENC_CTX_BUF_SIZE_V8,
 };
 
-static struct s5p_mfc_buf_size buf_size_v8 = {
+static const struct s5p_mfc_buf_size buf_size_v8 = {
 	.fw	= MAX_FW_SIZE_V8,
 	.cpb	= MAX_CPB_SIZE_V8,
 	.priv	= &mfc_buf_size_v8,
@@ -1624,7 +1624,7 @@ static struct s5p_mfc_variant mfc_drvdata_v8_5433 = {
 	.num_clocks	= 3,
 };
 
-static struct s5p_mfc_buf_size_v6 mfc_buf_size_v10 = {
+static const struct s5p_mfc_buf_size_v6 mfc_buf_size_v10 = {
 	.dev_ctx        = MFC_CTX_BUF_SIZE_V10,
 	.h264_dec_ctx   = MFC_H264_DEC_CTX_BUF_SIZE_V10,
 	.other_dec_ctx  = MFC_OTHER_DEC_CTX_BUF_SIZE_V10,
@@ -1633,7 +1633,7 @@ static struct s5p_mfc_buf_size_v6 mfc_buf_size_v10 = {
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


