Return-Path: <stable+bounces-130272-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21363A803E1
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 14:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAE88442D6F
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 11:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10842690DB;
	Tue,  8 Apr 2025 11:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VSTc/Boq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A33E22257E;
	Tue,  8 Apr 2025 11:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744113276; cv=none; b=Fl5z5s/EzxlHnZ5wO10VfKkI3yWtgRC/45Vjx+t0fU0/5vL2ON4EEALieJnutsctr28rZ3pW/qSYTW+WqPxFZn5NkxgUcoP2aBhQUOAugJIkWub5sztlVJkgoNgTmiR5ys375KYYptk+64GKnfV9F1NGI+Ec53ss9yw5FhdM52U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744113276; c=relaxed/simple;
	bh=Eru7mMB4dlp3AzOmv50EpWWb4Fl4wMbrshcAd3BZp+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A6L2zPflMj4xwmvQIUBCYNCJEsgoEhR6YzHYJTEFXaZLHQS4ZuZXAQTOp4txxIyKqOocE94nLJ3Jn4FilEzfPC0CXeO+gyKKrb37quDJlQVKE98LWwAV6Xj/yGUkPv/e3Ydv0ohWnF7ieirrXPhyjKun4G+dtztjpCxdf0N5QNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VSTc/Boq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E02E4C4CEE5;
	Tue,  8 Apr 2025 11:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744113276;
	bh=Eru7mMB4dlp3AzOmv50EpWWb4Fl4wMbrshcAd3BZp+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VSTc/Boqwo25keRX0imyKKYjhPHxmwa6q+lIUr9UvKAGdVBpBGJlUQ+bJBUQhl3Nu
	 8sXH1lr96GeWw1w6vqN3gG28Ilo/N3rgFIF2FyZTzlWyErcfVsjjc6u4+24pA+xeW4
	 D91Xr8wld0AyZmo6bZFX9LL5S/V3CsOXhVVVu9iw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Remi Pommarel <repk@triplefau.lt>,
	Hans de Goede <hdegoede@redhat.com>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 098/268] leds: Fix LED_OFF brightness race
Date: Tue,  8 Apr 2025 12:48:29 +0200
Message-ID: <20250408104831.139134131@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104828.499967190@linuxfoundation.org>
References: <20250408104828.499967190@linuxfoundation.org>
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

From: Remi Pommarel <repk@triplefau.lt>

[ Upstream commit 2c70953b6f535f7698ccbf22c1f5ba26cb6c2816 ]

While commit fa15d8c69238 ("leds: Fix set_brightness_delayed() race")
successfully forces led_set_brightness() to be called with LED_OFF at
least once when switching from blinking to LED on state so that
hw-blinking can be disabled, another race remains. Indeed in
led_set_brightness(LED_OFF) followed by led_set_brightness(any)
scenario the following CPU scheduling can happen:

    CPU0                                     CPU1
    ----                                     ----
 set_brightness_delayed() {
   test_and_clear_bit(BRIGHTNESS_OFF)
                                         led_set_brightness(LED_OFF) {
                                           set_bit(BRIGHTNESS_OFF)
					   queue_work()
                                         }
                                         led_set_brightness(any) {
                                           set_bit(BRIGHTNESS)
					   queue_work() //already queued
                                         }
   test_and_clear_bit(BRIGHTNESS)
     /* LED set with brightness any */
 }

 /* From previous CPU1 queue_work() */
 set_brightness_delayed() {
   test_and_clear_bit(BRIGHTNESS_OFF)
     /* LED turned off */
   test_and_clear_bit(BRIGHTNESS)
     /* Clear from previous run, LED remains off */

In that case the led_set_brightness(LED_OFF)/led_set_brightness(any)
sequence will be effectively executed in reverse order and LED will
remain off.

With the introduction of commit 32360bf6a5d4 ("leds: Introduce ordered
workqueue for LEDs events instead of system_wq") the race is easier to
trigger as sysfs brightness configuration does not wait for
set_brightness_delayed() work to finish (flush_work() removal).

Use delayed_set_value to optionnally re-configure brightness after a
LED_OFF. That way a LED state could be configured more that once but
final state will always be as expected. Ensure that delayed_set_value
modification is seen before set_bit() using smp_mb__before_atomic().

Fixes: fa15d8c69238 ("leds: Fix set_brightness_delayed() race")
Signed-off-by: Remi Pommarel <repk@triplefau.lt>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/19c81177059dab7b656c42063958011a8e4d1a66.1740050412.git.repk@triplefau.lt
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/leds/led-core.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/leds/led-core.c b/drivers/leds/led-core.c
index 214ed81eb0e92..136cb7f7469b6 100644
--- a/drivers/leds/led-core.c
+++ b/drivers/leds/led-core.c
@@ -147,8 +147,19 @@ static void set_brightness_delayed(struct work_struct *ws)
 	 * before this work item runs once. To make sure this works properly
 	 * handle LED_SET_BRIGHTNESS_OFF first.
 	 */
-	if (test_and_clear_bit(LED_SET_BRIGHTNESS_OFF, &led_cdev->work_flags))
+	if (test_and_clear_bit(LED_SET_BRIGHTNESS_OFF, &led_cdev->work_flags)) {
 		set_brightness_delayed_set_brightness(led_cdev, LED_OFF);
+		/*
+		 * The consecutives led_set_brightness(LED_OFF),
+		 * led_set_brightness(LED_FULL) could have been executed out of
+		 * order (LED_FULL first), if the work_flags has been set
+		 * between LED_SET_BRIGHTNESS_OFF and LED_SET_BRIGHTNESS of this
+		 * work. To avoid ending with the LED turned off, turn the LED
+		 * on again.
+		 */
+		if (led_cdev->delayed_set_value != LED_OFF)
+			set_bit(LED_SET_BRIGHTNESS, &led_cdev->work_flags);
+	}
 
 	if (test_and_clear_bit(LED_SET_BRIGHTNESS, &led_cdev->work_flags))
 		set_brightness_delayed_set_brightness(led_cdev, led_cdev->delayed_set_value);
@@ -319,10 +330,13 @@ void led_set_brightness_nopm(struct led_classdev *led_cdev, unsigned int value)
 	 * change is done immediately afterwards (before the work runs),
 	 * it uses a separate work_flag.
 	 */
-	if (value) {
-		led_cdev->delayed_set_value = value;
+	led_cdev->delayed_set_value = value;
+	/* Ensure delayed_set_value is seen before work_flags modification */
+	smp_mb__before_atomic();
+
+	if (value)
 		set_bit(LED_SET_BRIGHTNESS, &led_cdev->work_flags);
-	} else {
+	else {
 		clear_bit(LED_SET_BRIGHTNESS, &led_cdev->work_flags);
 		clear_bit(LED_SET_BLINK, &led_cdev->work_flags);
 		set_bit(LED_SET_BRIGHTNESS_OFF, &led_cdev->work_flags);
-- 
2.39.5




