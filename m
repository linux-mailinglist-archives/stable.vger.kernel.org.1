Return-Path: <stable+bounces-62474-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C0993F342
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 12:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F6BD1C21E33
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 10:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56350144D31;
	Mon, 29 Jul 2024 10:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IF16a7wn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159E828399
	for <stable@vger.kernel.org>; Mon, 29 Jul 2024 10:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722250338; cv=none; b=BopgxkLTIUNE6gB4GSkJOZ7Zj70K0l5MLArK6/wBzyuiYivUyxRv7m1qU4U5vjZEh5/e7E0GGP4bDNYQ1Qq+8/NWal9ztHLVEy/DbvWe/e7xivRiz+1aHhfSZvTRyxi3Kvxl8Ro4V5iNfCzdzyvuBZbjlvbF7n7NpFmcu8tNGlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722250338; c=relaxed/simple;
	bh=2XXJudRRmNeNQVUO5xSGetLQy/VM14edU9RGVdW/d2s=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ZzCkoe6BV5mpFTsKDNuzVokdFiB01wALNVBfwFDbUD6i2ptmGlYPjkt6IUIXbsQXrkUW0od+dR99ZgdcloF/wrdNqGMay4OTpFO1hy4TySAu5yZHTYQFZm3iA7Iv1nFt2bNBjXeR5BIyTry6lT4xlJJDcLbdw5hWCQ0TdytbblE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IF16a7wn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 261A5C32786;
	Mon, 29 Jul 2024 10:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722250337;
	bh=2XXJudRRmNeNQVUO5xSGetLQy/VM14edU9RGVdW/d2s=;
	h=Subject:To:Cc:From:Date:From;
	b=IF16a7wnVfXgFYMpuvM29iHhxCPx+itWizOXSBYuyBwogjqyMN6uqExbjcxM7wV4d
	 D1S0fBvpNMFfFr4HVLKCxUzpgmA5yZOUDvG+YzMtZJxahYIwbuoVYpVpeM/l8ADFug
	 jkhTLMaiujrnK3gBy00y/f/L0QhU+Dy358qUpeLY=
Subject: FAILED: patch "[PATCH] leds: triggers: Flush pending brightness before activating" failed to apply to 6.6-stable tree
To: linux@weissschuh.net,dustin@howett.net,lee@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Jul 2024 12:52:14 +0200
Message-ID: <2024072914-fiddle-little-c002@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x ab477b766edd3bfb6321a6e3df4c790612613fae
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024072914-fiddle-little-c002@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

ab477b766edd ("leds: triggers: Flush pending brightness before activating trigger")
b1bbd20f35e1 ("leds: trigger: Call synchronize_rcu() before calling trig->activate()")
822c91e72eac ("leds: trigger: Store brightness set by led_trigger_event()")
c82a1662d454 ("leds: trigger: Remove unused function led_trigger_rename_static()")

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
 


