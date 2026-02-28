Return-Path: <stable+bounces-220555-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6E4OBkM7o2nO+gQAu9opvQ
	(envelope-from <stable+bounces-220555-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:00:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B97FD1C67F2
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:00:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2945D3029266
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8CCA3D7509;
	Sat, 28 Feb 2026 17:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JwtuMui4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACCE3D74F5;
	Sat, 28 Feb 2026 17:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300436; cv=none; b=oBI7cPJRWFeAqE7sddT1R1SDcjmQAlX+fht5IiQ0v/ppZOQa/CVvqVOrHYCvHju3gml6empDwe147TyZB3+Od81AOaNOz7otAx4ZYkJ48wktlY+MW03gSHRzeM/SEM2kOd+1hIz/L1iLS1NaBVwQCbtD2FyDfcRyajsXjRBU+eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300436; c=relaxed/simple;
	bh=48EgMikTl/bu9W9zNPAxWtRIaL/Orh+GgvS+Au/IDV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jnQL0npnezSQ7J4qzbryxQ1xtQoXfJ/8b9UpYtmPtaBMb5OZm1FR1EhYB3HzPK93XN3kyR6jmqXqnX6R83P0nvFNkiwCSJBURlW769optLbz/N66WfvHju0l9+2B9viw0tP2Gr71Da5mzM9ta3G75CvqahcS7ebm+GRGdkg5zjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JwtuMui4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9164C19425;
	Sat, 28 Feb 2026 17:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300436;
	bh=48EgMikTl/bu9W9zNPAxWtRIaL/Orh+GgvS+Au/IDV0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JwtuMui4JT3JkeZ8r3tjxwldKAvIV3HqoYPOIaDcMjn7NMGFOhSnXwt8UGwxT63ln
	 9CKhlwtHQ9Co++O0+/Q2o0Q7pZAI0xGz7FNuZaJSi3cuTDf7Gi4sdJPD522WtLD5c4
	 SMoJzQmkEA4h3xBf3+Q1mi3tzHj7GH4ytTh1LtVXlaAlUli4UbMZKGiiiDAkW0boCG
	 BJmfL9A70C4oULy7gpO0n8zUgWmzvIImdgDEySrDbqfpyGXE8l9eXklDkvPYaWg77f
	 5ftYmk6MsiiLZblXd4OxFxw54+dZcDve6a68LDLpSxfVjDZZJLPwDbqGQO9XRc6QId
	 vw9nMxqiQBnnQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Krishna Kumar <krikku@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 476/844] net: do not pass flow_id to set_rps_cpu()
Date: Sat, 28 Feb 2026 12:26:29 -0500
Message-ID: <20260228173244.1509663-477-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[google.com,gmail.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220555-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: B97FD1C67F2
X-Rspamd-Action: no action

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 8a8a9fac9efa6423fd74938b940cb7d731780718 ]

Blamed commit made the assumption that the RPS table for each receive
queue would have the same size, and that it would not change.

Compute flow_id in set_rps_cpu(), do not assume we can use the value
computed by get_rps_cpu(). Otherwise we risk out-of-bound access
and/or crashes.

Fixes: 48aa30443e52 ("net: Cache hash and flow_id to avoid recalculation")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Krishna Kumar <krikku@gmail.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Link: https://patch.msgid.link/20260220222605.3468081-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/dev.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index f5e4040e08399..60a26208cbd87 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4988,8 +4988,7 @@ static bool rps_flow_is_active(struct rps_dev_flow *rflow,
 
 static struct rps_dev_flow *
 set_rps_cpu(struct net_device *dev, struct sk_buff *skb,
-	    struct rps_dev_flow *rflow, u16 next_cpu, u32 hash,
-	    u32 flow_id)
+	    struct rps_dev_flow *rflow, u16 next_cpu, u32 hash)
 {
 	if (next_cpu < nr_cpu_ids) {
 		u32 head;
@@ -5000,6 +4999,7 @@ set_rps_cpu(struct net_device *dev, struct sk_buff *skb,
 		struct rps_dev_flow *tmp_rflow;
 		unsigned int tmp_cpu;
 		u16 rxq_index;
+		u32 flow_id;
 		int rc;
 
 		/* Should we steer this flow to a different hardware queue? */
@@ -5015,6 +5015,7 @@ set_rps_cpu(struct net_device *dev, struct sk_buff *skb,
 		if (!flow_table)
 			goto out;
 
+		flow_id = rfs_slot(hash, flow_table);
 		tmp_rflow = &flow_table->flows[flow_id];
 		tmp_cpu = READ_ONCE(tmp_rflow->cpu);
 
@@ -5062,7 +5063,6 @@ static int get_rps_cpu(struct net_device *dev, struct sk_buff *skb,
 	struct rps_dev_flow_table *flow_table;
 	struct rps_map *map;
 	int cpu = -1;
-	u32 flow_id;
 	u32 tcpu;
 	u32 hash;
 
@@ -5109,8 +5109,7 @@ static int get_rps_cpu(struct net_device *dev, struct sk_buff *skb,
 		/* OK, now we know there is a match,
 		 * we can look at the local (per receive queue) flow table
 		 */
-		flow_id = rfs_slot(hash, flow_table);
-		rflow = &flow_table->flows[flow_id];
+		rflow = &flow_table->flows[rfs_slot(hash, flow_table)];
 		tcpu = rflow->cpu;
 
 		/*
@@ -5129,8 +5128,7 @@ static int get_rps_cpu(struct net_device *dev, struct sk_buff *skb,
 		     ((int)(READ_ONCE(per_cpu(softnet_data, tcpu).input_queue_head) -
 		      rflow->last_qtail)) >= 0)) {
 			tcpu = next_cpu;
-			rflow = set_rps_cpu(dev, skb, rflow, next_cpu, hash,
-					    flow_id);
+			rflow = set_rps_cpu(dev, skb, rflow, next_cpu, hash);
 		}
 
 		if (tcpu < nr_cpu_ids && cpu_online(tcpu)) {
-- 
2.51.0


