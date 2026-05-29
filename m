Return-Path: <stable+bounces-256766-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qDLUGYDzGWp/0AgAu9opvQ
	(envelope-from <stable+bounces-256766-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 22:13:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 151D260855F
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 22:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4CEA9305C518
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 20:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0232540961D;
	Fri, 29 May 2026 20:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="CFP5F4gQ"
X-Original-To: stable@vger.kernel.org
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C214014BB
	for <stable@vger.kernel.org>; Fri, 29 May 2026 20:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780085193; cv=none; b=uYRhh19FlL/mnhDEEQg66wyekXpOX3VQhc7M3bGS14c2dKVQ8eLYCJPEBYF5eTwRM0crKuTp+/DWq1QKeIA8cPCJxs3exITZTWNtiTbVgxt+/DJa5wT17IreZ4aFMVXFBJ4pun19TpZPtZlbxW/3oSBvRX9GSs1ipxOAHCnQA80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780085193; c=relaxed/simple;
	bh=sMW7URACETjBQKLLCpI4UCRbvtgLrVnlftGVV6PXgTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lNiugUnEsTXdFayTrfy6fdIxCQLkMJJ8Eoxz54AM4K+dUScMdujNxCu5lK9dBGsQoPE5K78GXjrVuRZb7a/qKdQWytiRpyQMMYOi1nmxNkZpcQSQvFjVecQ4+1Ea4IdwCdhR69+wlM8tJafeYCHncMS1Hp2a6qx19+Fsqg+/uKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=CFP5F4gQ; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Received: by dvalin.narfation.org (Postfix) id 9B75D20059;
	Fri, 29 May 2026 20:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1780085190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eRZSMLtlwuMAC2FklXZ9oc+wVsW/1222agDUWPUMhsw=;
	b=CFP5F4gQLnDWd0gUW8LJBjKY9tOz2izNydMVaMGbqqHBOKlxbOMt9UO9Hu6DCuqqh46XkW
	x+tounIM5EeSnV2vZHIg5fb+hK+SdbvjPhZzP8+S4Zs/VudSOeBwye6bWx6QMMVCeZk/86
	aLEMqZ7KggHh5B0vH8SD9Kr54e1QX7w=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>,
	stable@kernel.org
Subject: [PATCH 5.15.y 1/2] batman-adv: tp_meter: fix tp_vars reference leak in receiver shutdown
Date: Fri, 29 May 2026 22:06:00 +0200
Message-ID: <20260529200601.477663-1-sven@narfation.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026052834-cleat-culprit-4b87@gregkh>
References: <2026052834-cleat-culprit-4b87@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[narfation.org:s=20121];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256766-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,narfation.org:email,narfation.org:mid,narfation.org:dkim]
X-Rspamd-Queue-Id: 151D260855F
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
index e1ab239bc0e0e..2160ef46df1bb 100644
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
index f20ab9cade18b..9efc5bbeca1e0 100644
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


