Return-Path: <stable+bounces-220337-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iAoUMcQxo2kE+QQAu9opvQ
	(envelope-from <stable+bounces-220337-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:19:48 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A001C5AB9
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:19:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B980363436A
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E845398DD2;
	Sat, 28 Feb 2026 17:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ctstjHpC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5202398DC9;
	Sat, 28 Feb 2026 17:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300237; cv=none; b=SF5+poME3mYRYbSZwzW4Hj2COy07Neg49yYwD+gP6t1hOJ4ZWbk7e81rYcffOc7Menr1N9tVRq1jsUojUB8oBqvqWdj8KDSrag7Tttbpxqb95mxTR5Jy3k0D7r5VSwpRYAJ6/b1zhWLL0NW/fmAP9Be5idIRdJTWZiHQK/9Bz2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300237; c=relaxed/simple;
	bh=DSeS++EwEDiKiYQ08hrhNvl4zKjplGTpvpcRwe/cWmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ljczYxmdApKxX7eUfjtM6AJ8oKzvWOFXWUmVeRo8qRrcq9bvDz23hHX4jXaJYkkkfTLtFECyMJOSiVLNvn6wgO+6rgDAXvgRiMyhrEVio4Ss0/FCCnJciH9/gLEUSZ16DWHHDbTH+s/Qf/9eaEE3oEh0USoVMo3dwbKNKu13gbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ctstjHpC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1150CC19423;
	Sat, 28 Feb 2026 17:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300236;
	bh=DSeS++EwEDiKiYQ08hrhNvl4zKjplGTpvpcRwe/cWmg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ctstjHpC2V3ZMPp62+TLBDh7rfKTWrNJhyalWCeBzR6e1TQL7R8V644RYnBeDqaH5
	 SLmcFA4S0kyq2D2Obkb7zIGt70GbJuS6vXJ7AUFDEctsFBeJyUSN3U54i2DZdHk6vD
	 itvqzB7pXtdIq6fZT1qp/KStjcDWUsltcf0Vbc+UIqyWKEPxulSsbCY1hx2DNIE0EE
	 rom1Xn/8ICeK/e1FriLzqPKyFPA0Gtpdc3G8LHXG9tm2lKAXObIwMLp9SHCUvRBYmL
	 q1y9ZEvwAq61o+PEVM4LUM5hR1f4kWXg4zKw6gE9Uc4+W5rSe+3x82tpWgW7jKaJYu
	 XY3V6Y8YMZc4A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 259/844] wifi: rtw88: Use devm_kmemdup() in rtw_set_supported_band()
Date: Sat, 28 Feb 2026 12:22:52 -0500
Message-ID: <20260228173244.1509663-260-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,realtek.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-220337-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,realtek.com:email,msgid.link:url]
X-Rspamd-Queue-Id: 30A001C5AB9
X-Rspamd-Action: no action

From: Bitterblue Smith <rtl8821cerfe2@gmail.com>

[ Upstream commit 2ba12401cc1f2d970fa2e7d5b15abde3f5abd40d ]

Simplify the code by using device managed memory allocations.

This also fixes a memory leak in rtw_register_hw(). The supported bands
were not freed in the error path.

Copied from commit 145df52a8671 ("wifi: rtw89: Convert
rtw89_core_set_supported_band to use devm_*").

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/1aa7fdef-2d5b-4a31-a4e9-fac8257ed30d@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw88/main.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index f72d12c3b2bc6..6f35357e73246 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -1661,11 +1661,13 @@ static u16 rtw_get_max_scan_ie_len(struct rtw_dev *rtwdev)
 static void rtw_set_supported_band(struct ieee80211_hw *hw,
 				   const struct rtw_chip_info *chip)
 {
-	struct rtw_dev *rtwdev = hw->priv;
 	struct ieee80211_supported_band *sband;
+	struct rtw_dev *rtwdev = hw->priv;
+	struct device *dev = rtwdev->dev;
 
 	if (chip->band & RTW_BAND_2G) {
-		sband = kmemdup(&rtw_band_2ghz, sizeof(*sband), GFP_KERNEL);
+		sband = devm_kmemdup(dev, &rtw_band_2ghz, sizeof(*sband),
+				     GFP_KERNEL);
 		if (!sband)
 			goto err_out;
 		if (chip->ht_supported)
@@ -1674,7 +1676,8 @@ static void rtw_set_supported_band(struct ieee80211_hw *hw,
 	}
 
 	if (chip->band & RTW_BAND_5G) {
-		sband = kmemdup(&rtw_band_5ghz, sizeof(*sband), GFP_KERNEL);
+		sband = devm_kmemdup(dev, &rtw_band_5ghz, sizeof(*sband),
+				     GFP_KERNEL);
 		if (!sband)
 			goto err_out;
 		if (chip->ht_supported)
@@ -1690,13 +1693,6 @@ static void rtw_set_supported_band(struct ieee80211_hw *hw,
 	rtw_err(rtwdev, "failed to set supported band\n");
 }
 
-static void rtw_unset_supported_band(struct ieee80211_hw *hw,
-				     const struct rtw_chip_info *chip)
-{
-	kfree(hw->wiphy->bands[NL80211_BAND_2GHZ]);
-	kfree(hw->wiphy->bands[NL80211_BAND_5GHZ]);
-}
-
 static void rtw_vif_smps_iter(void *data, u8 *mac,
 			      struct ieee80211_vif *vif)
 {
@@ -2320,10 +2316,7 @@ EXPORT_SYMBOL(rtw_register_hw);
 
 void rtw_unregister_hw(struct rtw_dev *rtwdev, struct ieee80211_hw *hw)
 {
-	const struct rtw_chip_info *chip = rtwdev->chip;
-
 	ieee80211_unregister_hw(hw);
-	rtw_unset_supported_band(hw, chip);
 	rtw_debugfs_deinit(rtwdev);
 	rtw_led_deinit(rtwdev);
 }
-- 
2.51.0


