Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC587755540
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232432AbjGPUjF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232433AbjGPUjE (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:39:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC748AB
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:39:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 83EAA60E2C
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:39:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 963E8C433C8;
        Sun, 16 Jul 2023 20:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689539942;
        bh=IiYIJ5cmj4taGqLJBbsw1wJ4itWS/5zucRjGfclM9rA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0WuXvUnuywEwfqDJfjtU5tL+bOUeyFeMWCW9yySjaVCrpbKexRgLQG424b1kkCRGr
         ZiJqUqRy73h2Hsy/RP6WhLAAWPW+QKglLesbLBPnzf5AC2mHb232Wh4wGdwT9jlVXp
         +OLp+Nkh0ieHN2EPUfs2+5gLidMa9xPuV3uj6CB0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 186/591] drm/msm/dpu: Set DPU_DATA_HCTL_EN for in INTF_SC7180_MASK
Date:   Sun, 16 Jul 2023 21:45:25 +0200
Message-ID: <20230716194928.685665533@linuxfoundation.org>
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

From: Konrad Dybcio <konrad.dybcio@linaro.org>

[ Upstream commit a7129231edf329a00e92dbd2d741f6da728a4a06 ]

DPU5 and newer targets enable this unconditionally. Move it from the
SC7280 mask to the SC7180 one.

Fixes: 7e6ee55320f0 ("drm/msm/disp/dpu1: enable DATA_HCTL_EN for sc7280 target")
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Patchwork: https://patchwork.freedesktop.org/patch/538159/
Link: https://lore.kernel.org/r/20230508-topic-hctl_en-v2-1-e7bea9f1f5dd@linaro.org
[DB: removed BIT(DPU_INTF_DATA_COMPRESS), which is not yet merged]
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
index 715c7a254632b..80e59d3f9dd3e 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
@@ -80,9 +80,12 @@
 #define INTF_SDM845_MASK (0)
 
 #define INTF_SC7180_MASK \
-	(BIT(DPU_INTF_INPUT_CTRL) | BIT(DPU_INTF_TE) | BIT(DPU_INTF_STATUS_SUPPORTED))
+	(BIT(DPU_INTF_INPUT_CTRL) | \
+	 BIT(DPU_INTF_TE) | \
+	 BIT(DPU_INTF_STATUS_SUPPORTED) | \
+	 BIT(DPU_DATA_HCTL_EN))
 
-#define INTF_SC7280_MASK INTF_SC7180_MASK | BIT(DPU_DATA_HCTL_EN)
+#define INTF_SC7280_MASK (INTF_SC7180_MASK)
 
 #define IRQ_SDM845_MASK (BIT(MDP_SSPP_TOP0_INTR) | \
 			 BIT(MDP_SSPP_TOP0_INTR2) | \
-- 
2.39.2



