Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EFFB76ADFD
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232943AbjHAJfT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233072AbjHAJei (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:34:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DEB6A0
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:32:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 65DE8614DF
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:32:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EC41C433C8;
        Tue,  1 Aug 2023 09:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690882360;
        bh=CRWiTi9rthkFyDOcPNkIBtgksJKhMHKs1lqq/6hGH/M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=08zqf6//DrypLNAhFV8ChLG2wRP6BgYAhLd5XoP41DL04IdalOUnH8t75AR+0yDKG
         H/RUOxYmdY3WWZInErlUmP5xfT1swX+/i0/w/08eq209rrz38sZCq57EcjsHMbc694
         2FHH5xAeBAyyfl4jbNs6IuqR4iOdQ+LrSPkoaUlI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Adrien Thierry <athierry@redhat.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 077/228] phy: qcom-snps-femto-v2: properly enable ref clock
Date:   Tue,  1 Aug 2023 11:18:55 +0200
Message-ID: <20230801091925.626968907@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091922.799813980@linuxfoundation.org>
References: <20230801091922.799813980@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Adrien Thierry <athierry@redhat.com>

[ Upstream commit 8a0eb8f9b9a002291a3934acfd913660b905249e ]

The driver is not enabling the ref clock, which thus gets disabled by
the clk_disable_unused() initcall. This leads to the dwc3 controller
failing to initialize if probed after clk_disable_unused() is called,
for instance when the driver is built as a module.

To fix this, switch to the clk_bulk API to handle both cfg_ahb and ref
clocks at the proper places.

Note that the cfg_ahb clock is currently not used by any device tree
instantiation of the PHY. Work needs to be done separately to fix this.

Link: https://lore.kernel.org/linux-arm-msm/ZEqvy+khHeTkC2hf@fedora/
Fixes: 51e8114f80d0 ("phy: qcom-snps: Add SNPS USB PHY driver for QCOM based SOCs")
Signed-off-by: Adrien Thierry <athierry@redhat.com>
Link: https://lore.kernel.org/r/20230629144542.14906-3-athierry@redhat.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c | 63 ++++++++++++++-----
 1 file changed, 48 insertions(+), 15 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c b/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c
