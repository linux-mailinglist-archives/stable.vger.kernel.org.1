Return-Path: <stable+bounces-203632-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DACA6CE717A
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 15:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DFC0B3004EF1
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 14:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D3332F746;
	Mon, 29 Dec 2025 14:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="D38VrUot"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77C632ED56
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 14:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767018901; cv=none; b=th3lCoiyJgTHTw5vlCBAPYKLJg5r23KzIpA50+zgbf5bkXnRyekpjU09EBKwFGBGrQxxgNsivfQ7YBsphGVZcx3meIkgJCAC93W4oIvrhwlfAMVN9YXBoKYVRStH1erc9dONLHIt+JW0KpXXB9zssyEzUDNkT6jS0Lp086O2cOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767018901; c=relaxed/simple;
	bh=HjdatwOcmdYp5QJtv0g1d1Sj/aytwOkRVHQOKQXYSnc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=dJs9fwM/qVY0E1CCJVz8YsVmf5JNAz3zE3jiGalchnC/czcFShMC1UcuwQ7pTc1kaZlyv8Dt/s9y3/FQyZMtacxYmsz2eWOq2HYprsJNop8+bGiu8wxNOs81iQmNaDHvFJNdh7jZPR6eBzRNCCEELigE7dPo18Di7H3DcqN8JbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=D38VrUot; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8149C4CEF7;
	Mon, 29 Dec 2025 14:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767018901;
	bh=HjdatwOcmdYp5QJtv0g1d1Sj/aytwOkRVHQOKQXYSnc=;
	h=Subject:To:Cc:From:Date:From;
	b=D38VrUotfcRlOHQQx2DJ/73QBCfGAFmSBKFwZNUQH8lI32I0vYsXSc/QmkhzIcegv
	 73jA5rqNIvPLThZWP6Sk37w4ltjKVYMjFjzopX5iEtQ3y7gfvCVmvCgrHmYhw3ivZN
	 G79PDa4ryMUvEqmoj2CSlDbPg+hmcgewRjRzuweI=
Subject: FAILED: patch "[PATCH] gpio: loongson: Switch 2K2000/3000 GPIO to BYTE_CTRL_MODE" failed to apply to 6.12-stable tree
To: xry111@xry111.site,bartosz.golaszewski@linaro.org,chenhuacai@loongson.cn
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Dec 2025 15:34:58 +0100
Message-ID: <2025122958-statue-subtotal-2f1c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x dae9750105cf93ac1e156ef91f4beeb53bd64777
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025122958-statue-subtotal-2f1c@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From dae9750105cf93ac1e156ef91f4beeb53bd64777 Mon Sep 17 00:00:00 2001
From: Xi Ruoyao <xry111@xry111.site>
Date: Fri, 28 Nov 2025 15:50:32 +0800
Subject: [PATCH] gpio: loongson: Switch 2K2000/3000 GPIO to BYTE_CTRL_MODE

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

diff --git a/drivers/gpio/gpio-loongson-64bit.c b/drivers/gpio/gpio-loongson-64bit.c
index d4e291b275f0..77d07e31366f 100644
--- a/drivers/gpio/gpio-loongson-64bit.c
+++ b/drivers/gpio/gpio-loongson-64bit.c
@@ -408,11 +408,11 @@ static const struct loongson_gpio_chip_data loongson_gpio_ls2k2000_data0 = {
 
 static const struct loongson_gpio_chip_data loongson_gpio_ls2k2000_data1 = {
 	.label = "ls2k2000_gpio",
-	.mode = BIT_CTRL_MODE,
-	.conf_offset = 0x0,
-	.in_offset = 0x20,
-	.out_offset = 0x10,
-	.inten_offset = 0x30,
+	.mode = BYTE_CTRL_MODE,
+	.conf_offset = 0x800,
+	.in_offset = 0xa00,
+	.out_offset = 0x900,
+	.inten_offset = 0xb00,
 };
 
 static const struct loongson_gpio_chip_data loongson_gpio_ls2k2000_data2 = {


