Return-Path: <stable+bounces-256754-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPDTFPbtGWrlzwgAu9opvQ
	(envelope-from <stable+bounces-256754-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 21:50:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5445B607FE7
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 21:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1021A3025C7A
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 19:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9A73A8744;
	Fri, 29 May 2026 19:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="VlLkpmBv"
X-Original-To: stable@vger.kernel.org
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F312723395E
	for <stable@vger.kernel.org>; Fri, 29 May 2026 19:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780084204; cv=none; b=UHuab7PbO9FbpN6QAtgeu4wLMZoTTKBpw0s7TjCsDNn4ZcHX7N25ULRgWEt/w32XcHB8fG8Bqf14ScA92KMqdqGnVRQyRgKwnmtdkJY1bjujk1gbOlvMJVwad4nZdXqhXZiSLoeAk97Wu6frZMDnBGqAQY7P8ExGpy6TfemeBjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780084204; c=relaxed/simple;
	bh=df13bFRz8zpZjKDFSu0QlUnlFw9HrlknsUkA7oZ3km4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SQ85Pn/S1ynCxVldp7qY15ZWN6X5aHLZAkNFBnhi6AUVlEAZdxN7ue57Ob1pndKBdLqRgjyiTx7sZT4qwmEn39uStseIRR/RPn9imRDzyokxGAEP3XqWZXJIOgRiRt4rSaf+r4pDvVDLQq1TKSWi7PB4dTqQYqCW36DD/HHcfpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=VlLkpmBv; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Received: by dvalin.narfation.org (Postfix) id 173F920059;
	Fri, 29 May 2026 19:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1780084201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k+yoRdxcEOu8JA/RbA8dGuvbkivvJ1waJgIgNWdUQds=;
	b=VlLkpmBv03ElpagjMEcdONFQYSH6k+May6c5WI3KJPjfUyPrY4pIRf23fpzoY0c+zTZtK0
	VOFsu+Tvcx+ZIKzJ+h5VAbggSrZ+20G5gnoNmOy7GZTpHeRlVzK3rrAKh/SYIOPeTTjzri
	FjWLAMt9LuB69gBFOLLJH5kyMf3yhxc=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>,
	stable@kernel.org
Subject: [PATCH 6.1.y 1/2] batman-adv: tp_meter: fix tp_vars reference leak in receiver shutdown
Date: Fri, 29 May 2026 21:49:07 +0200
Message-ID: <20260529194908.473287-1-sven@narfation.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026052833-easing-gerbil-ae19@gregkh>
References: <2026052833-easing-gerbil-ae19@gregkh>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[narfation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[narfation.org:s=20121];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256754-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[narfation.org:email,narfation.org:mid,narfation.org:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 5445B607FE7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

commit 77098e4bea37af51d3962efa88a5af2ea5e1ac57 upstream.

The receiver shutdown timer handler, batadv_tp_receiver_shutdown(), is
responsible for releasing the tp_vars reference it holds. However, the
existing logic for coordinating this release with batadv_tp_stop_all() was
flawed.

timer_shutdown_sync() guarantees the timer will not fire again after it
returns, but it returns non-zero only when the timer was pending at the
time of the call. If the timer had already expired (and
batadv_tp_stop_all() would unsucessfully try to  rearm itself),
batadv_tp_stop_all() skips its batadv_tp_vars_put(), and
batadv_tp_receiver_shutdown() fails to put its own reference as well.

Fix this by introducing a new atomic variable receiving that is set to 1
when the receiver is initialized and cleared atomically with atomic_xchg()
by whichever side claims it first. Only the side that observes the
transition from 1 to 0 is responsible for releasing the tp_vars timer
reference, eliminating the uncertainty.

Cc: stable@kernel.org
Fixes: 3d3cf6a7314a ("batman-adv: stop tp_meter sessions during mesh teardown")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/tp_meter.c | 13 +++++++++++--
 net/batman-adv/types.h    |  3 +++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index 72652894e9d78..6cb1820fa4a4a 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -8,6 +8,7 @@
 #include "main.h"
 
 #include <linux/atomic.h>
+#include <linux/bug.h>
 #include <linux/build_bug.h>
 #include <linux/byteorder/generic.h>
 #include <linux/cache.h>
@@ -1157,6 +1158,9 @@ static void batadv_tp_receiver_shutdown(struct timer_list *t)
 	spin_unlock_bh(&tp_vars->unacked_lock);
 
 	/* drop reference of timer */
+	if (WARN_ON(atomic_xchg(&tp_vars->receiving, 0) != 1))
+		return;
+
 	batadv_tp_vars_put(tp_vars);
 }
 
@@ -1375,6 +1379,7 @@ batadv_tp_init_recv(struct batadv_priv *bat_priv,
 
 	ether_addr_copy(tp_vars->other_end, icmp->orig);
 	tp_vars->role = BATADV_TP_RECEIVER;
+	atomic_set(&tp_vars->receiving, 1);
 	memcpy(tp_vars->session, icmp->session, sizeof(tp_vars->session));
 	tp_vars->last_recv = BATADV_TP_FIRST_SEQ;
 	tp_vars->bat_priv = bat_priv;
@@ -1547,8 +1552,12 @@ void batadv_tp_stop_all(struct batadv_priv *bat_priv)
 			break;
 		case BATADV_TP_RECEIVER:
 			batadv_tp_list_detach(tp_var);
-			if (timer_shutdown_sync(&tp_var->timer))
-				batadv_tp_vars_put(tp_var);
+			timer_shutdown_sync(&tp_var->timer);
+
+			if (atomic_xchg(&tp_var->receiving, 0) != 1)
+				break;
+
+			batadv_tp_vars_put(tp_var);
 			break;
 		}
 
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index d755377b573c2..7ee337d72ebb0 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1391,6 +1391,9 @@ struct batadv_tp_vars {
 	/** @sending: sending binary semaphore: 1 if sending, 0 is not */
 	atomic_t sending;
 
+	/** @receiving: receiving binary semaphore: 1 if receiving, 0 is not */
+	atomic_t receiving;
+
 	/** @reason: reason for a stopped session */
 	enum batadv_tp_meter_reason reason;
 
-- 
2.47.3


