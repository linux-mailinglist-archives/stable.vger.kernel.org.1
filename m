Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3A356FA775
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234640AbjEHKao (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234659AbjEHKai (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:30:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E608DDBB
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:30:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 10C5C626BF
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:30:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ED2FC433EF;
        Mon,  8 May 2023 10:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683541835;
        bh=CIfkJ5Fha7/jTtp3HM3tKXjHJs6hs//vl1SArvHw+fc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p4aQEZjcUZx4PJUZsG/tC6RyBXTkrsrs2n2wUAE51putgp7PM4slZsSY5i5RalrDv
         GrfAu9jsiwgB4LleSpdkYgYkF7OwUa95SIXL8FrZATvD+zQhwVxBq1I9eT3RzAqwsN
         GEi9UmZeEt2ZhyDwSkJZwi8A9Rt/z+OFMHIYPOvE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yunfei Dong <yunfei.dong@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 240/663] media: mediatek: vcodec: add core decode done event
Date:   Mon,  8 May 2023 11:41:06 +0200
Message-Id: <20230508094436.074090117@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
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

From: Yunfei Dong <yunfei.dong@mediatek.com>

[ Upstream commit d227af847ac2d7d90350124a1b2451e4fc1f050c ]

Need to make sure core decode done before current instance is free.

Fixes: 365e4ba01df4 ("media: mtk-vcodec: Add work queue for core hardware decode")
Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c | 4 +++-
 drivers/media/platform/mediatek/vcodec/vdec_msg_queue.h | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c b/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c
index 0da6e3e2ef0b3..ce7c82e38103a 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c
+++ b/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c
@@ -196,7 +196,7 @@ bool vdec_msg_queue_wait_lat_buf_full(struct vdec_msg_queue *msg_queue)
 	spin_unlock(&core_ctx->ready_lock);
 
 	timeout_jiff = msecs_to_jiffies(1000 * (NUM_BUFFER_COUNT + 2));
-	ret = wait_event_timeout(msg_queue->lat_ctx.ready_to_use,
+	ret = wait_event_timeout(msg_queue->ctx->msg_queue.core_dec_done,
 				 msg_queue->lat_ctx.ready_num == NUM_BUFFER_COUNT,
 				 timeout_jiff);
 	if (ret) {
@@ -257,6 +257,7 @@ static void vdec_msg_queue_core_work(struct work_struct *work)
 	mtk_vcodec_dec_disable_hardware(ctx, MTK_VDEC_CORE);
 	vdec_msg_queue_qbuf(&ctx->msg_queue.lat_ctx, lat_buf);
 
+	wake_up_all(&ctx->msg_queue.core_dec_done);
 	if (atomic_read(&lat_buf->ctx->msg_queue.core_list_cnt)) {
 		mtk_v4l2_debug(3, "re-schedule to decode for core: %d",
 			       dev->msg_queue_core_ctx.ready_num);
@@ -281,6 +282,7 @@ int vdec_msg_queue_init(struct vdec_msg_queue *msg_queue,
 
 	atomic_set(&msg_queue->lat_list_cnt, 0);
 	atomic_set(&msg_queue->core_list_cnt, 0);
+	init_waitqueue_head(&msg_queue->core_dec_done);
 
 	msg_queue->wdma_addr.size =
 		vde_msg_queue_get_trans_size(ctx->picinfo.buf_w,
diff --git a/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.h b/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.h
index 56280d6682c5a..a75c04418f52e 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.h
+++ b/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.h
@@ -76,6 +76,7 @@ struct vdec_lat_buf {
  *
  * @lat_list_cnt: used to record each instance lat list count
  * @core_list_cnt: used to record each instance core list count
+ * @core_dec_done: core work queue decode done event
  */
 struct vdec_msg_queue {
 	struct vdec_lat_buf lat_buf[NUM_BUFFER_COUNT];
@@ -90,6 +91,7 @@ struct vdec_msg_queue {
 
 	atomic_t lat_list_cnt;
 	atomic_t core_list_cnt;
+	wait_queue_head_t core_dec_done;
 };
 
 /**
-- 
2.39.2



