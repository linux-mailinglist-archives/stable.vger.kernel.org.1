Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 419227ECE2C
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:41:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234685AbjKOTlV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:41:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjKOTlU (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:41:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF2EA4
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:41:16 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 606AFC433CA;
        Wed, 15 Nov 2023 19:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077276;
        bh=9Ff9pGsYPSDkA/+7wYcjCJf8rb6VNzL6db2HPrf0r8M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wXGVTxBsW3kJt7/SwcAm4+J1exUsA6CuILBPOU45SapDDJvV6ycyQQAvdEgMqrX4x
         tGTSqxMGs0AR9C9gjRBN5W4Ano3EqrLGl4DYieV8zl/5FQmqzc/ATf51F/LjMWv90V
         OSdfblKv6ezdGedrwLBEEqautyfSNpHTPRBTO0Tg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dragos Bogdan <dragos.bogdan@analog.com>,
        Nuno Sa <nuno.sa@analog.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 203/603] hwmon: (axi-fan-control) Fix possible NULL pointer dereference
Date:   Wed, 15 Nov 2023 14:12:28 -0500
Message-ID: <20231115191627.305912536@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dragos Bogdan <dragos.bogdan@analog.com>

[ Upstream commit 2a5b3370a1d9750eca325292e291c8c7cb8cf2e0 ]

axi_fan_control_irq_handler(), dependent on the private
axi_fan_control_data structure, might be called before the hwmon
device is registered. That will cause an "Unable to handle kernel
NULL pointer dereference" error.

Fixes: 8412b410fa5e ("hwmon: Support ADI Fan Control IP")
Signed-off-by: Dragos Bogdan <dragos.bogdan@analog.com>
Signed-off-by: Nuno Sa <nuno.sa@analog.com>
Link: https://lore.kernel.org/r/20231025132100.649499-1-nuno.sa@analog.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/axi-fan-control.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/hwmon/axi-fan-control.c b/drivers/hwmon/axi-fan-control.c
index 5fd136baf1cd3..19b9bf3d75ef9 100644
--- a/drivers/hwmon/axi-fan-control.c
+++ b/drivers/hwmon/axi-fan-control.c
@@ -496,6 +496,21 @@ static int axi_fan_control_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
+	ret = axi_fan_control_init(ctl, pdev->dev.of_node);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to initialize device\n");
+		return ret;
+	}
+
+	ctl->hdev = devm_hwmon_device_register_with_info(&pdev->dev,
+							 name,
+							 ctl,
+							 &axi_chip_info,
+							 axi_fan_control_groups);
+
+	if (IS_ERR(ctl->hdev))
+		return PTR_ERR(ctl->hdev);
+
 	ctl->irq = platform_get_irq(pdev, 0);
 	if (ctl->irq < 0)
 		return ctl->irq;
@@ -509,19 +524,7 @@ static int axi_fan_control_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = axi_fan_control_init(ctl, pdev->dev.of_node);
-	if (ret) {
-		dev_err(&pdev->dev, "Failed to initialize device\n");
-		return ret;
-	}
-
-	ctl->hdev = devm_hwmon_device_register_with_info(&pdev->dev,
-							 name,
-							 ctl,
-							 &axi_chip_info,
-							 axi_fan_control_groups);
-
-	return PTR_ERR_OR_ZERO(ctl->hdev);
+	return 0;
 }
 
 static struct platform_driver axi_fan_control_driver = {
-- 
2.42.0



