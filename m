Return-Path: <stable+bounces-62478-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8FDB93F347
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 12:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 240121C21EE7
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 10:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC7614372D;
	Mon, 29 Jul 2024 10:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="caUhx/lM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B14C144D24
	for <stable@vger.kernel.org>; Mon, 29 Jul 2024 10:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722250351; cv=none; b=mYfrQDUiv9SdSMPhs/6LDTsRFm9zfJZWAlvPSRtlSe7lNc/HX/Vx7F7NfxDGaF9PBWQgKfDMWp6xZbT0OvFGPTBFzPP03bQgqtxDYshCMJFpZATYpufEj7zQZU8ikrkdi7nXEg7yWaBEaNcAOs8SzaVcOQfprogEyBeVEbvX3C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722250351; c=relaxed/simple;
	bh=cmxOeIaGwl5o639S5ON39i346MFcDWzrIov3I93MUeY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=umtYNdPZOVjt4U2TyoaHeEKt/VWKni25YWPLFAfhoB76YCc85EZ2YN+SsK0aDIGG4b2WrYtxnshNKqYqjcxjkccBrFBUnLeM1Ir1+H0d5TZhEnKsaTmjRUFA0PHk3ruXXAYxlgjgulI0bFbewKrWPMBjmvcWKK8xBb6EAhZyGK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=caUhx/lM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3721C32786;
	Mon, 29 Jul 2024 10:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722250351;
	bh=cmxOeIaGwl5o639S5ON39i346MFcDWzrIov3I93MUeY=;
	h=Subject:To:Cc:From:Date:From;
	b=caUhx/lMI7Da3KQ6WkrpYDw+1kcygZu/F33On+wD8sIdJZBq4aSCXkQ5GY3FIoKZC
	 HsXy1sixcc9XyQcXBn5Rgxo05vMYVYIZbwCvSLpyLRjwf53sWGYCU2IDCcpQgPIJsr
	 JelLgxHDvGP/sDlILG3cBgq8g6Yfwq2v/onBOtXo=
Subject: FAILED: patch "[PATCH] leds: triggers: Flush pending brightness before activating" failed to apply to 5.4-stable tree
To: linux@weissschuh.net,dustin@howett.net,lee@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Jul 2024 12:52:17 +0200
Message-ID: <2024072917-pulsate-subduing-2b97@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x ab477b766edd3bfb6321a6e3df4c790612613fae
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024072917-pulsate-subduing-2b97@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

ab477b766edd ("leds: triggers: Flush pending brightness before activating trigger")
b1bbd20f35e1 ("leds: trigger: Call synchronize_rcu() before calling trig->activate()")
822c91e72eac ("leds: trigger: Store brightness set by led_trigger_event()")
c82a1662d454 ("leds: trigger: Remove unused function led_trigger_rename_static()")
2a5a8fa8b231 ("leds: trigger: use RCU to protect the led_cdevs list")
27af8e2c90fb ("leds: trigger: fix potential deadlock with libata")
93690cdf3060 ("leds: trigger: add support for LED-private device triggers")
ec28a8cfdce6 ("leds: core: Remove extern from header")
11f700022137 ("leds: remove PAGE_SIZE limit of /sys/class/leds/<led>/trigger")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ab477b766edd3bfb6321a6e3df4c790612613fae Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Thu, 13 Jun 2024 17:24:51 +0200
Subject: [PATCH] leds: triggers: Flush pending brightness before activating
 trigger
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The race fixed in timer_trig_activate() between a blocking
set_brightness() call and trigger->activate() can affect any trigger.
So move the call to flush_work() into led_trigger_set() where it can
avoid the race for all triggers.

Fixes: 0db37915d912 ("leds: avoid races with workqueue")
Fixes: 8c0f693c6eff ("leds: avoid flush_work in atomic context")
Cc: stable@vger.kernel.org
Tested-by: Dustin L. Howett <dustin@howett.net>
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Link: https://lore.kernel.org/r/20240613-led-trigger-flush-v2-1-f4f970799d77@weissschuh.net
Signed-off-by: Lee Jones <lee@kernel.org>

diff --git a/drivers/leds/led-triggers.c b/drivers/leds/led-triggers.c
index 59deadb86335..78eb20093b2c 100644
--- a/drivers/leds/led-triggers.c
+++ b/drivers/leds/led-triggers.c
@@ -201,6 +201,12 @@ int led_trigger_set(struct led_classdev *led_cdev, struct led_trigger *trig)
 		 */
 		synchronize_rcu();
 
+		/*
+		 * If "set brightness to 0" is pending in workqueue,
+		 * we don't want that to be reordered after ->activate()
+		 */
+		flush_work(&led_cdev->set_brightness_work);
+
 		ret = 0;
 		if (trig->activate)
 			ret = trig->activate(led_cdev);
diff --git a/drivers/leds/trigger/ledtrig-timer.c b/drivers/leds/trigger/ledtrig-timer.c
index b4688d1d9d2b..1d213c999d40 100644
--- a/drivers/leds/trigger/ledtrig-timer.c
+++ b/drivers/leds/trigger/ledtrig-timer.c
@@ -110,11 +110,6 @@ static int timer_trig_activate(struct led_classdev *led_cdev)
 		led_cdev->flags &= ~LED_INIT_DEFAULT_TRIGGER;
 	}
 
-	/*
-	 * If "set brightness to 0" is pending in workqueue, we don't
-	 * want that to be reordered after blink_set()
-	 */
-	flush_work(&led_cdev->set_brightness_work);
 	led_blink_set(led_cdev, &led_cdev->blink_delay_on,
 		      &led_cdev->blink_delay_off);
 


