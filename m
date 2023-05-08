Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDA036FA49A
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233899AbjEHKBS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233907AbjEHKBR (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:01:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9998D2E04D
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:01:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F092622C3
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:01:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 211DDC433D2;
        Mon,  8 May 2023 10:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683540074;
        bh=dmJd4OCemEENWpqqoGuc7IUh4bnBGElRLNYG/eRgy2Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eEPRfMnmw5a0hUVxkaTJLUm1v6+ZjbzfjWGfAV+lMiTfl3Gm6H55VjKAiSkFfJPSU
         s2zbfh/NC/XfV8shZfZop5C46yhH1QUZb2WoMpbPQ/E55nlOerjVJh/OAA8NhQj5pm
         H+5v4RrKJpdrzDzsNe6ndwyClMcdi9gmc+J5xGQo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yunfei Dong <yunfei.dong@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 230/611] media: mediatek: vcodec: remove unused lat_buf
Date:   Mon,  8 May 2023 11:41:12 +0200
Message-Id: <20230508094429.880546963@linuxfoundation.org>
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

[ Upstream commit af50b13dd3d7d5dbc1f08add1c462398e926a053 ]

Remove unused lat_buf from core list, or leading to core list access
NULL point.

Fixes: 365e4ba01df4 ("media: mtk-vcodec: Add work queue for core hardware decode")
Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../platform/mediatek/vcodec/vdec_msg_queue.c  | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c b/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c
index ce7c82e38103a..cdc539a46cb95 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c
+++ b/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c
@@ -177,7 +177,7 @@ bool vdec_msg_queue_wait_lat_buf_full(struct vdec_msg_queue *msg_queue)
 	struct vdec_lat_buf *buf, *tmp;
 	struct list_head *list_core[3];
 	struct vdec_msg_queue_ctx *core_ctx;
-	int ret, i, in_core_count = 0;
+	int ret, i, in_core_count = 0, count = 0;
 	long timeout_jiff;
 
 	core_ctx = &msg_queue->ctx->dev->msg_queue_core_ctx;
@@ -204,8 +204,20 @@ bool vdec_msg_queue_wait_lat_buf_full(struct vdec_msg_queue *msg_queue)
 			       msg_queue->lat_ctx.ready_num);
 		return true;
 	}
-	mtk_v4l2_err("failed with lat buf isn't full: %d",
-		     msg_queue->lat_ctx.ready_num);
+
+	spin_lock(&core_ctx->ready_lock);
+	list_for_each_entry_safe(buf, tmp, &core_ctx->ready_queue, core_list) {
+		if (buf && buf->ctx == msg_queue->ctx) {
+			count++;
+			list_del(&buf->core_list);
+		}
+	}
+	spin_unlock(&core_ctx->ready_lock);
+
+	mtk_v4l2_err("failed with lat buf isn't full: list(%d %d) count:%d",
+		     atomic_read(&msg_queue->lat_list_cnt),
+		     atomic_read(&msg_queue->core_list_cnt), count);
+
 	return false;
 }
 
-- 
2.39.2



