Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26ED47A383E
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239689AbjIQTdW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239763AbjIQTc5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:32:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D1711C
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:32:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76538C433CA;
        Sun, 17 Sep 2023 19:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694979166;
        bh=eNBTk6/WFkU19ynWNAFQKCtUuka8DgTBJyhhnXzIJz4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EIVtSjXaKejkisiltiezc0dd6eb0Xyem4pH7BKTlVL3aj+iRpyRMjhXcZ1b3BmUMx
         eoQlcC5tSDqQpccvdfoha2WPN+pZJci+1ylb6ovbtIvF4ySE2pm/JPihqaX/Og8VWQ
         +Cm5pVOqzSI4QBEanJ6ZItGys/bkJcI9xTLU7h6s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Will Deacon <will@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 234/406] iommu/qcom: Disable and reset context bank before programming
Date:   Sun, 17 Sep 2023 21:11:28 +0200
Message-ID: <20230917191107.346797313@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191101.035638219@linuxfoundation.org>
References: <20230917191101.035638219@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

[ Upstream commit 9f3fef23d9b5a858a6e6d5f478bb1b6b76265e76 ]

Writing	the new	TTBRs, TCRs and MAIRs on a previously enabled
context bank may trigger a context fault, resulting in firmware
driven AP resets: change the domain initialization programming
sequence to disable the context bank(s) and to also clear the
related fault address (CB_FAR) and fault status (CB_FSR)
registers before writing new values to TTBR0/1, TCR/TCR2, MAIR0/1.

Fixes: 0ae349a0f33f ("iommu/qcom: Add qcom_iommu")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20230622092742.74819-4-angelogioacchino.delregno@collabora.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/arm/arm-smmu/qcom_iommu.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
index a24390c548a91..37c8f75a35801 100644
--- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
+++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
@@ -283,6 +283,13 @@ static int qcom_iommu_init_domain(struct iommu_domain *domain,
 			ctx->secure_init = true;
 		}
 
+		/* Disable context bank before programming */
+		iommu_writel(ctx, ARM_SMMU_CB_SCTLR, 0);
+
+		/* Clear context bank fault address fault status registers */
+		iommu_writel(ctx, ARM_SMMU_CB_FAR, 0);
+		iommu_writel(ctx, ARM_SMMU_CB_FSR, ARM_SMMU_FSR_FAULT);
+
 		/* TTBRs */
 		iommu_writeq(ctx, ARM_SMMU_CB_TTBR0,
 				pgtbl_cfg.arm_lpae_s1_cfg.ttbr |
-- 
2.40.1



