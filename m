Return-Path: <stable+bounces-248655-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGFBFD1YB2oozgIAu9opvQ
	(envelope-from <stable+bounces-248655-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 19:30:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DB94855521E
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 19:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D1F5531490A5
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8124BC006;
	Fri, 15 May 2026 16:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jfXT2H/i"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA6C4B8DEF;
	Fri, 15 May 2026 16:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778862290; cv=none; b=gD4zoq8rk2OhOP15NSEI91ELXMl3IfG+v+4zZ94qmNE1/58TTPP7jGDMxzzY8leBnk45YvsnjJomfAZEpILpI0qigSJLePWKT/oQSymvvs7/Qx0eTAoTl7s/nPHzNPzgfKPbtKr8Fy1GZjbF23IS+8CP++CftP6a9qbX10dwRIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778862290; c=relaxed/simple;
	bh=oRUVnApo/tVHMlQz8XDGv5vOAdlpHFEAvYmxTdJl/QQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PPkGvadl5ezxHmdUDDDNHEjtribGrBXXf2uratfCrDzTKIvpmn1mNtdtkEJ/MDTLcZULhR+CbhK1GvyQ3kdnM2BAsPWmXfX4yHYbo2R+vfiGD4y8QPc5nG0hkORQdkKwpy40EBO+vHOdhk0CdHhDWxyWOxSzd3/3Jl3M5CElWpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jfXT2H/i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A007C2BCC9;
	Fri, 15 May 2026 16:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778862290;
	bh=oRUVnApo/tVHMlQz8XDGv5vOAdlpHFEAvYmxTdJl/QQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jfXT2H/ioe0LsdcrFF5y5NpCB0+OhErB8Y5NP3s9N6hQXs5A3kVxKOky/OE8J1mvT
	 uDyQU2+OpVt3meXk2iBWDHCybSu8IV7TgIVPJ1AYjz0qlw0i2ukj3t575QptZz+VCL
	 rrwE298Rbu/tL9+gomjspXaCft7e88DmH7gTMvwo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable@kernel.org,
	Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 6.18 181/188] batman-adv: tp_meter: fix tp_num leak on kmalloc failure
Date: Fri, 15 May 2026 17:49:58 +0200
Message-ID: <20260515154701.265950580@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515154657.309489048@linuxfoundation.org>
References: <20260515154657.309489048@linuxfoundation.org>
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
X-Rspamd-Queue-Id: DB94855521E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-248655-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[narfation.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sven Eckelmann <sven@narfation.org>

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/batman-adv/tp_meter.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -994,6 +994,7 @@ void batadv_tp_start(struct batadv_priv
 
 	tp_vars = kmalloc(sizeof(*tp_vars), GFP_ATOMIC);
 	if (!tp_vars) {
+		atomic_dec(&bat_priv->tp_num);
 		spin_unlock_bh(&bat_priv->tp_list_lock);
 		batadv_dbg(BATADV_DBG_TP_METER, bat_priv,
 			   "Meter: %s cannot allocate list elements\n",
@@ -1366,8 +1367,10 @@ batadv_tp_init_recv(struct batadv_priv *
 	}
 
 	tp_vars = kmalloc(sizeof(*tp_vars), GFP_ATOMIC);
-	if (!tp_vars)
+	if (!tp_vars) {
+		atomic_dec(&bat_priv->tp_num);
 		goto out_unlock;
+	}
 
 	ether_addr_copy(tp_vars->other_end, icmp->orig);
 	tp_vars->role = BATADV_TP_RECEIVER;



