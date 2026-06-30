Return-Path: <stable+bounces-269977-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Gb+dHTHKQ2okiAoAu9opvQ
	(envelope-from <stable+bounces-269977-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 15:52:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C4A6E5138
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 15:52:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=1CRTiOeA;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269977-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-269977-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C860C3121F4B
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 13:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A5A3DF01F;
	Tue, 30 Jun 2026 13:50:15 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E317E366066;
	Tue, 30 Jun 2026 13:50:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782827415; cv=none; b=uUINTX5x4fnHrnrrQRWdsMnVN2G2TfRjHP81+ZF+31kHQLPrqZnbZkimSTnnea+zf3vodMiN7d50HQc8UXAsy4Of8OzgQQJChtsPpRvc3yrVuaYwwU0rNZzQN+DiXyCiCNQrsrTrK+srRC7Z/9jX5oLQJC76urjOiiiDXq9JwdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782827415; c=relaxed/simple;
	bh=OARHgQ2UZkaBI0aNWjDfeM2ltbp2KYNcjq4HRzlHjSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HTlU4z5r6WnoC5it6WgohsMfLV7UFsL1Qd4O0kJ2hY5x2wLbWiA7D6NVxJimcw1iBX/fNvcWB23KF5BXkSApc/y+QTjAMnhzLPkTr0b4ANqDscWoFfbOC28q4aSMsq0qtsGcx/eCPPApIqrqjpms56VYSCofP+wA4JotcDZyTTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=1CRTiOeA; arc=none smtp.client-ip=23.88.38.48
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1782827074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SiIK0ISh6k4aQjZejSleIeHh0c9JnPFk+A63O8+Yixs=;
	b=1CRTiOeAAZM8h6sEfcYh0sAkV+2Dt1H8ekbdwWd66z3t6SF/DCXLDasSEAYsLc4GBV3rV6
	olFVTPgZvt/WDmrkgFh2qt0t3ixGncqyOBQCToabMuv35cRys3n0fLNfheGmpSDXQWU1jI
	72tTym77n3PSOzHFFQ+lm9FeMQH6kY/BaD7chEglT+BqbtcphNOfKRMDlhf2iTaXlAXmaB
	NWqTu19ucBX1BlVKtg1C9mKJUfMkB4muXcLlKii1Kb86xjovtRjGfSQvL0ekMskPtjBS5T
	taILNb1ACCrGffX21stG7z0ZeMsGDH5pvb698H4unY+TIRV1JVXs3MEmuOO8kQ==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	stable@vger.kernel.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net 4/6] batman-adv: dat: acquire ARP hw source only after skb realloc
Date: Tue, 30 Jun 2026 15:44:28 +0200
Message-ID: <20260630134430.85786-5-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260630134430.85786-1-sw@simonwunderlich.de>
References: <20260630134430.85786-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[simonwunderlich.de,none];
	R_DKIM_ALLOW(-0.20)[simonwunderlich.de:s=09092022];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-269977-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:b.a.t.m.a.n@lists.open-mesh.org,m:sven@narfation.org,m:stable@vger.kernel.org,m:sw@simonwunderlich.de,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sw@simonwunderlich.de,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sw@simonwunderlich.de,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[simonwunderlich.de:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,simonwunderlich.de:dkim,simonwunderlich.de:email,simonwunderlich.de:mid,simonwunderlich.de:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,narfation.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D6C4A6E5138

From: Sven Eckelmann <sven@narfation.org>

The pskb_may_pull() called by batadv_get_vid() could reallocate the buffer
behind the skb. Variables which were pointing to the old buffer need to be
reassigned to avoid an use-after-free.

Cc: stable@vger.kernel.org
Fixes: b61ec31c8575 ("batman-adv: Snoop DHCPACKs for DAT")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/distributed-arp-table.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index ae39ceaa2e29a..ead02c9e08484 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -1747,6 +1747,7 @@ void batadv_dat_snoop_incoming_dhcp_ack(struct batadv_priv *bat_priv,
 	struct ethhdr *ethhdr;
 	__be32 ip_src, yiaddr;
 	unsigned short vid;
+	int hdr_size_tmp;
 	__be16 proto;
 	u8 *hw_src;
 
@@ -1763,8 +1764,10 @@ void batadv_dat_snoop_incoming_dhcp_ack(struct batadv_priv *bat_priv,
 	if (!batadv_dat_check_dhcp_ack(skb, proto, &ip_src, chaddr, &yiaddr))
 		return;
 
+	hdr_size_tmp = hdr_size;
+	vid = batadv_dat_get_vid(skb, &hdr_size_tmp);
+	ethhdr = (struct ethhdr *)(skb->data + hdr_size);
 	hw_src = ethhdr->h_source;
-	vid = batadv_dat_get_vid(skb, &hdr_size);
 
 	batadv_dat_entry_add(bat_priv, yiaddr, chaddr, vid);
 	batadv_dat_entry_add(bat_priv, ip_src, hw_src, vid);
-- 
2.47.3


