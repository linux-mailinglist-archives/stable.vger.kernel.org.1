Return-Path: <stable+bounces-220383-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eEI/AeQ0o2kI+gQAu9opvQ
	(envelope-from <stable+bounces-220383-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:33:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4241C5F18
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:33:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BB90F30CEA5F
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4313F3A6987;
	Sat, 28 Feb 2026 17:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jWDXpmcg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044203A697F;
	Sat, 28 Feb 2026 17:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300277; cv=none; b=qSpe+kk31ETXHq6QrUwMkW2pt3hDfubr9pjtvxy96oR9mwxgjG0LQ38U5qeRfvaHT+Y6sF6roZsFsa2jJO5tazx0TVbZE9MNFwMdp7g2kwq7vPn2GoCl11c6K7X7o6rTjq3bPZDZeJMTmgnUDwJYApTkyeLuRGGX3wZiOSuIZPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300277; c=relaxed/simple;
	bh=uAQHOJwY6yHG0F4UleYU7O5AEtJGqzbnVcSUfGuXGDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=upF8lsViQY1FAl+OrJJtMUImLviqxA477Zey0Q0Aer/qDYD1eqJLXAS1erqculSTft28GEJ0CVAVy/OmjlI7c267vQgwCG/8ekOPkxiRkKxTn0U+LW6+HeqbS6rvxFrjlwuh8VOyxUvwv/k2Bp7+RpRpiJA7bF4ayTwQe9RZnwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jWDXpmcg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56928C116D0;
	Sat, 28 Feb 2026 17:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300276;
	bh=uAQHOJwY6yHG0F4UleYU7O5AEtJGqzbnVcSUfGuXGDQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jWDXpmcgaaYbbTZ3uc6F7CCk7pZA3V0XjgxgW31KyIex7GwSo+tp707J3ghnxfoxb
	 f5rEvuBOwkogRLFMcOutJ0LT6sakejUJbv3TAP/sEILRtuJECQjOwFHCQL3ptEv1QH
	 fu7Ui2mxNwB9Apj8eWSOwid3HGtbjtNMuOKdp4CN9JdFfRYtYbocU3YevKhx7vr28v
	 5ohS0kmMhzgfWjsGZVLsIWmGvdx8BRQhgZftOdIbL0R9nOb0yyMvXJgmNASFw8mgAG
	 5DmVWuNgv1Gt1B75LaXSZThByVt7marEkiGMJmCLl48Sqio6tXaFmMp18MAzhz3OWZ
	 tvcwbV3AxjbDA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Po-Hao Huang <phhuang@realtek.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 304/844] wifi: rtw89: 8922a: add digital compensation for 2GHz
Date: Sat, 28 Feb 2026 12:23:37 -0500
Message-ID: <20260228173244.1509663-305-sashal@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-220383-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 9F4241C5F18
X-Rspamd-Action: no action

From: Po-Hao Huang <phhuang@realtek.com>

[ Upstream commit 8da7e88682d58a7c2e2c2101e49d3c9c9ac481b0 ]

This fixes transmit power too low under 2GHz connection. Previously
we missed the settings of 2GHz, add the according calibrated tables.

Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20260117044157.2392958-10-pkshih@realtek.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw89/rtw8922a.c | 57 +++++++++++++++----
 1 file changed, 47 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index 4bcf20612a455..52da0fa02da01 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -1770,6 +1770,32 @@ static int rtw8922a_ctrl_rx_path_tmac(struct rtw89_dev *rtwdev,
 }
 
 #define DIGITAL_PWR_COMP_REG_NUM 22
