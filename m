Return-Path: <stable+bounces-78648-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E117898D2BF
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 14:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71ED6284B95
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 12:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E141CF5F7;
	Wed,  2 Oct 2024 12:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=georgmueller@gmx.net header.b="mbS+9rps"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DF51CF5E9
	for <stable@vger.kernel.org>; Wed,  2 Oct 2024 12:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727870955; cv=none; b=ubXML4SBPuLzN0dIhfMtbx5Hz+y8g5Dymb7H2VFQM0pMWToOKE1ZzVNgndPJlFrGA08fT4f5m3K5iohZ1OLzjfS3PtW3K9oEZX642XGmP0EF6hf9Ti3RsOY2k6z6KP+ZasoEm5CfgfsNyTJ3dNT8NQdQKEuo6Laxja7+MRxP34c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727870955; c=relaxed/simple;
	bh=mlsMNhqU/iu0d6dO6AV1BICgWqhbUAZXZcmCifrsFAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n2+7bncBfbM/e2GtVrenkwtsTmXPL1VkvYp1xpZ1ZbZ3urt+oYBizWmp1Hf9mBWErmsDO6hE7tBby6vYCWG6VSwjvGURInKpLNbLrvs1qbktPCZWJcLpOjeEmlrWJzc23tQuVJyFUgLk6Bw2ZWMXt6HQmK/XZ/znZ7i78ZI7Puo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=georgmueller@gmx.net header.b=mbS+9rps; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1727870944; x=1728475744; i=georgmueller@gmx.net;
	bh=RZ3zzDe6nMoi0MlcMQViX9yZmZpbpYVdX7N2qDSmby0=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=mbS+9rps8VpEV8EWn9FwiruHTDPv/LKZCsR/qnZYJ8P3Rn0PHfLesc7k77LMN2sW
	 1R5WZA18GxclgwwPUXRL/MfXbmbTVzUfxLYnUWLJTZstOjJfNJ3onip0D3RS5tF9j
	 SMoGNaIVRgKXXeOz8eQTy9yFAUadM0MUZ1FncGP29lYfwSxqrbdsl1lcAtgVxVFe7
	 Vxk6YsuJHEh69Mfy33WjmCVMcS6mqQm1reGOMPKF4Nayidr83OeSdmEB19Nxu8HkJ
	 8Wl2Dgl/WHfnsJwQKGxJGs0dptNiOQmpMNj+tSMexRgHw6/6zHxiRqEwjRd/h1agh
	 CZwjD16DY796UBlCvw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from nb-georg.intra.allegro-packets.com ([80.153.205.84]) by
 mail.gmx.net (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MvbBu-1s4p0j3onu-00wgqa; Wed, 02 Oct 2024 14:09:03 +0200
From: =?UTF-8?q?Georg=20M=C3=BCller?= <georgmueller@gmx.net>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Stuart Hayhurst <stuart.a.hayhurst@gmail.com>,
	Helmut Grohne <helmut@freexian.com>,
	Kalle Valo <kvalo@kernel.org>,
	=?UTF-8?q?Georg=20M=C3=BCller?= <georgmueller@gmx.net>
Subject: [PATCH] wifi: mt76: do not run mt76_unregister_device() on unregistered hw
Date: Wed,  2 Oct 2024 14:06:24 +0200
Message-ID: <20241002120721.1324759-1-georgmueller@gmx.net>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <2024100221-flight-whenever-eedb@gregkh>
References: <2024100221-flight-whenever-eedb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5kfWSNSkMyfA7ZsXuFXYmis/a2RvcoLs09kSSsSueWiLr1fW3Yo
 Zzj5ymMpcNI6UPTXTTX4CSpOtQXg+5pEwrllh7hOJanVddhmhz+YMpScY+ctV/iEZUZjNvc
 YuCk11KyGHq4JlvnDJRCNKf9F8bLQuhTbuEARc5ROXmJdF1PsSOwkMrLj0DhM+ZlwSLXbM4
 7UB3LV/z9+TcZYmRjpnGg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:KMoVEegJc6w=;hoTo9oKL9Szh7cus9no8Xag3xbv
 FKm3F1b5uHdjtBcAov0ERMnK425PWdwH4lGbKWVIbCa64VJccrpC2hW9ETjbNxsYtkGIhdRP9
 u1bIhXzum47RK8QLP/2Eoq0pmOhTrpCkYP38MVvi2cCMvrXBtt4Q5TJrvALKKcXkr4zo3ArwN
 gN0nvKR857CEcxBXlyz8ZsMM9J2KLTmiOkO5jhYdJed7tlrTHkFQMQlQbNTs/OSnMDIhOhHRC
 wcNuu9bJVxQWe0RN2ZpuHLnpXjQUzx0Sod5N6GtGhNpbTOZF/xQhk1c+Ap6+uuzzT2xLCMHWw
 160B1fD1Zwcegc7quIbGepANAH26vGYbtjakawIsTbpH+0TI7gCx/q5jyWEja3z2XtiA12Ycc
 LddYgRkI8Z3iV1wCMVGflLP71riw6gqHw8JXVISgV+N9VzrpdKpPezCbHQzlxd6dxQopmFzhC
 Lzbtn05io4D3zICwK5MLJwLG77ypKfKN2Nm3Vxipc45QTp3/w1eMdcIvstiyds+7j1eJ4Hdua
 MrWGjidORrNA5AmRBwyo2DAEuVBk9E9aUFntW7jTXU8/bQCvdt136+6QFAutd+gYVB/occn8J
 n6e229AQ0ZZhxVzhEi39AcfM9/ICxCqBq/CnT2pqmu3jAMPfvriVyaIWRaqw5vVgRFPFPmLSd
 JR80lEKNYrIF22mE+p8pwzzAtc+9FJnYgNM/0VW91BtE8guyF+aFLU0vnjDIzIzCwpJnxr2mx
 GTFLynHFAw6bdq2zg5dRHCNWONfoLBInn8U/UiFekXheMtelyZQ/5+4ri3TWdpSfx9WM6fqfz
 83/h2JCU4QuDJm8qUYrILMTQ==

From: Lorenzo Bianconi <lorenzo@kernel.org>

commit 41130c32f3a18fcc930316da17f3a5f3bc326aa1 upstream.

Trying to probe a mt7921e pci card without firmware results in a
successful probe where ieee80211_register_hw hasn't been called. When
removing the driver, ieee802111_unregister_hw is called unconditionally
leading to a kernel NULL pointer dereference.
Fix the issue running mt76_unregister_device routine just for registered
hw.

Link: https://bugs.debian.org/1029116
Link: https://bugs.kali.org/view.php?id=3D8140
Reported-by: Stuart Hayhurst <stuart.a.hayhurst@gmail.com>
Fixes: 1c71e03afe4b ("mt76: mt7921: move mt7921_init_hw in a dedicated wor=
k")
Tested-by: Helmut Grohne <helmut@freexian.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Signed-off-by: Georg M=C3=BCller <georgmueller@gmx.net>
Link: https://lore.kernel.org/r/be3457d82f4e44bb71a22b2b5db27b644a37b1e1.1=
677107277.git.lorenzo@kernel.org
=2D--
 drivers/net/wireless/mediatek/mt76/mac80211.c | 8 ++++++++
 drivers/net/wireless/mediatek/mt76/mt76.h     | 1 +
 2 files changed, 9 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/w=
ireless/mediatek/mt76/mac80211.c
index 6de13d641438..82fce4b1d581 100644
=2D-- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -522,6 +522,7 @@ int mt76_register_phy(struct mt76_phy *phy, bool vht,
 	if (ret)
 		return ret;

+	set_bit(MT76_STATE_REGISTERED, &phy->state);
 	phy->dev->phys[phy->band_idx] =3D phy;

 	return 0;
@@ -532,6 +533,9 @@ void mt76_unregister_phy(struct mt76_phy *phy)
 {
 	struct mt76_dev *dev =3D phy->dev;

+	if (!test_bit(MT76_STATE_REGISTERED, &phy->state))
+		return;
+
 	mt76_tx_status_check(dev, true);
 	ieee80211_unregister_hw(phy->hw);
 	dev->phys[phy->band_idx] =3D NULL;
@@ -654,6 +658,7 @@ int mt76_register_device(struct mt76_dev *dev, bool vh=
t,
 		return ret;

 	WARN_ON(mt76_worker_setup(hw, &dev->tx_worker, NULL, "tx"));
+	set_bit(MT76_STATE_REGISTERED, &phy->state);
 	sched_set_fifo_low(dev->tx_worker.task);

 	return 0;
@@ -664,6 +669,9 @@ void mt76_unregister_device(struct mt76_dev *dev)
 {
 	struct ieee80211_hw *hw =3D dev->hw;

+	if (!test_bit(MT76_STATE_REGISTERED, &dev->phy.state))
+		return;
+
 	if (IS_ENABLED(CONFIG_MT76_LEDS))
 		mt76_led_cleanup(dev);
 	mt76_tx_status_check(dev, true);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wirel=
ess/mediatek/mt76/mt76.h
index 60c9f9c56a4f..5b03e3b33d54 100644
=2D-- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -388,6 +388,7 @@ struct mt76_tx_cb {

 enum {
 	MT76_STATE_INITIALIZED,
+	MT76_STATE_REGISTERED,
 	MT76_STATE_RUNNING,
 	MT76_STATE_MCU_RUNNING,
 	MT76_SCANNING,
=2D-
2.46.2


