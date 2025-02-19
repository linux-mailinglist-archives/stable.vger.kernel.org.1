Return-Path: <stable+bounces-117597-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B0A2A3B751
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 10:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3268717134B
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 09:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61B91C173F;
	Wed, 19 Feb 2025 09:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZbXeayPR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829E61E51F5;
	Wed, 19 Feb 2025 09:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739955783; cv=none; b=F/wxtir1CW3o1qLu7h4AT0yeP1OVuQkHVmP1YvfFtdsoke6/vhoMXmhDFvlRbYq6o3CJi6voYfCjkx7KYvNM+0NGjR8qLPhLibYeaNUd/tQRR65aeRckq/OVzAioaUzxJe6YS4LzO+SuuHsqOAZz7eXIGEyGzIJJSbj3DM6Pq/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739955783; c=relaxed/simple;
	bh=HzrI3LPJQITX8VsdtlOVf+rBktT2AuDjFDnp+NFyNGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N4UFlJeYULg45m/v94lsNPZTDhQUqyD+Kc+8exDiqD5lJti6e009gFPu17lPlw/d0UaQmNEsCdW+rTKts+jB8K/dJgFwq/Lff9n4WCTh6s/7+D5GPkmKax1biJOoNOJOAgaNltPljUWXYhhKqMoWCsN595vZgoqYzykcl8E/PW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZbXeayPR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 025B9C4CEE6;
	Wed, 19 Feb 2025 09:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739955783;
	bh=HzrI3LPJQITX8VsdtlOVf+rBktT2AuDjFDnp+NFyNGU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZbXeayPRDsByvmZc2MOi5jmQC5qHIlkkBuHQoX5/CIR+oRDxZ8Bir+xIfEP5bFK9V
	 Bz+OtOlnbksQggblMt0UIV3qN4oIzlQe6Mu301T8GqamNYaUEjl/bQZ1wS6jjYAv7P
	 NA6ht/hor5D74jAvjqvGFAYRXOG4F2sRj9W9Lf2s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vicki Pfau <vi@endrift.com>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 113/152] HID: hid-steam: Clean up locking
Date: Wed, 19 Feb 2025 09:28:46 +0100
Message-ID: <20250219082554.528116019@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250219082550.014812078@linuxfoundation.org>
References: <20250219082550.014812078@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vicki Pfau <vi@endrift.com>

[ Upstream commit 691ead124a0c35e56633dbb73e43711ff3db23ef ]

This cleans up the locking logic so that the spinlock is consistently used for
access to a small handful of struct variables, and the mutex is exclusively and
consistently used for ensuring that mutliple threads aren't trying to
send/receive reports at the same time. Previously, only some report
transactions were guarded by this mutex, potentially breaking atomicity. The
mutex has been renamed to reflect this usage.

Signed-off-by: Vicki Pfau <vi@endrift.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Stable-dep-of: 79504249d7e2 ("HID: hid-steam: Move hidraw input (un)registering to work")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-steam.c | 122 +++++++++++++++++++++++-----------------
 1 file changed, 69 insertions(+), 53 deletions(-)

diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
index efd297e0ea8c2..57cb58941c9fc 100644
--- a/drivers/hid/hid-steam.c
+++ b/drivers/hid/hid-steam.c
@@ -124,7 +124,7 @@ struct steam_device {
 	struct list_head list;
 	spinlock_t lock;
 	struct hid_device *hdev, *client_hdev;
-	struct mutex mutex;
+	struct mutex report_mutex;
 	bool client_opened;
 	struct input_dev __rcu *input;
 	unsigned long quirks;
@@ -267,21 +267,26 @@ static int steam_get_serial(struct steam_device *steam)
 	 * Send: 0xae 0x15 0x01
 	 * Recv: 0xae 0x15 0x01 serialnumber (10 chars)
 	 */
-	int ret;
+	int ret = 0;
 	u8 cmd[] = {STEAM_CMD_GET_SERIAL, 0x15, 0x01};
 	u8 reply[3 + STEAM_SERIAL_LEN + 1];
 
+	mutex_lock(&steam->report_mutex);
 	ret = steam_send_report(steam, cmd, sizeof(cmd));
 	if (ret < 0)
-		return ret;
+		goto out;
 	ret = steam_recv_report(steam, reply, sizeof(reply));
 	if (ret < 0)
-		return ret;
-	if (reply[0] != 0xae || reply[1] != 0x15 || reply[2] != 0x01)
-		return -EIO;
+		goto out;
+	if (reply[0] != 0xae || reply[1] != 0x15 || reply[2] != 0x01) {
+		ret = -EIO;
+		goto out;
+	}
 	reply[3 + STEAM_SERIAL_LEN] = 0;
 	strscpy(steam->serial_no, reply + 3, sizeof(steam->serial_no));
-	return 0;
+out:
+	mutex_unlock(&steam->report_mutex);
+	return ret;
 }
 
 /*
@@ -291,13 +296,18 @@ static int steam_get_serial(struct steam_device *steam)
  */
 static inline int steam_request_conn_status(struct steam_device *steam)
 {
-	return steam_send_report_byte(steam, STEAM_CMD_REQUEST_COMM_STATUS);
+	int ret;
+	mutex_lock(&steam->report_mutex);
+	ret = steam_send_report_byte(steam, STEAM_CMD_REQUEST_COMM_STATUS);
+	mutex_unlock(&steam->report_mutex);
+	return ret;
 }
 
 static inline int steam_haptic_rumble(struct steam_device *steam,
 				u16 intensity, u16 left_speed, u16 right_speed,
 				u8 left_gain, u8 right_gain)
 {
+	int ret;
 	u8 report[11] = {STEAM_CMD_HAPTIC_RUMBLE, 9};
 
 	report[3] = intensity & 0xFF;
@@ -309,7 +319,10 @@ static inline int steam_haptic_rumble(struct steam_device *steam,
 	report[9] = left_gain;
 	report[10] = right_gain;
 
-	return steam_send_report(steam, report, sizeof(report));
+	mutex_lock(&steam->report_mutex);
+	ret = steam_send_report(steam, report, sizeof(report));
+	mutex_unlock(&steam->report_mutex);
+	return ret;
 }
 
 static void steam_haptic_rumble_cb(struct work_struct *work)
@@ -336,11 +349,14 @@ static int steam_play_effect(struct input_dev *dev, void *data,
 static void steam_set_lizard_mode(struct steam_device *steam, bool enable)
 {
 	if (enable) {
+		mutex_lock(&steam->report_mutex);
 		/* enable esc, enter, cursors */
 		steam_send_report_byte(steam, STEAM_CMD_DEFAULT_MAPPINGS);
 		/* enable mouse */
 		steam_send_report_byte(steam, STEAM_CMD_DEFAULT_MOUSE);
+		mutex_unlock(&steam->report_mutex);
 	} else {
+		mutex_lock(&steam->report_mutex);
 		/* disable esc, enter, cursor */
 		steam_send_report_byte(steam, STEAM_CMD_CLEAR_MAPPINGS);
 
@@ -352,11 +368,13 @@ static void steam_set_lizard_mode(struct steam_device *steam, bool enable)
 				STEAM_REG_RPAD_CLICK_PRESSURE, 0xFFFF, /* disable clicky pad */
 				STEAM_REG_WATCHDOG_ENABLE, 0, /* disable watchdog that tests if Steam is active */
 				0);
+			mutex_unlock(&steam->report_mutex);
 		} else {
 			steam_write_registers(steam,
 				STEAM_REG_LPAD_MODE, 0x07, /* disable mouse */
 				STEAM_REG_RPAD_MODE, 0x07, /* disable mouse */
 				0);
+			mutex_unlock(&steam->report_mutex);
 		}
 	}
 }
