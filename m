Return-Path: <stable+bounces-125643-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B50A6A56F
	for <lists+stable@lfdr.de>; Thu, 20 Mar 2025 12:53:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFD0116F4D4
	for <lists+stable@lfdr.de>; Thu, 20 Mar 2025 11:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44624221548;
	Thu, 20 Mar 2025 11:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="exwxpcum"
X-Original-To: stable@vger.kernel.org
Received: from out203-205-221-236.mail.qq.com (out203-205-221-236.mail.qq.com [203.205.221.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1D81EB5CA
	for <stable@vger.kernel.org>; Thu, 20 Mar 2025 11:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742471377; cv=none; b=VBJxBMDLJDlvcB++uXKn2rGnvetk7kq3Eqnp2DkfaS0e4z0fy2bPG0m6zR4B9Z0QNXVezGsWe9sEI2reEXRzihlZBwzfmHmWkvpO1kTqTL/nuozZxDsuoyuB1LhDf227a7SvEK9cAbIqqPG8L0Bld8boCSaFdTZSMOay7OUcx7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742471377; c=relaxed/simple;
	bh=1ZX+1uAXca9Y2kIxWXCIA9GvOn0yyYynQfJVEA3PdLU=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version:Content-Type; b=uScTen1JiYsET6B9IZCS0JQyJkI2tT/MJWPfAWFMQAy1iL4C827bkvn2uC9UojaMIClUjIU3KutVAyi7bdcRrD1zAbERpgvfr4AKUVvsH8wonXd6Ksrfw6fQqA6Grw2+dYoMdBDNLjZgA91aqkpiInfq4dFtdCgnfc5DatTbWwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=exwxpcum; arc=none smtp.client-ip=203.205.221.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1742471363;
	bh=yYz2lvXRz6wWXNolfZztZWAfp4NMCpBdeKovR/vLEx0=;
	h=From:To:Cc:Subject:Date;
	b=exwxpcumTx1dnY6xUwOEqGAZNSHbgvQV714vPoGa4pgYiEs+DJbKEvRMsZmEbTeAt
	 Dqifv3UUYKzPyY4djbIyxVtnmOI4OF1/Yx4UQG8jAJWMO+awY40tt4pd4LeRoXb7L8
	 Ca0cAt2o9bd/aW0kMaDIKmKf4n58WTp3JQeTZ1QU=
Received: from pek-blan-cn-l1.corp.ad.wrs.com ([120.244.194.128])
	by newxmesmtplogicsvrszb21-0.qq.com (NewEsmtp) with SMTP
	id AC28AAC3; Thu, 20 Mar 2025 19:43:02 +0800
X-QQ-mid: xmsmtpt1742470982tppebuh3g
Message-ID: <tencent_A61660721BA068D56A023F1625A5ACED7009@qq.com>
X-QQ-XMAILINFO: N7h1OCCDntujl7IrbIzTB8veoy3k92bgkp5Rnu77LKsDUXiH33ALpuCu49bnzm
	 FUcUsiYfMYwpCvlJn7d0aqmP9U+zwAxp5inCv6SGvwPZ5MTqvfEU3amZopQkvjf5iUQlVAsFVfBJ
	 WZA2ZBB57Vbc/yuQ4ibg5IxobxUNEi7xcDZ1B8dQ+r/dPmlThhOCc3ayScKDRI3lRCL91mZNg1XG
	 RH+VAmHWCqNTCsHccHqhYPPrYgBrJUilVzT1LO/J9Odcci/vW/u5UUc2l2V7d4QNBQXCLQ8noGlc
	 7//9LIU2fjdXjmnVSD3Gyu1Z95mkofckjBporV5KcUrbZvcHq9+MMeTNIwyUIITzAN7d0holhmav
	 qR+87xV7bjmRHakXfxMTRtSe5Ecm0x9RJAI+zO172/Jc42FhRgSz7S08D56pH8IItPxzllw1wnq2
	 IlfnL2Ui3eUxOofSNe81mR6JNwmGEJ0oy+Qk7UszvWEWIWuoy79RY725JzMUju40ucA+pyh37DzL
	 WcCPrtNn1WR7WvHAxFXOaaIFzAoeXhfrSYg3xnZh9X0Gk3bUUIvw1I9eTJpD4Tyj5m8d0jx9X82G
	 dnYTHnOP5Nshlzxs/ICI/rof7V+LxvS40DnJmwDplE+2I+I8eQwGsEE31o1mlsFks8tCOysewSib
	 sNaKKl8lrXEha+WVO5DzLQVw2tTF7UPeT5lCVXkG5W1M3+bvczK1GeVWE7Wfg9uf0WyHfe1CmDm4
	 S7Jjs1+shcR+gLFalan8dqfEN6SBieL8+Fz2GiPiCSs1ZexEVbj6aZOBKjsz7bLJMoKAxi+rDjap
	 1hmNFCtxuoRHY0o/ReCY89PAPWbigJ9hv7Rd0bwrOODVVz7E7WFGe4oGFmFDjRKWM3W8ymjWwddb
	 +PDEdqQI0OxUpPcfwcRJ17eMuYH9yDAVDZc5RYYUv3uHvr+Vz1f5Q7GLBSaNz4BboyTYAaA0ND90
	 8jxNAbjOaWpaLZhQgXOKxn4jKnk97hrQo3gAhmmg8=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: alvalan9@foxmail.com
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: Kang Yang <quic_kangyang@quicinc.com>,
	David Ruth <druth@chromium.org>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Alva Lan <alvalan9@foxmail.com>
Subject: [PATCH 5.10.y] wifi: ath10k: avoid NULL pointer error during sdio remove
Date: Thu, 20 Mar 2025 19:42:54 +0800
X-OQ-MSGID: <20250320114254.690-1-alvalan9@foxmail.com>
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
index 9d1b0890f310..418e40560f59 100644
--- a/drivers/net/wireless/ath/ath10k/sdio.c
+++ b/drivers/net/wireless/ath/ath10k/sdio.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2004-2011 Atheros Communications Inc.
  * Copyright (c) 2011-2012,2017 Qualcomm Atheros, Inc.
  * Copyright (c) 2016-2017 Erik Stromdahl <erik.stromdahl@gmail.com>
+ * Copyright (c) 2022-2024 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <linux/module.h>
@@ -2649,9 +2650,9 @@ static void ath10k_sdio_remove(struct sdio_func *func)
 
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


