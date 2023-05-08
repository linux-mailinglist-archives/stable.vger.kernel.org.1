Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC5B6FAAEE
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233051AbjEHLIA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233644AbjEHLHq (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:07:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D418E2E819
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:06:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 685C762AD2
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:06:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FAD3C433D2;
        Mon,  8 May 2023 11:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683544017;
        bh=uRG1Lne9p8ZLST3S39Ylke+Vn6pqUOoaaTR6c4xgeEs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uKgYDfZQLquIsVjLKYx6z3DMNvu7R/67i3P4NlzKpPQJfVdLaVf9r698f7ic+lfxK
         jK1/hNzmKoP/zV8q2VDk/y19vQfoimmvbfKfIUrU2lbWl3Jo3g4enGKpIP4dZS280m
         6+NJqe/3+soW8G4cqJLXwyyMD5LK1zCtKx4qwOts=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, kyrie wu <kyrie.wu@mediatek.com>,
        irui wang <irui.wang@mediatek.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 274/694] media: mtk-jpeg: Fixes jpeg enc&dec worker sw flow
Date:   Mon,  8 May 2023 11:41:49 +0200
Message-Id: <20230508094441.138312792@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: kyrie wu <kyrie.wu@mediatek.com>

[ Upstream commit 86379bd9d399e2c5fd638a869af223d4910725c3 ]

1. Move removing buffer after sw setting and before hw setting
in enc&dec worker to prevents the operation of removing
the buffer twice if the sw setting fails.
2. Remove the redundant operation of queue work in the
jpegenc irq handler because the jpegenc worker has called
v4l2_m2m_job_finish to do it.

Fixes: 5fb1c2361e56 ("mtk-jpegenc: add jpeg encode worker interface")
Fixes: dedc21500334 ("media: mtk-jpegdec: add jpeg decode worker interface")
Signed-off-by: kyrie wu <kyrie.wu@mediatek.com>
Signed-off-by: irui wang <irui.wang@mediatek.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../media/platform/mediatek/jpeg/mtk_jpeg_core.c   | 14 +++++++-------
 .../media/platform/mediatek/jpeg/mtk_jpeg_enc_hw.c |  4 ----
 2 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
index 6d052747a15e8..d9584fe5033eb 100644
--- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
+++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
@@ -1025,9 +1025,6 @@ static void mtk_jpegenc_worker(struct work_struct *work)
 	if (!dst_buf)
 		goto getbuf_fail;
 
-	v4l2_m2m_src_buf_remove(ctx->fh.m2m_ctx);
-	v4l2_m2m_dst_buf_remove(ctx->fh.m2m_ctx);
-
 	v4l2_m2m_buf_copy_metadata(src_buf, dst_buf, true);
 
 	mtk_jpegenc_set_hw_param(ctx, hw_id, src_buf, dst_buf);
@@ -1045,6 +1042,9 @@ static void mtk_jpegenc_worker(struct work_struct *work)
 		goto enc_end;
 	}
 
+	v4l2_m2m_src_buf_remove(ctx->fh.m2m_ctx);
+	v4l2_m2m_dst_buf_remove(ctx->fh.m2m_ctx);
+
 	schedule_delayed_work(&comp_jpeg[hw_id]->job_timeout_work,
 			      msecs_to_jiffies(MTK_JPEG_HW_TIMEOUT_MSEC));
 
@@ -1220,9 +1220,6 @@ static void mtk_jpegdec_worker(struct work_struct *work)
 	if (!dst_buf)
 		goto getbuf_fail;
 
-	v4l2_m2m_src_buf_remove(ctx->fh.m2m_ctx);
-	v4l2_m2m_dst_buf_remove(ctx->fh.m2m_ctx);
-
 	v4l2_m2m_buf_copy_metadata(src_buf, dst_buf, true);
 	jpeg_src_buf = mtk_jpeg_vb2_to_srcbuf(&src_buf->vb2_buf);
 	jpeg_dst_buf = mtk_jpeg_vb2_to_srcbuf(&dst_buf->vb2_buf);
@@ -1231,7 +1228,7 @@ static void mtk_jpegdec_worker(struct work_struct *work)
 					     &jpeg_src_buf->dec_param)) {
 		mtk_jpeg_queue_src_chg_event(ctx);
 		ctx->state = MTK_JPEG_SOURCE_CHANGE;
-		goto dec_end;
+		goto getbuf_fail;
 	}
 
 	jpeg_src_buf->curr_ctx = ctx;
@@ -1254,6 +1251,9 @@ static void mtk_jpegdec_worker(struct work_struct *work)
 		goto clk_end;
 	}
 
+	v4l2_m2m_src_buf_remove(ctx->fh.m2m_ctx);
+	v4l2_m2m_dst_buf_remove(ctx->fh.m2m_ctx);
+
 	schedule_delayed_work(&comp_jpeg[hw_id]->job_timeout_work,
 			      msecs_to_jiffies(MTK_JPEG_HW_TIMEOUT_MSEC));
 
diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_enc_hw.c b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_enc_hw.c
index 1bbb712d78d0e..867f4c1a09fa6 100644
--- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_enc_hw.c
+++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_enc_hw.c
@@ -286,10 +286,6 @@ static irqreturn_t mtk_jpegenc_hw_irq_handler(int irq, void *priv)
 	mtk_jpegenc_put_buf(jpeg);
 	pm_runtime_put(ctx->jpeg->dev);
 	clk_disable_unprepare(jpeg->venc_clk.clks->clk);
-	if (!list_empty(&ctx->fh.m2m_ctx->out_q_ctx.rdy_queue) ||
-	    !list_empty(&ctx->fh.m2m_ctx->cap_q_ctx.rdy_queue)) {
-		queue_work(master_jpeg->workqueue, &ctx->jpeg_work);
-	}
 
 	jpeg->hw_state = MTK_JPEG_HW_IDLE;
 	wake_up(&master_jpeg->enc_hw_wq);
-- 
2.39.2



