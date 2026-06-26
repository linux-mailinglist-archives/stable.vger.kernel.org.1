Return-Path: <stable+bounces-269166-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9tu5GI6nPmrsJgkAu9opvQ
	(envelope-from <stable+bounces-269166-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 18:23:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 135976CEF97
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 18:23:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=narfation.org header.s=20121 header.b=A8QagHnZ;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269166-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-269166-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=narfation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 09EB2313BBBA
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 16:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8FE402430;
	Fri, 26 Jun 2026 16:12:28 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027654014A1
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 16:12:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782490347; cv=none; b=ktCOTDYab0ByXZv1TuKUbFUR8gqzSqF5GQPY7leHihL2FoHrORVo8m8DxpVftC7VXxpf4jM/wuWWtvEM/kppAQ7DMIQZKEIb1u4aG+wnJNzEbDIC2IrhjmtNgPNcuK1JQTZVxAZZPtjZvB3XT6RUmzQ7oxEsqeLitVWnsVgyLlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782490347; c=relaxed/simple;
	bh=IhGr1Urjh2zeY6GxLIf/Cj8hEzQjEGhcbIeDlu/nbfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I89ardEHvo2wrozCOV2YMgp4Wt/XhBTCnrKnqv56tEb1A/uRYxgjt/nQps/jbwImSre9TYkRntiyUvHk0+fksI6mmjsRKadOM9Pdt1YIWePyzvDF1pF55BBL/X/Rt1q+WuSjM1w7OWmmMyMlvCQyr089IEv+4LaTHS+9sZHQSKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=A8QagHnZ; arc=none smtp.client-ip=213.160.73.56
Received: by dvalin.narfation.org (Postfix) id 441782045E;
	Fri, 26 Jun 2026 16:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1782490341;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NZ8uq1CecCQDMRO2uxtaCX3IvuF52vn+dSbi27x+whw=;
	b=A8QagHnZnHEwSvVF/5dqdbiQWqai48xgM11lmXxGp0YxY2WeXq2U851tTCAy0L/KKz1Ea0
	r/OBTj/fP6D2jR4syh7szWY5ih/hEco63kfz1jQtaoNJKdiC0/fb1iWz4+Qsdo7kuG0zM4
	JLynYpLCOCElwLO5yvowOHWPHR7lWFo=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 6.18 23/26] batman-adv: tt: track roam count per VID
Date: Fri, 26 Jun 2026 18:12:07 +0200
Message-ID: <20260626161210.124712-24-sven@narfation.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260626161210.124712-1-sven@narfation.org>
References: <20260626161210.124712-1-sven@narfation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[narfation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[narfation.org:s=20121];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269166-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sven@narfation.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sven@narfation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sven@narfation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[narfation.org:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,narfation.org:dkim,narfation.org:email,narfation.org:mid,narfation.org:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 135976CEF97

commit 12407d5f61c2653a64f2ff4b22f3c267f8420ef1 upstream.

batadv_tt_check_roam_count() is supposed to track roaming of a TT entry.
But TT entries are for a MAC + VID. The VID was completely missed and thus
leads to incorrect detection of ROAM counts when a client MAC exists in
multiple VLANs.

Cc: stable@kernel.org
Fixes: c018ad3de61a ("batman-adv: add the VLAN ID attribute to the TT entry")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 9 +++++++--
 net/batman-adv/types.h             | 3 +++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index acd8af4446671..83dfd804a143a 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -3442,6 +3442,7 @@ static void batadv_tt_roam_purge(struct batadv_priv *bat_priv)
  * batadv_tt_check_roam_count() - check if a client has roamed too frequently
  * @bat_priv: the bat priv with all the mesh interface information
  * @client: mac address of the roaming client
+ * @vid: VLAN identifier
  *
  * This function checks whether the client already reached the
  * maximum number of possible roaming phases. In this case the ROAMING_ADV
@@ -3449,7 +3450,7 @@ static void batadv_tt_roam_purge(struct batadv_priv *bat_priv)
  *
  * Return: true if the ROAMING_ADV can be sent, false otherwise
  */
-static bool batadv_tt_check_roam_count(struct batadv_priv *bat_priv, u8 *client)
+static bool batadv_tt_check_roam_count(struct batadv_priv *bat_priv, u8 *client, u16 vid)
 {
 	struct batadv_tt_roam_node *tt_roam_node;
 	bool ret = false;
@@ -3462,6 +3463,9 @@ static bool batadv_tt_check_roam_count(struct batadv_priv *bat_priv, u8 *client)
 		if (!batadv_compare_eth(tt_roam_node->addr, client))
 			continue;
 
+		if (tt_roam_node->vid != vid)
+			continue;
+
 		if (batadv_has_timed_out(tt_roam_node->first_time,
 					 BATADV_ROAMING_MAX_TIME))
 			continue;
@@ -3483,6 +3487,7 @@ static bool batadv_tt_check_roam_count(struct batadv_priv *bat_priv, u8 *client)
 		atomic_set(&tt_roam_node->counter,
 			   BATADV_ROAMING_MAX_COUNT - 1);
 		ether_addr_copy(tt_roam_node->addr, client);
+		tt_roam_node->vid = vid;
 
 		list_add(&tt_roam_node->list, &bat_priv->tt.roam_list);
 		ret = true;
@@ -3519,7 +3524,7 @@ static void batadv_send_roam_adv(struct batadv_priv *bat_priv, u8 *client,
 	/* before going on we have to check whether the client has
 	 * already roamed to us too many times
 	 */
-	if (!batadv_tt_check_roam_count(bat_priv, client))
+	if (!batadv_tt_check_roam_count(bat_priv, client, vid))
 		goto out;
 
 	batadv_dbg(BATADV_DBG_TT, bat_priv,
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 84de2570eac3e..ef712ba4fff2c 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1912,6 +1912,9 @@ struct batadv_tt_roam_node {
 	/** @addr: mac address of the client in the roaming phase */
 	u8 addr[ETH_ALEN];
 
+	/** @vid: VLAN identifier */
+	u16 vid;
+
 	/**
 	 * @counter: number of allowed roaming events per client within a single
 	 * OGM interval (changes are committed with each OGM)
-- 
2.47.3


