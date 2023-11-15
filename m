Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 101D27ECD65
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234517AbjKOTgR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:36:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234472AbjKOTgO (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:36:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D0B1A7
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:36:11 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 948C8C433C8;
        Wed, 15 Nov 2023 19:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076970;
        bh=TgGA0d7XkXWmWjDGXa+LZG+M75GX+avwMxDQr/1r/8c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P73OO/LWRoVLaolfIQwLbsBRjwbw6EVCTUB22KbvkW8V7wTLiq+yUmL6xhxvZMHzH
         1lGa205Jc6ApnQLz9PX1bTlDwLzwisB26v1fXAcq960XWJ1nml8xe8k6t1UBFlzGJ9
         ppGLsn+KHfTny/Gmm6cIT4ud9FPUAH/maKUbaj3w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Fei Shao <fshao@chromium.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 479/550] media: mtk-jpegenc: Fix bug in JPEG encode quality selection
Date:   Wed, 15 Nov 2023 14:17:43 -0500
Message-ID: <20231115191634.070209148@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Fei Shao <fshao@chromium.org>

[ Upstream commit 0aeccc63f3bc4cfd49dc4893da1409402ee6b295 ]

The driver uses the upper-bound approach to decide the target JPEG
encode quality, but there's a logic bug that if the desired quality is
higher than what the driver can support, the driver falls back to using
the worst quality.

Fix the bug by assuming using the best quality in the beginning, and
with trivial refactor to avoid long lines.

Fixes: 45f13a57d813 ("media: platform: Add jpeg enc feature")
Signed-off-by: Fei Shao <fshao@chromium.org>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/mediatek/jpeg/mtk_jpeg_enc_hw.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_enc_hw.c b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_enc_hw.c
index 244018365b6f1..03ee8f93bd467 100644
--- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_enc_hw.c
+++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_enc_hw.c
@@ -127,6 +127,7 @@ void mtk_jpeg_set_enc_params(struct mtk_jpeg_ctx *ctx,  void __iomem *base)
 	u32 img_stride;
 	u32 mem_stride;
 	u32 i, enc_quality;
+	u32 nr_enc_quality = ARRAY_SIZE(mtk_jpeg_enc_quality);
 
 	value = width << 16 | height;
 	writel(value, base + JPEG_ENC_IMG_SIZE);
@@ -157,8 +158,8 @@ void mtk_jpeg_set_enc_params(struct mtk_jpeg_ctx *ctx,  void __iomem *base)
 	writel(img_stride, base + JPEG_ENC_IMG_STRIDE);
 	writel(mem_stride, base + JPEG_ENC_STRIDE);
 
-	enc_quality = mtk_jpeg_enc_quality[0].hardware_value;
-	for (i = 0; i < ARRAY_SIZE(mtk_jpeg_enc_quality); i++) {
+	enc_quality = mtk_jpeg_enc_quality[nr_enc_quality - 1].hardware_value;
+	for (i = 0; i < nr_enc_quality; i++) {
 		if (ctx->enc_quality <= mtk_jpeg_enc_quality[i].quality_param) {
 			enc_quality = mtk_jpeg_enc_quality[i].hardware_value;
 			break;
-- 
2.42.0



