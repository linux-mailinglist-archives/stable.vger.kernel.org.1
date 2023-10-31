Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 200717DC701
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 08:13:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343553AbjJaHNc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 03:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343556AbjJaHNb (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 03:13:31 -0400
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 28EB8ED
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 00:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Mn+LM
        vMphVLhG3rmeD4sGc/rl3mIEcUGZbCfQih6dB0=; b=Bvwm9+DbJUJZq5NhDgQXF
        QLdwmXDAc4iyMCJVrPsNU+UjIP/R4DAcyvEBJLFmof/SSDbn/pDgQQAO8QG5NBA1
        qjsFhK7FywrovFl8kTT3WWP3Fb3LZq5XTbtfUcksGagwLSkurWtpEaAubniuy45x
        dMMBlGGLR4B1gtyFgwH8GU=
Received: from leanderwang-LC4.localdomain (unknown [111.206.145.21])
        by zwqz-smtp-mta-g0-3 (Coremail) with SMTP id _____wBHCxoBqUBl14DZBw--.49748S4;
        Tue, 31 Oct 2023 15:13:10 +0800 (CST)
From:   Zheng Wang <zyytlz.wz@163.com>
To:     1002992920@qq.com
Cc:     hackerzheng666@gmail.com, Zheng Wang <zyytlz.wz@163.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        stable@vger.kernel.org
Subject: [PATCH v2 2/3] media: mtk-jpeg: Fix use after free bug due to error path handling in mtk_jpeg_dec_device_run
Date:   Tue, 31 Oct 2023 15:13:01 +0800
Message-Id: <20231031071302.19748-3-zyytlz.wz@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231031071302.19748-1-zyytlz.wz@163.com>
References: <20231031071302.19748-1-zyytlz.wz@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wBHCxoBqUBl14DZBw--.49748S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7uF1rGr1fJr1kJFW3KF43GFg_yoW8KF48pr
        Zagw4DCFWUGrs0gr48Aa4UZF1rC398tF12gr4S9wn3Z343XFs7Jry0ya4IqFWIyr9rCa4r
        Zr1F9a4xJr4DZFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Uza0QUUUUU=
X-Originating-IP: [111.206.145.21]
X-CM-SenderInfo: h2113zf2oz6qqrwthudrp/1tbiXQ8aU1WBq7k8IgAAsD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

In mtk_jpeg_probe, &jpeg->job_timeout_work is bound with
mtk_jpeg_job_timeout_work.

In mtk_jpeg_dec_device_run, if error happens in
mtk_jpeg_set_dec_dst, it will finally start the worker while
mark the job as finished by invoking v4l2_m2m_job_finish.

There are two methods to trigger the bug. If we remove the
module, it which will call mtk_jpeg_remove to make cleanup.
The possible sequence is as follows, which will cause a
use-after-free bug.

CPU0                  CPU1
mtk_jpeg_dec_...    |
  start worker	    |
                    |mtk_jpeg_job_timeout_work
mtk_jpeg_remove     |
  v4l2_m2m_release  |
    kfree(m2m_dev); |
                    |
                    | v4l2_m2m_get_curr_priv
                    |   m2m_dev->curr_ctx //use

If we close the file descriptor, which will call mtk_jpeg_release,
it will have a similar sequence.

Fix this bug by starting timeout worker only if started jpegdec worker
successfully. Then v4l2_m2m_job_finish will only be called in
either mtk_jpeg_job_timeout_work or mtk_jpeg_dec_device_run.
Fixes: b2f0d2724ba4 ("[media] vcodec: mediatek: Add Mediatek JPEG Decoder Driver")
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
index 60425c99a2b8..a39acde2724a 100644
--- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
+++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
@@ -1021,13 +1021,13 @@ static void mtk_jpeg_dec_device_run(void *priv)
 	if (ret < 0)
 		goto dec_end;
 
-	schedule_delayed_work(&jpeg->job_timeout_work,
-			      msecs_to_jiffies(MTK_JPEG_HW_TIMEOUT_MSEC));
-
 	mtk_jpeg_set_dec_src(ctx, &src_buf->vb2_buf, &bs);
 	if (mtk_jpeg_set_dec_dst(ctx, &jpeg_src_buf->dec_param, &dst_buf->vb2_buf, &fb))
 		goto dec_end;
 
+	schedule_delayed_work(&jpeg->job_timeout_work,
+			      msecs_to_jiffies(MTK_JPEG_HW_TIMEOUT_MSEC));
+
 	spin_lock_irqsave(&jpeg->hw_lock, flags);
 	mtk_jpeg_dec_reset(jpeg->reg_base);
 	mtk_jpeg_dec_set_config(jpeg->reg_base,
-- 
2.25.1

