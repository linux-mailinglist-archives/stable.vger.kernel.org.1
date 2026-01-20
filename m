Return-Path: <stable+bounces-210435-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F20D3BF39
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 07:32:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A5759385A68
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 06:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E529379984;
	Tue, 20 Jan 2026 06:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PQQWr79p"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675E5379992
	for <stable@vger.kernel.org>; Tue, 20 Jan 2026 06:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768890546; cv=none; b=lsCppN8lgeZDVnEAyvxgZXe2Iql/oFRq7TB/CVTCdhf+uEHdyQyQThpCYa41mmZhgKCrQ+H0Yul2Glzmwdd42eaIv9EvLfB+wPXUqVvgfc3dUmllYrj+vS9JN7519AEGarhvTf98rVPI2yj4tQUqA04VZM4664ODqLx/OVW7slM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768890546; c=relaxed/simple;
	bh=opbV4IdcTAjTugROH0USOiae0jYpBQAjBUnIclDTNyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OhDuCrfdkKSO6moOAPS+k91BwK0HtnYekB0e34sFzw05PGOhwGA6o8gOkbVpUAlEJVRgJTXoZbAQBm+GUDQgxm+MLLeVgF9qOAriXWadgL5sQFnxNMdODTltiweU05WOmpVqiqUTLXqv5K3L3viEaQBCQGB4xGPPHz7awHrxCcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PQQWr79p; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2b04fcfc0daso5984519eec.0
        for <stable@vger.kernel.org>; Mon, 19 Jan 2026 22:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768890542; x=1769495342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oLLa5fZdpzWHQDj1zzbC4zgrpjcPTG+wEA6kFtMuqxE=;
        b=PQQWr79pBmxcy1Qz6W84HEYSMmMT0+IUwcyFKyjmqUdbsCer+DedcO5Je/CPUlyuGV
         9PwWpL++JYXHFsevjlYWMC7QK5xjwlXdnIhOiLqk0yie4bC/BthBnBVe3kR3DvW54FTP
         aDyGgL2sJgo/mdcJ9/uuGTJA0ruccCQyWyDDQK8sGlXoPKYdzL9Egk2by2PlOEMLnpwd
         dnsQUOqW5RS2J0Mo3rwa9DhdbBTMDROmyUFgtRKxcf0BzLrFjtoC4e3HUy+cDLpBV09c
         BtdpCDe0ekzCdWlsMpDVv6dBdMLeP9bxmoPX6YPxepgPk9pVch5JOiiYPUdiywR4JSC7
         OlNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768890542; x=1769495342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oLLa5fZdpzWHQDj1zzbC4zgrpjcPTG+wEA6kFtMuqxE=;
        b=a/w2udMNPizpwT+Uj3s9FLvNMhd7n2SZIo02dOprYP+dxWGPhygacsrHTnKCacneOY
         t29GstEmGeEQho6KJYwY5EUcSKiytM1FjZHj8QIGOJHHpM/K7yReTKE32yCPwkhaGxD1
         MkOMgoRQFenZNeTYc3I85RjLoK6XQuGHYzFSUCeDm+Kq5Ya+tDxVJdsNPWLD8rcq/ylF
         3xa781rzE46qpzalEiGJ1bY6umqAlL9humSxr7u2m5BxHdu/QU8fdXK66J2elN1QEc/S
         3tbSZd8YktD4s5j7DWxOTPy0Gu+2SJ1IHCfgevl1NZW1NswCNDLtZhSEReDTpYCX2gUU
         r+Hg==
X-Forwarded-Encrypted: i=1; AJvYcCVH+S1jvPtNZUptOCpqY9swBqlUQdVc9ob1nOwjpIziJ17H7twEj7ModzfoxmJX4vZbSm4oSno=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxdh7ooNmaL0hy9orBQ6Ln+8UegcKEdWIUmS6MI9VROWQQgVSIx
	aTTageiTxeqJFxKuUUQegkjLPqEX5CooWP0TEA0ET0ca3T/OlQ77VYkx
