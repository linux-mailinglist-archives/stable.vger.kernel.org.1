Return-Path: <stable+bounces-255766-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eHtuApikGGoQlwgAu9opvQ
	(envelope-from <stable+bounces-255766-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:24:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC855F89EF
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5827430601E6
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C512E7379;
	Thu, 28 May 2026 20:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="g2ec8Gsi"
X-Original-To: stable@vger.kernel.org
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0E53101B0
	for <stable@vger.kernel.org>; Thu, 28 May 2026 20:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779999822; cv=none; b=qK00khoHFIeN6b0g/qUgZK09is8AMu3A+QiBRNKRbKT+n80iKo23Jx2Fs3ywNa9huOqd72WW69TrZMmFDpVz9p/B2FMwQSHJG4rPl5pFqF4VNPP20KqfR7tWXf9I/Tj+ANpUXlT53Q8BZhjtwELfwvIrC1eJQpqwTmL2TPy5TBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779999822; c=relaxed/simple;
	bh=PjPpx/ADezrs9ZSqZcxiSc/iaIXYfrygE2MNvlVdBSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SjK3cB4BeLEEoCPhJr6VxVnOs34FxWQKD0sYh4odwfHQuq0nTPDU/CW21inyCyEeWHabKXlbsqunVOsdXdPKIsD3MzZG7FnebyDTEMh5zyX++0bToK2oogtwrgUN5nC+JlUJEFzxj4ZsHolCdynaXqPSkZt2x7+UqBDYCAVVYSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=g2ec8Gsi; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Received: by dvalin.narfation.org (Postfix) id ED79220074;
	Thu, 28 May 2026 20:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1779999820;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qhbgXyq7XNLh0gTPq6SUFs02TK9v74UELx5dX57oqR4=;
	b=g2ec8GsiDfDRqpjLQrYtHQC8S9W/SYanSSCzu0u5cKSIvoRbO2reN5vhFtS0taw2cJqf72
	uH9881/3H44/CJvuW8XBq2g5ExvC25EzPJYAo55mJjTt7y9VM67gUhGdyZinP/pBOgzSIz
	APs071PPpOrni88KF0clEL31py+NW+M=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>,
	stable@kernel.org
Subject: [PATCH 6.6.y] batman-adv: tp_meter: directly shut down timer on cleanup
Date: Thu, 28 May 2026 22:23:16 +0200
Message-ID: <20260528202316.468806-1-sven@narfation.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026052842-auction-seducing-6981@gregkh>
References: <2026052842-auction-seducing-6981@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[narfation.org:s=20121];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255766-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[narfation.org:email,narfation.org:mid,narfation.org:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: CDC855F89EF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

commit d5487249a81ea658717614009c8f46acc5b7101a upstream.

batadv_tp_sender_cleanup() was calling timer_delete_sync() followed by
timer_delete() to guard against the timer handler re-arming itself between
the two calls. This double-deletion hack relied on the sending status being
set to 0 to suppress re-arming.

Replace both calls with a single timer_shutdown_sync(). This function both
waits for any running timer callback to complete (like timer_delete_sync())
and permanently disarms the timer so it cannot be re-armed afterwards,
making re-arming prevention unconditional and self-documenting.

The re-arming property is also required because otherwise:

1. context 0 (batadv_tp_recv_ack()) checks in
   batadv_tp_reset_sender_timer() if sending is still 1 -> it is
2. context 1 changes in batadv_tp_sender_shutdown() sending to 0 and in
   this process forces the kthread to stop timer in
   batadv_tp_sender_cleanup()
3. context 0 continues in batadv_tp_reset_sender_timer() and rearms the
   timer -> but the reference for it is already gone

Cc: stable@kernel.org
Fixes: 33a3bb4a3345 ("batman-adv: throughput meter implementation")
[ adapt pre-hunk to old del_timer* names ]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/tp_meter.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index 87797969c220..bdafdec93a18 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -400,13 +400,7 @@ static void batadv_tp_sender_cleanup(struct batadv_tp_vars *tp_vars)
 	batadv_tp_list_detach(tp_vars);
 
 	/* kill the timer and remove its reference */
-	del_timer_sync(&tp_vars->timer);
-	/* the worker might have rearmed itself therefore we kill it again. Note
-	 * that if the worker should run again before invoking the following
-	 * del_timer(), it would not re-arm itself once again because the status
-	 * is OFF now
-	 */
-	del_timer(&tp_vars->timer);
+	timer_shutdown_sync(&tp_vars->timer);
 	batadv_tp_vars_put(tp_vars);
 }
 
-- 
2.47.3


