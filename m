Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C596F713D43
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjE1TXc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbjE1TXb (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:23:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6357DA3
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:23:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0112F60EE0
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:23:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E6B6C433EF;
        Sun, 28 May 2023 19:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685301809;
        bh=oexZKZr6/5cKWby2jukdlYdWx758CaTd9xzXpzooX9A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0bz935Z/FPe+31jBcYgCo4RFIULfqFKq0hv46hZiui7MqSpDLEYO9cYGkQz6sWaa/
         Rp7nWH2ZF028mYQTA9I3wL8k8ETRUdwu6FckOUvMuWuwLp0l0fUi2fKT7qKbJGTG75
         LiYkYikG7UdwXDViLbOH1adPKpyjNLwHnzGmjfhA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jason Gerecke <jason.gerecke@wacom.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Jiri Kosina <jkosina@suse.cz>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 045/161] HID: wacom: generic: Set battery quirk only when we see battery data
Date:   Sun, 28 May 2023 20:09:29 +0100
Message-Id: <20230528190838.641731069@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190837.051205996@linuxfoundation.org>
References: <20230528190837.051205996@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jason Gerecke <killertofu@gmail.com>

[ Upstream commit bea407a427baa019758f29f4d31b26f008bb8cc6 ]

Some devices will include battery status usages in the HID descriptor
but we won't see that battery data for one reason or another. For example,
AES sensors won't send battery data unless an AES pen is in proximity.
If a user does not have an AES pen but instead only interacts with the
AES touchscreen with their fingers then there is no need for us to create
a battery object. Similarly, if a family of peripherals shares the same
HID descriptor between wired-only and wireless-capable SKUs, users of the
former may never see a battery event and will not want a power_supply
object created.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=217062
Link: https://gitlab.gnome.org/GNOME/gnome-control-center/-/issues/2354
Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
Tested-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/wacom_wac.c | 33 +++++++++++----------------------
 1 file changed, 11 insertions(+), 22 deletions(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 339bc7f1fcedb..819e6d2ca2f3e 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1927,18 +1927,7 @@ static void wacom_map_usage(struct input_dev *input, struct hid_usage *usage,
 static void wacom_wac_battery_usage_mapping(struct hid_device *hdev,
 		struct hid_field *field, struct hid_usage *usage)
 {
-	struct wacom *wacom = hid_get_drvdata(hdev);
-	struct wacom_wac *wacom_wac = &wacom->wacom_wac;
-	struct wacom_features *features = &wacom_wac->features;
-	unsigned equivalent_usage = wacom_equivalent_usage(usage->hid);
-
-	switch (equivalent_usage) {
-	case HID_DG_BATTERYSTRENGTH:
-	case WACOM_HID_WD_BATTERY_LEVEL:
-	case WACOM_HID_WD_BATTERY_CHARGING:
-		features->quirks |= WACOM_QUIRK_BATTERY;
-		break;
-	}
+	return;
 }
 
 static void wacom_wac_battery_event(struct hid_device *hdev, struct hid_field *field,
@@ -1959,18 +1948,21 @@ static void wacom_wac_battery_event(struct hid_device *hdev, struct hid_field *f
 			wacom_wac->hid_data.bat_connected = 1;
 			wacom_wac->hid_data.bat_status = WACOM_POWER_SUPPLY_STATUS_AUTO;
 		}
+		wacom_wac->features.quirks |= WACOM_QUIRK_BATTERY;
 		break;
 	case WACOM_HID_WD_BATTERY_LEVEL:
 		value = value * 100 / (field->logical_maximum - field->logical_minimum);
 		wacom_wac->hid_data.battery_capacity = value;
 		wacom_wac->hid_data.bat_connected = 1;
 		wacom_wac->hid_data.bat_status = WACOM_POWER_SUPPLY_STATUS_AUTO;
+		wacom_wac->features.quirks |= WACOM_QUIRK_BATTERY;
 		break;
 	case WACOM_HID_WD_BATTERY_CHARGING:
 		wacom_wac->hid_data.bat_charging = value;
 		wacom_wac->hid_data.ps_connected = value;
 		wacom_wac->hid_data.bat_connected = 1;
 		wacom_wac->hid_data.bat_status = WACOM_POWER_SUPPLY_STATUS_AUTO;
+		wacom_wac->features.quirks |= WACOM_QUIRK_BATTERY;
 		break;
 	}
 }
@@ -1986,18 +1978,15 @@ static void wacom_wac_battery_report(struct hid_device *hdev,
 {
 	struct wacom *wacom = hid_get_drvdata(hdev);
 	struct wacom_wac *wacom_wac = &wacom->wacom_wac;
-	struct wacom_features *features = &wacom_wac->features;
 
-	if (features->quirks & WACOM_QUIRK_BATTERY) {
-		int status = wacom_wac->hid_data.bat_status;
-		int capacity = wacom_wac->hid_data.battery_capacity;
-		bool charging = wacom_wac->hid_data.bat_charging;
-		bool connected = wacom_wac->hid_data.bat_connected;
-		bool powered = wacom_wac->hid_data.ps_connected;
+	int status = wacom_wac->hid_data.bat_status;
+	int capacity = wacom_wac->hid_data.battery_capacity;
+	bool charging = wacom_wac->hid_data.bat_charging;
+	bool connected = wacom_wac->hid_data.bat_connected;
+	bool powered = wacom_wac->hid_data.ps_connected;
 
-		wacom_notify_battery(wacom_wac, status, capacity, charging,
-				     connected, powered);
-	}
+	wacom_notify_battery(wacom_wac, status, capacity, charging,
+			     connected, powered);
 }
 
 static void wacom_wac_pad_usage_mapping(struct hid_device *hdev,
-- 
2.39.2