index 3335480fc395a..6170f8fd118e2 100644
--- a/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c
+++ b/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c
@@ -110,11 +110,13 @@ struct phy_override_seq {
 /**
  * struct qcom_snps_hsphy - snps hs phy attributes
  *
+ * @dev: device structure
+ *
  * @phy: generic phy
  * @base: iomapped memory space for snps hs phy
  *
- * @cfg_ahb_clk: AHB2PHY interface clock
- * @ref_clk: phy reference clock
+ * @num_clks: number of clocks
+ * @clks: array of clocks
  * @phy_reset: phy reset control
  * @vregs: regulator supplies bulk data
  * @phy_initialized: if PHY has been initialized correctly
@@ -122,11 +124,13 @@ struct phy_override_seq {
  * @update_seq_cfg: tuning parameters for phy init
  */
 struct qcom_snps_hsphy {
+	struct device *dev;
+
 	struct phy *phy;
 	void __iomem *base;
 
-	struct clk *cfg_ahb_clk;
-	struct clk *ref_clk;
+	int num_clks;
+	struct clk_bulk_data *clks;
 	struct reset_control *phy_reset;
 	struct regulator_bulk_data vregs[SNPS_HS_NUM_VREGS];
 
@@ -135,6 +139,34 @@ struct qcom_snps_hsphy {
 	struct phy_override_seq update_seq_cfg[NUM_HSPHY_TUNING_PARAMS];
 };
 
+static int qcom_snps_hsphy_clk_init(struct qcom_snps_hsphy *hsphy)
+{
+	struct device *dev = hsphy->dev;
+
+	hsphy->num_clks = 2;
+	hsphy->clks = devm_kcalloc(dev, hsphy->num_clks, sizeof(*hsphy->clks), GFP_KERNEL);
+	if (!hsphy->clks)
+		return -ENOMEM;
+
+	/*
+	 * TODO: Currently no device tree instantiation of the PHY is using the clock.
+	 * This needs to be fixed in order for this code to be able to use devm_clk_bulk_get().
+	 */
+	hsphy->clks[0].id = "cfg_ahb";
+	hsphy->clks[0].clk = devm_clk_get_optional(dev, "cfg_ahb");
+	if (IS_ERR(hsphy->clks[0].clk))
+		return dev_err_probe(dev, PTR_ERR(hsphy->clks[0].clk),
+				     "failed to get cfg_ahb clk\n");
+
+	hsphy->clks[1].id = "ref";
+	hsphy->clks[1].clk = devm_clk_get(dev, "ref");
+	if (IS_ERR(hsphy->clks[1].clk))
+		return dev_err_probe(dev, PTR_ERR(hsphy->clks[1].clk),
+				     "failed to get ref clk\n");
+
+	return 0;
+}
+
 static inline void qcom_snps_hsphy_write_mask(void __iomem *base, u32 offset,
 						u32 mask, u32 val)
 {
@@ -365,16 +397,16 @@ static int qcom_snps_hsphy_init(struct phy *phy)
 	if (ret)
 		return ret;
 
-	ret = clk_prepare_enable(hsphy->cfg_ahb_clk);
+	ret = clk_bulk_prepare_enable(hsphy->num_clks, hsphy->clks);
 	if (ret) {
-		dev_err(&phy->dev, "failed to enable cfg ahb clock, %d\n", ret);
+		dev_err(&phy->dev, "failed to enable clocks, %d\n", ret);
 		goto poweroff_phy;
 	}
 
 	ret = reset_control_assert(hsphy->phy_reset);
 	if (ret) {
 		dev_err(&phy->dev, "failed to assert phy_reset, %d\n", ret);
-		goto disable_ahb_clk;
+		goto disable_clks;
 	}
 
 	usleep_range(100, 150);
@@ -382,7 +414,7 @@ static int qcom_snps_hsphy_init(struct phy *phy)
 	ret = reset_control_deassert(hsphy->phy_reset);
 	if (ret) {
 		dev_err(&phy->dev, "failed to de-assert phy_reset, %d\n", ret);
-		goto disable_ahb_clk;
+		goto disable_clks;
 	}
 
 	qcom_snps_hsphy_write_mask(hsphy->base, USB2_PHY_USB_PHY_CFG0,
@@ -439,8 +471,8 @@ static int qcom_snps_hsphy_init(struct phy *phy)
 
 	return 0;
 
-disable_ahb_clk:
-	clk_disable_unprepare(hsphy->cfg_ahb_clk);
+disable_clks:
+	clk_bulk_disable_unprepare(hsphy->num_clks, hsphy->clks);
 poweroff_phy:
 	regulator_bulk_disable(ARRAY_SIZE(hsphy->vregs), hsphy->vregs);
 
@@ -452,7 +484,7 @@ static int qcom_snps_hsphy_exit(struct phy *phy)
 	struct qcom_snps_hsphy *hsphy = phy_get_drvdata(phy);
 
 	reset_control_assert(hsphy->phy_reset);
-	clk_disable_unprepare(hsphy->cfg_ahb_clk);
+	clk_bulk_disable_unprepare(hsphy->num_clks, hsphy->clks);
 	regulator_bulk_disable(ARRAY_SIZE(hsphy->vregs), hsphy->vregs);
 	hsphy->phy_initialized = false;
 
@@ -545,14 +577,15 @@ static int qcom_snps_hsphy_probe(struct platform_device *pdev)
 	if (!hsphy)
 		return -ENOMEM;
 
+	hsphy->dev = dev;
+
 	hsphy->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(hsphy->base))
 		return PTR_ERR(hsphy->base);
 
-	hsphy->ref_clk = devm_clk_get(dev, "ref");
-	if (IS_ERR(hsphy->ref_clk))
-		return dev_err_probe(dev, PTR_ERR(hsphy->ref_clk),
-				     "failed to get ref clk\n");
+	ret = qcom_snps_hsphy_clk_init(hsphy);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to initialize clocks\n");
 
 	hsphy->phy_reset = devm_reset_control_get_exclusive(&pdev->dev, NULL);
 	if (IS_ERR(hsphy->phy_reset)) {
-- 
2.39.2



