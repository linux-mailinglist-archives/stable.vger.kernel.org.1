Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47474703B04
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244115AbjEOR6o (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244877AbjEOR61 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:58:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F1115612
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:55:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 608C362F75
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:55:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EC6BC433EF;
        Mon, 15 May 2023 17:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684173299;
        bh=S36NYVKjfmDx6sKc59U5sRs1sjbL0bkuQywxhdOvNYQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=axUAmskcWGbdsDuvL7w5OEUt4ubJX2y5BKJiL8TEvCI6isD+vmVcC9iNGVhOJl678
         29yDIcJNdW1KFaH4JdVhh+vJQRNdbZKKuMxyiZAZNwqLhvmwYocp9R0BET5vyLqna+
         9c1wO9+17AUdloy0C83lgpRgAzBj5VDqOkJNqhdY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Johan Hovold <johan+linaro@kernel.org>,
        Rob Clark <robdclark@chromium.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 050/282] drm/msm/adreno: drop bogus pm_runtime_set_active()
Date:   Mon, 15 May 2023 18:27:08 +0200
Message-Id: <20230515161723.756531172@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161722.146344674@linuxfoundation.org>
References: <20230515161722.146344674@linuxfoundation.org>
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

[ Upstream commit db7662d076c973072d788bd0e8130e04430307a1 ]

The runtime PM status can only be updated while runtime PM is disabled.

Drop the bogus pm_runtime_set_active() call that was made after enabling
runtime PM and which (incidentally but correctly) left the runtime PM
status set to 'suspended'.

Fixes: 2c087a336676 ("drm/msm/adreno: Load the firmware before bringing up the hardware")
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Patchwork: https://patchwork.freedesktop.org/patch/524972/
Link: https://lore.kernel.org/r/20230303164807.13124-4-johan+linaro@kernel.org
Signed-off-by: Rob Clark <robdclark@chromium.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/adreno/adreno_device.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
index 6ad9d2de07ed6..2a727ab0faf75 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -239,9 +239,6 @@ struct msm_gpu *adreno_load_gpu(struct drm_device *dev)
 	 */
 	pm_runtime_enable(&pdev->dev);
 
-	/* Make sure pm runtime is active and reset any previous errors */
-	pm_runtime_set_active(&pdev->dev);
-
 	ret = pm_runtime_get_sync(&pdev->dev);
 	if (ret < 0) {
 		pm_runtime_put_sync(&pdev->dev);
-- 
2.39.2



