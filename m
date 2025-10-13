Return-Path: <stable+bounces-185157-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49041BD50CE
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 18:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9715C485D6E
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 15:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9A830ACF2;
	Mon, 13 Oct 2025 15:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tj92BGXw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8756230ACF0;
	Mon, 13 Oct 2025 15:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760369495; cv=none; b=A5Ejjv6iI5nLKZeb6WEgpD8Xivdt2xcx2f0iG0Nw1ie0KFL0CjxnE47KRcVCN88aJuJsnZQG6pUrSIemsNLvMoqphx8Guv2QUKwAL3BdHGLPLxNiR8Ayx5L+Yc6UsUm6ycd2BdtG8ZPzMH5T0lwgEs2wLoQACq9k2vfbPSYGo/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760369495; c=relaxed/simple;
	bh=68irND2YBxnPDJZHhirtxZkgKsPOUWZk3nDs66hTAX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mX5dJzwTvzNgDQDFxtI0t+HVHYXEhVuOR3BJjBPZisszVe99ch4HzFXgC8kMvqjiUDzNHlw83ZMjIOncZi/6vnI83hrxXy3RTxGaaZ5hiWhtAKZUDvrxcWxf9vwyV3b2hIiDWkVGQ54yJfmjJSgb+iOCREWEhgxY4MSUSXSnRxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tj92BGXw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4F03C4CEE7;
	Mon, 13 Oct 2025 15:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760369495;
	bh=68irND2YBxnPDJZHhirtxZkgKsPOUWZk3nDs66hTAX8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tj92BGXwEaOruIKR3YGhvDg+SehTpH79IBUQ1KeDe3NLnmXXgpmFNQS5w8AnC65My
	 wzvN2puXHNakXKpKvnv4PuzjhVnl6ythfYyz5MNXteOTg23e82l5NIHMLoKG8uvi1V
	 y7IDbyTW/RJLx89jjVBgvHFAbRTY9q+4MAD1OGxM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Douglas Anderson <dianders@chromium.org>,
	Pin-yen Lin <treapking@chromium.org>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17 265/563] HID: i2c-hid: Make elan touch controllers power on after panel is enabled
Date: Mon, 13 Oct 2025 16:42:06 +0200
Message-ID: <20251013144420.877847733@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013144411.274874080@linuxfoundation.org>
References: <20251013144411.274874080@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pin-yen Lin <treapking@chromium.org>

[ Upstream commit cbdd16b818eef876dd2de9d503fe7397a0666cbe ]

Introduce a new HID quirk to indicate that this device has to be enabled
after the panel's backlight is enabled, and update the driver data for
the elan devices to enable this quirk. This cannot be a I2C HID quirk
because the kernel needs to acknowledge this before powering up the
device and read the VID/PID. When this quirk is enabled, register
.panel_enabled()/.panel_disabling() instead for the panel follower.

Also rename the *panel_prepare* functions into *panel_follower* because
they could be called in other situations now.

Fixes: bd3cba00dcc63 ("HID: i2c-hid: elan: Add support for Elan eKTH6915 i2c-hid touchscreens")
Fixes: d06651bebf99e ("HID: i2c-hid: elan: Add elan-ekth6a12nay timing")
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Pin-yen Lin <treapking@chromium.org>
Acked-by: Jiri Kosina <jkosina@suse.com>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Link: https://lore.kernel.org/r/20250818115015.2909525-2-treapking@chromium.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/i2c-hid/i2c-hid-core.c    | 46 ++++++++++++++++-----------
 drivers/hid/i2c-hid/i2c-hid-of-elan.c | 11 ++++++-
 include/linux/hid.h                   |  2 ++
 3 files changed, 40 insertions(+), 19 deletions(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
index d3912e3f2f13a..99ce6386176c6 100644
--- a/drivers/hid/i2c-hid/i2c-hid-core.c
+++ b/drivers/hid/i2c-hid/i2c-hid-core.c
@@ -112,9 +112,9 @@ struct i2c_hid {
 
 	struct i2chid_ops	*ops;
 	struct drm_panel_follower panel_follower;
-	struct work_struct	panel_follower_prepare_work;
+	struct work_struct	panel_follower_work;
 	bool			is_panel_follower;
-	bool			prepare_work_finished;
+	bool			panel_follower_work_finished;
 };
 
 static const struct i2c_hid_quirks {
@@ -1110,10 +1110,10 @@ static int i2c_hid_core_probe_panel_follower(struct i2c_hid *ihid)
 	return ret;
 }
 
-static void ihid_core_panel_prepare_work(struct work_struct *work)
+static void ihid_core_panel_follower_work(struct work_struct *work)
 {
 	struct i2c_hid *ihid = container_of(work, struct i2c_hid,
-					    panel_follower_prepare_work);
+					    panel_follower_work);
 	struct hid_device *hid = ihid->hid;
 	int ret;
 
@@ -1130,7 +1130,7 @@ static void ihid_core_panel_prepare_work(struct work_struct *work)
 	if (ret)
 		dev_warn(&ihid->client->dev, "Power on failed: %d\n", ret);
 	else
-		WRITE_ONCE(ihid->prepare_work_finished, true);
+		WRITE_ONCE(ihid->panel_follower_work_finished, true);
 
 	/*
 	 * The work APIs provide a number of memory ordering guarantees
@@ -1139,12 +1139,12 @@ static void ihid_core_panel_prepare_work(struct work_struct *work)
 	 * guarantee that a write that happened in the work is visible after
 	 * cancel_work_sync(). We'll add a write memory barrier here to match
 	 * with i2c_hid_core_panel_unpreparing() to ensure that our write to
-	 * prepare_work_finished is visible there.
+	 * panel_follower_work_finished is visible there.
 	 */
 	smp_wmb();
 }
 
