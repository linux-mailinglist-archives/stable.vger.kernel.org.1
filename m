Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE10770347E
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 18:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243048AbjEOQtO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 12:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243049AbjEOQs7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 12:48:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D3AF559D
        for <stable@vger.kernel.org>; Mon, 15 May 2023 09:48:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A3B4462924
        for <stable@vger.kernel.org>; Mon, 15 May 2023 16:48:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9783EC433EF;
        Mon, 15 May 2023 16:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684169332;
        bh=W0dr0ompCSH23tg7fAa57/7RUualUmc92Mb6OKmJux8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uUyOHSvrjC+lZ8MThB1ztgaxynhSM+i1pfY8K1bskHfF+b+k3mcAJSww1Qq+0YSmN
         G5MheRn4qUpcqLsqyb4cwYZIpDnRe4HXThsFCM7WXwh8AWsKYXfRal00IaiVr7UY/q
         Wsd1hbAmPgBZAwidWhLLQUeKmOFCAEodNA9GW6G0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Luca Weiss <luca.weiss@fairphone.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        Steev Klimaszewski <steev@kali.org>,
        Andrew Halaney <ahalaney@redhat.com>
Subject: [PATCH 6.3 006/246] qcom: llcc/edac: Support polling mode for ECC handling
Date:   Mon, 15 May 2023 18:23:38 +0200
Message-Id: <20230515161722.809789099@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161722.610123835@linuxfoundation.org>
References: <20230515161722.610123835@linuxfoundation.org>
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

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

[ Upstream commit 721d3e91bfc93975c5e1a76c7d588dd8df5d82da ]

Not all Qcom platforms support IRQ mode for ECC handling. For those
platforms, the current EDAC driver will not be probed due to missing ECC
IRQ in devicetree.

So add support for polling mode so that the EDAC driver can be used on all
Qcom platforms supporting LLCC.

The polling delay of 5000ms is chosen based on Qcom downstream/vendor
driver.

Reported-by: Luca Weiss <luca.weiss@fairphone.com>
Tested-by: Luca Weiss <luca.weiss@fairphone.com>
Tested-by: Steev Klimaszewski <steev@kali.org> # Thinkpad X13s
Tested-by: Andrew Halaney <ahalaney@redhat.com> # sa8540p-ride
Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Link: https://lore.kernel.org/r/20230314080443.64635-14-manivannan.sadhasivam@linaro.org
Stable-dep-of: cca94f1dd6d0 ("soc: qcom: llcc: Do not create EDAC platform device on SDM845")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/edac/qcom_edac.c     | 50 +++++++++++++++++++++---------------
 drivers/soc/qcom/llcc-qcom.c | 13 +++++-----
 2 files changed, 35 insertions(+), 28 deletions(-)

diff --git a/drivers/edac/qcom_edac.c b/drivers/edac/qcom_edac.c
index 3256254c3722c..a7158b570ddd0 100644
--- a/drivers/edac/qcom_edac.c
+++ b/drivers/edac/qcom_edac.c
@@ -76,6 +76,8 @@
 #define DRP0_INTERRUPT_ENABLE           BIT(6)
 #define SB_DB_DRP_INTERRUPT_ENABLE      0x3
 
+#define ECC_POLL_MSEC			5000
+
 enum {
 	LLCC_DRAM_CE = 0,
 	LLCC_DRAM_UE,
@@ -285,8 +287,7 @@ dump_syn_reg(struct edac_device_ctl_info *edev_ctl, int err_type, u32 bank)
 	return ret;
 }
 
-static irqreturn_t
-llcc_ecc_irq_handler(int irq, void *edev_ctl)
+static irqreturn_t llcc_ecc_irq_handler(int irq, void *edev_ctl)
 {
 	struct edac_device_ctl_info *edac_dev_ctl = edev_ctl;
 	struct llcc_drv_data *drv = edac_dev_ctl->dev->platform_data;
@@ -332,6 +333,11 @@ llcc_ecc_irq_handler(int irq, void *edev_ctl)
 	return irq_rc;
 }
 
+static void llcc_ecc_check(struct edac_device_ctl_info *edev_ctl)
+{
+	llcc_ecc_irq_handler(0, edev_ctl);
+}
+
 static int qcom_llcc_edac_probe(struct platform_device *pdev)
 {
 	struct llcc_drv_data *llcc_driv_data = pdev->dev.platform_data;
@@ -359,29 +365,31 @@ static int qcom_llcc_edac_probe(struct platform_device *pdev)
 	edev_ctl->ctl_name = "llcc";
 	edev_ctl->panic_on_ue = LLCC_ERP_PANIC_ON_UE;
 
-	rc = edac_device_add_device(edev_ctl);
-	if (rc)
-		goto out_mem;
-
-	platform_set_drvdata(pdev, edev_ctl);
-
-	/* Request for ecc irq */
+	/* Check if LLCC driver has passed ECC IRQ */
 	ecc_irq = llcc_driv_data->ecc_irq;
-	if (ecc_irq < 0) {
-		rc = -ENODEV;
-		goto out_dev;
-	}
-	rc = devm_request_irq(dev, ecc_irq, llcc_ecc_irq_handler,
+	if (ecc_irq > 0) {
+		/* Use interrupt mode if IRQ is available */
+		rc = devm_request_irq(dev, ecc_irq, llcc_ecc_irq_handler,
 			      IRQF_TRIGGER_HIGH, "llcc_ecc", edev_ctl);
-	if (rc)
-		goto out_dev;
+		if (!rc) {
+			edac_op_state = EDAC_OPSTATE_INT;
+			goto irq_done;
+		}
+	}
 
-	return rc;
+	/* Fall back to polling mode otherwise */
+	edev_ctl->poll_msec = ECC_POLL_MSEC;
+	edev_ctl->edac_check = llcc_ecc_check;
+	edac_op_state = EDAC_OPSTATE_POLL;
 
-out_dev:
-	edac_device_del_device(edev_ctl->dev);
-out_mem:
-	edac_device_free_ctl_info(edev_ctl);
+irq_done:
+	rc = edac_device_add_device(edev_ctl);
+	if (rc) {
+		edac_device_free_ctl_info(edev_ctl);
+		return rc;
+	}
+
+	platform_set_drvdata(pdev, edev_ctl);
 
 	return rc;
 }
diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
index 26efe12012a0d..e417bd285d9db 100644
--- a/drivers/soc/qcom/llcc-qcom.c
+++ b/drivers/soc/qcom/llcc-qcom.c
@@ -1001,13 +1001,12 @@ static int qcom_llcc_probe(struct platform_device *pdev)
 		goto err;
 
 	drv_data->ecc_irq = platform_get_irq_optional(pdev, 0);
-	if (drv_data->ecc_irq >= 0) {
-		llcc_edac = platform_device_register_data(&pdev->dev,
-						"qcom_llcc_edac", -1, drv_data,
-						sizeof(*drv_data));
-		if (IS_ERR(llcc_edac))
-			dev_err(dev, "Failed to register llcc edac driver\n");
-	}
+
+	llcc_edac = platform_device_register_data(&pdev->dev,
+					"qcom_llcc_edac", -1, drv_data,
+					sizeof(*drv_data));
+	if (IS_ERR(llcc_edac))
+		dev_err(dev, "Failed to register llcc edac driver\n");
 
 	return 0;
 err:
-- 
2.39.2



