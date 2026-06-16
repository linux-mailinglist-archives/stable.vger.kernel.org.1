Return-Path: <stable+bounces-265519-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WeYODYuKMWpnmAUAu9opvQ
	(envelope-from <stable+bounces-265519-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:40:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C7036935AC
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:40:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=rpAdp7e7;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-265519-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-265519-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A73CE3048634
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE33947AF5F;
	Tue, 16 Jun 2026 17:40:24 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDD53876CF;
	Tue, 16 Jun 2026 17:40:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781631624; cv=none; b=atbOkHtMTvvwLB7cuNhZz3JrtudckulHMmlpsr8WxuHim4fM9rj5CPgirbk7AqX2EgFQLeS5yPmfDIJMc6cJ5tTAqC3/lVUwlg5VzDScv2RpgcOCx2UhH13W86sk9k8aU1T6qlE4/qZrvsVsg9cRixASm0VCdLDNbKe14m9ayHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781631624; c=relaxed/simple;
	bh=X6hodFe62WAtmsL56kwlecVVYlJCmoRbqZn1gqInVx0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PYn5dnIrKst7zj9Doo/ZFRNy0puGCjf54y/YbaqzOp51LsSN/igT9Fm8AVgP+xBMCfp0DiQ5ozHz/53ucMQ9NlVUIIW/b8HKwmjWR5XhYK5Oy6+lM9LAqDs7dQ3V2w8Op+1jA3I5myuEqeSEsNUq4pyk1BkA2yDVZdFe2xBgwnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rpAdp7e7; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55D9B1F000E9;
	Tue, 16 Jun 2026 17:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781631623;
	bh=9uPUBwMPXvmI9JtNCiY7/uGPm6sAIChqXCHAY2UDsxY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=rpAdp7e7Cu+2OK612CnR4TlCxGDRhCxnk3kGt2rAaC3YRKJxod9TBEQKugEGxA+3L
	 t2XpXXtvs3ubbMN39jJPgOsWg50qHrtujY3yk8qz4YZ/izWwWOs3Mv9UOTfV3v+H0y
	 fpPJKaoVrv47Dbk+NpEwupPC7q0gvs+I3LSiRuIA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 256/522] netfilter: nf_conntrack: destroy stale expectfn expectations on unregister
