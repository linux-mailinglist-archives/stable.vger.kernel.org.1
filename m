Return-Path: <stable+bounces-233840-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OO49FPs11mlZBwgAu9opvQ
	(envelope-from <stable+bounces-233840-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 13:03:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A96463BB0F8
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 13:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ACE823015D26
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 11:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6296937B3F9;
	Wed,  8 Apr 2026 11:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="Dyy+MT5O"
X-Original-To: stable@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50ED2E8B8A;
	Wed,  8 Apr 2026 11:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775646200; cv=none; b=ge1OKy/mVSw+gl9gP2iPY6c4Pe8nU8/6dW2j+v6yj9sT6gNsRz9PpGVKaX7FGAwlMnZvSWNCK7W9mXVKX6F7RlZ+oi+5GbZZ2wZg4QeRMD+Fcimvtx2/Rd+pGBXspTduD8aaF2gM/oLlZv2vyz89Ff75QKOffbbdV3iA0/krJEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775646200; c=relaxed/simple;
	bh=08Q1dMV/7+KzD4lHA2fx/meL9kTyGNMncxHMHrZ4U7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bdylxe6UWxhG5XJw0z9JhLGsI7klwIycHdJYo9ccFx6numWLzXVP8i/MG5ul5LpQan91EbiWKb4hs0jH23JPV6FZ6gTUUnLiT1YJoE/QVB7BhJgDMd2cJ61zQTlYBHdvwL/fs7kGYE1cSKR0leBfhr6fu4qdKPUiX/UZ/9/bqoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=Dyy+MT5O; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1775646195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yp6I7b0bf/KYoASlU+siFF3CuLzV71ZDF6eOe3F2lZ0=;
	b=Dyy+MT5O8I06JJDfM9g8RSY3afbY86g6g1TSm9gQMXsApj5EdkcpxRFpUSqXKclZDKJeU1
	AK7O1Lx2BdJx3AntN2RMFtWCply21IeRCH4mQySBn5ouTtrt0VFK8IyeQNygnnujH5IejI
	jAfpqsNB3GfcW9GVXn2B3/16OVi6W6PKF3pR8Jz6v3w89zJlNZYSXOyLW/u7ptmjAafqJp
	PLCFjs6KOiH9zidQ/wcXxkiuSEjiWoMeK8fke4Ube2y24RrTVazmvAsZ9mq7KfLXrXr19f
	G34Epqe/2UMDzd9T/x8I/S+H46k6eByth7sIVj4b3vV1UbeVJaV8cDBvRAyegA==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Haoze Xie <royenheart@gmail.com>,
	stable@vger.kernel.org,
	Yifan Wu <yifanwucs@gmail.com>,
	Juefei Pu <tomapufckgml@gmail.com>,
	Yuan Tan <yuantan098@gmail.com>,
	Xin Liu <bird@lzu.edu.cn>,
	Ao Zhou <n05ec@lzu.edu.cn>,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net 2/2] batman-adv: hold claim backbone gateways by reference
