Return-Path: <stable+bounces-213408-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WNAwLl9bg2mJlQMAu9opvQ
	(envelope-from <stable+bounces-213408-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 15:44:47 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D838E74BE
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 15:44:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0114B3013688
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 14:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB267410D10;
	Wed,  4 Feb 2026 14:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RclupvGq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECE6280A3B;
	Wed,  4 Feb 2026 14:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770216237; cv=none; b=PqzG0eiS6kgMFBQhuJ88VDx7jhzVWbshwGSVkioTzWkbeGsSKGkrRMACG5v00EOM+Bn5zxoya5xs8Grac04A5sP3+qUE0KLBnMSWdNT/F+mIyyhNzmqnBtbLyz2uW14TYBYeVwgmgz7F9FHTm3z3ccAOUZoIxfTFOV178gO40as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770216237; c=relaxed/simple;
	bh=F9styHnQpp2tHdMifI6mwxchigu9fBQ76BGzOGeMeGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=okl4lVG3rpS158FFZbwlZbD3zjktr3nKugaklPfjX+ga3WgMSSSccjg4w1NNJvnc9ZlK55FFK0b9CdSEFwTS3S2K1T0OzIe2Fi5cIbwx2i0JSkw+A5RCvlRg+kAyz5R70v7ALR6g7Ce3dh2/znqLF+iTls4zX7+xVARfYEQLVGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RclupvGq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6708C4CEF7;
	Wed,  4 Feb 2026 14:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770216237;
	bh=F9styHnQpp2tHdMifI6mwxchigu9fBQ76BGzOGeMeGA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RclupvGqsUJzkux5ZfBK2hC41iQZ2IoVm1bWDxvcTEK1s5VWqLBZVVD9Uh3JoXNi3
	 xXsCvEObKS3pejuPsy3g0zxgQPeMJq4u284/BO0E/QkBnQwutg3/V0PGpHyyb9rjtb
	 BdELPDqpJ/X2Fcall1SRA8s5WIiaf3gPi+8ZsYDc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 007/161] macvlan: Use hash iterators to simplify code
Date: Wed,  4 Feb 2026 15:37:50 +0100
Message-ID: <20260204143852.028355719@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143851.755002596@linuxfoundation.org>
References: <20260204143851.755002596@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-213408-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,wanadoo.fr,davemloft.net,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[davemloft.net:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4D838E74BE
X-Rspamd-Action: no action

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit bb23ffa1015cb57e0c9ec3c6135275b38d66a780 ]

Use 'hash_for_each_rcu' and 'hash_for_each_safe' instead of hand writing
them. This saves some lines of code, reduce indentation and improve
readability.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: 7470a7a63dc1 ("macvlan: fix possible UAF in macvlan_forward_source()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/macvlan.c | 45 +++++++++++++++++--------------------------
 1 file changed, 18 insertions(+), 27 deletions(-)

diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
index 9a6d31cdc4ce6..a0d5d0c41b611 100644
--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -270,25 +270,22 @@ static void macvlan_broadcast(struct sk_buff *skb,
 	if (skb->protocol == htons(ETH_P_PAUSE))
 		return;
 
-	for (i = 0; i < MACVLAN_HASH_SIZE; i++) {
-		hlist_for_each_entry_rcu(vlan, &port->vlan_hash[i], hlist) {
-			if (vlan->dev == src || !(vlan->mode & mode))
-				continue;
+	hash_for_each_rcu(port->vlan_hash, i, vlan, hlist) {
+		if (vlan->dev == src || !(vlan->mode & mode))
+			continue;
 
-			hash = mc_hash(vlan, eth->h_dest);
-			if (!test_bit(hash, vlan->mc_filter))
-				continue;
+		hash = mc_hash(vlan, eth->h_dest);
+		if (!test_bit(hash, vlan->mc_filter))
+			continue;
 
-			err = NET_RX_DROP;
-			nskb = skb_clone(skb, GFP_ATOMIC);
-			if (likely(nskb))
-				err = macvlan_broadcast_one(
-					nskb, vlan, eth,
+		err = NET_RX_DROP;
+		nskb = skb_clone(skb, GFP_ATOMIC);
+		if (likely(nskb))
+			err = macvlan_broadcast_one(nskb, vlan, eth,
 					mode == MACVLAN_MODE_BRIDGE) ?:
-				      netif_rx_ni(nskb);
-			macvlan_count_rx(vlan, skb->len + ETH_HLEN,
-					 err == NET_RX_SUCCESS, true);
-		}
+			      netif_rx_ni(nskb);
+		macvlan_count_rx(vlan, skb->len + ETH_HLEN,
+				 err == NET_RX_SUCCESS, true);
 	}
 }
 
@@ -378,20 +375,14 @@ static void macvlan_broadcast_enqueue(struct macvlan_port *port,
 static void macvlan_flush_sources(struct macvlan_port *port,
 				  struct macvlan_dev *vlan)
 {
+	struct macvlan_source_entry *entry;
+	struct hlist_node *next;
 	int i;
 
-	for (i = 0; i < MACVLAN_HASH_SIZE; i++) {
-		struct hlist_node *h, *n;
-
-		hlist_for_each_safe(h, n, &port->vlan_source_hash[i]) {
-			struct macvlan_source_entry *entry;
+	hash_for_each_safe(port->vlan_source_hash, i, next, entry, hlist)
+		if (entry->vlan == vlan)
+			macvlan_hash_del_source(entry);
 
-			entry = hlist_entry(h, struct macvlan_source_entry,
-					    hlist);
-			if (entry->vlan == vlan)
-				macvlan_hash_del_source(entry);
-		}
-	}
 	vlan->macaddr_count = 0;
 }
 
-- 
2.51.0




