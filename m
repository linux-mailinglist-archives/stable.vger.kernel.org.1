Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 731DF7C99A0
	for <lists+stable@lfdr.de>; Sun, 15 Oct 2023 16:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjJOOwW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 15 Oct 2023 10:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjJOOwV (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 15 Oct 2023 10:52:21 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 82DF7C5
        for <stable@vger.kernel.org>; Sun, 15 Oct 2023 07:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=ueXlJ
        lVKbhSl1uShLEsjngt1VWT6okWayMs18u5pGBU=; b=c3TRPtoFLgLeeXLSGlkei
        DMZK4bAAeR20cEv8z/Q8OPDdgrl9CWI8VYunShXunHsY/zN6mRqK0t7a02oH39gk
        R7PtOtmhUM5dRatqBh/nt8TgGuKMoirQRdZxp/1Fd1be4Mz/oUfJMERX6f91lwEN
        WBaangxOQ8K+fhbw0pFNoE=
Received: from leanderwang-LC4.localdomain (unknown [111.206.145.21])
        by zwqz-smtp-mta-g5-1 (Coremail) with SMTP id _____wDXH1pA_CtlYv2IAg--.7403S2;
        Sun, 15 Oct 2023 22:50:40 +0800 (CST)
From:   Zheng Wang <zyytlz.wz@163.com>
To:     stable@vger.kernel.org
Cc:     hackerzheng666@gmail.com, sashal@kernel.org,
        gregkh@linuxfoundation.org, patches@lists.linux.dev,
        amergnat@baylibre.com, wenst@chromium.org,
        angelogioacchino.delregno@collabora.com, hverkuil-cisco@xs4all.nl,
        Zheng Wang <zyytlz.wz@163.com>
Subject: [PATCH] media: mtk-jpeg: Fix use after free bug due to uncanceled  work
Date:   Sun, 15 Oct 2023 22:50:37 +0800
Message-Id: <20231015145037.731975-1-zyytlz.wz@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDXH1pA_CtlYv2IAg--.7403S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kr15ZrW5JrW8CFy7Ww1ftFb_yoW8uF4Upr
        Z3K34DurWUGFsYqr1UAF12vFyrGwn8ta1Sqr1fWa1xZ393Xr4kJr1FvFy0vFWIvr93Cayf
        Xr18A348Gr4UZFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zic18dUUUUU=
X-Originating-IP: [111.206.145.21]
X-CM-SenderInfo: h2113zf2oz6qqrwthudrp/xtbBzgIKU2I0a7ff2gAAsa
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L4,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

This is a security bug that has been reported to google.
It affected all platforms on chrome-os. Please apply this
patch to 5.15.

Due to the directory structure change, the file path to
be patched is different from that in upstream.

[ Upstream commit c677d7ae83141d390d1253abebafa49c962afb52 ]

In mtk_jpeg_probe, &jpeg->job_timeout_work is bound with
mtk_jpeg_job_timeout_work. Then mtk_jpeg_dec_device_run
and mtk_jpeg_enc_device_run may be called to start the
work.

If we remove the module which will call mtk_jpeg_remove
to make cleanup, there may be a unfinished work. The
possible sequence is as follows, which will cause a
typical UAF bug.

Fix it by canceling the work before cleanup in the mtk_jpeg_remove

CPU0                  CPU1

                    |mtk_jpeg_job_timeout_work
mtk_jpeg_remove     |
  v4l2_m2m_release  |
    kfree(m2m_dev); |
                    |
                    | v4l2_m2m_get_curr_priv
                    |   m2m_dev->curr_ctx //use
Fixes: b2f0d2724ba4 ("[media] vcodec: mediatek: Add Mediatek JPEG Decoder Driver")
Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org
---
 drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c b/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c
index a89c7b206eef..d3af699ad72f 100644
--- a/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c
+++ b/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c
@@ -1455,6 +1455,7 @@ static int mtk_jpeg_remove(struct platform_device *pdev)
 {
 	struct mtk_jpeg_dev *jpeg = platform_get_drvdata(pdev);
 
+	cancel_delayed_work_sync(&jpeg->job_timeout_work);
 	pm_runtime_disable(&pdev->dev);
 	video_unregister_device(jpeg->vdev);
 	video_device_release(jpeg->vdev);
-- 
2.25.1

