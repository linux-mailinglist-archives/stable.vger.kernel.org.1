Return-Path: <stable+bounces-244855-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oHIPGlyB/mnyrwAAu9opvQ
	(envelope-from <stable+bounces-244855-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 02:35:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE5C4FD109
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 02:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0D26C300863F
	for <lists+stable@lfdr.de>; Sat,  9 May 2026 00:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98201D5CE0;
	Sat,  9 May 2026 00:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qOd9pCIe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2491A6807
	for <stable@vger.kernel.org>; Sat,  9 May 2026 00:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778286934; cv=none; b=kJOQ0I01ghX6zf4Vt+QLB8R++MSLJmhWZEnQELZZeSg8VQENDHnql9py87qVMaO185OzlmwHqoFrdymHV++Doa7B0E6NeZbW6kUAXNHEqF3+7WFSaQoqnwFcAGeYp9ErDX8JifY5FgizbwL89mIDm5XMOnsqKAVLcfqpwjP33sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778286934; c=relaxed/simple;
	bh=7bMV8SXJgFrEp2j+xiwL5xGZSAKjTvLtv0K35v0O6w8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UqyNZbVMC34a1WN/0O/UOcUJr0XJW9FbjOwiT3Z7QFtiqMz6udNHCOOvgF9uJSTD1TPmlgjeduRnuP0B1KEigDwsI7Dm7ECsQo4IcfhFzSApZ/2L1NBAJN4bdpJNOIC7ahFga+gCLnl8f1jaX3x0GxKlxwI9xcfjkM3Tp2Fgtao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qOd9pCIe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E2D3C2BCB0;
	Sat,  9 May 2026 00:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778286933;
	bh=7bMV8SXJgFrEp2j+xiwL5xGZSAKjTvLtv0K35v0O6w8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qOd9pCIeV8HDklWo+sjYpGumWNMdlP3eillgD7BE1KW5bFrN/hCriLi2osp44l6TX
	 JWWVKTnHr8fSR/Inss0zhuO/LSFNJul52PbsZAg5laXzggHFmebD2bLALUQYOt60Dh
	 fDKHkRkj1J7uI4FB4oEoulP00g2duCfj3G8jgCzb0lMxBMAuGT3h4/O0B9WC085urf
	 0Ygb8gJGi5e9VL8zIACEu1vfMLF/7TGAs4MGMhCGn7u7Hpj6LU18BWHCmC6o0HaPom
	 FccX0PKUqNvmWfUce7rt873qrrU8AHNDlldziR9qNwpyPdwAhrNB8+zXomaEH4x3ID
	 kPS25YP56nOUw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yi Cong <yicong@kylinos.cn>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] wifi: rtl8xxxu: fix potential use of uninitialized value
Date: Fri,  8 May 2026 20:35:20 -0400
Message-ID: <20260509003520.2360221-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026050450-canning-drab-e2be@gregkh>
References: <2026050450-canning-drab-e2be@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6DE5C4FD109
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244855-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Action: no action

From: Yi Cong <yicong@kylinos.cn>

[ Upstream commit f8a2fc809bfeb49130709b31a4d357a049f28547 ]

The local variables 'mcs' and 'nss' in rtl8xxxu_update_ra_report() are
passed to rtl8xxxu_desc_to_mcsrate() as output parameters. If the helper
function encounters an unhandled rate index, it may return without setting
these values, leading to the use of uninitialized stack data.

Remove the helper rtl8xxxu_desc_to_mcsrate() and inline the logic into
rtl8xxxu_update_ra_report(). This fixes the use of uninitialized 'mcs'
and 'nss' variables for legacy rates.

The new implementation explicitly handles:
- Legacy rates: Set bitrate only.
- HT rates (MCS0-15): Set MCS flags, index, and NSS (1 or 2) directly.
- Invalid rates: Return early.

Fixes: 7de16123d9e2 ("wifi: rtl8xxxu: Introduce rtl8xxxu_update_ra_report")
Cc: stable@vger.kernel.org
Suggested-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Yi Cong <yicong@kylinos.cn>
Link: https://lore.kernel.org/all/96e31963da0c42dcb52ce44f818963d7@realtek.com/
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20260306071627.56501-1-cong.yi@linux.dev
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 28 ++++++-------------
 1 file changed, 8 insertions(+), 20 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 03aacb7a43171..5a57ffb53acee 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -4809,20 +4809,6 @@ static const struct ieee80211_rate rtl8xxxu_legacy_ratetable[] = {
 	{.bitrate = 540, .hw_value = 0x0b,},
 };
 
-static void rtl8xxxu_desc_to_mcsrate(u16 rate, u8 *mcs, u8 *nss)
-{
-	if (rate <= DESC_RATE_54M)
-		return;
-
-	if (rate >= DESC_RATE_MCS0 && rate <= DESC_RATE_MCS15) {
-		if (rate < DESC_RATE_MCS8)
-			*nss = 1;
-		else
-			*nss = 2;
-		*mcs = rate - DESC_RATE_MCS0;
-	}
-}
-
 static void rtl8xxxu_set_basic_rates(struct rtl8xxxu_priv *priv, u32 rate_cfg)
 {
 	struct ieee80211_hw *hw = priv->hw;
@@ -4927,23 +4913,25 @@ static void rtl8xxxu_set_aifs(struct rtl8xxxu_priv *priv, u8 slot_time)
 void rtl8xxxu_update_ra_report(struct rtl8xxxu_ra_report *rarpt,
 			       u8 rate, u8 sgi, u8 bw)
 {
-	u8 mcs, nss;
-
 	rarpt->txrate.flags = 0;
 
 	if (rate <= DESC_RATE_54M) {
 		rarpt->txrate.legacy = rtl8xxxu_legacy_ratetable[rate].bitrate;
-	} else {
-		rtl8xxxu_desc_to_mcsrate(rate, &mcs, &nss);
+	} else if (rate >= DESC_RATE_MCS0 && rate <= DESC_RATE_MCS15) {
 		rarpt->txrate.flags |= RATE_INFO_FLAGS_MCS;
+		if (rate < DESC_RATE_MCS8)
+			rarpt->txrate.nss = 1;
+		else
+			rarpt->txrate.nss = 2;
 
-		rarpt->txrate.mcs = mcs;
-		rarpt->txrate.nss = nss;
+		rarpt->txrate.mcs = rate - DESC_RATE_MCS0;
 
 		if (sgi)
 			rarpt->txrate.flags |= RATE_INFO_FLAGS_SHORT_GI;
 
 		rarpt->txrate.bw = bw;
+	} else {
+		return;
 	}
 
 	rarpt->bit_rate = cfg80211_calculate_bitrate(&rarpt->txrate);
-- 
2.53.0


