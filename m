Return-Path: <stable+bounces-220345-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJ9RN0E2o2lG+gQAu9opvQ
	(envelope-from <stable+bounces-220345-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:38:57 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B351C6100
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:38:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E05CA31F494C
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F1939B96B;
	Sat, 28 Feb 2026 17:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IViXweEp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094EF39B963;
	Sat, 28 Feb 2026 17:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300244; cv=none; b=PqR9dxosGMdqqWyNYrAwsNXhTnX3hsywf6J8G76vD5t7qj0MNSg7RDWXjWNvEXW+D+/gf8I42qt2BlLB+5Qliis10XNuuujWhFndCCDC8irxmQVyAptCwomliafTRxPiFTjkMI2HRkji/ekECiDCH57OnzFUty2/mGs98HoAQgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300244; c=relaxed/simple;
	bh=Ihsn2/ioBdssasUkisvqXnV86eTduIcwn1rgT7gK7f8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qlIwhOcB/9fXiX8hIXrCzhQfyU31CEHRVmtsBXMIzmo7Ghkl4o0NRTLQ3Phk7OiSqBxjLGAvqGDWvlmJli1t5BAat2yLYKXlzO2ieOPV66uQFR/iZrSHFXijRlvDqm3wtPmN1vbcK6s/3tyUELrW4DxRjPjme/VAA6UdXatJCBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IViXweEp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53B4EC19424;
	Sat, 28 Feb 2026 17:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300243;
	bh=Ihsn2/ioBdssasUkisvqXnV86eTduIcwn1rgT7gK7f8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IViXweEpGuy+iUlAZDB77Elqqo7G09w+OrB68hvchWO4YbEh7wMrFekzpAMyGkb28
	 pzyqa/6QELfyvc0djFwYjqQ1xRF8LSntncHOdhr4oLf5e9ua+keSbZ6dMvZ5+TIduM
	 n8hh81j1/wDefOBfIDi63rhDYDZjX9VMm/yW9z5xH8vpj41WJqUIGsRVlSiRFZe3JI
	 iphb2XHLPR2LIKNF4ErbjD8a1oOmkwrUcGFVs1uLexLfeIXWYk11rc20GaNxoFSV1l
	 JGgD2PZZIEpJHqWHwIQqu49LsAqyYVD5CTQooUdFREBgWkWvtvIQQnkOM8XH158nsD
	 KdsBUG6XildCA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kuan-Chung Chen <damon.chen@realtek.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 267/844] wifi: rtw89: fix potential zero beacon interval in beacon tracking
Date: Sat, 28 Feb 2026 12:23:00 -0500
Message-ID: <20260228173244.1509663-268-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-220345-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 62B351C6100
X-Rspamd-Action: no action

From: Kuan-Chung Chen <damon.chen@realtek.com>

[ Upstream commit eb57be32f438c57c88d6ce756101c1dfbcc03bba ]

During fuzz testing, it was discovered that bss_conf->beacon_int
might be zero, which could result in a division by zero error in
subsequent calculations. Set a default value of 100 TU if the
interval is zero to ensure stability.

Signed-off-by: Kuan-Chung Chen <damon.chen@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20251231090647.56407-11-pkshih@realtek.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw89/core.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 53d32f3137ebe..c5934e4eff711 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -2787,7 +2787,7 @@ static void rtw89_core_bcn_track_assoc(struct rtw89_dev *rtwdev,
 
 	rcu_read_lock();
 	bss_conf = rtw89_vif_rcu_dereference_link(rtwvif_link, true);
-	beacon_int = bss_conf->beacon_int;
+	beacon_int = bss_conf->beacon_int ?: 100;
 	dtim = bss_conf->dtim_period;
 	rcu_read_unlock();
 
@@ -2817,9 +2817,7 @@ static void rtw89_core_bcn_track_reset(struct rtw89_dev *rtwdev)
 	memset(&rtwdev->bcn_track, 0, sizeof(rtwdev->bcn_track));
 }
 
-static void rtw89_vif_rx_bcn_stat(struct rtw89_dev *rtwdev,
-				  struct ieee80211_bss_conf *bss_conf,
-				  struct sk_buff *skb)
+static void rtw89_vif_rx_bcn_stat(struct rtw89_dev *rtwdev, struct sk_buff *skb)
 {
 #define RTW89_APPEND_TSF_2GHZ 384
 #define RTW89_APPEND_TSF_5GHZ 52
@@ -2828,7 +2826,7 @@ static void rtw89_vif_rx_bcn_stat(struct rtw89_dev *rtwdev,
 	struct ieee80211_rx_status *rx_status = IEEE80211_SKB_RXCB(skb);
 	struct rtw89_beacon_stat *bcn_stat = &rtwdev->phystat.bcn_stat;
 	struct rtw89_beacon_track_info *bcn_track = &rtwdev->bcn_track;
-	u32 bcn_intvl_us = ieee80211_tu_to_usec(bss_conf->beacon_int);
+	u32 bcn_intvl_us = ieee80211_tu_to_usec(bcn_track->beacon_int);
 	u64 tsf = le64_to_cpu(mgmt->u.beacon.timestamp);
 	u8 wp, num = bcn_stat->num;
 	u16 append;
@@ -2836,6 +2834,10 @@ static void rtw89_vif_rx_bcn_stat(struct rtw89_dev *rtwdev,
 	if (!RTW89_CHK_FW_FEATURE(BEACON_TRACKING, &rtwdev->fw))
 		return;
 
+	/* Skip if not yet associated */
+	if (!bcn_intvl_us)
+		return;
+
 	switch (rx_status->band) {
 	default:
 	case NL80211_BAND_2GHZ:
@@ -2923,7 +2925,7 @@ static void rtw89_vif_rx_stats_iter(void *data, u8 *mac,
 		pkt_stat->beacon_rate = desc_info->data_rate;
 		pkt_stat->beacon_len = skb->len;
 
-		rtw89_vif_rx_bcn_stat(rtwdev, bss_conf, skb);
+		rtw89_vif_rx_bcn_stat(rtwdev, skb);
 	}
 
 	if (!ether_addr_equal(bss_conf->addr, hdr->addr1))
-- 
2.51.0


