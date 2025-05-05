Return-Path: <stable+bounces-141112-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9941CAAB09E
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 153304E2DCA
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A9831CA38;
	Tue,  6 May 2025 00:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NO94QIpn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302B635B95C;
	Mon,  5 May 2025 22:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485102; cv=none; b=h8/hl8DUqdmRfsFaHDEmOeQtMu29ja4Ufyd0tsgaweioxS5sSkixe/tOWLmglIPsKGfgPqeqLGuHsLRkyL9v1TSGJfN+gzidES0DMATr29XMIiqEZBacnc/k9PQeAx0GNCQxttwCgRq/99rqKKTe/mGvCk48CIvgDjAGA8FXH4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485102; c=relaxed/simple;
	bh=W9Hm8XrRthHsKUB9PrcxGZk/2gDj88UVL64AUY00eUA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g/5ce0CS51EH0tzOyfdEWXSdLK9OlVuHh8RZ2UbcYtBu0Nicggx/+tBqzeF6IeZax/8PdZ20TnbwR8MezKLWu+gIoyIYoiZNne/u6NnE+XehW3MfSX79e5bnwizYdxyt+m+mQ4O4TCbj5mbClOulQBcQKu9/GReXfui4tDlHKpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NO94QIpn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6704DC4CEE4;
	Mon,  5 May 2025 22:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485101;
	bh=W9Hm8XrRthHsKUB9PrcxGZk/2gDj88UVL64AUY00eUA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NO94QIpnL59VTlT+keimvWcYUIqd2W22ldYa49dzaxkoms9RKI3bFZ22FtKf5Q4NH
	 pjGjnURI86UWhnlIA6hyllpFWXdLpF2DqpZwsxJYtWQ3dWRRsIruuUCvpuQ4fxweBP
	 bSWLCT3cdXlj/h30AsUr2Z2tHk0vENrICt6FwfatP90dd20C93TBq0YqEG/LsKco4c
	 BDETKJenTC9tKqhYof+/edZSIYuISDAvdzsFXBQOll/TzK+6zbOOB2Khl0Xw8s36pv
	 vpxSCa1ooQMCmaDhmaYnRhkYsbkF4OLd0/7YEALVZhTC1AnoL6LSv6UTSNRISKhOki
	 tgQqZgd1iO3iw==
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
	tglx@linutronix.de,
	gregkh@linuxfoundation.org,
	linux@treblig.org
Subject: [PATCH AUTOSEL 6.12 161/486] auxdisplay: charlcd: Partially revert "Move hwidth and bwidth to struct hd44780_common"
Date: Mon,  5 May 2025 18:33:57 -0400
Message-Id: <20250505223922.2682012-161-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
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
index 41807ce363399..9428f951c9bf2 100644
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
index 6422be0dfe20e..0ecf6a9469f24 100644
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


