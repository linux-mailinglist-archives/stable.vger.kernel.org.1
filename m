Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ECC26FAAD3
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233535AbjEHLGw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233319AbjEHLGd (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:06:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 873CD2FA29
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:05:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 66BA062A74
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:05:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CF91C433EF;
        Mon,  8 May 2023 11:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683543934;
        bh=MB/lyDL4/GEr019OeuI0dxOAPHRvFbVPNBjN44GEfV4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FABC7QWj9tOSfHbfoATOyKuiV4tnZekLpSy7uFftmzyh7IIgYZnJpxf0Ni/DKSbjB
         /Yy5TSJPA1vMjv7pfj7Rg6hoxSXFT1wtjZeGFbud5UR6xNgUu6DKqtDU5W5v3jRZSP
         fQ9qReNUXU2oVzFst1Fy6vqefFrgAEdAftqIx+zI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Johan Hovold <johan+linaro@kernel.org>,
        Rob Clark <robdclark@chromium.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 217/694] drm/msm/adreno: drop bogus pm_runtime_set_active()
Date:   Mon,  8 May 2023 11:40:52 +0200
Message-Id: <20230508094439.408096146@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
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
index c5c4c93b3689c..cd009d56d35d5 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -438,9 +438,6 @@ struct msm_gpu *adreno_load_gpu(struct drm_device *dev)
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



