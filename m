Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 098246F984D
	for <lists+stable@lfdr.de>; Sun,  7 May 2023 12:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbjEGKyx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 7 May 2023 06:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbjEGKyu (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 7 May 2023 06:54:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF8359EE
        for <stable@vger.kernel.org>; Sun,  7 May 2023 03:54:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E7B8261AFA
        for <stable@vger.kernel.org>; Sun,  7 May 2023 10:54:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 091F4C433D2;
        Sun,  7 May 2023 10:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683456888;
        bh=3m8gJdvzJUiNsE1YdQsuvsaiXeWGFWWl8m6AA/Qeta0=;
        h=Subject:To:Cc:From:Date:From;
        b=Lp8mg193sUSrzBASA1V+ghzn56SEOEXa7fgsA8D4F0yiY7Ni4rMpZePrr/25jIq2c
         iOgAirHdVfFn3QimoH4Dzo0voSeWEOTj/O11kWEd44VJ+A4+ceDmcX0tSTUCjMbCrO
         1QdGnTzqKqPP/nwJ5Vtz4GZCj1TVlLEfIjTtQN2I=
Subject: FAILED: patch "[PATCH] soc: qcom: llcc: Do not create EDAC platform device on SDM845" failed to apply to 6.2-stable tree
To:     mani@kernel.org, andersson@kernel.org,
        manivannan.sadhasivam@linaro.org, stable@vger.kernel.org,
        steev@kali.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 07 May 2023 12:54:43 +0200
Message-ID: <2023050743-mummy-sharper-ce8c@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.2-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.2.y
git checkout FETCH_HEAD
git cherry-pick -x cca94f1dd6d0a4c7e5c8190672f5747e3c00ddde
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023050743-mummy-sharper-ce8c@gregkh' --subject-prefix 'PATCH 6.2.y' HEAD^..

Possible dependencies:

cca94f1dd6d0 ("soc: qcom: llcc: Do not create EDAC platform device on SDM845")
721d3e91bfc9 ("qcom: llcc/edac: Support polling mode for ECC handling")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From cca94f1dd6d0a4c7e5c8190672f5747e3c00ddde Mon Sep 17 00:00:00 2001
From: Manivannan Sadhasivam <mani@kernel.org>
Date: Tue, 14 Mar 2023 13:34:43 +0530
Subject: [PATCH] soc: qcom: llcc: Do not create EDAC platform device on SDM845

The platforms based on SDM845 SoC locks the access to EDAC registers in the
bootloader. So probing the EDAC driver will result in a crash. Hence,
disable the creation of EDAC platform device on all SDM845 devices.

The issue has been observed on Lenovo Yoga C630 and DB845c.

While at it, also sort the members of `struct qcom_llcc_config` to avoid
any holes in-between.

Cc: <stable@vger.kernel.org> # 5.10
Reported-by: Steev Klimaszewski <steev@kali.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Link: https://lore.kernel.org/r/20230314080443.64635-15-manivannan.sadhasivam@linaro.org

diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
index 7b7c5a38bac6..a5140f19f200 100644
--- a/drivers/soc/qcom/llcc-qcom.c
+++ b/drivers/soc/qcom/llcc-qcom.c
@@ -120,10 +120,11 @@ struct llcc_slice_config {
 
 struct qcom_llcc_config {
 	const struct llcc_slice_config *sct_data;
-	int size;
-	bool need_llcc_cfg;
 	const u32 *reg_offset;
 	const struct llcc_edac_reg_offset *edac_reg_offset;
+	int size;
+	bool need_llcc_cfg;
+	bool no_edac;
 };
 
 enum llcc_reg_offset {
@@ -452,6 +453,7 @@ static const struct qcom_llcc_config sdm845_cfg = {
 	.need_llcc_cfg	= false,
 	.reg_offset	= llcc_v1_reg_offset,
 	.edac_reg_offset = &llcc_v1_edac_reg_offset,
+	.no_edac	= true,
 };
 
 static const struct qcom_llcc_config sm6350_cfg = {
@@ -1012,11 +1014,19 @@ static int qcom_llcc_probe(struct platform_device *pdev)
 
 	drv_data->ecc_irq = platform_get_irq_optional(pdev, 0);
 
-	llcc_edac = platform_device_register_data(&pdev->dev,
-					"qcom_llcc_edac", -1, drv_data,
-					sizeof(*drv_data));
-	if (IS_ERR(llcc_edac))
-		dev_err(dev, "Failed to register llcc edac driver\n");
+	/*
+	 * On some platforms, the access to EDAC registers will be locked by
+	 * the bootloader. So probing the EDAC driver will result in a crash.
+	 * Hence, disable the creation of EDAC platform device for the
+	 * problematic platforms.
+	 */
+	if (!cfg->no_edac) {
+		llcc_edac = platform_device_register_data(&pdev->dev,
+						"qcom_llcc_edac", -1, drv_data,
+						sizeof(*drv_data));
+		if (IS_ERR(llcc_edac))
+			dev_err(dev, "Failed to register llcc edac driver\n");
+	}
 
 	return 0;
 err:

