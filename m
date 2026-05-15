Return-Path: <stable+bounces-247614-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yOq8IRzeBmp4ogIAu9opvQ
	(envelope-from <stable+bounces-247614-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 10:49:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0808154BB62
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 10:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9D2F630684F0
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 08:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F9037DEAA;
	Fri, 15 May 2026 08:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fg3vf1YQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1617931F991
	for <stable@vger.kernel.org>; Fri, 15 May 2026 08:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778834717; cv=none; b=gS70INkR0rcsLaZFcNwBzJAF61e88gte/1rVOX7J2mDas6elEzDj0GmtgffQ8kJbXMSfSc/QVXdiZruxip/s/U/61x18/RMSIKs7h3ScghzKAciT/GY27KJoGtnYYJ9y5Q/qRFugae4IeJPVPDdNuBEeTgKxhBn9Q6c1Yte0LKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778834717; c=relaxed/simple;
	bh=B+qXT9zOawZ7TgzLnp72et2lXv+29yqJ92Rsugah8NE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=RZbLeeocCiNqDrzVqMojR+PbNOMLHyGpO1WIdbE3euALGmcq8mC4HnYTYx4CrIoEh6JvCE71eBUyP77kNOFKdcj2ifoMdyOj7E1CjSaFxKTf2SzKfQR8W2vK5rlxerYc05G9/j5QdosqxU1itOPTMcqJsM+jI17s659Q6Bg40MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fg3vf1YQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95B84C2BCB0;
	Fri, 15 May 2026 08:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778834717;
	bh=B+qXT9zOawZ7TgzLnp72et2lXv+29yqJ92Rsugah8NE=;
	h=Subject:To:Cc:From:Date:From;
	b=fg3vf1YQ7ln1yFkcYmOFP2iwJhXbsxTQvV37vWzzfvuSttPLldiOAcLRiT21tgPcD
	 Qz7zry4WWYvA+sl0KEp8/MvTAj7NZFfBTSOePT4B+9qKoapRNMfCVtY0WyQ/R6Inaz
	 wYqOWojsNLtsxF+/nzo+r8I0bKtY53yQcGEQOYEE=
Subject: FAILED: patch "[PATCH] batman-adv: tp_meter: fix tp_num leak on kmalloc failure" failed to apply to 6.18-stable tree
To: sven@narfation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 15 May 2026 10:45:19 +0200
Message-ID: <2026051519-award-matron-543d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0808154BB62
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247614-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,narfation.org:email,gregkh:email]
X-Rspamd-Action: no action


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x ce425dd05d0fe7594930a0fb103634f35ac47bb6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051519-award-matron-543d@gregkh' --subject-prefix 'PATCH 6.18.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ce425dd05d0fe7594930a0fb103634f35ac47bb6 Mon Sep 17 00:00:00 2001
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 6 May 2026 22:20:49 +0200
Subject: [PATCH] batman-adv: tp_meter: fix tp_num leak on kmalloc failure

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
Signed-off-by: Sven Eckelmann <sven@narfation.org>

diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index 58ca59a2799e..066c76113fc4 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -994,6 +994,7 @@ void batadv_tp_start(struct batadv_priv *bat_priv, const u8 *dst,
 
 	tp_vars = kmalloc_obj(*tp_vars, GFP_ATOMIC);
 	if (!tp_vars) {
+		atomic_dec(&bat_priv->tp_num);
 		spin_unlock_bh(&bat_priv->tp_list_lock);
 		batadv_dbg(BATADV_DBG_TP_METER, bat_priv,
 			   "Meter: %s cannot allocate list elements\n",
@@ -1366,8 +1367,10 @@ batadv_tp_init_recv(struct batadv_priv *bat_priv,
 	}
 
 	tp_vars = kmalloc_obj(*tp_vars, GFP_ATOMIC);
-	if (!tp_vars)
+	if (!tp_vars) {
+		atomic_dec(&bat_priv->tp_num);
 		goto out_unlock;
+	}
 
 	ether_addr_copy(tp_vars->other_end, icmp->orig);
 	tp_vars->role = BATADV_TP_RECEIVER;


