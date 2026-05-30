Return-Path: <stable+bounces-257827-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cIE/OFIfG2rO/QgAu9opvQ
	(envelope-from <stable+bounces-257827-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:33:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E95D060FE55
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1EEDD3003718
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 17:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471203ACEEA;
	Sat, 30 May 2026 17:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pnCzvqnW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACA530E853;
	Sat, 30 May 2026 17:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780162304; cv=none; b=XYMBD7yI/HM6KKxZ8hoeaUBF/v8VBFcKzJHnSrUxZJHmHrfTR01iQMD8kHQ7z5VpjfEDFX3VeK3PiQEuB3wusqUCUa9BioMTVvc3fl8SiQvYlFWBQ4jHOCiVtwYTc4FM7OhxKrT1wZD4SnEHFurBWd63vd7bqXHPVVEqIOJBO48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780162304; c=relaxed/simple;
	bh=5PJW3CEby3ZU2aQMmLNpMZ1FMFD8jV+N/KgDXHW1d5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iDDaAbslWzZdKYWZhkmgw6kbzNCEpOdpUorwX9Ggryjx/1y+Dgo4FL4F8yA3eQTuBYnZRjt+X6k1sSmOGcVBfjHXQ+EDpYChrfh2gJM1DEa+9SkQ6ELR6LslLUoyyJQ/3kfMtYqSZWAzIRaeD2tMxA6lVb01BaIh7LK/3LWnhgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pnCzvqnW; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 393AB1F00893;
	Sat, 30 May 2026 17:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780162301;
	bh=6oMqNCKb/bUpXDKKO06gEIiG73N5m3GuZha3dnOtda4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=pnCzvqnWvyF8P6gfBRLyqK9PlEnto6cRBheyBZyTciyd9qTWZ2YLDxWCvAmm+2qeO
	 Jwax+gnSXiut2NHWZNT/zz/4n/Iy1HLOgOqlYvMwg8yI1rRUy8D64Eq9egWSxt5Vrm
	 lQp2fntXSw9LGnWpsKBoXrmzdPaHOZSt9X/hiGiY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable@kernel.org,
	Yuan Tan <yuantan098@gmail.com>,
	Yifan Wu <yifanwucs@gmail.com>,
	Juefei Pu <tomapufckgml@gmail.com>,
	Xin Liu <bird@lzu.edu.cn>,
	Ruijie Li <ruijieli51@gmail.com>,
	Zhanpeng Li <lzhanpeng2025@lzu.edu.cn>,
	Ren Wei <n05ec@lzu.edu.cn>,
	Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 6.1 881/969] batman-adv: clear current gateway during teardown
Date: Sat, 30 May 2026 18:06:45 +0200
Message-ID: <20260530160325.017528042@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160300.485627683@linuxfoundation.org>
References: <20260530160300.485627683@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257827-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,kernel.org,gmail.com,lzu.edu.cn,narfation.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,lzu.edu.cn:email,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: E95D060FE55
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ruijie Li <ruijieli51@gmail.com>

commit a340a51ed801eab7bb454150c226323b865263cc upstream.

batadv_gw_node_free() removes the gateway list entries during mesh teardown,
but it does not clear the currently selected gateway. This leaves stale
gateway state behind across cleanup and can break a later mesh recreation.

Clear bat_priv->gw.curr_gw before walking the gateway list so the selected
gateway reference is dropped as part of teardown.

Fixes: 2265c1410864 ("batman-adv: gateway election code refactoring")
Cc: stable@kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Signed-off-by: Ruijie Li <ruijieli51@gmail.com>
Signed-off-by: Zhanpeng Li <lzhanpeng2025@lzu.edu.cn>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/batman-adv/gateway_client.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/net/batman-adv/gateway_client.c
+++ b/net/batman-adv/gateway_client.c
@@ -479,10 +479,14 @@ void batadv_gw_node_delete(struct batadv
  */
 void batadv_gw_node_free(struct batadv_priv *bat_priv)
 {
+	struct batadv_gw_node *curr_gw;
 	struct batadv_gw_node *gw_node;
 	struct hlist_node *node_tmp;
 
 	spin_lock_bh(&bat_priv->gw.list_lock);
+	curr_gw = rcu_replace_pointer(bat_priv->gw.curr_gw, NULL, true);
+	batadv_gw_node_put(curr_gw);
+
 	hlist_for_each_entry_safe(gw_node, node_tmp,
 				  &bat_priv->gw.gateway_list, list) {
 		hlist_del_init_rcu(&gw_node->list);



