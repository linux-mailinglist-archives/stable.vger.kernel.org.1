Return-Path: <stable+bounces-210441-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 83934D3BF46
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 07:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 27290387FBE
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 06:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0233921EB;
	Tue, 20 Jan 2026 06:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bdZYWY0M"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B42E36CE15
	for <stable@vger.kernel.org>; Tue, 20 Jan 2026 06:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768890553; cv=none; b=EaqESWVX/VfI+V5MSxqS2A+vYJGn5rrwrhb+qpStnndWIgO4TGpzLxtYoupnwuvjEyjUxv5BqicWvTZjsatv9A2L6R0L1ZMy64VCICgsj01tITjvS4+i8DwexL+QcMLgATcuhTogvIhzAYOTCk326ccZgh3+rsAACHg2t2R3LNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768890553; c=relaxed/simple;
	bh=Msmn00R/whpSKvYB7cyEtq9bHDCq1FKIinq7ESwlb0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NzvY97Ud8eKBDE0DRswg0MguohlAQdum2xhrRmtt5NWnDw9J8fhJ6P9JbmOYuPWE18xrVqSV1agwMMWpQ+VKEOqOC1wLxVx0f2p5D+XPXzT8KsylhZ974S1DrZrBVtWVjmJ3apQ4ERimGEGHgcp7ptQNNnrwePebTFnb03CgD7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bdZYWY0M; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2b1981ca515so5420578eec.1
        for <stable@vger.kernel.org>; Mon, 19 Jan 2026 22:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768890550; x=1769495350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jhF6S0lUNMQ6iu2San+RRE4uR0QE14549Ly/QDJAGJY=;
        b=bdZYWY0MQnX439Gsqr9mhNTZ95TFGUu5Rj+o0spj358gQxqF5M2PAmVgltVjB1OEKO
         GVZyVABRVe5U1mm6ESeZDQjySwpkv4j9tN4R6eX26Jry2H6GMOCRb+6uIWT+yb4+e4R+
         PC8VsneaCHNeMErrw1o01BC0w64poyWNsZgbnwOnmHG4IlTV3dGwvrUgFmpW8dBgvdQR
         PlX2XGagVLTMMveJGD5RoGbBCLB6KzV32W0iKOg+vndK13BGXcfCXpfIxBBrdyKrAygl
         tBvbwJ6kjjMxSSIh5OBy6fp3/KG7aQIeflW/ws5OI1+Ri5j3ZeSmWCVVQLC0IXZlAUfM
         qokQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768890550; x=1769495350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jhF6S0lUNMQ6iu2San+RRE4uR0QE14549Ly/QDJAGJY=;
        b=o1N5wlFbD2vtKUuWS/HJh2oBZ4ctNIS+QdDwS5RDmRh8vpNOlJkwwBjNlD7gWBqzLn
         mA/ueSAETzExzPfWw33140a2fiB6RRfrstRHhk9w4fzp5d+9sUDVCAAXIQ9PNt4JLR5X
         AoAS4hsS+QdVebqjhbvYxQyCN8+ecyu5g7CnymJBentBeKOShUQjA0MNLir3Nnme3m26
         4GjIfy2yssAp9m7ayY7ikMIW8tvhu6nipWhqMermWbhiQWqQzZRhEa/ZH0sZ9+e6OJQ+
         /IWKRq88lf+OcIZNvQYEkMO0OUycUo1U8a4boXCqUFRzs48Xn49cU2WNBInJjlXzZUnN
         IObw==
X-Forwarded-Encrypted: i=1; AJvYcCWyeCCYl6wSDMvLGyttzUvhtUU5xjPxTvc6ZH0rzxG7tfSZe9sOJS6zPuWKWCxcgkAie5fbBmo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmXLPER3SXI4KR6Bwpfzst4XyBOISzpSwYuyA3G3Npu8zAM4bU
	8ey/lszzHdDOHVVTtbDAW0JJYXcepxRojcKGxRlbHY3VmEcJKYiTkfpq
