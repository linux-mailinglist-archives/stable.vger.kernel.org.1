Return-Path: <stable+bounces-242633-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GIaJD1qn9mmYXQIAu9opvQ
	(envelope-from <stable+bounces-242633-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 03:39:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 311B84B3FEF
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 03:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0E36230028DF
	for <lists+stable@lfdr.de>; Sun,  3 May 2026 01:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F9123C8AE;
	Sun,  3 May 2026 01:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fSh9Ys5B"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E121B4224
	for <stable@vger.kernel.org>; Sun,  3 May 2026 01:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777772369; cv=none; b=OD0h1aF+Er+S+36Vd5/Wa4E7FR/a+70YWg71i1eKSvNA/OiNu/r9KCTol3TQSL1VbUVhozy7GYloOghrroQF+lRFTQGGpBoCtzhumwml3vXhDpSljGkyB/zCsbBZmZk23tzz8fZ15HeWwyMt2Pnq29u/EZhCANqKqo30oZ/xJFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777772369; c=relaxed/simple;
	bh=YPGmyUudNSjw4eCk1z0v7TQxyamgkewkjdMSqZfW3uA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nVw2iRFk/D+SHjtpSJL9OiXVxfK5++xEftdtiNAmWZ7m+GfMZskB32gR+7zPmIT1wQ2oDvJH5zFZjfR5WJEXkkVr7Yc0QSiQHFAMJXdfbmpxOaqz7emCcsjgC6xU/2YTKuFeQLaCb9czk/h06qpFVzzR3d037kvn4Hx2qzIrPIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fSh9Ys5B; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-baa8c78ac7fso402743066b.0
        for <stable@vger.kernel.org>; Sat, 02 May 2026 18:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777772367; x=1778377167; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5/hy9Op5MH/n5HzPINkQe6Hw6Gmq5KhiDMLcdOYjsuM=;
        b=fSh9Ys5BcgAl5CLabGjWPlQUp5rxxRCnk0okIi30Loi2w/rixHaaY+uXEVa28DksGk
         BNELSaImrzo9MXGK5UolmnFc6W61kv8lfJAaks/JlJeizh+k3vuEm1HfDFFwlh6I7gLg
         LaYYX+Sx1O2eSbQgt8iU8tYTNjF9v31ITGcDrYL+cZF1NKZxaQwrxulzRHOIRCVh16AL
         GvMoJ7LZx43il/5wDHpf6VCixBR+f1XoX76AkBxueI8Oo38gGWU9Y2U+sy/c2syiHyS3
         z3ZglNEfFbaqV02JHSXqJmVKsBxdoALXGhUT7C4aQkue0TTxkGTXdwLoitxom4c7/djV
         SzjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777772367; x=1778377167;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5/hy9Op5MH/n5HzPINkQe6Hw6Gmq5KhiDMLcdOYjsuM=;
        b=hsNkSpWe4tXOrUnr6IfgGr3GLvhOskhhBzJzevff6nMs/zeOl0HDrtgNdFOAwQ6svv
         m49aWg8iNxm+B3V1GAiiwX9xXvbnbX2HSoCgcyfbxX+pF/ft+SOaCzkuPSNn+bRG3JW4
         2X4qSoEsLurnnJ7uGjCLnSD9tKUSZeaJOUD8tsiTqo6KabbYqfb4OekTXesU1qfSg5zC
         AexSgOxnxLzZVTIwsY0bfvqIgLlir8VlZNM/EF49kCdinlzr+NFJgFpESCW5896jVRmM
         yV4CwIstomnnO8P9oO+v+czQWLD3YW9uade52JIgOiX9JDbYRI2f2/I5r5JwGhLjqZhd
         GCDA==
X-Forwarded-Encrypted: i=1; AFNElJ+K+1fXV0xmDIM8V71COLOzE/iHNSYTMpiR9VgsicplC1MdNuLcbaq/BOtrUWzNSseD6SYu1xY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY7mzKihLQ4lxG0ZNB390FE/UBJrz511ePae4UTW9WcisMvEqT
	1jYHdUgADjby49k2AbOROJQBUwU0t9AgCxCytnZ1TSrGL3WKJ49zz0TS
X-Gm-Gg: AeBDieutKLNy2wy/BuwZDJSMMi9tlvT7oD4W5fIVf9Hg40aQn2dzYp9PvgvY/2GTaCy
	+EEYwYEIE3jiFnZgrZbIBqe6sj5pXw0KhoUIqoHYEVBxMngpDnE46uduAN2fTWw2+YXibv4oaOG
	CJOBjYfHlloB21zkY2LTx/ACp+r5gHdatW45VD47tqMfH9sM1lxT4lTyxWsAN+v8XLnanDT9JBk
	fN7HlyFhBLolVhwlx0gZ5XgpoakD6rbBOShlJsE2dp6AaHUBNEKnkqAYxlB0Ucu3o3ivOxbZ5IC
	6jgfcnNWbNnCOfO9IccPEKmi/vHClS8VEQc2eG1sS9hz5Y6OII9qVqKc1uISs9b+oIFvyR+TcrR
	nM2t9hJ/6hYsS8a6Gi7FBDzGpSxaf/mGGfjW2+T6jhwu9GKsoXwsg3bIvNxlFBHu96gMWusyJQn
	LhTT1imgsGN9ED+QvUsxlxDK+4N2SsEp8n/CK7KJNzkBUIoXWZgkJMtZdC0Kf7RRJ596R+0T+bx
	cfY3qUortNI/eLft5Om835wspwVHsxNz6nluWE=
X-Received: by 2002:a17:906:9f87:b0:ba1:1181:b773 with SMTP id a640c23a62f3a-bbffa336011mr224803366b.10.1777772366373;
        Sat, 02 May 2026 18:39:26 -0700 (PDT)
Received: from KURWA.angora-ide.ts.net (mm-39-71-126-178.vitebsk.dynamic.pppoe.byfly.by. [178.126.71.39])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bc1671c1d3esm24796466b.42.2026.05.02.18.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 18:39:25 -0700 (PDT)
From: ElXreno <elxreno@gmail.com>
Subject: [PATCH 0/2] wifi: mt76: fix TDLS direct-link on MediaTek MT7925
Date: Sun, 03 May 2026 04:38:29 +0300
Message-Id: <20260503-mt7925-tdls-fixes-v1-0-dde847e21081@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABWn9mkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDUwNj3dwSc0sjU92SlJxi3bTMitRiXcMUQ2NLcxMjA0sDAyWgvoKiVLA
 EUFt0LIRfXJqUlZpcAjJIqbYWAK4p9jx1AAAA
X-Change-ID: 20260503-mt7925-tdls-fixes-1d1397420900
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3364; i=elxreno@gmail.com;
 h=from:subject:message-id; bh=YPGmyUudNSjw4eCk1z0v7TQxyamgkewkjdMSqZfW3uA=;
 b=owJ4nJvAy8zAJXa0WDmKX5v/EeNptSSGzG/LfatSrcLPN15++MYthFUoRjl0P9uFBxs3mHG9s
 t3u1fv3xrmOUhYGMS4GWTFFFp5ze2tzltUtmVzPlQEzh5UJZAgDF6cATGRnEyPDqa45L/1ZclJ/
 /9llq7hf+zqzQ2gHy6bMwgdSfMtWLRHdwfBXqCrhlfWsxyXsGw3No7YdPOWXz7twtWi41hQxt1u
 f7yUxAgBO/EcD
X-Developer-Key: i=elxreno@gmail.com; a=openpgp;
 fpr=0CCEBD7D6CA67EA4937F0A68C573235A0F2B0FE2
X-Rspamd-Queue-Id: 311B84B3FEF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-242633-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mediatek.com:email]

