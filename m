Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE8CD7ED0E7
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343884AbjKOT6U (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:58:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343894AbjKOT6S (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:58:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A1FD189
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:58:15 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D87DC433C7;
        Wed, 15 Nov 2023 19:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700078294;
        bh=cz2USZc+Z193fOo2TCclfXh/dBnzDW+KaTqHgjchM0U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2ALYB8M6aFed7yiQUt2jOJQl8CjbmvTMMGDJX5ybdI9SjKbHjT0J0DpJhtNl0xKsa
         /v+x1WSoaC2GZ6bXZ5gp2jIpVXLgmdtYPKgZtF9B7XZcpCDIClNx2vHHyiM041tJcL
         Cn6l4ceXOxKSYlQN6m9Os1V7vzGjIDYGY/cQYSW0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hans de Goede <hdegoede@redhat.com>,
        Benjamin Tissoires <bentiss@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 234/379] HID: logitech-hidpp: Move get_wireless_feature_index() check to hidpp_connect_event()
Date:   Wed, 15 Nov 2023 14:25:09 -0500
Message-ID: <20231115192658.955987374@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115192645.143643130@linuxfoundation.org>
References: <20231115192645.143643130@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit ba9de350509504fb748837b71e23d7e84c83d93c ]

Calling get_wireless_feature_index() from probe() causes
the wireless_feature_index to only get set for unifying devices which
are already connected at probe() time. It does not get set for devices
which connect later.

Fix this by moving get_wireless_feature_index() to hidpp_connect_event(),
this does not make a difference for devices connected at probe() since
probe() will queue the hidpp_connect_event() for those at probe time.

This series has been tested on the following devices:
Logitech Bluetooth Laser Travel Mouse (bluetooth, HID++ 1.0)
Logitech M720 Triathlon (bluetooth, HID++ 4.5)
Logitech M720 Triathlon (unifying, HID++ 4.5)
Logitech K400 Pro (unifying, HID++ 4.1)
Logitech K270 (eQUAD nano Lite, HID++ 2.0)
Logitech M185 (eQUAD nano Lite, HID++ 4.5)
Logitech LX501 keyboard (27 Mhz, HID++ builtin scroll-wheel, HID++ 1.0)
Logitech M-RAZ105 mouse (27 Mhz, HID++ extra mouse buttons, HID++ 1.0)

And by bentiss:
Logitech Touchpad T650 (unifying)
Logitech Touchpad T651 (bluetooth)
Logitech MX Master 3B (BLE)
Logitech G403 (plain USB / Gaming receiver)

Fixes: 0da0a63b7cba ("HID: logitech-hidpp: Support WirelessDeviceStatus connect events")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/20231010102029.111003-4-hdegoede@redhat.com
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-logitech-hidpp.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 2c212f835e8c5..fa1c7e07e220b 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -1757,15 +1757,14 @@ static int hidpp_battery_get_property(struct power_supply *psy,
 /* -------------------------------------------------------------------------- */
 #define HIDPP_PAGE_WIRELESS_DEVICE_STATUS			0x1d4b
 
-static int hidpp_set_wireless_feature_index(struct hidpp_device *hidpp)
+static int hidpp_get_wireless_feature_index(struct hidpp_device *hidpp, u8 *feature_index)
 {
 	u8 feature_type;
 	int ret;
 
 	ret = hidpp_root_get_feature(hidpp,
 				     HIDPP_PAGE_WIRELESS_DEVICE_STATUS,
-				     &hidpp->wireless_feature_index,
-				     &feature_type);
+				     feature_index, &feature_type);
 
 	return ret;
 }
@@ -3999,6 +3998,13 @@ static void hidpp_connect_event(struct hidpp_device *hidpp)
 		}
 	}
 
+	if (hidpp->protocol_major >= 2) {
+		u8 feature_index;
+
+		if (!hidpp_get_wireless_feature_index(hidpp, &feature_index))
+			hidpp->wireless_feature_index = feature_index;
+	}
+
 	if (hidpp->name == hdev->name && hidpp->protocol_major >= 2) {
 		name = hidpp_get_device_name(hidpp);
 		if (name) {
@@ -4241,14 +4247,6 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		hidpp_overwrite_name(hdev);
 	}
 
-	if (connected && hidpp->protocol_major >= 2) {
-		ret = hidpp_set_wireless_feature_index(hidpp);
-		if (ret == -ENOENT)
-			hidpp->wireless_feature_index = 0;
-		else if (ret)
-			goto hid_hw_init_fail;
-	}
-
 	if (connected && (hidpp->quirks & HIDPP_QUIRK_CLASS_WTP)) {
 		ret = wtp_get_config(hidpp);
 		if (ret)
-- 
2.42.0



