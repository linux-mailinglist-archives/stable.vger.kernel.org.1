Return-Path: <stable+bounces-242634-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8M6lMWun9mmYXQIAu9opvQ
	(envelope-from <stable+bounces-242634-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 03:39:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FBA64B400E
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 03:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6E0D2300E17D
	for <lists+stable@lfdr.de>; Sun,  3 May 2026 01:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B7A24A06A;
	Sun,  3 May 2026 01:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z6TYdVQ6"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B293A1D9A54
	for <stable@vger.kernel.org>; Sun,  3 May 2026 01:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777772371; cv=none; b=uFpcV36azDOtn/bpoT0Gt9ne8k7Z2vCwi7sJTgd7Yu98w2u/cK8edWZfRg8FyGIEmFzT6qv4qKZoj50/gi95YAjA6dYi8JsqkQeS2DiQXDR4+djVFpL+xZehd9bR4nXW9t/PeHBUiRAd06/1tQe36pGFfgB+dWVFNeqYZob2G3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777772371; c=relaxed/simple;
	bh=7uwJxgvTxpOn6gNEIOPNEioHiEozfkGob7zPtdELUWI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=opIMbjg5l+QSUmk9VGMXJq/tWvhDltkYJF7ulGKZEQ2zEeLz0TGEooRusEBmsp1d3HDwbWzQN/gX5u2r+go3Yf+i3UttyJA57i3LnGlyZa3K2KLkkfAe+TnQdVt44CQQ+sH6r9Xl/Z2lG8FPD0EjL4xUuH9L3AxY1zhM6MLYC7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z6TYdVQ6; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b9c01854477so432109766b.0
        for <stable@vger.kernel.org>; Sat, 02 May 2026 18:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777772368; x=1778377168; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mCD/2g9DiH7IGmCylqgN8SVqRAlReG1YJkLOG3TO9pw=;
        b=Z6TYdVQ67nfpyM+Eky4qqdjd4e497GCIMbYd4QHCVjZ6qs01j1aYs6VUHihBfs22sX
         9M5m/ZrQwC+YCE7X09PIrjZOYgS1Q9foAsm6n/AKPzfLe6TuwDKH+Q7h1WIINYGIBGrC
         CQOUeEYYeL682Np0WzDsw5iRytj7XeK+vtzf1qYuK6OVSYdspCeRuPDd6ImpDBHwvwAb
         MkvTJUviwS0m4Txd+0U4OzZFMOedbM/aereboqo7dDWT5NZhoI8hoJhSBvHzmksk3EAE
         8oRORoxChAnGp3Wn8dbYSEDrJOxECSJtCzG88fPA+6ctaKhcbLRDP3u8PXyld7ncHT1o
         inkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777772368; x=1778377168;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mCD/2g9DiH7IGmCylqgN8SVqRAlReG1YJkLOG3TO9pw=;
        b=hjo7GY0VCGsO9uipUOLdKcqdE56IONaVjnB5yEE/e4l4LMUoVjG8r1ONlVAhM+T8CX
         T72as6tCdGQO2vSVEDTmWXhGByCUyKdEa24gfS1EryEKKSVM4joPEdOGyLzie9m0iiK9
         WOzPaUQzo3UmEdl5rvdvVreWXymiYm6fIvh1fhhfYTXUGY2Ibw/webMl2EBID1PwGIFq
         5tUoRYY+hD5CM760u+MP1uPrtlDwwKZ/ZZMpGJxoBmz/nyQzG23iOuvMY73q780Q67rC
         0Q//2WHwKyPWA5iE8nVhoT7QMGNwhyMLIMu2+jC9u7M7lQi5hU1avGCHClQNzzvq2fHU
         mHSg==
X-Forwarded-Encrypted: i=1; AFNElJ/4eLoxl4L+IFKCymrImNlmGtPQqx/vlmX0+JlzAZsfx7vjivorPQQqPmf0jz71Ck3b3cICRHI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7LizvLUcrl7BUkN4UrSLNQXHpnVL5ENIUn+WP005Yy0hpbSSD
	zf9+Dx7F5aUwa8oxK3xgdxC+ZNmijbMaLSieGyot82r9iA25nL9ZGsrG
X-Gm-Gg: AeBDietSiqlyeM7wMVoPmW79c+xXTGLmPZWFr7LKy4by0yAFdhvQ+1mnKDIaxw+WgUK
	Mnv4S32ImbSSlcZq45+SuEe1aw29aYwmk9VVLBoz05VHsev4obyucR2K23HBpREB/BgVZtif+EX
	8S+WlWbM8zWkcG29B+abcME7MpJP+ApxtshriV0G1SIo/cQUkgj2bbQlTpq14J4fAWNBH4UAhU8
	4FYtSSHCjdOYI3KYCRuBSRc2k4iYNvvCzRrtnDFrh1Deo2FXmB42uwAimeoFAunG+siGAe30552
	VoC8lDpa/cARm5MNjEmKTu56JOWBCuLZvpwVG95IT5cAzYTOo1t9VMzGmvIxFLMQxN4/+tnbrVq
	XakkJqIKbcIeBhocJINkxVyPzUlBbjMTlYC4LrSa2lWDZj52UpMsOceDXdMBMXZcq4z16/cl30F
	/HrTTvZjVqz0dPYbiyFLkXXhnu+2fiIR5+dO9wLOFxsGg8U9xmGOgiMPorVjMdq38WBAY+AEpkQ
	ZgpypxQLWkFHg8ScQtrnUJDpFZU
X-Received: by 2002:a17:907:198c:b0:b9e:8e4:8765 with SMTP id a640c23a62f3a-bbffb23fe1amr237176266b.10.1777772368030;
        Sat, 02 May 2026 18:39:28 -0700 (PDT)
Received: from KURWA.angora-ide.ts.net (mm-39-71-126-178.vitebsk.dynamic.pppoe.byfly.by. [178.126.71.39])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bc1671c1d3esm24796466b.42.2026.05.02.18.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 18:39:27 -0700 (PDT)
From: ElXreno <elxreno@gmail.com>
Date: Sun, 03 May 2026 04:38:30 +0300
Subject: [PATCH 1/2] wifi: mt76: mt792x: disable HW TX/RX encap offload to
 fix TDLS direct-link
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260503-mt7925-tdls-fixes-v1-1-dde847e21081@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4215; i=elxreno@gmail.com;
 h=from:subject:message-id; bh=7uwJxgvTxpOn6gNEIOPNEioHiEozfkGob7zPtdELUWI=;
 b=owJ4nJvAy8zAJXa0WDmKX5v/EeNptSSGzG/LfTNMDDbv83x9t8ziV+VZJeNKo5MB9cwrXz83n
 G6x792x7W4dpSwMYlwMsmKKLDzn9tbmLKtbMrmeKwNmDisTyBAGLk4BmEgYD8P/JKl3nJpLa/Ka
 bl5Idnp1ekbCjzrz/qdJrJfP1259uTL4GsP/7BX+oeF7w3Y+5euOWn36UPq8FvE7J+wZ5pQrrju
 6pUKAFQAL90r/
X-Developer-Key: i=elxreno@gmail.com; a=openpgp;
 fpr=0CCEBD7D6CA67EA4937F0A68C573235A0F2B0FE2
X-Rspamd-Queue-Id: 7FBA64B400E
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
	TAGGED_FROM(0.00)[bounces-242634-lists,stable=lfdr.de];
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

On MediaTek MT7925 (Connac3), QoS Data frames whose destination WCID
is a TDLS direct-link peer are silently dropped after submission to
firmware via the HW_80211_ENCAP TX path. The driver sees submit and
complete counts match (firmware reports success on TX queue
submission), but the frames never reach the PHY. iw counters show
tx_packets growing, tx_failed = 0, tx_retries low; on the air,
nothing.

This breaks TDLS direct-link as soon as a peer auto-initiates one
(Samsung phones do this aggressively when both peers share a BSS and
traffic exceeds a threshold). Pattern is:

  1. Any sustained direct traffic between two STAs sharing the BSS
     reaches the auto-TDLS threshold within ~1 s.
  2. Peer initiates TDLS; mac80211 routes data frames to the TDLS-peer
     WCID and the AP stops forwarding peer-to-peer traffic per the
     802.11z spec.
  3. Direct-link frames are accepted by firmware, completed in the TX
     descriptor pool, but never PHY-transmitted.
  4. TCP collapses; the peer eventually tears down the TDLS link with
     reason WLAN_REASON_TDLS_TEARDOWN_UNSPECIFIED. Cycle repeats.

Effective TCP throughput drops from ~300 Mbit/s (AP route) to ~6
Mbit/s with TDLS active.

Verified on mt7925e (PCIe) at 5 GHz HE NSS 2 MCS 11 80 MHz and at
2.4 GHz 802.11n HT NSS 2 MCS 15. With this patch, TDLS direct link
sustains ~750 Mbit/s and ~130 Mbit/s respectively.

mt76 advertises WIPHY_FLAG_SUPPORTS_TDLS via the shared
mt76_register_phy_helper() but does not provide TDLS-aware
firmware-facing peer setup: no CONNECTION_TDLS constant in
mt76_connac_mcu.h, no STA_REC_TDLS TLV, no TDLS bit in
mt76_wcid_flags, and no TDLS-specific code in
mt7925_mac_write_txwi_8023(). TDLS peers are registered as
CONNECTION_INFRA_STA with peer_addr set to the peer's MAC and
nothing else. The proprietary out-of-tree MediaTek driver carries an
explicit cfg80211_tdls.c (PTK/TK install paths, etc.) with no
in-tree equivalent. Whether the underlying gap is in the firmware
HW_ENCAP path or in mt76's missing TDLS-aware setup is unclear from
the kernel side; the software-encap path sidesteps it either way.

Work around the issue by not advertising SUPPORTS_TX_ENCAP_OFFLOAD
and SUPPORTS_RX_DECAP_OFFLOAD in mt792x_init_wiphy(). mac80211 then
takes the software 802.11 encap path, which submits already-formed
802.11 frames via a different firmware path that handles all WCIDs
correctly, including TDLS peers.

mt792x_init_wiphy() is shared with the Connac2 family (mt7921/22/20/02),
which uses the same firmware HW_ENCAP path; the disable is applied
globally to cover the likely-affected chips. If Connac2 is later
confirmed unaffected, the disable can be narrowed with is_mt7925().

Fixes: 5c14a5f944b9 ("mt76: mt7921: introduce mt7921e support")
Cc: stable@vger.kernel.org
Signed-off-by: ElXreno <elxreno@gmail.com>
Assisted-by: Claude:claude-opus-4-7 bpftrace
---
 drivers/net/wireless/mediatek/mt76/mt792x_core.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_core.c b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
index 152cfcca2f90..f9610c6c1597 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
@@ -681,8 +681,14 @@ int mt792x_init_wiphy(struct ieee80211_hw *hw)
 
 	ieee80211_hw_set(hw, SINGLE_SCAN_ON_ALL_BANDS);
 	ieee80211_hw_set(hw, HAS_RATE_CONTROL);
-	ieee80211_hw_set(hw, SUPPORTS_TX_ENCAP_OFFLOAD);
-	ieee80211_hw_set(hw, SUPPORTS_RX_DECAP_OFFLOAD);
+	/* HW TX/RX 802.11 encap offload is intentionally NOT advertised:
+	 * the firmware HW_80211_ENCAP path silently drops QoS Data frames
+	 * whose destination WCID is a TDLS direct-link peer, breaking TDLS
+	 * data flow. The mac80211 software encap path submits already-formed
+	 * 802.11 frames, which the firmware handles correctly for all WCIDs.
+	 * Re-add SUPPORTS_TX_ENCAP_OFFLOAD / SUPPORTS_RX_DECAP_OFFLOAD here
+	 * once the firmware HW_ENCAP path is fixed.
+	 */
 	ieee80211_hw_set(hw, WANT_MONITOR_VIF);
 	ieee80211_hw_set(hw, SUPPORTS_PS);
 	ieee80211_hw_set(hw, SUPPORTS_DYNAMIC_PS);

-- 
2.53.0


