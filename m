Return-Path: <stable+bounces-270770-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id q6J8HXqWRmpAZQsAu9opvQ
	(envelope-from <stable+bounces-270770-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 18:48:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 76AD56FA987
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 18:48:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=nZb0IygZ;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270770-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-270770-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5CCFC3044A0B
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 16:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D69733BBD7;
	Thu,  2 Jul 2026 16:30:07 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60723A9628;
	Thu,  2 Jul 2026 16:30:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783009806; cv=none; b=AaS8WVMsMGYJb3v9z9ZPFIPUITRJEDMCPWEChiLhHF37/Zb6YkSKTu+LuPC19HuWX9oycmIKsbvCdR4nWJfy7VDPeJPmMOKuDCbmVVPWGnm4oDRX9O6LoNBfZv1zBn59+Ftgkdn/AAaIqVHe7rA1X78i1rTAmPiFfedf3Xiv9UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783009806; c=relaxed/simple;
	bh=+PDesukn8JjrRH92Uh+AqTkY2YTv+r5cM5M1vHM7xC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qMwfPw+aQLZGW6dTVGowazMjTxOscRUcVjvbuTIygdg1jd4mrTm3kEShuYaUlB+d3dU3zfvcEmG0MY+j8IEsti8VGzF8NB0z7wXsbNIN8OkoGdADoFmTCGS+FpgrgCu3hNgjSE35/gU6XBd+YlX/KSf1Q9CZ9mEdYuQ6YwSxkxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nZb0IygZ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 160E91F000E9;
	Thu,  2 Jul 2026 16:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783009804;
	bh=d0aQ6hXmRxqL0M0eebFYLDYyfDo2X/QjJpoQUcBABPE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nZb0IygZjh2pxmxhZKpsOeTOe0D9Ip4MquK0bglkGPCcrAspOQYMF8ucu9z8fb2fz
	 cw43kKGBLn9ytfT2R2R7vk3Kp0U4Q5KHvG58nWOcgRnujMU72GLzpn6msKuwvPRir5
	 cWUGZPHRunbHEoJQaURJoWRiITYdifC+An4eOfYE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable@kernel.org,
	Sven Eckelmann <sven@narfation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 50/95] batman-adv: dat: prevent false sharing between VLANs
Date: Thu,  2 Jul 2026 18:19:53 +0200
Message-ID: <20260702155110.261300527@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702155109.196223802@linuxfoundation.org>
References: <20260702155109.196223802@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-270770-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:stable@kernel.org,m:sven@narfation.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,narfation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 76AD56FA987

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sven Eckelmann <sven@narfation.org>

commit 20d7658b74169f86d4ac01b9185b3eadddf71f28 upstream.

The local hash of DAT entries is supposed to be VLAN (VID) aware. But
the adding to the hash and the search in the hash were not checking the VID
information of the hash entries. The entries would therefore only be
correctly separated when batadv_hash_dat() didn't select the same buckets
for different VIDs.

Cc: stable@kernel.org
Fixes: be1db4f6615b ("batman-adv: make the Distributed ARP Table vlan aware")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/batman-adv/distributed-arp-table.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index 9f561ea95f730d..b8d471dae2888c 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -215,10 +215,13 @@ static void batadv_dat_purge(struct work_struct *work)
  */
 static bool batadv_compare_dat(const struct hlist_node *node, const void *data2)
 {
-	const void *data1 = container_of(node, struct batadv_dat_entry,
-					 hash_entry);
+	const struct batadv_dat_entry *entry1;
+	const struct batadv_dat_entry *entry2;
 
-	return memcmp(data1, data2, sizeof(__be32)) == 0;
+	entry1 = container_of(node, struct batadv_dat_entry, hash_entry);
+	entry2 = data2;
+
+	return entry1->ip == entry2->ip && entry1->vid == entry2->vid;
 }
 
 /**
@@ -345,6 +348,9 @@ batadv_dat_entry_hash_find(struct batadv_priv *bat_priv, __be32 ip,
 		if (dat_entry->ip != ip)
 			continue;
 
+		if (dat_entry->vid != vid)
+			continue;
+
 		if (!kref_get_unless_zero(&dat_entry->refcount))
 			continue;
 
-- 
2.53.0




