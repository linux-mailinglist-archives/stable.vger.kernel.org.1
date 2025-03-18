Return-Path: <stable+bounces-124768-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F68A66C37
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 08:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56C1819A297C
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 07:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1751D1E5B8C;
	Tue, 18 Mar 2025 07:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="qoVpQzNR"
X-Original-To: stable@vger.kernel.org
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7767E9
	for <stable@vger.kernel.org>; Tue, 18 Mar 2025 07:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742283488; cv=none; b=LZxupiEZKtQvcJcuXsRLUHih4sGvb2Dp6iKeFyVrQ4jka3/n1X/ySFEWjBWEBP7qHAS2mZs2tCYIdlbKRbzIvt4tK0SE83BccPvEMrqbW0uodj/awtpEltlVKEgzx783CFhRsV4VLA90phoXP4WDDeVAOTuy21iC5S6N/k2Jw8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742283488; c=relaxed/simple;
	bh=TNHzETrAs9ASf/mtzKZatO+VZMHOF5LR6xLiaqtUUAA=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version:Content-Type; b=uc7CMU9ehDcwEdrZuitZW2nZqEpVri2jvdT8fMImyx0sBd4Fa1VScUSERQPF/sCm/bEL4hI8buLJNI6lWEp+CFAtanN9/WO3gwFM+1gKXV44fPYA8qunFXyLIRxbN1865ZEZYnubrPdxn1w775hYl+mY4iIO7d52q8QxS+VuREY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=qoVpQzNR; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1742283169;
	bh=t3BQVJQf18D27DHzSxfer3fRuqW4K7UlYytGbRnKP1A=;
	h=From:To:Cc:Subject:Date;
	b=qoVpQzNRH/8ylBxPniFdKuHC9XL+RcuhKe1CD4DKdgd6iORVDG7CpHlWLjrY1tAeH
	 E7VG8M5Pi/O6n6GqP7cNly3ztTbBdlfCaAmGQcH4//LOGTdgQbp2dKDFtT153mdIU4
	 vUt1LsHndhvr8ezsPAekwdjq3EyJUO7X6S1ld2Yo=
Received: from pek-blan-cn-l1.corp.ad.wrs.com ([120.244.194.128])
	by newxmesmtplogicsvrsza36-0.qq.com (NewEsmtp) with SMTP
	id 82496A07; Tue, 18 Mar 2025 15:32:36 +0800
X-QQ-mid: xmsmtpt1742283156tz5xpbyhf
Message-ID: <tencent_891A70685F6B183EE224B3AC4F70FC60DC09@qq.com>
X-QQ-XMAILINFO: NnYhxYSyuBnLki+715JwhiCwrWWOitK/aWX4aTmSto519E3HchcKW5FmePghM3
	 Y00qw2syQX5RfoW0gp3TGqh6Wq2RSwN8mbLamb719AmJpEVtBnTiEDJ8FAFsvwTNWBN6YO7DMJRf
	 SJQX7PSEFBaFBbk9ARfpAZiHNXVWcrPNlkGv1DAuCMivtJtba5iYW15OvoBT7TNFzrujU+23SpRM
	 HucRhhfySqae1ZwyHXaNGrRmU4E3ALb+PLcZI9k/tddrEbP4bR9OAGBBasWn/3iALveAbNz2gGMO
	 yobDKOZenL098eGlSDZmviaHIqkCvQ9CoRhLXs/UN9Y1LnMUCh5/Z/IJ13Tfn3hLSrNYR3EwuvAK
	 9ts79BDHSimskCwPncgwluFxRp8T1xfsWQ9ka9FcOOgZdRVqMhPt3MKlZ1/aukTdeqVcB8UeFjzC
	 OIhf5wWBcTNvsLORsdbhV9T64J9mWtjQmaBl4UIDTbd+PhxqwBQMCF71tHUurj94GSqf9qoHT2Pr
	 wINmSCUKVVt6DspS+zQKU0uY5EWnOyDJv3D7zEC8Sdl1LCMNAcrmPCsDF77LM2D3+TdB39IJ1zsy
	 ULqXfClQMyWMV/oSHLDaE2olxbqEgI3Q66vN4vqHF/1+IQleW5d69m7E7xzp6pRARqPcMRSCIPFc
	 GhSYehykJZ5QjkV+0NplGbPChvN3G9kbKnImmDHgfTaDTdhMa4WM9NAYfg0RslOXKaHRyC90p2yK
	 A4B3xsNTWvxpiBHZQqDnjrz/KS1F8db+Mx2pg9kz/IUu7cS5jMMb2nnQ+Lbl63WsOOLeRnXo7Q1c
	 AMAs8ejNiA6qw6ccD95DCPbssP7KgV5HKd+J99A29PZrqClHCeRYAmNb4cFHN/YfKR+/SOnhnXDi
	 XeRBRjxU1/xkSW00Gbzn+wrz5EXUmIa7FaeDka9HVWurUd2Wc91xP1Y76OWsRZ51q+ciVso3zuqw
	 BnzMwBE3XrYTBRzmJpf7zYuKMqvLcffyobaJOsfws=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: alvalan9@foxmail.com
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: Kang Yang <quic_kangyang@quicinc.com>,
	David Ruth <druth@chromium.org>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Alva Lan <alvalan9@foxmail.com>
