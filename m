Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8537DD543
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 18:48:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376472AbjJaRsp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 13:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376496AbjJaRso (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 13:48:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FDD7E8
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 10:48:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E066C433CD;
        Tue, 31 Oct 2023 17:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698774521;
        bh=0Kvtk395VoXhcyDFH7o9Vzvoe0VPE5M9qK5bMlLsgI8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tONYQ2byoSPf9d5lD/V4ijKgYiD53YGRLbuo1YRWnX8mEYwXjmcuRDWewGrDO9i+2
         ZlP98ikrAlJyI1DPkwBYgclFN0RjalwM1aBKk5EgEVecWNb32+wcPrfNT4hkLzVLNB
         33oEifhYz+MbqWfbszWO/QjBWXVjquWtj4fmNOkI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Vladimir Smelhaus <vl.sm@email.cz>,
        Paul Blakey <paulb@nvidia.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 075/112] netfilter: flowtable: GC pushes back packets to classic path
Date:   Tue, 31 Oct 2023 18:01:16 +0100
Message-ID: <20231031165903.688196388@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231031165901.318222981@linuxfoundation.org>
References: <20231031165901.318222981@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/netfilter/nf_flow_table.h |  1 +
 net/netfilter/nf_flow_table_core.c    | 14 +++++++-------
 net/sched/act_ct.c                    |  7 +++++++
 3 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/include/net/netfilter/nf_flow_table.h b/include/net/netfilter/nf_flow_table.h
index d466e1a3b0b19..fe1507c1db828 100644
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
index 1d34d700bd09b..920a5a29ae1dc 100644
--- a/net/netfilter/nf_flow_table_core.c
+++ b/net/netfilter/nf_flow_table_core.c
@@ -316,12 +316,6 @@ void flow_offload_refresh(struct nf_flowtable *flow_table,
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
@@ -407,12 +401,18 @@ nf_flow_table_iterate(struct nf_flowtable *flow_table,
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
index abc71a06d634a..2b5ef83e44243 100644
--- a/net/sched/act_ct.c
+++ b/net/sched/act_ct.c
@@ -278,7 +278,14 @@ static int tcf_ct_flow_table_fill_actions(struct net *net,
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
2.42.0



