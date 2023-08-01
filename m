Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDC0876AD1B
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjHAJ0Z (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232597AbjHAJ0K (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:26:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9562108
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:24:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F0513614CF
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:24:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F36BC433C8;
        Tue,  1 Aug 2023 09:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690881891;
        bh=4fJDMZTYfFaPEwz8wir+h/3ybU5pVKMyEQ4m+0vJAio=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zLZNKqwy7xCvpCH8wYXFE2s9vG1bkASyR7SU2w0B5JIfdW48mfmaQtcDQ2OrtWamD
         2SplHVMtTElUVjVP+5qOsCoeHpSsyxvYDdiYSDUyFE+uObxSQ7vierzYmxgrl8vRtG
         l1caZPlosRK/8Kqil31e5ZYY80h8ADhDsHm00iZU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yuan Can <yuancan@huawei.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andrew Halaney <ahalaney@redhat.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 049/155] phy: qcom-snps: Use dev_err_probe() to simplify code
Date:   Tue,  1 Aug 2023 11:19:21 +0200
Message-ID: <20230801091911.947322265@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091910.165050260@linuxfoundation.org>
References: <20230801091910.165050260@linuxfoundation.org>
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

From: Yuan Can <yuancan@huawei.com>

[ Upstream commit 668dc8afce43d4bc01feb3e929d6d5ffcb14f899 ]

In the probe path, dev_err() can be replaced with dev_err_probe()
which will check if error code is -EPROBE_DEFER and prints the
error name. It also sets the defer probe reason which can be
checked later through debugfs.

Signed-off-by: Yuan Can <yuancan@huawei.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
Link: https://lore.kernel.org/r/20220922111228.36355-8-yuancan@huawei.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Stable-dep-of: 8a0eb8f9b9a0 ("phy: qcom-snps-femto-v2: properly enable ref clock")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c b/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c
index 7e61202aa234e..54846259405a9 100644
--- a/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c
+++ b/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c
@@ -304,12 +304,9 @@ static int qcom_snps_hsphy_probe(struct platform_device *pdev)
 		return PTR_ERR(hsphy->base);
 
 	hsphy->ref_clk = devm_clk_get(dev, "ref");
-	if (IS_ERR(hsphy->ref_clk)) {
-		ret = PTR_ERR(hsphy->ref_clk);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to get ref clk, %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(hsphy->ref_clk))
+		return dev_err_probe(dev, PTR_ERR(hsphy->ref_clk),
+				     "failed to get ref clk\n");
 
 	hsphy->phy_reset = devm_reset_control_get_exclusive(&pdev->dev, NULL);
 	if (IS_ERR(hsphy->phy_reset)) {
@@ -322,12 +319,9 @@ static int qcom_snps_hsphy_probe(struct platform_device *pdev)
 		hsphy->vregs[i].supply = qcom_snps_hsphy_vreg_names[i];
 
 	ret = devm_regulator_bulk_get(dev, num, hsphy->vregs);
-	if (ret) {
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to get regulator supplies: %d\n",
-				ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to get regulator supplies\n");
 
 	pm_runtime_set_active(dev);
 	pm_runtime_enable(dev);
-- 
2.39.2