This series fixes two TDLS-related issues on the MediaTek MT7925
(Connac3) Wi-Fi 6E chip, observed reproducibly with Samsung phones
and other peers that auto-initiate TDLS direct links.

Patch 1 works around a TDLS direct-link issue on MT7925: QoS Data
frames whose destination WCID is a TDLS peer are silently dropped
after submission to firmware via the HW_80211_ENCAP TX path. mt76
advertises WIPHY_FLAG_SUPPORTS_TDLS via the shared
mt76_register_phy_helper(), but does not provide TDLS-aware
firmware-facing peer setup -- no CONNECTION_TDLS constant in
mt76_connac_mcu.h, no STA_REC_TDLS TLV, no TDLS bit in
mt76_wcid_flags, no TDLS-specific handling in
mt7925_mac_write_txwi_8023(); the proprietary out-of-tree MediaTek
driver carries an explicit cfg80211_tdls.c with no in-tree
equivalent. Whether the underlying gap is in the firmware HW_ENCAP
path or in mt76's missing TDLS-aware setup is unclear from the
kernel side; the software-encap path sidesteps it either way. This
patch stops advertising SUPPORTS_TX_ENCAP_OFFLOAD and
SUPPORTS_RX_DECAP_OFFLOAD in mt792x_init_wiphy(); mac80211 then
takes the software 802.11 encap path, which submits already-formed
802.11 frames via a different firmware path that handles all WCIDs
correctly. Verified on mt7925e at 5 GHz HE 80 MHz and 2.4 GHz
802.11n; TDLS direct link sustains ~750 Mbit/s and ~130 Mbit/s
respectively. The disable is applied to the shared
mt792x_init_wiphy() and so also covers the Connac2 family
(mt7921/22/20/02), which uses the same firmware HW_ENCAP path; if
Connac2 is later confirmed unaffected, the disable can be narrowed
with is_mt7925().

Patch 2 fixes a regression introduced by the MLO refactor in
commit 3878b4333602 ("wifi: mt76: mt7925: update
mt7925_mac_link_sta_[add, assoc, remove] for MLO"): the cleanup
loop in mt7925_mac_sta_remove_links() unconditionally calls
mt7925_mcu_add_bss_info(..., enable=false) for every link of the
station being removed, including TDLS peers on a STATION vif which
share the AP's bss_conf -- wiping the AP-side rate-control context
on every TDLS teardown and collapsing rx bitrate to 6 Mbit/s for
tens of seconds.

---
To: Felix Fietkau <nbd@nbd.name>
To: Lorenzo Bianconi <lorenzo@kernel.org>
To: Ryder Lee <ryder.lee@mediatek.com>
To: Shayne Chen <shayne.chen@mediatek.com>
To: Sean Wang <sean.wang@mediatek.com>
To: Matthias Brugger <matthias.bgg@gmail.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Soul Huang <Soul.Huang@mediatek.com>
To: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
To: Deren Wu <deren.wu@mediatek.com>
Cc: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-mediatek@lists.infradead.org
base-commit: 7baf5857e15d722776898510a10546d6b2f18645

---
ElXreno (2):
      wifi: mt76: mt792x: disable HW TX/RX encap offload to fix TDLS direct-link
      wifi: mt76: mt7925: don't disable AP BSS when removing TDLS peer

 drivers/net/wireless/mediatek/mt76/mt7925/main.c | 10 ++++++++++
 drivers/net/wireless/mediatek/mt76/mt792x_core.c | 10 ++++++++--
 2 files changed, 18 insertions(+), 2 deletions(-)
---
base-commit: 7baf5857e15d722776898510a10546d6b2f18645
change-id: 20260503-mt7925-tdls-fixes-1d1397420900

Best regards,
--  
ElXreno <elxreno@gmail.com>


