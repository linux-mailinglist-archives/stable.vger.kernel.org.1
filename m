Return-Path: <stable+bounces-250125-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +NN7DeLtDWpb4wUAu9opvQ
	(envelope-from <stable+bounces-250125-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:22:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA352593777
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B91D34A8F74
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5CB3033E7;
	Wed, 20 May 2026 16:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IkhWRS11"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E70372EF6;
	Wed, 20 May 2026 16:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779294609; cv=none; b=JppPMPmQK4LY7NeVOIb0ukMTt7Zk5kYXiM1uCQ7cpQ2Q5MQ+mCbopE8C0SJFIGMj9+Qp/M9Dj4ehxze9Mw8z5BaCdDo75JUCmVHyIjoqwiqHbODBJiA0cAMk4Ud1RtCJ9ISEj135y4eucSsCFNuhiW/9eibNM2BF50Qs1a4+NbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779294609; c=relaxed/simple;
	bh=HVBuOXe9BegCGm2HXvGi+MwvYQwTefeytpY5sWToCL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n7O2s7X0ho1XGc8ZFXwGzBXYvb8OEpZTHKH7qXsBMhdq6iUdNtbm3TONKLqv6mIh53v/wkYXyTwvpkb4HL9KS6DHIic8JBFHYBMK5rcD6zIY6LfJ/eh2pczgKJfb4qdyC8+Vh3+TGR5D5LWmKT3A4tGnulN0aD8o18QRiGeSS1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IkhWRS11; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07B4F1F000E9;
	Wed, 20 May 2026 16:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779294608;
	bh=5jMzBFhObh6TAGBz8DXQtw2yVaRWCsm0a3hzda0OqJc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IkhWRS11Rj/nw0ok2gfykCiE4keSh8zhTLloP72R+GXcMYdNk8f5jZcJLaeITaNcM
	 BdFNj8w+ACbsrB3OxXR3GhBZsjUaop6VvQIQ1QM220dXfe75q8W/RiQHbmXt91hmAI
	 0XlInUqsT8HHSnZTIRKlSWdtnnH2MZIVWGp2sfg4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ming Yen Hsieh <mingyen.hsieh@mediatek.com>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0104/1146] wifi: mt76: mt7925: prevent NULL pointer dereference in mt7925_tx_check_aggr()
Date: Wed, 20 May 2026 18:05:54 +0200
Message-ID: <20260520162150.695254727@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-250125-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nbd.name:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,mediatek.com:email,msgid.link:url]
X-Rspamd-Queue-Id: AA352593777
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>

[ Upstream commit 83ae3a18ba957257b4c406273d2da2caeea2b439 ]

Move the NULL check for 'sta' before dereferencing it to prevent a
possible crash.

Fixes: 44eb173bdd4f ("wifi: mt76: mt7925: add link handling in mt7925_txwi_free")
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Link: https://patch.msgid.link/20250904030649.655436-4-mingyen.hsieh@mediatek.com
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7925/mac.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
index ebe872f58c88f..711daa5f07fab 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
@@ -846,11 +846,14 @@ static void mt7925_tx_check_aggr(struct ieee80211_sta *sta, struct sk_buff *skb,
 	bool is_8023;
 	u16 fc, tid;
 
+	if (!sta)
+		return;
+
 	link_sta = rcu_dereference(sta->link[wcid->link_id]);
 	if (!link_sta)
 		return;
 
-	if (!sta || !(link_sta->ht_cap.ht_supported || link_sta->he_cap.has_he))
+	if (!(link_sta->ht_cap.ht_supported || link_sta->he_cap.has_he))
 		return;
 
 	tid = skb->priority & IEEE80211_QOS_CTL_TID_MASK;
-- 
2.53.0




