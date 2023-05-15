Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 674A970367E
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243761AbjEORKj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243884AbjEORKE (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:10:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577CC8692
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:08:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2ABE9620FF
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:08:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 327A1C433D2;
        Mon, 15 May 2023 17:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684170513;
        bh=q6AzAGrTG8ArFQN82EMIcsu59wUViAOx8XuiCJeb2zI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jzD7d2iTuXlTZVmgP7pyr9GxFKDw0LVQU2EHOzSdj2f1VnyHesQ8/UpmJ+01/fpfw
         T9c9TN4FN15XJBlgDE/+RdyC5Ri+FAVR7wFPhCcbCxGnM+5O98LTGBqpTZkryTN+Q8
         ULkvVkI6hu+afMVCAjWaKzNcv/vXLSk0Duz2162Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Johan Hovold <johan+linaro@kernel.org>,
        Rob Clark <robdclark@chromium.org>
Subject: [PATCH 6.1 147/239] drm/msm/adreno: fix runtime PM imbalance at gpu load
Date:   Mon, 15 May 2023 18:26:50 +0200
Message-Id: <20230515161726.094047552@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161721.545370111@linuxfoundation.org>
References: <20230515161721.545370111@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Johan Hovold <johan+linaro@kernel.org>

commit 0d997f95b70f98987ae031a89677c13e0e223670 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/msm/adreno/adreno_device.c |   16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -440,20 +440,21 @@ struct msm_gpu *adreno_load_gpu(struct d
 
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
@@ -462,6 +463,13 @@ struct msm_gpu *adreno_load_gpu(struct d
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
 
 static int find_chipid(struct device *dev, struct adreno_rev *rev)


