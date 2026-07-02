Return-Path: <stable+bounces-271254-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id W0ovO5KcRmqEaAsAu9opvQ
	(envelope-from <stable+bounces-271254-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:14:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3946FB28B
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:14:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b="toC3WmC/";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271254-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-271254-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6BFB13142AA8
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 16:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD19F33E355;
	Thu,  2 Jul 2026 16:51:06 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8015126F46F;
	Thu,  2 Jul 2026 16:51:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783011066; cv=none; b=kkw0/2m8+Bq8DVmb6+ek3vuHKtuyIcFWpriDA7WR/eTiopUsUcFjvN+d288w6RTJB802Lwl3VlX83RE+12NTxbGlUkKgndemLDo1D/YdoNUbEh3GCuT+ZD63mCkMndwURGm3pN+w39RyTCqNduQBJEvufJtMHpNofGvXEh+Ghb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783011066; c=relaxed/simple;
	bh=zIY6XVUDJeys747uI2xkS3WYkofOnofJyfi5ePfobWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mgLU3J/rfmutf3sfbr0yI8FqxauYJoiZb7LF6QNNP9CUZAAANN3Tk60kIS5nCvf0/SiMMXer1LteJ5AVJo2KPlGP4+OFrQHzlBNh7VgtXo/5XNF32DtQvcUBIjzLW8FMVq13t8qDluGxNCe5E649biDboepm9s+0BrhqHuC1NOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=toC3WmC/; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5D511F000E9;
	Thu,  2 Jul 2026 16:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783011065;
	bh=AWnXchYFLkn8fLCp4Ptasq7BF3SDsrGLR+JNg+Xu3uM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=toC3WmC/peQqSJAziHfgWwdahfIYeVJhnQjqA3pjE2Ft6zoFQ+ZYuSGjnHQ0N4e5e
	 0JlQXYfG3/ESdinDY4oXI/h7ELtlNg3bVT7TlI0ppxbmh4Pxp7YdbhOnq3p/t06w2o
	 c+VVhv8A0rKsUK5ahq3NlJXjczyKD0da2IaGczF8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable@kernel.org,
	Sven Eckelmann <sven@narfation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 099/175] batman-adv: bla: annotate lasttime access with READ/WRITE_ONCE
