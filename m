Return-Path: <stable+bounces-160382-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5500CAFB8C5
	for <lists+stable@lfdr.de>; Mon,  7 Jul 2025 18:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 484D17A271B
	for <lists+stable@lfdr.de>; Mon,  7 Jul 2025 16:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1D722D9E6;
	Mon,  7 Jul 2025 16:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b="Z81NEhW6"
X-Original-To: stable@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EFA22A4E8;
	Mon,  7 Jul 2025 16:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751906321; cv=pass; b=NXumIWJRb1jEBKBjnBm16N8Pcq4CnblsDVGwcKNGMkD+A11IMla0tUgQQCY+MGU7qZn7HPLhVwtd6opW7bfCI4nBAEcR5TEDRdBpDjlrjxPTTfARQeoEfGDTnIcPXAurEkdWrQQwTyaA04mgLkeG14lJHqRD2Hc2dGV5lCXBlWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751906321; c=relaxed/simple;
	bh=XpKnMJqwV7riptPK0Cvr/eXezIQ8tIihZ11L1F0k4ig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K1AowD+eoc5jIJz4jJO/m+eyReKIkbJxjSO6eRx0uOfXw+IjA2et5dy3Wr+kuSt0wMQ+vjJQmv06Vq57ELPPhE96E9FiFQJZ5xd2jDAoEYEvk8y7p+ugu2/WPDnGmo+sDO6OXdg2NFheSeEoV82m72c9lFogcWO0q6XEnwjB+s4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b=Z81NEhW6; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
ARC-Seal: i=1; a=rsa-sha256; t=1751906302; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=dFiIjtTCTSVg5f9LB/3GZSbHEKQuiEeisAtrCTn26YmmKEZD0VIuFpRYjIWPHvvWPqOMcnOLhkvsiFZYSRJiCHizfRbFSvJJFckBHrURwMiYdn0bM3iEdvQOIQPzIwmB/fZezcv4UzvZIQuPzgZ4Vcsa7eFnBBiLIjjfTpssIUE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1751906302; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=IyZ30ONk3667u+R0j5jnQIo/ViwgAs3JR32ehGptRv8=; 
	b=g/ePRwlLglvOV4LWirDHAa0+xaYxJOqzsIvjvjzK6ht0CsVKPhKv+iCeat8r3tudsSpJi8uKi5o591ngpoZdVKjW41aQs183ARDxozf+lfX3k9Nxt7gHDZNi4QfnCHuHzT3+qO4f9eYJnLWSLGyqMU4dIFH87/q5xpAX9mLnXWE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1751906302;
	s=zmail; d=rong.moe; i=i@rong.moe;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=IyZ30ONk3667u+R0j5jnQIo/ViwgAs3JR32ehGptRv8=;
	b=Z81NEhW6zGUDxyt0SzaRes73zfnw0rouDwe6+KMfSPLey454feuXD1P/7dp9F1ke
	syGw17qSwEKCGwbvt49dJNYdcJj7FxcIAuiR76Alf2vSkh7KoxNeaSeFjNgdDLrognA
	OzAejXqhd3Yj3oaaWpKtfK/+BJeFf1V0e1JdFn4Q=
Received: by mx.zohomail.com with SMTPS id 1751906301060801.5068744885242;
	Mon, 7 Jul 2025 09:38:21 -0700 (PDT)
From: Rong Zhang <i@rong.moe>
To: Ike Panhc <ikepanhc@gmail.com>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Rong Zhang <i@rong.moe>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Gergo Koteles <soyer@irl.hu>,
	=?UTF-8?q?Barnab=C3=A1s=20P=C5=91cze?= <pobrn@protonmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] platform/x86: ideapad-laptop: Fix kbd backlight not remembered among boots
Date: Tue,  8 Jul 2025 00:38:07 +0800
Message-ID: <20250707163808.155876-3-i@rong.moe>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250707163808.155876-1-i@rong.moe>
References: <20250707163808.155876-1-i@rong.moe>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

On some models supported by ideapad-laptop, the HW/FW can remember the
state of keyboard backlight among boots. However, it is always turned
off while shutting down, as a side effect of the LED class device
unregistering sequence.

This is inconvenient for users who always prefer turning on the
keyboard backlight. Thus, set LED_RETAIN_AT_SHUTDOWN on the LED class
device so that the state of keyboard backlight gets remembered, which
also aligns with the behavior of manufacturer utilities on Windows.

Fixes: 503325f84bc0 ("platform/x86: ideapad-laptop: add keyboard backlight control support")
Cc: stable@vger.kernel.org
Signed-off-by: Rong Zhang <i@rong.moe>
---
 drivers/platform/x86/ideapad-laptop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
index 62a72b09fc3a..edb9d2fb02ec 100644
--- a/drivers/platform/x86/ideapad-laptop.c
+++ b/drivers/platform/x86/ideapad-laptop.c
@@ -1669,7 +1669,7 @@ static int ideapad_kbd_bl_init(struct ideapad_private *priv)
 	priv->kbd_bl.led.name                    = "platform::" LED_FUNCTION_KBD_BACKLIGHT;
 	priv->kbd_bl.led.brightness_get          = ideapad_kbd_bl_led_cdev_brightness_get;
 	priv->kbd_bl.led.brightness_set_blocking = ideapad_kbd_bl_led_cdev_brightness_set;
-	priv->kbd_bl.led.flags                   = LED_BRIGHT_HW_CHANGED;
+	priv->kbd_bl.led.flags                   = LED_BRIGHT_HW_CHANGED | LED_RETAIN_AT_SHUTDOWN;
 
 	err = led_classdev_register(&priv->platform_device->dev, &priv->kbd_bl.led);
 	if (err)
-- 
2.50.0


