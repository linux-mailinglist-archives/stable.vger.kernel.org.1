Return-Path: <stable+bounces-210438-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EF216D3BF3E
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 07:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E2042386956
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 06:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 952CA36CDF4;
	Tue, 20 Jan 2026 06:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CPJv5e58"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877E23815D7
	for <stable@vger.kernel.org>; Tue, 20 Jan 2026 06:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768890549; cv=none; b=UFJsBVvtF03sn9LWI1tWCJLi4YIMGx5btd+DrThTaYTzI7guYKC1j53e519Opr7L/spmyZx9C1nac7fNy9nIOJBSEr/U0Dr4VWtiTV2YmqO9RR+Gj5v9iIfzUD+ztoR5IwKDn6NmCGxEYaveHxzodL//BWU1B0A3USRBjWWYAfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768890549; c=relaxed/simple;
	bh=56oCFiJ1Fh61sRezmynDWOGrNpWTbudvtUqxK0WIYv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aa2OtejW6DIhkvvYxfwwI76gK86Wncj95+/UB9pKVXMCK7fq/wAYsV1h+ATldQaJSQwU4SQgef2clFgeRp8YIxYbQZx9xasKx8tl9vze+iAJOZkTIiKY3+PVDVapx/7gLVqCcRw7IKADCaW3kqmV7Pqlyn1SfN5ooQI/Eoz1Yko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CPJv5e58; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2ac3d5ab81bso5272121eec.1
        for <stable@vger.kernel.org>; Mon, 19 Jan 2026 22:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768890547; x=1769495347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VGov7+UsnnkD8BK1HtQcfIxHNxhYSq3s1xKOOfEdd3U=;
        b=CPJv5e58By9ox8KUwU+eCWb5ka9LmnEqfyDiXnMnSv5mUqSldNXxYMt1VxMJX9HpWu
         rl9w3oQ5/40PpPCg9GzjtwSwDS+YNHUkAmFkJz4Dr4t5nWzzcWrS07NW5XZrmrBhnssj
         4xAwPE3x+JDSOaKURfqVROY9mCQFEe9lbAvuwWhdcMNx98Y4MZ6x+heQUgJINwagv1wj
         GyStPgW2HKSJJYhKS6kT1UV7ZHwCZB3JMxOmDhHO33hoV268/jdxC4I5SlIgPl9hT/ka
         D0qJbgNyedvgwHVBRFPjmnHRDxDm0MGwdSkwLoY1+i2Tc+JTnWDHz58S/MKgrawnQL+Z
         A1jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768890547; x=1769495347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VGov7+UsnnkD8BK1HtQcfIxHNxhYSq3s1xKOOfEdd3U=;
        b=C1tVrfsofjg8JRgJbjQosfKnyYuiqUobkmTOqvW+QGeY3kAJisq41zUFKDfxUzV7mU
         Sz7/55KB7+lckB7Sf2PZfIGeDQ/1MfxTVjcJMsiXGnJDmjKPaLAhIt4ne9OT9m6606wD
         C1dz/la75v9by5b76NrSjGLKS/+h3G/kejrb9t+tM6x5nGvZtZZcerC4+/Ff/Gvn1ptz
         rK7J1GlZQ0d8i/qiNSLUYNosKq3/53hTMQ4AOcEWt82T2rn93xiyzFj3k8yFs8zylks6
         qbkJNA9RmJ72Q+DKw6i93o1t9DEmiQN40tujVWigfQdWEUVDQ4AD+mfI/dqZTukEFb0g
         KTtQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpxWGkTDMYfHF82SG0Bc4P116zXLHhQWaA9c9OzH767xdV5PN8n0mnHbuhNhdnxh+a1Kk/Qek=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3TNMaqLVSFqnOQVNVLjYtIvGw18++Noh1gW+au7I1jLcKnf/H
	3P95YlnPMEZ2ZUj8g8B/vYel0ARTYNOb9zcvh925W8FjFTtFkbkU9IkU
X-Gm-Gg: AZuq6aJeHKjjMaizUTzEOztT2lx+DsUV4p/9L/fYIqzugUxqKc8dfI+kV7UVX11lMQa
	Q4MscCtN7vwGhvxGLoR4Rlxmi7+73nkDTm3NWyG4sKFeAcS9Rlyv8hKNCwqyrx91mFiAb86HvsQ
	82o7Jr3P3EOmiFLY6KCjmyGsQRPDG+McHqysoBTXEXOBETYvgOlMCwuy0tFCjYi+zMjb99VnxvC
	xE1vk12y6udUHkCT7FRkmMwtP0yKgHSDSg47NqfaZhMKf+KpgR4EynZsT8foCT3tEBeV95hftpq
	3++uSHuJ9VuADu2u9YkzcIuG70Ota51cU2PBd5Mo8HtEy8Gaz0uHTMZ2FPlL+aPN1TJilziQDF7
	xLuHzQqEen5jE0+xvO8uEiZ0u1yTpNePXlMfKFvWKLZPNA3lFyOlxC2U21W8aKEL/yy8Y9CRjKq
	sLm4ItNZDmHovohPC4NlfniwcJiIfjfP2IPhhkiPwNlCUb+XUlCblvjsYK3OMUASJm+NLXQzE=
X-Received: by 2002:a05:7300:6420:b0:2ac:1c5a:9950 with SMTP id 5a478bee46e88-2b6b4e98df3mr12535539eec.34.1768890546301;
        Mon, 19 Jan 2026 22:29:06 -0800 (PST)
