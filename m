Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AFBB7C4BE1
	for <lists+stable@lfdr.de>; Wed, 11 Oct 2023 09:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344641AbjJKHdL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 11 Oct 2023 03:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344466AbjJKHdK (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Oct 2023 03:33:10 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E864691
        for <stable@vger.kernel.org>; Wed, 11 Oct 2023 00:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=s1Rg4
        RojmQKTMkN8IJyGXT1YTHwVaX00n9xyjCRW6MU=; b=OWNggwynIzqdngaAkMqBd
        SaW0tKmUDqBEsu9kNdzPu3g3GkmUJ1YVoXFStqs+FV+Nu8GnQr5M7UHAnaI4Lbho
        SPbz0cxPcFQN2v7aLrt1S9PHQZmGKhzP/G031pIX/VlQ1/2HB4ZDiLuh9gGrH3lU
        hhwt5+xe5g3Ei7CMRCCaPg=
Received: from leanderwang-LC4.localdomain (unknown [111.206.145.21])
        by zwqz-smtp-mta-g3-2 (Coremail) with SMTP id _____wDXv3aGTyZlN6YBAQ--.47035S2;
        Wed, 11 Oct 2023 15:32:23 +0800 (CST)
From:   Zheng Wang <zyytlz.wz@163.com>
To:     stable@vger.kernel.org
Cc:     hackerzheng666@gmail.com, sashal@kernel.org,
        gregkh@linuxfoundation.org, patches@lists.linux.dev,
        amergnat@baylibre.com, wenst@chromium.org,
        angelogioacchino.delregno@collabora.com, hverkuil-cisco@xs4all.nl,
        Zheng Wang <zyytlz.wz@163.com>
Subject: [RESEND PATCH v2] media: mtk-jpeg: Fix use after free bug due to uncanceled work
Date:   Wed, 11 Oct 2023 15:32:04 +0800
Message-Id: <20231011073204.1069793-1-zyytlz.wz@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDXv3aGTyZlN6YBAQ--.47035S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kr1UKr1rCw1ftw18WrW3Wrg_yoW8uw1fpr
        WfK3yUC3yUGFsYqr1UJ3W2vFyrGwnxKayIgry7ua1xZ39xJr4kJryFya40vFWIvF92kayf
        Xr10v34xKr4UZFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziaZXrUUUUU=
X-Originating-IP: [111.206.145.21]
X-CM-SenderInfo: h2113zf2oz6qqrwthudrp/1tbiXRYGU1WBqq2FEgABsb
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L4,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

This is a security bug that has been reported to google.
It affected all platforms on chrome-os. Please apply this
patch to 4.14 4.19 5.4 5.10 and 5.15.

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
- v2: use cancel_delayed_work_sync instead of cancel_delayed_work suggested by Kyrie.
---
 drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
index 0051f372a66c..6069ecf420b0 100644
--- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
+++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
@@ -1816,6 +1816,7 @@ static void mtk_jpeg_remove(struct platform_device *pdev)
 {
 	struct mtk_jpeg_dev *jpeg = platform_get_drvdata(pdev);
 
+	cancel_delayed_work_sync(&jpeg->job_timeout_work);
 	pm_runtime_disable(&pdev->dev);
 	video_unregister_device(jpeg->vdev);
 	v4l2_m2m_release(jpeg->m2m_dev);
-- 
2.25.1

