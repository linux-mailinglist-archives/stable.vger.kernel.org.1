Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 715967ECD39
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:35:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234380AbjKOTfJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:35:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234374AbjKOTfJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:35:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 137B59E
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:35:06 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F3D4C433C8;
        Wed, 15 Nov 2023 19:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076905;
        bh=nL4c9clThsMp8acee4GUj9KWEjxoat7N2qyUdRclRFA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UqwIscWQJAyj+qrFkZEk4cG4D2OE2ykY5r/UkPkSamFRvXEf1GOV0vxlo6c/nL692
         WwWghnUUbtmkJIAjj8JlEB+l1ms/Lx1guL1kVxsfOr9hiNYwQkUeG/AGyE+5aMCejw
         jTjA7Y6BKp0pueild0HucWVKDXyAWp2BimtKR5cI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Mike Looijmans <mike.looijmans@topic.nl>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 459/550] rtc: pcf85363: Allow to wake up system without IRQ
Date:   Wed, 15 Nov 2023 14:17:23 -0500
Message-ID: <20231115191632.671769063@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mike Looijmans <mike.looijmans@topic.nl>

[ Upstream commit 1e786b03705938870dafb629f2248f88d507a0ff ]

When wakeup-source is set in the devicetree, set up the device for
using the output as interrupt instead of clock. This is similar to
how other RTC devices handle this.

This allows the clock chip to turn on the board when wired to do
so in hardware.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
Link: https://lore.kernel.org/r/20230821072013.7072-1-mike.looijmans@topic.nl
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Stable-dep-of: 2be36c09b6b0 ("rtc: pcf85363: fix wrong mask/val parameters in regmap_update_bits call")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/rtc/rtc-pcf85363.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/rtc/rtc-pcf85363.c b/drivers/rtc/rtc-pcf85363.c
index 65b8b1338dbb0..b2b7ea32b961f 100644
--- a/drivers/rtc/rtc-pcf85363.c
+++ b/drivers/rtc/rtc-pcf85363.c
@@ -403,6 +403,7 @@ static int pcf85363_probe(struct i2c_client *client)
 		},
 	};
 	int ret, i, err;
+	bool wakeup_source;
 
 	if (data)
 		config = data;
@@ -432,25 +433,36 @@ static int pcf85363_probe(struct i2c_client *client)
 	pcf85363->rtc->ops = &rtc_ops;
 	pcf85363->rtc->range_min = RTC_TIMESTAMP_BEGIN_2000;
 	pcf85363->rtc->range_max = RTC_TIMESTAMP_END_2099;
-	clear_bit(RTC_FEATURE_ALARM, pcf85363->rtc->features);
+
+	wakeup_source = device_property_read_bool(&client->dev,
+						  "wakeup-source");
+	if (client->irq > 0 || wakeup_source) {
+		regmap_write(pcf85363->regmap, CTRL_FLAGS, 0);
+		regmap_update_bits(pcf85363->regmap, CTRL_PIN_IO,
+				   PIN_IO_INTA_OUT, PIN_IO_INTAPM);
+	}
 
 	if (client->irq > 0) {
 		unsigned long irqflags = IRQF_TRIGGER_LOW;
 
 		if (dev_fwnode(&client->dev))
 			irqflags = 0;
-
-		regmap_write(pcf85363->regmap, CTRL_FLAGS, 0);
-		regmap_update_bits(pcf85363->regmap, CTRL_PIN_IO,
-				   PIN_IO_INTA_OUT, PIN_IO_INTAPM);
 		ret = devm_request_threaded_irq(&client->dev, client->irq,
 						NULL, pcf85363_rtc_handle_irq,
 						irqflags | IRQF_ONESHOT,
 						"pcf85363", client);
-		if (ret)
-			dev_warn(&client->dev, "unable to request IRQ, alarms disabled\n");
-		else
-			set_bit(RTC_FEATURE_ALARM, pcf85363->rtc->features);
+		if (ret) {
+			dev_warn(&client->dev,
+				 "unable to request IRQ, alarms disabled\n");
+			client->irq = 0;
+		}
+	}
+
+	if (client->irq > 0 || wakeup_source) {
+		device_init_wakeup(&client->dev, true);
+		set_bit(RTC_FEATURE_ALARM, pcf85363->rtc->features);
+	} else {
+		clear_bit(RTC_FEATURE_ALARM, pcf85363->rtc->features);
 	}
 
 	ret = devm_rtc_register_device(pcf85363->rtc);
-- 
2.42.0