Received: from zcache.home.zacbowling.com ([2001:5a8:60d:bc9:f31e:1cb:296a:cc2a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b3502c91sm15706784eec.9.2026.01.19.22.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 22:29:05 -0800 (PST)
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
Subject: [PATCH 07/11] wifi: mt76: mt7925: add MCU command error handling
Date: Mon, 19 Jan 2026 22:28:50 -0800
Message-ID: <20260120062854.126501-8-zac@zacbowling.com>
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

Add proper error handling for MCU command return values that were
previously being ignored. Without proper error handling, failures in
MCU communication can leave the driver in an inconsistent state.

Functions updated:

1. main.c: mt7925_ampdu_action() - BA session setup
   - Check mt7925_mcu_uni_tx_ba() return value
   - Check mt7925_mcu_uni_rx_ba() return value
   - Return error to mac80211 on failure

2. main.c: mt7925_mac_link_sta_add() - Station addition
   - Check mt7925_mcu_add_bss_info() return value
   - Propagate errors during station setup

3. main.c: mt7925_set_key() - Key installation
   - Check mt7925_mcu_add_bss_info() return value when setting
     BSS info before key installation
   - Prevent key setup on communication failure

These changes ensure that MCU communication failures are properly
detected and reported to mac80211, allowing proper error recovery
instead of leaving the driver in an undefined state.

Fixes: c948b5da6bbe ("wifi: mt76: mt7925: add Mediatek Wi-Fi7 driver for mt7925 device")
Signed-off-by: Zac Bowling <zac@zacbowling.com>
---
 .../net/wireless/mediatek/mt76/mt7925/main.c  | 30 +++++++++++--------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 80ca5181150b..5f8a28d5ff72 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -637,8 +637,10 @@ static int mt7925_set_link_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 		struct mt792x_phy *phy = mt792x_hw_phy(hw);
 
 		mconf->mt76.cipher = mt7925_mcu_get_cipher(key->cipher);
-		mt7925_mcu_add_bss_info(phy, mconf->mt76.ctx, link_conf,
-					link_sta, true);
+		err = mt7925_mcu_add_bss_info(phy, mconf->mt76.ctx, link_conf,
+					      link_sta, true);
+		if (err)
+			goto out;
 	}
 
 	if (cmd == SET_KEY)
@@ -904,11 +906,14 @@ static int mt7925_mac_link_sta_add(struct mt76_dev *mdev,
 	/* should update bss info before STA add */
 	if (vif->type == NL80211_IFTYPE_STATION && !link_sta->sta->tdls) {
 		if (ieee80211_vif_is_mld(vif))
-			mt7925_mcu_add_bss_info(&dev->phy, mconf->mt76.ctx,
-						link_conf, link_sta, link_sta != mlink->pri_link);
+			ret = mt7925_mcu_add_bss_info(&dev->phy, mconf->mt76.ctx,
+						      link_conf, link_sta,
+						      link_sta != mlink->pri_link);
 		else
-			mt7925_mcu_add_bss_info(&dev->phy, mconf->mt76.ctx,
-						link_conf, link_sta, false);
+			ret = mt7925_mcu_add_bss_info(&dev->phy, mconf->mt76.ctx,
+						      link_conf, link_sta, false);
+		if (ret)
+			return ret;
 	}
 
 	if (ieee80211_vif_is_mld(vif) &&
@@ -1287,22 +1292,22 @@ mt7925_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	case IEEE80211_AMPDU_RX_START:
 		mt76_rx_aggr_start(&dev->mt76, &msta->deflink.wcid, tid, ssn,
 				   params->buf_size);
-		mt7925_mcu_uni_rx_ba(dev, params, true);
+		ret = mt7925_mcu_uni_rx_ba(dev, params, true);
 		break;
 	case IEEE80211_AMPDU_RX_STOP:
 		mt76_rx_aggr_stop(&dev->mt76, &msta->deflink.wcid, tid);
-		mt7925_mcu_uni_rx_ba(dev, params, false);
+		ret = mt7925_mcu_uni_rx_ba(dev, params, false);
 		break;
 	case IEEE80211_AMPDU_TX_OPERATIONAL:
 		mtxq->aggr = true;
 		mtxq->send_bar = false;
-		mt7925_mcu_uni_tx_ba(dev, params, true);
+		ret = mt7925_mcu_uni_tx_ba(dev, params, true);
 		break;
 	case IEEE80211_AMPDU_TX_STOP_FLUSH:
 	case IEEE80211_AMPDU_TX_STOP_FLUSH_CONT:
 		mtxq->aggr = false;
 		clear_bit(tid, &msta->deflink.wcid.ampdu_state);
-		mt7925_mcu_uni_tx_ba(dev, params, false);
+		ret = mt7925_mcu_uni_tx_ba(dev, params, false);
 		break;
 	case IEEE80211_AMPDU_TX_START:
 		set_bit(tid, &msta->deflink.wcid.ampdu_state);
@@ -1311,8 +1316,9 @@ mt7925_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	case IEEE80211_AMPDU_TX_STOP_CONT:
 		mtxq->aggr = false;
 		clear_bit(tid, &msta->deflink.wcid.ampdu_state);
-		mt7925_mcu_uni_tx_ba(dev, params, false);
-		ieee80211_stop_tx_ba_cb_irqsafe(vif, sta->addr, tid);
+		ret = mt7925_mcu_uni_tx_ba(dev, params, false);
+		if (!ret)
+			ieee80211_stop_tx_ba_cb_irqsafe(vif, sta->addr, tid);
 		break;
 	}
 	mt792x_mutex_release(dev);
-- 
2.52.0


