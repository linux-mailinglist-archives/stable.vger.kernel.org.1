Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81DF175558A
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232555AbjGPUl4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232553AbjGPUlz (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:41:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECED0E4
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:41:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 61B3060EAE
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:41:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7194FC433C8;
        Sun, 16 Jul 2023 20:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689540112;
        bh=Lqww7CpVt3mwXLv++6oqCAAYZplr+V6yphJ4SJNNziI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TmYOY+V1z6tf+Ph+VzDQ9DepxIH0mO4S36Q/VuLRALp7z9es5BH2OeovMl4Vqnnp9
         lGd1M0fv0xPLbVoNtpMYa7lERYXZK8VD3sS4BG12uSJN9Hs+FTBlwRgWMSyNu8CEJU
         zqTSLp4dbX0UdzMPX4Xxkfj5royrioo/5yMTcHSA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Adam Skladowski <a39.skl@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@chromium.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 247/591] drm/msm/a5xx: really check for A510 in a5xx_gpu_init
Date:   Sun, 16 Jul 2023 21:46:26 +0200
Message-ID: <20230716194930.261594951@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
index 24feae285ccd6..0829eaf2cd4e8 100644
--- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
@@ -1740,6 +1740,7 @@ struct msm_gpu *a5xx_gpu_init(struct drm_device *dev)
 {
 	struct msm_drm_private *priv = dev->dev_private;
 	struct platform_device *pdev = priv->gpu_pdev;
+	struct adreno_platform_config *config = pdev->dev.platform_data;
 	struct a5xx_gpu *a5xx_gpu = NULL;
 	struct adreno_gpu *adreno_gpu;
 	struct msm_gpu *gpu;
@@ -1766,7 +1767,7 @@ struct msm_gpu *a5xx_gpu_init(struct drm_device *dev)
 
 	nr_rings = 4;
 
-	if (adreno_is_a510(adreno_gpu))
+	if (adreno_cmp_rev(ADRENO_REV(5, 1, 0, ANY_ID), config->rev))
 		nr_rings = 1;
 
 	ret = adreno_gpu_init(dev, pdev, adreno_gpu, &funcs, nr_rings);
-- 
2.39.2



