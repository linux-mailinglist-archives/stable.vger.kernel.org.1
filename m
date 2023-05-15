Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF9070389F
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244335AbjEORdm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244348AbjEORd1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:33:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4133E15247
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:31:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B184262D2A
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:31:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADCFEC433EF;
        Mon, 15 May 2023 17:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684171875;
        bh=ZsyEdIHpU2jOgYvQP82kq0HW7VDTkiDo4p+w8JTrXgE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dUkhQmJXPpOLULEDuNdbZtERF4ZDLouaEoqiUFpU8tomk6mutrYEO6d1iL/v5eq85
         vTXCBJNJuRcH/lWO2TUgFjQd6a8PpmgtbJNH/7TyxInyG/ibTzXOTihjRhLIg77X9U
         wUpqSoqSbsDjXeGSDsAg2bIroxxbJClVjrJ+j3zU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Johan Hovold <johan+linaro@kernel.org>,
        Rob Clark <robdclark@chromium.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 106/134] drm/msm/adreno: fix runtime PM imbalance at gpu load
Date:   Mon, 15 May 2023 18:29:43 +0200
Message-Id: <20230515161706.648821122@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161702.887638251@linuxfoundation.org>
References: <20230515161702.887638251@linuxfoundation.org>
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

From: Johan Hovold <johan+linaro@kernel.org>

[ Upstream commit 0d997f95b70f98987ae031a89677c13e0e223670 ]

A recent commit moved enabling of runtime PM to GPU load time (first
open()) but failed to update the error paths so that runtime PM is
disabled if initialisation of the GPU fails. This would trigger a
warning about the unbalanced disable count on the next open() attempt.

Note that pm_runtime_put_noidle() is sufficient to balance the usage
count when pm_runtime_put_sync() fails (and is chosen over
pm_runtime_resume_and_get() for consistency reasons).

Fixes: 4b18299b3365 ("drm/msm/adreno: Defer enabling runpm until hw_init()")
Cc: stable@vger.kernel.org      # 6.0
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Patchwork: https://patchwork.freedesktop.org/patch/524971/
Link: https://lore.kernel.org/r/20230303164807.13124-3-johan+linaro@kernel.org
Signed-off-by: Rob Clark <robdclark@chromium.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/adreno/adreno_device.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
index afdfa9edbea3d..7c3d80e78fb8b 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -406,20 +406,21 @@ struct msm_gpu *adreno_load_gpu(struct drm_device *dev)
 
 	ret = pm_runtime_get_sync(&pdev->dev);
 	if (ret < 0) {
-		pm_runtime_put_sync(&pdev->dev);
+		pm_runtime_put_noidle(&pdev->dev);
 		DRM_DEV_ERROR(dev->dev, "Couldn't power up the GPU: %d\n", ret);
-		return NULL;
+		goto err_disable_rpm;
 	}
 
 	mutex_lock(&gpu->lock);
 	ret = msm_gpu_hw_init(gpu);
 	mutex_unlock(&gpu->lock);
-	pm_runtime_put_autosuspend(&pdev->dev);
 	if (ret) {
 		DRM_DEV_ERROR(dev->dev, "gpu hw init failed: %d\n", ret);
-		return NULL;
+		goto err_put_rpm;
 	}
 
+	pm_runtime_put_autosuspend(&pdev->dev);
+
 #ifdef CONFIG_DEBUG_FS
 	if (gpu->funcs->debugfs_init) {
 		gpu->funcs->debugfs_init(gpu, dev->primary);
@@ -428,6 +429,13 @@ struct msm_gpu *adreno_load_gpu(struct drm_device *dev)
 #endif
 
 	return gpu;
+
+err_put_rpm:
+	pm_runtime_put_sync(&pdev->dev);
+err_disable_rpm:
+	pm_runtime_disable(&pdev->dev);
+
+	return NULL;
 }
 
 static void set_gpu_pdev(struct drm_device *dev,
-- 
2.39.2



