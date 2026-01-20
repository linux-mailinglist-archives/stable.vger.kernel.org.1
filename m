Return-Path: <stable+bounces-210437-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D82FD3BF4F
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 07:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BEFF34F42C4
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 06:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B207381710;
	Tue, 20 Jan 2026 06:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ef7RKXMl"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF6F37F8A2
	for <stable@vger.kernel.org>; Tue, 20 Jan 2026 06:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768890548; cv=none; b=THd0f1JCaGJupKUOvTD29nUfGDxZ1pWRa3C3JK3CEyi5YBu8ToIVv+lDeJjosu0dUvKBqqcK4+lSrjjkoOPt9jO2yHphOfO3tcQv8iDdNK9UfRsW5t0FBhSF7q5tbGbW4FuS3pJrkf+Nl0XYShLkIgNRi9lXHa6iAz1lHA8A77E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768890548; c=relaxed/simple;
	bh=IkGS2pbb9DGLGXEWPJhYUmq0EJShmdW9s055oJTD1fM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r62XJxiWPv6S/2hQzpHY56Xjegt3Zf3yRF8WiEEhLTuoiDb4/UiCfn+87yP/fWj7E2CDtwdIeF199QWk++RLJ3DU5OS2b9z3l+7wP6yItU/dOee1J7l0oBvpV4abiet7FIKwaiI1ZSSKRmxV5ieMMtYM8mR6PU72SJdmMYxVCAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ef7RKXMl; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2ae61424095so5027866eec.1
        for <stable@vger.kernel.org>; Mon, 19 Jan 2026 22:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768890545; x=1769495345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gq8BwtBE3udkhb8xxJaDge5ayHDcllBWREYlF8lWPK8=;
        b=Ef7RKXMlRU6Wl/SKant8GmP849OnO+ckbTBrRC/vbhy+QBuGwkcVg2KqHc1OlGIvKb
         43KGyqAxELOBcjPrlPHLoZwBjI1t8wDXj1zTHVf8w0CcngZ2sVTKCe5OheDXFZ4O0d/G
         Dj2nMdtQLIzStvO1cGLqxmZCGBfMWl2tcOop/OHmDj4DhvqnWsVXQt6eeP0nSkHu9Hwu
         3kuJVbLdqCyKG9sdPeu0NrIxn4XO37qXIqZr/v/yx3CTw5+V0QxCMpUQb4ecLC14b4WE
         B+Ev7W4quQ/TC8dLEprOi/No1f7icosDUtaFP3gR4j9EDpsjFUybAer8i8dD+5H9nd2l
         Bobw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768890545; x=1769495345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gq8BwtBE3udkhb8xxJaDge5ayHDcllBWREYlF8lWPK8=;
        b=W6I6GZOkwoklqQ9r1ucDkXWNH58t5+RiH/lW3YKzodTgr0jKxS4/dr8mcFcSZenQWq
         6lzeAtnMJ5w2tjurd4+XNgZ4ci/dL8LRppPzJMbXuVyXnNvZDojOy1/cyeDnJaeooOXq
         7Hm4bvIFuPY/0VHdYHiDinNFSO0riQYWGmxOrjLBqYZKcJfItbRiZbFXiFc11dCWux9D
         mGHuGQ7ILspSNgPJUjlENfg7v/naFSwahxjiMAqKFCRVsJI3vw8xbvgaBT+m/BJp5jcw
         WAj6I7dPVZRceoZdaq/ZhSRNNKnwTFOwc4KlWq8Gggum9lhyH9BDifRmiISuTlmNInOt
         /MAQ==
X-Forwarded-Encrypted: i=1; AJvYcCV327SHJK6z/AF+1XHtT9Tz7/xA/Ri1OOdf91pWRDx4f4cgcnva9kk9qFAnU+SQ3n7C/ABDxbA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRaFt64fYdTjG4TBYxEn7F88r/I2tm0bytcTwIa2NI59r3On+/
	Ct9fjU+OaSSvYV0IIGmVdMZZLz3hxzHf7rOsjkLa/ux3iLBkJ/YjXWKu
X-Gm-Gg: AZuq6aIE6b3zL+qnnS0/eD7MickjJdO8XEVWOXybuE0+j5Xy+cnSAxSL6wmgVa2kE14
	pt4ULtFMWfXq4WpIQD2+VoeJbbtFlDtoJcBZIhXcYAZ8ntPCgAOEuf0hT+Kbt9KBGORFppLeCuE
	axh3BByAQ/kMnazBSAzytj6ekoSneTau/d65isIN05iQFmyyWXMXKe5WN8kW8gnMk7sPRMRDq4O
	6XGkNQUwDKUQJYSImzCHpIsD9F1XyV+MZBYlRAKyrdzKSe+9v1X6UkiFtoLOCTvqRloE+P+1not
	AjL9ez9q1LXHDoLPzs5CxIH+OYAPJ56Ur7EwIavCU4WbnwDUX/5yxvpsgzsH+/87AVrPZNKcWnY
	/sMuv7Xibi8EU9okWYi2aggqbEvGeCAFWRJujOKAhLJXT/7e5HhPOerqJu0UcrMDvjnd6/9scG/
	4u9Ivq+lDFG/IoK8JvNcDbGDobLgZWfPXUJIYilwkQWComLXEfirdWm3VeN8dh
X-Received: by 2002:a05:7301:290a:b0:2ae:60fd:6f18 with SMTP id 5a478bee46e88-2b6b4e8a496mr11903860eec.22.1768890544990;
        Mon, 19 Jan 2026 22:29:04 -0800 (PST)