Date: Wed,  8 Apr 2026 13:02:55 +0200
Message-ID: <20260408110255.976389-3-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260408110255.976389-1-sw@simonwunderlich.de>
References: <20260408110255.976389-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[simonwunderlich.de,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[simonwunderlich.de:s=09092022];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.open-mesh.org,gmail.com,lzu.edu.cn,narfation.org,simonwunderlich.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-233840-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sw@simonwunderlich.de,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[simonwunderlich.de:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lzu.edu.cn:email]
X-Rspamd-Queue-Id: A96463BB0F8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Haoze Xie <royenheart@gmail.com>

batadv_bla_add_claim() can replace claim->backbone_gw and drop the old
gateway's last reference while readers still follow the pointer.

The netlink claim dump path dereferences claim->backbone_gw->orig and
takes claim->backbone_gw->crc_lock without pinning the underlying
backbone gateway. batadv_bla_check_claim() still has the same naked
pointer access pattern.

Reuse batadv_bla_claim_get_backbone_gw() in both readers so they operate
on a stable gateway reference until the read-side work is complete.
This keeps the dump and claim-check paths aligned with the lifetime
rules introduced for the other BLA claim readers.

Fixes: 23721387c409 ("batman-adv: add basic bridge loop avoidance code")
Fixes: 04f3f5bf1883 ("batman-adv: add B.A.T.M.A.N. Dump BLA claims via netlink")
Cc: stable@vger.kernel.org
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Co-developed-by: Yuan Tan <yuantan098@gmail.com>
Signed-off-by: Yuan Tan <yuantan098@gmail.com>
Suggested-by: Xin Liu <bird@lzu.edu.cn>
Signed-off-by: Haoze Xie <royenheart@gmail.com>
Signed-off-by: Ao Zhou <n05ec@lzu.edu.cn>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bridge_loop_avoidance.c | 27 +++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index 3dc791c15bf72..648fa97ea913f 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -2130,6 +2130,7 @@ batadv_bla_claim_dump_entry(struct sk_buff *msg, u32 portid,
 			    struct batadv_bla_claim *claim)
 {
 	const u8 *primary_addr = primary_if->net_dev->dev_addr;
+	struct batadv_bla_backbone_gw *backbone_gw;
 	u16 backbone_crc;
 	bool is_own;
 	void *hdr;
@@ -2145,32 +2146,35 @@ batadv_bla_claim_dump_entry(struct sk_buff *msg, u32 portid,
 
 	genl_dump_check_consistent(cb, hdr);
 
-	is_own = batadv_compare_eth(claim->backbone_gw->orig,
-				    primary_addr);
+	backbone_gw = batadv_bla_claim_get_backbone_gw(claim);
+
+	is_own = batadv_compare_eth(backbone_gw->orig, primary_addr);
 
-	spin_lock_bh(&claim->backbone_gw->crc_lock);
-	backbone_crc = claim->backbone_gw->crc;
-	spin_unlock_bh(&claim->backbone_gw->crc_lock);
+	spin_lock_bh(&backbone_gw->crc_lock);
+	backbone_crc = backbone_gw->crc;
+	spin_unlock_bh(&backbone_gw->crc_lock);
 
 	if (is_own)
 		if (nla_put_flag(msg, BATADV_ATTR_BLA_OWN)) {
 			genlmsg_cancel(msg, hdr);
-			goto out;
+			goto put_backbone_gw;
 		}
 
 	if (nla_put(msg, BATADV_ATTR_BLA_ADDRESS, ETH_ALEN, claim->addr) ||
 	    nla_put_u16(msg, BATADV_ATTR_BLA_VID, claim->vid) ||
 	    nla_put(msg, BATADV_ATTR_BLA_BACKBONE, ETH_ALEN,
-		    claim->backbone_gw->orig) ||
+		    backbone_gw->orig) ||
 	    nla_put_u16(msg, BATADV_ATTR_BLA_CRC,
 			backbone_crc)) {
 		genlmsg_cancel(msg, hdr);
-		goto out;
+		goto put_backbone_gw;
 	}
 
 	genlmsg_end(msg, hdr);
 	ret = 0;
 
+put_backbone_gw:
+	batadv_backbone_gw_put(backbone_gw);
 out:
 	return ret;
 }
@@ -2448,6 +2452,7 @@ int batadv_bla_backbone_dump(struct sk_buff *msg, struct netlink_callback *cb)
 bool batadv_bla_check_claim(struct batadv_priv *bat_priv,
 			    u8 *addr, unsigned short vid)
 {
+	struct batadv_bla_backbone_gw *backbone_gw;
 	struct batadv_bla_claim search_claim;
 	struct batadv_bla_claim *claim = NULL;
 	struct batadv_hard_iface *primary_if = NULL;
@@ -2470,9 +2475,13 @@ bool batadv_bla_check_claim(struct batadv_priv *bat_priv,
 	 * return false.
 	 */
 	if (claim) {
-		if (!batadv_compare_eth(claim->backbone_gw->orig,
+		backbone_gw = batadv_bla_claim_get_backbone_gw(claim);
+
+		if (!batadv_compare_eth(backbone_gw->orig,
 					primary_if->net_dev->dev_addr))
 			ret = false;
+
+		batadv_backbone_gw_put(backbone_gw);
 		batadv_claim_put(claim);
 	}
 
-- 
2.47.3


