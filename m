Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5522B7DC702
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 08:13:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343559AbjJaHNi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 03:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343556AbjJaHNh (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 03:13:37 -0400
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E3436C2
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 00:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=omdBI
        C+e1jVadRkJ0QsCI7L9wKGBA2OoP3PF04hqiWI=; b=FbTi1gdugfJVPY7RrBQyF
        yRHAyCUicIyUgXXyC7rBV5xGj+/inCoG2OxBsGv/NOQ79nKSq5gV3Of+ohhlDdoa
        O9jXE8bpxgndoitiaqSpeExeipKUnRZR6aKSHRUYVl/FAmgLytnUn9M/VNE0tovU
        iFOra80Xg5codXqSf+GhMU=
Received: from leanderwang-LC4.localdomain (unknown [111.206.145.21])
        by zwqz-smtp-mta-g0-3 (Coremail) with SMTP id _____wBHCxoBqUBl14DZBw--.49748S5;
        Tue, 31 Oct 2023 15:13:11 +0800 (CST)
From:   Zheng Wang <zyytlz.wz@163.com>
To:     1002992920@qq.com
Cc:     hackerzheng666@gmail.com, Zheng Wang <zyytlz.wz@163.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        stable@vger.kernel.org
Subject: [PATCH v2 3/3] media: mtk-jpeg: Fix timeout schedule error in 
Date:   Tue, 31 Oct 2023 15:13:02 +0800
Message-Id: <20231031071302.19748-4-zyytlz.wz@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231031071302.19748-1-zyytlz.wz@163.com>
References: <20231031071302.19748-1-zyytlz.wz@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wBHCxoBqUBl14DZBw--.49748S5
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ar15uF1rKrW5Gr4xtw4Dtwb_yoW8ZF1rpF
        WfK3yqkrWUWrZ8tF4UA3W7ZFy5G34Fgr47Ww43Xwn5A343XF47tryjya4xtFWIyFy2ka4F
        yF4vg34xJFsFyFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jbl19UUUUU=
X-Originating-IP: [111.206.145.21]
X-CM-SenderInfo: h2113zf2oz6qqrwthudrp/1tbiXAwaU1Xl78YkcgAAsW
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

In mtk_jpegdec_worker, if error occurs in mtk_jpeg_set_dec_dst, it
will start the timeout worker and invoke v4l2_m2m_job_finish at
the same time. This will break the logic of design for there should
be only one function to call v4l2_m2m_job_finish. But now the timeout
handler and mtk_jpegdec_worker will both invoke it.

Fix it by start the worker only if mtk_jpeg_set_dec_dst successfully
finished.

Fixes: da4ede4b7fd6 ("media: mtk-jpeg: move data/code inside CONFIG_OF blocks")
Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: stable@vger.kernel.org
---
v2:
- put the patches into a single series suggested by Dmitry
---
 drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
index a39acde2724a..c3456c700c07 100644
--- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
+++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
@@ -1749,9 +1749,6 @@ static void mtk_jpegdec_worker(struct work_struct *work)
 	v4l2_m2m_src_buf_remove(ctx->fh.m2m_ctx);
 	v4l2_m2m_dst_buf_remove(ctx->fh.m2m_ctx);
 
-	schedule_delayed_work(&comp_jpeg[hw_id]->job_timeout_work,
-			      msecs_to_jiffies(MTK_JPEG_HW_TIMEOUT_MSEC));
-
 	mtk_jpeg_set_dec_src(ctx, &src_buf->vb2_buf, &bs);
 	if (mtk_jpeg_set_dec_dst(ctx,
 				 &jpeg_src_buf->dec_param,
@@ -1761,6 +1758,9 @@ static void mtk_jpegdec_worker(struct work_struct *work)
 		goto setdst_end;
 	}
 
+	schedule_delayed_work(&comp_jpeg[hw_id]->job_timeout_work,
+			      msecs_to_jiffies(MTK_JPEG_HW_TIMEOUT_MSEC));
+
 	spin_lock_irqsave(&comp_jpeg[hw_id]->hw_lock, flags);
 	ctx->total_frame_num++;
 	mtk_jpeg_dec_reset(comp_jpeg[hw_id]->reg_base);
-- 
2.25.1

