Return-Path: <stable+bounces-84616-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8292699D112
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 17:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B420B1C23612
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 15:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A6F1AB505;
	Mon, 14 Oct 2024 15:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="e4kZM2UX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FCA1AA793;
	Mon, 14 Oct 2024 15:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728918625; cv=none; b=LpvR3Pt51csrFif2hTqa867cF5U0Vz4MlYn06x2onMTWVCiWQ8tSPHT1RQk0mh/luBrc3KwTAviu/YowK85+KZ4n+gU9AvfkcQnLbJQP4vgIAg/4bqPWjh0M57sILK6QHNicvl+97BY+/TwO5gwMFhH7k9QueLaCek4bBRzdNdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728918625; c=relaxed/simple;
	bh=fvDZQkxJUs+nA9GgGGqcyUJrPSnZOGQ1HBKGCEcNqMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=udZIi+dFH4gJn4rNIyymU7LR1S0xLR5wC0OocnoAiFb2rwVMEw5p3Y0BgbWn89cckyzB8I3PHmDWFlHw09KqbX+Q35575t5hwJNGH8szB27TdeLO/+D82NnzetFtwhbyrJJEVHy+j+Cm2syks75+KBw/WxZ8NvV7I47KoMrhRfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=e4kZM2UX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47AF3C4CEC3;
	Mon, 14 Oct 2024 15:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728918625;
	bh=fvDZQkxJUs+nA9GgGGqcyUJrPSnZOGQ1HBKGCEcNqMY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e4kZM2UX0eT05yRX0uYyQftsxrNruvC+lKRr+EtmelqiqBcpntHvKJmOLtIgws7LF
	 4zCIkdM7Wtwy5GNISPUvCUi96tGrxPRZofZDE9BPYiZR1eFvA0LIrvhSLHYYuaP+18
	 xyVrYJvawDkCcPQTAacthXZcoPllvoq6B99ysmYM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Stuart Hayhurst <stuart.a.hayhurst@gmail.com>,
	Helmut Grohne <helmut@freexian.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Kalle Valo <kvalo@kernel.org>,
	=?UTF-8?q?Georg=20M=C3=BCller?= <georgmueller@gmx.net>
Subject: [PATCH 6.1 376/798] wifi: mt76: do not run mt76_unregister_device() on unregistered hw
Date: Mon, 14 Oct 2024 16:15:30 +0200
Message-ID: <20241014141232.725633905@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241014141217.941104064@linuxfoundation.org>
References: <20241014141217.941104064@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lorenzo Bianconi <lorenzo@kernel.org>

commit 41130c32f3a18fcc930316da17f3a5f3bc326aa1 upstream.

Trying to probe a mt7921e pci card without firmware results in a
successful probe where ieee80211_register_hw hasn't been called. When
removing the driver, ieee802111_unregister_hw is called unconditionally
leading to a kernel NULL pointer dereference.
Fix the issue running mt76_unregister_device routine just for registered
hw.

Link: https://bugs.debian.org/1029116
Link: https://bugs.kali.org/view.php?id=8140
Reported-by: Stuart Hayhurst <stuart.a.hayhurst@gmail.com>
Fixes: 1c71e03afe4b ("mt76: mt7921: move mt7921_init_hw in a dedicated work")
Tested-by: Helmut Grohne <helmut@freexian.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://lore.kernel.org/r/be3457d82f4e44bb71a22b2b5db27b644a37b1e1.1677107277.git.lorenzo@kernel.org
Signed-off-by: Georg Müller <georgmueller@gmx.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c |    8 ++++++++
 drivers/net/wireless/mediatek/mt76/mt76.h     |    1 +
 2 files changed, 9 insertions(+)

--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -522,6 +522,7 @@ int mt76_register_phy(struct mt76_phy *p
 	if (ret)
 		return ret;
 
+	set_bit(MT76_STATE_REGISTERED, &phy->state);
 	phy->dev->phys[phy->band_idx] = phy;
 
 	return 0;
@@ -532,6 +533,9 @@ void mt76_unregister_phy(struct mt76_phy
 {
 	struct mt76_dev *dev = phy->dev;
 
+	if (!test_bit(MT76_STATE_REGISTERED, &phy->state))
+		return;
+
 	mt76_tx_status_check(dev, true);
 	ieee80211_unregister_hw(phy->hw);
 	dev->phys[phy->band_idx] = NULL;
@@ -654,6 +658,7 @@ int mt76_register_device(struct mt76_dev
 		return ret;
 
 	WARN_ON(mt76_worker_setup(hw, &dev->tx_worker, NULL, "tx"));
+	set_bit(MT76_STATE_REGISTERED, &phy->state);
 	sched_set_fifo_low(dev->tx_worker.task);
 
 	return 0;
@@ -664,6 +669,9 @@ void mt76_unregister_device(struct mt76_
 {
 	struct ieee80211_hw *hw = dev->hw;
 
+	if (!test_bit(MT76_STATE_REGISTERED, &dev->phy.state))
+		return;
+
 	if (IS_ENABLED(CONFIG_MT76_LEDS))
 		mt76_led_cleanup(dev);
 	mt76_tx_status_check(dev, true);
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -388,6 +388,7 @@ struct mt76_tx_cb {
 
 enum {
 	MT76_STATE_INITIALIZED,
+	MT76_STATE_REGISTERED,
 	MT76_STATE_RUNNING,
 	MT76_STATE_MCU_RUNNING,
 	MT76_SCANNING,



