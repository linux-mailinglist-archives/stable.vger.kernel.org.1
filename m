Return-Path: <stable+bounces-266556-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0NpQMpKfMWologUAu9opvQ
	(envelope-from <stable+bounces-266556-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 21:10:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C74D0694D1D
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 21:10:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=f1hmCO3J;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266556-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-266556-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DDF8A3004430
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859033DDDD5;
	Tue, 16 Jun 2026 19:10:03 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184503DE43F;
	Tue, 16 Jun 2026 19:10:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781637003; cv=none; b=Ghepp2rZxo1sjPbcVOX7bGNedBf5JlC8selErUlWa2jX/0p4lWlZzmN6DpD2P6NbKNnRWs7uel8eKHvOzHv4xcOJKya+L9Ws9r/TumHo0wMNuP0tHdx0KnY1f4d64Mk65fol8Ky6Ol/upX8Lhwmwlqms25ToPLYa1G+1wShWCII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781637003; c=relaxed/simple;
	bh=fveLoBKVDREe0YNAMruvZJYJFPeebiSU4FrqNXEr5BQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fVFXPyif3vw3LKnN7T1yFit852rju6qdjtFpij8iGW5uqvA7a4Zrvr0txfKAJu2IamFCppAEHAgWjOmP+UwmCwHZpGJ7X66VOkQhXt+17ZX2hgb3hOvwHEd3O4rAvWl5qN1Otd/I6fR73KxaYTRtAcTY3D+PC3A7I49Uczu4O1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=f1hmCO3J; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0FD81F000E9;
	Tue, 16 Jun 2026 19:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781637002;
	bh=vELi45qNnPa0W1zfFVqx20hDBRcnfpJY3NXoIZcCRuQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=f1hmCO3JTOHZBq+IwKfpTNfeT3X/MB1C/mQzZlsC+ZAuE2TmK94TQAqljzx3I+ZMt
	 bDTwyDhEuCOJiREvYcx6ZLR/ylZS5QR/jjWot5IBOYrUPNnoC53VmKEnZypgzIOEpE
	 1A9dURt7+04Wydwp6L5AQ92HlF6DX4aeAPDzVbys=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable@kernel.org,
	Yuan Tan <yuantan098@gmail.com>,
	Xin Liu <bird@lzu.edu.cn>,
	Luxing Yin <tr0jan@lzu.edu.cn>,
	Zhengchuan Liang <zcliangcn@gmail.com>,
	Ren Wei <n05ec@lzu.edu.cn>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 325/342] xfrm: input: hold netns during deferred transport reinjection
Date: Tue, 16 Jun 2026 20:30:21 +0530
Message-ID: <20260616145103.722409678@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145048.348037099@linuxfoundation.org>
References: <20260616145048.348037099@linuxfoundation.org>
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
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,kernel.org,gmail.com,lzu.edu.cn,secunet.com];
	TAGGED_FROM(0.00)[bounces-266556-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:stable@kernel.org,m:yuantan098@gmail.com,m:bird@lzu.edu.cn,m:tr0jan@lzu.edu.cn,m:zcliangcn@gmail.com,m:n05ec@lzu.edu.cn,m:steffen.klassert@secunet.com,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lzu.edu.cn:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,secunet.com:email,vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C74D0694D1D

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhengchuan Liang <zcliangcn@gmail.com>

[ Upstream commit c16f74dc1d75d0e2e7670076d5375deda110ebeb ]

Transport-mode reinjection stores a struct net pointer in skb->cb and
uses it later from xfrm_trans_reinject(). That pointer must stay valid
until the deferred callback runs.

Take a netns reference when queueing deferred reinjection work and drop
it after the callback completes. Use maybe_get_net() so the queueing
path does not revive a namespace that is already being torn down.

This keeps the existing workqueue design and fixes the netns lifetime
handling in one place for all users of xfrm_trans_queue_net().

Fixes: 7b3801927e52 ("xfrm: introduce xfrm_trans_queue_net")
Cc: stable@kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Co-developed-by: Luxing Yin <tr0jan@lzu.edu.cn>
Signed-off-by: Luxing Yin <tr0jan@lzu.edu.cn>
Signed-off-by: Zhengchuan Liang <zcliangcn@gmail.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/xfrm/xfrm_input.c |   16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

--- a/net/xfrm/xfrm_input.c
+++ b/net/xfrm/xfrm_input.c
@@ -777,9 +777,12 @@ static void xfrm_trans_reinject(unsigned
 	__skb_queue_head_init(&queue);
 	skb_queue_splice_init(&trans->queue, &queue);
 
-	while ((skb = __skb_dequeue(&queue)))
-		XFRM_TRANS_SKB_CB(skb)->finish(XFRM_TRANS_SKB_CB(skb)->net,
-					       NULL, skb);
+	while ((skb = __skb_dequeue(&queue))) {
+		struct net *net = XFRM_TRANS_SKB_CB(skb)->net;
+
+		XFRM_TRANS_SKB_CB(skb)->finish(net, NULL, skb);
+		put_net(net);
+	}
 }
 
 int xfrm_trans_queue_net(struct net *net, struct sk_buff *skb,
@@ -787,6 +790,7 @@ int xfrm_trans_queue_net(struct net *net
 				       struct sk_buff *))
 {
 	struct xfrm_trans_tasklet *trans;
+	struct net *hold_net;
 
 	trans = this_cpu_ptr(&xfrm_trans_tasklet);
 
@@ -795,8 +799,12 @@ int xfrm_trans_queue_net(struct net *net
 
 	BUILD_BUG_ON(sizeof(struct xfrm_trans_cb) > sizeof(skb->cb));
 
+	hold_net = maybe_get_net(net);
+	if (!hold_net)
+		return -ENODEV;
+
 	XFRM_TRANS_SKB_CB(skb)->finish = finish;
-	XFRM_TRANS_SKB_CB(skb)->net = net;
+	XFRM_TRANS_SKB_CB(skb)->net = hold_net;
 	__skb_queue_tail(&trans->queue, skb);
 	tasklet_schedule(&trans->tasklet);
 	return 0;



