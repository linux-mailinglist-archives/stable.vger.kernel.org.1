Return-Path: <stable+bounces-110129-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D8FA18E2F
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 10:19:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B0603AC089
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 09:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03EAF20F099;
	Wed, 22 Jan 2025 09:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Hdumu3wj"
X-Original-To: stable@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DF417C220;
	Wed, 22 Jan 2025 09:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737537571; cv=none; b=rSy7iXPZXZ0qGY/6vRspJEI2mZ0LqFXHtLZIouxHDOOAYJk9EraeLdJpedL8vKd5PO7TupQ8+SCN+t0w+JOkS2UamzsnPlU8zQS0UfFdqhkCD9FalkP8l8kWpEPurYxSdYZxOXj+AVEcoNufvYMsOkftXPWUNtEqbisEdwt2yuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737537571; c=relaxed/simple;
	bh=n7/plYjZ8a/vk8cO1ix6RSMJpNzrP7HqGWfJq2oKdmM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DOi9tKcMnBU1nNY5amynLnow3hq6sqIQ8zW+5q1CXRVB1CDg9hL07dgFpOhvvvn5vkmX9g1VZESa3BPAofYq5oIB6GcIQhEJEl7ZR5KzDFbQSGoOhamga8tBB8wkhuEvZyZLhsdb6hLuVflugHFQGHyGi0sy3X3ldXhoQwXzX3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Hdumu3wj; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 478B160008;
	Wed, 22 Jan 2025 09:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1737537562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ONL1/Ez3NsQeRw6Wk3Nm8VxztLs0ZCkJAWZTU0jWOC0=;
	b=Hdumu3wjNxjptWYwI28XoHzQVzDrcxsuMOx2d/F7frDMGU4rKmmVXkECKgxjANby0u38a+
	Bgg2nkJiCdEPDoWG8FIaFWq1bLsAoxl5E7iobmF9kWdQNGh7esj2gKL2fFScljcGCoN1Sy
	WqhPnIP6tEV1jIUhYeKf9Uvn+tK0P25OF+ou5rNZY+EMcKD8tmW8lRuTFmOxg88emlaP6+
	fbJXSbGxxmzxvDSvrKLULMG0XA33CKDvOnFZtfFYViMdoizZlXukRfW0WpZQ1hKTbpPfcl
	8HfJ4Ft/V8SBuAXHr/PR7G6PLSrJj5oPtqd0fRvOdOet8ho4GX9eTtygfbhvhw==
From: Herve Codina <herve.codina@bootlin.com>
To: Lee Jones <lee@kernel.org>,
	Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>,
	Tony Lindgren <tony@atomide.com>,
	Pavel Machek <pavel@ucw.cz>,
	Tomi Valkeinen <tomi.valkeinen@ti.com>,
	Jean-Jacques Hiblot <jjhiblot@ti.com>
Cc: Daniel Thompson <daniel.thompson@linaro.org>,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Herve Codina <herve.codina@bootlin.com>,
	stable@vger.kernel.org
Subject: [PATCH] backlight: led_bl: Hold led_access lock when calling led_sysfs_disable()
Date: Wed, 22 Jan 2025 10:19:14 +0100
Message-ID: <20250122091914.309533-1-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

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
---
 drivers/video/backlight/led_bl.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

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
-- 
2.47.1


