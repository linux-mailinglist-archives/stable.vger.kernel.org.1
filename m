Return-Path: <stable+bounces-242635-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uA4ZG3un9mmYXQIAu9opvQ
	(envelope-from <stable+bounces-242635-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 03:40:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 23AFC4B401C
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 03:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7DB1E30143DE
	for <lists+stable@lfdr.de>; Sun,  3 May 2026 01:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9070F259CB2;
	Sun,  3 May 2026 01:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fLpPy3SN"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC32C242D97
	for <stable@vger.kernel.org>; Sun,  3 May 2026 01:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777772372; cv=none; b=CU/JBFWJZ9DSo8UnmCBrX43Bsc5TT+Y+1ZKdlHoUHSEazoMElFlytrlBrt+RiJMcEDoFtMA9uL5hp89cTMoJe1O5Lx+Jh5kQrPNhMocINAIncbB3PlvRLLNPOsIC8K9v1lLhYfXwp+xb7uqW5j5VWJesl6Oo/2lINkRlj2W0JXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777772372; c=relaxed/simple;
	bh=uAMNZJNELeTW91RepEFHxSC/5cFK8pGWTHntf3vPjy0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l5eyeH7y3JJVDB74dXVgd/yoFslJNL4Do2lg1YIqqaOAwXj30igLQVdiHz9W5eQvAhALjEZx0TzjDoGQBYMZL7kaDTonhS9BOkWiqIDL1wQb3rdrdk2dYszF776gQ8D/gfIkbXS5Svf/W/qWuh7O3RVySWH1zC2jNRvPkjzAtJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fLpPy3SN; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-670ab084a39so5360434a12.3
        for <stable@vger.kernel.org>; Sat, 02 May 2026 18:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777772369; x=1778377169; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IkJvgTcI4nUUQ/9kKtwsMfSDSEk8uVrEpeWRMA7wuFg=;
        b=fLpPy3SNgOV03pbBxbrVcQffTMp0jHYaYs/K4qlIuvEF1esVOemrPYzlEh8N9PqCat
         24KEMOFRrkn/0RWBJS/5sfE308B4P94CABsQv1UZ2ypRXxSBjDQxPg0wHXQUeVnVd1zc
         uzQ5FLcSHfKJiHOvVtjvzbAYcB4XuWCAa4QmmT4FX/qNtKxdGqtidi/RCM9IuP8tzyW/
         Iy5iGMpWVakIcJSayyG6QUaFOL9E3GMpVYrx+5B8H1JxsUmrtTWPRQHwf5FUB9swjeD1
         tS+5Ky7EvTU4a5qJoOxPh6zU5xdH4Mk4lassITUrzt+ds8jiw7vIfFaT31pB+BjfsYvV
         a97Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777772369; x=1778377169;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IkJvgTcI4nUUQ/9kKtwsMfSDSEk8uVrEpeWRMA7wuFg=;
        b=D6ENXJWFlziXBdHMbq15hYG76D6wFJrLdJV7tkH2iDnHGO+1Ih1HF5eq/poRXGSQbV
         V0AvJOIctsRI2Wdc0LLWPZNHGmIIHBYr2b/EOdeIblyZKgHxfWCHZynWT8MnP2740X/5
         dkbe1fzxHFOEZhOMrBQ7S6NVDU3DFYnF3Y1Et9YkhJrfVOC6nHn9kJec56X3C3DhyU81
         +dKSt6WuqJL3JUUrQBYpOYgjgLaCnkp4s4W9upB4dfi7AyppsqP/zwuQegzzFde1yHyN
         d9DK+qDcWN94fc1E50/D37+dOi12mYf7JyWgxjUtFq11Y+knrOo8w0Lu01kc5eznnpt3
         RUJQ==
X-Forwarded-Encrypted: i=1; AFNElJ+YPwnCA/SXhgClB/zhcPOlnlwBhDEgqE94SuBZNB9soCQA12/k9iMqyxYnL++Cz5pptOwrYHM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC2xx5UTwQluHQJBtVqhlhvZ/JC7w+GjmoiI0Wv8597/a3KEa7
	CavHsqIgsmnpI3AdhCgdMkdxPjQzB3Xy+tpievKspH4tRWKNjJcPvHwc
X-Gm-Gg: AeBDieu02AstMssazUSUuQdGZnbjNaLLAkkN6u2tNillTB2PBVDd9cwap597a6dUHNY
	2ngyvoS7L+5VM6xxrGJuTgOlKkNwMYIlkGGPJhS5ee+x37kcNwhoz7O8Lo3Bjal0DsHpOlk8+Hz
	t7nhzbgdNf/iD2zBexWHD+P6eCRt/2dhQmG9rMBq31zuYqo4e0NlusDjs2ZJ0j/Cpcrotv/elWV
	YgSOan5qcga1yy6Gc+fZTp8SMiClAr73W2bgtFcIBMKhqmzx2m8Z68jFgUNiz1JE64UJHQmi1x0
	5H836GvyUdfGbgUvI5dbaR3DW91bThtarfH/oweMN1fLv6aLuM1XIjgMKodFlulzyducJWIltRQ
	H6/LYDUZ5pVT/AaC4XV/xX5InIYJoELtHx6er4sPTtp4jLwBU8qb9AsuNtx5KVkOrQ2RPM0jo+y
	TQI/9n+zx9lLU19rHTi5snbve/TocoVJG+5q/BAOa4dtuDCI9bj/KKsHRvTo15gIHl4FG/bSlJw
	Ih4SCEdNYVojDnCcM6pXd/A+1SG
X-Received: by 2002:a17:907:a06:b0:bb9:c62:2c04 with SMTP id a640c23a62f3a-bbff9933024mr206200166b.10.1777772369341;
        Sat, 02 May 2026 18:39:29 -0700 (PDT)
Received: from KURWA.angora-ide.ts.net (mm-39-71-126-178.vitebsk.dynamic.pppoe.byfly.by. [178.126.71.39])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bc1671c1d3esm24796466b.42.2026.05.02.18.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 18:39:28 -0700 (PDT)
From: ElXreno <elxreno@gmail.com>
Date: Sun, 03 May 2026 04:38:31 +0300
Subject: [PATCH 2/2] wifi: mt76: mt7925: don't disable AP BSS when removing
 TDLS peer
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260503-mt7925-tdls-fixes-v1-2-dde847e21081@gmail.com>
References: <20260503-mt7925-tdls-fixes-v1-0-dde847e21081@gmail.com>
In-Reply-To: <20260503-mt7925-tdls-fixes-v1-0-dde847e21081@gmail.com>
To: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>, 
 Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Soul Huang <Soul.Huang@mediatek.com>, 
 Ming Yen Hsieh <mingyen.hsieh@mediatek.com>, 
 Deren Wu <deren.wu@mediatek.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 stable@vger.kernel.org, ElXreno <elxreno@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3207; i=elxreno@gmail.com;
 h=from:subject:message-id; bh=uAMNZJNELeTW91RepEFHxSC/5cFK8pGWTHntf3vPjy0=;
 b=owJ4nJvAy8zAJXa0WDmKX5v/EeNptSSGzG/LfVlS+BMnzPKMFGComFxwcnOSX4zj+c2njmcvL
 HFa2jGR+WFHKQuDGBeDrJgiC8+5vbU5y+qWTK7nyoCZw8oEMoSBi1MAJiLxiZFhqnGD+9dv22e8
 j+faISvyxHGrrHJ7m+aGV2l35AQm9F8MYvgf69L9rHvtLQuly6/WCE3Q4GHeHtf+XJMp2rL+pbb
 3MxUeAFDqRN8=
X-Developer-Key: i=elxreno@gmail.com; a=openpgp;
 fpr=0CCEBD7D6CA67EA4937F0A68C573235A0F2B0FE2
X-Rspamd-Queue-Id: 23AFC4B401C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-242635-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[nbd.name,kernel.org,mediatek.com,gmail.com,collabora.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[elxreno@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

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
          an NM reconnect.
  After:  rx bitrate stays at 1200.9 Mbit/s HE-MCS 11 NSS 2 80 MHz
          across the entire TDLS lifecycle.

bpftrace confirms a single mt7925_mcu_add_bss_info(enable=0) call per
teardown before the fix; zero such calls after.

Fixes: 3878b4333602 ("wifi: mt76: mt7925: update mt7925_mac_link_sta_[add, assoc, remove] for MLO")
Cc: stable@vger.kernel.org
Signed-off-by: ElXreno <elxreno@gmail.com>
Assisted-by: Claude:claude-opus-4-7 bpftrace
---
 drivers/net/wireless/mediatek/mt76/mt7925/main.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 73d3722739d0..7220bf2c0afa 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -1265,6 +1265,16 @@ mt7925_mac_sta_remove_links(struct mt792x_dev *dev, struct ieee80211_vif *vif,
 		if (vif->type == NL80211_IFTYPE_AP)
 			break;
 
+		/* TDLS peers on a STATION vif share the AP's bss_conf. The
+		 * link_conf retrieved below would be the AP's, and calling
+		 * mcu_add_bss_info(..., false) for a TDLS peer teardown
+		 * would disable the AP's BSS in firmware, wiping its
+		 * rate-control context. mt7925_mac_link_sta_remove() has
+		 * the symmetric guard for its own bss-info call.
+		 */
+		if (vif->type == NL80211_IFTYPE_STATION && sta->tdls)
+			continue;
+
 		link_sta = mt792x_sta_to_link_sta(vif, sta, link_id);
 		if (!link_sta)
 			continue;

-- 
2.53.0


