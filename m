Return-Path: <stable+bounces-251274-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YHtEFz/zDWrA4wUAu9opvQ
	(envelope-from <stable+bounces-251274-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:45:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F355E5947CF
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2BC4E31022B9
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DFA136F421;
	Wed, 20 May 2026 17:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jQkn9tpP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29417372EDE;
	Wed, 20 May 2026 17:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779297557; cv=none; b=nwXLICO0bn7JybOSLODeh3LRnQM8TEPdApchmWty8FotmFgaSRz0CLCiIOaWQ6OkXwXu7pw3JUXad+boM7KNnh9CBvdB2jRwSl5OWgnzFJwGHkogjsXorSwM2YBGYDYKpKwVF34MYTVvMaeBqwg0SsoRJ9RhH1be3HFo5GvNXO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779297557; c=relaxed/simple;
	bh=h9f2gCAy2fG7IIUsDDycF3gwXPFe/RyiTl6SdfOl89U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X4gMi1Yf895vfcC6xshwxOU2YYeN9k/uXQc54q+SFqrarmZCyCN2BOaOlNEqhOHiyR7O1QKi75ukPLx/qYPp9ss+B9qVbfXA6LD+5REGBHoYD2W2Aa6SdhAvLadXKE2RzuR5QxssuapSmhD3rDSuroScSeFZ7OTiY++rehXvmXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jQkn9tpP; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 874D21F000E9;
	Wed, 20 May 2026 17:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779297556;
	bh=4dSyjwROSI5R/7LmqMGznVpIIXDrumM6NlFU1bqIT64=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jQkn9tpPD3b8uE76gqBnwdwdm586nN4zg+FKY6shOre9wS68InMSuN9iQpzCtrK4G
	 kKnmBmZac9l1k5ERq62+r9THeqKXi6I/0Q3kWqLpSiQVYF2W1X2Davbp7Kp1hDz4B0
	 LVSMaoomGOBLP3JjTQ5UXI1iHxJqMGrhscx9tjbA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shayne Chen <shayne.chen@mediatek.com>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 075/957] wifi: mt76: mt7996: fix iface combination for different chipsets
Date: Wed, 20 May 2026 18:09:18 +0200
Message-ID: <20260520162136.190306479@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-251274-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mediatek.com:email,nbd.name:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: F355E5947CF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shayne Chen <shayne.chen@mediatek.com>

[ Upstream commit 5ef0e8e2653b1ba325eb883ffb94073f19cb669a ]

MT7992 and MT7990 support up to 19 interfaces per band and 32 in total.

Fixes: 8df63a4bbe3d ("wifi: mt76: mt7996: adjust interface num and wtbl size for mt7992")
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
Link: https://patch.msgid.link/20251215063728.3013365-7-shayne.chen@mediatek.com
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7996/init.c    | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
index b136b9a669769..e26f8e9e4f8fc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -34,6 +34,20 @@ static const struct ieee80211_iface_combination if_comb_global = {
 			       BIT(NL80211_CHAN_WIDTH_40) |
 			       BIT(NL80211_CHAN_WIDTH_80) |
 			       BIT(NL80211_CHAN_WIDTH_160),
+	.beacon_int_min_gcd = 100,
+};
+
+static const struct ieee80211_iface_combination if_comb_global_7992 = {
+	.limits = &if_limits_global,
+	.n_limits = 1,
+	.max_interfaces = 32,
+	.num_different_channels = MT7996_MAX_RADIOS - 1,
+	.radar_detect_widths = BIT(NL80211_CHAN_WIDTH_20_NOHT) |
+			       BIT(NL80211_CHAN_WIDTH_20) |
+			       BIT(NL80211_CHAN_WIDTH_40) |
+			       BIT(NL80211_CHAN_WIDTH_80) |
+			       BIT(NL80211_CHAN_WIDTH_160),
+	.beacon_int_min_gcd = 100,
 };
 
 static const struct ieee80211_iface_limit if_limits[] = {
@@ -485,7 +499,8 @@ mt7996_init_wiphy(struct ieee80211_hw *hw, struct mtk_wed_device *wed)
 	hw->vif_data_size = sizeof(struct mt7996_vif);
 	hw->chanctx_data_size = sizeof(struct mt76_chanctx);
 
-	wiphy->iface_combinations = &if_comb_global;
+	wiphy->iface_combinations = is_mt7996(&dev->mt76) ? &if_comb_global :
+							    &if_comb_global_7992;
 	wiphy->n_iface_combinations = 1;
 
 	wiphy->radio = dev->radios;
-- 
2.53.0




