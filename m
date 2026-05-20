Return-Path: <stable+bounces-251356-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CCyDB0n6DWq75AUAu9opvQ
	(envelope-from <stable+bounces-251356-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:15:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8170E595A92
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 698D135D51A4
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6B03EDACC;
	Wed, 20 May 2026 17:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lIozEq7i"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0508936A376;
	Wed, 20 May 2026 17:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779297766; cv=none; b=tuCe5tnWh8lVoB+bU+YPx6F+640Ts1SP1+/jJtFy85y80HmEKLjxtsfVpeZr1/sVhG6z4urMRVzPVzSAaqClFDkKmenYupmff+CPkC8voav1oqjK3BbP4Mg2zzRWzEkiZqRQEGMJjUTkp7gCS4K5F4dO8M0RM0MuqKAOIImbYIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779297766; c=relaxed/simple;
	bh=UFm7GgEkok61STLmwoS1BOs15KWhvpps+zouTaYEPho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IxjbthlgNfRMrVB7Swo5zN9l7s4fVZgLzjGGX0VXqoBggVUc156rRP2fKfwXUy7FFg+GYo14U8v1s4ju/HixGZItgHVHClylzg8txFV9LDpdqR7zifFelB0XYbzZlN02y6f6YYBqZhDHQZ9WvLZdkiH2B1CR589KtUCvQKx41Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lIozEq7i; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 270D21F000E9;
	Wed, 20 May 2026 17:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779297764;
	bh=FWSKXbha3EickjVHkui+vB+StEehQjE/aR03K8nkWE8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lIozEq7iU8pdtzTMEtSsXRJ6O+tS/BK+Mhs4neo/2hfTm1bDGuOcXoTjndRozkXdB
	 LSRknf5tR6H334nEBPY8C2teEeTEji+PcV7kbVrp+4hYwpXIkBPjF0TebxdjalyTiN
	 GBPGHVeFfmV2xNbs8Z3tZ8LEMXLKZybpPCr9oQ/4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	zdi-disclosures@trendmicro.com,
	Victor Nogueira <victor@mojatatu.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 155/957] net/sched: act_ct: Only release RCU read lock after ct_ft
Date: Wed, 20 May 2026 18:10:38 +0200
Message-ID: <20260520162137.912589444@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251356-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mojatatu.com:email,trendmicro.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 8170E595A92
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jamal Hadi Salim <jhs@mojatatu.com>

[ Upstream commit f462dca0c8415bf0058d0ffa476354c4476d0f09 ]

When looking up a flow table in act_ct in tcf_ct_flow_table_get(),
rhashtable_lookup_fast() internally opens and closes an RCU read critical
section before returning ct_ft.
The tcf_ct_flow_table_cleanup_work() can complete before refcount_inc_not_zero()
is invoked on the returned ct_ft resulting in a UAF on the already freed ct_ft
object. This vulnerability can lead to privilege escalation.

Analysis from zdi-disclosures@trendmicro.com:
When initializing act_ct, tcf_ct_init() is called, which internally triggers
tcf_ct_flow_table_get().

static int tcf_ct_flow_table_get(struct net *net, struct tcf_ct_params *params)

{
                struct zones_ht_key key = { .net = net, .zone = params->zone };
                struct tcf_ct_flow_table *ct_ft;
                int err = -ENOMEM;

                mutex_lock(&zones_mutex);
                ct_ft = rhashtable_lookup_fast(&zones_ht, &key, zones_params); // [1]
                if (ct_ft && refcount_inc_not_zero(&ct_ft->ref)) // [2]
                                goto out_unlock;
                ...
}

static __always_inline void *rhashtable_lookup_fast(
                struct rhashtable *ht, const void *key,
                const struct rhashtable_params params)
{
                void *obj;

                rcu_read_lock();
                obj = rhashtable_lookup(ht, key, params);
                rcu_read_unlock();

                return obj;
}

At [1], rhashtable_lookup_fast() looks up and returns the corresponding ct_ft
from zones_ht . The lookup is performed within an RCU read critical section
through rcu_read_lock() / rcu_read_unlock(), which prevents the object from
being freed. However, at the point of function return, rcu_read_unlock() has
already been called, and there is nothing preventing ct_ft from being freed
before reaching refcount_inc_not_zero(&ct_ft->ref) at [2]. This interval becomes
the race window, during which ct_ft can be freed.

Free Process:

tcf_ct_flow_table_put() is executed through the path tcf_ct_cleanup() call_rcu()
tcf_ct_params_free_rcu() tcf_ct_params_free() tcf_ct_flow_table_put().

static void tcf_ct_flow_table_put(struct tcf_ct_flow_table *ct_ft)
{
                if (refcount_dec_and_test(&ct_ft->ref)) {
                                rhashtable_remove_fast(&zones_ht, &ct_ft->node, zones_params);
                                INIT_RCU_WORK(&ct_ft->rwork, tcf_ct_flow_table_cleanup_work); // [3]
                                queue_rcu_work(act_ct_wq, &ct_ft->rwork);
                }
}

At [3], tcf_ct_flow_table_cleanup_work() is scheduled as RCU work

static void tcf_ct_flow_table_cleanup_work(struct work_struct *work)

{
                struct tcf_ct_flow_table *ct_ft;
                struct flow_block *block;

                ct_ft = container_of(to_rcu_work(work), struct tcf_ct_flow_table,
                                                                rwork);
                nf_flow_table_free(&ct_ft->nf_ft);
                block = &ct_ft->nf_ft.flow_block;
                down_write(&ct_ft->nf_ft.flow_block_lock);
                WARN_ON(!list_empty(&block->cb_list));
                up_write(&ct_ft->nf_ft.flow_block_lock);
                kfree(ct_ft); // [4]

                module_put(THIS_MODULE);
}

tcf_ct_flow_table_cleanup_work() frees ct_ft at [4]. When this function executes
between [1] and [2], UAF occurs.

This race condition has a very short race window, making it generally
difficult to trigger. Therefore, to trigger the vulnerability an msleep(100) was
inserted after[1]

Fixes: 138470a9b2cc2 ("net/sched: act_ct: fix lockdep splat in tcf_ct_flow_table_get")
Reported-by: zdi-disclosures@trendmicro.com
Tested-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
Link: https://patch.msgid.link/20260410111627.46611-1-jhs@mojatatu.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/act_ct.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
index b3c160ad590d2..f9cb8f7474ed3 100644
--- a/net/sched/act_ct.c
+++ b/net/sched/act_ct.c
@@ -326,9 +326,13 @@ static int tcf_ct_flow_table_get(struct net *net, struct tcf_ct_params *params)
 	int err = -ENOMEM;
 
 	mutex_lock(&zones_mutex);
-	ct_ft = rhashtable_lookup_fast(&zones_ht, &key, zones_params);
-	if (ct_ft && refcount_inc_not_zero(&ct_ft->ref))
+	rcu_read_lock();
+	ct_ft = rhashtable_lookup(&zones_ht, &key, zones_params);
+	if (ct_ft && refcount_inc_not_zero(&ct_ft->ref)) {
+		rcu_read_unlock();
 		goto out_unlock;
+	}
+	rcu_read_unlock();
 
 	ct_ft = kzalloc(sizeof(*ct_ft), GFP_KERNEL);
 	if (!ct_ft)
-- 
2.53.0




