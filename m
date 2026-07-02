Return-Path: <stable+bounces-270931-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4fvHKUaYRmpSZgsAu9opvQ
	(envelope-from <stable+bounces-270931-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 18:56:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98FD96FAC6D
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 18:56:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=ZhC8+wee;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270931-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-270931-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4DE8031891E4
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 16:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5627B358381;
	Thu,  2 Jul 2026 16:37:06 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0872D8DC4;
	Thu,  2 Jul 2026 16:37:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783010226; cv=none; b=Gf2luF9GImwVZbtoVKRdXZGkATSFZQrrsVOSsy8n/kKC74q1IghR3PEu2cM461HnA55Iz/9xW9JkgvI9wFGY5P5dMBB19ZooZbUVX03Lof3uvfoDeJWYQXK/z7DLR2FhurFWclyBU5mOeegp82wHnTzyLxTZTGQQEW8Wryksh6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783010226; c=relaxed/simple;
	bh=OdO6PMf4X83YAQfjQPMx3gwBfKp0SUpABqJvcfe3yRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qPwi8ICZT5hRblchSRv7QrBOtNX+vIWM40a+HOfkEaBxsy3p71lw1++otQ4loCe+aIsBNGVxIWtYNNv+AE3PPmT0JKnO7GlxBChpsBCvSuiPaipMI/6V6vBqhtLS+rRwKDYNoKRFRNfyv9JaG9UeCzNJ5o85u9rNC8pIUQU5fAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZhC8+wee; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 729231F000E9;
	Thu,  2 Jul 2026 16:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783010224;
	bh=LavDGVx6g+xCb2c3LoKFbsETnnceV0Dqaua4c+lAn64=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZhC8+weeQFtG+U2I3JrL6mXsGjHVK8FRWpzrNFB+t9zj9E+402Cp5Wa6yZ3gAUxk+
	 o8tZR+0Lr1m6kp1s3wJJPJ7z5iPs2sUqx9GEDHwHeqQxHQc/Gcr7HkyMvuOL45reM2
	 KzsN+zbvTfAx57C/UbLiE23dqUfLchS8jbd3K9vE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.12 029/204] net: qualcomm: rmnet: fix endpoint use-after-free in rmnet_dellink()
Date: Thu,  2 Jul 2026 18:18:06 +0200
Message-ID: <20260702155119.271772836@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702155118.667618796@linuxfoundation.org>
References: <20260702155118.667618796@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-270931-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:xmei5@asu.edu,m:bestswngs@gmail.com,m:kuba@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,asu.edu,gmail.com,kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,msgid.link:url,vger.kernel.org:from_smtp,asu.edu:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 98FD96FAC6D

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Weiming Shi <bestswngs@gmail.com>

commit d00c953a8f69921f484b629801766da68f27f658 upstream.

rmnet_dellink() removes the endpoint from the hash table with
hlist_del_init_rcu() and then immediately frees it with kfree(). However,
RCU readers on the receive path (rmnet_rx_handler ->
__rmnet_map_ingress_handler) may still hold a reference to the endpoint and
dereference ep->egress_dev after the memory has been freed. The endpoint is
a kmalloc-32 object, and the stale read at offset 8 corresponds to the
egress_dev pointer.

  BUG: unable to handle page fault for address: ffffffffde942eef
  Oops: 0002 [#1] SMP NOPTI
  CPU: 1 UID: 0 PID: 137 Comm: poc_write Not tainted 7.0.0+ #4 PREEMPTLAZY
  RIP: 0010:rmnet_vnd_rx_fixup (rmnet_vnd.c:27)
  Call Trace:
   <TASK>
   __rmnet_map_ingress_handler (rmnet_handlers.c:48 rmnet_handlers.c:101)
   rmnet_rx_handler (rmnet_handlers.c:129 rmnet_handlers.c:235)
   __netif_receive_skb_core.constprop.0 (net/core/dev.c:6096)
   __netif_receive_skb_one_core (net/core/dev.c:6208)
   netif_receive_skb (net/core/dev.c:6467)
   tun_get_user (drivers/net/tun.c:1955)
   tun_chr_write_iter (drivers/net/tun.c:2003)
   vfs_write (fs/read_write.c:688)
   ksys_write (fs/read_write.c:740)
   </TASK>

Add an rcu_head field to struct rmnet_endpoint and replace kfree() with
kfree_rcu() so the endpoint memory remains valid through the RCU grace
period. Also remove the rmnet_vnd_dellink() call and inline only the
nr_rmnet_devs decrement, since rmnet_vnd_dellink() would set
ep->egress_dev to NULL during the grace period, creating a data race
with lockless readers.

Fixes: ceed73a2cf4a ("drivers: net: ethernet: qualcomm: rmnet: Initial implementation")
Reported-by: Xiang Mei <xmei5@asu.edu>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
Link: https://patch.msgid.link/20260514122511.3083479-2-bestswngs@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c |    8 ++++----
 drivers/net/ethernet/qualcomm/rmnet/rmnet_config.h |    1 +
 2 files changed, 5 insertions(+), 4 deletions(-)

--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
@@ -210,8 +210,8 @@ static void rmnet_dellink(struct net_dev
 	ep = rmnet_get_endpoint(real_port, mux_id);
 	if (ep) {
 		hlist_del_init_rcu(&ep->hlnode);
-		rmnet_vnd_dellink(mux_id, real_port, ep);
-		kfree(ep);
+		real_port->nr_rmnet_devs--;
+		kfree_rcu(ep, rcu);
 	}
 
 	netdev_upper_dev_unlink(real_dev, dev);
@@ -235,9 +235,9 @@ static void rmnet_force_unassociate_devi
 		hash_for_each_safe(port->muxed_ep, bkt_ep, tmp_ep, ep, hlnode) {
 			unregister_netdevice_queue(ep->egress_dev, &list);
 			netdev_upper_dev_unlink(real_dev, ep->egress_dev);
-			rmnet_vnd_dellink(ep->mux_id, port, ep);
 			hlist_del_init_rcu(&ep->hlnode);
-			kfree(ep);
+			port->nr_rmnet_devs--;
+			kfree_rcu(ep, rcu);
 		}
 		rmnet_unregister_real_device(real_dev);
 		unregister_netdevice_many(&list);
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.h
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.h
@@ -18,6 +18,7 @@ struct rmnet_endpoint {
 	u8 mux_id;
 	struct net_device *egress_dev;
 	struct hlist_node hlnode;
+	struct rcu_head rcu;
 };
 
 struct rmnet_egress_agg_params {



