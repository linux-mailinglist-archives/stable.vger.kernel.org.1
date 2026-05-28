Return-Path: <stable+bounces-254937-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SEVSOfEuGGpwfggAu9opvQ
	(envelope-from <stable+bounces-254937-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 14:02:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99CC45F1C9B
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 14:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF5F7301952E
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 11:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0623F3E5EC7;
	Thu, 28 May 2026 11:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="f3skHYuv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805CC3E558E
	for <stable@vger.kernel.org>; Thu, 28 May 2026 11:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779969350; cv=none; b=kOLK1GgIxk9yei8jAsPZTqlp+TH20xUX/erDfYNLaW2g82wYQbG/KfgfjMKUwNofN0XIVJzDEYm0Zx6ZA5aM6w7YGKWNTLv+VKK77BEZj+o7FPHoHaXts6X8iPEHsDxeVQfSAni3cRlZYdFWnFEps13KMt7RwuBd1+9sMjmb+vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779969350; c=relaxed/simple;
	bh=/k/i9qLhgw8oB4OCTkkU2wWM1ea+l2NdNVZD57Od7Uw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=kLQv6AopWRxwLjsCmEFH6e8sXHBz4tNr7UwMWn04pXxJAYhkNrPZRD8jlmNZoVfjn2E2AsyHFjA48fiOohcX+ePcq9Xk0C5LXVvVuhkWpvlyVJmGGlcBVaAlNK01CtN78oI13THbOe5D3v0WeiDLoeKlX1O8M3nEYxLSflDySwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=f3skHYuv; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EDBB1F000E9;
	Thu, 28 May 2026 11:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779969347;
	bh=ri+tjhyb8jMnrr6Emx7zlutlFNCB6zKXFJ+plF/1MMw=;
	h=Subject:To:Cc:From:Date;
	b=f3skHYuv+1eV0o9riNCoCPjENdISB3FNTNYm8kiMrcanvDPnlT2cYWRCZnb88+eYQ
	 IVblkOHHWnbw/tS3LSVawsPSi3/Hg7/zss0M42BQqN9bJwhbWLRa0V9QGasc3C8/3h
	 o2+hky57+Ho/QBAKcV9/B5vbPd563CTeGiZXDDfM=
Subject: FAILED: patch "[PATCH] batman-adv: tp_meter: directly shut down timer on cleanup" failed to apply to 5.10-stable tree
To: sven@narfation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 28 May 2026 13:54:45 +0200
Message-ID: <2026052844-dominoes-placard-3f71@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254937-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	RSPAMD_EMAILBL_FAIL(0.00)[2026052844-dominoes-placard-3f71.gregkh:query timed out];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[narfation.org:email,linuxfoundation.org:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,gregkh:email]
X-Rspamd-Queue-Id: 99CC45F1C9B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x d5487249a81ea658717614009c8f46acc5b7101a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026052844-dominoes-placard-3f71@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d5487249a81ea658717614009c8f46acc5b7101a Mon Sep 17 00:00:00 2001
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 13 May 2026 10:43:54 +0200
Subject: [PATCH] batman-adv: tp_meter: directly shut down timer on cleanup

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
Signed-off-by: Sven Eckelmann <sven@narfation.org>

diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index a3593d104caa..1fd1526059d8 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -401,13 +401,7 @@ static void batadv_tp_sender_cleanup(struct batadv_tp_vars *tp_vars)
 	batadv_tp_list_detach(tp_vars);
 
 	/* kill the timer and remove its reference */
-	timer_delete_sync(&tp_vars->timer);
-	/* the worker might have rearmed itself therefore we kill it again. Note
-	 * that if the worker should run again before invoking the following
-	 * timer_delete(), it would not re-arm itself once again because the status
-	 * is OFF now
-	 */
-	timer_delete(&tp_vars->timer);
+	timer_shutdown_sync(&tp_vars->timer);
 	batadv_tp_vars_put(tp_vars);
 }
 


