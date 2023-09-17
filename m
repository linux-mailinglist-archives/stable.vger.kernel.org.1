Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3FA97A3C4D
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240988AbjIQU3X (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241047AbjIQU3H (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:29:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 686C610A
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:29:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9806CC433C8;
        Sun, 17 Sep 2023 20:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694982541;
        bh=uzJyNjGzGmSqLZZ20L8p3R8jATjTVy3ma1K6XLL4qQc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KCa2t46CYtNcjP16xOoYZwgBZvE+vTh7HzYti7kelVsG0oRcezcZjcAYRAzvarmoW
         Ins4Ne8DdxLoV+svLArWvONOcgHgrNHsLS+mWoUvmPSiHTXNLYgQ6RPIqhCjXveP49
         /cnW8u++8DOEroWZmnRkmLAwRLAT6mKKgxsYHSSQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Will Deacon <will@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 273/511] iommu/qcom: Disable and reset context bank before programming
Date:   Sun, 17 Sep 2023 21:11:40 +0200
Message-ID: <20230917191120.432473010@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191113.831992765@linuxfoundation.org>
References: <20230917191113.831992765@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

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
index a47cb654b7048..9438203f08de7 100644
--- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
+++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
@@ -273,6 +273,13 @@ static int qcom_iommu_init_domain(struct iommu_domain *domain,
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



