Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0C5A7A3CE0
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241155AbjIQUgU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241190AbjIQUgI (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:36:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9653F10E
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:36:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C767EC433C8;
        Sun, 17 Sep 2023 20:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694982963;
        bh=NFQnkpo+DI1vsdvroWqU4dcSWF9d4eSvsZVH6FMn8QM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P2+leRJSawxxrBdnG2p2CfMnDqO9JKCz2XbjE5QnmH6dRSSQ0Lr2+W0m2+L/+Acj1
         crvOnPbgBmIgGppQZKExLD8yafn32PJeJ62tcRByF288zCSJIusoUOWdJZtV+Cgf40
         Xcvfb4nGK8TXis87GWegprU9O32S4SqfI9OLhI5Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Taniya Das <quic_tdas@quicinc.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Subject: [PATCH 5.15 403/511] clk: qcom: mss-sc7180: fix missing resume during probe
Date:   Sun, 17 Sep 2023 21:13:50 +0200
Message-ID: <20230917191123.521232901@linuxfoundation.org>
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

commit e2349da0fa7ca822cda72f427345b95795358fe7 upstream.

Drivers that enable runtime PM must make sure that the controller is
runtime resumed before accessing its registers to prevent the power
domain from being disabled.

Fixes: 8def929c4097 ("clk: qcom: Add modem clock controller driver for SC7180")
Cc: stable@vger.kernel.org      # 5.7
Cc: Taniya Das <quic_tdas@quicinc.com>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Link: https://lore.kernel.org/r/20230718132902.21430-8-johan+linaro@kernel.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/clk/qcom/mss-sc7180.c |   13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

--- a/drivers/clk/qcom/mss-sc7180.c
+++ b/drivers/clk/qcom/mss-sc7180.c
@@ -87,11 +87,22 @@ static int mss_sc7180_probe(struct platf
 		return ret;
 	}
 
+	ret = pm_runtime_resume_and_get(&pdev->dev);
+	if (ret)
+		return ret;
+
 	ret = qcom_cc_probe(pdev, &mss_sc7180_desc);
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
 
 static const struct dev_pm_ops mss_sc7180_pm_ops = {


