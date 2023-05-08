Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 732B76FA495
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233904AbjEHKBG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233912AbjEHKBE (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:01:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA3632E041
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:01:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 71F04622B6
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:01:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A5F3C433EF;
        Mon,  8 May 2023 10:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683540061;
        bh=V6c7x2Bkf/H7GdclbSjZoJir9+56LWuFk27QSP9RJfU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zLz5qZAfnhJey8p6Ksclm7beDaiH4MnvyMjHvvxXqAxSH1A4J6yjzLdz1IEeTl8oE
         3C8mTJyoPmneuTmcwmCyjsN+K5q7u8GdD515S4IYSY8k1IUSHowh9JJZcYeRIOfAI0
         kwYpcGJ0aP2Hob65hrM4AKssRAp9i0UckffI7zmw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yunfei Dong <yunfei.dong@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 226/611] media: mediatek: vcodec: add params to record lat and core lat_buf count
Date:   Mon,  8 May 2023 11:41:08 +0200
Message-Id: <20230508094429.758614459@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
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

[ Upstream commit 5bbb6e2ca67477ab41163b32e6b3444faea74a5e ]

Using lat_buf to share decoder information between lat and core work
queue, adding params to record the buf count.

Fixes: 365e4ba01df4 ("media: mtk-vcodec: Add work queue for core hardware decode")
Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../platform/mediatek/vcodec/vdec_msg_queue.c | 23 ++++++++++++++++++-
 .../platform/mediatek/vcodec/vdec_msg_queue.h |  6 +++++
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c b/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c
index dc2004790a472..3f016c87d722c 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c
+++ b/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c
@@ -52,6 +52,22 @@ static struct list_head *vdec_get_buf_list(int hardware_index, struct vdec_lat_b
 	}
 }
 
+static void vdec_msg_queue_inc(struct vdec_msg_queue *msg_queue, int hardware_index)
+{
+	if (hardware_index == MTK_VDEC_CORE)
+		atomic_inc(&msg_queue->core_list_cnt);
+	else
+		atomic_inc(&msg_queue->lat_list_cnt);
+}
+
+static void vdec_msg_queue_dec(struct vdec_msg_queue *msg_queue, int hardware_index)
+{
+	if (hardware_index == MTK_VDEC_CORE)
+		atomic_dec(&msg_queue->core_list_cnt);
+	else
+		atomic_dec(&msg_queue->lat_list_cnt);
+}
+
 int vdec_msg_queue_qbuf(struct vdec_msg_queue_ctx *msg_ctx, struct vdec_lat_buf *buf)
 {
 	struct list_head *head;
@@ -66,6 +82,7 @@ int vdec_msg_queue_qbuf(struct vdec_msg_queue_ctx *msg_ctx, struct vdec_lat_buf
 	list_add_tail(head, &msg_ctx->ready_queue);
 	msg_ctx->ready_num++;
 
+	vdec_msg_queue_inc(&buf->ctx->msg_queue, msg_ctx->hardware_index);
 	if (msg_ctx->hardware_index != MTK_VDEC_CORE)
 		wake_up_all(&msg_ctx->ready_to_use);
 	else
@@ -127,6 +144,7 @@ struct vdec_lat_buf *vdec_msg_queue_dqbuf(struct vdec_msg_queue_ctx *msg_ctx)
 		return NULL;
 	}
 	list_del(head);
+	vdec_msg_queue_dec(&buf->ctx->msg_queue, msg_ctx->hardware_index);
 
 	msg_ctx->ready_num--;
 	mtk_v4l2_debug(3, "dqueue buf type:%d addr: 0x%p num: %d",
@@ -241,10 +259,13 @@ int vdec_msg_queue_init(struct vdec_msg_queue *msg_queue,
 
 	vdec_msg_queue_init_ctx(&msg_queue->lat_ctx, MTK_VDEC_LAT0);
 	INIT_WORK(&msg_queue->core_work, vdec_msg_queue_core_work);
+
+	atomic_set(&msg_queue->lat_list_cnt, 0);
+	atomic_set(&msg_queue->core_list_cnt, 0);
+
 	msg_queue->wdma_addr.size =
 		vde_msg_queue_get_trans_size(ctx->picinfo.buf_w,
 					     ctx->picinfo.buf_h);
-
 	err = mtk_vcodec_mem_alloc(ctx, &msg_queue->wdma_addr);
 	if (err) {
 		mtk_v4l2_err("failed to allocate wdma_addr buf");
diff --git a/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.h b/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.h
index c43d427f5f544..b1aa5572ba49f 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.h
+++ b/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.h
@@ -72,6 +72,9 @@ struct vdec_lat_buf {
  * @wdma_wptr_addr: ube write point
  * @core_work: core hardware work
  * @lat_ctx: used to store lat buffer list
+ *
+ * @lat_list_cnt: used to record each instance lat list count
+ * @core_list_cnt: used to record each instance core list count
  */
 struct vdec_msg_queue {
 	struct vdec_lat_buf lat_buf[NUM_BUFFER_COUNT];
@@ -82,6 +85,9 @@ struct vdec_msg_queue {
 
 	struct work_struct core_work;
 	struct vdec_msg_queue_ctx lat_ctx;
+
+	atomic_t lat_list_cnt;
+	atomic_t core_list_cnt;
 };
 
 /**
-- 
2.39.2



