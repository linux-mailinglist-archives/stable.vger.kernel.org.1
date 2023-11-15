Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 095187ED464
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:57:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344643AbjKOU56 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 15:57:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344567AbjKOU5d (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 15:57:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F8010C6
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 12:57:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38BA3C32793;
        Wed, 15 Nov 2023 20:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700081363;
        bh=NJYNLVJMiWy77bOopTInqcUMLf8xV/bTdY2VWSPlcFM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v1xaFE+XuG+v9rL0gPoAByiIfnyt0RhMG/dtit2rjDtN0JCtEVrM8DE964T68ukCx
         ukB+/JXxgkBYr2OtFFIzEk8Iw63KiQvFZ/eqdDCZgk3TBi++FiGuCaZRfPBSIYvD53
         YF0A+qr293e6X0k9ioFv6psHE6rVfyjjw+BMtJek=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dragos Bogdan <dragos.bogdan@analog.com>,
        Nuno Sa <nuno.sa@analog.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 081/244] hwmon: (axi-fan-control) Fix possible NULL pointer dereference
Date:   Wed, 15 Nov 2023 15:34:33 -0500
Message-ID: <20231115203553.220083968@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115203548.387164783@linuxfoundation.org>
References: <20231115203548.387164783@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

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
index d2092c17d9935..7af18018a32ff 100644
--- a/drivers/hwmon/axi-fan-control.c
+++ b/drivers/hwmon/axi-fan-control.c
@@ -508,6 +508,21 @@ static int axi_fan_control_probe(struct platform_device *pdev)
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
@@ -521,19 +536,7 @@ static int axi_fan_control_probe(struct platform_device *pdev)
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



