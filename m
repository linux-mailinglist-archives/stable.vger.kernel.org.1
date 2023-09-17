Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32BB07A3BE2
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240813AbjIQUXc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240911AbjIQUXO (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:23:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C81110A
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:23:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81EAEC433C8;
        Sun, 17 Sep 2023 20:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694982188;
        bh=OuoIYjMKvP/U3JLrzR99b1Y5R65TxdT94+MHPXh7qd8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BwASdXO4R+Yc5rEhIGpfBt0ssn6aIhIrYai9FV1ibpHjyvQeTECa9aof7VMW3FoVT
         dDjHF1pKtv/cbXPqsQD93mrEBI/zxPaXpsJpIG6cMNEvob7APOK1vkX9h/oChdqqD3
         5ggq9CIt89Il6H05pxSjVka2Vr/OvrKX1hd+EI4o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Fabio Estevam <festevam@denx.de>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@chromium.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 177/511] drm/msm/a2xx: Call adreno_gpu_init() earlier
Date:   Sun, 17 Sep 2023 21:10:04 +0200
Message-ID: <20230917191118.107189215@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191113.831992765@linuxfoundation.org>
References: <20230917191113.831992765@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Fabio Estevam <festevam@denx.de>

[ Upstream commit db07ce5da8b26bfeaf437a676ae49bd3bb1eace6 ]

The adreno_is_a20x() and adreno_is_a225() functions rely on the
GPU revision, but such information is retrieved inside adreno_gpu_init(),
which is called afterwards.

Fix this problem by caling adreno_gpu_init() earlier, so that
the GPU information revision is available when adreno_is_a20x()
and adreno_is_a225() run.

Tested on a imx53-qsb board.

Fixes: 21af872cd8c6 ("drm/msm/adreno: add a2xx")
Signed-off-by: Fabio Estevam <festevam@denx.de>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Patchwork: https://patchwork.freedesktop.org/patch/543456/
Signed-off-by: Rob Clark <robdclark@chromium.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/adreno/a2xx_gpu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a2xx_gpu.c b/drivers/gpu/drm/msm/adreno/a2xx_gpu.c
index bdc989183c648..17d6a1ecb1110 100644
--- a/drivers/gpu/drm/msm/adreno/a2xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a2xx_gpu.c
@@ -521,6 +521,10 @@ struct msm_gpu *a2xx_gpu_init(struct drm_device *dev)
 	gpu->perfcntrs = perfcntrs;
 	gpu->num_perfcntrs = ARRAY_SIZE(perfcntrs);
 
+	ret = adreno_gpu_init(dev, pdev, adreno_gpu, &funcs, 1);
+	if (ret)
+		goto fail;
+
 	if (adreno_is_a20x(adreno_gpu))
 		adreno_gpu->registers = a200_registers;
 	else if (adreno_is_a225(adreno_gpu))
@@ -528,10 +532,6 @@ struct msm_gpu *a2xx_gpu_init(struct drm_device *dev)
 	else
 		adreno_gpu->registers = a220_registers;
 
-	ret = adreno_gpu_init(dev, pdev, adreno_gpu, &funcs, 1);
-	if (ret)
-		goto fail;
-
 	if (!gpu->aspace) {
 		dev_err(dev->dev, "No memory protection without MMU\n");
 		if (!allow_vram_carveout) {
-- 
2.40.1