Date: Tue, 16 Jun 2026 20:26:43 +0530
Message-ID: <20260616145137.929033421@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,asu.edu,gmail.com,netfilter.org,kernel.org];
	TAGGED_FROM(0.00)[bounces-265519-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:xmei5@asu.edu,m:bestswngs@gmail.com,m:pablo@netfilter.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[asu.edu:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,netfilter.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9C7036935AC

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Weiming Shi <bestswngs@gmail.com>

[ Upstream commit c3009418f9fa1dcb3eb86f4d8c92583537b5faa3 ]

NAT helpers such as nf_nat_h323 store a raw pointer to module text in
exp->expectfn (e.g. ip_nat_q931_expect). nf_ct_helper_expectfn_unregister()
only unlinks the callback descriptor and never walks the expectation table,
so an expectation pending at module removal survives with a dangling
exp->expectfn into freed module text.

When the expected connection arrives, init_conntrack() invokes
exp->expectfn(), now a stale pointer into the unloaded module. Reproduced
on a KASAN build by loading the H.323 helpers, creating a Q.931
expectation, unloading nf_nat_h323, then connecting to the expected port:

 Oops: int3: 0000 [#1] SMP KASAN NOPTI
 RIP: 0010:0xffffffffa06102d1
  init_conntrack.isra.0 (net/netfilter/nf_conntrack_core.c:1862)
  nf_conntrack_in (net/netfilter/nf_conntrack_core.c:2049)
  ipv4_conntrack_local (net/netfilter/nf_conntrack_proto.c:223)
  nf_hook_slow (net/netfilter/core.c:619)
  __ip_local_out (net/ipv4/ip_output.c:120)
  __tcp_transmit_skb (net/ipv4/tcp_output.c:1715)
  tcp_connect (net/ipv4/tcp_output.c:4374)
  tcp_v4_connect (net/ipv4/tcp_ipv4.c:345)
  __sys_connect (net/socket.c:2167)
 Modules linked in: nf_conntrack_h323 [last unloaded: nf_nat_h323]

Reaching the dangling state requires CAP_SYS_MODULE in the initial user
namespace to remove a NAT helper that still has live expectations, so this
is a robustness fix; leaving an expectation pointing at freed text is wrong
regardless.

Add nf_ct_helper_expectfn_destroy(), which walks the expectation table and
drops every expectation whose ->expectfn matches the descriptor being torn
down. Call it from each NAT helper's exit path after the existing RCU grace
period, so no expectation outlives the code it points at and no extra
synchronize_rcu() is introduced. With the fix, the same reproducer runs to
completion without the Oops.

Fixes: f587de0e2feb ("[NETFILTER]: nf_conntrack/nf_nat: add H.323 helper port")
Reported-by: Xiang Mei <xmei5@asu.edu>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/netfilter/nf_conntrack_helper.h |  1 +
 net/ipv4/netfilter/nf_nat_h323.c            |  2 ++
 net/netfilter/nf_conntrack_helper.c         | 19 +++++++++++++++++++
 net/netfilter/nf_nat_core.c                 |  2 ++
 net/netfilter/nf_nat_sip.c                  |  1 +
 5 files changed, 25 insertions(+)

diff --git a/include/net/netfilter/nf_conntrack_helper.h b/include/net/netfilter/nf_conntrack_helper.h
index 9939c366f720d4..2435039434ea9d 100644
--- a/include/net/netfilter/nf_conntrack_helper.h
+++ b/include/net/netfilter/nf_conntrack_helper.h
@@ -152,6 +152,7 @@ void nf_ct_helper_log(struct sk_buff *skb, const struct nf_conn *ct,
 
 void nf_ct_helper_expectfn_register(struct nf_ct_helper_expectfn *n);
 void nf_ct_helper_expectfn_unregister(struct nf_ct_helper_expectfn *n);
+void nf_ct_helper_expectfn_destroy(const struct nf_ct_helper_expectfn *n);
 struct nf_ct_helper_expectfn *
 nf_ct_helper_expectfn_find_by_name(const char *name);
 struct nf_ct_helper_expectfn *
diff --git a/net/ipv4/netfilter/nf_nat_h323.c b/net/ipv4/netfilter/nf_nat_h323.c
index faee20af485613..10e1b0837731b7 100644
--- a/net/ipv4/netfilter/nf_nat_h323.c
+++ b/net/ipv4/netfilter/nf_nat_h323.c
@@ -555,6 +555,8 @@ static void __exit nf_nat_h323_fini(void)
 	nf_ct_helper_expectfn_unregister(&q931_nat);
 	nf_ct_helper_expectfn_unregister(&callforwarding_nat);
 	synchronize_rcu();
+	nf_ct_helper_expectfn_destroy(&q931_nat);
+	nf_ct_helper_expectfn_destroy(&callforwarding_nat);
 }
 
 /****************************************************************************/
diff --git a/net/netfilter/nf_conntrack_helper.c b/net/netfilter/nf_conntrack_helper.c
index 6a2ad31ac62f12..8e72c3d4db4ad1 100644
--- a/net/netfilter/nf_conntrack_helper.c
+++ b/net/netfilter/nf_conntrack_helper.c
@@ -286,6 +286,25 @@ void nf_ct_helper_expectfn_unregister(struct nf_ct_helper_expectfn *n)
 }
 EXPORT_SYMBOL_GPL(nf_ct_helper_expectfn_unregister);
 
+static bool expect_iter_expectfn(struct nf_conntrack_expect *exp, void *data)
+{
+	const struct nf_ct_helper_expectfn *n = data;
+
+	/* Relies on registered expectfn descriptors having unique ->expectfn
+	 * pointers, which holds for the in-tree NAT helpers.
+	 */
+	return exp->expectfn == n->expectfn;
+}
+
+/* Destroy expectations still pointing at @n->expectfn; call after the
+ * caller's RCU grace period so none outlives the (often modular) callback.
+ */
+void nf_ct_helper_expectfn_destroy(const struct nf_ct_helper_expectfn *n)
+{
+	nf_ct_expect_iterate_destroy(expect_iter_expectfn, (void *)n);
+}
+EXPORT_SYMBOL_GPL(nf_ct_helper_expectfn_destroy);
+
 /* Caller should hold the rcu lock */
 struct nf_ct_helper_expectfn *
 nf_ct_helper_expectfn_find_by_name(const char *name)
diff --git a/net/netfilter/nf_nat_core.c b/net/netfilter/nf_nat_core.c
index 6b683ff015b9cc..cf7c06b79d5614 100644
--- a/net/netfilter/nf_nat_core.c
+++ b/net/netfilter/nf_nat_core.c
@@ -1157,6 +1157,7 @@ static int __init nf_nat_init(void)
 		RCU_INIT_POINTER(nf_nat_hook, NULL);
 		nf_ct_helper_expectfn_unregister(&follow_master_nat);
 		synchronize_net();
+		nf_ct_helper_expectfn_destroy(&follow_master_nat);
 		unregister_pernet_subsys(&nat_net_ops);
 		kvfree(nf_nat_bysource);
 	}
@@ -1174,6 +1175,7 @@ static void __exit nf_nat_cleanup(void)
 	RCU_INIT_POINTER(nf_nat_hook, NULL);
 
 	synchronize_net();
+	nf_ct_helper_expectfn_destroy(&follow_master_nat);
 	kvfree(nf_nat_bysource);
 	unregister_pernet_subsys(&nat_net_ops);
 }
diff --git a/net/netfilter/nf_nat_sip.c b/net/netfilter/nf_nat_sip.c
index 9fbfc6bff0c221..00838c0cc5bb28 100644
--- a/net/netfilter/nf_nat_sip.c
+++ b/net/netfilter/nf_nat_sip.c
@@ -655,6 +655,7 @@ static void __exit nf_nat_sip_fini(void)
 	RCU_INIT_POINTER(nf_nat_sip_hooks, NULL);
 	nf_ct_helper_expectfn_unregister(&sip_nat);
 	synchronize_rcu();
+	nf_ct_helper_expectfn_destroy(&sip_nat);
 }
 
 static const struct nf_nat_sip_hooks sip_hooks = {
-- 
2.53.0




