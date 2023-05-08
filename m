Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 338506FAD81
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236011AbjEHLfR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236000AbjEHLfF (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:35:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6720A3E336
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:34:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3853E630D6
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:34:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F640C433EF;
        Mon,  8 May 2023 11:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683545655;
        bh=Q6KXXE6y859Mqtw4+tXcWUYwfw6SiLAE1BFjMXAMzyI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D5JwvL6mVM4aZ2RlDnIdxWJ4GWp7Zh77HhCE5eZBBO9Ph5ZNtBH6GXRwETqp4gwDZ
         cyt+4LjQxplv14lZYkJ1+KcMGH1BwCl+7b+wU5or8mU0767FNqnZWuzJv7J+udGkBQ
         +xzEdzMWACHGlMWZL+0jI8Tc0JRAtBq9vXzY+q6w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Rob Clark <robdclark@chromium.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 111/371] drm/msm/adreno: Defer enabling runpm until hw_init()
Date:   Mon,  8 May 2023 11:45:12 +0200
Message-Id: <20230508094816.418690974@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094811.912279944@linuxfoundation.org>
References: <20230508094811.912279944@linuxfoundation.org>
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

From: Rob Clark <robdclark@chromium.org>

[ Upstream commit 4b18299b33655fa9672b774b6df774dc03d6aee8 ]

To avoid preventing the display from coming up before the rootfs is
mounted, without resorting to packing fw in the initrd, the GPU has
this limbo state where the device is probed, but we aren't ready to
start sending commands to it.  This is particularly problematic for
a6xx, since the GMU (which requires fw to be loaded) is the one that
is controlling the power/clk/icc votes.

So defer enabling runpm until we are ready to call gpu->hw_init(),
as that is a point where we know we have all the needed fw and are
ready to start sending commands to the coproc's.

Signed-off-by: Rob Clark <robdclark@chromium.org>
Patchwork: https://patchwork.freedesktop.org/patch/489337/
Link: https://lore.kernel.org/r/20220613182036.2567963-1-robdclark@gmail.com
Stable-dep-of: db7662d076c9 ("drm/msm/adreno: drop bogus pm_runtime_set_active()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/adreno/adreno_device.c | 6 ++++++
 drivers/gpu/drm/msm/adreno/adreno_gpu.c    | 1 -
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
index 2a6ce76656aa2..32207bc42b281 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -398,6 +398,12 @@ struct msm_gpu *adreno_load_gpu(struct drm_device *dev)
 	if (ret)
 		return NULL;
 
+	/*
+	 * Now that we have firmware loaded, and are ready to begin
+	 * booting the gpu, go ahead and enable runpm:
+	 */
+	pm_runtime_enable(&pdev->dev);
+
 	/* Make sure pm runtime is active and reset any previous errors */
 	pm_runtime_set_active(&pdev->dev);
 
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index 3fa01938f4b29..47a260715a89c 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -943,7 +943,6 @@ int adreno_gpu_init(struct drm_device *drm, struct platform_device *pdev,
 	pm_runtime_set_autosuspend_delay(dev,
 		adreno_gpu->info->inactive_period);
 	pm_runtime_use_autosuspend(dev);
-	pm_runtime_enable(dev);
 
 	return msm_gpu_init(drm, pdev, &adreno_gpu->base, &funcs->base,
 			adreno_gpu->info->name, &adreno_gpu_config);
-- 
2.39.2



