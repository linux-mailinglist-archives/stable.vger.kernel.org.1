Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4972570C930
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235250AbjEVTpl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235267AbjEVTpk (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:45:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4329BE0
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:45:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 077C262A84
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:45:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F202C4339C;
        Mon, 22 May 2023 19:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684784738;
        bh=hVu+a8jVOMe7QOMCNpFFNUq9ZPHGBxRr2Ltzkk0kQoA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q4ogTqErSdnm91uFQv+BGFzIlHkIe3J6U2gOKIyNbJXGOZQSrXwIArBzPXD+XuQtw
         ytuZ5NN3DKPzbVqeZPKcSYP4oLN6wE4W2sN1z+MOGlbFeV0fz2jjjIYQR4PTB66QxI
         TW8fbuMZJSsJCQfn1CILMt04uuFhVo8DCtUuQHdY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hans de Goede <hdegoede@redhat.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 184/364] power: supply: axp288_charger: Use alt usb-id extcon on some x86 android tablets
Date:   Mon, 22 May 2023 20:08:09 +0100
Message-Id: <20230522190417.330026322@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190412.801391872@linuxfoundation.org>
References: <20230522190412.801391872@linuxfoundation.org>
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

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit ce38f3fc0f87a358a9560a3815265a94f1b38c37 ]

x86 ACPI boards which ship with only Android as their factory image may
have pretty broken ACPI tables. This includes broken _AEI ACPI GPIO event
handlers, which are normally used to listen to the micro-USB ID pin and:

1. Switch the USB-mux to the host / device USB controllers
2. Disable Vbus path before enabling the 5V boost (AXP reg 0x30 bit 7)
3. Turn 5V Vboost on / off

On non broken systems where this is not done through an ACPI GPIO event
handler, there is an ACPI INT3496 device describing the involved GPIOs
which are handled by the extcon-intel-int3496 driver; and axp288-charger.ko
listens to this extcon-device and disables the Vbus path when necessary.

On x86 Android boards, with broken ACPI GPIO event handlers, these are
disabled by acpi_quirk_skip_gpio_event_handlers() and an intel-int3496
extcon device is manually instantiated by x86-android-tablets.ko .

Add support to the axp288-charger code for this setup, so that it
properly disables the Vbus path when necessary. Note this uses
acpi_quirk_skip_gpio_event_handlers() to identify these systems,
to avoid the need to add a separate DMI match table for this.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/axp288_charger.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/axp288_charger.c b/drivers/power/supply/axp288_charger.c
index 15219ed43ce95..b5903193e2f96 100644
--- a/drivers/power/supply/axp288_charger.c
+++ b/drivers/power/supply/axp288_charger.c
@@ -836,6 +836,7 @@ static int axp288_charger_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct axp20x_dev *axp20x = dev_get_drvdata(pdev->dev.parent);
 	struct power_supply_config charger_cfg = {};
+	const char *extcon_name = NULL;
 	unsigned int val;
 
 	/*
@@ -872,8 +873,18 @@ static int axp288_charger_probe(struct platform_device *pdev)
 		return PTR_ERR(info->cable.edev);
 	}
 
-	if (acpi_dev_present(USB_HOST_EXTCON_HID, NULL, -1)) {
-		info->otg.cable = extcon_get_extcon_dev(USB_HOST_EXTCON_NAME);
+	/*
+	 * On devices with broken ACPI GPIO event handlers there also is no ACPI
+	 * "INT3496" (USB_HOST_EXTCON_HID) device. x86-android-tablets.ko
+	 * instantiates an "intel-int3496" extcon on these devs as a workaround.
+	 */
+	if (acpi_quirk_skip_gpio_event_handlers())
+		extcon_name = "intel-int3496";
+	else if (acpi_dev_present(USB_HOST_EXTCON_HID, NULL, -1))
+		extcon_name = USB_HOST_EXTCON_NAME;
+
+	if (extcon_name) {
+		info->otg.cable = extcon_get_extcon_dev(extcon_name);
 		if (IS_ERR(info->otg.cable)) {
 			dev_err_probe(dev, PTR_ERR(info->otg.cable),
 				      "extcon_get_extcon_dev(%s) failed\n",
-- 
2.39.2