-static int i2c_hid_core_panel_prepared(struct drm_panel_follower *follower)
+static int i2c_hid_core_panel_follower_resume(struct drm_panel_follower *follower)
 {
 	struct i2c_hid *ihid = container_of(follower, struct i2c_hid, panel_follower);
 
@@ -1152,29 +1152,36 @@ static int i2c_hid_core_panel_prepared(struct drm_panel_follower *follower)
 	 * Powering on a touchscreen can be a slow process. Queue the work to
 	 * the system workqueue so we don't block the panel's power up.
 	 */
-	WRITE_ONCE(ihid->prepare_work_finished, false);
-	schedule_work(&ihid->panel_follower_prepare_work);
+	WRITE_ONCE(ihid->panel_follower_work_finished, false);
+	schedule_work(&ihid->panel_follower_work);
 
 	return 0;
 }
 
-static int i2c_hid_core_panel_unpreparing(struct drm_panel_follower *follower)
+static int i2c_hid_core_panel_follower_suspend(struct drm_panel_follower *follower)
 {
 	struct i2c_hid *ihid = container_of(follower, struct i2c_hid, panel_follower);
 
-	cancel_work_sync(&ihid->panel_follower_prepare_work);
+	cancel_work_sync(&ihid->panel_follower_work);
 
-	/* Match with ihid_core_panel_prepare_work() */
+	/* Match with ihid_core_panel_follower_work() */
 	smp_rmb();
-	if (!READ_ONCE(ihid->prepare_work_finished))
+	if (!READ_ONCE(ihid->panel_follower_work_finished))
 		return 0;
 
 	return i2c_hid_core_suspend(ihid, true);
 }
 