Subject: [PATCH 5.15.y] wifi: ath10k: avoid NULL pointer error during sdio remove
Date: Tue, 18 Mar 2025 15:32:34 +0800
X-OQ-MSGID: <20250318073234.1166-1-alvalan9@foxmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kang Yang <quic_kangyang@quicinc.com>

[ Upstream commit 95c38953cb1ecf40399a676a1f85dfe2b5780a9a ]

When running 'rmmod ath10k', ath10k_sdio_remove() will free sdio
workqueue by destroy_workqueue(). But if CONFIG_INIT_ON_FREE_DEFAULT_ON
is set to yes, kernel panic will happen:
Call trace:
 destroy_workqueue+0x1c/0x258
 ath10k_sdio_remove+0x84/0x94
 sdio_bus_remove+0x50/0x16c
 device_release_driver_internal+0x188/0x25c
 device_driver_detach+0x20/0x2c

This is because during 'rmmod ath10k', ath10k_sdio_remove() will call
ath10k_core_destroy() before destroy_workqueue(). wiphy_dev_release()
will finally be called in ath10k_core_destroy(). This function will free
struct cfg80211_registered_device *rdev and all its members, including
wiphy, dev and the pointer of sdio workqueue. Then the pointer of sdio
workqueue will be set to NULL due to CONFIG_INIT_ON_FREE_DEFAULT_ON.

After device release, destroy_workqueue() will use NULL pointer then the
kernel panic happen.

Call trace:
ath10k_sdio_remove
  ->ath10k_core_unregister
    ……
    ->ath10k_core_stop
      ->ath10k_hif_stop
        ->ath10k_sdio_irq_disable
    ->ath10k_hif_power_down
      ->del_timer_sync(&ar_sdio->sleep_timer)
  ->ath10k_core_destroy
    ->ath10k_mac_destroy
      ->ieee80211_free_hw
        ->wiphy_free
    ……
          ->wiphy_dev_release
  ->destroy_workqueue

Need to call destroy_workqueue() before ath10k_core_destroy(), free
the work queue buffer first and then free pointer of work queue by
ath10k_core_destroy(). This order matches the error path order in
ath10k_sdio_probe().

No work will be queued on sdio workqueue between it is destroyed and
ath10k_core_destroy() is called. Based on the call_stack above, the
reason is:
Only ath10k_sdio_sleep_timer_handler(), ath10k_sdio_hif_tx_sg() and
ath10k_sdio_irq_disable() will queue work on sdio workqueue.
Sleep timer will be deleted before ath10k_core_destroy() in
ath10k_hif_power_down().
ath10k_sdio_irq_disable() only be called in ath10k_hif_stop().
ath10k_core_unregister() will call ath10k_hif_power_down() to stop hif
bus, so ath10k_sdio_hif_tx_sg() won't be called anymore.

Tested-on: QCA6174 hw3.2 SDIO WLAN.RMH.4.4.1-00189

Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
Tested-by: David Ruth <druth@chromium.org>
Reviewed-by: David Ruth <druth@chromium.org>
Link: https://patch.msgid.link/20241008022246.1010-1-quic_kangyang@quicinc.com
Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
Signed-off-by: Alva Lan <alvalan9@foxmail.com>
---
 drivers/net/wireless/ath/ath10k/sdio.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/sdio.c b/drivers/net/wireless/ath/ath10k/sdio.c
index 63e1c2d783c5..b2e0abb5b2b5 100644
--- a/drivers/net/wireless/ath/ath10k/sdio.c
+++ b/drivers/net/wireless/ath/ath10k/sdio.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2004-2011 Atheros Communications Inc.
  * Copyright (c) 2011-2012,2017 Qualcomm Atheros, Inc.
  * Copyright (c) 2016-2017 Erik Stromdahl <erik.stromdahl@gmail.com>
+ * Copyright (c) 2022-2024 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <linux/module.h>
@@ -2648,9 +2649,9 @@ static void ath10k_sdio_remove(struct sdio_func *func)
 
 	netif_napi_del(&ar->napi);
 
-	ath10k_core_destroy(ar);
-
 	destroy_workqueue(ar_sdio->workqueue);
+
+	ath10k_core_destroy(ar);
 }
 
 static const struct sdio_device_id ath10k_sdio_devices[] = {
-- 
2.34.1