Date: Thu,  2 Jul 2026 18:20:00 +0200
Message-ID: <20260702155117.857371614@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702155115.766838875@linuxfoundation.org>
References: <20260702155115.766838875@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-271254-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[narfation.org:email,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DC3946FB28B

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sven Eckelmann <sven@narfation.org>

commit 98b0fb191c878a64cbaebfe231d96d57576acf8c upstream.

The lasttime field for claim, backbone_gw, and loopdetect tracks the
jiffies value of the most recent activity and is used to detect timeouts.
These accesses are not consistently protected by a lock, so
READ_ONCE/WRITE_ONCE must be used to prevent data races caused by compiler
optimizations.

Cc: stable@kernel.org
Fixes: 23721387c409 ("batman-adv: add basic bridge loop avoidance code")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/batman-adv/bridge_loop_avoidance.c | 28 +++++++++++++-------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index cfb1eb25c6ac4d..ac12c06f11b89e 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -512,7 +512,7 @@ batadv_bla_get_backbone_gw(struct batadv_priv *bat_priv, const u8 *orig,
 		return NULL;
 
 	entry->vid = vid;
-	entry->lasttime = jiffies;
+	WRITE_ONCE(entry->lasttime, jiffies);
 	entry->crc = BATADV_BLA_CRC_INIT;
 	entry->bat_priv = bat_priv;
 	spin_lock_init(&entry->crc_lock);
@@ -580,7 +580,7 @@ batadv_bla_update_own_backbone_gw(struct batadv_priv *bat_priv,
 	if (unlikely(!backbone_gw))
 		return;
 
-	backbone_gw->lasttime = jiffies;
+	WRITE_ONCE(backbone_gw->lasttime, jiffies);
 	batadv_backbone_gw_put(backbone_gw);
 }
 
@@ -714,7 +714,7 @@ static void batadv_bla_add_claim(struct batadv_priv *bat_priv,
 		ether_addr_copy(claim->addr, mac);
 		spin_lock_init(&claim->backbone_lock);
 		claim->vid = vid;
-		claim->lasttime = jiffies;
+		WRITE_ONCE(claim->lasttime, jiffies);
 		kref_get(&backbone_gw->refcount);
 		claim->backbone_gw = backbone_gw;
 		kref_init(&claim->refcount);
@@ -736,7 +736,7 @@ static void batadv_bla_add_claim(struct batadv_priv *bat_priv,
 			return;
 		}
 	} else {
-		claim->lasttime = jiffies;
+		WRITE_ONCE(claim->lasttime, jiffies);
 		if (claim->backbone_gw == backbone_gw)
 			/* no need to register a new backbone */
 			goto claim_free_ref;
@@ -769,7 +769,7 @@ static void batadv_bla_add_claim(struct batadv_priv *bat_priv,
 	spin_lock_bh(&backbone_gw->crc_lock);
 	backbone_gw->crc ^= crc16(0, claim->addr, ETH_ALEN);
 	spin_unlock_bh(&backbone_gw->crc_lock);
-	backbone_gw->lasttime = jiffies;
+	WRITE_ONCE(backbone_gw->lasttime, jiffies);
 
 claim_free_ref:
 	batadv_claim_put(claim);
@@ -858,7 +858,7 @@ static bool batadv_handle_announce(struct batadv_priv *bat_priv, u8 *an_addr,
 		return true;
 
 	/* handle as ANNOUNCE frame */
-	backbone_gw->lasttime = jiffies;
+	WRITE_ONCE(backbone_gw->lasttime, jiffies);
 	crc = ntohs(*((__force __be16 *)(&an_addr[4])));
 
 	batadv_dbg(BATADV_DBG_BLA, bat_priv,
@@ -1253,7 +1253,7 @@ static void batadv_bla_purge_backbone_gw(struct batadv_priv *bat_priv, int now)
 						  head, hash_entry) {
 				if (now)
 					goto purge_now;
-				if (!batadv_has_timed_out(backbone_gw->lasttime,
+				if (!batadv_has_timed_out(READ_ONCE(backbone_gw->lasttime),
 							  BATADV_BLA_BACKBONE_TIMEOUT))
 					continue;
 
@@ -1334,7 +1334,7 @@ static void batadv_bla_purge_claims(struct batadv_priv *bat_priv,
 						primary_if->net_dev->dev_addr))
 				goto skip;
 
-			if (!batadv_has_timed_out(claim->lasttime,
+			if (!batadv_has_timed_out(READ_ONCE(claim->lasttime),
 						  BATADV_BLA_CLAIM_TIMEOUT))
 				goto skip;
 
@@ -1494,7 +1494,7 @@ static void batadv_bla_periodic_work(struct work_struct *work)
 		eth_random_addr(bat_priv->bla.loopdetect_addr);
 		bat_priv->bla.loopdetect_addr[0] = 0xba;
 		bat_priv->bla.loopdetect_addr[1] = 0xbe;
-		bat_priv->bla.loopdetect_lasttime = jiffies;
+		WRITE_ONCE(bat_priv->bla.loopdetect_lasttime, jiffies);
 		atomic_set(&bat_priv->bla.loopdetect_next,
 			   BATADV_BLA_LOOPDETECT_PERIODS);
 
@@ -1515,7 +1515,7 @@ static void batadv_bla_periodic_work(struct work_struct *work)
 						primary_if->net_dev->dev_addr))
 				continue;
 
-			backbone_gw->lasttime = jiffies;
+			WRITE_ONCE(backbone_gw->lasttime, jiffies);
 
 			batadv_bla_send_announce(bat_priv, backbone_gw);
 			if (send_loopdetect)
@@ -1900,7 +1900,7 @@ batadv_bla_loopdetect_check(struct batadv_priv *bat_priv, struct sk_buff *skb,
 	/* If the packet came too late, don't forward it on the mesh
 	 * but don't consider that as loop. It might be a coincidence.
 	 */
-	if (batadv_has_timed_out(bat_priv->bla.loopdetect_lasttime,
+	if (batadv_has_timed_out(READ_ONCE(bat_priv->bla.loopdetect_lasttime),
 				 BATADV_BLA_LOOPDETECT_TIMEOUT))
 		return true;
 
@@ -2016,7 +2016,7 @@ bool batadv_bla_rx(struct batadv_priv *bat_priv, struct sk_buff *skb,
 
 	if (own_claim) {
 		/* ... allow it in any case */
-		claim->lasttime = jiffies;
+		WRITE_ONCE(claim->lasttime, jiffies);
 		goto allow;
 	}
 
@@ -2118,7 +2118,7 @@ bool batadv_bla_tx(struct batadv_priv *bat_priv, struct sk_buff *skb,
 		/* if yes, the client has roamed and we have
 		 * to unclaim it.
 		 */
-		if (batadv_has_timed_out(claim->lasttime, 100)) {
+		if (batadv_has_timed_out(READ_ONCE(claim->lasttime), 100)) {
 			/* only unclaim if the last claim entry is
 			 * older than 100 ms to make sure we really
 			 * have a roaming client here.
@@ -2372,7 +2372,7 @@ batadv_bla_backbone_dump_entry(struct sk_buff *msg, u32 portid,
 	backbone_crc = backbone_gw->crc;
 	spin_unlock_bh(&backbone_gw->crc_lock);
 
-	msecs = jiffies_to_msecs(jiffies - backbone_gw->lasttime);
+	msecs = jiffies_to_msecs(jiffies - READ_ONCE(backbone_gw->lasttime));
 
 	if (is_own)
 		if (nla_put_flag(msg, BATADV_ATTR_BLA_OWN)) {
-- 
2.53.0




