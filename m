Return-Path: <stable+bounces-204168-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B25CE8838
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 03:02:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 961B2300D314
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 02:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F8E26461F;
	Tue, 30 Dec 2025 02:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="idbedcP8"
X-Original-To: stable@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB527749C
	for <stable@vger.kernel.org>; Tue, 30 Dec 2025 02:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767060124; cv=none; b=MrUieX4aIzSmrgPq7PmseRKgN1AfMdkW6I8zWTip8NrstUwk3mcQb4/YcBBt38xEgIQqQNfuXFXFOlPH38xwUnp0t0tXolBnFvIsNGcB7AnP5OVqlHAUQpXthluserurJal4mt6cNxgEiFh8zqDxhIf9lTUHTPGptTPa+1TnH0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767060124; c=relaxed/simple;
	bh=x0ptLv/xo2eYTXBcNwqAjRXfezVYsgO/Tae0AChoYZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KIZX90/8Lq01B1vDUwb3XfQzfAhNPIy7zxWCyFsMmjUHMF5oAy5CJx+fFle4oOWflPDjSdvLG7x+6G0xzjnplyozM0doe161IlU9WD+DS83SnhgT7T2nKfiUYcDHAZwa3Y3CDrGPh/i+5Ukp8mGA04EYsZN3ILAnorh9GFLrn6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=idbedcP8; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1767060115;
	bh=0m1IMjzwqKz35rth5O0VJFAM4Qv19eMl9zFFmg6oaAc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=idbedcP8dpZC4dpr/ZJhiAmxmuXmMzjTRx8G5A8cquWYy26Tr0eNgDbynzNlsxEpJ
	 V28NYsfbDb8L28LY2d3soCrPtLss4bAxfMQYNv3tsr3a/L9sbol/5XH03TRhkORhzq
	 p2W4CJdgpsoTriqTPsO/jzSnbPD+OMchGOB2zgLo=
Received: from stargazer (unknown [IPv6:2409:8a4c:e19:b211::b3c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 7039E66599;
	Mon, 29 Dec 2025 21:01:53 -0500 (EST)
From: Xi Ruoyao <xry111@xry111.site>
To: stable@vger.kernel.org
Cc: Xi Ruoyao <xry111@xry111.site>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 6.12.y] gpio: loongson: Switch 2K2000/3000 GPIO to BYTE_CTRL_MODE
Date: Tue, 30 Dec 2025 10:01:04 +0800
Message-ID: <20251230020103.72792-2-xry111@xry111.site>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <2025122958-statue-subtotal-2f1c@gregkh>
References: <2025122958-statue-subtotal-2f1c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The manuals of 2K2000 says both BIT_CTRL_MODE and BYTE_CTRL_MODE are
supported but the latter is recommended.  Also on 2K3000, per the ACPI
DSDT the GPIO controller is compatible with 2K2000, but it fails to
operate GPIOs 62 and 63 (and maybe others) using BIT_CTRL_MODE.
Using BYTE_CTRL_MODE also makes those 2K3000 GPIOs work.

Fixes: 3feb70a61740 ("gpio: loongson: add more gpio chip support")
Cc: stable@vger.kernel.org
Signed-off-by: Xi Ruoyao <xry111@xry111.site>
Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
Link: https://lore.kernel.org/r/20251128075033.255821-1-xry111@xry111.site
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
(cherry picked from commit dae9750105cf93ac1e156ef91f4beeb53bd64777)
[Removed inten_offset as 6.12 has no 2K2000/3000 GPIO interrupt support.]
Signed-off-by: Xi Ruoyao <xry111@xry111.site>
---
 drivers/gpio/gpio-loongson-64bit.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-loongson-64bit.c b/drivers/gpio/gpio-loongson-64bit.c
index 7f4d78fd800e..11915898a93d 100644
--- a/drivers/gpio/gpio-loongson-64bit.c
+++ b/drivers/gpio/gpio-loongson-64bit.c
@@ -228,10 +228,10 @@ static const struct loongson_gpio_chip_data loongson_gpio_ls2k2000_data0 = {
 
 static const struct loongson_gpio_chip_data loongson_gpio_ls2k2000_data1 = {
 	.label = "ls2k2000_gpio",
-	.mode = BIT_CTRL_MODE,
-	.conf_offset = 0x0,
-	.in_offset = 0x20,
-	.out_offset = 0x10,
+	.mode = BYTE_CTRL_MODE,
+	.conf_offset = 0x800,
+	.in_offset = 0xa00,
+	.out_offset = 0x900,
 };
 
 static const struct loongson_gpio_chip_data loongson_gpio_ls2k2000_data2 = {
-- 
2.52.0