-static const struct drm_panel_follower_funcs i2c_hid_core_panel_follower_funcs = {
-	.panel_prepared = i2c_hid_core_panel_prepared,
-	.panel_unpreparing = i2c_hid_core_panel_unpreparing,
+static const struct drm_panel_follower_funcs
+				i2c_hid_core_panel_follower_prepare_funcs = {
+	.panel_prepared = i2c_hid_core_panel_follower_resume,
+	.panel_unpreparing = i2c_hid_core_panel_follower_suspend,
+};
+
+static const struct drm_panel_follower_funcs
+				i2c_hid_core_panel_follower_enable_funcs = {
+	.panel_enabled = i2c_hid_core_panel_follower_resume,
+	.panel_disabling = i2c_hid_core_panel_follower_suspend,
 };
 
 static int i2c_hid_core_register_panel_follower(struct i2c_hid *ihid)
@@ -1182,7 +1189,10 @@ static int i2c_hid_core_register_panel_follower(struct i2c_hid *ihid)
 	struct device *dev = &ihid->client->dev;
 	int ret;
 
-	ihid->panel_follower.funcs = &i2c_hid_core_panel_follower_funcs;
+	if (ihid->hid->initial_quirks | HID_QUIRK_POWER_ON_AFTER_BACKLIGHT)
+		ihid->panel_follower.funcs = &i2c_hid_core_panel_follower_enable_funcs;
+	else
+		ihid->panel_follower.funcs = &i2c_hid_core_panel_follower_prepare_funcs;
 
 	/*
 	 * If we're not in control of our own power up/power down then we can't
@@ -1237,7 +1247,7 @@ int i2c_hid_core_probe(struct i2c_client *client, struct i2chid_ops *ops,
 	init_waitqueue_head(&ihid->wait);
 	mutex_init(&ihid->cmd_lock);
 	mutex_init(&ihid->reset_lock);
-	INIT_WORK(&ihid->panel_follower_prepare_work, ihid_core_panel_prepare_work);
+	INIT_WORK(&ihid->panel_follower_work, ihid_core_panel_follower_work);
 
 	/* we need to allocate the command buffer without knowing the maximum
 	 * size of the reports. Let's use HID_MIN_BUFFER_SIZE, then we do the
diff --git a/drivers/hid/i2c-hid/i2c-hid-of-elan.c b/drivers/hid/i2c-hid/i2c-hid-of-elan.c
index 3fcff6daa0d3a..0215f217f6d86 100644
--- a/drivers/hid/i2c-hid/i2c-hid-of-elan.c
+++ b/drivers/hid/i2c-hid/i2c-hid-of-elan.c
@@ -8,6 +8,7 @@
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/gpio/consumer.h>
+#include <linux/hid.h>
 #include <linux/i2c.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -23,6 +24,7 @@ struct elan_i2c_hid_chip_data {
 	unsigned int post_power_delay_ms;
 	u16 hid_descriptor_address;
 	const char *main_supply_name;
+	bool power_after_backlight;
 };
 
 struct i2c_hid_of_elan {
@@ -97,6 +99,7 @@ static int i2c_hid_of_elan_probe(struct i2c_client *client)
 {
 	struct i2c_hid_of_elan *ihid_elan;
 	int ret;
+	u32 quirks = 0;
 
 	ihid_elan = devm_kzalloc(&client->dev, sizeof(*ihid_elan), GFP_KERNEL);
 	if (!ihid_elan)
@@ -131,8 +134,12 @@ static int i2c_hid_of_elan_probe(struct i2c_client *client)
 		}
 	}
 
+	if (ihid_elan->chip_data->power_after_backlight)
+		quirks = HID_QUIRK_POWER_ON_AFTER_BACKLIGHT;
+
 	ret = i2c_hid_core_probe(client, &ihid_elan->ops,
-				 ihid_elan->chip_data->hid_descriptor_address, 0);
+				 ihid_elan->chip_data->hid_descriptor_address,
+				 quirks);
 	if (ret)
 		goto err_deassert_reset;
 
@@ -150,6 +157,7 @@ static const struct elan_i2c_hid_chip_data elan_ekth6915_chip_data = {
 	.post_gpio_reset_on_delay_ms = 300,
 	.hid_descriptor_address = 0x0001,
 	.main_supply_name = "vcc33",
+	.power_after_backlight = true,
 };
 
 static const struct elan_i2c_hid_chip_data elan_ekth6a12nay_chip_data = {
@@ -157,6 +165,7 @@ static const struct elan_i2c_hid_chip_data elan_ekth6a12nay_chip_data = {
 	.post_gpio_reset_on_delay_ms = 300,
 	.hid_descriptor_address = 0x0001,
 	.main_supply_name = "vcc33",
+	.power_after_backlight = true,
 };
 
 static const struct elan_i2c_hid_chip_data ilitek_ili9882t_chip_data = {
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 2cc4f1e4ea963..c32425b5d0119 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -364,6 +364,7 @@ struct hid_item {
  * | @HID_QUIRK_HAVE_SPECIAL_DRIVER:
  * | @HID_QUIRK_INCREMENT_USAGE_ON_DUPLICATE:
  * | @HID_QUIRK_IGNORE_SPECIAL_DRIVER
+ * | @HID_QUIRK_POWER_ON_AFTER_BACKLIGHT
  * | @HID_QUIRK_FULLSPEED_INTERVAL:
  * | @HID_QUIRK_NO_INIT_REPORTS:
  * | @HID_QUIRK_NO_IGNORE:
@@ -391,6 +392,7 @@ struct hid_item {
 #define HID_QUIRK_INCREMENT_USAGE_ON_DUPLICATE	BIT(20)
 #define HID_QUIRK_NOINVERT			BIT(21)
 #define HID_QUIRK_IGNORE_SPECIAL_DRIVER		BIT(22)
+#define HID_QUIRK_POWER_ON_AFTER_BACKLIGHT	BIT(23)
 #define HID_QUIRK_FULLSPEED_INTERVAL		BIT(28)
 #define HID_QUIRK_NO_INIT_REPORTS		BIT(29)
 #define HID_QUIRK_NO_IGNORE			BIT(30)
-- 
2.51.0




