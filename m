Return-Path: <stable+bounces-133048-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01732A91ABC
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 13:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15508444C31
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 11:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46A623C8A5;
	Thu, 17 Apr 2025 11:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yG+Aefu8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754932397B4
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 11:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744889082; cv=none; b=Uob7Xv9AAs8GAhIdWyFfvgq6B0taPVnVgPN4Sn/9oY8k9VRM/GgrOhkX1Jx5hr8v/PsSW6FXhXHTCPb0G+iAT4kEZMQ3y/yrs4j/xgEXXVeJM+LxnJQpcW6oNG0rc6p01TV4ZzcZ7tBA/SHVbRe88pZXBA+9ZkznJEYm26wLZmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744889082; c=relaxed/simple;
	bh=Mv8TZtwk5yDG6ueEGuNBjGKMSEi62U0pW8+AGV7Ydbs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=CbKmbhGTjSIhUSg4NARLUVGAIySZtNUThqA3fc2jsnpJXXyst10ucAysrxtWhMJoqlUuiqVg3kMmoqBwH7Xl3COrJwKFvF8JRcrxCOtSWTOfJsiL7eaFdpSf0uyEUxHbDGbVsoKbMRuR2Iv6V88JIqhbW75H7NGWvbfQFeUM6CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yG+Aefu8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D584CC4CEEA;
	Thu, 17 Apr 2025 11:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744889082;
	bh=Mv8TZtwk5yDG6ueEGuNBjGKMSEi62U0pW8+AGV7Ydbs=;
	h=Subject:To:Cc:From:Date:From;
	b=yG+Aefu8rAhy6FCP2z1f/nShGg7ye0fN76AAcEvtcQk5J/TqrBnfOBinloOON7cbD
	 0gX8EO4cuK1W6/ukjRWSxjQGFxFt/9l4HeHNoCp8HfwXwJO1xn3nvWtBssaNvYfAFy
	 fNEH1CRlqxePwATVAEEYF6MyfsLqjiJxyOo07BsA=
Subject: FAILED: patch "[PATCH] backlight: led_bl: Hold led_access lock when calling" failed to apply to 5.15-stable tree
To: herve.codina@bootlin.com,lee@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 17 Apr 2025 13:12:44 +0200
Message-ID: <2025041744-kite-tasty-461a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 276822a00db3c1061382b41e72cafc09d6a0ec30
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025041744-kite-tasty-461a@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 276822a00db3c1061382b41e72cafc09d6a0ec30 Mon Sep 17 00:00:00 2001
From: Herve Codina <herve.codina@bootlin.com>
Date: Wed, 22 Jan 2025 10:19:14 +0100
Subject: [PATCH] backlight: led_bl: Hold led_access lock when calling
 led_sysfs_disable()

Lockdep detects the following issue on led-backlight removal:
  [  142.315935] ------------[ cut here ]------------
  [  142.315954] WARNING: CPU: 2 PID: 292 at drivers/leds/led-core.c:455 led_sysfs_enable+0x54/0x80
  ...
  [  142.500725] Call trace:
  [  142.503176]  led_sysfs_enable+0x54/0x80 (P)
  [  142.507370]  led_bl_remove+0x80/0xa8 [led_bl]
  [  142.511742]  platform_remove+0x30/0x58
  [  142.515501]  device_remove+0x54/0x90
  ...

Indeed, led_sysfs_enable() has to be called with the led_access
lock held.

Hold the lock when calling led_sysfs_disable().

Fixes: ae232e45acf9 ("backlight: add led-backlight driver")
Cc: stable@vger.kernel.org
Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Link: https://lore.kernel.org/r/20250122091914.309533-1-herve.codina@bootlin.com
Signed-off-by: Lee Jones <lee@kernel.org>

diff --git a/drivers/video/backlight/led_bl.c b/drivers/video/backlight/led_bl.c
index ae34d1ecbfbe..d2db157b2c29 100644
--- a/drivers/video/backlight/led_bl.c
+++ b/drivers/video/backlight/led_bl.c
@@ -229,8 +229,11 @@ static void led_bl_remove(struct platform_device *pdev)
 	backlight_device_unregister(bl);
 
 	led_bl_power_off(priv);
-	for (i = 0; i < priv->nb_leds; i++)
+	for (i = 0; i < priv->nb_leds; i++) {
+		mutex_lock(&priv->leds[i]->led_access);
 		led_sysfs_enable(priv->leds[i]);
+		mutex_unlock(&priv->leds[i]->led_access);
+	}
 }
 
 static const struct of_device_id led_bl_of_match[] = {


