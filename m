Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD7EB7489B0
	for <lists+stable@lfdr.de>; Wed,  5 Jul 2023 18:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbjGEQz1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 5 Jul 2023 12:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbjGEQz0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 5 Jul 2023 12:55:26 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0983910EA;
        Wed,  5 Jul 2023 09:55:24 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     sashal@kernel.org, gregkh@linuxfoundation.org,
        stable@vger.kernel.org
Subject: [PATCH -stable,4.19 04/10] netfilter: add helper function to set up the nfnetlink header and use it
Date:   Wed,  5 Jul 2023 18:55:10 +0200
Message-Id: <20230705165516.50145-5-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230705165516.50145-1-pablo@netfilter.org>
References: <20230705165516.50145-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

[ 19c28b1374fb1073a9ec873a6c10bf5f16b10b9d ]

This patch adds a helper function to set up the netlink and nfnetlink headers.
Update existing codebase to use it.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 include/linux/netfilter/nfnetlink.h  |  27 +++++++
 net/netfilter/ipset/ip_set_core.c    |  17 +----
 net/netfilter/nf_conntrack_netlink.c |  77 ++++++--------------
 net/netfilter/nf_tables_api.c        | 102 +++++++--------------------
 net/netfilter/nf_tables_trace.c      |   9 +--
 net/netfilter/nfnetlink_acct.c       |  11 +--
 net/netfilter/nfnetlink_cthelper.c   |  11 +--
 net/netfilter/nfnetlink_cttimeout.c  |  22 ++----
 net/netfilter/nfnetlink_log.c        |  11 +--
 net/netfilter/nfnetlink_queue.c      |  12 ++--
 net/netfilter/nft_compat.c           |  11 +--
 11 files changed, 102 insertions(+), 208 deletions(-)

diff --git a/include/linux/netfilter/nfnetlink.h b/include/linux/netfilter/nfnetlink.h
index a806803fbe37..de206e410ee2 100644
--- a/include/linux/netfilter/nfnetlink.h
+++ b/include/linux/netfilter/nfnetlink.h
@@ -49,6 +49,33 @@ static inline u16 nfnl_msg_type(u8 subsys, u8 msg_type)
 	return subsys << 8 | msg_type;
 }
 
+static inline void nfnl_fill_hdr(struct nlmsghdr *nlh, u8 family, u8 version,
+				 __be16 res_id)
+{
+	struct nfgenmsg *nfmsg;
+
+	nfmsg = nlmsg_data(nlh);
+	nfmsg->nfgen_family = family;
+	nfmsg->version = version;
+	nfmsg->res_id = res_id;
+}
+
+static inline struct nlmsghdr *nfnl_msg_put(struct sk_buff *skb, u32 portid,
+					    u32 seq, int type, int flags,
+					    u8 family, u8 version,
+					    __be16 res_id)
+{
+	struct nlmsghdr *nlh;
+
+	nlh = nlmsg_put(skb, portid, seq, type, sizeof(struct nfgenmsg), flags);
+	if (!nlh)
+		return NULL;
+
+	nfnl_fill_hdr(nlh, family, version, res_id);
+
+	return nlh;
+}
+
 void nfnl_lock(__u8 subsys_id);
 void nfnl_unlock(__u8 subsys_id);
 #ifdef CONFIG_PROVE_LOCKING
diff --git a/net/netfilter/ipset/ip_set_core.c b/net/netfilter/ipset/ip_set_core.c
index 0427e66bc478..31756d1bf83e 100644
--- a/net/netfilter/ipset/ip_set_core.c
+++ b/net/netfilter/ipset/ip_set_core.c
@@ -791,20 +791,9 @@ static struct nlmsghdr *
 start_msg(struct sk_buff *skb, u32 portid, u32 seq, unsigned int flags,
 	  enum ipset_cmd cmd)
 {
-	struct nlmsghdr *nlh;
-	struct nfgenmsg *nfmsg;
-
-	nlh = nlmsg_put(skb, portid, seq, nfnl_msg_type(NFNL_SUBSYS_IPSET, cmd),
-			sizeof(*nfmsg), flags);
-	if (!nlh)
-		return NULL;
-
-	nfmsg = nlmsg_data(nlh);
-	nfmsg->nfgen_family = NFPROTO_IPV4;
-	nfmsg->version = NFNETLINK_V0;
-	nfmsg->res_id = 0;
-
-	return nlh;
+	return nfnl_msg_put(skb, portid, seq,
+			    nfnl_msg_type(NFNL_SUBSYS_IPSET, cmd), flags,
+			    NFPROTO_IPV4, NFNETLINK_V0, 0);
 }
 
 /* Create a set */
diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conntrack_netlink.c
index b710889a90f6..83e8566ec3f0 100644
--- a/net/netfilter/nf_conntrack_netlink.c
+++ b/net/netfilter/nf_conntrack_netlink.c
@@ -517,20 +517,15 @@ ctnetlink_fill_info(struct sk_buff *skb, u32 portid, u32 seq, u32 type,
 {
 	const struct nf_conntrack_zone *zone;
 	struct nlmsghdr *nlh;
-	struct nfgenmsg *nfmsg;
 	struct nlattr *nest_parms;
 	unsigned int flags = portid ? NLM_F_MULTI : 0, event;
 
 	event = nfnl_msg_type(NFNL_SUBSYS_CTNETLINK, IPCTNL_MSG_CT_NEW);
-	nlh = nlmsg_put(skb, portid, seq, event, sizeof(*nfmsg), flags);
-	if (nlh == NULL)
+	nlh = nfnl_msg_put(skb, portid, seq, event, flags, nf_ct_l3num(ct),
+			   NFNETLINK_V0, 0);
+	if (!nlh)
 		goto nlmsg_failure;
 
-	nfmsg = nlmsg_data(nlh);
-	nfmsg->nfgen_family = nf_ct_l3num(ct);
-	nfmsg->version      = NFNETLINK_V0;
-	nfmsg->res_id	    = 0;
-
 	zone = nf_ct_zone(ct);
 
 	nest_parms = nla_nest_start(skb, CTA_TUPLE_ORIG | NLA_F_NESTED);
@@ -687,7 +682,6 @@ ctnetlink_conntrack_event(unsigned int events, struct nf_ct_event *item)
 	const struct nf_conntrack_zone *zone;
 	struct net *net;
 	struct nlmsghdr *nlh;
-	struct nfgenmsg *nfmsg;
 	struct nlattr *nest_parms;
 	struct nf_conn *ct = item->ct;
 	struct sk_buff *skb;
@@ -717,15 +711,11 @@ ctnetlink_conntrack_event(unsigned int events, struct nf_ct_event *item)
 		goto errout;
 
 	type = nfnl_msg_type(NFNL_SUBSYS_CTNETLINK, type);
-	nlh = nlmsg_put(skb, item->portid, 0, type, sizeof(*nfmsg), flags);
-	if (nlh == NULL)
+	nlh = nfnl_msg_put(skb, item->portid, 0, type, flags, nf_ct_l3num(ct),
+			   NFNETLINK_V0, 0);
+	if (!nlh)
 		goto nlmsg_failure;
 
-	nfmsg = nlmsg_data(nlh);
-	nfmsg->nfgen_family = nf_ct_l3num(ct);
-	nfmsg->version	= NFNETLINK_V0;
-	nfmsg->res_id	= 0;
-
 	zone = nf_ct_zone(ct);
 
 	nest_parms = nla_nest_start(skb, CTA_TUPLE_ORIG | NLA_F_NESTED);
@@ -2170,20 +2160,15 @@ ctnetlink_ct_stat_cpu_fill_info(struct sk_buff *skb, u32 portid, u32 seq,
 				__u16 cpu, const struct ip_conntrack_stat *st)
 {
 	struct nlmsghdr *nlh;
-	struct nfgenmsg *nfmsg;
 	unsigned int flags = portid ? NLM_F_MULTI : 0, event;
 
 	event = nfnl_msg_type(NFNL_SUBSYS_CTNETLINK,
 			      IPCTNL_MSG_CT_GET_STATS_CPU);
-	nlh = nlmsg_put(skb, portid, seq, event, sizeof(*nfmsg), flags);
-	if (nlh == NULL)
+	nlh = nfnl_msg_put(skb, portid, seq, event, flags, AF_UNSPEC,
+			   NFNETLINK_V0, htons(cpu));
+	if (!nlh)
 		goto nlmsg_failure;
 
-	nfmsg = nlmsg_data(nlh);
-	nfmsg->nfgen_family = AF_UNSPEC;
-	nfmsg->version      = NFNETLINK_V0;
-	nfmsg->res_id	    = htons(cpu);
-
 	if (nla_put_be32(skb, CTA_STATS_FOUND, htonl(st->found)) ||
 	    nla_put_be32(skb, CTA_STATS_INVALID, htonl(st->invalid)) ||
 	    nla_put_be32(skb, CTA_STATS_IGNORE, htonl(st->ignore)) ||
@@ -2254,20 +2239,15 @@ ctnetlink_stat_ct_fill_info(struct sk_buff *skb, u32 portid, u32 seq, u32 type,
 			    struct net *net)
 {
 	struct nlmsghdr *nlh;
-	struct nfgenmsg *nfmsg;
 	unsigned int flags = portid ? NLM_F_MULTI : 0, event;
 	unsigned int nr_conntracks = atomic_read(&net->ct.count);
 
 	event = nfnl_msg_type(NFNL_SUBSYS_CTNETLINK, IPCTNL_MSG_CT_GET_STATS);
-	nlh = nlmsg_put(skb, portid, seq, event, sizeof(*nfmsg), flags);
-	if (nlh == NULL)
+	nlh = nfnl_msg_put(skb, portid, seq, event, flags, AF_UNSPEC,
+			   NFNETLINK_V0, 0);
+	if (!nlh)
 		goto nlmsg_failure;
 
-	nfmsg = nlmsg_data(nlh);
-	nfmsg->nfgen_family = AF_UNSPEC;
-	nfmsg->version      = NFNETLINK_V0;
-	nfmsg->res_id	    = 0;
-
 	if (nla_put_be32(skb, CTA_STATS_GLOBAL_ENTRIES, htonl(nr_conntracks)))
 		goto nla_put_failure;
 
@@ -2780,19 +2760,14 @@ ctnetlink_exp_fill_info(struct sk_buff *skb, u32 portid, u32 seq,
 			int event, const struct nf_conntrack_expect *exp)
 {
 	struct nlmsghdr *nlh;
-	struct nfgenmsg *nfmsg;
 	unsigned int flags = portid ? NLM_F_MULTI : 0;
 
 	event = nfnl_msg_type(NFNL_SUBSYS_CTNETLINK_EXP, event);
-	nlh = nlmsg_put(skb, portid, seq, event, sizeof(*nfmsg), flags);
-	if (nlh == NULL)
+	nlh = nfnl_msg_put(skb, portid, seq, event, flags,
+			   exp->tuple.src.l3num, NFNETLINK_V0, 0);
+	if (!nlh)
 		goto nlmsg_failure;
 
-	nfmsg = nlmsg_data(nlh);
-	nfmsg->nfgen_family = exp->tuple.src.l3num;
-	nfmsg->version	    = NFNETLINK_V0;
-	nfmsg->res_id	    = 0;
-
 	if (ctnetlink_exp_dump_expect(skb, exp) < 0)
 		goto nla_put_failure;
 
@@ -2812,7 +2787,6 @@ ctnetlink_expect_event(unsigned int events, struct nf_exp_event *item)
 	struct nf_conntrack_expect *exp = item->exp;
 	struct net *net = nf_ct_exp_net(exp);
 	struct nlmsghdr *nlh;
-	struct nfgenmsg *nfmsg;
 	struct sk_buff *skb;
 	unsigned int type, group;
 	int flags = 0;
@@ -2835,15 +2809,11 @@ ctnetlink_expect_event(unsigned int events, struct nf_exp_event *item)
 		goto errout;
 
 	type = nfnl_msg_type(NFNL_SUBSYS_CTNETLINK_EXP, type);
-	nlh = nlmsg_put(skb, item->portid, 0, type, sizeof(*nfmsg), flags);
-	if (nlh == NULL)
+	nlh = nfnl_msg_put(skb, item->portid, 0, type, flags,
+			   exp->tuple.src.l3num, NFNETLINK_V0, 0);
+	if (!nlh)
 		goto nlmsg_failure;
 
-	nfmsg = nlmsg_data(nlh);
-	nfmsg->nfgen_family = exp->tuple.src.l3num;
-	nfmsg->version	    = NFNETLINK_V0;
-	nfmsg->res_id	    = 0;
-
 	if (ctnetlink_exp_dump_expect(skb, exp) < 0)
 		goto nla_put_failure;
 
@@ -3413,20 +3383,15 @@ ctnetlink_exp_stat_fill_info(struct sk_buff *skb, u32 portid, u32 seq, int cpu,
 			     const struct ip_conntrack_stat *st)
 {
 	struct nlmsghdr *nlh;
-	struct nfgenmsg *nfmsg;
 	unsigned int flags = portid ? NLM_F_MULTI : 0, event;
 
 	event = nfnl_msg_type(NFNL_SUBSYS_CTNETLINK,
 			      IPCTNL_MSG_EXP_GET_STATS_CPU);
-	nlh = nlmsg_put(skb, portid, seq, event, sizeof(*nfmsg), flags);
-	if (nlh == NULL)
+	nlh = nfnl_msg_put(skb, portid, seq, event, flags, AF_UNSPEC,
+			   NFNETLINK_V0, htons(cpu));
+	if (!nlh)
 		goto nlmsg_failure;
 
-	nfmsg = nlmsg_data(nlh);
-	nfmsg->nfgen_family = AF_UNSPEC;
-	nfmsg->version      = NFNETLINK_V0;
-	nfmsg->res_id	    = htons(cpu);
-
 	if (nla_put_be32(skb, CTA_STATS_EXP_NEW, htonl(st->expect_new)) ||
 	    nla_put_be32(skb, CTA_STATS_EXP_CREATE, htonl(st->expect_create)) ||
 	    nla_put_be32(skb, CTA_STATS_EXP_DELETE, htonl(st->expect_delete)))
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 154bdcc27d72..bd9a6fa13b36 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -578,18 +578,13 @@ static int nf_tables_fill_table_info(struct sk_buff *skb, struct net *net,
 				     int family, const struct nft_table *table)
 {
 	struct nlmsghdr *nlh;
-	struct nfgenmsg *nfmsg;
 
 	event = nfnl_msg_type(NFNL_SUBSYS_NFTABLES, event);
-	nlh = nlmsg_put(skb, portid, seq, event, sizeof(struct nfgenmsg), flags);
-	if (nlh == NULL)
+	nlh = nfnl_msg_put(skb, portid, seq, event, flags, family,
+			   NFNETLINK_V0, nft_base_seq(net));
+	if (!nlh)
 		goto nla_put_failure;
 
-	nfmsg = nlmsg_data(nlh);
-	nfmsg->nfgen_family	= family;
-	nfmsg->version		= NFNETLINK_V0;
-	nfmsg->res_id		= nft_base_seq(net);
-
 	if (nla_put_string(skb, NFTA_TABLE_NAME, table->name) ||
 	    nla_put_be32(skb, NFTA_TABLE_FLAGS, htonl(table->flags)) ||
 	    nla_put_be32(skb, NFTA_TABLE_USE, htonl(table->use)) ||
@@ -1213,18 +1208,13 @@ static int nf_tables_fill_chain_info(struct sk_buff *skb, struct net *net,
 				     const struct nft_chain *chain)
 {
 	struct nlmsghdr *nlh;
-	struct nfgenmsg *nfmsg;
 
 	event = nfnl_msg_type(NFNL_SUBSYS_NFTABLES, event);
-	nlh = nlmsg_put(skb, portid, seq, event, sizeof(struct nfgenmsg), flags);
-	if (nlh == NULL)
+	nlh = nfnl_msg_put(skb, portid, seq, event, flags, family,
+			   NFNETLINK_V0, nft_base_seq(net));
+	if (!nlh)
 		goto nla_put_failure;
 
-	nfmsg = nlmsg_data(nlh);
-	nfmsg->nfgen_family	= family;
-	nfmsg->version		= NFNETLINK_V0;
-	nfmsg->res_id		= nft_base_seq(net);
-
 	if (nla_put_string(skb, NFTA_CHAIN_TABLE, table->name))
 		goto nla_put_failure;
 	if (nla_put_be64(skb, NFTA_CHAIN_HANDLE, cpu_to_be64(chain->handle),
@@ -2257,21 +2247,16 @@ static int nf_tables_fill_rule_info(struct sk_buff *skb, struct net *net,
 				    const struct nft_rule *rule)
 {
 	struct nlmsghdr *nlh;
-	struct nfgenmsg *nfmsg;
 	const struct nft_expr *expr, *next;
 	struct nlattr *list;
 	const struct nft_rule *prule;
 	u16 type = nfnl_msg_type(NFNL_SUBSYS_NFTABLES, event);
 
-	nlh = nlmsg_put(skb, portid, seq, type, sizeof(struct nfgenmsg), flags);
-	if (nlh == NULL)
+	nlh = nfnl_msg_put(skb, portid, seq, type, flags, family, NFNETLINK_V0,
+			   nft_base_seq(net));
+	if (!nlh)
 		goto nla_put_failure;
 
-	nfmsg = nlmsg_data(nlh);
-	nfmsg->nfgen_family	= family;
-	nfmsg->version		= NFNETLINK_V0;
-	nfmsg->res_id		= nft_base_seq(net);
-
 	if (nla_put_string(skb, NFTA_RULE_TABLE, table->name))
 		goto nla_put_failure;
 	if (nla_put_string(skb, NFTA_RULE_CHAIN, chain->name))
@@ -3166,23 +3151,17 @@ static __be64 nf_jiffies64_to_msecs(u64 input)
 static int nf_tables_fill_set(struct sk_buff *skb, const struct nft_ctx *ctx,
 			      const struct nft_set *set, u16 event, u16 flags)
 {
-	struct nfgenmsg *nfmsg;
 	struct nlmsghdr *nlh;
 	struct nlattr *desc;
 	u32 portid = ctx->portid;
 	u32 seq = ctx->seq;
 
 	event = nfnl_msg_type(NFNL_SUBSYS_NFTABLES, event);
-	nlh = nlmsg_put(skb, portid, seq, event, sizeof(struct nfgenmsg),
-			flags);
-	if (nlh == NULL)
+	nlh = nfnl_msg_put(skb, portid, seq, event, flags, ctx->family,
+			   NFNETLINK_V0, nft_base_seq(ctx->net));
+	if (!nlh)
 		goto nla_put_failure;
 
-	nfmsg = nlmsg_data(nlh);
-	nfmsg->nfgen_family	= ctx->family;
-	nfmsg->version		= NFNETLINK_V0;
-	nfmsg->res_id		= nft_base_seq(ctx->net);
-
 	if (nla_put_string(skb, NFTA_SET_TABLE, ctx->table->name))
 		goto nla_put_failure;
 	if (nla_put_string(skb, NFTA_SET_NAME, set->name))
@@ -3996,7 +3975,6 @@ static int nf_tables_dump_set(struct sk_buff *skb, struct netlink_callback *cb)
 	struct nft_set *set;
 	struct nft_set_dump_args args;
 	bool set_found = false;
-	struct nfgenmsg *nfmsg;
 	struct nlmsghdr *nlh;
 	struct nlattr *nest;
 	u32 portid, seq;
@@ -4029,16 +4007,11 @@ static int nf_tables_dump_set(struct sk_buff *skb, struct netlink_callback *cb)
 	portid = NETLINK_CB(cb->skb).portid;
 	seq    = cb->nlh->nlmsg_seq;
 
-	nlh = nlmsg_put(skb, portid, seq, event, sizeof(struct nfgenmsg),
-			NLM_F_MULTI);
-	if (nlh == NULL)
+	nlh = nfnl_msg_put(skb, portid, seq, event, NLM_F_MULTI,
+			   table->family, NFNETLINK_V0, nft_base_seq(net));
+	if (!nlh)
 		goto nla_put_failure;
 
-	nfmsg = nlmsg_data(nlh);
-	nfmsg->nfgen_family = table->family;
-	nfmsg->version      = NFNETLINK_V0;
-	nfmsg->res_id	    = nft_base_seq(net);
-
 	if (nla_put_string(skb, NFTA_SET_ELEM_LIST_TABLE, table->name))
 		goto nla_put_failure;
 	if (nla_put_string(skb, NFTA_SET_ELEM_LIST_SET, set->name))
@@ -4095,22 +4068,16 @@ static int nf_tables_fill_setelem_info(struct sk_buff *skb,
 				       const struct nft_set *set,
 				       const struct nft_set_elem *elem)
 {
-	struct nfgenmsg *nfmsg;
 	struct nlmsghdr *nlh;
 	struct nlattr *nest;
 	int err;
 
 	event = nfnl_msg_type(NFNL_SUBSYS_NFTABLES, event);
-	nlh = nlmsg_put(skb, portid, seq, event, sizeof(struct nfgenmsg),
-			flags);
-	if (nlh == NULL)
+	nlh = nfnl_msg_put(skb, portid, seq, event, flags, ctx->family,
+			   NFNETLINK_V0, nft_base_seq(ctx->net));
+	if (!nlh)
 		goto nla_put_failure;
 
-	nfmsg = nlmsg_data(nlh);
-	nfmsg->nfgen_family	= ctx->family;
-	nfmsg->version		= NFNETLINK_V0;
-	nfmsg->res_id		= nft_base_seq(ctx->net);
-
 	if (nla_put_string(skb, NFTA_SET_TABLE, ctx->table->name))
 		goto nla_put_failure;
 	if (nla_put_string(skb, NFTA_SET_NAME, set->name))
@@ -5146,19 +5113,14 @@ static int nf_tables_fill_obj_info(struct sk_buff *skb, struct net *net,
 				   int family, const struct nft_table *table,
 				   struct nft_object *obj, bool reset)
 {
-	struct nfgenmsg *nfmsg;
 	struct nlmsghdr *nlh;
 
 	event = nfnl_msg_type(NFNL_SUBSYS_NFTABLES, event);
-	nlh = nlmsg_put(skb, portid, seq, event, sizeof(struct nfgenmsg), flags);
-	if (nlh == NULL)
+	nlh = nfnl_msg_put(skb, portid, seq, event, flags, family,
+			   NFNETLINK_V0, nft_base_seq(net));
+	if (!nlh)
 		goto nla_put_failure;
 
-	nfmsg = nlmsg_data(nlh);
-	nfmsg->nfgen_family	= family;
-	nfmsg->version		= NFNETLINK_V0;
-	nfmsg->res_id		= nft_base_seq(net);
-
 	if (nla_put_string(skb, NFTA_OBJ_TABLE, table->name) ||
 	    nla_put_string(skb, NFTA_OBJ_NAME, obj->name) ||
 	    nla_put_be32(skb, NFTA_OBJ_TYPE, htonl(obj->ops->type->type)) ||
@@ -5806,20 +5768,15 @@ static int nf_tables_fill_flowtable_info(struct sk_buff *skb, struct net *net,
 					 struct nft_flowtable *flowtable)
 {
 	struct nlattr *nest, *nest_devs;
-	struct nfgenmsg *nfmsg;
 	struct nlmsghdr *nlh;
 	int i;
 
 	event = nfnl_msg_type(NFNL_SUBSYS_NFTABLES, event);
-	nlh = nlmsg_put(skb, portid, seq, event, sizeof(struct nfgenmsg), flags);
-	if (nlh == NULL)
+	nlh = nfnl_msg_put(skb, portid, seq, event, flags, family,
+			   NFNETLINK_V0, nft_base_seq(net));
+	if (!nlh)
 		goto nla_put_failure;
 
-	nfmsg = nlmsg_data(nlh);
-	nfmsg->nfgen_family	= family;
-	nfmsg->version		= NFNETLINK_V0;
-	nfmsg->res_id		= nft_base_seq(net);
-
 	if (nla_put_string(skb, NFTA_FLOWTABLE_TABLE, flowtable->table->name) ||
 	    nla_put_string(skb, NFTA_FLOWTABLE_NAME, flowtable->name) ||
 	    nla_put_be32(skb, NFTA_FLOWTABLE_USE, htonl(flowtable->use)) ||
@@ -6045,19 +6002,14 @@ static int nf_tables_fill_gen_info(struct sk_buff *skb, struct net *net,
 				   u32 portid, u32 seq)
 {
 	struct nlmsghdr *nlh;
-	struct nfgenmsg *nfmsg;
 	char buf[TASK_COMM_LEN];
 	int event = nfnl_msg_type(NFNL_SUBSYS_NFTABLES, NFT_MSG_NEWGEN);
 
-	nlh = nlmsg_put(skb, portid, seq, event, sizeof(struct nfgenmsg), 0);
-	if (nlh == NULL)
+	nlh = nfnl_msg_put(skb, portid, seq, event, 0, AF_UNSPEC,
+			   NFNETLINK_V0, nft_base_seq(net));
+	if (!nlh)
 		goto nla_put_failure;
 
-	nfmsg = nlmsg_data(nlh);
-	nfmsg->nfgen_family	= AF_UNSPEC;
-	nfmsg->version		= NFNETLINK_V0;
-	nfmsg->res_id		= nft_base_seq(net);
-
 	if (nla_put_be32(skb, NFTA_GEN_ID, htonl(net->nft.base_seq)) ||
 	    nla_put_be32(skb, NFTA_GEN_PROC_PID, htonl(task_pid_nr(current))) ||
 	    nla_put_string(skb, NFTA_GEN_PROC_NAME, get_task_comm(buf, current)))
diff --git a/net/netfilter/nf_tables_trace.c b/net/netfilter/nf_tables_trace.c
index e1dc527a493b..7a19c517b191 100644
--- a/net/netfilter/nf_tables_trace.c
+++ b/net/netfilter/nf_tables_trace.c
@@ -186,7 +186,6 @@ static bool nft_trace_have_verdict_chain(struct nft_traceinfo *info)
 void nft_trace_notify(struct nft_traceinfo *info)
 {
 	const struct nft_pktinfo *pkt = info->pkt;
-	struct nfgenmsg *nfmsg;
 	struct nlmsghdr *nlh;
 	struct sk_buff *skb;
 	unsigned int size;
@@ -222,15 +221,11 @@ void nft_trace_notify(struct nft_traceinfo *info)
 		return;
 
 	event = nfnl_msg_type(NFNL_SUBSYS_NFTABLES, NFT_MSG_TRACE);
-	nlh = nlmsg_put(skb, 0, 0, event, sizeof(struct nfgenmsg), 0);
+	nlh = nfnl_msg_put(skb, 0, 0, event, 0, info->basechain->type->family,
+			   NFNETLINK_V0, 0);
 	if (!nlh)
 		goto nla_put_failure;
 
-	nfmsg = nlmsg_data(nlh);
-	nfmsg->nfgen_family	= info->basechain->type->family;
-	nfmsg->version		= NFNETLINK_V0;
-	nfmsg->res_id		= 0;
-
 	if (nla_put_be32(skb, NFTA_TRACE_NFPROTO, htonl(nft_pf(pkt))))
 		goto nla_put_failure;
 
diff --git a/net/netfilter/nfnetlink_acct.c b/net/netfilter/nfnetlink_acct.c
index 8fa8bf7c48e6..7c5f428dc5c9 100644
--- a/net/netfilter/nfnetlink_acct.c
+++ b/net/netfilter/nfnetlink_acct.c
@@ -135,21 +135,16 @@ nfnl_acct_fill_info(struct sk_buff *skb, u32 portid, u32 seq, u32 type,
 		   int event, struct nf_acct *acct)
 {
 	struct nlmsghdr *nlh;
-	struct nfgenmsg *nfmsg;
 	unsigned int flags = portid ? NLM_F_MULTI : 0;
 	u64 pkts, bytes;
 	u32 old_flags;
 
 	event = nfnl_msg_type(NFNL_SUBSYS_ACCT, event);
-	nlh = nlmsg_put(skb, portid, seq, event, sizeof(*nfmsg), flags);
-	if (nlh == NULL)
+	nlh = nfnl_msg_put(skb, portid, seq, event, flags, AF_UNSPEC,
+			   NFNETLINK_V0, 0);
+	if (!nlh)
 		goto nlmsg_failure;
 
-	nfmsg = nlmsg_data(nlh);
-	nfmsg->nfgen_family = AF_UNSPEC;
-	nfmsg->version = NFNETLINK_V0;
-	nfmsg->res_id = 0;
-
 	if (nla_put_string(skb, NFACCT_NAME, acct->name))
 		goto nla_put_failure;
 
diff --git a/net/netfilter/nfnetlink_cthelper.c b/net/netfilter/nfnetlink_cthelper.c
index c8b0f1122c44..720177721e3c 100644
--- a/net/netfilter/nfnetlink_cthelper.c
+++ b/net/netfilter/nfnetlink_cthelper.c
@@ -532,20 +532,15 @@ nfnl_cthelper_fill_info(struct sk_buff *skb, u32 portid, u32 seq, u32 type,
 			int event, struct nf_conntrack_helper *helper)
 {
 	struct nlmsghdr *nlh;
-	struct nfgenmsg *nfmsg;
 	unsigned int flags = portid ? NLM_F_MULTI : 0;
 	int status;
 
 	event = nfnl_msg_type(NFNL_SUBSYS_CTHELPER, event);
-	nlh = nlmsg_put(skb, portid, seq, event, sizeof(*nfmsg), flags);
-	if (nlh == NULL)
+	nlh = nfnl_msg_put(skb, portid, seq, event, flags, AF_UNSPEC,
+			   NFNETLINK_V0, 0);
+	if (!nlh)
 		goto nlmsg_failure;
 
-	nfmsg = nlmsg_data(nlh);
-	nfmsg->nfgen_family = AF_UNSPEC;
-	nfmsg->version = NFNETLINK_V0;
-	nfmsg->res_id = 0;
-
 	if (nla_put_string(skb, NFCTH_NAME, helper->name))
 		goto nla_put_failure;
 
diff --git a/net/netfilter/nfnetlink_cttimeout.c b/net/netfilter/nfnetlink_cttimeout.c
index 70a7382b9787..ae01e9ad5546 100644
--- a/net/netfilter/nfnetlink_cttimeout.c
+++ b/net/netfilter/nfnetlink_cttimeout.c
@@ -164,20 +164,15 @@ ctnl_timeout_fill_info(struct sk_buff *skb, u32 portid, u32 seq, u32 type,
 		       int event, struct ctnl_timeout *timeout)
 {
 	struct nlmsghdr *nlh;
-	struct nfgenmsg *nfmsg;
 	unsigned int flags = portid ? NLM_F_MULTI : 0;
 	const struct nf_conntrack_l4proto *l4proto = timeout->timeout.l4proto;
 
 	event = nfnl_msg_type(NFNL_SUBSYS_CTNETLINK_TIMEOUT, event);
-	nlh = nlmsg_put(skb, portid, seq, event, sizeof(*nfmsg), flags);
-	if (nlh == NULL)
+	nlh = nfnl_msg_put(skb, portid, seq, event, flags, AF_UNSPEC,
+			   NFNETLINK_V0, 0);
+	if (!nlh)
 		goto nlmsg_failure;
 
-	nfmsg = nlmsg_data(nlh);
-	nfmsg->nfgen_family = AF_UNSPEC;
-	nfmsg->version = NFNETLINK_V0;
-	nfmsg->res_id = 0;
-
 	if (nla_put_string(skb, CTA_TIMEOUT_NAME, timeout->name) ||
 	    nla_put_be16(skb, CTA_TIMEOUT_L3PROTO,
 			 htons(timeout->timeout.l3num)) ||
@@ -396,19 +391,14 @@ cttimeout_default_fill_info(struct net *net, struct sk_buff *skb, u32 portid,
 			    const unsigned int *timeouts)
 {
 	struct nlmsghdr *nlh;
-	struct nfgenmsg *nfmsg;
 	unsigned int flags = portid ? NLM_F_MULTI : 0;
 
 	event = nfnl_msg_type(NFNL_SUBSYS_CTNETLINK_TIMEOUT, event);
-	nlh = nlmsg_put(skb, portid, seq, event, sizeof(*nfmsg), flags);
-	if (nlh == NULL)
+	nlh = nfnl_msg_put(skb, portid, seq, event, flags, AF_UNSPEC,
+			   NFNETLINK_V0, 0);
+	if (!nlh)
 		goto nlmsg_failure;
 
-	nfmsg = nlmsg_data(nlh);
-	nfmsg->nfgen_family = AF_UNSPEC;
-	nfmsg->version = NFNETLINK_V0;
-	nfmsg->res_id = 0;
-
 	if (nla_put_be16(skb, CTA_TIMEOUT_L3PROTO, htons(l4proto->l3proto)) ||
 	    nla_put_u8(skb, CTA_TIMEOUT_L4PROTO, l4proto->l4proto))
 		goto nla_put_failure;
diff --git a/net/netfilter/nfnetlink_log.c b/net/netfilter/nfnetlink_log.c
index 17ca9a681d47..dc0f08c10544 100644
--- a/net/netfilter/nfnetlink_log.c
+++ b/net/netfilter/nfnetlink_log.c
@@ -404,20 +404,15 @@ __build_packet_message(struct nfnl_log_net *log,
 {
 	struct nfulnl_msg_packet_hdr pmsg;
 	struct nlmsghdr *nlh;
-	struct nfgenmsg *nfmsg;
 	sk_buff_data_t old_tail = inst->skb->tail;
 	struct sock *sk;
 	const unsigned char *hwhdrp;
 
-	nlh = nlmsg_put(inst->skb, 0, 0,
-			nfnl_msg_type(NFNL_SUBSYS_ULOG, NFULNL_MSG_PACKET),
-			sizeof(struct nfgenmsg), 0);
+	nlh = nfnl_msg_put(inst->skb, 0, 0,
+			   nfnl_msg_type(NFNL_SUBSYS_ULOG, NFULNL_MSG_PACKET),
+			   0, pf, NFNETLINK_V0, htons(inst->group_num));
 	if (!nlh)
 		return -1;
-	nfmsg = nlmsg_data(nlh);
-	nfmsg->nfgen_family = pf;
-	nfmsg->version = NFNETLINK_V0;
-	nfmsg->res_id = htons(inst->group_num);
 
 	memset(&pmsg, 0, sizeof(pmsg));
 	pmsg.hw_protocol	= skb->protocol;
diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_queue.c
index cd496b074a71..d6b1b2feb58c 100644
--- a/net/netfilter/nfnetlink_queue.c
+++ b/net/netfilter/nfnetlink_queue.c
@@ -387,7 +387,6 @@ nfqnl_build_packet_message(struct net *net, struct nfqnl_instance *queue,
 	struct nlattr *nla;
 	struct nfqnl_msg_packet_hdr *pmsg;
 	struct nlmsghdr *nlh;
-	struct nfgenmsg *nfmsg;
 	struct sk_buff *entskb = entry->skb;
 	struct net_device *indev;
 	struct net_device *outdev;
@@ -473,18 +472,15 @@ nfqnl_build_packet_message(struct net *net, struct nfqnl_instance *queue,
 		goto nlmsg_failure;
 	}
 
-	nlh = nlmsg_put(skb, 0, 0,
-			nfnl_msg_type(NFNL_SUBSYS_QUEUE, NFQNL_MSG_PACKET),
-			sizeof(struct nfgenmsg), 0);
+	nlh = nfnl_msg_put(skb, 0, 0,
+			   nfnl_msg_type(NFNL_SUBSYS_QUEUE, NFQNL_MSG_PACKET),
+			   0, entry->state.pf, NFNETLINK_V0,
+			   htons(queue->queue_num));
 	if (!nlh) {
 		skb_tx_error(entskb);
 		kfree_skb(skb);
 		goto nlmsg_failure;
 	}
-	nfmsg = nlmsg_data(nlh);
-	nfmsg->nfgen_family = entry->state.pf;
-	nfmsg->version = NFNETLINK_V0;
-	nfmsg->res_id = htons(queue->queue_num);
 
 	nla = __nla_reserve(skb, NFQA_PACKET_HDR, sizeof(*pmsg));
 	pmsg = nla_data(nla);
diff --git a/net/netfilter/nft_compat.c b/net/netfilter/nft_compat.c
index 469f9da5073b..2846d64659f2 100644
--- a/net/netfilter/nft_compat.c
+++ b/net/netfilter/nft_compat.c
@@ -575,19 +575,14 @@ nfnl_compat_fill_info(struct sk_buff *skb, u32 portid, u32 seq, u32 type,
 		      int rev, int target)
 {
 	struct nlmsghdr *nlh;
-	struct nfgenmsg *nfmsg;
 	unsigned int flags = portid ? NLM_F_MULTI : 0;
 
 	event = nfnl_msg_type(NFNL_SUBSYS_NFT_COMPAT, event);
-	nlh = nlmsg_put(skb, portid, seq, event, sizeof(*nfmsg), flags);
-	if (nlh == NULL)
+	nlh = nfnl_msg_put(skb, portid, seq, event, flags, family,
+			   NFNETLINK_V0, 0);
+	if (!nlh)
 		goto nlmsg_failure;
 
-	nfmsg = nlmsg_data(nlh);
-	nfmsg->nfgen_family = family;
-	nfmsg->version = NFNETLINK_V0;
-	nfmsg->res_id = 0;
-
 	if (nla_put_string(skb, NFTA_COMPAT_NAME, name) ||
 	    nla_put_be32(skb, NFTA_COMPAT_REV, htonl(rev)) ||
 	    nla_put_be32(skb, NFTA_COMPAT_TYPE, htonl(target)))
-- 
2.30.2