X-Gm-Gg: AZuq6aKvPQEzItkvfzMN8U+aq4hj8Fo8QvhngPuXHou9aHdyj/Hu4Y0C1qr8UF+NFPX
	GSGfMkLwvvA3Fi7XkUbvjd0SMV5IUXHFXMSnAb1aNwGMxsPgGbo4b2DzSAH4SrlO1yHDY7k920t
	fReF03cwbsFGdTCkD/dVW7AJhULLqyR9VdTRgv5rboplDRgq6TBVCZJnHcLPFp4MV52b9HI8oVS
	ZFFTsflASvqrcOU6RdHk2mmQ9SIJvOoppeJJl8V9Infxa5/SQOtqEjXXqR9+RtC6IqvOxRnWFgm
	XbK0ilOZ4xKG708ovG6vuzC0MvhnLGRXpL3YYpCTbgk+ZHNPC0Ntrs9YrS5x8U2JViI72CNp1BE
	lzW7r+q+GajMge2zxJgji6ZerGP6KZguKC4QFlyy1DgKHbyY/s3WB8lVsuH/xN1GrSkLsEcISW1
	10X0KyqbjMh9IYniouyGuNqVDEun1j3pRDYoBDIkd9V1mXwvKFmLqb5GE+OgDL
X-Received: by 2002:a05:7301:5f85:b0:2ae:5af4:7d65 with SMTP id 5a478bee46e88-2b6b410b608mr10898547eec.31.1768890542196;
        Mon, 19 Jan 2026 22:29:02 -0800 (PST)
