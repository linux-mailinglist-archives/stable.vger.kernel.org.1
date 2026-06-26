Return-Path: <stable+bounces-269212-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HugpIoupPmqUJwkAu9opvQ
	(envelope-from <stable+bounces-269212-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 18:32:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B776CF1C1
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 18:32:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=narfation.org header.s=20121 header.b=ZAXydP7h;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269212-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-269212-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=narfation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A8163270CAA
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 16:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAFE1403AF4;
	Fri, 26 Jun 2026 16:12:54 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB27E403B0D
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 16:12:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782490374; cv=none; b=hZPmTnlgYBCOLZox5owVKqrrla5S1gG0nVsf3k4woaZs/J3iqKKXka+/kCXmUgL0NlYGyQ7t2PTqJ4a0XnxgVHBrUaSUflvU0GqanHKqpa94TBd8Izu4lKkDarprTg8m2ARVNTQjWGncYI7dunSxSqw4kAkxBrJ1XP+y/dP40ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782490374; c=relaxed/simple;
	bh=AVBnUsvppe1nl3U+wKR4KaDwfr9ajUCmH5foOd/d08Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bSzSyKnhG/d8sdlXDCSLN4B/FxooYV2VRzYz08LD2LEnHIksTaoxLJoDO2MGVXFVq5FdfNnVDzK6R2yP5QEupKit+mGKF+04qea+WfqAbkRRyGB/RwtnXGTkklcA4PJV4N5hj1bojGGHRWdRtpGMhYCC5s/OR1C1ozWf00Wu/sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=ZAXydP7h; arc=none smtp.client-ip=213.160.73.56
Received: by dvalin.narfation.org (Postfix) id 12332202D1;
	Fri, 26 Jun 2026 16:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1782490368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2+LUyL2is44G0RqZTxGaJmna5RtNBKr4/nOs5HPtErc=;
	b=ZAXydP7hUHtlW6YTPH5Hgfj8bWAQ4CC7I/TZxnnsYqEEXxUEn5HrFuFKJ4SAvHDF4u+bzx
	rXbuACSNoqKI1ZPzUnsEe8vsTALAeS5OdMCpLws9WWsBqpw3cMwBXO9LAdKEuBY+fa2Jyv
	I0R14lx+JGrut4lo76b+C9cL/tY2Seo=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 7.1 12/26] batman-adv: gw: don't deselect gateway with active hardif
Date: Fri, 26 Jun 2026 18:12:27 +0200
Message-ID: <20260626161241.124988-13-sven@narfation.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260626161241.124988-1-sven@narfation.org>
References: <20260626161241.124988-1-sven@narfation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[narfation.org:s=20121];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269212-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,narfation.org:dkim,narfation.org:email,narfation.org:mid,narfation.org:from_mime,vger.kernel.org:from_smtp,universe-factory.net:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 58B776CF1C1

commit df97a7107b16375a10a36d7a63e9b4291a8ac680 upstream.

The batadv_hardif_cnt() was previously checking if there is an
batadv_hard_iface->mesh_iface which is has the same mesh_iface. And since
batadv_hardif_disable_interface() was resetting the
batadv_hard_iface->mesh_iface after this check, it had to verify whether
*1* interface was still part of the mesh_iface before it started the
gateway deselection.

But after batadv_hardif_cnt() is now checking the lower interfaces of
mesh_iface and batadv_hardif_disable_interface() already removed the
interface via netdev_upper_dev_unlink() earlier in this function, the check
must now make sure that *0* interfaces can be found by batadv_hardif_cnt()
before selected gateway must be deselected. Otherwise the deselection would
already happen one batadv_hard_iface too early.

Because a 0 hardif count from batadv_hardif_cnt() is equal to an empty
list, it is possible to replace the counting with a simple list_empty().

Cc: stable@kernel.org
Fixes: 7dc284702bcd ("batman-adv: store hard_iface as iflink private data")
Reviewed-by: Nora Schiffer <neocturne@universe-factory.net>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/hard-interface.c | 28 ++--------------------------
 1 file changed, 2 insertions(+), 26 deletions(-)

diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index d6732c34aeafc..c7dbd24ea1998 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -786,30 +786,6 @@ int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
 	return ret;
 }
 
-/**
- * batadv_hardif_cnt() - get number of interfaces enslaved to mesh interface
- * @mesh_iface: mesh interface to check
- *
- * This function is only using RCU for locking - the result can therefore be
- * off when another function is modifying the list at the same time. The
- * caller can use the rtnl_lock to make sure that the count is accurate.
- *
- * Return: number of connected/enslaved hard interfaces
- */
-static size_t batadv_hardif_cnt(struct net_device *mesh_iface)
-{
-	struct batadv_hard_iface *hard_iface;
-	struct list_head *iter;
-	size_t count = 0;
-
-	rcu_read_lock();
-	netdev_for_each_lower_private_rcu(mesh_iface, hard_iface, iter)
-		count++;
-	rcu_read_unlock();
-
-	return count;
-}
-
 /**
  * batadv_hardif_disable_interface() - Remove hard interface from mesh interface
  * @hard_iface: hard interface to be removed
@@ -850,8 +826,8 @@ void batadv_hardif_disable_interface(struct batadv_hard_iface *hard_iface)
 	netdev_upper_dev_unlink(hard_iface->net_dev, hard_iface->mesh_iface);
 	batadv_hardif_recalc_extra_skbroom(hard_iface->mesh_iface);
 
-	/* nobody uses this interface anymore */
-	if (batadv_hardif_cnt(hard_iface->mesh_iface) <= 1)
+	/* nobody uses this mesh interface anymore */
+	if (list_empty(&hard_iface->mesh_iface->adj_list.lower))
 		batadv_gw_check_client_stop(bat_priv);
 
 	hard_iface->mesh_iface = NULL;
-- 
2.47.3


