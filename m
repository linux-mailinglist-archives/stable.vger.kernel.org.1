Return-Path: <stable+bounces-258547-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KAR4GuUoG2ra/ggAu9opvQ
	(envelope-from <stable+bounces-258547-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:13:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0441C61147E
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 035F7303AF89
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E40C3BFE4D;
	Sat, 30 May 2026 18:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ox5QX5G1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3082F90E0;
	Sat, 30 May 2026 18:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780164715; cv=none; b=ok8zHKs1u3MOFXG8qihppGPue8EKOsEB8TdSYn7ebEJLm70F0UCBka+dFLkRO7ixJYC9TwgTuNvGRzLfVP+jD4YQU5LxdZu5Im36o3aWQP+3YIEh998I/oTcI1o1c7nU6lqurZG8XW1KygN4XLue2Z6lh3RD6apyB/4dlFlpxz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780164715; c=relaxed/simple;
	bh=DBinf9gI/AQ6dI9CXumfyO6haZn2cVJqzPKrGox8JJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jbx8T2Qopfu2ojL9Z6kcehqv6O2CQzskaZDjkkwdM0Pi3hqzif0UyTtbHegEPwQbXy/fkAluieH543XYa1AG9pGV7C1GA6GXMPW9M7JeygvVrFXxq8hKiZ45UvI9y1o/pbQTQjRKrxjRnOKUJOJ44GziYcBPBGhbC47VFOkkpow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ox5QX5G1; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBE561F00893;
	Sat, 30 May 2026 18:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780164714;
	bh=wqIh99atCrVMgr2hp4x5s9HlL5sdpEL8MRzWLP8q7H8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ox5QX5G1cIhAP1/phNrR53GQuCyc1tcox+UEFtKzZ5n6NTM/8zI05uPYij4w0pGCs
	 iJohLwHqMhwi2spjYArDWQDVKE3VwPmpWjxb7Fk2uJX2o9xH5menVSt/sWjx/b51kO
	 8XIFfN+mS5sO2kHGMqE43zwHBknrCURRI4HDoq/k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 620/776] net/sched: sch_fq_pie: annotate data-races in fq_pie_dump_stats()
Date: Sat, 30 May 2026 18:05:34 +0200
Message-ID: <20260530160256.011414801@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160240.228940103@linuxfoundation.org>
References: <20260530160240.228940103@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258547-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.996];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mojatatu.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,msgid.link:url]
X-Rspamd-Queue-Id: 0441C61147E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 59b145771c7982cfe9020d4e9e22da92d6b5ae31 ]

fq_codel_dump_stats() acquires the qdisc spinlock a bit too late.

Move this acquisition before we fill tc_fq_pie_xstats with live data.

Alternative would be to add READ_ONCE() and WRITE_ONCE() annotations,
but the spinlock is needed anyway to scan q->new_flows and q->old_flows.

Fixes: ec97ecf1ebe4 ("net: sched: add Flow Queue PIE packet scheduler")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
Link: https://patch.msgid.link/20260423063527.2568262-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/sch_fq_pie.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/net/sched/sch_fq_pie.c b/net/sched/sch_fq_pie.c
index 30259c8756451..910efc0630a14 100644
--- a/net/sched/sch_fq_pie.c
+++ b/net/sched/sch_fq_pie.c
@@ -499,18 +499,19 @@ static int fq_pie_dump(struct Qdisc *sch, struct sk_buff *skb)
 static int fq_pie_dump_stats(struct Qdisc *sch, struct gnet_dump *d)
 {
 	struct fq_pie_sched_data *q = qdisc_priv(sch);
-	struct tc_fq_pie_xstats st = {
-		.packets_in	= q->stats.packets_in,
-		.overlimit	= q->stats.overlimit,
-		.overmemory	= q->overmemory,
-		.dropped	= q->stats.dropped,
-		.ecn_mark	= q->stats.ecn_mark,
-		.new_flow_count = q->new_flow_count,
-		.memory_usage   = q->memory_usage,
-	};
+	struct tc_fq_pie_xstats st = { 0 };
 	struct list_head *pos;
 
 	sch_tree_lock(sch);
+
+	st.packets_in	= q->stats.packets_in;
+	st.overlimit	= q->stats.overlimit;
+	st.overmemory	= q->overmemory;
+	st.dropped	= q->stats.dropped;
+	st.ecn_mark	= q->stats.ecn_mark;
+	st.new_flow_count = q->new_flow_count;
+	st.memory_usage   = q->memory_usage;
+
 	list_for_each(pos, &q->new_flows)
 		st.new_flows_len++;
 
-- 
2.53.0




