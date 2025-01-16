Return-Path: <stable+bounces-109259-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7182A139C8
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 13:16:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA6737A4E2F
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 12:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BBF31DE3DE;
	Thu, 16 Jan 2025 12:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="b7p+gSME"
X-Original-To: stable@vger.kernel.org
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870B01DE3AB
	for <stable@vger.kernel.org>; Thu, 16 Jan 2025 12:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737029809; cv=none; b=m/21nab2eruRyXkWcr4VyxHpkhB/nT2G1p3EFOC+t5QioOMey7hOYSfSorZSDzhc3WpfV9YmEV/qgchjD36uhvb+lycIlb13AwM6y5KtCvoapjuQiUy8faMxUr9PGZ1ggDojbvjERY1TG7DV6pB1RPv9gMgY0JCYlPH+Jnhg5yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737029809; c=relaxed/simple;
	bh=ocgb+1wnTY/YH/HdsbZvFHbSP4O4fTBIZk7OOy0UaRc=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version:Content-Type; b=UwGJU1QgFqY+MYy/DOikbkg5cy4TUppyAVm2PJddmetzCJS5f9Btx5lZ7d41mpawt5FIo/J4tyjlrxaCjFYpHhACmauUTVxPDHP0YaMlQVpldYjEOCYvayD9z09WD+qsytj/lpRoCIvRYsDEojC4K4XoFLEl2ixcCy3CaWe8wWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=b7p+gSME; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1737029796; bh=f841JuwicRpt5PO6Wmjhtcegojum5gRKFv9yV11B8PU=;
	h=From:To:Cc:Subject:Date;
	b=b7p+gSMEXjM2A8ziWpuwivWNTlTArUPhJKitexjCjvmXWmzBu5WbtpwdNS4vaUpUq
	 HhiKLdw1/Kkclm69x1/K4GCenNM6xPOW19omHBYo1iQJTXpthCxvA3GE+fEDfPcGQi
	 fg8kK9MtZ2jTC2bcIMX1aJ8+OdebbTtm0/UpTAVk=
Received: from my-pc.corp.ad.wrs.com ([120.244.194.130])
	by newxmesmtplogicsvrszgpuc5-0.qq.com (NewEsmtp) with SMTP
	id 29534612; Thu, 16 Jan 2025 20:10:21 +0800
X-QQ-mid: xmsmtpt1737029421thjdgkjah
Message-ID: <tencent_FA36A0C6E3834FF2D95A12671766AE418505@qq.com>
X-QQ-XMAILINFO: NyTsQ4JOu2J2p4Bnopz1Nr0X72rQqMfcoheopPBDhlqqGnmiBLrEsDWczQGROf
	 3Ajp3orCjsH5mfarvqK/sXEfAhNYQ3CuNpua0jK71ZgzXPnx1d3KwcsuhlStk9yvLtbzG5JqLY1i
	 GOk4HRVjnCcjN/Zt/i6Pt0TgDo+xv3tCjWF3nXyaiOxvGfUttT0LRMMRKJnMg0yAa1MPcSs9IWFf
	 i3MrEIj93047b+8N/4yfRhlD+qad+3ctC9Jb5qZIBbbPqxfAY4XRDGlZ/zp1PRbtS5IfnpmHxdh5
	 zjnDSc+7qHt2dNpHXigILZMR2qHA6/E/Wy6CN5PVxWNMWhjsQbCgFV9UEfhqpQPQW/JbhWwoV1nN
	 Ii1RJSeMXq8CDo6Z4wIK0Dc0nhbsxxMnyHbiNrEipwAzdww2aOhMqyH4dLcpd8Ao3WkayEFIKEMj
	 Yc4kZoIKrfYRGbf69J3yWh9xkHUbYa3OQoqomu6Li3ATrh849twn0T1FrRUiS2DVxjRfWVNXfRAf
	 hJRPzdA4bN8H3hecKOqY9ncr+2iNyrbvtWdkEwi0Xm5OmBEg1icctV7YN/Dwxn+jS0Wfs3R8LPcZ
	 Rawhs3v1lm1eSBswVPKeuLPt/NEjTABfax0XEpiw09mkYzfiuYF10duIsvE20e5AiInfLseKIiPC
	 /JsKQuRB8WymeWHd+rCg8Gsc188JadQjhIZXdAnM7g2CE4M7sKs3shke19dMeND8TG6B2vcE+L+Y
	 SLIDOTkJWYtOs/I0QAeNKhxfrhuDp9PYkczsPPMo126J0yOqqZXbR0V6JKvVHQR3kCfX2EYI0LTA
	 g6FEG2rAwA5vnlMrjX197vyxX3OpsSjCmURSunFH3nrD1JRd0PFI7FQCFMe+YnFPAIQf8wB6vLmj
	 Es0EnK7ks4x7oIFeYfJ6yFlGSLRLn2oVna4TDxNvpHdPH5Kp+aTSe9c6bLE9zude3o1BGnTX8EQd
	 0sWNNSKrdmFjg0110Xv5Gc1VLbKbk3KGyItaPsHV6v8JDJfAKPxblqL9rT8cigQO2jkwYfmr7cSu
	 UsNUgNKg==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: lanbincn@qq.com
To: stable@vger.kernel.org
Cc: Kang Yang <quic_kangyang@quicinc.com>,
	David Ruth <druth@chromium.org>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Bin Lan <lanbincn@qq.com>
Subject: [PATCH 6.1.y] wifi: ath10k: avoid NULL pointer error during sdio remove
Date: Thu, 16 Jan 2025 20:10:20 +0800
X-OQ-MSGID: <20250116121020.3416-1-lanbincn@qq.com>
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

commit 95c38953cb1ecf40399a676a1f85dfe2b5780a9a upstream.

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
Signed-off-by: Bin Lan <lanbincn@qq.com>
---
 drivers/net/wireless/ath/ath10k/sdio.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/sdio.c b/drivers/net/wireless/ath/ath10k/sdio.c
index 79e09c7a82b3..886070b2a722 100644
--- a/drivers/net/wireless/ath/ath10k/sdio.c
+++ b/drivers/net/wireless/ath/ath10k/sdio.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2004-2011 Atheros Communications Inc.
  * Copyright (c) 2011-2012,2017 Qualcomm Atheros, Inc.
  * Copyright (c) 2016-2017 Erik Stromdahl <erik.stromdahl@gmail.com>
+ * Copyright (c) 2022-2024 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <linux/module.h>
@@ -2647,9 +2648,9 @@ static void ath10k_sdio_remove(struct sdio_func *func)
 
 	netif_napi_del(&ar->napi);
 
-	ath10k_core_destroy(ar);
-
 	destroy_workqueue(ar_sdio->workqueue);
+
+	ath10k_core_destroy(ar);
 }
 
 static const struct sdio_device_id ath10k_sdio_devices[] = {
-- 
2.43.0


