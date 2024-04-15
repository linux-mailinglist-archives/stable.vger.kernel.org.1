Return-Path: <stable+bounces-39416-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7460D8A4E31
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 13:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFE9C1F210D8
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 11:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E401166B5E;
	Mon, 15 Apr 2024 11:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bcZaZPak"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19346605B6;
	Mon, 15 Apr 2024 11:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713182245; cv=none; b=Ty/1KxMGPRxsZ3AwgcacEBUARuhUrMT4F4xwtey0JxtTa10tc9r1U2UIRfde9E2KdIOOmEgd8TyGlNkgG9c1SiUpj3Rkov5s4rStAo8hWxQxY+y2fbq6O6T7ysS5ua4Zjol/O1Qr0+z+ba2vAkIlz+N7so8B7pGRiop5L329vOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713182245; c=relaxed/simple;
	bh=xG7070IKtllLIE5Jx5TWiM3Jo+uZEnEHiu8qrG0JR64=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=Xoptb2iF6neYOY2dYd5iN4rZLWmNLEwsRZLMbtVV71iXHfUaEYppoRNrhm99+Y4UOpVT84NA6SYJ02Gzr1PvNgfjTqczPC9dj9g648YNZQQa5eLzvBOsuMf6X25r22KskJqGAbz1/B7WCbVkAtzEvdlLunz+escKkKzeEU3CMzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bcZaZPak; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-56e69888a36so4265488a12.3;
        Mon, 15 Apr 2024 04:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713182242; x=1713787042; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:content-language:cc:to:subject
         :from:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=52DKIr5XjPxE0lxaaQl58l9lNteOOTdG5ZI5b4uihM0=;
        b=bcZaZPakz8NgyMhZt2Hirgs3xd6zRLnWViW144qofF+i902oXVHIusb/wfGsONgwgy
         a4fBedL3E9QKgm/HeHQ61krLsx3Gb2tl7l+epuLTG/w6KkLKlXRWrqyS0XxFqtbUapey
         YliGasBOvEQYWTcMP5wieSot1ldK7tESM5vvqu9SDCxuDwVFaz0ukPe33ayx8zq53JN/
         w9bTpFeG6gxls+oOc3GF+XsAonXEAaLUhc0yrR/sI6EpL5BZL6rZQMyIwiU7tfbd3vpp
         rtla1u2vHBqIkIEN4otZL51c9dHAPoKrQasw/FAqenBcvGWiksFJgz0AOv/rW61tOsIt
         X3RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713182242; x=1713787042;
        h=content-transfer-encoding:autocrypt:content-language:cc:to:subject
         :from:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=52DKIr5XjPxE0lxaaQl58l9lNteOOTdG5ZI5b4uihM0=;
        b=kMS+7BNiL2cBOo9opzrfJaCsZcnNNVjh+R5Vg411/W+SSTCuje0U31k2GHO/Tur91b
         g1XZZ2oAm7tTwPoBguz833NONS3SZPbhOw5HlakJqi8Qiy6Ho8TYHw//9CQ/FaLNLT0m
         Nq1v5DXTeXpRvMtsemElhdCjGXHnuDPbhUvs0hAMblIwAq9cEa2TNU8lqmP+J+KIWX+P
         8ZPkrleJaTDZVnK0U2pvTNJTaxREa4irmxg45wTCyo35AYy+udfhb0PNeZwKcdcNwOyA
         dUL1CFHaHOO82fcfSdn6uA5nz4TJJv5+2W/uBGCD0bkhtr1vgQsYTI0ViRG2k1lJdyIo
         Y4qw==
X-Gm-Message-State: AOJu0YwD1klB5gYECD9M3RYIlnLH6u9dF6FzaQKrJTP80I3QaGjOyHGR
	ipGMCqbVl1ca+1359BqJgBdtmX+uw57ae5klbz4jPQGOZEdFzrY0bcNLHA==
X-Google-Smtp-Source: AGHT+IGAaiEjAn4cxbXq8ujn9hnbq8IUB4YldWxH41kFI890qXPbI3eIOahSGaPEYsUlTZHDL8+sGA==
X-Received: by 2002:a17:906:35ce:b0:a52:71af:405d with SMTP id p14-20020a17090635ce00b00a5271af405dmr1015020ejb.56.1713182236138;
        Mon, 15 Apr 2024 04:57:16 -0700 (PDT)
Received: from ?IPV6:2a01:c22:6fba:a100:9cae:aacf:9cd8:e36e? (dynamic-2a01-0c22-6fba-a100-9cae-aacf-9cd8-e36e.c22.pool.telefonica.de. [2a01:c22:6fba:a100:9cae:aacf:9cd8:e36e])
        by smtp.googlemail.com with ESMTPSA id qb42-20020a1709077eaa00b00a5216df5d25sm5367008ejc.3.2024.04.15.04.57.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 04:57:15 -0700 (PDT)
Message-ID: <ded9d793-83f8-4f11-87d9-a218d10c2981@gmail.com>
Date: Mon, 15 Apr 2024 13:57:17 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net] r8169: fix LED-related deadlock on module removal
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Binding devm_led_classdev_register() to the netdev is problematic
because on module removal we get a RTNL-related deadlock. Fix this
by avoiding the device-managed LED functions.

