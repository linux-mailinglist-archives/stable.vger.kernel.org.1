Return-Path: <stable+bounces-265308-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AetHGV2IMWp2lwUAu9opvQ
	(envelope-from <stable+bounces-265308-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:31:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F901693361
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:31:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b="x/OGMYCP";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-265308-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-265308-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2057830681E4
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D934502F;
	Tue, 16 Jun 2026 17:22:22 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A6F1A6803;
	Tue, 16 Jun 2026 17:22:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781630542; cv=none; b=Mk2e9Fc+YZixGkhBVMjZxL1H+Hz4RWn3n9SP5pOL52wihHTB5bSonu4juOIQqlvjWWyGnzGw8iaccmeWf6cFOY/xR5X3lQyW78isNQ8B0L8JhCMcU0JG47D9MGOve+3o7Vhvh9nw0AlDBKGCJ6WXHOTiw+keEsELWRQVqymWsSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781630542; c=relaxed/simple;
	bh=F6ia4JyWyF9FHh+cviyhWDWYGoNVrdjCG3rTQ3DrhNY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N2is5z329vTrdmHpg6c8T3RetzOc7gvNRYm87es2ebePdrwjCjGoLdWwXUEMOdl1809nLNWL8wWR+335eIS4B2v0/BSfogQ2+2hBkfsbE+iX+Cargf4nJInj/OjuzQtXwpvLrRtm6A0cpjDcWdvwrBGhZKlxP5mmIPlvyPI/8pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=x/OGMYCP; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9852B1F000E9;
	Tue, 16 Jun 2026 17:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781630541;
	bh=d51mzjekrHdlZr/lk4Aaqi8Hk/7gXtuHkHZYqKLF92I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=x/OGMYCPsvCLAAoIND/Tvk95fKqCVNBPHTdSwEvfby2i9saI5i0ctZ4a1Yb4F3I3q
	 C6Lk+hVwX3cVskiCdOXK/mZ6P4BSAj2Vwfe36CcFvzx9vJqRqgA0Z6d7TUxXACr6+O
	 Sf90P8uXEolQSckzx0u+YvcTn3jXBLymzbg2GDyU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable@kernel.org,
	Sven Eckelmann <sven@narfation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 049/522] batman-adv: tp_meter: directly shut down timer on cleanup
Date: Tue, 16 Jun 2026 20:23:16 +0530
Message-ID: <20260616145128.063357408@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145125.307082728@linuxfoundation.org>
References: <20260616145125.307082728@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-265308-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:stable@kernel.org,m:sven@narfation.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[narfation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5F901693361

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sven Eckelmann <sven@narfation.org>

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/batman-adv/tp_meter.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index 61e6cb5bce8ec5..707f05aa14791f 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -384,13 +384,7 @@ static void batadv_tp_sender_cleanup(struct batadv_priv *bat_priv,
 	atomic_dec(&tp_vars->bat_priv->tp_num);
 
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
2.53.0




