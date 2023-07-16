Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22A2A7552A9
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbjGPUKZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbjGPUKY (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:10:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9647712E
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:10:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2BA3E60EA6
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C1CFC433C8;
        Sun, 16 Jul 2023 20:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689538222;
        bh=JJ0HmW8b+19dY/qbpyRFzjTaGbi1t7XWabwtuZLT5d0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D4MCtyc+B0ZbSgal7OMWGwE22+u2lKepAqy4vuStJ2nBY33cgD925xVH3a+FdRRzG
         JIp4uY3tjBQ0rXAGNOxcw7Pz3S6B1H1tEbQS3HgD78WCnoEXHOspWr0xHKZb12LJ2M
         QBVjyDkKZv8h+Mcjk1BifkDahCymBC/2x2Z17k1w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, David Heidelberg <david@ixit.cz>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Clark <robdclark@chromium.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 374/800] drm/msm/a6xx: dont set IO_PGTABLE_QUIRK_ARM_OUTER_WBWA with coherent SMMU
Date:   Sun, 16 Jul 2023 21:43:47 +0200
Message-ID: <20230716194957.761329011@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
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

[ Upstream commit 38e27a6fbf2206b18417c5985dbcdeca0f2026b8 ]

If the Adreno SMMU is dma-coherent, allocation will fail unless we
disable IO_PGTABLE_QUIRK_ARM_OUTER_WBWA. Skip setting this quirk for the
coherent SMMUs (like we have on sm8350 platform).

Fixes: 54af0ceb7595 ("arm64: dts: qcom: sm8350: add GPU, GMU, GPU CC and SMMU nodes")
Reported-by: David Heidelberg <david@ixit.cz>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Tested-by: David Heidelberg <david@ixit.cz>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Tested-by: Konrad Dybcio <konrad.dybcio@linaro.org> # SM8450 HDK
Patchwork: https://patchwork.freedesktop.org/patch/531562/
Signed-off-by: Rob Clark <robdclark@chromium.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 52da3795b175d..411b7a5fa2f32 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -1744,7 +1744,8 @@ a6xx_create_address_space(struct msm_gpu *gpu, struct platform_device *pdev)
 	 * This allows GPU to set the bus attributes required to use system
 	 * cache on behalf of the iommu page table walker.
 	 */
-	if (!IS_ERR_OR_NULL(a6xx_gpu->htw_llc_slice))
+	if (!IS_ERR_OR_NULL(a6xx_gpu->htw_llc_slice) &&
+	    !device_iommu_capable(&pdev->dev, IOMMU_CAP_CACHE_COHERENCY))
 		quirks |= IO_PGTABLE_QUIRK_ARM_OUTER_WBWA;
 
 	return adreno_iommu_create_address_space(gpu, pdev, quirks);
-- 
2.39.2



