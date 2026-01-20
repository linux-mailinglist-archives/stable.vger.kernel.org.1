Return-Path: <stable+bounces-210432-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C66FDD3BF44
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 07:34:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6E6654F52C2
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 06:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB15F36E470;
	Tue, 20 Jan 2026 06:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KfBVCy6B"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA8D36CE0B
	for <stable@vger.kernel.org>; Tue, 20 Jan 2026 06:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768890540; cv=none; b=Vm59gBNdURAk9y2/JC8/6a39EZnVh24hC45Nq7jkVfyulT9mMJ180rs6heszkxqtARG7WdoVCLqKLfvEoswFQFFXj4BB64PL306bCCbd0fTY389LbcjbfL2+wc8L2bfsbw3Oc4UnuWPm8G2qd5yFJAfd8/RNtNWK8HvyGJS9Me8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768890540; c=relaxed/simple;
	bh=2+HHCsL4CHpvAxtcpZ+oNfJ91XAAY5ApArx/L+V3+Ww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WxDLTDKyGC15Cfe15wM4hK+0e5Gp3EWnICGMsrYhhQ/WvY7WPYqAUhcgz5FZrK/JgPpD6LSr7d2ZYvVA9yKhBoh7EWBsAil2RXJT+mcl4LNYdnegO2YgOfmm+PslElG6wKmi/Ku7u7BAXPiFpD5jhEIBBwNC+5241f5yy9rbs0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KfBVCy6B; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2b6bf6adc65so4982767eec.0
        for <stable@vger.kernel.org>; Mon, 19 Jan 2026 22:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768890538; x=1769495338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hZqhvQUqHyPjd5YwFiryR+es7m9UdWSAqM9hdcVMAYY=;
        b=KfBVCy6Btat3on8k4RWjWohTf/kL/A3GiZd/jR1dWPTZ7i8oymlmP7SNvzFIyhz0XK
         8nA5MBTVR2ZmcixOvOKqha7hwOgVfpEE4xClNZ9FbNCVyLLP1aa5qOCRci/93z/xAJ7y
         gGlVLb1IqjLb5qLobEpBugeiuNlaRdhzhF6g8sf8BY8uIZ7EuHNjUJsaWkjYu/EZCp7b
         ip0bDp+gWeLFxjsiP/2+eaSJkuHG8NRqay56tqxJeJ6D24Zf8zmryBhuoUKZjByAH3Hd
         zxBSCdt4hcC3HfQkao6ggL4hhq4z1UHu3RdOUQ5VVwsO6Wfat6XaFhuwUCErshY199Q/
         x32g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768890538; x=1769495338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hZqhvQUqHyPjd5YwFiryR+es7m9UdWSAqM9hdcVMAYY=;
        b=sBJ5n1tGstbJriWBSrFd6qRwPEL6lc+NKsFRIlDyTra0lRbDoJuRxLis9banER3seh
         z9PSXmUliVAE4CEdlluz1Wio9kajq4LBOVdcV32UbgW6bPKagXA8ufPEREVPoBvL/naF
         6kzpQBdRD5iz/u7HS9dgvXdnhpum3qHgrkHywhDiccf9r/Evoiubba6t8WRhCmOdsLKM
         UpiaK0+x4/EuOfsBTh1a/zPbfZB//z2ufskZwFALTIqbSIO+ln8A16++xTIYBcMJZ0dr
         LA682I5gMizUNq0WR88pRmU3/1TFzT3H3V7yl7Jt9ad4bBER438Q4Vcycoca07GhqJhm
         FY8g==
X-Forwarded-Encrypted: i=1; AJvYcCWlOWcrSmWjqKgV3R1L3jA1nXtYjK9EJ/2pnvlLl9r0S7+vscordjnsdXW0gY4de2XhLYe9VvM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe3kp5Goo6Aw1XHtxp3FqJY9G1jga0XTbunrRGA079TdNZHFXJ
	3KtzznHHq495msFCnoiPBNPpIXgW4xj132zPUZ/kIUNOknOaDfGJdmEJ
X-Gm-Gg: AZuq6aLMPK66WxSfx4WwQ9oS5dhuefL6Ee2llqd9mHSZbDn4gmJbVvu0wZfYMGQ0rGA
	3hLu7KWAOiUrrgJGVVD0v+Uhzsxi4fYOjFwtCVw8tQhqZtoRxMnOhgtXTqcM5EJymuPCqpHDj5r
	JD/AvNs/JK3/QJ/o4KsUWzxC8F0ATm1ixT9I15pGrGCLDyxCkuBNFrZ3Bb+Bli+OpfcqwWq3Nln
	KkGZ4Z2ACVHf/w27NQauDd2hmTIDlyNTxnBeSGCc+e2NMENC6s39M2VJ85QbJVBuSrnHzi/Mrex
	udtcpPSg3AThI5uBacy0l35rhpWB0Ud8G0jfiW4lbkq2QlrBJRWGbe7raTcUDrteqZ467dIx2pV
	P0Rqs1qpEdQ1hxapdeQ9wZpGvxxdhfgWGDQllHuPAxRLedxe7LHS0FyGLc3gLSnG681PqJVZ5O2
	UZhA9iF6aeEMAZuerYZ3kiP41/xg+7is+hwPO4urPQ1hwWNSLQAKlhXi3vc1ym1r7B5jbkGFM=
X-Received: by 2002:a05:7300:6420:b0:2ac:1c5a:9950 with SMTP id 5a478bee46e88-2b6b4e98df3mr12535391eec.34.1768890538000;
        Mon, 19 Jan 2026 22:28:58 -0800 (PST)
Received: from zcache.home.zacbowling.com ([2001:5a8:60d:bc9:f31e:1cb:296a:cc2a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b3502c91sm15706784eec.9.2026.01.19.22.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 22:28:57 -0800 (PST)
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
Subject: [PATCH 01/11] wifi: mt76: fix list corruption in mt76_wcid_cleanup
Date: Mon, 19 Jan 2026 22:28:44 -0800
Message-ID: <20260120062854.126501-2-zac@zacbowling.com>
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

mt76_wcid_cleanup() was not removing wcid entries from sta_poll_list
before mt76_reset_device() reinitializes the master list. This leaves
stale pointers in wcid->poll_list, causing list corruption when
mt76_wcid_add_poll() later checks list_empty() and tries to add the
entry back.

The fix adds proper cleanup of poll_list in mt76_wcid_cleanup(),
matching how tx_list is already handled. This is similar to what
mt7996_mac_sta_deinit_link() already does correctly.

Fixes list corruption warnings like:
  list_add corruption. prev->next should be next (ffffffff...)

Signed-off-by: Zac Bowling <zac@zacbowling.com>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 75772979f438..d0c522909e98 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -1716,6 +1716,16 @@ void mt76_wcid_cleanup(struct mt76_dev *dev, struct mt76_wcid *wcid)
 
 	idr_destroy(&wcid->pktid);
 
+	/* Remove from sta_poll_list to prevent list corruption after reset.
+	 * Without this, mt76_reset_device() reinitializes sta_poll_list but
+	 * leaves wcid->poll_list with stale pointers, causing list corruption
+	 * when mt76_wcid_add_poll() checks list_empty().
+	 */
+	spin_lock_bh(&dev->sta_poll_lock);
+	if (!list_empty(&wcid->poll_list))
+		list_del_init(&wcid->poll_list);
+	spin_unlock_bh(&dev->sta_poll_lock);
+
 	spin_lock_bh(&phy->tx_lock);
 
 	if (!list_empty(&wcid->tx_list))
-- 
2.52.0


