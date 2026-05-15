Return-Path: <stable+bounces-248848-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CKnIOgJRB2rBxgIAu9opvQ
	(envelope-from <stable+bounces-248848-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:59:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9296E5544D6
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B925C3042E36
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C9A3AD51C;
	Fri, 15 May 2026 16:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aPFfa7+I"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A5F35FF73;
	Fri, 15 May 2026 16:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778862784; cv=none; b=p/xwzvCocz2Qqm80lynfGsdR5EeDZ1CCMMcRJzpiB+7BqIBI/TgQwfxxXmD7ef6VrjG4Nh7jq4ASBIs5SYeAP7hkbhxkrie9EmCcqEd00Sw4EWerFBD4TPJTMWjVSuPTbQRV/BSkrrAnmJCswXZg0cAznqOW7hp8TlIddvsELT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778862784; c=relaxed/simple;
	bh=PZLDtTSPIGOPb3Ej6ZCwa+d52tMTG8EhYHiAkGsqBd0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MY9qCRpdrU1mV8AOybpyD6l1qVMRuOv4te7Ec9U6q2eXJyOfxL6XN308x+Tjb0YUSAs/Go4MvjnjqrQApyV1RXbCzZiMrgPFyeqEIYRR+601Zl3vyZDEEGYwB/csce2OhTLRAXOCLbZWZ3Gt6BODuAXgzFjpSB+PMPNI3lmhvbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aPFfa7+I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA7BAC2BCB0;
	Fri, 15 May 2026 16:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778862784;
	bh=PZLDtTSPIGOPb3Ej6ZCwa+d52tMTG8EhYHiAkGsqBd0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aPFfa7+IKVKHN7YWnPu2TxvNkSFedD5bPCRw/S4r5P93SrRiwWsaPpRXpWoh06YU7
	 knGGOAOkwvyM24AERm0ZdpWmB+IssxlAONbFiK1f2JDvXuFK0f7F7++UP3V8HFpOtQ
	 VnClljjv9g9oCXBbo+c6l3XY7+3jP6Bw9YKxqFZ8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable@kernel.org,
	Yuan Tan <yuantan098@gmail.com>,
	Yifan Wu <yifanwucs@gmail.com>,
	Juefei Pu <tomapufckgml@gmail.com>,
	Xin Liu <bird@lzu.edu.cn>,
	Luxing Yin <tr0jan@lzu.edu.cn>,
	Jiexun Wang <wangjiexun2025@gmail.com>,
	Ren Wei <n05ec@lzu.edu.cn>,
	Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 7.0 174/201] batman-adv: reject new tp_meter sessions during teardown
Date: Fri, 15 May 2026 17:49:52 +0200
Message-ID: <20260515154702.348094718@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515154658.538039039@linuxfoundation.org>
References: <20260515154658.538039039@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 9296E5544D6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-248848-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,kernel.org,gmail.com,lzu.edu.cn,narfation.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,narfation.org:email,lzu.edu.cn:email]
X-Rspamd-Action: no action

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiexun Wang <wangjiexun2025@gmail.com>

commit 3243543592425beec83d453793e9d27caa0d8e66 upstream.

Prevent tp_meter from starting new sender or receiver sessions after
mesh_state has left BATADV_MESH_ACTIVE.

Fixes: 33a3bb4a3345 ("batman-adv: throughput meter implementation")
Cc: stable@kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Co-developed-by: Luxing Yin <tr0jan@lzu.edu.cn>
Signed-off-by: Luxing Yin <tr0jan@lzu.edu.cn>
Signed-off-by: Jiexun Wang <wangjiexun2025@gmail.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/batman-adv/tp_meter.c |   17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -947,6 +947,13 @@ void batadv_tp_start(struct batadv_priv
 
 	/* look for an already existing test towards this node */
 	spin_lock_bh(&bat_priv->tp_list_lock);
+	if (atomic_read(&bat_priv->mesh_state) != BATADV_MESH_ACTIVE) {
+		spin_unlock_bh(&bat_priv->tp_list_lock);
+		batadv_tp_batctl_error_notify(BATADV_TP_REASON_DST_UNREACHABLE,
+					      dst, bat_priv, session_cookie);
+		return;
+	}
+
 	tp_vars = batadv_tp_list_find(bat_priv, dst);
 	if (tp_vars) {
 		spin_unlock_bh(&bat_priv->tp_list_lock);
@@ -1329,9 +1336,12 @@ static struct batadv_tp_vars *
 batadv_tp_init_recv(struct batadv_priv *bat_priv,
 		    const struct batadv_icmp_tp_packet *icmp)
 {
-	struct batadv_tp_vars *tp_vars;
+	struct batadv_tp_vars *tp_vars = NULL;
 
 	spin_lock_bh(&bat_priv->tp_list_lock);
+	if (atomic_read(&bat_priv->mesh_state) != BATADV_MESH_ACTIVE)
+		goto out_unlock;
+
 	tp_vars = batadv_tp_list_find_session(bat_priv, icmp->orig,
 					      icmp->session);
 	if (tp_vars)
@@ -1464,6 +1474,9 @@ void batadv_tp_meter_recv(struct batadv_
 {
 	struct batadv_icmp_tp_packet *icmp;
 
+	if (atomic_read(&bat_priv->mesh_state) != BATADV_MESH_ACTIVE)
+		goto out;
+
 	icmp = (struct batadv_icmp_tp_packet *)skb->data;
 
 	switch (icmp->subtype) {
@@ -1478,6 +1491,8 @@ void batadv_tp_meter_recv(struct batadv_
 			   "Received unknown TP Metric packet type %u\n",
 			   icmp->subtype);
 	}
+
+out:
 	consume_skb(skb);
 }
 



