Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E66B74C375
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 13:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjGILcq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 07:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233009AbjGILc0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 07:32:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C397495
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 04:32:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A4B960BA4
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 11:32:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F1CFC433C8;
        Sun,  9 Jul 2023 11:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688902344;
        bh=9P9kM6IpkhDOKDcWf9Bqdy+aX30Bqt56Q+QC3y7SJRM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LyZP5XmfP9FWUe9f1L5UIKeeBmhVeWyy2V5brz1nBusZGZ0KIq4dxee82ZoXpxk+i
         VtlWp6UAevHQjRzUmI1+c9kCOZcd0BG4KRbfxdUdP8SOldgDaQXVcMdXq8N50BJvol
         1M5YGONbfgl4f4cq1ybkifVs7kcMxrZCuhPKxanw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hans de Goede <hdegoede@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 343/431] platform/x86: lenovo-yogabook: Fix work race on remove()
Date:   Sun,  9 Jul 2023 13:14:51 +0200
Message-ID: <20230709111459.209685523@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230709111451.101012554@linuxfoundation.org>
References: <20230709111451.101012554@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 9148cd2eb4450a8e9c49c8a14201fb82f651128f ]

When yogabook_wmi_remove() runs yogabook_wmi_work might still be running
and using the devices which yogabook_wmi_remove() puts.

To avoid this move to explicitly cancelling the work rather then using
devm_work_autocancel().

This requires also making the yogabook_backside_hall_irq handler non
devm managed, so that it cannot re-queue the work while
yogabook_wmi_remove() runs.

Fixes: c0549b72d99d ("platform/x86: lenovo-yogabook-wmi: Add driver for Lenovo Yoga Book")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/20230430165807.472798-3-hdegoede@redhat.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/lenovo-yogabook-wmi.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/platform/x86/lenovo-yogabook-wmi.c b/drivers/platform/x86/lenovo-yogabook-wmi.c
index 5f4bd1eec38a9..3a6de4ab74a41 100644
--- a/drivers/platform/x86/lenovo-yogabook-wmi.c
+++ b/drivers/platform/x86/lenovo-yogabook-wmi.c
@@ -2,7 +2,6 @@
 /* WMI driver for Lenovo Yoga Book YB1-X90* / -X91* tablets */
 
 #include <linux/acpi.h>
-#include <linux/devm-helpers.h>
 #include <linux/gpio/consumer.h>
 #include <linux/gpio/machine.h>
 #include <linux/interrupt.h>
@@ -248,10 +247,7 @@ static int yogabook_wmi_probe(struct wmi_device *wdev, const void *context)
 	data->brightness = YB_KBD_BL_DEFAULT;
 	set_bit(YB_KBD_IS_ON, &data->flags);
 	set_bit(YB_DIGITIZER_IS_ON, &data->flags);
-
-	r = devm_work_autocancel(&wdev->dev, &data->work, yogabook_wmi_work);
-	if (r)
-		return r;
+	INIT_WORK(&data->work, yogabook_wmi_work);
 
 	data->kbd_adev = acpi_dev_get_first_match_dev("GDIX1001", NULL, -1);
 	if (!data->kbd_adev) {
@@ -299,10 +295,9 @@ static int yogabook_wmi_probe(struct wmi_device *wdev, const void *context)
 	}
 	data->backside_hall_irq = r;
 
-	r = devm_request_irq(&wdev->dev, data->backside_hall_irq,
-			     yogabook_backside_hall_irq,
-			     IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
-			     "backside_hall_sw", data);
+	r = request_irq(data->backside_hall_irq, yogabook_backside_hall_irq,
+			IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
+			"backside_hall_sw", data);
 	if (r) {
 		dev_err_probe(&wdev->dev, r, "Requesting backside_hall_sw IRQ\n");
 		goto error_put_devs;
@@ -318,11 +313,14 @@ static int yogabook_wmi_probe(struct wmi_device *wdev, const void *context)
 	r = devm_led_classdev_register(&wdev->dev, &data->kbd_bl_led);
 	if (r < 0) {
 		dev_err_probe(&wdev->dev, r, "Registering backlight LED device\n");
-		goto error_put_devs;
+		goto error_free_irq;
 	}
 
 	return 0;
 
+error_free_irq:
+	free_irq(data->backside_hall_irq, data);
+	cancel_work_sync(&data->work);
 error_put_devs:
 	put_device(data->dig_dev);
 	put_device(data->kbd_dev);
@@ -335,6 +333,8 @@ static void yogabook_wmi_remove(struct wmi_device *wdev)
 {
 	struct yogabook_wmi *data = dev_get_drvdata(&wdev->dev);
 
+	free_irq(data->backside_hall_irq, data);
+	cancel_work_sync(&data->work);
 	put_device(data->dig_dev);
 	put_device(data->kbd_dev);
 	acpi_dev_put(data->dig_adev);
-- 
2.39.2



