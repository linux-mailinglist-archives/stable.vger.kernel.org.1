Return-Path: <stable+bounces-266536-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BtkXByufMWrsoQUAu9opvQ
	(envelope-from <stable+bounces-266536-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 21:08:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A17694C5E
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 21:08:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b="kfgR/r9V";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266536-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-266536-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 37117300106B
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B8E3DE422;
	Tue, 16 Jun 2026 19:08:19 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE5F318EDA;
	Tue, 16 Jun 2026 19:08:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781636899; cv=none; b=t3Ubd4fzEZAjfrDXwQNQRjwLdN5AdonvzS+bkLvJQvrLyrwSBsCofRk6zjGwWKr9cQeXrptzw3hDSHIC+V4dQ+QmXssupNqMAPCD58IdXWSIrNMJngM/HdfNdzV9eKBO25Dk+EIMkOJG1HLmD+mHgneuICkKKcR5NucT8efyIuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781636899; c=relaxed/simple;
	bh=HUnxP8iUaktYB1wQU18cn0+E4URcBVEh/US5rSK9rM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dFfQjlL2iduvvZJRvrkm/SKxXkbzUIG8Gt641rHrHxmbnJQ9K0bKEuqJ6e4UI3dG3ZNab+sk/EqRUiPNoYlNSnb/qaA7EASBT/znhKDdreNYzgCyPo2NOeWKUAhX8Ok/TCxe+76X+Of4VeFifyDYbuTmYIrAv4ujOqBX6XhJbs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kfgR/r9V; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87A571F000E9;
	Tue, 16 Jun 2026 19:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781636898;
	bh=NCAGIAnLauLQoYg8miGCUskyg1mo0582fgKwHbZVu64=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kfgR/r9VZ9Yi4VnnKVhXEBN8zTaI4PTQImCtPgmdSZPuCVFAOaYKNpLcPMPDa5/0l
	 TEvHJAH+OGO0OaqDjffdMordBpYrjg+rS3Dr9jM3ATZ6IF4vC5Agj8iS4Q0qgaABoS
	 y2z1ksS6gbhukxABzgtef3lROMfI9E4H8zNeMo1c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable@kernel.org,
	Yuan Tan <yuantan098@gmail.com>,
	Yifan Wu <yifanwucs@gmail.com>,
	Juefei Pu <tomapufckgml@gmail.com>,
	Xin Liu <bird@lzu.edu.cn>,
	Haoze Xie <royenheart@gmail.com>,
	Ren Wei <n05ec@lzu.edu.cn>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 283/342] netfilter: nf_queue: hold bridge skb->dev while queued
Date: Tue, 16 Jun 2026 20:29:39 +0530
Message-ID: <20260616145101.591137757@linuxfoundation.org>
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
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-266536-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:stable@kernel.org,m:yuantan098@gmail.com,m:yifanwucs@gmail.com,m:tomapufckgml@gmail.com,m:bird@lzu.edu.cn,m:royenheart@gmail.com,m:n05ec@lzu.edu.cn,m:pablo@netfilter.org,m:sashal@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,kernel.org,gmail.com,lzu.edu.cn,netfilter.org];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,lzu.edu.cn:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,netfilter.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 13A17694C5E

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Haoze Xie <royenheart@gmail.com>

[ Upstream commit e196115ec330a18de415bdb9f5071aa9f08e53ce ]

br_pass_frame_up() rewrites skb->dev from the ingress port to the bridge
master before queueing bridge LOCAL_IN packets. NFQUEUE only holds
references on state.in/out and bridge physdevs, so a queued bridge
packet can retain a freed bridge master in skb->dev until reinjection.

When the verdict is reinjected later, br_netif_receive_skb() re-enters
the receive path with skb->dev still pointing at the freed bridge master,
triggering a use-after-free.

Store skb->dev in the queue entry, hold a reference on it for the queue
lifetime, and use the saved device when dropping queued packets during
NETDEV_DOWN handling.

Fixes: ac2863445686 ("netfilter: bridge: add nf_afinfo to enable queuing to userspace")
Cc: stable@kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Signed-off-by: Haoze Xie <royenheart@gmail.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/netfilter/nf_queue.h |    1 +
 net/netfilter/nf_queue.c         |    4 +++-
 net/netfilter/nfnetlink_queue.c  |    2 ++
 3 files changed, 6 insertions(+), 1 deletion(-)

--- a/include/net/netfilter/nf_queue.h
+++ b/include/net/netfilter/nf_queue.h
@@ -12,6 +12,7 @@
 struct nf_queue_entry {
 	struct list_head	list;
 	struct sk_buff		*skb;
+	struct net_device	*skb_dev;
 	unsigned int		id;
 	unsigned int		hook_index;	/* index in hook_entries->hook[] */
 #if IS_ENABLED(CONFIG_BRIDGE_NETFILTER)
--- a/net/netfilter/nf_queue.c
+++ b/net/netfilter/nf_queue.c
@@ -60,6 +60,7 @@ static void nf_queue_entry_release_refs(
 	struct nf_hook_state *state = &entry->state;
 
 	/* Release those devices we held, or Alexey will kill me. */
+	dev_put(entry->skb_dev);
 	dev_put(state->in);
 	dev_put(state->out);
 	if (state->sk)
@@ -103,6 +104,7 @@ bool nf_queue_entry_get_refs(struct nf_q
 	if (state->sk && !refcount_inc_not_zero(&state->sk->sk_refcnt))
 		return false;
 
+	dev_hold(entry->skb_dev);
 	dev_hold(state->in);
 	dev_hold(state->out);
 
@@ -204,11 +206,11 @@ static int __nf_queue(struct sk_buff *sk
 
 	*entry = (struct nf_queue_entry) {
 		.skb	= skb,
+		.skb_dev = skb->dev,
 		.state	= *state,
 		.hook_index = index,
 		.size	= sizeof(*entry) + route_key_size,
 	};
-
 	__nf_queue_entry_init_physdevs(entry);
 
 	if (!nf_queue_entry_get_refs(entry)) {
--- a/net/netfilter/nfnetlink_queue.c
+++ b/net/netfilter/nfnetlink_queue.c
@@ -911,6 +911,8 @@ dev_cmp(struct nf_queue_entry *entry, un
 	if (physinif == ifindex || physoutif == ifindex)
 		return 1;
 #endif
+	if (entry->skb_dev && entry->skb_dev->ifindex == ifindex)
+		return 1;
 	if (entry->state.in)
 		if (entry->state.in->ifindex == ifindex)
 			return 1;



