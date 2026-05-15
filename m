Return-Path: <stable+bounces-247676-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IKptDs4PB2qbrAIAu9opvQ
	(envelope-from <stable+bounces-247676-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 14:21:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FFD854F5EE
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 14:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D45F307163F
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 11:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D290347A0DB;
	Fri, 15 May 2026 11:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="UP1A7nS2"
X-Original-To: stable@vger.kernel.org
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC9D396B73
	for <stable@vger.kernel.org>; Fri, 15 May 2026 11:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778845475; cv=none; b=gpk+FocXmTdPelnaCwv9Yu2xmUvZ+NH1sSi0JzyNqnKRx/wXlkU2kmw/W5nAt9cOrWye7o1VzYxNh+rXMqyyIHNd+YAtOFONwtUCH/LDxafq9MzuwTzbbEjR1VBh9Di16rk7LE6kZo+bTpMxYMTDw1vifaxgbKmSz4CMeb4ChiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778845475; c=relaxed/simple;
	bh=VNgv9OG7XWYg5yaYaH6o3ZmpMs14i9y6v+YvtRJsevQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BvEtWGQwB4Wt8vvRhIvzjhm01FvioMb40isBZQmM88eRAY7TgITvzIbHpLJfmf/8sg6E1pD+YqqXKKPbEBp/D0uQizUaUtoItnG5pMnQPe6D1vLPXl5Zi9lbOmLMIHZMC5cP1am6B/q+PJaDu0VE6n2Iob5NlYSi1AEO+rVFpYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=UP1A7nS2; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Received: by dvalin.narfation.org (Postfix) id 9D42F21550;
	Fri, 15 May 2026 11:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1778845472;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8XT5W4XTEK1qO2DYnzfWxWMDfpkNHVre27GD+ik3kps=;
	b=UP1A7nS210g2+WKE4PRSAPd1zmSCLW8Lw6QWOISBxJeljU9Nv7eGqi1gnvtmWdih84c6WS
	WqhamUFu2OSQhgceEc9EIfBG1NXyEy1ITYPlo6cbRHjydZk2WkhagK/5gGIGtffjmnYfm7
	zDkiJUE1AkE63NrG1CT5yXPZk0CGnyA=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>,
	stable@kernel.org
Subject: [PATCH 6.18.y] batman-adv: tp_meter: fix tp_num leak on kmalloc failure
Date: Fri, 15 May 2026 13:44:28 +0200
Message-ID: <20260515114428.385372-1-sven@narfation.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026051519-award-matron-543d@gregkh>
References: <2026051519-award-matron-543d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7FFD854F5EE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[narfation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[narfation.org:s=20121];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-247676-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[narfation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sven@narfation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

commit ce425dd05d0fe7594930a0fb103634f35ac47bb6 upstream.

When batadv_tp_start() or batadv_tp_init_recv() fail to allocate a new
tp_vars object, the previously incremented bat_priv->tp_num counter is
never decremented. This causes tp_num to drift upward on each allocation
failure. Since only BATADV_TP_MAX_NUM sessions can be started and the count
is never reduced for these failed allocations, it causes to an exhaustion
of throughput meter sessions. In worst case, no new throughput meter
session can be started until the mesh interface is removed.

The error handling must decrement tp_num releasing the lock and aborting
the creation of an throughput meter session

Cc: stable@kernel.org
Fixes: 33a3bb4a3345 ("batman-adv: throughput meter implementation")
[ Context ]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/tp_meter.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index 350b149e48be..0ae7887ff2db 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -969,6 +969,7 @@ void batadv_tp_start(struct batadv_priv *bat_priv, const u8 *dst,
 
 	tp_vars = kmalloc(sizeof(*tp_vars), GFP_ATOMIC);
 	if (!tp_vars) {
+		atomic_dec(&bat_priv->tp_num);
 		spin_unlock_bh(&bat_priv->tp_list_lock);
 		batadv_dbg(BATADV_DBG_TP_METER, bat_priv,
 			   "Meter: %s cannot allocate list elements\n",
@@ -1344,8 +1345,10 @@ batadv_tp_init_recv(struct batadv_priv *bat_priv,
 	}
 
 	tp_vars = kmalloc(sizeof(*tp_vars), GFP_ATOMIC);
-	if (!tp_vars)
+	if (!tp_vars) {
+		atomic_dec(&bat_priv->tp_num);
 		goto out_unlock;
+	}
 
 	ether_addr_copy(tp_vars->other_end, icmp->orig);
 	tp_vars->role = BATADV_TP_RECEIVER;
-- 
2.47.3


