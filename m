Return-Path: <stable+bounces-77331-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A24C0985BE0
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 14:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6484C285CFF
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 12:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C5515CD46;
	Wed, 25 Sep 2024 11:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uXF9uDYc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12631C8FA4;
	Wed, 25 Sep 2024 11:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265195; cv=none; b=RSaVtF5bNy0ZaKmvcy2+fcphfir/dCAewX1SaxKQ5Qcy75lGFxZdrMgpdU0rfukh1pZbS1KTvWpJax3xvO1aAER/0wOy09t4yRmHEalspd/zm6ADEoUGLDwfuiLlYx4O2IjnSXqCOVsIL3PNI7f3JcYIbMl+XzOKtNiPGII/P94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265195; c=relaxed/simple;
	bh=OnqE7hMVp7P7mOZDjM+m6mgGSt7B98LSvqkkmRJF8Ss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qLDUq5giukcWWRoC7NpjvLhBEQ3RACr52g9GPmXf4p1nZZC0tvZkM2u/ZF5UIMW+Z8ESn5xYNwzpgi4vXkDOmqUOF+XsDbXMLp3/g28IvrlTYJUVmoTMtSFXYArK6dYxcb0SVIwraTMiGPQct9B689o7PdVC0tdl5YwkroNXu9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uXF9uDYc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 802D1C4CEC7;
	Wed, 25 Sep 2024 11:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727265195;
	bh=OnqE7hMVp7P7mOZDjM+m6mgGSt7B98LSvqkkmRJF8Ss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uXF9uDYcSpdnuBG/9JII0fZwuAI7f5s8DPy13P4wi6ioaM2v5grp1OuKbo0DCdsi/
	 4A50htuPaw6sTAreEcFbyx+eVpmBagX/3wFCdWW00ehxZrdV7OohudiPP5iTvWVNic
	 9LjVS2XwhqV+QSgbgG5NOtYtb9iKzmB1qxCZ0kLS469Obi0dqbUCTdz8lFptI5V7YJ
	 6JYGkD2PvfJIONTZDNsVPbwZJB2rzPqOvvbLhpbrTETT21mGomGwleMEAWtu918dnT
	 j1ZRXSsvlLUj9yR2o5wJeQe/b1dqjMA02kU0KuEuNP9YJa9qn+RUr8Hv+fpx7u0lVh
	 loflIzLeYrXEw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 233/244] platform/x86: x86-android-tablets: Adjust Xiaomi Pad 2 bottom bezel touch buttons LED
Date: Wed, 25 Sep 2024 07:27:34 -0400
Message-ID: <20240925113641.1297102-233-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
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