Note: We can safely call led_classdev_unregister() for a LED even
if registering it failed, because led_classdev_unregister() detects
this and is a no-op in this case.

Fixes: 18764b883e15 ("r8169: add support for LED's on RTL8168/RTL8101")
Cc: <stable@vger.kernel.org> # 6.8.x
Reported-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
The original change was introduced with 6.8, 6.9 added support for
LEDs on RTL8125. Therefore the first version of the fix applied on
6.9-rc only. This is the modified version for 6.8.
Upstream commit: 19fa4f2a85d7
---
 drivers/net/ethernet/realtek/r8169.h      |  4 +++-
 drivers/net/ethernet/realtek/r8169_leds.c | 23 +++++++++++++++++------
 drivers/net/ethernet/realtek/r8169_main.c |  7 ++++++-
 3 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169.h b/drivers/net/ethernet/realtek/r8169.h
index 81567fcf3..1ef399287 100644
--- a/drivers/net/ethernet/realtek/r8169.h
+++ b/drivers/net/ethernet/realtek/r8169.h
@@ -72,6 +72,7 @@ enum mac_version {
 };
 
 struct rtl8169_private;
+struct r8169_led_classdev;
 
 void r8169_apply_firmware(struct rtl8169_private *tp);
 u16 rtl8168h_2_get_adc_bias_ioffset(struct rtl8169_private *tp);
@@ -83,4 +84,5 @@ void r8169_get_led_name(struct rtl8169_private *tp, int idx,
 			char *buf, int buf_len);
 int rtl8168_get_led_mode(struct rtl8169_private *tp);
 int rtl8168_led_mod_ctrl(struct rtl8169_private *tp, u16 mask, u16 val);
-void rtl8168_init_leds(struct net_device *ndev);
+struct r8169_led_classdev *rtl8168_init_leds(struct net_device *ndev);
+void r8169_remove_leds(struct r8169_led_classdev *leds);
diff --git a/drivers/net/ethernet/realtek/r8169_leds.c b/drivers/net/ethernet/realtek/r8169_leds.c
index 007d077ed..1c97f3cca 100644
--- a/drivers/net/ethernet/realtek/r8169_leds.c
+++ b/drivers/net/ethernet/realtek/r8169_leds.c
@@ -138,20 +138,31 @@ static void rtl8168_setup_ldev(struct r8169_led_classdev *ldev,
 	led_cdev->hw_control_get_device = r8169_led_hw_control_get_device;
 
 	/* ignore errors */
-	devm_led_classdev_register(&ndev->dev, led_cdev);
+	led_classdev_register(&ndev->dev, led_cdev);
 }
 
-void rtl8168_init_leds(struct net_device *ndev)
+struct r8169_led_classdev *rtl8168_init_leds(struct net_device *ndev)
 {
-	/* bind resource mgmt to netdev */
-	struct device *dev = &ndev->dev;
 	struct r8169_led_classdev *leds;
 	int i;
 
-	leds = devm_kcalloc(dev, RTL8168_NUM_LEDS, sizeof(*leds), GFP_KERNEL);
+	leds = kcalloc(RTL8168_NUM_LEDS + 1, sizeof(*leds), GFP_KERNEL);
 	if (!leds)
-		return;
+		return NULL;
 
 	for (i = 0; i < RTL8168_NUM_LEDS; i++)
 		rtl8168_setup_ldev(leds + i, ndev, i);
+
+	return leds;
+}
+
+void r8169_remove_leds(struct r8169_led_classdev *leds)
+{
+	if (!leds)
+		return;
+
+	for (struct r8169_led_classdev *l = leds; l->ndev; l++)
+		led_classdev_unregister(&l->led);
+
+	kfree(leds);
 }
diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 4b6c28576..32b73f398 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -634,6 +634,8 @@ struct rtl8169_private {
 	const char *fw_name;
 	struct rtl_fw *rtl_fw;
 
+	struct r8169_led_classdev *leds;
+
 	u32 ocp_base;
 };
 
@@ -4930,6 +4932,9 @@ static void rtl_remove_one(struct pci_dev *pdev)
 
 	cancel_work_sync(&tp->wk.work);
 
+	if (IS_ENABLED(CONFIG_R8169_LEDS))
+		r8169_remove_leds(tp->leds);
+
 	unregister_netdev(tp->dev);
 
 	if (tp->dash_type != RTL_DASH_NONE)
@@ -5391,7 +5396,7 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (IS_ENABLED(CONFIG_R8169_LEDS) &&
 	    tp->mac_version > RTL_GIGA_MAC_VER_06 &&
 	    tp->mac_version < RTL_GIGA_MAC_VER_61)
-		rtl8168_init_leds(dev);
+		tp->leds = rtl8168_init_leds(dev);
 
 	netdev_info(dev, "%s, %pM, XID %03x, IRQ %d\n",
 		    rtl_chip_infos[chipset].name, dev->dev_addr, xid, tp->irq);
-- 
2.44.0


