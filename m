Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96FA66FAB1A
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233120AbjEHLJ7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233848AbjEHLJH (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:09:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 765CE3554B
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:09:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0BF1762B14
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:09:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03AC6C433D2;
        Mon,  8 May 2023 11:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683544142;
        bh=QpZGSFcUEdxc4V4AwY/r1ackKvIgcNwFVumQaCxvIpk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ib+v1FAgay55iK+cPfmXfotsk9l/A1MfzRdkh+5MJEyPbS/Tn5G/mrRmiRGLUSo56
         tzjvUN3ErFVFkw2vLmyqn0Yi4Gnq0Fk6b3l4fA3bFpdEKbxY2NPW6YsWBM/2gZM0vb
         W8b4NjlZYvjZygndeU3V1f91zjXGyidEnwj7WIwo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yunfei Dong <yunfei.dong@mediatek.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 283/694] media: mediatek: vcodec: making sure queue_work successfully
Date:   Mon,  8 May 2023 11:41:58 +0200
Message-Id: <20230508094441.478591712@linuxfoundation.org>
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

From: Yunfei Dong <yunfei.dong@mediatek.com>

[ Upstream commit 2e0ef56d81cb2569624d288b7e95a8a2734a7c74 ]

Putting core work to work queue using queue_work maybe fail, call
queue_work again when the count of core work in work queue is less
than core_list_cnt, making sure all the buffer in core list can be
scheduled.

Fixes: 365e4ba01df4 ("media: mtk-vcodec: Add work queue for core hardware decode")
Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../platform/mediatek/vcodec/vdec_msg_queue.c | 31 ++++++++++++++-----
 .../platform/mediatek/vcodec/vdec_msg_queue.h |  2 ++
 2 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c b/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c
index cdc539a46cb95..f3073d1e7f420 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c
+++ b/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c
@@ -71,6 +71,7 @@ static void vdec_msg_queue_dec(struct vdec_msg_queue *msg_queue, int hardware_in
 int vdec_msg_queue_qbuf(struct vdec_msg_queue_ctx *msg_ctx, struct vdec_lat_buf *buf)
 {
 	struct list_head *head;
+	int status;
 
 	head = vdec_get_buf_list(msg_ctx->hardware_index, buf);
 	if (!head) {
@@ -83,11 +84,17 @@ int vdec_msg_queue_qbuf(struct vdec_msg_queue_ctx *msg_ctx, struct vdec_lat_buf
 	msg_ctx->ready_num++;
 
 	vdec_msg_queue_inc(&buf->ctx->msg_queue, msg_ctx->hardware_index);
-	if (msg_ctx->hardware_index != MTK_VDEC_CORE)
+	if (msg_ctx->hardware_index != MTK_VDEC_CORE) {
 		wake_up_all(&msg_ctx->ready_to_use);
-	else
-		queue_work(buf->ctx->dev->core_workqueue,
-			   &buf->ctx->msg_queue.core_work);
+	} else {
+		if (buf->ctx->msg_queue.core_work_cnt <
+			atomic_read(&buf->ctx->msg_queue.core_list_cnt)) {
+			status = queue_work(buf->ctx->dev->core_workqueue,
+					    &buf->ctx->msg_queue.core_work);
+			if (status)
+				buf->ctx->msg_queue.core_work_cnt++;
+		}
+	}
 
 	mtk_v4l2_debug(3, "enqueue buf type: %d addr: 0x%p num: %d",
 		       msg_ctx->hardware_index, buf, msg_ctx->ready_num);
@@ -254,6 +261,7 @@ static void vdec_msg_queue_core_work(struct work_struct *work)
 		container_of(msg_queue, struct mtk_vcodec_ctx, msg_queue);
 	struct mtk_vcodec_dev *dev = ctx->dev;
 	struct vdec_lat_buf *lat_buf;
+	int status;
 
 	lat_buf = vdec_msg_queue_dqbuf(&dev->msg_queue_core_ctx);
 	if (!lat_buf)
@@ -270,11 +278,17 @@ static void vdec_msg_queue_core_work(struct work_struct *work)
 	vdec_msg_queue_qbuf(&ctx->msg_queue.lat_ctx, lat_buf);
 
 	wake_up_all(&ctx->msg_queue.core_dec_done);
-	if (atomic_read(&lat_buf->ctx->msg_queue.core_list_cnt)) {
-		mtk_v4l2_debug(3, "re-schedule to decode for core: %d",
-			       dev->msg_queue_core_ctx.ready_num);
-		queue_work(dev->core_workqueue, &msg_queue->core_work);
+	spin_lock(&dev->msg_queue_core_ctx.ready_lock);
+	lat_buf->ctx->msg_queue.core_work_cnt--;
+
+	if (lat_buf->ctx->msg_queue.core_work_cnt <
+		atomic_read(&lat_buf->ctx->msg_queue.core_list_cnt)) {
+		status = queue_work(lat_buf->ctx->dev->core_workqueue,
+				    &lat_buf->ctx->msg_queue.core_work);
+		if (status)
+			lat_buf->ctx->msg_queue.core_work_cnt++;
 	}
+	spin_unlock(&dev->msg_queue_core_ctx.ready_lock);
 }
 
 int vdec_msg_queue_init(struct vdec_msg_queue *msg_queue,
@@ -289,6 +303,7 @@ int vdec_msg_queue_init(struct vdec_msg_queue *msg_queue,
 		return 0;
 
 	msg_queue->ctx = ctx;
+	msg_queue->core_work_cnt = 0;
 	vdec_msg_queue_init_ctx(&msg_queue->lat_ctx, MTK_VDEC_LAT0);
 	INIT_WORK(&msg_queue->core_work, vdec_msg_queue_core_work);
 
diff --git a/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.h b/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.h
index a75c04418f52e..a5d44bc97c16b 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.h
+++ b/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.h
@@ -77,6 +77,7 @@ struct vdec_lat_buf {
  * @lat_list_cnt: used to record each instance lat list count
  * @core_list_cnt: used to record each instance core list count
  * @core_dec_done: core work queue decode done event
+ * @core_work_cnt: the number of core work in work queue
  */
 struct vdec_msg_queue {
 	struct vdec_lat_buf lat_buf[NUM_BUFFER_COUNT];
@@ -92,6 +93,7 @@ struct vdec_msg_queue {
 	atomic_t lat_list_cnt;
 	atomic_t core_list_cnt;
 	wait_queue_head_t core_dec_done;
+	int core_work_cnt;
 };
 
 /**
-- 
2.39.2



