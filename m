Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66E1D761708
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbjGYLoB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235386AbjGYLn3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:43:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C921BCF;
        Tue, 25 Jul 2023 04:43:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A50F616CE;
        Tue, 25 Jul 2023 11:42:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 230DFC433C8;
        Tue, 25 Jul 2023 11:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690285375;
        bh=EOpIhLGWL0X2M1Nvz1PRnrt9vHN/6ODXkPx84Jgs82o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cNmx07zYWDb5UvH2WrkDE0ZwXl9b0Vft0A2E/gEexTTnR0WBaqAnPa5kn4Mu3VyGd
         JrhF1DmfQ7Q3TaQ7vMH1yUsBVXEZ9fpx5iABC5QRmLu650vnH+e4mr0Rc0koE/6lh3
         3mvbdJZfqzPgZ7xCt6ahuEkrnCnHg9rNvSMTrDio=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org, netfilter-devel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 5.4 182/313] netfilter: nf_tables: use net_generic infra for transaction data
Date:   Tue, 25 Jul 2023 12:45:35 +0200
Message-ID: <20230725104528.826653583@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104521.167250627@linuxfoundation.org>
References: <20230725104521.167250627@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Florian Westphal <fw@strlen.de>

[ 0854db2aaef3fcdd3498a9d299c60adea2aa3dc6 ]

This moves all nf_tables pernet data from struct net to a net_generic
extension, with the exception of the gencursor.

The latter is used in the data path and also outside of the nf_tables
core. All others are only used from the configuration plane.

Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/netfilter/nf_tables.h |   10 +
 include/net/netns/nftables.h      |    6 
 net/netfilter/nf_tables_api.c     |  330 +++++++++++++++++++++++---------------
 net/netfilter/nf_tables_offload.c |   29 ++-
 net/netfilter/nft_chain_filter.c  |   11 -
 net/netfilter/nft_dynset.c        |    6 
 6 files changed, 245 insertions(+), 147 deletions(-)

