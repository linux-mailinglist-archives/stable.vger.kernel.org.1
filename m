Return-Path: <stable+bounces-247711-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0FQ2Io8NB2oLrAIAu9opvQ
	(envelope-from <stable+bounces-247711-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 14:11:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB5554F381
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 14:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F27583194AD6
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 11:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D3443E4AE;
	Fri, 15 May 2026 11:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="xSAq2oxF"
X-Original-To: stable@vger.kernel.org
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685FB44BCB5
	for <stable@vger.kernel.org>; Fri, 15 May 2026 11:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778846161; cv=none; b=frn6WukQpD284jYESPyruOr6M5AeGjPWmsMi3g3H6tiN0DjCwLxU8Ac6D4MOLKYR15aWT2zH6TS2GMvumx0v4A2vYRQ98Vnf6FWaCUn86XNicGJ8Vsmh5r7D8r7WDhVW/glvsL5/JeLcWJwysqUkw7hTh4XVeWGx6YqyrLCsq0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778846161; c=relaxed/simple;
	bh=KWfISSJMcZqzH4lc92p5Upb0U5S5zTl5Y0uUzPxMm7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KZJYcO/fBz4ont1dnTa69xZ3s5AJRIhJarPCUhzVjcayMfnWv1bxlstyCzOjHjVrEw2VgrExT+H7lbbAFOk5+M+/ots7h0DzyIFBIc/3Fxs+9lgaFZRFpAzBbwsFmfwBI+ZF+rGym9ie6ZBZLelT0eZvLpz6a+t1gU8aHm3p47E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=xSAq2oxF; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Received: by dvalin.narfation.org (Postfix) id 6EEA120059;
	Fri, 15 May 2026 11:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1778846158;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dxcHQTDizHQ35SCjII9xxJcB3SdFew+JGc9QAOoue8I=;
	b=xSAq2oxFDMHmgM13cDMdhNbOKM8QoU5UvW/x5njBfWMl7Q4N7nNJHMbSZTVfbv6Um+MujA
	ExcHBC85Lx5fack24/JUQCOTWY4I/PDwi1TZDBGEmno6LYulZbXYBOfzwDwHNvZfDxA54X
	kXfP/KCBexgxaoai6p6AaSmf0/kzzZQ=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>,
	stable@kernel.org
Subject: [PATCH 5.15.y] batman-adv: tp_meter: fix tp_num leak on kmalloc failure
Date: Fri, 15 May 2026 13:55:53 +0200
Message-ID: <20260515115553.542876-1-sven@narfation.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026051520-serve-zit-cadd@gregkh>
References: <2026051520-serve-zit-cadd@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1DB5554F381
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-247711-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sven@narfation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[narfation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
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
index 56b9fe97b3b4..0eb9eccfc1e8 100644
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


