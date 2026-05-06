Return-Path: <stable+bounces-244291-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMQfMyGc+mkKQQMAu9opvQ
	(envelope-from <stable+bounces-244291-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 03:40:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D80EF4D5590
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 03:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8169D3024112
	for <lists+stable@lfdr.de>; Wed,  6 May 2026 01:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF59286425;
	Wed,  6 May 2026 01:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lT5rUTZR"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F81727AC4C
	for <stable@vger.kernel.org>; Wed,  6 May 2026 01:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778031604; cv=none; b=tvPPiaUamfcj7ti3NKmRM2N6XvKHqus5KnCBiSDy9l6RfrVgcXXrM4OXKDGU7vIfddgkP58K34k+vbZMXxuryNuZuqc1+9pog6F+699NJbofJaBkxA1qfLob1KY+etrYlDhowsanTdvH3fhoMiAk2eqfOg23LKKHhrgH8h5d98g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778031604; c=relaxed/simple;
	bh=Gr7EWkvsipUpzm6yGXOHgRC0cyi+bO2nl/KB1dA/mFg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZHA2QIXkxNlLJrJ3tr3ZaA4CSnoaaRKTro5x9TFuRFSSKXC/iLQ9ven+ntHBqCK9ZP0F3vrKpt0ywEvy8fSZt/IzKdqzgDm2DY0z3EU1+piKKcrcUCZQlGiQUSZqXRN4l/uHB0sHAw5KUFOiP8pQON08Jwn6+15QBmfnzmnVjEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lT5rUTZR; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-67389cf78b0so11589122a12.2
        for <stable@vger.kernel.org>; Tue, 05 May 2026 18:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778031601; x=1778636401; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EU+q7eWhkGer8GyP69DC5ptsWUViocS21pDQ3GPfREM=;
        b=lT5rUTZRSP60ozi3CDhpxL1mPL7V8WE29RKdRfZhQuOAnIWVAc3xIr2AUt1REN4qtB
         ioZ9NcHB6Sjj+YE61M+r1HbqbpGe4QZ+iVxM1S/uk/qdgENrO1rMqRJh1M5w71psZT+X
         Pf4ZpfzWW6O4KEWkl225cZopUsvbsVFcEgaqeo/DC19mx+znWbDI1ZAXopbVFL3FRElW
         lxLW2SZC6UEM+K+5N+kGJnpMwKtgDVPgk/jp8u+1QFx1MjpBsGYCylDwgUdxvH+Til5y
         orvGrYWUbn7EPPpLQm37f+g44SAKPL9cVyfxJcAAHPbR9VWvflbabGLIfpK3WDDgC+oH
         spSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778031601; x=1778636401;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EU+q7eWhkGer8GyP69DC5ptsWUViocS21pDQ3GPfREM=;
        b=acnohIChuZuvI9JayU/yHpmlpkPzGHOFiX+Jp7Q2XfnIN9VwPLarq4OFH9I3Z3ReP2
         zqBhRt9+mE5BpmrBldDnULaTf3lP7QB1iqCLH44RDBFr/6iTOTrg52/Dm323B1wIzdPi
         2144x5sliYcy7fehycuhBx6cp2Ehge4SRS5nvjumde8gCShbR24YNh4R9y95/IADQh7a
         OmdJh7EmmDXXfepBHGJ4DBNPKOC6MnwB0eBWdf9ysao+OeVKW/q8ib0M6H0Y4BpB8yPm
         mHyoNW8BWgXG2Mvg3hOepzF0TgoH8TnUQ01N/cNXTCNoR98MiEtaYnS3+mlrBpUPoTZ7
         tMTg==
X-Forwarded-Encrypted: i=1; AFNElJ+RkIkEakytQ5UKZvb3ppYPRQ8DEG58WupDLhn81YWNbNp+TuOy8rlRlHOu7/rN2t2Z5bKksqY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4hN8W2Rt5AR+2UyhdRyh90VfQjIa8jxrQqFm1zxUrQ/M++Q0B
	jzo7WaUM+2bRqLw9t16H41JiavMIk0GY0DSM319gC7rZ6I1gOw1EyuHM
X-Gm-Gg: AeBDievQsL7xrr955nEA1V66S0xSuPxtW+RA4p5tDA4yicGMAEZoAgd1JQkwV4qtwvD
	gijOgxp9yIyP9mMo2sxqGJZOXa4yGVYmEw/yu1tjiDG7Z7DcFGM0sBu6zAzdSnKBtu8nsOzoG3f
	DBe4gFHRd75Mp7l3YGIjlsMQX55r4FHHpk4lfIjgppaLz/1vqFlSyQ28PvNN2inVSLJgAsyKpBL
	eyEau4aOVLl+yyqmFoVF55PrtTN9PJYklnEYv8eAodHKfLJYg2Ql5T7mzWo2RAq83cLGnLzuBX8
	MzpYTOwBvz0TBNgjQEf2+LvGVdyzz13peYGaR6iEW2r8ZujKHaowf52tgCDQQ46OGTIy2pEkN2R
	MsDcDXrbB1nGttUC+VLVR8TWjFw3KPUTaGoGWQOJN2X+9psTBDKniRKZo/xMK5WhlE0nHYIp9Ni
	tD2GgPKNUbHJ/EnSORpZPbqw4q2AM0zcPwHDhmUOvc3Ij9QPpH8S9JX7ll+VTDJzXTG8zEbMZN+
	P9XkwExUDaULamgBxU5IAriMwbIg5TwBehPhOKDemI8
X-Received: by 2002:aa7:da97:0:b0:67b:790e:bf12 with SMTP id 4fb4d7f45d1cf-67d642c098cmr294960a12.12.1778031600972;
        Tue, 05 May 2026 18:40:00 -0700 (PDT)
Received: from KURWA.angora-ide.ts.net (mm-195-107-126-178.vitebsk.dynamic.pppoe.byfly.by. [178.126.107.195])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67cd904fe68sm849388a12.0.2026.05.05.18.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 18:40:00 -0700 (PDT)
From: ElXreno <elxreno@gmail.com>
Date: Wed, 06 May 2026 04:39:16 +0300
Subject: [PATCH v2 2/2] wifi: mt76: mt7925: don't disable AP BSS when
 removing TDLS peer
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260506-mt7925-tdls-fixes-v2-2-46aa826ba8bb@gmail.com>
References: <20260506-mt7925-tdls-fixes-v2-0-46aa826ba8bb@gmail.com>
In-Reply-To: <20260506-mt7925-tdls-fixes-v2-0-46aa826ba8bb@gmail.com>
To: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>, 
 Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Ming Yen Hsieh <mingyen.hsieh@mediatek.com>, 
 Deren Wu <deren.wu@mediatek.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 ElXreno <elxreno@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2827; i=elxreno@gmail.com;
 h=from:subject:message-id; bh=Gr7EWkvsipUpzm6yGXOHgRC0cyi+bO2nl/KB1dA/mFg=;
 b=owJ4nJvAy8zAJXa0WDmKX5v/EeNptSSGzF+z37i4btCS8Hxb1Jjfq5GaszDbxFTh898l1w1sQ
 pn37H/EGNpRysIgxsUgK6bIwnNub23Osrolk+u5MmDmsDKBDGHg4hSAiewpZvhneTPCnv9UuPQc
 l8k1B5Juay1R3BVzXovxruVS1ZBrrMkhjAznmaYfWXBieixbQsqpA1N445dZTxbw/yXbrpVXMDH
 K1IQbAIBdQ48=
X-Developer-Key: i=elxreno@gmail.com; a=openpgp;
 fpr=0CCEBD7D6CA67EA4937F0A68C573235A0F2B0FE2
X-Rspamd-Queue-Id: D80EF4D5590
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244291-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[nbd.name,kernel.org,mediatek.com,gmail.com,collabora.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[elxreno@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

On a STATION vif, removing a TDLS peer takes the mt7925_mac_sta_remove
-> mt7925_mac_sta_remove_links path. The first loop in that function
calls mt7925_mcu_add_bss_info(..., enable=false) for every link of the
station being removed. For a non-MLO STATION vif there is exactly one
link, link 0, whose bss_conf is the AP's. TDLS peers do not have their
own bss_conf - they share the AP's BSS.

The result is that every TDLS peer teardown sends a BSS_INFO_UPDATE
with enable=0 for the AP's BSS to the firmware, which wipes the AP-side
rate-control context. The connection stays associated and TX from the
host still works at the negotiated rate, but the AP's downlink to us
collapses to the lowest mandatory OFDM rate (HE-MCS 0 / 6 Mbit/s OFDM)
and only slowly recovers as rate adaptation re-learns under sustained
traffic. With brief or bursty traffic the link can stay at 6-72 Mbit/s
indefinitely, requiring a manual reconnect.

mt7925_mac_link_sta_remove() already guards its own
mt7925_mcu_add_bss_info(..., false) call with
"vif->type == NL80211_IFTYPE_STATION && !link_sta->sta->tdls".
Add the equivalent guard at the top of the cleanup loop in
mt7925_mac_sta_remove_links(), above the link_sta / link_conf /
mlink / mconf lookups, so TDLS peer teardown skips the loop body
entirely without doing the per-link work that would just be thrown
away.

Verified on mt7925e by triggering Samsung-S938B auto-TDLS via iperf3
and watching iw rx bitrate after teardown:

  Before: rx bitrate collapses to 6.0-72.0 Mbit/s, oscillates 17/72/
          137/288/432 Mbit/s for 30+ seconds, no full recovery without
          a manual reassoc.
  After:  rx bitrate stays at 1200.9 Mbit/s HE-MCS 11 NSS 2 80 MHz
          across the entire TDLS lifecycle.

bpftrace confirms a single mt7925_mcu_add_bss_info(enable=0) call per
teardown before the fix; zero such calls after.

Fixes: 3878b4333602 ("wifi: mt76: mt7925: update mt7925_mac_link_sta_[add, assoc, remove] for MLO")
Cc: stable@vger.kernel.org
Signed-off-by: ElXreno <elxreno@gmail.com>
Assisted-by: Claude:claude-opus-4-7 bpftrace
---
 drivers/net/wireless/mediatek/mt76/mt7925/main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 61330e3c18b2..041d06143ef1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -1268,6 +1268,9 @@ mt7925_mac_sta_remove_links(struct mt792x_dev *dev, struct ieee80211_vif *vif,
 		if (vif->type == NL80211_IFTYPE_AP)
 			break;
 
+		if (vif->type == NL80211_IFTYPE_STATION && sta->tdls)
+			continue;
+
 		link_sta = mt792x_sta_to_link_sta(vif, sta, link_id);
 		if (!link_sta)
 			continue;

-- 
2.53.0


