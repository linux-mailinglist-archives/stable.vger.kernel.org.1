Return-Path: <stable+bounces-141622-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E1CAAB4F9
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 07:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1E46502453
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023B2487BAB;
	Tue,  6 May 2025 00:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E3qlpiZo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F97283FE7;
	Mon,  5 May 2025 23:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486904; cv=none; b=sML55oWPjBfZNoWTftCxFfpSFOqaPe0x9ELd7fv7wUHnUDg4K6X18vIcbhxaajZBsrVgsFliRTf32f8lDF7Si3Lg23OZsFKmSkLcSmMVH58Xx3FJVMJJRc1D1pCH6PCWeruVQFSPVeG0pi+OkW6OXNTsODr7tSOMAmEdaF5uiio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486904; c=relaxed/simple;
	bh=3pn0POrxtmqjwWqo4wAYL5F4MHG8KY2M5HwwboODC/E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TmaQqnA3LET6JpcRHR+QlOKdZ05hMli3LRu0LVAtEKR37cHtfsC0wCqapp8IwGmfUCRJtaCuTkfqxe+/kcAbw3ysEDEQkXuafxk8CwbeDWFurpxb6GXrqLF71vSVNDBC+naz3JMs5F/HT4NfgTc/nJladghl/CYswmCN/VZjn3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E3qlpiZo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B58C3C4CEE4;
	Mon,  5 May 2025 23:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486904;
	bh=3pn0POrxtmqjwWqo4wAYL5F4MHG8KY2M5HwwboODC/E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E3qlpiZojxYXPLar4zmUxlRJMghzoEN8Joqq9cEpd1x01rVbbGbdcrBnw+uWvv6Ye
	 5pG6yMOIzP0VcFQrPuM7pB3QGYYeINbtEafFaHS4e6ukJqVXvBGAyaDSNsnSaT/nd3
	 NIdsGrnBFD3Q+fUZryJmU9cdLkQMfM6ZyHt7m+kLoGcN4gdOXim988AgoUCEmV+rsy
	 O9G1p+yKqaJs0dOx+txQTWzkgS0ZvOpjWgn6lQElmHXysK53Vw57JWEqNbc3WHlyPp
	 PEzokKU2vUAdnqw4t7anhJBpTbNZq77oz1+wWt++QEzwxO7diJFnYy/X6g60hvniQY
	 JkQYQ55NHbKTw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Sasha Levin <sashal@kernel.org>,
	andy@kernel.org,
	willy@haproxy.com,
	ksenija.stanojevic@gmail.com,
	viro@zeniv.linux.org.uk,
	erick.archer@outlook.com,
	haoxiang_li2024@163.com,
	u.kleine-koenig@baylibre.com,
	mingo@kernel.org,
	tglx@linutronix.de,
	gregkh@linuxfoundation.org,
	linux@treblig.org
Subject: [PATCH AUTOSEL 5.15 052/153] auxdisplay: charlcd: Partially revert "Move hwidth and bwidth to struct hd44780_common"
Date: Mon,  5 May 2025 19:11:39 -0400
Message-Id: <20250505231320.2695319-52-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231320.2695319-1-sashal@kernel.org>
References: <20250505231320.2695319-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.181
Content-Transfer-Encoding: 8bit

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit 09965a142078080fe7807bab0f6f1890cb5987a4 ]

Commit 2545c1c948a6 ("auxdisplay: Move hwidth and bwidth to struct
hd44780_common") makes charlcd_alloc() argument-less effectively dropping
the single allocation for the struct charlcd_priv object along with
the driver specific one. Restore that behaviour here.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/auxdisplay/charlcd.c | 5 +++--
 drivers/auxdisplay/charlcd.h | 5 +++--
 drivers/auxdisplay/hd44780.c | 2 +-
 drivers/auxdisplay/lcd2s.c   | 2 +-
 drivers/auxdisplay/panel.c   | 2 +-
 5 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/auxdisplay/charlcd.c b/drivers/auxdisplay/charlcd.c
index 6c010d4efa4ae..313bb7ebc2cfa 100644
--- a/drivers/auxdisplay/charlcd.c
+++ b/drivers/auxdisplay/charlcd.c
@@ -594,18 +594,19 @@ static int charlcd_init(struct charlcd *lcd)
 	return 0;
 }
 
-struct charlcd *charlcd_alloc(void)
+struct charlcd *charlcd_alloc(unsigned int drvdata_size)
 {
 	struct charlcd_priv *priv;
 	struct charlcd *lcd;
 
-	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	priv = kzalloc(sizeof(*priv) + drvdata_size, GFP_KERNEL);
 	if (!priv)
 		return NULL;
 
 	priv->esc_seq.len = -1;
 
 	lcd = &priv->lcd;
+	lcd->drvdata = priv->drvdata;
 
 	return lcd;
 }
diff --git a/drivers/auxdisplay/charlcd.h b/drivers/auxdisplay/charlcd.h
index eed80063a6d20..4bbf106b2dd8a 100644
--- a/drivers/auxdisplay/charlcd.h
+++ b/drivers/auxdisplay/charlcd.h
@@ -49,7 +49,7 @@ struct charlcd {
 		unsigned long y;
 	} addr;
 
-	void *drvdata;
+	void *drvdata;			/* Set by charlcd_alloc() */
 };
 
 /**
@@ -93,7 +93,8 @@ struct charlcd_ops {
 };
 
 void charlcd_backlight(struct charlcd *lcd, enum charlcd_onoff on);
-struct charlcd *charlcd_alloc(void);
+
+struct charlcd *charlcd_alloc(unsigned int drvdata_size);
 void charlcd_free(struct charlcd *lcd);
 
 int charlcd_register(struct charlcd *lcd);
diff --git a/drivers/auxdisplay/hd44780.c b/drivers/auxdisplay/hd44780.c
index 8b690f59df27d..ebaf0ff518f4c 100644
--- a/drivers/auxdisplay/hd44780.c
+++ b/drivers/auxdisplay/hd44780.c
@@ -226,7 +226,7 @@ static int hd44780_probe(struct platform_device *pdev)
 	if (!hdc)
 		return -ENOMEM;
 
-	lcd = charlcd_alloc();
+	lcd = charlcd_alloc(0);
 	if (!lcd)
 		goto fail1;
 
diff --git a/drivers/auxdisplay/lcd2s.c b/drivers/auxdisplay/lcd2s.c
index 2578b2d454397..2ee6875044a9c 100644
--- a/drivers/auxdisplay/lcd2s.c
+++ b/drivers/auxdisplay/lcd2s.c
@@ -307,7 +307,7 @@ static int lcd2s_i2c_probe(struct i2c_client *i2c,
 	if (err < 0)
 		return err;
 
-	lcd = charlcd_alloc();
+	lcd = charlcd_alloc(0);
 	if (!lcd)
 		return -ENOMEM;
 
diff --git a/drivers/auxdisplay/panel.c b/drivers/auxdisplay/panel.c
index eba04c0de7eb3..0f3999b665e70 100644
--- a/drivers/auxdisplay/panel.c
+++ b/drivers/auxdisplay/panel.c
@@ -835,7 +835,7 @@ static void lcd_init(void)
 	if (!hdc)
 		return;
 
-	charlcd = charlcd_alloc();
+	charlcd = charlcd_alloc(0);
 	if (!charlcd) {
 		kfree(hdc);
 		return;
-- 
2.39.5


