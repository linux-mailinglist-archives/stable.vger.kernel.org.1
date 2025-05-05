Return-Path: <stable+bounces-139947-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2701FAAA2B9
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 839D71884927
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 23:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05F1281516;
	Mon,  5 May 2025 22:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nJd19WKA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C06A280CCD;
	Mon,  5 May 2025 22:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483754; cv=none; b=r7YSxR0JsDLCwl9Ypt/8I77evK23mzbYdynAJCA0aIF3heTfJVviuYIYBXD3nfWN9zyVY3OD8ACLtj5Kcmti0pWVSM8PZrMXIc4tqNsZ06KwJG8IXsZ0zeKwe9UA7YDP+OOW1PU28cRQZdY1sdg9BYcHNcRTy/oVylpyt7clmnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483754; c=relaxed/simple;
	bh=HzpRiViPmWeBz4hfnk5g9GoCznYF1l2O4LsO/KAwZN8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=boAQW27nTlN0ngex3fkFF2u1Za3EXim2+9L6pXR/UfZ0GnnMmnmG4JfYpkYg/lB2x3lZ9isu1jkS8fDYq3DZHSNNlv+MryweYiNN+CFvAeVQF9IeeV5QXtdTTxqVUOGdvP5Pz4HgvbLbsxy7p9bfc24z4R/uE9Q8ComuezGcplo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nJd19WKA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECC7EC4CEE4;
	Mon,  5 May 2025 22:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483754;
	bh=HzpRiViPmWeBz4hfnk5g9GoCznYF1l2O4LsO/KAwZN8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nJd19WKAJuacJULsDa5/uADh14PFTgF2esazdWhSaIqL/Q7rP3edR9HjsIpPwT3I+
	 QiaDbEneyRg55XL5O8tEV2gJ+odgGiNOfwvWWQ5B0GT33vM2qHIiMZ44q8oLNZKLTO
	 Om72AELF0hLOQtwi7w84es50uYOWoNXIHbuH0XYXQJ8lhgEcIazQWI2HWP9DFvLUFO
	 n7ABXcFzaohP1+Z4mcdXfSfWYUZtXytmF9JEnACdvzANgaegb9EfV6vp+DkOISqZRi
	 /I8MaUKj59bAxER13wJl/+TqSukvpWl0bc9XxZ25ZSXOyymiZXBw+COIeSkeYtw2lQ
	 ExKfl2jamrIRQ==
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
	sudipm.mukherjee@gmail.com,
	linux@treblig.org,
	tglx@linutronix.de
Subject: [PATCH AUTOSEL 6.14 200/642] auxdisplay: charlcd: Partially revert "Move hwidth and bwidth to struct hd44780_common"
Date: Mon,  5 May 2025 18:06:56 -0400
Message-Id: <20250505221419.2672473-200-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
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
index 19b619376d48b..09020bb8ad15f 100644
--- a/drivers/auxdisplay/charlcd.c
+++ b/drivers/auxdisplay/charlcd.c
@@ -595,18 +595,19 @@ static int charlcd_init(struct charlcd *lcd)
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
index 4d4287209d04c..d10b89740bcae 100644
--- a/drivers/auxdisplay/charlcd.h
+++ b/drivers/auxdisplay/charlcd.h
@@ -51,7 +51,7 @@ struct charlcd {
 		unsigned long y;
 	} addr;
 
-	void *drvdata;
+	void *drvdata;			/* Set by charlcd_alloc() */
 };
 
 /**
@@ -95,7 +95,8 @@ struct charlcd_ops {
 };
 
 void charlcd_backlight(struct charlcd *lcd, enum charlcd_onoff on);
-struct charlcd *charlcd_alloc(void);
+
+struct charlcd *charlcd_alloc(unsigned int drvdata_size);
 void charlcd_free(struct charlcd *lcd);
 
 int charlcd_register(struct charlcd *lcd);
diff --git a/drivers/auxdisplay/hd44780.c b/drivers/auxdisplay/hd44780.c
index 9d0ae9c02e9ba..1d67fe3243412 100644
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
index a28daa4ffbf75..c71ebb925971b 100644
--- a/drivers/auxdisplay/lcd2s.c
+++ b/drivers/auxdisplay/lcd2s.c
@@ -307,7 +307,7 @@ static int lcd2s_i2c_probe(struct i2c_client *i2c)
 	if (err < 0)
 		return err;
 
-	lcd = charlcd_alloc();
+	lcd = charlcd_alloc(0);
 	if (!lcd)
 		return -ENOMEM;
 
diff --git a/drivers/auxdisplay/panel.c b/drivers/auxdisplay/panel.c
index 6dc8798d01f98..4da142692d55f 100644
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


