Return-Path: <stable+bounces-248351-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJUfGM1KB2pZwwIAu9opvQ
	(envelope-from <stable+bounces-248351-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:33:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 028B45536F0
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4C307317A0BF
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0793E008F;
	Fri, 15 May 2026 16:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VwXeUUDZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8C33E7BAE;
	Fri, 15 May 2026 16:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778861511; cv=none; b=rvnb4L53TssM+xHyQLkFWGpel0qozHlOzUBoFwu69xaqRDXh0bwFy6FRwrgYOaiF5FXsjMoIZ+OlkToMUjJg4xvzbTNpT7Mq1lXg7yt6vPt53kEVHLK2JhGxGRXNFYMUvfTlLDR+jaFbXcw6K603sidxfZ3ROIDgfOw4Sjb/f8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778861511; c=relaxed/simple;
	bh=HGMfr+b8yZygchqawXr69F+lCCxWuF0My42wfByNXP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R9MGidfqWHlVCgvqgKGHewe/WDz6bz549/P+cCAUwAivQ6K7MyI8G8G6JJWB12AN3bJLsNMYI/ulaCslEhbgn7SwpvR6ghod5TfSKW+ZYg87om1NXcxxbISsnaIJQ2Xxm8ET7/OWyhrzKJl4eT2UodGgPn6lN39xI4nzUPJ1Wio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VwXeUUDZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F539C2BCF6;
	Fri, 15 May 2026 16:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778861511;
	bh=HGMfr+b8yZygchqawXr69F+lCCxWuF0My42wfByNXP4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VwXeUUDZm/xKYynocCXMzh/noTp3n0R/MdjVOzDEcNngjBmD6SdRwIQSGfzC5z+6a
	 IgefH2Z/R7SpTU9R2JbyGbVb2WLKaB+zhIuV0nG8bfTXJ/p8EzGm3jxA0dknxGQxrE
	 WvL1uG/FwZ/A0wgy6DCPxMfycbG1FWcZrG6hH7g0=
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
Subject: [PATCH 6.6 357/474] batman-adv: reject new tp_meter sessions during teardown
Date: Fri, 15 May 2026 17:47:46 +0200
Message-ID: <20260515154722.744641715@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515154715.053014143@linuxfoundation.org>
References: <20260515154715.053014143@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 028B45536F0
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
	TAGGED_FROM(0.00)[bounces-248351-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,lzu.edu.cn:email,narfation.org:email]
X-Rspamd-Action: no action

6.6-stable review patch.  If anyone has any objections, please let me know.

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
 



