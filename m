Return-Path: <stable+bounces-10321-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3DED827461
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 16:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E73BB235F8
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 15:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96E953E23;
	Mon,  8 Jan 2024 15:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ApaF7hdp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BAD53E1F;
	Mon,  8 Jan 2024 15:44:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FE4BC433C9;
	Mon,  8 Jan 2024 15:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704728680;
	bh=1vTOtFuS+jn3f+D6JD6qsY6Xu+2NCvPRhqXdRTRtqbs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ApaF7hdpcoFlicg7AKuG+OUywCyWxv2ov6JVQv3qC2y0OTkc3Uvp3NAZcULaDGYEt
	 qUfPeKj/cHNCCZxVfg2Z0cf0XYtukwdUyXEOXZPvwFFj4I38CokltdXk+fBseZNCtm
	 ABNQrtHhHiC0oYACF1Ibh3OYf2P4Lyd9q18ewNeM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vladimir Smelhaus <vl.sm@email.cz>,
	Paul Blakey <paulb@nvidia.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 125/150] netfilter: flowtable: GC pushes back packets to classic path
Date: Mon,  8 Jan 2024 16:36:16 +0100
Message-ID: <20240108153516.956393315@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240108153511.214254205@linuxfoundation.org>
References: <20240108153511.214254205@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pablo Neira Ayuso <pablo@netfilter.org>

[ Upstream commit 735795f68b37e9bb49f642407a0d49b1631ea1c7 ]

Since 41f2c7c342d3 ("net/sched: act_ct: Fix promotion of offloaded
unreplied tuple"), flowtable GC pushes back flows with IPS_SEEN_REPLY
back to classic path in every run, ie. every second. This is because of
a new check for NF_FLOW_HW_ESTABLISHED which is specific of sched/act_ct.

In Netfilter's flowtable case, NF_FLOW_HW_ESTABLISHED never gets set on
and IPS_SEEN_REPLY is unreliable since users decide when to offload the
flow before, such bit might be set on at a later stage.

Fix it by adding a custom .gc handler that sched/act_ct can use to
deal with its NF_FLOW_HW_ESTABLISHED bit.

Fixes: 41f2c7c342d3 ("net/sched: act_ct: Fix promotion of offloaded unreplied tuple")
Reported-by: Vladimir Smelhaus <vl.sm@email.cz>
Reviewed-by: Paul Blakey <paulb@nvidia.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Stable-dep-of: 125f1c7f26ff ("net/sched: act_ct: Take per-cb reference to tcf_ct_flow_table")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/netfilter/nf_flow_table.h |  1 +
 net/netfilter/nf_flow_table_core.c    | 14 +++++++-------
 net/sched/act_ct.c                    |  7 +++++++
 3 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/include/net/netfilter/nf_flow_table.h b/include/net/netfilter/nf_flow_table.h
index f37f9f34430c1..0b163ead95c9f 100644
--- a/include/net/netfilter/nf_flow_table.h
+++ b/include/net/netfilter/nf_flow_table.h
@@ -53,6 +53,7 @@ struct nf_flowtable_type {
 	struct list_head		list;
 	int				family;
 	int				(*init)(struct nf_flowtable *ft);
+	bool				(*gc)(const struct flow_offload *flow);
 	int				(*setup)(struct nf_flowtable *ft,
 						 struct net_device *dev,
 						 enum flow_block_command cmd);
diff --git a/net/netfilter/nf_flow_table_core.c b/net/netfilter/nf_flow_table_core.c
index baddb93a5e8cf..c1d99cb370b44 100644
--- a/net/netfilter/nf_flow_table_core.c
+++ b/net/netfilter/nf_flow_table_core.c
@@ -331,12 +331,6 @@ void flow_offload_refresh(struct nf_flowtable *flow_table,
 }
 EXPORT_SYMBOL_GPL(flow_offload_refresh);
 
-static bool nf_flow_is_outdated(const struct flow_offload *flow)
-{
-	return test_bit(IPS_SEEN_REPLY_BIT, &flow->ct->status) &&
-		!test_bit(NF_FLOW_HW_ESTABLISHED, &flow->flags);
-}
-
 static inline bool nf_flow_has_expired(const struct flow_offload *flow)
 {
 	return nf_flow_timeout_delta(flow->timeout) <= 0;
@@ -422,12 +416,18 @@ nf_flow_table_iterate(struct nf_flowtable *flow_table,
 	return err;
 }
 
+static bool nf_flow_custom_gc(struct nf_flowtable *flow_table,
+			      const struct flow_offload *flow)
+{
+	return flow_table->type->gc && flow_table->type->gc(flow);
+}
+
 static void nf_flow_offload_gc_step(struct nf_flowtable *flow_table,
 				    struct flow_offload *flow, void *data)
 {
 	if (nf_flow_has_expired(flow) ||
 	    nf_ct_is_dying(flow->ct) ||
-	    nf_flow_is_outdated(flow))
+	    nf_flow_custom_gc(flow_table, flow))
 		flow_offload_teardown(flow);
 
 	if (test_bit(NF_FLOW_TEARDOWN, &flow->flags)) {
diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
index b80a58d3bf0f3..4d34474f2cc0e 100644
--- a/net/sched/act_ct.c
+++ b/net/sched/act_ct.c
@@ -274,7 +274,14 @@ static int tcf_ct_flow_table_fill_actions(struct net *net,
 	return err;
 }
 
+static bool tcf_ct_flow_is_outdated(const struct flow_offload *flow)
+{
+	return test_bit(IPS_SEEN_REPLY_BIT, &flow->ct->status) &&
+	       !test_bit(NF_FLOW_HW_ESTABLISHED, &flow->flags);
+}
+
 static struct nf_flowtable_type flowtable_ct = {
+	.gc		= tcf_ct_flow_is_outdated,
 	.action		= tcf_ct_flow_table_fill_actions,
 	.owner		= THIS_MODULE,
 };
-- 
2.43.0