X-Gm-Gg: AZuq6aIu4rKfTkcg5Hw4bxd7/ZcBGVvcNJr52Rjz7GUGBMlc2oWy0ue4cg7JNhaAbOx
	4uOcwfgsn8Mb6ZocJ3yDqpqC54+hFJi8+9RSUogFts3QUOil6kW9X00MfMcn569UbKUMPYl8pCz
	K6K2J0FFEK4ibh5dHu7q+1hmFxWa3rD2O/xgPK1wUvKZM3omBbgIdi86YjYcT7LrjGEf6bAb/IN
	o11RFlqBMxqZQ+lJd3JKgHHFpkVlnN3vkNNr/PpRnyp1lCnwyNFki8fgxfaECU7HCCXTrUEDk/a
	8dNGJ1vz9Yhd7prRKFbBpy3lcP+xjqysrDmuCOQdk+piK7yTbPOrPF1gM8kifBu+PYXj07c/WS1
	lK1FkC0DCIPyY1CF2PWU/W+/qkRGmj4HhEJW8rnCs8srfE7/SIIJSFA0g+kuFxhVMYlkmKt7mp9
	wKdFeTwc8NmZt/sm6xysfqKBcdqY5WtfdGGuolo1oz0W+sPbsXi9k/vx8jYjUOpAv6tCy8uYM=
X-Received: by 2002:a05:7300:3206:b0:2b4:7c92:3f7c with SMTP id 5a478bee46e88-2b6fd623ccdmr573615eec.6.1768890550416;
        Mon, 19 Jan 2026 22:29:10 -0800 (PST)
Received: from zcache.home.zacbowling.com ([2001:5a8:60d:bc9:f31e:1cb:296a:cc2a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b3502c91sm15706784eec.9.2026.01.19.22.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 22:29:10 -0800 (PST)
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
Subject: [PATCH 10/11] wifi: mt76: mt7925: fix BA session teardown during beacon loss
Date: Mon, 19 Jan 2026 22:28:53 -0800
Message-ID: <20260120062854.126501-11-zac@zacbowling.com>
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

The ieee80211_stop_tx_ba_cb_irqsafe() callback was conditionally called
only when the MCU command succeeded. However, during beacon connection
loss, the MCU command may fail because the AP is no longer reachable.

If the callback is not called, mac80211's BA session state machine gets
stuck in an intermediate state. When mac80211 later tries to tear down
all BA sessions during disconnection, it hits a WARN in
__ieee80211_stop_tx_ba_session() due to the inconsistent state.

Fix by making the callback unconditional, matching the behavior of
mt7921 and mt7996 drivers. The MCU command failure is acceptable during
disconnection - what matters is that mac80211 is notified to complete
the session teardown.

Reported-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Zac Bowling <zac@zacbowling.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/main.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 81373e479abd..cc7ef2c17032 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -1323,9 +1323,13 @@ mt7925_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	case IEEE80211_AMPDU_TX_STOP_CONT:
 		mtxq->aggr = false;
 		clear_bit(tid, &msta->deflink.wcid.ampdu_state);
-		ret = mt7925_mcu_uni_tx_ba(dev, params, false);
-		if (!ret)
-			ieee80211_stop_tx_ba_cb_irqsafe(vif, sta->addr, tid);
+		/* MCU command may fail during beacon loss, but callback must
+		 * always be called to complete the BA session teardown in
+		 * mac80211. Otherwise the state machine gets stuck and triggers
+		 * WARN in __ieee80211_stop_tx_ba_session().
+		 */
+		mt7925_mcu_uni_tx_ba(dev, params, false);
+		ieee80211_stop_tx_ba_cb_irqsafe(vif, sta->addr, tid);
 		break;
 	}
 	mt792x_mutex_release(dev);
-- 
2.52.0