+static const u32 rtw8922a_digital_pwr_comp_2g_s0_val[][DIGITAL_PWR_COMP_REG_NUM] = {
+	{0x012C0064, 0x04B00258, 0x00432710, 0x019000A7, 0x06400320,
+	 0x0D05091D, 0x14D50FA0, 0x00000000, 0x01010000, 0x00000101,
+	 0x01010101, 0x02020201, 0x02010000, 0x03030202, 0x00000303,
+	 0x03020101, 0x06060504, 0x01010000, 0x06050403, 0x01000606,
+	 0x05040202, 0x07070706},
+	{0x012C0064, 0x04B00258, 0x00432710, 0x019000A7, 0x06400320,
+	 0x0D05091D, 0x14D50FA0, 0x00000000, 0x01010100, 0x00000101,
+	 0x01000000, 0x01010101, 0x01010000, 0x02020202, 0x00000404,
+	 0x03020101, 0x04040303, 0x02010000, 0x03030303, 0x00000505,
+	 0x03030201, 0x05050303},
+};
+
+static const u32 rtw8922a_digital_pwr_comp_2g_s1_val[][DIGITAL_PWR_COMP_REG_NUM] = {
+	{0x012C0064, 0x04B00258, 0x00432710, 0x019000A7, 0x06400320,
+	 0x0D05091D, 0x14D50FA0, 0x01010000, 0x01010101, 0x00000101,
+	 0x01010100, 0x01010101, 0x01010000, 0x02020202, 0x01000202,
+	 0x02020101, 0x03030202, 0x02010000, 0x05040403, 0x01000606,
+	 0x05040302, 0x07070605},
+	{0x012C0064, 0x04B00258, 0x00432710, 0x019000A7, 0x06400320,
+	 0x0D05091D, 0x14D50FA0, 0x00000000, 0x01010100, 0x00000101,
+	 0x01010000, 0x02020201, 0x02010100, 0x03030202, 0x01000404,
+	 0x04030201, 0x05050404, 0x01010100, 0x04030303, 0x01000505,
+	 0x03030101, 0x05050404},
+};
+
 static const u32 rtw8922a_digital_pwr_comp_val[][DIGITAL_PWR_COMP_REG_NUM] = {
 	{0x012C0096, 0x044C02BC, 0x00322710, 0x015E0096, 0x03C8028A,
 	 0x0BB80708, 0x17701194, 0x02020100, 0x03030303, 0x01000303,
@@ -1784,7 +1810,7 @@ static const u32 rtw8922a_digital_pwr_comp_val[][DIGITAL_PWR_COMP_REG_NUM] = {
 };
 
 static void rtw8922a_set_digital_pwr_comp(struct rtw89_dev *rtwdev,
-					  bool enable, u8 nss,
+					  u8 band, u8 nss,
 					  enum rtw89_rf_path path)
 {
 	static const u32 ltpc_t0[2] = {R_BE_LTPC_T0_PATH0, R_BE_LTPC_T0_PATH1};
@@ -1792,14 +1818,25 @@ static void rtw8922a_set_digital_pwr_comp(struct rtw89_dev *rtwdev,
 	u32 addr, val;
 	u32 i;
 
-	if (nss == 1)
-		digital_pwr_comp = rtw8922a_digital_pwr_comp_val[0];
-	else
-		digital_pwr_comp = rtw8922a_digital_pwr_comp_val[1];
+	if (nss == 1) {
+		if (band == RTW89_BAND_2G)
+			digital_pwr_comp = path == RF_PATH_A ?
+				rtw8922a_digital_pwr_comp_2g_s0_val[0] :
+				rtw8922a_digital_pwr_comp_2g_s1_val[0];
+		else
+			digital_pwr_comp = rtw8922a_digital_pwr_comp_val[0];
+	} else {
+		if (band == RTW89_BAND_2G)
+			digital_pwr_comp = path == RF_PATH_A ?
+				rtw8922a_digital_pwr_comp_2g_s0_val[1] :
+				rtw8922a_digital_pwr_comp_2g_s1_val[1];
+		else
+			digital_pwr_comp = rtw8922a_digital_pwr_comp_val[1];
+	}
 
 	addr = ltpc_t0[path];
 	for (i = 0; i < DIGITAL_PWR_COMP_REG_NUM; i++, addr += 4) {
-		val = enable ? digital_pwr_comp[i] : 0;
+		val = digital_pwr_comp[i];
 		rtw89_phy_write32(rtwdev, addr, val);
 	}
 }
@@ -1808,7 +1845,7 @@ static void rtw8922a_digital_pwr_comp(struct rtw89_dev *rtwdev,
 				      enum rtw89_phy_idx phy_idx)
 {
 	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
-	bool enable = chan->band_type != RTW89_BAND_2G;
+	u8 band = chan->band_type;
 	u8 path;
 
 	if (rtwdev->mlo_dbcc_mode == MLO_1_PLUS_1_1RF) {
@@ -1816,10 +1853,10 @@ static void rtw8922a_digital_pwr_comp(struct rtw89_dev *rtwdev,
 			path = RF_PATH_A;
 		else
 			path = RF_PATH_B;
-		rtw8922a_set_digital_pwr_comp(rtwdev, enable, 1, path);
+		rtw8922a_set_digital_pwr_comp(rtwdev, band, 1, path);
 	} else {
-		rtw8922a_set_digital_pwr_comp(rtwdev, enable, 2, RF_PATH_A);
-		rtw8922a_set_digital_pwr_comp(rtwdev, enable, 2, RF_PATH_B);
+		rtw8922a_set_digital_pwr_comp(rtwdev, band, 2, RF_PATH_A);
+		rtw8922a_set_digital_pwr_comp(rtwdev, band, 2, RF_PATH_B);
 	}
 }
 
-- 
2.51.0