@@ -364,22 +382,29 @@ static void steam_set_lizard_mode(struct steam_device *steam, bool enable)
 static int steam_input_open(struct input_dev *dev)
 {
 	struct steam_device *steam = input_get_drvdata(dev);
+	unsigned long flags;
+	bool set_lizard_mode;
 
-	mutex_lock(&steam->mutex);
-	if (!steam->client_opened && lizard_mode)
+	spin_lock_irqsave(&steam->lock, flags);
+	set_lizard_mode = !steam->client_opened && lizard_mode;
+	spin_unlock_irqrestore(&steam->lock, flags);
+	if (set_lizard_mode)
 		steam_set_lizard_mode(steam, false);
-	mutex_unlock(&steam->mutex);
+
 	return 0;
 }
 
 static void steam_input_close(struct input_dev *dev)
 {
 	struct steam_device *steam = input_get_drvdata(dev);
+	unsigned long flags;
+	bool set_lizard_mode;
 
-	mutex_lock(&steam->mutex);
-	if (!steam->client_opened && lizard_mode)
+	spin_lock_irqsave(&steam->lock, flags);
+	set_lizard_mode = !steam->client_opened && lizard_mode;
+	spin_unlock_irqrestore(&steam->lock, flags);
+	if (set_lizard_mode)
 		steam_set_lizard_mode(steam, true);
-	mutex_unlock(&steam->mutex);
 }
 
 static enum power_supply_property steam_battery_props[] = {
@@ -624,6 +649,7 @@ static int steam_register(struct steam_device *steam)
 {
 	int ret;
 	bool client_opened;
+	unsigned long flags;
 
 	/*
 	 * This function can be called several times in a row with the
@@ -636,11 +662,9 @@ static int steam_register(struct steam_device *steam)
 		 * Unlikely, but getting the serial could fail, and it is not so
 		 * important, so make up a serial number and go on.
 		 */
-		mutex_lock(&steam->mutex);
 		if (steam_get_serial(steam) < 0)
 			strscpy(steam->serial_no, "XXXXXXXXXX",
 					sizeof(steam->serial_no));
-		mutex_unlock(&steam->mutex);
 
 		hid_info(steam->hdev, "Steam Controller '%s' connected",
 				steam->serial_no);
@@ -655,15 +679,13 @@ static int steam_register(struct steam_device *steam)
 		mutex_unlock(&steam_devices_lock);
 	}
 
-	mutex_lock(&steam->mutex);
+	spin_lock_irqsave(&steam->lock, flags);
 	client_opened = steam->client_opened;
-	if (!client_opened)
+	spin_unlock_irqrestore(&steam->lock, flags);
+	if (!client_opened) {
 		steam_set_lizard_mode(steam, lizard_mode);
-	mutex_unlock(&steam->mutex);
-
-	if (!client_opened)
 		ret = steam_input_register(steam);
-	else
+	} else
 		ret = 0;
 
 	return ret;
@@ -746,10 +768,11 @@ static void steam_client_ll_stop(struct hid_device *hdev)
 static int steam_client_ll_open(struct hid_device *hdev)
 {
 	struct steam_device *steam = hdev->driver_data;
+	unsigned long flags;
 
-	mutex_lock(&steam->mutex);
+	spin_lock_irqsave(&steam->lock, flags);
 	steam->client_opened = true;
-	mutex_unlock(&steam->mutex);
+	spin_unlock_irqrestore(&steam->lock, flags);
 
 	steam_input_unregister(steam);
 
@@ -764,17 +787,14 @@ static void steam_client_ll_close(struct hid_device *hdev)
 	bool connected;
 
 	spin_lock_irqsave(&steam->lock, flags);
-	connected = steam->connected;
+	steam->client_opened = false;
+	connected = steam->connected && !steam->client_opened;
 	spin_unlock_irqrestore(&steam->lock, flags);
 
-	mutex_lock(&steam->mutex);
-	steam->client_opened = false;
-	if (connected)
+	if (connected) {
 		steam_set_lizard_mode(steam, lizard_mode);
-	mutex_unlock(&steam->mutex);
-
-	if (connected)
 		steam_input_register(steam);
+	}
 }
 
 static int steam_client_ll_raw_request(struct hid_device *hdev,
@@ -860,19 +880,12 @@ static int steam_probe(struct hid_device *hdev,
 	steam->hdev = hdev;
 	hid_set_drvdata(hdev, steam);
 	spin_lock_init(&steam->lock);
-	mutex_init(&steam->mutex);
+	mutex_init(&steam->report_mutex);
 	steam->quirks = id->driver_data;
 	INIT_WORK(&steam->work_connect, steam_work_connect_cb);
 	INIT_LIST_HEAD(&steam->list);
 	INIT_WORK(&steam->rumble_work, steam_haptic_rumble_cb);
 
-	steam->client_hdev = steam_create_client_hid(hdev);
-	if (IS_ERR(steam->client_hdev)) {
-		ret = PTR_ERR(steam->client_hdev);
-		goto client_hdev_fail;
-	}
-	steam->client_hdev->driver_data = steam;
-
 	/*
 	 * With the real steam controller interface, do not connect hidraw.
 	 * Instead, create the client_hid and connect that.
@@ -881,10 +894,6 @@ static int steam_probe(struct hid_device *hdev,
 	if (ret)
 		goto hid_hw_start_fail;
 
-	ret = hid_add_device(steam->client_hdev);
-	if (ret)
-		goto client_hdev_add_fail;
-
 	ret = hid_hw_open(hdev);
 	if (ret) {
 		hid_err(hdev,
@@ -910,15 +919,26 @@ static int steam_probe(struct hid_device *hdev,
 		}
 	}
 
+	steam->client_hdev = steam_create_client_hid(hdev);
+	if (IS_ERR(steam->client_hdev)) {
+		ret = PTR_ERR(steam->client_hdev);
+		goto client_hdev_fail;
+	}
+	steam->client_hdev->driver_data = steam;
+
+	ret = hid_add_device(steam->client_hdev);
+	if (ret)
+		goto client_hdev_add_fail;
+
 	return 0;
 
-input_register_fail:
-hid_hw_open_fail:
 client_hdev_add_fail:
 	hid_hw_stop(hdev);
-hid_hw_start_fail:
-	hid_destroy_device(steam->client_hdev);
 client_hdev_fail:
+	hid_destroy_device(steam->client_hdev);
+input_register_fail:
+hid_hw_open_fail:
+hid_hw_start_fail:
 	cancel_work_sync(&steam->work_connect);
 	cancel_work_sync(&steam->rumble_work);
 steam_alloc_fail:
@@ -936,12 +956,10 @@ static void steam_remove(struct hid_device *hdev)
 		return;
 	}
 
+	cancel_work_sync(&steam->work_connect);
 	hid_destroy_device(steam->client_hdev);
-	mutex_lock(&steam->mutex);
 	steam->client_hdev = NULL;
 	steam->client_opened = false;
-	mutex_unlock(&steam->mutex);
-	cancel_work_sync(&steam->work_connect);
 	if (steam->quirks & STEAM_QUIRK_WIRELESS) {
 		hid_info(hdev, "Steam wireless receiver disconnected");
 	}
@@ -1408,10 +1426,8 @@ static int steam_param_set_lizard_mode(const char *val,
 
 	mutex_lock(&steam_devices_lock);
 	list_for_each_entry(steam, &steam_devices, list) {
-		mutex_lock(&steam->mutex);
 		if (!steam->client_opened)
 			steam_set_lizard_mode(steam, lizard_mode);
-		mutex_unlock(&steam->mutex);
 	}
 	mutex_unlock(&steam_devices_lock);
 	return 0;
-- 
2.39.5




