Return-Path: <stable+bounces-40217-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A87AD8AA40C
	for <lists+stable@lfdr.de>; Thu, 18 Apr 2024 22:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCAC01C20F5B
	for <lists+stable@lfdr.de>; Thu, 18 Apr 2024 20:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CDA67D3E2;
	Thu, 18 Apr 2024 20:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hXkXKarV"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F625231
	for <stable@vger.kernel.org>; Thu, 18 Apr 2024 20:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713472261; cv=none; b=V/9QZtStwXFMOfHmq4OE2zYdjbH5OaChPdvviUKSGcTL7VrKPUvTVvEZqdTmu/BbK/UMQjvBcBHlZKg38gmcKFg/gWfUy7dfHEY9rj3fbIJhJB1otMXu3eoVfHaqARmIP5pm7mGjROHhsrcX7eh0R66kkePwrp11twoo99DArgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713472261; c=relaxed/simple;
	bh=iqNbfQJvJn/fTjZIpJnWCqZ4GTAzReDuRlJ5pn74TRI=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Cc:Content-Type; b=Ld4L5R4cdbY26QDLMftkIgUeH1nqX8b6LUdXLGP6RjDmaexZLWTiBVU2l46/Qkg0Ttonf3JDOOhlIrMZMDYnVIUmzRxjx1NBfVH/hk/PgtITNimWBx2CuiRsuxg6I1vQ91dW15apaY+vF+2632/tpl1SW0T14zIRKRK8C+gaHv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hXkXKarV; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-418c979ddf3so10303935e9.0
        for <stable@vger.kernel.org>; Thu, 18 Apr 2024 13:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713472258; x=1714077058; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:autocrypt:subject:from:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9s6dmS9CLUCkZnwqY2wtGzDXMyZPduERr+W2bFrp3B4=;
        b=hXkXKarVzJoADqVafJA2mCl/FSx8gUAgWSyZIv7vL0/7J7vA0GGfEn/tM9p3T9/RdR
         yIYhNSpN+shj94GLexgy2IHK29jVYZS+ou/xrCwGWu9GEs2MhjMFVxrCmcVCbGmQ9U+l
         NwDLDzcRLdCs+S5L+FbYFi8zGImgBMi01CCgP2QgY24vfC8kPHg9RIwV3tFFKN7eSdmV
         AYyEfLxbRvvqDi1aBVwtDNT69WYKKq9dNyEeQ+vPgEtVmME9IVDP65fc0MqGfMMU2RUJ
         LjFLSPjk5DPmJYa6sgiaUCbS9y4kyRFGmGFT6dydH+3JKFPmLmpQ7pRHYOJVffRUrCPH
         P4SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713472258; x=1714077058;
        h=content-transfer-encoding:cc:autocrypt:subject:from:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9s6dmS9CLUCkZnwqY2wtGzDXMyZPduERr+W2bFrp3B4=;
        b=ca4Lz5DVq6Wdhgq6/eLgKFDZ9ooUtZhAv4EI0qdKjXoWqLkZ4rpbvXyiv7BpebLNfV
         H6VlfHkIOxgy/TiUx3j6q9nQhBqAnCB2BIIPye/ixSOFx99fe4ZwV+suW9PRUcwSxsnE
         0i4L8YTWKULSsEXODb7/fhXfT+hsbBwP7bhRsXrNrJgAcqJDQxqSCEuMbt1RRf6UuS7p
         Il5qniFkOFtn4d+5guixQh5SKjmYFRzZ1Y3KAC7pH6NUN1briJ9awCWvo8vPh9u2Y+rM
         pJ+eQls9HFVz31J6AHWXJaaPvW8uD7UELJeGGXVz6OZClSZYEZnBCa1bMjFZz5KrHmw5
         lRTQ==
X-Gm-Message-State: AOJu0Ywjhk5XcXv7nsmPqyf4/haIOantkUGC49H8ee/fX2AblW+qEn9F
	1TjvXZi1lMgKXjqcORaclQvfQmy0VUcuGGvaC5OmjBwFZdLGqmcHXpCImA==
X-Google-Smtp-Source: AGHT+IFXi1/8B1eNOlEtf3Hf7n3K44ieW0SPmfCYH4x3tpul1QkVPtrPBwvS9rmEWyrFUY+fABYlrw==
X-Received: by 2002:a05:600c:4f85:b0:418:d423:6da8 with SMTP id n5-20020a05600c4f8500b00418d4236da8mr11773wmq.4.1713472257947;
        Thu, 18 Apr 2024 13:30:57 -0700 (PDT)
Received: from ?IPV6:2a01:c22:7a7c:3800:df8:a4c3:282a:f888? (dynamic-2a01-0c22-7a7c-3800-0df8-a4c3-282a-f888.c22.pool.telefonica.de. [2a01:c22:7a7c:3800:df8:a4c3:282a:f888])
        by smtp.googlemail.com with ESMTPSA id ay15-20020a05600c1e0f00b004189a5ada3asm7762691wmb.19.2024.04.18.13.30.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 13:30:57 -0700 (PDT)
Message-ID: <569cb4bd-af80-4751-bdff-24a507d895d0@gmail.com>
Date: Thu, 18 Apr 2024 22:31:01 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH] r8169: fix LED-related deadlock on module removal
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Cc: Lukas Wunner <lukas@wunner.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

[ Upstream commit 19fa4f2a85d777a8052e869c1b892a2f7556569d ]

Binding devm_led_classdev_register() to the netdev is problematic
because on module unbinding we get a RTNL-related deadlock.
Fix this by avoiding the device-managed LED functions.

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
---
 drivers/net/ethernet/realtek/r8169.h      |  4 +++-
 drivers/net/ethernet/realtek/r8169_leds.c | 23 +++++++++++++++++------
 drivers/net/ethernet/realtek/r8169_main.c |  6 +++++-
 3 files changed, 25 insertions(+), 8 deletions(-)

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
index 4b6c28576..2cc1c36ab 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -634,6 +634,8 @@ struct rtl8169_private {
 	const char *fw_name;
 	struct rtl_fw *rtl_fw;
 
+	struct r8169_led_classdev *leds;
+
 	u32 ocp_base;
 };
 
@@ -4930,6 +4932,8 @@ static void rtl_remove_one(struct pci_dev *pdev)
 
 	cancel_work_sync(&tp->wk.work);
 
+	r8169_remove_leds(tp->leds);
+
 	unregister_netdev(tp->dev);
 
 	if (tp->dash_type != RTL_DASH_NONE)
@@ -5391,7 +5395,7 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (IS_ENABLED(CONFIG_R8169_LEDS) &&
 	    tp->mac_version > RTL_GIGA_MAC_VER_06 &&
 	    tp->mac_version < RTL_GIGA_MAC_VER_61)
-		rtl8168_init_leds(dev);
+		tp->leds = rtl8168_init_leds(dev);
 
 	netdev_info(dev, "%s, %pM, XID %03x, IRQ %d\n",
 		    rtl_chip_infos[chipset].name, dev->dev_addr, xid, tp->irq);
-- 
2.44.0


