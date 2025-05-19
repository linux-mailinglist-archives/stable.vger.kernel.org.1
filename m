Return-Path: <stable+bounces-144790-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F55ABBD42
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 14:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 840EA169F93
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 12:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687B427602F;
	Mon, 19 May 2025 12:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mfgfJ351"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298D51FC0F3
	for <stable@vger.kernel.org>; Mon, 19 May 2025 12:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747656243; cv=none; b=bfwk6vxYC5LHI1zPwjbtT0iMjNnL8y4lCg5nio1N2cc+ljuwxohz5ppDE6/nSgoBaEghZ8if5Zb77KiiprIksv36TNHg10Mushn2TNe0jpfwRsFUKRcx34dc9vqDpcH3/7LTv8CPWTeec/vo0vFokA/GbGAv28+tu6fuonmF4wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747656243; c=relaxed/simple;
	bh=qwmWXWl7EZddsbdIeSizNc5mISs8zVQuqeVRi0sbbGk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=sQjLbbW2CLLdcnccyvI7wJnOlZvdwP7jUkHdVbmQk9COumu6fPhpqXL/4Lf+zy+9+VvqcFK5IgLdVVGsHOXUlN2omnscEYJ4pCeocxvattfMestUmkiTqwfnf60S8zBL8jgWJ7PoI6XPT6DJiO6mgXq4jF8B67nxXcNQ0kpOONs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mfgfJ351; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30A3EC4CEE4;
	Mon, 19 May 2025 12:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747656242;
	bh=qwmWXWl7EZddsbdIeSizNc5mISs8zVQuqeVRi0sbbGk=;
	h=Subject:To:Cc:From:Date:From;
	b=mfgfJ351KfWDs7+iNeyTq+TgSKaGd7aSuiMy7TzTs1hDkHTg0ZJIDZMvIKANNdxjx
	 Ug0H3D1S6mXJ43FFN2f+LzDvPeuS6pgG9N2pHqJvBdA3oRpX0Ab8mq8exrzv3eGHYC
	 1ihgoh/0lbYzRIKtDF8vrZnR1XcCA+G7U6b3DMjM=
Subject: FAILED: patch "[PATCH] gpio: pca953x: fix IRQ storm on system wake up" failed to apply to 5.4-stable tree
To: emanuele.ghidoli@toradex.com,andriy.shevchenko@linux.intel.com,bartosz.golaszewski@linaro.org,francesco.dolcini@toradex.com,geert+renesas@glider.be
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 May 2025 14:03:44 +0200
Message-ID: <2025051943-spoon-zodiac-7ae0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 3e38f946062b4845961ab86b726651b4457b2af8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025051943-spoon-zodiac-7ae0@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3e38f946062b4845961ab86b726651b4457b2af8 Mon Sep 17 00:00:00 2001
From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
Date: Mon, 12 May 2025 11:54:41 +0200
Subject: [PATCH] gpio: pca953x: fix IRQ storm on system wake up

If an input changes state during wake-up and is used as an interrupt
source, the IRQ handler reads the volatile input register to clear the
interrupt mask and deassert the IRQ line. However, the IRQ handler is
triggered before access to the register is granted, causing the read
operation to fail.

As a result, the IRQ handler enters a loop, repeatedly printing the
"failed reading register" message, until `pca953x_resume()` is eventually
called, which restores the driver context and enables access to
registers.

Fix by disabling the IRQ line before entering suspend mode, and
re-enabling it after the driver context is restored in `pca953x_resume()`.

An IRQ can be disabled with disable_irq() and still wake the system as
long as the IRQ has wake enabled, so the wake-up functionality is
preserved.

Fixes: b76574300504 ("gpio: pca953x: Restore registers after suspend/resume cycle")
Cc: stable@vger.kernel.org
Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20250512095441.31645-1-francesco@dolcini.it
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
index 442435ded020..13cc120cf11f 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -1204,6 +1204,8 @@ static int pca953x_restore_context(struct pca953x_chip *chip)
 
 	guard(mutex)(&chip->i2c_lock);
 
+	if (chip->client->irq > 0)
+		enable_irq(chip->client->irq);
 	regcache_cache_only(chip->regmap, false);
 	regcache_mark_dirty(chip->regmap);
 	ret = pca953x_regcache_sync(chip);
@@ -1216,6 +1218,10 @@ static int pca953x_restore_context(struct pca953x_chip *chip)
 static void pca953x_save_context(struct pca953x_chip *chip)
 {
 	guard(mutex)(&chip->i2c_lock);
+
+	/* Disable IRQ to prevent early triggering while regmap "cache only" is on */
+	if (chip->client->irq > 0)
+		disable_irq(chip->client->irq);
 	regcache_cache_only(chip->regmap, true);
 }
 


