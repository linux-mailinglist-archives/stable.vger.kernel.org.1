Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1F074C339
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 13:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232713AbjGIL3p (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 07:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232730AbjGIL3o (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 07:29:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A8118C
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 04:29:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B03F960BC9
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 11:29:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C44A3C433C7;
        Sun,  9 Jul 2023 11:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688902182;
        bh=w8ECqtR7M4AT+PxaL9qqPkJxhQoxNuJYGKoeoJPOc8U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jrfwnRpIKv66YSxtWaqYr2iEImY6AlEtWoF3/y20NSe5Wlk1G5S/KNRDJ2Q8tbedr
         BSEA4fs1CtlqPMfVMkYTkBCVyPXQd4cTIzTJEuLrOrQFYXL7DMFf315ZZzHV/03r3X
         0eaeCP6b3BDz/D47IjUrjSfab69VWGb5HL0uCnIQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Adam Skladowski <a39.skl@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@chromium.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 285/431] drm/msm/a5xx: really check for A510 in a5xx_gpu_init
Date:   Sun,  9 Jul 2023 13:13:53 +0200
Message-ID: <20230709111457.827886912@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230709111451.101012554@linuxfoundation.org>
References: <20230709111451.101012554@linuxfoundation.org>
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
index 0372f89082022..660c830c68764 100644
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



