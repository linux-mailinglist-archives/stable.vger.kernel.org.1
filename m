Return-Path: <stable+bounces-220355-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wKNeH5Qyo2kE+QQAu9opvQ
	(envelope-from <stable+bounces-220355-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:23:16 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 236371C5B9C
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:23:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7328830BDA7C
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E0E39EE14;
	Sat, 28 Feb 2026 17:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F2jVH27t"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7944439EE0A;
	Sat, 28 Feb 2026 17:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300252; cv=none; b=StddXXUD6oJADDkQbErf29lhY6D9Lq7bOixYtJeM+OSj371jqG6NWDj0k7NOa0JUxUhWPEuqf66rL2Ik2nTNbukivLigGugEx+A8Ve5hkNQlPjsYBumldXGkSd+o3rc1r53Fofy1k3nXMp3W71QZxAlkmuccx1BFVw33B/NJ9os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300252; c=relaxed/simple;
	bh=mhbAl8sJyvyAjf4RPrZXtW5aXsE0+cHJpp8tFN+sMJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eYr5q9eHC6WON1s1IHk1V+fJsrXxRatVcUekMxHo96LzcsrG7RRlpfm1/5O3sVDrgH8WhlsRDTMwHdKdPZIYo23Rd53HI3BYPHYTiWHeCO7KXaJviec5P5ZQrO6vxlmkq+m14klvn0jRKVfaF8OUnd5lzO6MT8DyHcd8ixG3hdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F2jVH27t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC1B4C116D0;
	Sat, 28 Feb 2026 17:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300252;
	bh=mhbAl8sJyvyAjf4RPrZXtW5aXsE0+cHJpp8tFN+sMJw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F2jVH27tCiRnK4HhYW4PdEbGd88Yn8W8SopGSXUjX8/ynJAKetYchns0Sd+DiNaXp
	 32pYLMxUeD7lihm62223Pw0T8T3XnGBPV23opjrBptCGwc80mMY90tSG+8NR6QZVu8
	 P5WCdMhuG7ac8rBQ76zGzB6Qk/MxQLz5DF3dmwf45a/9aEMa1QEgN1+FhA5QsrKtzB
	 Gz1BEOpHswypWo23KPrBQnNDECyY3FH2PfLPe7/5B4qGw5lOQDcJLjXgY1TexFE3SK
	 GC/ZI9E0H8i28/Zls7QrVVe9O1BUI62HUclz1o2mSegyifM47oUjSyuGklzApmCskZ
	 ZiRPC20OVC6+g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 277/844] wifi: rtw89: disable EHT protocol by chip capabilities
Date: Sat, 28 Feb 2026 12:23:10 -0500
Message-ID: <20260228173244.1509663-278-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220355-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,realtek.com:email,msgid.link:url]
X-Rspamd-Queue-Id: 236371C5B9C
X-Rspamd-Action: no action

From: Ping-Ke Shih <pkshih@realtek.com>

[ Upstream commit 7fd36ffedeedc97c44a10249a3f12d471bb2dc26 ]

For certain chip models, EHT protocol is disabled, and driver must follow
the capabilities. Otherwise, chips become unusable.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20260110022019.2254969-5-pkshih@realtek.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw89/core.c | 2 +-
 drivers/net/wireless/realtek/rtw89/core.h | 1 +
 drivers/net/wireless/realtek/rtw89/fw.h   | 4 ++++
 drivers/net/wireless/realtek/rtw89/mac.c  | 5 +++++
 4 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index c5934e4eff711..4b86a7c4fe329 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -5238,7 +5238,7 @@ static void rtw89_init_eht_cap(struct rtw89_dev *rtwdev,
 	u8 val, val_mcs13;
 	int sts = 8;
 
-	if (chip->chip_gen == RTW89_CHIP_AX)
+	if (chip->chip_gen == RTW89_CHIP_AX || hal->no_eht)
 		return;
 
 	if (hal->no_mcs_12_13)
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 92636cfc5ca58..a032a20d4c23b 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -5039,6 +5039,7 @@ struct rtw89_hal {
 	bool support_cckpd;
 	bool support_igi;
 	bool no_mcs_12_13;
+	bool no_eht;
 
 	atomic_t roc_chanctx_idx;
 	u8 roc_link_index;
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index cedb4a47a769c..ba7c332911310 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -42,6 +42,10 @@ struct rtw89_c2hreg_phycap {
 #define RTW89_C2HREG_PHYCAP_W0_BW GENMASK(31, 24)
 #define RTW89_C2HREG_PHYCAP_W1_TX_NSS GENMASK(7, 0)
 #define RTW89_C2HREG_PHYCAP_W1_PROT GENMASK(15, 8)
+#define RTW89_C2HREG_PHYCAP_W1_PROT_11N 1
+#define RTW89_C2HREG_PHYCAP_W1_PROT_11AC 2
+#define RTW89_C2HREG_PHYCAP_W1_PROT_11AX 3
+#define RTW89_C2HREG_PHYCAP_W1_PROT_11BE 4
 #define RTW89_C2HREG_PHYCAP_W1_NIC GENMASK(23, 16)
 #define RTW89_C2HREG_PHYCAP_W1_WL_FUNC GENMASK(31, 24)
 #define RTW89_C2HREG_PHYCAP_W2_HW_TYPE GENMASK(7, 0)
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 6734e5d5a5e22..fbce71cd5a05c 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -3061,6 +3061,7 @@ static int rtw89_mac_setup_phycap_part0(struct rtw89_dev *rtwdev)
 	struct rtw89_efuse *efuse = &rtwdev->efuse;
 	struct rtw89_mac_c2h_info c2h_info = {};
 	struct rtw89_hal *hal = &rtwdev->hal;
+	u8 protocol;
 	u8 tx_nss;
 	u8 rx_nss;
 	u8 tx_ant;
@@ -3108,6 +3109,10 @@ static int rtw89_mac_setup_phycap_part0(struct rtw89_dev *rtwdev)
 	rtw89_debug(rtwdev, RTW89_DBG_FW, "TX path diversity=%d\n", hal->tx_path_diversity);
 	rtw89_debug(rtwdev, RTW89_DBG_FW, "Antenna diversity=%d\n", hal->ant_diversity);
 
+	protocol = u32_get_bits(phycap->w1, RTW89_C2HREG_PHYCAP_W1_PROT);
+	if (protocol < RTW89_C2HREG_PHYCAP_W1_PROT_11BE)
+		hal->no_eht = true;
+
 	return 0;
 }
 
-- 
2.51.0


