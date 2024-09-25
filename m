Return-Path: <stable+bounces-77535-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5668985E2C
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 15:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4998E1F252C4
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880201CD6E0;
	Wed, 25 Sep 2024 12:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uy/yzK8B"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F3F1B654F;
	Wed, 25 Sep 2024 12:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266141; cv=none; b=iC0Ww3hH5Ib4jTKY3PG1W8BmITYtksUpilBYo0jYAZhKLm+hyZYIme23CmghP5DkWBxpZTVIO6klOny82IRl5Dv6Whdd71gYaxLhYZTCoBPI7hYh5XODbA64fFHgD7cVfb2xK1wt0SBqlyYpuvoHHenPNxEm61HJP7C5RzybP8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266141; c=relaxed/simple;
	bh=OnqE7hMVp7P7mOZDjM+m6mgGSt7B98LSvqkkmRJF8Ss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a4iCre6fKJ5GrxrP70zXQIP2cWsvxLsQVbB7WKX+ju9HBVKiyCiT+nflEkmkyMUeW17HP/OA0oGcC+Fi+IHWA5BFolTQWOkeLUOPt7v/ptYvQZeT0C65CeqGfJPSSHhiZxCyysfUiUl1hDQSfFafIfk8NwRahaL1kGmZeB2X08Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uy/yzK8B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47D8DC4CECE;
	Wed, 25 Sep 2024 12:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727266141;
	bh=OnqE7hMVp7P7mOZDjM+m6mgGSt7B98LSvqkkmRJF8Ss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Uy/yzK8BxJJJ1yhL4W/UL6o9+xgYO+YkbRLwFpRWOm3GSGDy1EvR8BRV4IDoEeBUX
	 YaOTKTGJ11+r7q9AgAuKG0c55jn8EC/Mm282yLjX64ET8WKFhtMhbq6hyNnhrub1+B
	 cG+NemGDX5Aeo+15UupBZJSiDm+SXUO0C2yfA+pl0cUpAbWsSyj6uMmGhJVpKFaGxJ
	 LSfRyG6yUIKxpCXAB287ToM4KcG1mOmY0+laxy+94wtP5efa1v2/Xy6pBgd3AfunfN
	 ywypwOrHAhaPmiuIXBxkdgM2Km6upMq9/jpawy5ph/3tQieG7pHQvNEtJd8J8396sV
	 6YUbzfka3olyw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 187/197] platform/x86: x86-android-tablets: Adjust Xiaomi Pad 2 bottom bezel touch buttons LED
Date: Wed, 25 Sep 2024 07:53:26 -0400
Message-ID: <20240925115823.1303019-187-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925115823.1303019-1-sashal@kernel.org>
References: <20240925115823.1303019-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.11
Content-Transfer-Encoding: 8bit

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit df40a23cc34c200cfde559eda7ca540f3ae7bd9e ]

The "input-events" LED trigger used to turn on the backlight LEDs had to
be rewritten to use led_trigger_register_simple() + led_trigger_event()
to fix a serious locking issue.

This means it no longer supports using blink_brightness to set a per LED
brightness for the trigger and it no longer sets LED_CORE_SUSPENDRESUME.

Adjust the MiPad 2 bottom bezel touch buttons LED class device to match:

1. Make LED_FULL the maximum brightness to fix the LED brightness
   being very low when on.
2. Set flags = LED_CORE_SUSPENDRESUME.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/20240916090255.35548-1-hdegoede@redhat.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/x86-android-tablets/other.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/x86-android-tablets/other.c b/drivers/platform/x86/x86-android-tablets/other.c
index eb0e55c69dfed..2549c348c8825 100644
--- a/drivers/platform/x86/x86-android-tablets/other.c
+++ b/drivers/platform/x86/x86-android-tablets/other.c
@@ -670,7 +670,7 @@ static const struct software_node *ktd2026_node_group[] = {
  * is controlled by the "pwm_soc_lpss_2" PWM output.
  */
 #define XIAOMI_MIPAD2_LED_PERIOD_NS		19200
-#define XIAOMI_MIPAD2_LED_DEFAULT_DUTY		 6000 /* From Android kernel */
+#define XIAOMI_MIPAD2_LED_MAX_DUTY_NS		 6000 /* From Android kernel */
 
 static struct pwm_device *xiaomi_mipad2_led_pwm;
 
@@ -679,7 +679,7 @@ static int xiaomi_mipad2_brightness_set(struct led_classdev *led_cdev,
 {
 	struct pwm_state state = {
 		.period = XIAOMI_MIPAD2_LED_PERIOD_NS,
-		.duty_cycle = val,
+		.duty_cycle = XIAOMI_MIPAD2_LED_MAX_DUTY_NS * val / LED_FULL,
 		/* Always set PWM enabled to avoid the pin floating */
 		.enabled = true,
 	};
@@ -701,11 +701,11 @@ static int __init xiaomi_mipad2_init(struct device *dev)
 		return -ENOMEM;
 
 	led_cdev->name = "mipad2:white:touch-buttons-backlight";
-	led_cdev->max_brightness = XIAOMI_MIPAD2_LED_PERIOD_NS;
-	/* "input-events" trigger uses blink_brightness */
-	led_cdev->blink_brightness = XIAOMI_MIPAD2_LED_DEFAULT_DUTY;
+	led_cdev->max_brightness = LED_FULL;
 	led_cdev->default_trigger = "input-events";
 	led_cdev->brightness_set_blocking = xiaomi_mipad2_brightness_set;
+	/* Turn LED off during suspend */
+	led_cdev->flags = LED_CORE_SUSPENDRESUME;
 
 	ret = devm_led_classdev_register(dev, led_cdev);
 	if (ret)
-- 
2.43.0


