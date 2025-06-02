Return-Path: <stable+bounces-149392-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC7C4ACB291
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 16:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67E5B485801
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 14:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F6022F742;
	Mon,  2 Jun 2025 14:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CP8c0W9o"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216472236F4;
	Mon,  2 Jun 2025 14:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748873826; cv=none; b=BKTGdY+hAAOmsvxIcGpMWSzny7wq84a82TenZzQckf2n0BcYu8QDQRaX5ZWC0ws6y7IpvW1k6WrHI3QmWHJ4aV7M50aKiMPgDU1VYus7Jz2UhgyOcQzWtlYUmklQ4OGDMBh4PSK30NwqVzyitvm/wqJGay/f6bbWuDNGjdYob4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748873826; c=relaxed/simple;
	bh=nRAZ1vbq+LhAJrA6j1KP+EjV8WGKLwtCyej7hrZ5SYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dnLe18IOAoJQwr1TN6v2RSvaPv7pNbeCWx7y6F0eh7OJpH5YhOLvQfsN423k7IT907kONaDmnZ3i8KBxSTKKRFnUup62GfodKrt0aak1jCQ7ycgSm9bOay8MCMZVK6sHivP+5OkUSTpyISU/tMg8NEXSbIZWQbt8qrOM5ntS3cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CP8c0W9o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A69B6C4CEEB;
	Mon,  2 Jun 2025 14:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748873826;
	bh=nRAZ1vbq+LhAJrA6j1KP+EjV8WGKLwtCyej7hrZ5SYw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CP8c0W9oep64cqdbGTePY3pSWLnO6MCnNxpbm0wJPVdyIXf93ns3yccfQ4KCqC6GQ
	 QTXvdtjzVo2EblwwvubyFWmBoRXm6owHUs6b6CRs08Wm9SmIrJtwURDufTMoiCvMy+
	 G33q7c5xIjS5u+tZ/je6bKrapaoyl9ze0+9lMsEU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Marek Vasut <marex@denx.de>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 265/444] leds: trigger: netdev: Configure LED blink interval for HW offload
Date: Mon,  2 Jun 2025 15:45:29 +0200
Message-ID: <20250602134351.708379837@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602134340.906731340@linuxfoundation.org>
References: <20250602134340.906731340@linuxfoundation.org>
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

From: Marek Vasut <marex@denx.de>

[ Upstream commit c629c972b310af41e9e072febb6dae9a299edde6 ]

In case a PHY LED implements .blink_set callback to set LED blink
interval, call it even if .hw_control is already set, as that LED
blink interval likely controls the blink rate of that HW offloaded
LED. For PHY LEDs, that can be their activity blinking interval.

The software blinking is not affected by this change.

With this change, the LED interval setting looks something like this:
$ echo netdev > /sys/class/leds/led:green:lan/trigger
$ echo 1 > /sys/class/leds/led:green:lan/brightness
$ echo 250 > /sys/class/leds/led:green:lan/interval

Signed-off-by: Marek Vasut <marex@denx.de>
Link: https://lore.kernel.org/r/20250120113740.91807-1-marex@denx.de
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/leds/trigger/ledtrig-netdev.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/leds/trigger/ledtrig-netdev.c b/drivers/leds/trigger/ledtrig-netdev.c
index 79719fc8a08fb..f8912fa60c498 100644
--- a/drivers/leds/trigger/ledtrig-netdev.c
+++ b/drivers/leds/trigger/ledtrig-netdev.c
@@ -54,6 +54,7 @@ struct led_netdev_data {
 	unsigned int last_activity;
 
 	unsigned long mode;
+	unsigned long blink_delay;
 	int link_speed;
 	u8 duplex;
 
@@ -69,6 +70,10 @@ static void set_baseline_state(struct led_netdev_data *trigger_data)
 	/* Already validated, hw control is possible with the requested mode */
 	if (trigger_data->hw_control) {
 		led_cdev->hw_control_set(led_cdev, trigger_data->mode);
+		if (led_cdev->blink_set) {
+			led_cdev->blink_set(led_cdev, &trigger_data->blink_delay,
+					    &trigger_data->blink_delay);
+		}
 
 		return;
 	}
@@ -386,10 +391,11 @@ static ssize_t interval_store(struct device *dev,
 			      size_t size)
 {
 	struct led_netdev_data *trigger_data = led_trigger_get_drvdata(dev);
+	struct led_classdev *led_cdev = trigger_data->led_cdev;
 	unsigned long value;
 	int ret;
 
-	if (trigger_data->hw_control)
+	if (trigger_data->hw_control && !led_cdev->blink_set)
 		return -EINVAL;
 
 	ret = kstrtoul(buf, 0, &value);
@@ -398,9 +404,13 @@ static ssize_t interval_store(struct device *dev,
 
 	/* impose some basic bounds on the timer interval */
 	if (value >= 5 && value <= 10000) {
-		cancel_delayed_work_sync(&trigger_data->work);
+		if (trigger_data->hw_control) {
+			trigger_data->blink_delay = value;
+		} else {
+			cancel_delayed_work_sync(&trigger_data->work);
 
-		atomic_set(&trigger_data->interval, msecs_to_jiffies(value));
+			atomic_set(&trigger_data->interval, msecs_to_jiffies(value));
+		}
 		set_baseline_state(trigger_data);	/* resets timer */
 	}
 
-- 
2.39.5




