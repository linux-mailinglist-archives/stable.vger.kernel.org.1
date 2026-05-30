Return-Path: <stable+bounces-259100-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6M5iLFYwG2p5AAkAu9opvQ
	(envelope-from <stable+bounces-259100-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:45:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 508896126DD
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EA1A13071184
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939072773DE;
	Sat, 30 May 2026 18:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BRi8e3ZE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514E129E11A;
	Sat, 30 May 2026 18:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780166612; cv=none; b=Wcvm/zsyKEgPDaodt23SuhQ92QQUxv9PYA25AgWMff/xe6eYnchzlKKZwq+EJmGGwETf3yFXwrYGsEtgcEOeWb3axUppSAYTd7e0dlhoU1QUz56C8EB/vHWr+138yp95U2okE/4/4qXbg4NH2K1jHd1QcryuN6lDdwRwUNvmwAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780166612; c=relaxed/simple;
	bh=3a0/sSdjnZEhXWBdeHXKqFu+UTNTmafMPnZXtXuH23E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GqZou/SN2y0eUqV4uouojs0+cU17Rt2tGjrK/vl0GuvI4KJE2iiy+F3Tjrxw5wZ7CiDlDTRV8WKQwR9WaA8pRv0LQJj6LYvbzFgHPqKzN/Oa/NMhnJaMv7ocIT11joGAVFkkbg4OVX9ijxuaHWe6NYa0/kzJW6cTc7ADGiHaBF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BRi8e3ZE; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E5091F00893;
	Sat, 30 May 2026 18:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780166611;
	bh=GW8nzS7gFthsmqiCzNiehyaRMJJmZLTgMeCkeZ8X38c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BRi8e3ZEiKgzAx2vctc1w65i9W2wNhMGxRO9MvtE9pvPg0ObdRWEkNAIPSC6kxmFg
	 Hek8lJU2+jZW8xoJUFLRF9rgoplkJOqaxqKhWjSLzLWCR4ud/KYjhzt0Pucz3PgNYo
	 wPJ6yhCHaZNQFrjfF1nEwWFGOGVDv4LXUb9cfMPM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 417/589] net/sched: taprio: stop going through private ops for dequeue and peek
Date: Sat, 30 May 2026 18:04:58 +0200
Message-ID: <20260530160235.709215566@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160224.570625122@linuxfoundation.org>
References: <20260530160224.570625122@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-259100-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nxp.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 508896126DD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vladimir Oltean <vladimir.oltean@nxp.com>

[ Upstream commit 25becba6290bc34e369a0e1a76db9ca88bad87aa ]

Since commit 13511704f8d7 ("net: taprio offload: enforce qdisc to netdev
queue mapping"), taprio_dequeue_soft() and taprio_peek_soft() are de
facto the only implementations for Qdisc_ops :: dequeue and Qdisc_ops ::
peek that taprio provides.

This is because in full offload mode, __dev_queue_xmit() will select a
txq->qdisc which is never root taprio qdisc. So if nothing is enqueued
in the root qdisc, it will never be run and nothing will get dequeued
from it.

Therefore, we can remove the private indirection from taprio, and always
point Qdisc_ops :: dequeue to taprio_dequeue_soft (now simply named
taprio_dequeue) and Qdisc_ops :: peek to taprio_peek_soft (now simply
named taprio_peek).

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 105425b1969c ("net/sched: taprio: fix use-after-free in advance_sched() on schedule switch")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/sch_taprio.c | 58 +++++++++---------------------------------
 1 file changed, 12 insertions(+), 46 deletions(-)

diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index a92dab2fa6ff4..b3b62ee6093d2 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -77,8 +77,6 @@ struct taprio_sched {
 	struct sched_gate_list __rcu *admin_sched;
 	struct hrtimer advance_timer;
 	struct list_head taprio_list;
-	struct sk_buff *(*dequeue)(struct Qdisc *sch);
-	struct sk_buff *(*peek)(struct Qdisc *sch);
 	u32 txtime_delay;
 };
 
@@ -493,7 +491,7 @@ static int taprio_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	return taprio_enqueue_one(skb, sch, child, to_free);
 }
 
