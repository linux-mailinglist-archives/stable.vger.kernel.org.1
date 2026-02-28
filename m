Return-Path: <stable+bounces-220338-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6HhkNVIyo2kE+QQAu9opvQ
	(envelope-from <stable+bounces-220338-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:22:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 781501C5B6A
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:22:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7C76230E260D
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64B8359A63;
	Sat, 28 Feb 2026 17:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rSBh/ovp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9289D347FCC;
	Sat, 28 Feb 2026 17:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300237; cv=none; b=Yd2nFgFfQePqu2UuQzc4zXTq/vJRSkQLunozBd0I4I6zU4WV7p0vBot5LYsaYsU7lD1dwHh7KNFdn8Tmfe8wBmYRtZXpNxcxNpBcx+qH+ToWWuxm6DcPdqF3bc+r0aFjd3uNoSw7CetilHaOm52fPkwVGV8GUV8y8RuflR8mkl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300237; c=relaxed/simple;
	bh=awD29nvx2aphOkit+4HOtUSGi40fwC+8DL/sgkv8urc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OfZr3A0zfGVbFZXmFcWHx4yQ/y1TxJDQKACTNGYDUHobGpRgwmOGdqetSinJtYtD/cH5a6e0sEhI4S0PSaNSbxXzKmU79CLHDu1JoJ4CaAhAmIVissY/5x23GcSvmMk/GMCJF2aqmItGUNYalb8Q2UVaOPT+HldycEgazZhXazs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rSBh/ovp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF21EC19425;
	Sat, 28 Feb 2026 17:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300237;
	bh=awD29nvx2aphOkit+4HOtUSGi40fwC+8DL/sgkv8urc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rSBh/ovpr2/PF5kPXWO8w9r75am40nOCgNUAUHVWLaE/tSDA83BWhKap/pKoyIjHO
	 tP7TewFEKJnkBVqRILZOEmtsB6QK9/23jBAhMqaGPQ/7TKvlXTuEOuz9u/o23prYsb
	 EUg6VJ2PrLyj4+RqKxtHLp7bgMtJqD3kgMCzS3I8aGK9lCt1fKWgTm16XsrvpM4leV
	 HlGtprjvC7mozEWTGDgTXarEmSgrMpArEtMGvvyZ46mt2KUcyqQaAWjG750kbDrrmy
	 HkiuxP0TQWFnXMYaUpscWMvNfC0pbjYY+THPLXG99DgUzj1CBLaP6N7ocIYu5GmIq6
	 V85IWnh0cNK4A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 260/844] wifi: rtw88: Fix inadvertent sharing of struct ieee80211_supported_band data
Date: Sat, 28 Feb 2026 12:22:53 -0500
Message-ID: <20260228173244.1509663-261-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,realtek.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-220338-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,realtek.com:email,msgid.link:url]
X-Rspamd-Queue-Id: 781501C5B6A
X-Rspamd-Action: no action

From: Bitterblue Smith <rtl8821cerfe2@gmail.com>

[ Upstream commit fcac0f23d4d20b11014a39f8e2527cdc12ec9c82 ]

Internally wiphy writes to individual channels in this structure,
so we must not share one static definition of channel list between
multiple device instances, because that causes hard to debug
breakage.

For example, with two rtw88 driven devices in the system, channel
information may get incoherent, preventing channel use.

Copied from commit 0ae36391c804 ("wifi: rtw89: Fix inadverent sharing
of struct ieee80211_supported_band data").

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/e94ad653-2b6d-4284-a33c-8c694f88955b@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw88/main.c | 34 +++++++++++++++++++----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 6f35357e73246..dde2ea6a00e06 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -1658,16 +1658,41 @@ static u16 rtw_get_max_scan_ie_len(struct rtw_dev *rtwdev)
 	return len;
 }
 
+static struct ieee80211_supported_band *
+rtw_sband_dup(struct rtw_dev *rtwdev,
+	      const struct ieee80211_supported_band *sband)
+{
+	struct ieee80211_supported_band *dup;
+
+	dup = devm_kmemdup(rtwdev->dev, sband, sizeof(*sband), GFP_KERNEL);
+	if (!dup)
+		return NULL;
+
+	dup->channels = devm_kmemdup_array(rtwdev->dev, sband->channels,
+					   sband->n_channels,
+					   sizeof(*sband->channels),
+					   GFP_KERNEL);
+	if (!dup->channels)
+		return NULL;
+
+	dup->bitrates = devm_kmemdup_array(rtwdev->dev, sband->bitrates,
+					   sband->n_bitrates,
+					   sizeof(*sband->bitrates),
+					   GFP_KERNEL);
+	if (!dup->bitrates)
+		return NULL;
+
+	return dup;
+}
+
 static void rtw_set_supported_band(struct ieee80211_hw *hw,
 				   const struct rtw_chip_info *chip)
 {
 	struct ieee80211_supported_band *sband;
 	struct rtw_dev *rtwdev = hw->priv;
-	struct device *dev = rtwdev->dev;
 
 	if (chip->band & RTW_BAND_2G) {
-		sband = devm_kmemdup(dev, &rtw_band_2ghz, sizeof(*sband),
-				     GFP_KERNEL);
+		sband = rtw_sband_dup(rtwdev, &rtw_band_2ghz);
 		if (!sband)
 			goto err_out;
 		if (chip->ht_supported)
@@ -1676,8 +1701,7 @@ static void rtw_set_supported_band(struct ieee80211_hw *hw,
 	}
 
 	if (chip->band & RTW_BAND_5G) {
-		sband = devm_kmemdup(dev, &rtw_band_5ghz, sizeof(*sband),
-				     GFP_KERNEL);
+		sband = rtw_sband_dup(rtwdev, &rtw_band_5ghz);
 		if (!sband)
 			goto err_out;
 		if (chip->ht_supported)
-- 
2.51.0


