Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD8117A3CD6
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241136AbjIQUfq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241184AbjIQUfb (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:35:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 665EA115
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:35:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ADE7C433C8;
        Sun, 17 Sep 2023 20:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694982926;
        bh=RdUGNlqLu8aW3BNwtMJy7dqiGhVxPIHDFd9Yj+DoHDI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=016tYytdxWkEuJjrmTpyeIpalUcx21oWPftDM+kO1JlkMG0qAojnnjOTGF93yxBPz
         Y8Qpo6Gkjb7SrJE/dVA1UizngmvDPg7+CFPqiGS7OnVhyQWQb3sWLtV3wH6Q32zn8y
         RxHbGX1p9vx8J2v892xrSmbjW2Uqq/Ahuj0CMuUM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Bjorn Andersson <andersson@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 5.15 393/511] clk: qcom: turingcc-qcs404: fix missing resume during probe
Date:   Sun, 17 Sep 2023 21:13:40 +0200
Message-ID: <20230917191123.284212093@linuxfoundation.org>
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

From: Johan Hovold <johan+linaro@kernel.org>

commit a9f71a033587c9074059132d34c74eabbe95ef26 upstream.

Drivers that enable runtime PM must make sure that the controller is
runtime resumed before accessing its registers to prevent the power
domain from being disabled.

Fixes: 892df0191b29 ("clk: qcom: Add QCS404 TuringCC")
Cc: stable@vger.kernel.org      # 5.2
Cc: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Link: https://lore.kernel.org/r/20230718132902.21430-9-johan+linaro@kernel.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/clk/qcom/turingcc-qcs404.c |   13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

--- a/drivers/clk/qcom/turingcc-qcs404.c
+++ b/drivers/clk/qcom/turingcc-qcs404.c
@@ -124,11 +124,22 @@ static int turingcc_probe(struct platfor
 		return ret;
 	}
 
+	ret = pm_runtime_resume_and_get(&pdev->dev);
+	if (ret)
+		return ret;
+
 	ret = qcom_cc_probe(pdev, &turingcc_desc);
 	if (ret < 0)
-		return ret;
+		goto err_put_rpm;
+
+	pm_runtime_put(&pdev->dev);
 
 	return 0;
+
+err_put_rpm:
+	pm_runtime_put_sync(&pdev->dev);
+
+	return ret;
 }
 
 static const struct dev_pm_ops turingcc_pm_ops = {