Received: from zcache.home.zacbowling.com ([2001:5a8:60d:bc9:f31e:1cb:296a:cc2a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b3502c91sm15706784eec.9.2026.01.19.22.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 22:29:01 -0800 (PST)
Sender: Zac Bowling <zbowling@gmail.com>
From: Zac <zac@zacbowling.com>
To: sean.wang@kernel.org
Cc: deren.wu@mediatek.com,
	kvalo@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	lorenzo@kernel.org,
	nbd@nbd.name,
	ryder.lee@mediatek.com,
	sean.wang@mediatek.com,
	stable@vger.kernel.org,
	linux@frame.work,
	zbowling@gmail.com,
	Zac Bowling <zac@zacbowling.com>
Subject: [PATCH 04/11] wifi: mt76: mt7921: fix deadlock in sta removal and suspend ROC abort
Date: Mon, 19 Jan 2026 22:28:47 -0800
Message-ID: <20260120062854.126501-5-zac@zacbowling.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120062854.126501-1-zac@zacbowling.com>
References: <CAGp9LzpuyXRDa=TxqY+Xd5ZhDVvNayWbpMGDD1T0g7apkn7P0A@mail.gmail.com>
 <20260120062854.126501-1-zac@zacbowling.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Zac Bowling <zac@zacbowling.com>

Fix deadlock scenarios in mt7921 ROC (Remain On Channel) abort paths:

1. Suspend path deadlock (pci.c, sdio.c):
   - Previous fix (b74d48c46f) added mutex around mt7921_roc_abort_sync
   - But roc_work acquires mutex, so cancel_work_sync can deadlock
   - Fix: Remove mutex wrappers since mt7921_roc_abort_sync doesn't
     actually need them (it only calls timer_delete_sync, cancel_work_sync,
     and ieee80211_iterate_interfaces which handles its own locking)

2. sta_remove path deadlock:
   - mt7921_mac_sta_remove is called from mt76_sta_remove which holds mutex
   - Calling mt7921_roc_abort_sync → cancel_work_sync can deadlock if
     roc_work is waiting for the mutex
   - Fix: Add mt7921_roc_abort_async (matching mt7925 pattern) that sets
     abort flag and schedules work instead of blocking
   - Add abort flag checking in mt7921_roc_work to handle async abort

The fix mirrors the mt7925 implementation which already handles these
scenarios correctly.

Fixes: b74d48c46f ("wifi: mt76: mt7921: fix mutex handling in multiple paths")
Signed-off-by: Zac Bowling <zac@zacbowling.com>
---
 .../net/wireless/mediatek/mt76/mt7921/main.c  | 29 +++++++++++++++----
 .../net/wireless/mediatek/mt76/mt7921/pci.c   |  2 --
 .../net/wireless/mediatek/mt76/mt7921/sdio.c  |  2 --
 3 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 9315dbdf8880..07d1d0d497f1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -367,17 +367,24 @@ static void mt7921_roc_iter(void *priv, u8 *mac,
 	mt7921_mcu_abort_roc(phy, mvif, phy->roc_token_id);
 }
 
+/* Async ROC abort - safe to call while holding mutex.
+ * Sets abort flag and schedules roc_work for cleanup.
+ */
+static void mt7921_roc_abort_async(struct mt792x_dev *dev)
+{
+	struct mt792x_phy *phy = &dev->phy;
+
+	set_bit(MT76_STATE_ROC_ABORT, &phy->mt76->state);
+	timer_delete(&phy->roc_timer);
+	ieee80211_queue_work(phy->mt76->hw, &phy->roc_work);
+}
+
 void mt7921_roc_abort_sync(struct mt792x_dev *dev)
 {
 	struct mt792x_phy *phy = &dev->phy;
 
 	timer_delete_sync(&phy->roc_timer);
 	cancel_work_sync(&phy->roc_work);
-	/* Note: caller must hold mutex if ieee80211_iterate_interfaces is
-	 * needed for ROC cleanup. Some call sites (like mt7921_mac_sta_remove)
-	 * already hold the mutex via mt76_sta_remove(). For suspend paths,
-	 * the mutex should be acquired before calling this function.
-	 */
 	if (test_and_clear_bit(MT76_STATE_ROC, &phy->mt76->state))
 		ieee80211_iterate_interfaces(mt76_hw(dev),
 					     IEEE80211_IFACE_ITER_RESUME_ALL,
@@ -392,6 +399,15 @@ void mt7921_roc_work(struct work_struct *work)
 	phy = (struct mt792x_phy *)container_of(work, struct mt792x_phy,
 						roc_work);
 
+	/* Check abort flag before acquiring mutex to prevent deadlock.
+	 * Only send expired callback if ROC was actually active.
+	 */
+	if (test_and_clear_bit(MT76_STATE_ROC_ABORT, &phy->mt76->state)) {
+		if (test_and_clear_bit(MT76_STATE_ROC, &phy->mt76->state))
+			ieee80211_remain_on_channel_expired(phy->mt76->hw);
+		return;
+	}
+
 	if (!test_and_clear_bit(MT76_STATE_ROC, &phy->mt76->state))
 		return;
 
@@ -887,7 +903,8 @@ void mt7921_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	struct mt792x_dev *dev = container_of(mdev, struct mt792x_dev, mt76);
 	struct mt792x_sta *msta = (struct mt792x_sta *)sta->drv_priv;
 
-	mt7921_roc_abort_sync(dev);
+	/* Async abort - caller already holds mutex */
+	mt7921_roc_abort_async(dev);
 	mt76_connac_free_pending_tx_skbs(&dev->pm, &msta->deflink.wcid);
 	mt76_connac_pm_wake(&dev->mphy, &dev->pm);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
index 9f76b334b93d..ec9686183251 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
@@ -426,9 +426,7 @@ static int mt7921_pci_suspend(struct device *device)
 	cancel_delayed_work_sync(&pm->ps_work);
 	cancel_work_sync(&pm->wake_work);
 
-	mt792x_mutex_acquire(dev);
 	mt7921_roc_abort_sync(dev);
-	mt792x_mutex_release(dev);
 
 	err = mt792x_mcu_drv_pmctrl(dev);
 	if (err < 0)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c b/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
index 92ea2811816f..3421e53dc948 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
@@ -219,9 +219,7 @@ static int mt7921s_suspend(struct device *__dev)
 	cancel_delayed_work_sync(&pm->ps_work);
 	cancel_work_sync(&pm->wake_work);
 
-	mt792x_mutex_acquire(dev);
 	mt7921_roc_abort_sync(dev);
-	mt792x_mutex_release(dev);
 
 	err = mt792x_mcu_drv_pmctrl(dev);
 	if (err < 0)
-- 
2.52.0


