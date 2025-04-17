Return-Path: <stable+bounces-133046-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF066A91AB8
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 13:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4092F5A2908
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 11:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C763B23C8AC;
	Thu, 17 Apr 2025 11:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iSW1P8L4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8709D23C385
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 11:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744889075; cv=none; b=rdjOsUeBXca24JpYX2hvLf7fWEnVcMi+8Z2SZUJyTBegTIZDP+Y+jtDFgd/KEj3HLdZFT1nlyVhAvun7yRjToi3DS7fVZiUdBav2Va2dmkjZeh/7kQlReWKoTbuFEKUpbjvKpaaAsBFArVl9Eb59NOb50sJ+Oek+Gek4adWGXdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744889075; c=relaxed/simple;
	bh=m7njBt7i8ASIxnO87rRk9PyKGdx9JxVk03LIy5t6CjY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=b6LRDEMt1276p65J57nJs35rDuTAGsuTNjpmkBMfwc35q1iQLoeDvBsVyW+uGpQXqUrFcYmDakc3c3LulNsMPX5ufLhMHHF78kAxJTDKQIF70ZZQwUewdDd1sh8cBNdj5yJa9t4xhRPCTAAL9qdqgWzDxaz85FPcyXYE9xiln8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iSW1P8L4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED400C4CEE4;
	Thu, 17 Apr 2025 11:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744889075;
	bh=m7njBt7i8ASIxnO87rRk9PyKGdx9JxVk03LIy5t6CjY=;
	h=Subject:To:Cc:From:Date:From;
	b=iSW1P8L4T2cIM8r022ELSNwaww0PCS3jxBvIKhAyo1AYI2tNjqRqcJroCHA86PvGO
	 tOhbAsTnVnOx9OZvDWlQ7Twh2w8+KgfNaOOh3rvLZBgehFUJ36FWH/s8s0l0aOwsrA
	 bpKmtBIwoyfZedr5odLAHbgVp2mlY8ZyrDmN1tck=
Subject: FAILED: patch "[PATCH] backlight: led_bl: Hold led_access lock when calling" failed to apply to 6.1-stable tree
To: herve.codina@bootlin.com,lee@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 17 Apr 2025 13:12:43 +0200
Message-ID: <2025041743-nintendo-armhole-dbe0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 276822a00db3c1061382b41e72cafc09d6a0ec30
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025041743-nintendo-armhole-dbe0@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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


