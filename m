Return-Path: <stable+bounces-242900-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJFVK0Rc+GnatQIAu9opvQ
	(envelope-from <stable+bounces-242900-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 10:43:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5186F4BA6C0
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 10:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 133EC30117A5
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 08:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A6934216C;
	Mon,  4 May 2026 08:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pM7OQM3s"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F37340280
	for <stable@vger.kernel.org>; Mon,  4 May 2026 08:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777884172; cv=none; b=d6sMh4pb8J8b66gtOQbdjemxK6Wlwd7qfbf+eLZSHodDbvizY1KCf+VK/pC0faYENTC/9H7RRPdyqFLQ1id3xN3cUkgGvDF5DtejIey30fwd0zlvqYEJyD0rJr4QNLgbp597gnBqsJ2MRXJRk5FEQst2q3VNRv3BBfi1FPviMkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777884172; c=relaxed/simple;
	bh=BLXbK0ctPCM8DL7grq9TCk13IzV9rhZwrl9sbTnDPZ4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ReSDErolfA6GkD0upzbnW5B4cfjSVaF6ENb6C//bVekkyHLW1YKc+Wkc49/H4KmLK0sLhWc1lC4z4vI+U7suHExqFG7KJHLo/jYocm8Ol77LHGuRCzwHEKfX+yhlSgyS3RNCgiqKoZN2PH4SH5skDJOPC1+sSLcHYmnsXq/cT2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pM7OQM3s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D75BEC2BCB8;
	Mon,  4 May 2026 08:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777884172;
	bh=BLXbK0ctPCM8DL7grq9TCk13IzV9rhZwrl9sbTnDPZ4=;
	h=Subject:To:Cc:From:Date:From;
	b=pM7OQM3s5BWHoNy0mjl/SWo8h72gE6Iz0q22e/eKg6zlxrgXu0vxdUFwcm0m18TNI
	 BmP/asyMSjLby+YtU7c5ywqiLbZWPKrsRWPYfWZrQml6VR4qm6pUSkYlHGErWRnF/E
	 OtziYs4qaOvhM0B0ED37WbxDItt5+c7RgEv2Xc44=
Subject: FAILED: patch "[PATCH] wifi: rtl8xxxu: fix potential use of uninitialized value" failed to apply to 6.12-stable tree
To: yicong@kylinos.cn,pkshih@realtek.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 04 May 2026 10:42:49 +0200
Message-ID: <2026050449-subtitle-twisty-9256@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5186F4BA6C0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-242900-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,kylinos.cn:email,msgid.link:url,linuxfoundation.org:dkim]


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x f8a2fc809bfeb49130709b31a4d357a049f28547
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026050449-subtitle-twisty-9256@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f8a2fc809bfeb49130709b31a4d357a049f28547 Mon Sep 17 00:00:00 2001
From: Yi Cong <yicong@kylinos.cn>
Date: Fri, 6 Mar 2026 15:16:27 +0800
Subject: [PATCH] wifi: rtl8xxxu: fix potential use of uninitialized value

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

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/core.c b/drivers/net/wireless/realtek/rtl8xxxu/core.c
index b4efc6f00a37..d1b1474cba67 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/core.c
@@ -4697,20 +4697,6 @@ static const struct ieee80211_rate rtl8xxxu_legacy_ratetable[] = {
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
@@ -4820,23 +4806,25 @@ static void rtl8xxxu_set_aifs(struct rtl8xxxu_priv *priv, u8 slot_time)
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