--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -1472,4 +1472,14 @@ void nf_tables_trans_destroy_flush_work(
 int nf_msecs_to_jiffies64(const struct nlattr *nla, u64 *result);
 __be64 nf_jiffies64_to_msecs(u64 input);
 
+struct nftables_pernet {
+	struct list_head	tables;
+	struct list_head	commit_list;
+	struct list_head	module_list;
+	struct list_head	notify_list;
+	struct mutex		commit_mutex;
+	unsigned int		base_seq;
+	u8			validate_state;
+};
+
 #endif /* _NET_NF_TABLES_H */
--- a/include/net/netns/nftables.h
+++ b/include/net/netns/nftables.h
@@ -5,13 +5,7 @@
 #include <linux/list.h>
 
 struct netns_nftables {
-	struct list_head	tables;
-	struct list_head	commit_list;
-	struct list_head	module_list;
-	struct mutex		commit_mutex;
-	unsigned int		base_seq;
 	u8			gencursor;
-	u8			validate_state;
 };
 
 #endif
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -20,10 +20,13 @@
 #include <net/netfilter/nf_tables.h>
 #include <net/netfilter/nf_tables_offload.h>
 #include <net/net_namespace.h>
+#include <net/netns/generic.h>
 #include <net/sock.h>
 
 #define NFT_MODULE_AUTOLOAD_LIMIT (MODULE_NAME_LEN - sizeof("nft-expr-255-"))
 
+unsigned int nf_tables_net_id __read_mostly;
+
 static LIST_HEAD(nf_tables_expressions);
 static LIST_HEAD(nf_tables_objects);
 static LIST_HEAD(nf_tables_flowtables);
@@ -67,7 +70,9 @@ static const struct rhashtable_params nf
 
 static void nft_validate_state_update(struct net *net, u8 new_validate_state)
 {
-	switch (net->nft.validate_state) {
+	struct nftables_pernet *nft_net = net_generic(net, nf_tables_net_id);
+
+	switch (nft_net->validate_state) {
 	case NFT_VALIDATE_SKIP:
 		WARN_ON_ONCE(new_validate_state == NFT_VALIDATE_DO);
 		break;
@@ -78,7 +83,7 @@ static void nft_validate_state_update(st
 			return;
 	}
 
-	net->nft.validate_state = new_validate_state;
+	nft_net->validate_state = new_validate_state;
 }
 static void nf_tables_trans_destroy_work(struct work_struct *w);
 static DECLARE_WORK(trans_destroy_work, nf_tables_trans_destroy_work);
@@ -134,13 +139,15 @@ static void nft_trans_destroy(struct nft
 
 static void nft_set_trans_bind(const struct nft_ctx *ctx, struct nft_set *set)
 {
+	struct nftables_pernet *nft_net;
 	struct net *net = ctx->net;
 	struct nft_trans *trans;
 
 	if (!nft_set_is_anonymous(set))
 		return;
 
-	list_for_each_entry_reverse(trans, &net->nft.commit_list, list) {
+	nft_net = net_generic(net, nf_tables_net_id);
+	list_for_each_entry_reverse(trans, &nft_net->commit_list, list) {
 		switch (trans->msg_type) {
 		case NFT_MSG_NEWSET:
 			if (nft_trans_set(trans) == set)
@@ -154,6 +161,14 @@ static void nft_set_trans_bind(const str
 	}
 }
 
+static void nft_trans_commit_list_add_tail(struct net *net, struct nft_trans *trans)
+{
+	struct nftables_pernet *nft_net;
+
+	nft_net = net_generic(net, nf_tables_net_id);
+	list_add_tail(&trans->list, &nft_net->commit_list);
+}
+
 static int nf_tables_register_hook(struct net *net,
 				   const struct nft_table *table,
 				   struct nft_chain *chain)
@@ -204,7 +219,7 @@ static int nft_trans_table_add(struct nf
 	if (msg_type == NFT_MSG_NEWTABLE)
 		nft_activate_next(ctx->net, ctx->table);
 
-	list_add_tail(&trans->list, &ctx->net->nft.commit_list);
+	nft_trans_commit_list_add_tail(ctx->net, trans);
 	return 0;
 }
 
@@ -231,7 +246,7 @@ static struct nft_trans *nft_trans_chain
 	if (msg_type == NFT_MSG_NEWCHAIN)
 		nft_activate_next(ctx->net, ctx->chain);
 
-	list_add_tail(&trans->list, &ctx->net->nft.commit_list);
+	nft_trans_commit_list_add_tail(ctx->net, trans);
 	return trans;
 }
 
@@ -304,7 +319,7 @@ static struct nft_trans *nft_trans_rule_
 			ntohl(nla_get_be32(ctx->nla[NFTA_RULE_ID]));
 	}
 	nft_trans_rule(trans) = rule;
-	list_add_tail(&trans->list, &ctx->net->nft.commit_list);
+	nft_trans_commit_list_add_tail(ctx->net, trans);
 
 	return trans;
 }
@@ -359,7 +374,7 @@ static int nft_trans_set_add(const struc
 		nft_activate_next(ctx->net, set);
 	}
 	nft_trans_set(trans) = set;
-	list_add_tail(&trans->list, &ctx->net->nft.commit_list);
+	nft_trans_commit_list_add_tail(ctx->net, trans);
 
 	return 0;
 }
@@ -391,7 +406,7 @@ static int nft_trans_obj_add(struct nft_
 		nft_activate_next(ctx->net, obj);
 
 	nft_trans_obj(trans) = obj;
-	list_add_tail(&trans->list, &ctx->net->nft.commit_list);
+	nft_trans_commit_list_add_tail(ctx->net, trans);
 
 	return 0;
 }
@@ -424,7 +439,7 @@ static int nft_trans_flowtable_add(struc
 		nft_activate_next(ctx->net, flowtable);
 
 	nft_trans_flowtable(trans) = flowtable;
-	list_add_tail(&trans->list, &ctx->net->nft.commit_list);
+	nft_trans_commit_list_add_tail(ctx->net, trans);
 
 	return 0;
 }
@@ -452,13 +467,15 @@ static struct nft_table *nft_table_looku
 					  const struct nlattr *nla,
 					  u8 family, u8 genmask)
 {
+	struct nftables_pernet *nft_net;
 	struct nft_table *table;
 
 	if (nla == NULL)
 		return ERR_PTR(-EINVAL);
 
-	list_for_each_entry_rcu(table, &net->nft.tables, list,
-				lockdep_is_held(&net->nft.commit_mutex)) {
+	nft_net = net_generic(net, nf_tables_net_id);
+	list_for_each_entry_rcu(table, &nft_net->tables, list,
+				lockdep_is_held(&nft_net->commit_mutex)) {
 		if (!nla_strcmp(nla, table->name) &&
 		    table->family == family &&
 		    nft_active_genmask(table, genmask))
@@ -472,9 +489,11 @@ static struct nft_table *nft_table_looku
 						   const struct nlattr *nla,
 						   u8 genmask)
 {
+	struct nftables_pernet *nft_net;
 	struct nft_table *table;
 
-	list_for_each_entry(table, &net->nft.tables, list) {
+	nft_net = net_generic(net, nf_tables_net_id);
+	list_for_each_entry(table, &nft_net->tables, list) {
 		if (be64_to_cpu(nla_get_be64(nla)) == table->handle &&
 		    nft_active_genmask(table, genmask))
 			return table;
@@ -526,6 +545,7 @@ struct nft_module_request {
 static int nft_request_module(struct net *net, const char *fmt, ...)
 {
 	char module_name[MODULE_NAME_LEN];
+	struct nftables_pernet *nft_net;
 	struct nft_module_request *req;
 	va_list args;
 	int ret;
@@ -536,7 +556,8 @@ static int nft_request_module(struct net
 	if (ret >= MODULE_NAME_LEN)
 		return 0;
 
-	list_for_each_entry(req, &net->nft.module_list, list) {
+	nft_net = net_generic(net, nf_tables_net_id);
+	list_for_each_entry(req, &nft_net->module_list, list) {
 		if (!strcmp(req->module, module_name)) {
 			if (req->done)
 				return 0;
@@ -552,7 +573,7 @@ static int nft_request_module(struct net
 
 	req->done = false;
 	strlcpy(req->module, module_name, MODULE_NAME_LEN);
-	list_add_tail(&req->list, &net->nft.module_list);
+	list_add_tail(&req->list, &nft_net->module_list);
 
 	return -EAGAIN;
 }
@@ -590,7 +611,9 @@ nf_tables_chain_type_lookup(struct net *
 
 static __be16 nft_base_seq(const struct net *net)
 {
-	return htons(net->nft.base_seq & 0xffff);
+	struct nftables_pernet *nft_net = net_generic(net, nf_tables_net_id);
+
+	return htons(nft_net->base_seq & 0xffff);
 }
 
 static const struct nla_policy nft_table_policy[NFTA_TABLE_MAX + 1] = {
@@ -658,15 +681,17 @@ static int nf_tables_dump_tables(struct
 				 struct netlink_callback *cb)
 {
 	const struct nfgenmsg *nfmsg = nlmsg_data(cb->nlh);
+	struct nftables_pernet *nft_net;
 	const struct nft_table *table;
 	unsigned int idx = 0, s_idx = cb->args[0];
 	struct net *net = sock_net(skb->sk);
 	int family = nfmsg->nfgen_family;
 
 	rcu_read_lock();
-	cb->seq = net->nft.base_seq;
+	nft_net = net_generic(net, nf_tables_net_id);
+	cb->seq = nft_net->base_seq;
 
-	list_for_each_entry_rcu(table, &net->nft.tables, list) {
+	list_for_each_entry_rcu(table, &nft_net->tables, list) {
 		if (family != NFPROTO_UNSPEC && family != table->family)
 			continue;
 
@@ -840,7 +865,7 @@ static int nf_tables_updtable(struct nft
 		goto err;
 
 	nft_trans_table_update(trans) = true;
-	list_add_tail(&trans->list, &ctx->net->nft.commit_list);
+	nft_trans_commit_list_add_tail(ctx->net, trans);
 	return 0;
 err:
 	nft_trans_destroy(trans);
@@ -903,6 +928,7 @@ static int nf_tables_newtable(struct net
 			      const struct nlattr * const nla[],
 			      struct netlink_ext_ack *extack)
 {
+	struct nftables_pernet *nft_net = net_generic(net, nf_tables_net_id);
 	const struct nfgenmsg *nfmsg = nlmsg_data(nlh);
 	u8 genmask = nft_genmask_next(net);
 	int family = nfmsg->nfgen_family;
@@ -912,7 +938,7 @@ static int nf_tables_newtable(struct net
 	struct nft_ctx ctx;
 	int err;
 
-	lockdep_assert_held(&net->nft.commit_mutex);
+	lockdep_assert_held(&nft_net->commit_mutex);
 	attr = nla[NFTA_TABLE_NAME];
 	table = nft_table_lookup(net, attr, family, genmask);
 	if (IS_ERR(table)) {
@@ -962,7 +988,7 @@ static int nf_tables_newtable(struct net
 	if (err < 0)
 		goto err_trans;
 
-	list_add_tail_rcu(&table->list, &net->nft.tables);
+	list_add_tail_rcu(&table->list, &nft_net->tables);
 	return 0;
 err_trans:
 	rhltable_destroy(&table->chains_ht);
@@ -1042,11 +1068,12 @@ out:
 
 static int nft_flush(struct nft_ctx *ctx, int family)
 {
+	struct nftables_pernet *nft_net = net_generic(ctx->net, nf_tables_net_id);
 	struct nft_table *table, *nt;
 	const struct nlattr * const *nla = ctx->nla;
 	int err = 0;
 
-	list_for_each_entry_safe(table, nt, &ctx->net->nft.tables, list) {
+	list_for_each_entry_safe(table, nt, &nft_net->tables, list) {
 		if (family != AF_UNSPEC && table->family != family)
 			continue;
 
@@ -1160,7 +1187,9 @@ nft_chain_lookup_byhandle(const struct n
 static bool lockdep_commit_lock_is_held(const struct net *net)
 {
 #ifdef CONFIG_PROVE_LOCKING
-	return lockdep_is_held(&net->nft.commit_mutex);
+	struct nftables_pernet *nft_net = net_generic(net, nf_tables_net_id);
+
+	return lockdep_is_held(&nft_net->commit_mutex);
 #else
 	return true;
 #endif
@@ -1363,11 +1392,13 @@ static int nf_tables_dump_chains(struct
 	unsigned int idx = 0, s_idx = cb->args[0];
 	struct net *net = sock_net(skb->sk);
 	int family = nfmsg->nfgen_family;
+	struct nftables_pernet *nft_net;
 
 	rcu_read_lock();
-	cb->seq = net->nft.base_seq;
+	nft_net = net_generic(net, nf_tables_net_id);
+	cb->seq = nft_net->base_seq;
 
-	list_for_each_entry_rcu(table, &net->nft.tables, list) {
+	list_for_each_entry_rcu(table, &nft_net->tables, list) {
 		if (family != NFPROTO_UNSPEC && family != table->family)
 			continue;
 
@@ -1553,12 +1584,13 @@ static int nft_chain_parse_hook(struct n
 				struct nft_chain_hook *hook, u8 family,
 				bool autoload)
 {
+	struct nftables_pernet *nft_net = net_generic(net, nf_tables_net_id);
 	struct nlattr *ha[NFTA_HOOK_MAX + 1];
 	const struct nft_chain_type *type;
 	struct net_device *dev;
 	int err;
 
-	lockdep_assert_held(&net->nft.commit_mutex);
+	lockdep_assert_held(&nft_net->commit_mutex);
 	lockdep_nfnl_nft_mutex_not_held();
 
 	err = nla_parse_nested_deprecated(ha, NFTA_HOOK_MAX,
@@ -1843,6 +1875,7 @@ static int nf_tables_updchain(struct nft
 
 	if (nla[NFTA_CHAIN_HANDLE] &&
 	    nla[NFTA_CHAIN_NAME]) {
+		struct nftables_pernet *nft_net = net_generic(ctx->net, nf_tables_net_id);
 		struct nft_trans *tmp;
 		char *name;
 
@@ -1852,7 +1885,7 @@ static int nf_tables_updchain(struct nft
 			goto err;
 
 		err = -EEXIST;
-		list_for_each_entry(tmp, &ctx->net->nft.commit_list, list) {
+		list_for_each_entry(tmp, &nft_net->commit_list, list) {
 			if (tmp->msg_type == NFT_MSG_NEWCHAIN &&
 			    tmp->ctx.table == table &&
 			    nft_trans_chain_update(tmp) &&
@@ -1865,7 +1898,7 @@ static int nf_tables_updchain(struct nft
 
 		nft_trans_chain_name(trans) = name;
 	}
-	list_add_tail(&trans->list, &ctx->net->nft.commit_list);
+	nft_trans_commit_list_add_tail(ctx->net, trans);
 
 	return 0;
 err:
@@ -1879,6 +1912,7 @@ static int nf_tables_newchain(struct net
 			      const struct nlattr * const nla[],
 			      struct netlink_ext_ack *extack)
 {
+	struct nftables_pernet *nft_net = net_generic(net, nf_tables_net_id);
 	const struct nfgenmsg *nfmsg = nlmsg_data(nlh);
 	u8 genmask = nft_genmask_next(net);
 	int family = nfmsg->nfgen_family;
@@ -1890,7 +1924,7 @@ static int nf_tables_newchain(struct net
 	u64 handle = 0;
 	u32 flags = 0;
 
-	lockdep_assert_held(&net->nft.commit_mutex);
+	lockdep_assert_held(&nft_net->commit_mutex);
 
 	table = nft_table_lookup(net, nla[NFTA_CHAIN_TABLE], family, genmask);
 	if (IS_ERR(table)) {
@@ -2478,11 +2512,13 @@ static int nf_tables_dump_rules(struct s
 	unsigned int idx = 0;
 	struct net *net = sock_net(skb->sk);
 	int family = nfmsg->nfgen_family;
+	struct nftables_pernet *nft_net;
 
 	rcu_read_lock();
-	cb->seq = net->nft.base_seq;
+	nft_net = net_generic(net, nf_tables_net_id);
+	cb->seq = nft_net->base_seq;
 
-	list_for_each_entry_rcu(table, &net->nft.tables, list) {
+	list_for_each_entry_rcu(table, &nft_net->tables, list) {
 		if (family != NFPROTO_UNSPEC && family != table->family)
 			continue;
 
@@ -2715,6 +2751,7 @@ static int nf_tables_newrule(struct net
 			     const struct nlattr * const nla[],
 			     struct netlink_ext_ack *extack)
 {
+	struct nftables_pernet *nft_net = net_generic(net, nf_tables_net_id);
 	const struct nfgenmsg *nfmsg = nlmsg_data(nlh);
 	u8 genmask = nft_genmask_next(net);
 	struct nft_expr_info *info = NULL;
@@ -2732,7 +2769,7 @@ static int nf_tables_newrule(struct net
 	int err, rem;
 	u64 handle, pos_handle;
 
-	lockdep_assert_held(&net->nft.commit_mutex);
+	lockdep_assert_held(&nft_net->commit_mutex);
 
 	table = nft_table_lookup(net, nla[NFTA_RULE_TABLE], family, genmask);
 	if (IS_ERR(table)) {
@@ -2887,7 +2924,7 @@ static int nf_tables_newrule(struct net
 	kvfree(info);
 	chain->use++;
 
-	if (net->nft.validate_state == NFT_VALIDATE_DO)
+	if (nft_net->validate_state == NFT_VALIDATE_DO)
 		return nft_table_validate(net, table);
 
 	if (chain->flags & NFT_CHAIN_HW_OFFLOAD) {
@@ -2917,10 +2954,11 @@ static struct nft_rule *nft_rule_lookup_
 					     const struct nft_chain *chain,
 					     const struct nlattr *nla)
 {
+	struct nftables_pernet *nft_net = net_generic(net, nf_tables_net_id);
 	u32 id = ntohl(nla_get_be32(nla));
 	struct nft_trans *trans;
 
-	list_for_each_entry(trans, &net->nft.commit_list, list) {
+	list_for_each_entry(trans, &nft_net->commit_list, list) {
 		struct nft_rule *rule = nft_trans_rule(trans);
 
 		if (trans->msg_type == NFT_MSG_NEWRULE &&
@@ -3039,12 +3077,13 @@ nft_select_set_ops(const struct nft_ctx
 		   const struct nft_set_desc *desc,
 		   enum nft_set_policies policy)
 {
+	struct nftables_pernet *nft_net = net_generic(ctx->net, nf_tables_net_id);
 	const struct nft_set_ops *ops, *bops;
 	struct nft_set_estimate est, best;
 	const struct nft_set_type *type;
 	u32 flags = 0;
 
-	lockdep_assert_held(&ctx->net->nft.commit_mutex);
+	lockdep_assert_held(&nft_net->commit_mutex);
 	lockdep_nfnl_nft_mutex_not_held();
 #ifdef CONFIG_MODULES
 	if (list_empty(&nf_tables_set_types)) {
@@ -3189,10 +3228,11 @@ static struct nft_set *nft_set_lookup_by
 					   const struct nft_table *table,
 					   const struct nlattr *nla, u8 genmask)
 {
+	struct nftables_pernet *nft_net = net_generic(net, nf_tables_net_id);
 	struct nft_trans *trans;
 	u32 id = ntohl(nla_get_be32(nla));
 
-	list_for_each_entry(trans, &net->nft.commit_list, list) {
+	list_for_each_entry(trans, &nft_net->commit_list, list) {
 		if (trans->msg_type == NFT_MSG_NEWSET) {
 			struct nft_set *set = nft_trans_set(trans);
 
@@ -3406,14 +3446,16 @@ static int nf_tables_dump_sets(struct sk
 	struct nft_table *table, *cur_table = (struct nft_table *)cb->args[2];
 	struct net *net = sock_net(skb->sk);
 	struct nft_ctx *ctx = cb->data, ctx_set;
+	struct nftables_pernet *nft_net;
 
 	if (cb->args[1])
 		return skb->len;
 
 	rcu_read_lock();
-	cb->seq = net->nft.base_seq;
+	nft_net = net_generic(net, nf_tables_net_id);
+	cb->seq = nft_net->base_seq;
 
-	list_for_each_entry_rcu(table, &net->nft.tables, list) {
+	list_for_each_entry_rcu(table, &nft_net->tables, list) {
 		if (ctx->family != NFPROTO_UNSPEC &&
 		    ctx->family != table->family)
 			continue;
@@ -4119,6 +4161,7 @@ static int nf_tables_dump_set(struct sk_
 {
 	struct nft_set_dump_ctx *dump_ctx = cb->data;
 	struct net *net = sock_net(skb->sk);
+	struct nftables_pernet *nft_net;
 	struct nft_table *table;
 	struct nft_set *set;
 	struct nft_set_dump_args args;
@@ -4129,7 +4172,8 @@ static int nf_tables_dump_set(struct sk_
 	int event;
 
 	rcu_read_lock();
-	list_for_each_entry_rcu(table, &net->nft.tables, list) {
+	nft_net = net_generic(net, nf_tables_net_id);
+	list_for_each_entry_rcu(table, &nft_net->tables, list) {
 		if (dump_ctx->ctx.family != NFPROTO_UNSPEC &&
 		    dump_ctx->ctx.family != table->family)
 			continue;
@@ -4733,7 +4777,7 @@ static int nft_add_set_elem(struct nft_c
 	}
 
 	nft_trans_elem(trans) = elem;
-	list_add_tail(&trans->list, &ctx->net->nft.commit_list);
+	nft_trans_commit_list_add_tail(ctx->net, trans);
 	return 0;
 
 err6:
@@ -4758,6 +4802,7 @@ static int nf_tables_newsetelem(struct n
 				const struct nlattr * const nla[],
 				struct netlink_ext_ack *extack)
 {
+	struct nftables_pernet *nft_net = net_generic(net, nf_tables_net_id);
 	u8 genmask = nft_genmask_next(net);
 	const struct nlattr *attr;
 	struct nft_set *set;
@@ -4787,7 +4832,7 @@ static int nf_tables_newsetelem(struct n
 			return err;
 	}
 
-	if (net->nft.validate_state == NFT_VALIDATE_DO)
+	if (nft_net->validate_state == NFT_VALIDATE_DO)
 		return nft_table_validate(net, ctx.table);
 
 	return 0;
@@ -4900,7 +4945,7 @@ static int nft_del_setelem(struct nft_ct
 	nft_set_elem_deactivate(ctx->net, set, &elem);
 
 	nft_trans_elem(trans) = elem;
-	list_add_tail(&trans->list, &ctx->net->nft.commit_list);
+	nft_trans_commit_list_add_tail(ctx->net, trans);
 	return 0;
 
 fail_ops:
@@ -4934,7 +4979,7 @@ static int nft_flush_set(const struct nf
 	nft_set_elem_deactivate(ctx->net, set, elem);
 	nft_trans_elem_set(trans) = set;
 	nft_trans_elem(trans) = *elem;
-	list_add_tail(&trans->list, &ctx->net->nft.commit_list);
+	nft_trans_commit_list_add_tail(ctx->net, trans);
 
 	return 0;
 err1:
@@ -5233,7 +5278,7 @@ static int nf_tables_updobj(const struct
 	nft_trans_obj(trans) = obj;
 	nft_trans_obj_update(trans) = true;
 	nft_trans_obj_newobj(trans) = newobj;
-	list_add_tail(&trans->list, &ctx->net->nft.commit_list);
+	nft_trans_commit_list_add_tail(ctx->net, trans);
 
 	return 0;
 
@@ -5382,6 +5427,7 @@ static int nf_tables_dump_obj(struct sk_
 	struct nft_obj_filter *filter = cb->data;
 	struct net *net = sock_net(skb->sk);
 	int family = nfmsg->nfgen_family;
+	struct nftables_pernet *nft_net;
 	struct nft_object *obj;
 	bool reset = false;
 
@@ -5389,9 +5435,10 @@ static int nf_tables_dump_obj(struct sk_
 		reset = true;
 
 	rcu_read_lock();
-	cb->seq = net->nft.base_seq;
+	nft_net = net_generic(net, nf_tables_net_id);
+	cb->seq = nft_net->base_seq;
 
-	list_for_each_entry_rcu(table, &net->nft.tables, list) {
+	list_for_each_entry_rcu(table, &nft_net->tables, list) {
 		if (family != NFPROTO_UNSPEC && family != table->family)
 			continue;
 
@@ -6071,13 +6118,15 @@ static int nf_tables_dump_flowtable(stru
 	unsigned int idx = 0, s_idx = cb->args[0];
 	struct net *net = sock_net(skb->sk);
 	int family = nfmsg->nfgen_family;
+	struct nftables_pernet *nft_net;
 	struct nft_flowtable *flowtable;
 	const struct nft_table *table;
 
 	rcu_read_lock();
-	cb->seq = net->nft.base_seq;
+	nft_net = net_generic(net, nf_tables_net_id);
+	cb->seq = nft_net->base_seq;
 
-	list_for_each_entry_rcu(table, &net->nft.tables, list) {
+	list_for_each_entry_rcu(table, &nft_net->tables, list) {
 		if (family != NFPROTO_UNSPEC && family != table->family)
 			continue;
 
@@ -6247,6 +6296,7 @@ static void nf_tables_flowtable_destroy(
 static int nf_tables_fill_gen_info(struct sk_buff *skb, struct net *net,
 				   u32 portid, u32 seq)
 {
+	struct nftables_pernet *nft_net = net_generic(net, nf_tables_net_id);
 	struct nlmsghdr *nlh;
 	char buf[TASK_COMM_LEN];
 	int event = nfnl_msg_type(NFNL_SUBSYS_NFTABLES, NFT_MSG_NEWGEN);
@@ -6256,7 +6306,7 @@ static int nf_tables_fill_gen_info(struc
 	if (!nlh)
 		goto nla_put_failure;
 
-	if (nla_put_be32(skb, NFTA_GEN_ID, htonl(net->nft.base_seq)) ||
+	if (nla_put_be32(skb, NFTA_GEN_ID, htonl(nft_net->base_seq)) ||
 	    nla_put_be32(skb, NFTA_GEN_PROC_PID, htonl(task_pid_nr(current))) ||
 	    nla_put_string(skb, NFTA_GEN_PROC_NAME, get_task_comm(buf, current)))
 		goto nla_put_failure;
@@ -6289,6 +6339,7 @@ static int nf_tables_flowtable_event(str
 {
 	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
 	struct nft_flowtable *flowtable;
+	struct nftables_pernet *nft_net;
 	struct nft_table *table;
 	struct net *net;
 
@@ -6296,13 +6347,14 @@ static int nf_tables_flowtable_event(str
 		return 0;
 
 	net = dev_net(dev);
-	mutex_lock(&net->nft.commit_mutex);
-	list_for_each_entry(table, &net->nft.tables, list) {
+	nft_net = net_generic(net, nf_tables_net_id);
+	mutex_lock(&nft_net->commit_mutex);
+	list_for_each_entry(table, &nft_net->tables, list) {
 		list_for_each_entry(flowtable, &table->flowtables, list) {
 			nft_flowtable_event(event, dev, flowtable);
 		}
 	}
-	mutex_unlock(&net->nft.commit_mutex);
+	mutex_unlock(&nft_net->commit_mutex);
 
 	return NOTIFY_DONE;
 }
@@ -6483,16 +6535,17 @@ static const struct nfnl_callback nf_tab
 
 static int nf_tables_validate(struct net *net)
 {
+	struct nftables_pernet *nft_net = net_generic(net, nf_tables_net_id);
 	struct nft_table *table;
 
-	switch (net->nft.validate_state) {
+	switch (nft_net->validate_state) {
 	case NFT_VALIDATE_SKIP:
 		break;
 	case NFT_VALIDATE_NEED:
 		nft_validate_state_update(net, NFT_VALIDATE_DO);
 		/* fall through */
 	case NFT_VALIDATE_DO:
-		list_for_each_entry(table, &net->nft.tables, list) {
+		list_for_each_entry(table, &nft_net->tables, list) {
 			if (nft_table_validate(net, table) < 0)
 				return -EAGAIN;
 		}
@@ -6666,9 +6719,10 @@ static int nf_tables_commit_chain_prepar
 
 static void nf_tables_commit_chain_prepare_cancel(struct net *net)
 {
+	struct nftables_pernet *nft_net = net_generic(net, nf_tables_net_id);
 	struct nft_trans *trans, *next;
 
-	list_for_each_entry_safe(trans, next, &net->nft.commit_list, list) {
+	list_for_each_entry_safe(trans, next, &nft_net->commit_list, list) {
 		struct nft_chain *chain = trans->ctx.chain;
 
 		if (trans->msg_type == NFT_MSG_NEWRULE ||
@@ -6766,10 +6820,11 @@ static void nft_chain_del(struct nft_cha
 
 static void nf_tables_module_autoload_cleanup(struct net *net)
 {
+	struct nftables_pernet *nft_net = net_generic(net, nf_tables_net_id);
 	struct nft_module_request *req, *next;
 
-	WARN_ON_ONCE(!list_empty(&net->nft.commit_list));
-	list_for_each_entry_safe(req, next, &net->nft.module_list, list) {
+	WARN_ON_ONCE(!list_empty(&nft_net->commit_list));
+	list_for_each_entry_safe(req, next, &nft_net->module_list, list) {
 		WARN_ON_ONCE(!req->done);
 		list_del(&req->list);
 		kfree(req);
@@ -6778,6 +6833,7 @@ static void nf_tables_module_autoload_cl
 
 static void nf_tables_commit_release(struct net *net)
 {
+	struct nftables_pernet *nft_net = net_generic(net, nf_tables_net_id);
 	struct nft_trans *trans;
 
 	/* all side effects have to be made visible.
@@ -6787,38 +6843,39 @@ static void nf_tables_commit_release(str
 	 * Memory reclaim happens asynchronously from work queue
 	 * to prevent expensive synchronize_rcu() in commit phase.
 	 */
-	if (list_empty(&net->nft.commit_list)) {
+	if (list_empty(&nft_net->commit_list)) {
 		nf_tables_module_autoload_cleanup(net);
-		mutex_unlock(&net->nft.commit_mutex);
+		mutex_unlock(&nft_net->commit_mutex);
 		return;
 	}
 
-	trans = list_last_entry(&net->nft.commit_list,
+	trans = list_last_entry(&nft_net->commit_list,
 				struct nft_trans, list);
 	get_net(trans->ctx.net);
 	WARN_ON_ONCE(trans->put_net);
 
 	trans->put_net = true;
 	spin_lock(&nf_tables_destroy_list_lock);
-	list_splice_tail_init(&net->nft.commit_list, &nf_tables_destroy_list);
+	list_splice_tail_init(&nft_net->commit_list, &nf_tables_destroy_list);
 	spin_unlock(&nf_tables_destroy_list_lock);
 
 	nf_tables_module_autoload_cleanup(net);
 	schedule_work(&trans_destroy_work);
 
-	mutex_unlock(&net->nft.commit_mutex);
+	mutex_unlock(&nft_net->commit_mutex);
 }
 
 static int nf_tables_commit(struct net *net, struct sk_buff *skb)
 {
+	struct nftables_pernet *nft_net = net_generic(net, nf_tables_net_id);
 	struct nft_trans *trans, *next;
 	struct nft_trans_elem *te;
 	struct nft_chain *chain;
 	struct nft_table *table;
 	int err;
 
-	if (list_empty(&net->nft.commit_list)) {
-		mutex_unlock(&net->nft.commit_mutex);
+	if (list_empty(&nft_net->commit_list)) {
+		mutex_unlock(&nft_net->commit_mutex);
 		return 0;
 	}
 
@@ -6831,7 +6888,7 @@ static int nf_tables_commit(struct net *
 		return err;
 
 	/* 1.  Allocate space for next generation rules_gen_X[] */
-	list_for_each_entry_safe(trans, next, &net->nft.commit_list, list) {
+	list_for_each_entry_safe(trans, next, &nft_net->commit_list, list) {
 		int ret;
 
 		if (trans->msg_type == NFT_MSG_NEWRULE ||
@@ -6847,7 +6904,7 @@ static int nf_tables_commit(struct net *
 	}
 
 	/* step 2.  Make rules_gen_X visible to packet path */
-	list_for_each_entry(table, &net->nft.tables, list) {
+	list_for_each_entry(table, &nft_net->tables, list) {
 		list_for_each_entry(chain, &table->chains, list)
 			nf_tables_commit_chain(net, chain);
 	}
@@ -6856,12 +6913,13 @@ static int nf_tables_commit(struct net *
 	 * Bump generation counter, invalidate any dump in progress.
 	 * Cannot fail after this point.
 	 */
-	while (++net->nft.base_seq == 0);
+	while (++nft_net->base_seq == 0)
+		;
 
 	/* step 3. Start new generation, rules_gen_X now in use. */
 	net->nft.gencursor = nft_gencursor_next(net);
 
-	list_for_each_entry_safe(trans, next, &net->nft.commit_list, list) {
+	list_for_each_entry_safe(trans, next, &nft_net->commit_list, list) {
 		switch (trans->msg_type) {
 		case NFT_MSG_NEWTABLE:
 			if (nft_trans_table_update(trans)) {
@@ -7003,17 +7061,18 @@ static int nf_tables_commit(struct net *
 
 static void nf_tables_module_autoload(struct net *net)
 {
+	struct nftables_pernet *nft_net = net_generic(net, nf_tables_net_id);
 	struct nft_module_request *req, *next;
 	LIST_HEAD(module_list);
 
-	list_splice_init(&net->nft.module_list, &module_list);
-	mutex_unlock(&net->nft.commit_mutex);
+	list_splice_init(&nft_net->module_list, &module_list);
+	mutex_unlock(&nft_net->commit_mutex);
 	list_for_each_entry_safe(req, next, &module_list, list) {
 		request_module("%s", req->module);
 		req->done = true;
 	}
-	mutex_lock(&net->nft.commit_mutex);
-	list_splice(&module_list, &net->nft.module_list);
+	mutex_lock(&nft_net->commit_mutex);
+	list_splice(&module_list, &nft_net->module_list);
 }
 
 static void nf_tables_abort_release(struct nft_trans *trans)
@@ -7047,6 +7106,7 @@ static void nf_tables_abort_release(stru
 
 static int __nf_tables_abort(struct net *net, enum nfnl_abort_action action)
 {
+	struct nftables_pernet *nft_net = net_generic(net, nf_tables_net_id);
 	struct nft_trans *trans, *next;
 	struct nft_trans_elem *te;
 
@@ -7054,7 +7114,7 @@ static int __nf_tables_abort(struct net
 	    nf_tables_validate(net) < 0)
 		return -EAGAIN;
 
-	list_for_each_entry_safe_reverse(trans, next, &net->nft.commit_list,
+	list_for_each_entry_safe_reverse(trans, next, &nft_net->commit_list,
 					 list) {
 		switch (trans->msg_type) {
 		case NFT_MSG_NEWTABLE:
@@ -7166,7 +7226,7 @@ static int __nf_tables_abort(struct net
 	synchronize_rcu();
 
 	list_for_each_entry_safe_reverse(trans, next,
-					 &net->nft.commit_list, list) {
+					 &nft_net->commit_list, list) {
 		list_del(&trans->list);
 		nf_tables_abort_release(trans);
 	}
@@ -7182,22 +7242,24 @@ static int __nf_tables_abort(struct net
 static int nf_tables_abort(struct net *net, struct sk_buff *skb,
 			   enum nfnl_abort_action action)
 {
+	struct nftables_pernet *nft_net = net_generic(net, nf_tables_net_id);
 	int ret = __nf_tables_abort(net, action);
 
-	mutex_unlock(&net->nft.commit_mutex);
+	mutex_unlock(&nft_net->commit_mutex);
 
 	return ret;
 }
 
 static bool nf_tables_valid_genid(struct net *net, u32 genid)
 {
+	struct nftables_pernet *nft_net = net_generic(net, nf_tables_net_id);
 	bool genid_ok;
 
-	mutex_lock(&net->nft.commit_mutex);
+	mutex_lock(&nft_net->commit_mutex);
 
-	genid_ok = genid == 0 || net->nft.base_seq == genid;
+	genid_ok = genid == 0 || nft_net->base_seq == genid;
 	if (!genid_ok)
-		mutex_unlock(&net->nft.commit_mutex);
+		mutex_unlock(&nft_net->commit_mutex);
 
 	/* else, commit mutex has to be released by commit or abort function */
 	return genid_ok;
@@ -7754,19 +7816,19 @@ EXPORT_SYMBOL_GPL(__nft_release_basechai
 
 static void __nft_release_hooks(struct net *net)
 {
+	struct nftables_pernet *nft_net = net_generic(net, nf_tables_net_id);
 	struct nft_table *table;
 	struct nft_chain *chain;
 
-	list_for_each_entry(table, &net->nft.tables, list) {
+	list_for_each_entry(table, &nft_net->tables, list) {
 		list_for_each_entry(chain, &table->chains, list)
 			nf_tables_unregister_hook(net, table, chain);
 	}
 }
 
-static void __nft_release_tables(struct net *net)
+static void __nft_release_table(struct net *net, struct nft_table *table)
 {
 	struct nft_flowtable *flowtable, *nf;
-	struct nft_table *table, *nt;
 	struct nft_chain *chain, *nc;
 	struct nft_object *obj, *ne;
 	struct nft_rule *rule, *nr;
@@ -7776,77 +7838,93 @@ static void __nft_release_tables(struct
 		.family	= NFPROTO_NETDEV,
 	};
 
-	list_for_each_entry_safe(table, nt, &net->nft.tables, list) {
-		ctx.family = table->family;
-		ctx.table = table;
-		list_for_each_entry(chain, &table->chains, list) {
-			ctx.chain = chain;
-			list_for_each_entry_safe(rule, nr, &chain->rules, list) {
-				list_del(&rule->list);
-				chain->use--;
-				nf_tables_rule_release(&ctx, rule);
-			}
-		}
-		list_for_each_entry_safe(flowtable, nf, &table->flowtables, list) {
-			list_del(&flowtable->list);
-			table->use--;
-			nf_tables_flowtable_destroy(flowtable);
-		}
-		list_for_each_entry_safe(set, ns, &table->sets, list) {
-			list_del(&set->list);
-			table->use--;
-			nft_set_destroy(set);
-		}
-		list_for_each_entry_safe(obj, ne, &table->objects, list) {
-			nft_obj_del(obj);
-			table->use--;
-			nft_obj_destroy(&ctx, obj);
-		}
-		list_for_each_entry_safe(chain, nc, &table->chains, list) {
-			ctx.chain = chain;
-			nft_chain_del(chain);
-			table->use--;
-			nf_tables_chain_destroy(&ctx);
+	ctx.family = table->family;
+	ctx.table = table;
+	list_for_each_entry(chain, &table->chains, list) {
+		ctx.chain = chain;
+		list_for_each_entry_safe(rule, nr, &chain->rules, list) {
+			list_del(&rule->list);
+			chain->use--;
+			nf_tables_rule_release(&ctx, rule);
 		}
-		list_del(&table->list);
-		nf_tables_table_destroy(&ctx);
 	}
+	list_for_each_entry_safe(flowtable, nf, &table->flowtables, list) {
+		list_del(&flowtable->list);
+		table->use--;
+		nf_tables_flowtable_destroy(flowtable);
+	}
+	list_for_each_entry_safe(set, ns, &table->sets, list) {
+		list_del(&set->list);
+		table->use--;
+		nft_set_destroy(set);
+	}
+	list_for_each_entry_safe(obj, ne, &table->objects, list) {
+		nft_obj_del(obj);
+		table->use--;
+		nft_obj_destroy(&ctx, obj);
+	}
+	list_for_each_entry_safe(chain, nc, &table->chains, list) {
+		ctx.chain = chain;
+		nft_chain_del(chain);
+		table->use--;
+		nf_tables_chain_destroy(&ctx);
+	}
+	list_del(&table->list);
+	nf_tables_table_destroy(&ctx);
+}
+
+static void __nft_release_tables(struct net *net)
+{
+	struct nftables_pernet *nft_net = net_generic(net, nf_tables_net_id);
+	struct nft_table *table, *nt;
+
+	list_for_each_entry_safe(table, nt, &nft_net->tables, list)
+		__nft_release_table(net, table);
 }
 
 static int __net_init nf_tables_init_net(struct net *net)
 {
-	INIT_LIST_HEAD(&net->nft.tables);
-	INIT_LIST_HEAD(&net->nft.commit_list);
-	INIT_LIST_HEAD(&net->nft.module_list);
-	mutex_init(&net->nft.commit_mutex);
-	net->nft.base_seq = 1;
-	net->nft.validate_state = NFT_VALIDATE_SKIP;
+	struct nftables_pernet *nft_net = net_generic(net, nf_tables_net_id);
+
+	INIT_LIST_HEAD(&nft_net->tables);
+	INIT_LIST_HEAD(&nft_net->commit_list);
+	INIT_LIST_HEAD(&nft_net->module_list);
+	INIT_LIST_HEAD(&nft_net->notify_list);
+	mutex_init(&nft_net->commit_mutex);
+	nft_net->base_seq = 1;
+	nft_net->validate_state = NFT_VALIDATE_SKIP;
 
 	return 0;
 }
 
 static void __net_exit nf_tables_pre_exit_net(struct net *net)
 {
-	mutex_lock(&net->nft.commit_mutex);
+	struct nftables_pernet *nft_net = net_generic(net, nf_tables_net_id);
+
+	mutex_lock(&nft_net->commit_mutex);
 	__nft_release_hooks(net);
-	mutex_unlock(&net->nft.commit_mutex);
+	mutex_unlock(&nft_net->commit_mutex);
 }
 
 static void __net_exit nf_tables_exit_net(struct net *net)
 {
-	mutex_lock(&net->nft.commit_mutex);
-	if (!list_empty(&net->nft.commit_list))
+	struct nftables_pernet *nft_net = net_generic(net, nf_tables_net_id);
+
+	mutex_lock(&nft_net->commit_mutex);
+	if (!list_empty(&nft_net->commit_list))
 		__nf_tables_abort(net, NFNL_ABORT_NONE);
 	__nft_release_tables(net);
-	mutex_unlock(&net->nft.commit_mutex);
-	WARN_ON_ONCE(!list_empty(&net->nft.tables));
-	WARN_ON_ONCE(!list_empty(&net->nft.module_list));
+	mutex_unlock(&nft_net->commit_mutex);
+	WARN_ON_ONCE(!list_empty(&nft_net->tables));
+	WARN_ON_ONCE(!list_empty(&nft_net->module_list));
 }
 
 static struct pernet_operations nf_tables_net_ops = {
 	.init		= nf_tables_init_net,
 	.pre_exit	= nf_tables_pre_exit_net,
 	.exit		= nf_tables_exit_net,
+	.id		= &nf_tables_net_id,
+	.size		= sizeof(struct nftables_pernet),
 };
 
 static int __init nf_tables_module_init(void)
--- a/net/netfilter/nf_tables_offload.c
+++ b/net/netfilter/nf_tables_offload.c
@@ -7,6 +7,8 @@
 #include <net/netfilter/nf_tables_offload.h>
 #include <net/pkt_cls.h>
 
+extern unsigned int nf_tables_net_id;
+
 static struct nft_flow_rule *nft_flow_rule_alloc(int num_actions)
 {
 	struct nft_flow_rule *flow;
@@ -345,11 +347,12 @@ static int nft_flow_offload_chain(struct
 
 int nft_flow_rule_offload_commit(struct net *net)
 {
+	struct nftables_pernet *nft_net = net_generic(net, nf_tables_net_id);
 	struct nft_trans *trans;
 	int err = 0;
 	u8 policy;
 
-	list_for_each_entry(trans, &net->nft.commit_list, list) {
+	list_for_each_entry(trans, &nft_net->commit_list, list) {
 		if (trans->ctx.family != NFPROTO_NETDEV)
 			continue;
 
@@ -400,7 +403,7 @@ int nft_flow_rule_offload_commit(struct
 			break;
 	}
 
-	list_for_each_entry(trans, &net->nft.commit_list, list) {
+	list_for_each_entry(trans, &nft_net->commit_list, list) {
 		if (trans->ctx.family != NFPROTO_NETDEV)
 			continue;
 
@@ -419,14 +422,14 @@ int nft_flow_rule_offload_commit(struct
 	return err;
 }
 
-static struct nft_chain *__nft_offload_get_chain(struct net_device *dev)
+static struct nft_chain *__nft_offload_get_chain(const struct nftables_pernet *nft_net,
+						 struct net_device *dev)
 {
 	struct nft_base_chain *basechain;
-	struct net *net = dev_net(dev);
 	const struct nft_table *table;
 	struct nft_chain *chain;
 
-	list_for_each_entry(table, &net->nft.tables, list) {
+	list_for_each_entry(table, &nft_net->tables, list) {
 		if (table->family != NFPROTO_NETDEV)
 			continue;
 
@@ -450,18 +453,20 @@ static void nft_indr_block_cb(struct net
 			      flow_indr_block_bind_cb_t *cb, void *cb_priv,
 			      enum flow_block_command cmd)
 {
+	struct nftables_pernet *nft_net;
 	struct net *net = dev_net(dev);
 	struct nft_chain *chain;
 
-	mutex_lock(&net->nft.commit_mutex);
-	chain = __nft_offload_get_chain(dev);
+	nft_net = net_generic(net, nf_tables_net_id);
+	mutex_lock(&nft_net->commit_mutex);
+	chain = __nft_offload_get_chain(nft_net, dev);
 	if (chain && chain->flags & NFT_CHAIN_HW_OFFLOAD) {
 		struct nft_base_chain *basechain;
 
 		basechain = nft_base_chain(chain);
 		nft_indr_block_ing_cmd(dev, basechain, cb, cb_priv, cmd);
 	}
-	mutex_unlock(&net->nft.commit_mutex);
+	mutex_unlock(&nft_net->commit_mutex);
 }
 
 static void nft_offload_chain_clean(struct nft_chain *chain)
@@ -480,17 +485,19 @@ static int nft_offload_netdev_event(stru
 				    unsigned long event, void *ptr)
 {
 	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
+	struct nftables_pernet *nft_net;
 	struct net *net = dev_net(dev);
 	struct nft_chain *chain;
 
 	if (event != NETDEV_UNREGISTER)
 		return NOTIFY_DONE;
 
-	mutex_lock(&net->nft.commit_mutex);
-	chain = __nft_offload_get_chain(dev);
+	nft_net = net_generic(net, nf_tables_net_id);
+	mutex_lock(&nft_net->commit_mutex);
+	chain = __nft_offload_get_chain(nft_net, dev);
 	if (chain)
 		nft_offload_chain_clean(chain);
-	mutex_unlock(&net->nft.commit_mutex);
+	mutex_unlock(&nft_net->commit_mutex);
 
 	return NOTIFY_DONE;
 }
--- a/net/netfilter/nft_chain_filter.c
+++ b/net/netfilter/nft_chain_filter.c
@@ -2,6 +2,7 @@
 #include <linux/kernel.h>
 #include <linux/netdevice.h>
 #include <net/net_namespace.h>
+#include <net/netns/generic.h>
 #include <net/netfilter/nf_tables.h>
 #include <linux/netfilter_ipv4.h>
 #include <linux/netfilter_ipv6.h>
@@ -10,6 +11,8 @@
 #include <net/netfilter/nf_tables_ipv4.h>
 #include <net/netfilter/nf_tables_ipv6.h>
 
+extern unsigned int nf_tables_net_id;
+
 #ifdef CONFIG_NF_TABLES_IPV4
 static unsigned int nft_do_chain_ipv4(void *priv,
 				      struct sk_buff *skb,
@@ -315,6 +318,7 @@ static int nf_tables_netdev_event(struct
 				  unsigned long event, void *ptr)
 {
 	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
+	struct nftables_pernet *nft_net;
 	struct nft_table *table;
 	struct nft_chain *chain, *nr;
 	struct nft_ctx ctx = {
@@ -325,8 +329,9 @@ static int nf_tables_netdev_event(struct
 	    event != NETDEV_CHANGENAME)
 		return NOTIFY_DONE;
 
-	mutex_lock(&ctx.net->nft.commit_mutex);
-	list_for_each_entry(table, &ctx.net->nft.tables, list) {
+	nft_net = net_generic(ctx.net, nf_tables_net_id);
+	mutex_lock(&nft_net->commit_mutex);
+	list_for_each_entry(table, &nft_net->tables, list) {
 		if (table->family != NFPROTO_NETDEV)
 			continue;
 
@@ -340,7 +345,7 @@ static int nf_tables_netdev_event(struct
 			nft_netdev_event(event, dev, &ctx);
 		}
 	}
-	mutex_unlock(&ctx.net->nft.commit_mutex);
+	mutex_unlock(&nft_net->commit_mutex);
 
 	return NOTIFY_DONE;
 }
--- a/net/netfilter/nft_dynset.c
+++ b/net/netfilter/nft_dynset.c
@@ -11,6 +11,9 @@
 #include <linux/netfilter/nf_tables.h>
 #include <net/netfilter/nf_tables.h>
 #include <net/netfilter/nf_tables_core.h>
+#include <net/netns/generic.h>
+
+extern unsigned int nf_tables_net_id;
 
 struct nft_dynset {
 	struct nft_set			*set;
@@ -129,13 +132,14 @@ static int nft_dynset_init(const struct
 			   const struct nft_expr *expr,
 			   const struct nlattr * const tb[])
 {
+	struct nftables_pernet *nft_net = net_generic(ctx->net, nf_tables_net_id);
 	struct nft_dynset *priv = nft_expr_priv(expr);
 	u8 genmask = nft_genmask_next(ctx->net);
 	struct nft_set *set;
 	u64 timeout;
 	int err;
 
-	lockdep_assert_held(&ctx->net->nft.commit_mutex);
+	lockdep_assert_held(&nft_net->commit_mutex);
 
 	if (tb[NFTA_DYNSET_SET_NAME] == NULL ||
 	    tb[NFTA_DYNSET_OP] == NULL ||


