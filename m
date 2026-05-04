Return-Path: <stable+bounces-243762-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iGGxCtau+Gn2xgIAu9opvQ
	(envelope-from <stable+bounces-243762-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:36:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C434BFBDA
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 19959306AE9E
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 14:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0413DFC69;
	Mon,  4 May 2026 14:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bsCLGx0n"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE333DF01B;
	Mon,  4 May 2026 14:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777904713; cv=none; b=k30ZqH8fVcvTFEdq9ylxrpdHlQ7C1QWm5RiC1nxxhkp4CJccmjb2B1WrYF4uECP7X5ZRVQx1tv6pH0BtiV+GRZclIIIKSGaJlYKSdFJQ+ldwpSuJBqL9Of8JcZNJ4l82iHOJHyUtKdfXpskB8eZI8N5ZyTBagQoqjadcWdH+0C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777904713; c=relaxed/simple;
	bh=19ipKceCJC83WfnwQeZtN0IyecH8UAucgaOzuPVdW7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mhNWL+bjI1cndFuNkQvL9AwCuieuXOcVta5S8hcE0iZMnxUyo/o0Vcjjep8er7fKVwkyEgNYgMkDeQJXO3tz2ddfaUjRUK6SSR631nHMFq3cPhn6U/vCr9mKLzqIcxGMBf1gQye3HYFS9LhrXBw8P68QUhYN3/QyqbtVxATduNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bsCLGx0n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04F9BC2BCB8;
	Mon,  4 May 2026 14:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777904713;
	bh=19ipKceCJC83WfnwQeZtN0IyecH8UAucgaOzuPVdW7A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bsCLGx0nGGW5vjwhMfbbh1LIyjln6qddKBQxc4TS7LqVGCbKoCP3sgM8FN7nfwhht
	 nFHg8yTIs8o2TWT+6ycIu+JObwlafOw0kndwsgtvjRqQNjXRQGk58fW1IBPt1jZmg8
	 E/Jy810+RMEZ7uHkaKiinQCDQRvD6Bx17SGam3nA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ping-Ke Shih <pkshih@realtek.com>,
	Yi Cong <yicong@kylinos.cn>
Subject: [PATCH 6.12 146/215] wifi: rtl8xxxu: fix potential use of uninitialized value
Date: Mon,  4 May 2026 15:52:45 +0200
Message-ID: <20260504135135.495257621@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504135130.169210693@linuxfoundation.org>
References: <20260504135130.169210693@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C4C434BFBDA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-243762-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,kylinos.cn:email,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,msgid.link:url,realtek.com:email]

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yi Cong <yicong@kylinos.cn>

commit f8a2fc809bfeb49130709b31a4d357a049f28547 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/realtek/rtl8xxxu/core.c |   28 +++++++--------------------
 1 file changed, 8 insertions(+), 20 deletions(-)

--- a/drivers/net/wireless/realtek/rtl8xxxu/core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/core.c
@@ -4799,20 +4799,6 @@ static const struct ieee80211_rate rtl8x
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
@@ -4922,23 +4908,25 @@ static void rtl8xxxu_set_aifs(struct rtl
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