Received: from zcache.home.zacbowling.com ([2001:5a8:60d:bc9:f31e:1cb:296a:cc2a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b3502c91sm15706784eec.9.2026.01.19.22.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 22:29:04 -0800 (PST)
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
Subject: [PATCH 06/11] wifi: mt76: mt7925: add mutex protection in critical paths
Date: Mon, 19 Jan 2026 22:28:49 -0800
Message-ID: <20260120062854.126501-7-zac@zacbowling.com>
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
Content-Transfer-Encoding: 8bit

From: Zac Bowling <zac@zacbowling.com>

Add proper mutex protection for mt7925 driver operations that access
hardware state without proper synchronization. This fixes race conditions
that can cause system instability during power management and recovery.

Fixes added:

1. mac.c: mt7925_mac_reset_work()
   - Wrap ieee80211_iterate_active_interfaces() with mt792x_mutex
   - The vif_connect_iter callback accesses hardware state

2. mac.c: mt7925_mac_sta_assoc()
   - Wrap vif_connect_iter call with mutex protection
   - Called during station association which races with PM

3. main.c: mt7925_set_runtime_pm()
   - Add mutex protection around mt76_connac_pm_wake/sleep
   - Runtime PM can race with other operations

4. main.c: mt7925_set_mlo_pm()
   - Add mutex protection around MLO PM configuration
   - Prevents races during MLO link setup/teardown

5. pci.c: mt7925_pci_resume()
   - Add mutex protection around ieee80211_iterate_active_interfaces
   - The vif iteration accesses hardware state that needs synchronization

These protections ensure consistent hardware state access during power
management transitions and recovery operations.

Fixes: c948b5da6bbe ("wifi: mt76: mt7925: add Mediatek Wi-Fi7 driver for mt7925 device")
Signed-off-by: Zac Bowling <zac@zacbowling.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/mac.c  | 2 ++
 drivers/net/wireless/mediatek/mt76/mt7925/main.c | 6 ++++--
 drivers/net/wireless/mediatek/mt76/mt7925/pci.c  | 4 ++++
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
index 184efe8afa10..06420ac6ed55 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
@@ -1331,9 +1331,11 @@ void mt7925_mac_reset_work(struct work_struct *work)
 	dev->hw_full_reset = false;
 	pm->suspended = false;
 	ieee80211_wake_queues(hw);
+	mt792x_mutex_acquire(dev);
 	ieee80211_iterate_active_interfaces(hw,
 					    IEEE80211_IFACE_ITER_RESUME_ALL,
 					    mt7925_vif_connect_iter, NULL);
+	mt792x_mutex_release(dev);
 	mt76_connac_power_save_sched(&dev->mt76.phy, pm);
 
 	mt7925_regd_change(&dev->phy, "00");
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 15d1b1b8d9f8..80ca5181150b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -755,9 +755,11 @@ void mt7925_set_runtime_pm(struct mt792x_dev *dev)
 	bool monitor = !!(hw->conf.flags & IEEE80211_CONF_MONITOR);
 
 	pm->enable = pm->enable_user && !monitor;
+	mt792x_mutex_acquire(dev);
 	ieee80211_iterate_active_interfaces(hw,
 					    IEEE80211_IFACE_ITER_RESUME_ALL,
 					    mt7925_pm_interface_iter, dev);
+	mt792x_mutex_release(dev);
 	pm->ds_enable = pm->ds_enable_user && !monitor;
 	mt7925_mcu_set_deep_sleep(dev, pm->ds_enable);
 }
@@ -1331,14 +1333,12 @@ mt7925_mlo_pm_iter(void *priv, u8 *mac, struct ieee80211_vif *vif)
 	if (mvif->mlo_pm_state != MT792x_MLO_CHANGED_PS)
 		return;
 
-	mt792x_mutex_acquire(dev);
 	for_each_set_bit(i, &valid, IEEE80211_MLD_MAX_NUM_LINKS) {
 		bss_conf = mt792x_vif_to_bss_conf(vif, i);
 		if (!bss_conf)
 			continue;
 		mt7925_mcu_uni_bss_ps(dev, bss_conf);
 	}
-	mt792x_mutex_release(dev);
 }
 
 void mt7925_mlo_pm_work(struct work_struct *work)
@@ -1347,9 +1347,11 @@ void mt7925_mlo_pm_work(struct work_struct *work)
 					      mlo_pm_work.work);
 	struct ieee80211_hw *hw = mt76_hw(dev);
 
+	mt792x_mutex_acquire(dev);
 	ieee80211_iterate_active_interfaces(hw,
 					    IEEE80211_IFACE_ITER_RESUME_ALL,
 					    mt7925_mlo_pm_iter, dev);
+	mt792x_mutex_release(dev);
 }
 
 void mt7925_scan_work(struct work_struct *work)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
index c4161754c01d..3a9e32a1759d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
@@ -455,7 +455,9 @@ static int mt7925_pci_suspend(struct device *device)
 	cancel_delayed_work_sync(&pm->ps_work);
 	cancel_work_sync(&pm->wake_work);
 
+	mt792x_mutex_acquire(dev);
 	mt7925_roc_abort_sync(dev);
+	mt792x_mutex_release(dev);
 
 	err = mt792x_mcu_drv_pmctrl(dev);
 	if (err < 0)
@@ -582,10 +584,12 @@ static int _mt7925_pci_resume(struct device *device, bool restore)
 	}
 
 	/* restore previous ds setting */
+	mt792x_mutex_acquire(dev);
 	if (!pm->ds_enable)
 		mt7925_mcu_set_deep_sleep(dev, false);
 
 	mt7925_mcu_regd_update(dev, mdev->alpha2, dev->country_ie_env);
+	mt792x_mutex_release(dev);
 failed:
 	pm->suspended = false;
 
-- 
2.52.0


