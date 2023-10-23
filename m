Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05ED17D3321
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233946AbjJWL1B (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233955AbjJWL1B (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:27:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ABF2D6
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:26:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B668C433C9;
        Mon, 23 Oct 2023 11:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698060415;
        bh=8T0hVqP/efRJ1aA1/ZSo/Kx+03sa2R3oyDNeAh6xcWc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vF9Gv7mFzbtsNtTQgUp3KP++LG81WTOm3QUq4cxdMI+SeAOHmqTqzGpkqY2M+nFyD
         8pRFWaK1TdG93tMFyCiihN8b24Ct0o7ShzvwJ9xKlfwyLp83Vr2VYECUVjxyjLy6q3
         6c+IkFa8uaAQHit+C2vZarqjIvxOTNUFqxkMR/BQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
        Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH 6.1 164/196] HID: input: map battery system charging
Date:   Mon, 23 Oct 2023 12:57:09 +0200
Message-ID: <20231023104833.076289949@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104828.488041585@linuxfoundation.org>
References: <20231023104828.488041585@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: José Expósito <jose.exposito89@gmail.com>

commit a608dc1c06397dc50ab773498433432fb5938f92 upstream.

HID descriptors with Battery System (0x85) Charging (0x44) usage are
ignored and POWER_SUPPLY_STATUS_DISCHARGING is always reported to user
space, even when the device is charging.

Map this usage and when it is reported set the right charging status.

In addition, add KUnit tests to make sure that the charging status is
correctly set and reported. They can be run with the usual command:

    $ ./tools/testing/kunit/kunit.py run --kunitconfig=drivers/hid

Signed-off-by: José Expósito <jose.exposito89@gmail.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hid/.kunitconfig     |    1 
 drivers/hid/hid-input-test.c |   80 +++++++++++++++++++++++++++++++++++++++++++
 drivers/hid/hid-input.c      |   36 ++++++++++++++++++-
 include/linux/hid.h          |    2 +
 4 files changed, 117 insertions(+), 2 deletions(-)
 create mode 100644 drivers/hid/hid-input-test.c

--- a/drivers/hid/.kunitconfig
+++ b/drivers/hid/.kunitconfig
@@ -1,5 +1,6 @@
 CONFIG_KUNIT=y
 CONFIG_USB=y
 CONFIG_USB_HID=y
+CONFIG_HID_BATTERY_STRENGTH=y
 CONFIG_HID_UCLOGIC=y
 CONFIG_HID_KUNIT_TEST=y
--- /dev/null
+++ b/drivers/hid/hid-input-test.c
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ *  HID to Linux Input mapping
+ *
+ *  Copyright (c) 2022 José Expósito <jose.exposito89@gmail.com>
+ */
+
+#include <kunit/test.h>
+
+static void hid_test_input_set_battery_charge_status(struct kunit *test)
+{
+	struct hid_device *dev;
+	bool handled;
+
+	dev = kunit_kzalloc(test, sizeof(*dev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
+
+	handled = hidinput_set_battery_charge_status(dev, HID_DG_HEIGHT, 0);
+	KUNIT_EXPECT_FALSE(test, handled);
+	KUNIT_EXPECT_EQ(test, dev->battery_charge_status, POWER_SUPPLY_STATUS_UNKNOWN);
+
+	handled = hidinput_set_battery_charge_status(dev, HID_BAT_CHARGING, 0);
+	KUNIT_EXPECT_TRUE(test, handled);
+	KUNIT_EXPECT_EQ(test, dev->battery_charge_status, POWER_SUPPLY_STATUS_DISCHARGING);
+
+	handled = hidinput_set_battery_charge_status(dev, HID_BAT_CHARGING, 1);
+	KUNIT_EXPECT_TRUE(test, handled);
+	KUNIT_EXPECT_EQ(test, dev->battery_charge_status, POWER_SUPPLY_STATUS_CHARGING);
+}
+
+static void hid_test_input_get_battery_property(struct kunit *test)
+{
+	struct power_supply *psy;
+	struct hid_device *dev;
+	union power_supply_propval val;
+	int ret;
+
+	dev = kunit_kzalloc(test, sizeof(*dev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
+	dev->battery_avoid_query = true;
+
+	psy = kunit_kzalloc(test, sizeof(*psy), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, psy);
+	psy->drv_data = dev;
+
+	dev->battery_status = HID_BATTERY_UNKNOWN;
+	dev->battery_charge_status = POWER_SUPPLY_STATUS_CHARGING;
+	ret = hidinput_get_battery_property(psy, POWER_SUPPLY_PROP_STATUS, &val);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, val.intval, POWER_SUPPLY_STATUS_UNKNOWN);
+
+	dev->battery_status = HID_BATTERY_REPORTED;
+	dev->battery_charge_status = POWER_SUPPLY_STATUS_CHARGING;
+	ret = hidinput_get_battery_property(psy, POWER_SUPPLY_PROP_STATUS, &val);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, val.intval, POWER_SUPPLY_STATUS_CHARGING);
+
+	dev->battery_status = HID_BATTERY_REPORTED;
+	dev->battery_charge_status = POWER_SUPPLY_STATUS_DISCHARGING;
+	ret = hidinput_get_battery_property(psy, POWER_SUPPLY_PROP_STATUS, &val);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, val.intval, POWER_SUPPLY_STATUS_DISCHARGING);
+}
+
+static struct kunit_case hid_input_tests[] = {
+	KUNIT_CASE(hid_test_input_set_battery_charge_status),
+	KUNIT_CASE(hid_test_input_get_battery_property),
+	{ }
+};
+
+static struct kunit_suite hid_input_test_suite = {
+	.name = "hid_input",
+	.test_cases = hid_input_tests,
+};
+
+kunit_test_suite(hid_input_test_suite);
+
+MODULE_DESCRIPTION("HID input KUnit tests");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("José Expósito <jose.exposito89@gmail.com>");
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -492,7 +492,7 @@ static int hidinput_get_battery_property
 		if (dev->battery_status == HID_BATTERY_UNKNOWN)
 			val->intval = POWER_SUPPLY_STATUS_UNKNOWN;
 		else
-			val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
+			val->intval = dev->battery_charge_status;
 		break;
 
 	case POWER_SUPPLY_PROP_SCOPE:
@@ -560,6 +560,7 @@ static int hidinput_setup_battery(struct
 	dev->battery_max = max;
 	dev->battery_report_type = report_type;
 	dev->battery_report_id = field->report->id;
+	dev->battery_charge_status = POWER_SUPPLY_STATUS_DISCHARGING;
 
 	/*
 	 * Stylus is normally not connected to the device and thus we
@@ -626,6 +627,20 @@ static void hidinput_update_battery(stru
 		power_supply_changed(dev->battery);
 	}
 }
+
+static bool hidinput_set_battery_charge_status(struct hid_device *dev,
+					       unsigned int usage, int value)
+{
+	switch (usage) {
+	case HID_BAT_CHARGING:
+		dev->battery_charge_status = value ?
+					     POWER_SUPPLY_STATUS_CHARGING :
+					     POWER_SUPPLY_STATUS_DISCHARGING;
+		return true;
+	}
+
+	return false;
+}
 #else  /* !CONFIG_HID_BATTERY_STRENGTH */
 static int hidinput_setup_battery(struct hid_device *dev, unsigned report_type,
 				  struct hid_field *field, bool is_percentage)
@@ -640,6 +655,12 @@ static void hidinput_cleanup_battery(str
 static void hidinput_update_battery(struct hid_device *dev, int value)
 {
 }
+
+static bool hidinput_set_battery_charge_status(struct hid_device *dev,
+					       unsigned int usage, int value)
+{
+	return false;
+}
 #endif	/* CONFIG_HID_BATTERY_STRENGTH */
 
 static bool hidinput_field_in_collection(struct hid_device *device, struct hid_field *field,
@@ -1239,6 +1260,9 @@ static void hidinput_configure_usage(str
 			hidinput_setup_battery(device, HID_INPUT_REPORT, field, true);
 			usage->type = EV_PWR;
 			return;
+		case HID_BAT_CHARGING:
+			usage->type = EV_PWR;
+			return;
 		}
 		goto unknown;
 
@@ -1481,7 +1505,11 @@ void hidinput_hid_event(struct hid_devic
 		return;
 
 	if (usage->type == EV_PWR) {
-		hidinput_update_battery(hid, value);
+		bool handled = hidinput_set_battery_charge_status(hid, usage->hid, value);
+
+		if (!handled)
+			hidinput_update_battery(hid, value);
+
 		return;
 	}
 
@@ -2346,3 +2374,7 @@ void hidinput_disconnect(struct hid_devi
 	cancel_work_sync(&hid->led_work);
 }
 EXPORT_SYMBOL_GPL(hidinput_disconnect);
+
+#ifdef CONFIG_HID_KUNIT_TEST
+#include "hid-input-test.c"
+#endif
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -312,6 +312,7 @@ struct hid_item {
 #define HID_DG_LATENCYMODE	0x000d0060
 
 #define HID_BAT_ABSOLUTESTATEOFCHARGE	0x00850065
+#define HID_BAT_CHARGING		0x00850044
 
 #define HID_VD_ASUS_CUSTOM_MEDIA_KEYS	0xff310076
 
@@ -612,6 +613,7 @@ struct hid_device {							/* device repo
 	__s32 battery_max;
 	__s32 battery_report_type;
 	__s32 battery_report_id;
+	__s32 battery_charge_status;
 	enum hid_battery_status battery_status;
 	bool battery_avoid_query;
 	ktime_t battery_ratelimit_time;


