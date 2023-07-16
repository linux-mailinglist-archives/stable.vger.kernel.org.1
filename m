Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5477C7552AA
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbjGPUK2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231424AbjGPUK1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:10:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8316FC0
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:10:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2249B60E65
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:10:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D802C433C8;
        Sun, 16 Jul 2023 20:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689538225;
        bh=M84IB0Aj6rp8lwBlVDuz47ca0nf96ibsRGYv7+sL9t8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N3I4MGDDL58S2Mq0c6eNHKHNwqeaybn4Ag8mFp2HO/k8h9VUYAFRWzkn1DUSeRb0H
         2Xiit2w5RK7D5uSNRcKkqLpUl1nMhSwWhrlYniYXJJiQdDpIc3aw/OeCL5ceVn0W6q
         38xh7aXxxfz1qbmZrAiPRg+BuWW2bMfkCbsFW5rg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Adam Skladowski <a39.skl@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@chromium.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 375/800] drm/msm/a5xx: really check for A510 in a5xx_gpu_init
Date:   Sun, 16 Jul 2023 21:43:48 +0200
Message-ID: <20230716194957.785832472@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
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

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

[ Upstream commit 736a9327365644b460e4498b1ce172ca411efcbc ]

The commit 010c8bbad2cb ("drm: msm: adreno: Disable preemption on Adreno
510") added special handling for a510 (this SKU doesn't seem to support
preemption, so the driver should clamp nr_rings to 1). However the
gpu->revn is not yet set (it is set later, in adreno_gpu_init()) and
thus the condition is always false. Check config->rev instead.

Fixes: 010c8bbad2cb ("drm: msm: adreno: Disable preemption on Adreno 510")
Reported-by: Adam Skladowski <a39.skl@gmail.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Tested-by: Adam Skladowski <a39.skl@gmail.com>
Patchwork: https://patchwork.freedesktop.org/patch/531511/
Signed-off-by: Rob Clark <robdclark@chromium.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
index 1e8d2982d603c..a99310b687932 100644
--- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
@@ -1743,6 +1743,7 @@ struct msm_gpu *a5xx_gpu_init(struct drm_device *dev)
 {
 	struct msm_drm_private *priv = dev->dev_private;
 	struct platform_device *pdev = priv->gpu_pdev;
+	struct adreno_platform_config *config = pdev->dev.platform_data;
 	struct a5xx_gpu *a5xx_gpu = NULL;
 	struct adreno_gpu *adreno_gpu;
 	struct msm_gpu *gpu;
@@ -1769,7 +1770,7 @@ struct msm_gpu *a5xx_gpu_init(struct drm_device *dev)
 
 	nr_rings = 4;
 
-	if (adreno_is_a510(adreno_gpu))
+	if (adreno_cmp_rev(ADRENO_REV(5, 1, 0, ANY_ID), config->rev))
 		nr_rings = 1;
 
 	ret = adreno_gpu_init(dev, pdev, adreno_gpu, &funcs, nr_rings);
-- 
2.39.2



