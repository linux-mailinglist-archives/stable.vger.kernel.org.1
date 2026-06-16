Return-Path: <stable+bounces-265469-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7kTpJ/iKMWqbmAUAu9opvQ
	(envelope-from <stable+bounces-265469-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:42:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A289693622
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:42:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b="eIS/ezFT";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-265469-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-265469-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8EC1E3241A6A
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF254611CF;
	Tue, 16 Jun 2026 17:35:56 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D1832E728;
	Tue, 16 Jun 2026 17:35:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781631356; cv=none; b=fdNqKZJzSoAmmnfaWEma7+JGP52dVkdk4+iCeCQlf6QQdyWCUlFNeztKvwUffmTh0Ux7amT1BA+gF2/H/hW70NmkVQyrtX4dC2hphnNj3JiHv4pAAg+HKts2CaOxxptMJBrhAk/bgr32OFsCQsNgXTu/I446sydl2zNOVwibZFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781631356; c=relaxed/simple;
	bh=Lzlq3qI1cJrjjNCwd1GbW3l6xosjouVB5VesBJaZqco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CVqlNPiCBy2A7UmmL39JfM3IseqNZMornxSzwvWT9P0oCy1j+jQSEWtayAUuJRjjJNX+2n5xMNvLbe2muAPNMaJ3wMFrCbcySVE6Dkp0ASyleyowVt7kWWODNK7lXspjp7dqgMl7L2Y03zfEjNE6RGGVD2ykDzzqkcsuAoHeWDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eIS/ezFT; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43A4E1F00A3A;
	Tue, 16 Jun 2026 17:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781631354;
	bh=rbSDirl+RlSNQ2MRDXiDi3zRCE7PYLaWuzTFKXqTLrk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eIS/ezFT+iF5vj+CtkYoTzKvqYrjp7a1wxKgGcI0VOuttKpeOce4lHMhbWwMmYYGx
	 yVNuv9kN/szQ5EmluijHa0R72kBrpQ7EHmOxVMHQYlIU7x2aTTLdtFj908+a5qdvpn
	 aGMuhCZcG7iN1260UEj8HzqulojW4mTWn/ACU0pg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
	Kyle Zeng <kylebot@openai.com>,
	Victor Nogueira <victor@mojatatu.com>,
	syzbot@syzkaller.appspotmail.com,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Pedro Tammela <pctammela@mojatatu.com>,
	Eric Dumazet <edumazet@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 204/522] net/sched: act_api: use RCU with deferred freeing for action lifecycle
Date: Tue, 16 Jun 2026 20:25:51 +0530
Message-ID: <20260616145135.615929801@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-265469-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:kuba@kernel.org,m:kylebot@openai.com,m:victor@mojatatu.com,m:syzbot@syzkaller.appspotmail.com,m:jhs@mojatatu.com,m:pctammela@mojatatu.com,m:edumazet@google.com,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,appspotmail.com:email,openai.com:email,mojatatu.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0A289693622

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jamal Hadi Salim <jhs@mojatatu.com>

[ Upstream commit 5057e1aca011e51ef51498c940ef96f3d3e8a305 ]

When NEWTFILTER and DELFILTER are run concurrently it is possible to create a
race with an associated action.

Let's illustrate with CPU0 running NEWTFILTER and CPU1 running DELFILTER:

 0: mutex_lock() <-- holds the idr lock
 0: rcu_read_lock()
 0: p = idr_find(idr, index) <-- action p is valid (RCU protects IDR)
 0: mutex_unlock() <-- releases the idr lock
 1: refcount_dec_and_mutex_lock() <-- refcnt 1->0, mutex held
 1: idr_remove(idr, index) <-- Action removed from IDR
 1: mutex_unlock() <-- mutex released allowing us to delete the action
 1: tcf_action_cleanup(p); kfree(p) <-- Kfrees p immediately, no deferral
 0: refcount_inc_not_zero(&p->tcfa_refcnt) <-- ouch, UAF p points to freed memory

This patch fixes the race condition between NEWTFILTER and DELFILTER by
adding struct rcu_head to tc_action used in the deferral and introducing a
call_rcu() in the delete path to defer the final kfree().

Note: this is a revert of commit d7fb60b9cafb ("net_sched: get rid of tcfa_rcu")
but also modernization/simplification to directly use kfree_rcu().

Let's illustrate the new restored code path:

 0: rcu_read_lock()
 1: refcount_dec_and_mutex_lock() <-- refcnt 1->0, mutex held
 1: idr_remove(idr, index)
 1: mutex_unlock()
 1: call_rcu(&p->tcfa_rcu, tcf_action_rcu_free) <-- defer kfree after grace period
 0: p = idr_find(idr, index)
 0: refcount_inc_not_zero(&p->tcfa_refcnt) <-- fails, refcnt already 0
 1: rcu_read_unlock() <-- release so freeing can run after grace period

After CPU1 calls idr_remove(), the object is no longer reachable through the IDR.
CPU0's subsequent idr_find() will return NULL, and even if it still held a
stale pointer, the immediate kfree() is now deferred until after the RCU grace
period, so no UAF can occur.

Fixes: d7fb60b9cafb ("net_sched: get rid of tcfa_rcu")
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Reported-by: Kyle Zeng <kylebot@openai.com>
Tested-by: Victor Nogueira <victor@mojatatu.com>
Tested-by: syzbot@syzkaller.appspotmail.com
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
Tested-by: Kyle Zeng <kylebot@openai.com>
Reviewed-by: Pedro Tammela <pctammela@mojatatu.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Link: https://patch.msgid.link/20260531160812.68020-1-jhs@mojatatu.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/act_api.h | 1 +
 net/sched/act_api.c   | 7 +------
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/include/net/act_api.h b/include/net/act_api.h
index 31e8d8f8bcd7eb..55e3b5ec1d92d8 100644
--- a/include/net/act_api.h
+++ b/include/net/act_api.h
@@ -42,6 +42,7 @@ struct tc_action {
 	struct tc_cookie	__rcu *act_cookie;
 	struct tcf_chain	__rcu *goto_chain;
 	u32			tcfa_flags;
+	struct rcu_head         tcfa_rcu;
 	u8			hw_stats;
 	u8			used_hw_stats;
 	bool			used_hw_stats_valid;
diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index b75e22756c4b09..47f0d4c3dc487f 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -111,11 +111,6 @@ struct tcf_chain *tcf_action_set_ctrlact(struct tc_action *a, int action,
 }
 EXPORT_SYMBOL(tcf_action_set_ctrlact);
 
-/* XXX: For standalone actions, we don't need a RCU grace period either, because
- * actions are always connected to filters and filters are already destroyed in
- * RCU callbacks, so after a RCU grace period actions are already disconnected
- * from filters. Readers later can not find us.
- */
 static void free_tcf(struct tc_action *p)
 {
 	struct tcf_chain *chain = rcu_dereference_protected(p->goto_chain, 1);
@@ -128,7 +123,7 @@ static void free_tcf(struct tc_action *p)
 	if (chain)
 		tcf_chain_put_by_act(chain);
 
-	kfree(p);
+	kfree_rcu(p, tcfa_rcu);
 }
 
 static void offload_action_hw_count_set(struct tc_action *act,
-- 
2.53.0




