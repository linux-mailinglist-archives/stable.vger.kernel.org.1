Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 970F46FA76F
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234620AbjEHKaf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234674AbjEHKaV (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:30:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F989E72C
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:30:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B05F4626A8
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:30:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD61CC433EF;
        Mon,  8 May 2023 10:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683541816;
        bh=w/t2A4zVFzPFuF4F1zTVMPbkwgl6BgQv6xF64kcS2w8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fYaycLZwL3+8iDb3ijsWZwNpSPqSk7NsFuw5CKUyeaAYkmFtCFwZ59T0MTGOHOoTh
         /t0vuoPxqPtTU9OF96lvsdPai1DgUEEEWGa6gW2N5Ahl+mNYU0PO+MYw3qeSV9FL7E
         LRxL1PCagNxoGXf33u/qCT0uKb4ZrraAd1pTI1Ic=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Pin-yen Lin <treapking@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 234/663] media: mediatek: vcodec: Use 4K frame size when supported by stateful decoder
Date:   Mon,  8 May 2023 11:41:00 +0200
Message-Id: <20230508094435.881380194@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Pin-yen Lin <treapking@chromium.org>

[ Upstream commit e25528e1dbe52784ac250071653104a8adc848e2 ]

After commit b018be06f3c7 ("media: mediatek: vcodec: Read max resolution
from dec_capability"), the stateful video decoder driver never really
sets its output frame size to 4K.

Parse the decoder capability reported by the firmware, and update the
output frame size in mtk_init_vdec_params to enable 4K frame size when
available.

Fixes: b018be06f3c7 ("media: mediatek: vcodec: Read max resolution from dec_capability")
Signed-off-by: Pin-yen Lin <treapking@chromium.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../mediatek/vcodec/mtk_vcodec_dec_stateful.c        | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateful.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateful.c
index 035c86e7809fd..29991551cf614 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateful.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateful.c
@@ -11,7 +11,7 @@
 #include "mtk_vcodec_dec_pm.h"
 #include "vdec_drv_if.h"
 
-static const struct mtk_video_fmt mtk_video_formats[] = {
+static struct mtk_video_fmt mtk_video_formats[] = {
 	{
 		.fourcc = V4L2_PIX_FMT_H264,
 		.type = MTK_FMT_DEC,
@@ -580,6 +580,16 @@ static int mtk_vcodec_dec_ctrls_setup(struct mtk_vcodec_ctx *ctx)
 
 static void mtk_init_vdec_params(struct mtk_vcodec_ctx *ctx)
 {
+	unsigned int i;
+
+	if (!(ctx->dev->dec_capability & VCODEC_CAPABILITY_4K_DISABLED)) {
+		for (i = 0; i < num_supported_formats; i++) {
+			mtk_video_formats[i].frmsize.max_width =
+				VCODEC_DEC_4K_CODED_WIDTH;
+			mtk_video_formats[i].frmsize.max_height =
+				VCODEC_DEC_4K_CODED_HEIGHT;
+		}
+	}
 }
 
 static struct vb2_ops mtk_vdec_frame_vb2_ops = {
-- 
2.39.2