-static struct sk_buff *taprio_peek_soft(struct Qdisc *sch)
+static struct sk_buff *taprio_peek(struct Qdisc *sch)
 {
 	struct taprio_sched *q = qdisc_priv(sch);
 	struct net_device *dev = qdisc_dev(sch);
@@ -502,6 +500,11 @@ static struct sk_buff *taprio_peek_soft(struct Qdisc *sch)
 	u32 gate_mask;
 	int i;
 
+	if (unlikely(FULL_OFFLOAD_IS_ENABLED(q->flags))) {
+		WARN_ONCE(1, "Trying to peek into the root of a taprio qdisc configured with full offload\n");
+		return NULL;
+	}
+
 	rcu_read_lock();
 	entry = rcu_dereference(q->current_entry);
 	gate_mask = entry ? entry->gate_mask : TAPRIO_ALL_GATES_OPEN;
@@ -537,20 +540,6 @@ static struct sk_buff *taprio_peek_soft(struct Qdisc *sch)
 	return NULL;
 }
 
-static struct sk_buff *taprio_peek_offload(struct Qdisc *sch)
-{
-	WARN_ONCE(1, "Trying to peek into the root of a taprio qdisc configured with full offload\n");
-
-	return NULL;
-}
-
-static struct sk_buff *taprio_peek(struct Qdisc *sch)
-{
-	struct taprio_sched *q = qdisc_priv(sch);
-
-	return q->peek(sch);
-}
-
 static void taprio_set_budget(struct taprio_sched *q, struct sched_entry *entry)
 {
 	atomic_set(&entry->budget,
@@ -558,7 +547,7 @@ static void taprio_set_budget(struct taprio_sched *q, struct sched_entry *entry)
 			     atomic64_read(&q->picos_per_byte)));
 }
 
-static struct sk_buff *taprio_dequeue_soft(struct Qdisc *sch)
+static struct sk_buff *taprio_dequeue(struct Qdisc *sch)
 {
 	struct taprio_sched *q = qdisc_priv(sch);
 	struct net_device *dev = qdisc_dev(sch);
@@ -567,6 +556,11 @@ static struct sk_buff *taprio_dequeue_soft(struct Qdisc *sch)
 	u32 gate_mask;
 	int i;
 
+	if (unlikely(FULL_OFFLOAD_IS_ENABLED(q->flags))) {
+		WARN_ONCE(1, "Trying to dequeue from the root of a taprio qdisc configured with full offload\n");
+		return NULL;
+	}
+
 	rcu_read_lock();
 	entry = rcu_dereference(q->current_entry);
 	/* if there's no entry, it means that the schedule didn't
@@ -646,20 +640,6 @@ static struct sk_buff *taprio_dequeue_soft(struct Qdisc *sch)
 	return skb;
 }
 
-static struct sk_buff *taprio_dequeue_offload(struct Qdisc *sch)
-{
-	WARN_ONCE(1, "Trying to dequeue from the root of a taprio qdisc configured with full offload\n");
-
-	return NULL;
-}
-
-static struct sk_buff *taprio_dequeue(struct Qdisc *sch)
-{
-	struct taprio_sched *q = qdisc_priv(sch);
-
-	return q->dequeue(sch);
-}
-
 static bool should_restart_cycle(const struct sched_gate_list *oper,
 				 const struct sched_entry *entry)
 {
@@ -1563,17 +1543,6 @@ static int taprio_change(struct Qdisc *sch, struct nlattr *opt,
 		q->advance_timer.function = advance_sched;
 	}
 
-	if (FULL_OFFLOAD_IS_ENABLED(q->flags)) {
-		q->dequeue = taprio_dequeue_offload;
-		q->peek = taprio_peek_offload;
-	} else {
-		/* Be sure to always keep the function pointers
-		 * in a consistent state.
-		 */
-		q->dequeue = taprio_dequeue_soft;
-		q->peek = taprio_peek_soft;
-	}
-
 	err = taprio_get_start_time(sch, new_admin, &start);
 	if (err < 0) {
 		NL_SET_ERR_MSG(extack, "Internal error: failed get start time");
@@ -1689,9 +1658,6 @@ static int taprio_init(struct Qdisc *sch, struct nlattr *opt,
 	hrtimer_init(&q->advance_timer, CLOCK_TAI, HRTIMER_MODE_ABS);
 	q->advance_timer.function = advance_sched;
 
-	q->dequeue = taprio_dequeue_soft;
-	q->peek = taprio_peek_soft;
-
 	q->root = sch;
 
 	/* We only support static clockids. Use an invalid value as default
-- 
2.53.0




