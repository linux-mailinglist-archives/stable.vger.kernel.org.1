Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D550E7A3930
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239993AbjIQTqL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239987AbjIQTpm (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:45:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C67103
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:45:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65BC4C433C8;
        Sun, 17 Sep 2023 19:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694979935;
        bh=6mzTUJrcQzwAWL0Zwjl0Wtuj94nxwdg86m6H5LBUZHc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2fIbzfYUJNqLUVk0ED3EdoHhw/z4rui3kTTuyVY2zvAyLOAevKzF6uZpNBvAfu9Jy
         6Y8CSjbDjKaryjXEEH44yBi4A3GbRWdEVUvMCrcZ/3gns9Odk0nIBj4uFEub4qlPck
         fWZMsXFKdyQQ4l+T4HzraMmzUk6V0hHFKr41GmVY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Taniya Das <quic_tdas@quicinc.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Subject: [PATCH 6.5 050/285] clk: qcom: lpasscc-sc7280: fix missing resume during probe
Date:   Sun, 17 Sep 2023 21:10:50 +0200
Message-ID: <20230917191053.413771110@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191051.639202302@linuxfoundation.org>
References: <20230917191051.639202302@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan+linaro@kernel.org>

commit 66af5339d4f8e20c6d89a490570bd94d40f1a7f6 upstream.

Drivers that enable runtime PM must make sure that the controller is
runtime resumed before accessing its registers to prevent the power
domain from being disabled.

Fixes: 4ab43d171181 ("clk: qcom: Add lpass clock controller driver for SC7280")
Cc: stable@vger.kernel.org      # 5.16
Cc: Taniya Das <quic_tdas@quicinc.com>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Link: https://lore.kernel.org/r/20230718132902.21430-6-johan+linaro@kernel.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/clk/qcom/lpasscc-sc7280.c |   16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

--- a/drivers/clk/qcom/lpasscc-sc7280.c
+++ b/drivers/clk/qcom/lpasscc-sc7280.c
@@ -118,9 +118,13 @@ static int lpass_cc_sc7280_probe(struct
 	ret = pm_clk_add(&pdev->dev, "iface");
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to acquire iface clock\n");
-		goto destroy_pm_clk;
+		goto err_destroy_pm_clk;
 	}
 
+	ret = pm_runtime_resume_and_get(&pdev->dev);
+	if (ret)
+		goto err_destroy_pm_clk;
+
 	if (!of_property_read_bool(pdev->dev.of_node, "qcom,adsp-pil-mode")) {
 		lpass_regmap_config.name = "qdsp6ss";
 		lpass_regmap_config.max_register = 0x3f;
@@ -128,7 +132,7 @@ static int lpass_cc_sc7280_probe(struct
 
 		ret = qcom_cc_probe_by_index(pdev, 0, desc);
 		if (ret)
-			goto destroy_pm_clk;
+			goto err_put_rpm;
 	}
 
 	lpass_regmap_config.name = "top_cc";
@@ -137,11 +141,15 @@ static int lpass_cc_sc7280_probe(struct
 
 	ret = qcom_cc_probe_by_index(pdev, 1, desc);
 	if (ret)
-		goto destroy_pm_clk;
+		goto err_put_rpm;
+
+	pm_runtime_put(&pdev->dev);
 
 	return 0;
 
-destroy_pm_clk:
+err_put_rpm:
+	pm_runtime_put_sync(&pdev->dev);
+err_destroy_pm_clk:
 	pm_clk_destroy(&pdev->dev);
 
 	return ret;


