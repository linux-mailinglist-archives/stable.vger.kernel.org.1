Return-Path: <stable+bounces-250989-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KAYMJd7tDWpb4wUAu9opvQ
	(envelope-from <stable+bounces-250989-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:22:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 324CD593767
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B8205308459A
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6183A3F20E5;
	Wed, 20 May 2026 17:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HWUfOKH1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FCC3F1AD8;
	Wed, 20 May 2026 17:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779296813; cv=none; b=ND1i7Vn8OTlZMslXv2WmPYNFiXYqNR/E5BTVxyuX+Z4beW8LP+a+JrziPr1NXVSc4IM5gT116dpNQCyJ4LYpKPYcTix9y+DeDyuZ0DG/LT5scsZZn6WeayN2SdDPSXjiS81Tq2vqjtMEDrvYG01GgT2mtpgpsunPjFHDRnaFHP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779296813; c=relaxed/simple;
	bh=Bul4/HAr57eldpdjil+Bnk/ky8VXKFuNB7T8MVRF1hw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IgLkG+Dm9fUgZNxEMgK+L0pq+2fDOsB5lPa4Q108u9CoEIGKf1x5sQbfEiD622+yf7/oMEHztQCrMNHBfoxPjiHz2zv94J55Ot6+0MKke6tHOqW3Nk7HWnNRf6DNjmnuWYnZ4rOc3ydNGwWuUOaEknIHbAZ/afvMQxNPLIdEyKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HWUfOKH1; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B6DD1F000E9;
	Wed, 20 May 2026 17:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779296811;
	bh=eq0eONkDQYp2FtjQEIKC+ZzM6YA4xrjn3gXkdAdunso=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HWUfOKH1S+UlD/t1yeVt/h7TJ6cNEyeohPH4FYwoXa7rrg8fGWpQFavvZFR3Ma+IX
	 0QgM1FGAOUTvwZgflgxBG7jiGG1WLl9mCvntSWObFEFmTrmfNpYZ0NM5SHUsP5Z3ru
	 xFAGiw9ulcIOV6mPBBngRPcZ2dDqgMTU+9fGOQBk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0940/1146] net/sched: sch_fq_pie: annotate data-races in fq_pie_dump_stats()
Date: Wed, 20 May 2026 18:19:50 +0200
Message-ID: <20260520162209.508808941@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-250989-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mojatatu.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url]
X-Rspamd-Queue-Id: 324CD593767
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

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
index d8ac3519e9379..66ec15998ce05 100644
--- a/net/sched/sch_fq_pie.c
+++ b/net/sched/sch_fq_pie.c
@@ -509,18 +509,19 @@ static int fq_pie_dump(struct Qdisc *sch, struct sk_buff *skb)
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




