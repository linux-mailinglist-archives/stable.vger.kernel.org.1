Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80280735401
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbjFSKvN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232190AbjFSKug (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:50:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3533B199
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:50:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B74896068B
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:50:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9D69C433C8;
        Mon, 19 Jun 2023 10:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687171806;
        bh=m35ekIagCqlB0WwSQyoiOB58o7UUrRhWF9Iho4fEpoA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rj3q836y1uGltxrSegcAz0T6fr96GraVQlr3ULEjqtROhCpXxwqCluNyOPC8EdioN
         tvdSi+qxXVkYrI3N8UAYaQtOHBzRHhzlszGu0pjpUAuOWdhyA5W0Eg06kymu4597X0
         8n4kqS+Gp+D3k+y+tSZaEtafEWh0CzBnELYzC8jI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 139/166] sched: add new attr TCA_EXT_WARN_MSG to report tc extact message
Date:   Mon, 19 Jun 2023 12:30:16 +0200
Message-ID: <20230619102201.503152562@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102154.568541872@linuxfoundation.org>
References: <20230619102154.568541872@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Hangbin Liu <liuhangbin@gmail.com>

[ Upstream commit 0349b8779cc949ad9e6aced32672ee48cf79b497 ]

We will report extack message if there is an error via netlink_ack(). But
if the rule is not to be exclusively executed by the hardware, extack is not
passed along and offloading failures don't get logged.

In commit 81c7288b170a ("sched: cls: enable verbose logging") Marcelo
made cls could log verbose info for offloading failures, which helps
improving Open vSwitch debuggability when using flower offloading.

It would also be helpful if userspace monitor tools, like "tc monitor",
could log this kind of message, as it doesn't require vswitchd log level
adjusment. Let's add a new tc attributes to report the extack message so
the monitor program could receive the failures. e.g.

  # tc monitor
  added chain dev enp3s0f1np1 parent ffff: chain 0
  added filter dev enp3s0f1np1 ingress protocol all pref 49152 flower chain 0 handle 0x1
    ct_state +trk+new
    not_in_hw
          action order 1: gact action drop
           random type none pass val 0
           index 1 ref 1 bind 1

  Warning: mlx5_core: matching on ct_state +new isn't supported.

In this patch I only report the extack message on add/del operations.
It doesn't look like we need to report the extack message on get/dump
operations.

Note this message not only reporte to multicast groups, it could also
be reported unicast, which may affect the current usersapce tool's behaivor.

Suggested-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
Acked-by: Jakub Kicinski <kuba@kernel.org>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Link: https://lore.kernel.org/r/20230113034353.2766735-1-liuhangbin@gmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Stable-dep-of: 84ad0af0bccd ("net/sched: qdisc_destroy() old ingress and clsact Qdiscs before grafting")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/uapi/linux/rtnetlink.h |  1 +
 net/sched/act_api.c            | 15 +++++---
 net/sched/cls_api.c            | 62 +++++++++++++++++++++-------------
 net/sched/sch_api.c            | 55 ++++++++++++++++++------------
 4 files changed, 84 insertions(+), 49 deletions(-)

diff --git a/include/uapi/linux/rtnetlink.h b/include/uapi/linux/rtnetlink.h
index eb2747d58a813..25a0af57dd5ed 100644
--- a/include/uapi/linux/rtnetlink.h
+++ b/include/uapi/linux/rtnetlink.h
@@ -635,6 +635,7 @@ enum {
 	TCA_INGRESS_BLOCK,
 	TCA_EGRESS_BLOCK,
 	TCA_DUMP_FLAGS,
+	TCA_EXT_WARN_MSG,
 	__TCA_MAX
 };
 
diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index 9b31a10cc6399..cc6628a42e839 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -1581,7 +1581,7 @@ int tcf_action_copy_stats(struct sk_buff *skb, struct tc_action *p,
 
 static int tca_get_fill(struct sk_buff *skb, struct tc_action *actions[],
 			u32 portid, u32 seq, u16 flags, int event, int bind,
-			int ref)
+			int ref, struct netlink_ext_ack *extack)
 {
 	struct tcamsg *t;
 	struct nlmsghdr *nlh;
@@ -1605,7 +1605,12 @@ static int tca_get_fill(struct sk_buff *skb, struct tc_action *actions[],
 
 	nla_nest_end(skb, nest);
 
+	if (extack && extack->_msg &&
+	    nla_put_string(skb, TCA_EXT_WARN_MSG, extack->_msg))
+		goto out_nlmsg_trim;
+
 	nlh->nlmsg_len = skb_tail_pointer(skb) - b;
+
 	return skb->len;
 
 out_nlmsg_trim:
@@ -1624,7 +1629,7 @@ tcf_get_notify(struct net *net, u32 portid, struct nlmsghdr *n,
 	if (!skb)
 		return -ENOBUFS;
 	if (tca_get_fill(skb, actions, portid, n->nlmsg_seq, 0, event,
-			 0, 1) <= 0) {
+			 0, 1, NULL) <= 0) {
 		NL_SET_ERR_MSG(extack, "Failed to fill netlink attributes while adding TC action");
 		kfree_skb(skb);
 		return -EINVAL;
@@ -1798,7 +1803,7 @@ tcf_reoffload_del_notify(struct net *net, struct tc_action *action)
 	if (!skb)
 		return -ENOBUFS;
 
-	if (tca_get_fill(skb, actions, 0, 0, 0, RTM_DELACTION, 0, 1) <= 0) {
+	if (tca_get_fill(skb, actions, 0, 0, 0, RTM_DELACTION, 0, 1, NULL) <= 0) {
 		kfree_skb(skb);
 		return -EINVAL;
 	}
@@ -1885,7 +1890,7 @@ tcf_del_notify(struct net *net, struct nlmsghdr *n, struct tc_action *actions[],
 		return -ENOBUFS;
 
 	if (tca_get_fill(skb, actions, portid, n->nlmsg_seq, 0, RTM_DELACTION,
-			 0, 2) <= 0) {
+			 0, 2, extack) <= 0) {
 		NL_SET_ERR_MSG(extack, "Failed to fill netlink TC action attributes");
 		kfree_skb(skb);
 		return -EINVAL;
@@ -1964,7 +1969,7 @@ tcf_add_notify(struct net *net, struct nlmsghdr *n, struct tc_action *actions[],
 		return -ENOBUFS;
 
 	if (tca_get_fill(skb, actions, portid, n->nlmsg_seq, n->nlmsg_flags,
-			 RTM_NEWACTION, 0, 0) <= 0) {
+			 RTM_NEWACTION, 0, 0, extack) <= 0) {
 		NL_SET_ERR_MSG(extack, "Failed to fill netlink attributes while adding TC action");
 		kfree_skb(skb);
 		return -EINVAL;
diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index abaf75300497d..0dbfc37d97991 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -485,7 +485,8 @@ static struct tcf_chain *tcf_chain_lookup_rcu(const struct tcf_block *block,
 #endif
 
 static int tc_chain_notify(struct tcf_chain *chain, struct sk_buff *oskb,
-			   u32 seq, u16 flags, int event, bool unicast);
+			   u32 seq, u16 flags, int event, bool unicast,
+			   struct netlink_ext_ack *extack);
 
 static struct tcf_chain *__tcf_chain_get(struct tcf_block *block,
 					 u32 chain_index, bool create,
@@ -518,7 +519,7 @@ static struct tcf_chain *__tcf_chain_get(struct tcf_block *block,
 	 */
 	if (is_first_reference && !by_act)
 		tc_chain_notify(chain, NULL, 0, NLM_F_CREATE | NLM_F_EXCL,
-				RTM_NEWCHAIN, false);
+				RTM_NEWCHAIN, false, NULL);
 
 	return chain;
 
@@ -1815,7 +1816,8 @@ static int tcf_fill_node(struct net *net, struct sk_buff *skb,
 			 struct tcf_proto *tp, struct tcf_block *block,
 			 struct Qdisc *q, u32 parent, void *fh,
 			 u32 portid, u32 seq, u16 flags, int event,
-			 bool terse_dump, bool rtnl_held)
+			 bool terse_dump, bool rtnl_held,
+			 struct netlink_ext_ack *extack)
 {
 	struct tcmsg *tcm;
 	struct nlmsghdr  *nlh;
@@ -1855,7 +1857,13 @@ static int tcf_fill_node(struct net *net, struct sk_buff *skb,
 		    tp->ops->dump(net, tp, fh, skb, tcm, rtnl_held) < 0)
 			goto nla_put_failure;
 	}
+
+	if (extack && extack->_msg &&
+	    nla_put_string(skb, TCA_EXT_WARN_MSG, extack->_msg))
+		goto nla_put_failure;
+
 	nlh->nlmsg_len = skb_tail_pointer(skb) - b;
+
 	return skb->len;
 
 out_nlmsg_trim:
@@ -1869,7 +1877,7 @@ static int tfilter_notify(struct net *net, struct sk_buff *oskb,
 			  struct nlmsghdr *n, struct tcf_proto *tp,
 			  struct tcf_block *block, struct Qdisc *q,
 			  u32 parent, void *fh, int event, bool unicast,
-			  bool rtnl_held)
+			  bool rtnl_held, struct netlink_ext_ack *extack)
 {
 	struct sk_buff *skb;
 	u32 portid = oskb ? NETLINK_CB(oskb).portid : 0;
@@ -1881,7 +1889,7 @@ static int tfilter_notify(struct net *net, struct sk_buff *oskb,
 
 	if (tcf_fill_node(net, skb, tp, block, q, parent, fh, portid,
 			  n->nlmsg_seq, n->nlmsg_flags, event,
-			  false, rtnl_held) <= 0) {
+			  false, rtnl_held, extack) <= 0) {
 		kfree_skb(skb);
 		return -EINVAL;
 	}
@@ -1910,7 +1918,7 @@ static int tfilter_del_notify(struct net *net, struct sk_buff *oskb,
 
 	if (tcf_fill_node(net, skb, tp, block, q, parent, fh, portid,
 			  n->nlmsg_seq, n->nlmsg_flags, RTM_DELTFILTER,
-			  false, rtnl_held) <= 0) {
+			  false, rtnl_held, extack) <= 0) {
 		NL_SET_ERR_MSG(extack, "Failed to build del event notification");
 		kfree_skb(skb);
 		return -EINVAL;
@@ -1936,14 +1944,15 @@ static int tfilter_del_notify(struct net *net, struct sk_buff *oskb,
 static void tfilter_notify_chain(struct net *net, struct sk_buff *oskb,
 				 struct tcf_block *block, struct Qdisc *q,
 				 u32 parent, struct nlmsghdr *n,
-				 struct tcf_chain *chain, int event)
+				 struct tcf_chain *chain, int event,
+				 struct netlink_ext_ack *extack)
 {
 	struct tcf_proto *tp;
 
 	for (tp = tcf_get_next_proto(chain, NULL);
 	     tp; tp = tcf_get_next_proto(chain, tp))
-		tfilter_notify(net, oskb, n, tp, block,
-			       q, parent, NULL, event, false, true);
+		tfilter_notify(net, oskb, n, tp, block, q, parent, NULL,
+			       event, false, true, extack);
 }
 
 static void tfilter_put(struct tcf_proto *tp, void *fh)
@@ -2147,7 +2156,7 @@ static int tc_new_tfilter(struct sk_buff *skb, struct nlmsghdr *n,
 			      flags, extack);
 	if (err == 0) {
 		tfilter_notify(net, skb, n, tp, block, q, parent, fh,
-			       RTM_NEWTFILTER, false, rtnl_held);
+			       RTM_NEWTFILTER, false, rtnl_held, extack);
 		tfilter_put(tp, fh);
 		/* q pointer is NULL for shared blocks */
 		if (q)
@@ -2275,7 +2284,7 @@ static int tc_del_tfilter(struct sk_buff *skb, struct nlmsghdr *n,
 
 	if (prio == 0) {
 		tfilter_notify_chain(net, skb, block, q, parent, n,
-				     chain, RTM_DELTFILTER);
+				     chain, RTM_DELTFILTER, extack);
 		tcf_chain_flush(chain, rtnl_held);
 		err = 0;
 		goto errout;
@@ -2299,7 +2308,7 @@ static int tc_del_tfilter(struct sk_buff *skb, struct nlmsghdr *n,
 
 		tcf_proto_put(tp, rtnl_held, NULL);
 		tfilter_notify(net, skb, n, tp, block, q, parent, fh,
-			       RTM_DELTFILTER, false, rtnl_held);
+			       RTM_DELTFILTER, false, rtnl_held, extack);
 		err = 0;
 		goto errout;
 	}
@@ -2443,7 +2452,7 @@ static int tc_get_tfilter(struct sk_buff *skb, struct nlmsghdr *n,
 		err = -ENOENT;
 	} else {
 		err = tfilter_notify(net, skb, n, tp, block, q, parent,
-				     fh, RTM_NEWTFILTER, true, rtnl_held);
+				     fh, RTM_NEWTFILTER, true, rtnl_held, NULL);
 		if (err < 0)
 			NL_SET_ERR_MSG(extack, "Failed to send filter notify message");
 	}
@@ -2481,7 +2490,7 @@ static int tcf_node_dump(struct tcf_proto *tp, void *n, struct tcf_walker *arg)
 	return tcf_fill_node(net, a->skb, tp, a->block, a->q, a->parent,
 			     n, NETLINK_CB(a->cb->skb).portid,
 			     a->cb->nlh->nlmsg_seq, NLM_F_MULTI,
-			     RTM_NEWTFILTER, a->terse_dump, true);
+			     RTM_NEWTFILTER, a->terse_dump, true, NULL);
 }
 
 static bool tcf_chain_dump(struct tcf_chain *chain, struct Qdisc *q, u32 parent,
@@ -2515,7 +2524,7 @@ static bool tcf_chain_dump(struct tcf_chain *chain, struct Qdisc *q, u32 parent,
 			if (tcf_fill_node(net, skb, tp, block, q, parent, NULL,
 					  NETLINK_CB(cb->skb).portid,
 					  cb->nlh->nlmsg_seq, NLM_F_MULTI,
-					  RTM_NEWTFILTER, false, true) <= 0)
+					  RTM_NEWTFILTER, false, true, NULL) <= 0)
 				goto errout;
 			cb->args[1] = 1;
 		}
@@ -2658,7 +2667,8 @@ static int tc_chain_fill_node(const struct tcf_proto_ops *tmplt_ops,
 			      void *tmplt_priv, u32 chain_index,
 			      struct net *net, struct sk_buff *skb,
 			      struct tcf_block *block,
-			      u32 portid, u32 seq, u16 flags, int event)
+			      u32 portid, u32 seq, u16 flags, int event,
+			      struct netlink_ext_ack *extack)
 {
 	unsigned char *b = skb_tail_pointer(skb);
 	const struct tcf_proto_ops *ops;
@@ -2695,7 +2705,12 @@ static int tc_chain_fill_node(const struct tcf_proto_ops *tmplt_ops,
 			goto nla_put_failure;
 	}
 
+	if (extack && extack->_msg &&
+	    nla_put_string(skb, TCA_EXT_WARN_MSG, extack->_msg))
+		goto out_nlmsg_trim;
+
 	nlh->nlmsg_len = skb_tail_pointer(skb) - b;
+
 	return skb->len;
 
 out_nlmsg_trim:
@@ -2705,7 +2720,8 @@ static int tc_chain_fill_node(const struct tcf_proto_ops *tmplt_ops,
 }
 
 static int tc_chain_notify(struct tcf_chain *chain, struct sk_buff *oskb,
-			   u32 seq, u16 flags, int event, bool unicast)
+			   u32 seq, u16 flags, int event, bool unicast,
+			   struct netlink_ext_ack *extack)
 {
 	u32 portid = oskb ? NETLINK_CB(oskb).portid : 0;
 	struct tcf_block *block = chain->block;
@@ -2719,7 +2735,7 @@ static int tc_chain_notify(struct tcf_chain *chain, struct sk_buff *oskb,
 
 	if (tc_chain_fill_node(chain->tmplt_ops, chain->tmplt_priv,
 			       chain->index, net, skb, block, portid,
-			       seq, flags, event) <= 0) {
+			       seq, flags, event, extack) <= 0) {
 		kfree_skb(skb);
 		return -EINVAL;
 	}
@@ -2747,7 +2763,7 @@ static int tc_chain_notify_delete(const struct tcf_proto_ops *tmplt_ops,
 		return -ENOBUFS;
 
 	if (tc_chain_fill_node(tmplt_ops, tmplt_priv, chain_index, net, skb,
-			       block, portid, seq, flags, RTM_DELCHAIN) <= 0) {
+			       block, portid, seq, flags, RTM_DELCHAIN, NULL) <= 0) {
 		kfree_skb(skb);
 		return -EINVAL;
 	}
@@ -2900,11 +2916,11 @@ static int tc_ctl_chain(struct sk_buff *skb, struct nlmsghdr *n,
 		}
 
 		tc_chain_notify(chain, NULL, 0, NLM_F_CREATE | NLM_F_EXCL,
-				RTM_NEWCHAIN, false);
+				RTM_NEWCHAIN, false, extack);
 		break;
 	case RTM_DELCHAIN:
 		tfilter_notify_chain(net, skb, block, q, parent, n,
-				     chain, RTM_DELTFILTER);
+				     chain, RTM_DELTFILTER, extack);
 		/* Flush the chain first as the user requested chain removal. */
 		tcf_chain_flush(chain, true);
 		/* In case the chain was successfully deleted, put a reference
@@ -2914,7 +2930,7 @@ static int tc_ctl_chain(struct sk_buff *skb, struct nlmsghdr *n,
 		break;
 	case RTM_GETCHAIN:
 		err = tc_chain_notify(chain, skb, n->nlmsg_seq,
-				      n->nlmsg_flags, n->nlmsg_type, true);
+				      n->nlmsg_flags, n->nlmsg_type, true, extack);
 		if (err < 0)
 			NL_SET_ERR_MSG(extack, "Failed to send chain notify message");
 		break;
@@ -3014,7 +3030,7 @@ static int tc_dump_chain(struct sk_buff *skb, struct netlink_callback *cb)
 					 chain->index, net, skb, block,
 					 NETLINK_CB(cb->skb).portid,
 					 cb->nlh->nlmsg_seq, NLM_F_MULTI,
-					 RTM_NEWCHAIN);
+					 RTM_NEWCHAIN, NULL);
 		if (err <= 0)
 			break;
 		index++;
diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index 6fb345ec22641..3907483dae624 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -907,7 +907,8 @@ static void qdisc_offload_graft_root(struct net_device *dev,
 }
 
 static int tc_fill_qdisc(struct sk_buff *skb, struct Qdisc *q, u32 clid,
-			 u32 portid, u32 seq, u16 flags, int event)
+			 u32 portid, u32 seq, u16 flags, int event,
+			 struct netlink_ext_ack *extack)
 {
 	struct gnet_stats_basic_sync __percpu *cpu_bstats = NULL;
 	struct gnet_stats_queue __percpu *cpu_qstats = NULL;
@@ -975,7 +976,12 @@ static int tc_fill_qdisc(struct sk_buff *skb, struct Qdisc *q, u32 clid,
 	if (gnet_stats_finish_copy(&d) < 0)
 		goto nla_put_failure;
 
+	if (extack && extack->_msg &&
+	    nla_put_string(skb, TCA_EXT_WARN_MSG, extack->_msg))
+		goto out_nlmsg_trim;
+
 	nlh->nlmsg_len = skb_tail_pointer(skb) - b;
+
 	return skb->len;
 
 out_nlmsg_trim:
@@ -996,7 +1002,8 @@ static bool tc_qdisc_dump_ignore(struct Qdisc *q, bool dump_invisible)
 
 static int qdisc_notify(struct net *net, struct sk_buff *oskb,
 			struct nlmsghdr *n, u32 clid,
-			struct Qdisc *old, struct Qdisc *new)
+			struct Qdisc *old, struct Qdisc *new,
+			struct netlink_ext_ack *extack)
 {
 	struct sk_buff *skb;
 	u32 portid = oskb ? NETLINK_CB(oskb).portid : 0;
@@ -1007,12 +1014,12 @@ static int qdisc_notify(struct net *net, struct sk_buff *oskb,
 
 	if (old && !tc_qdisc_dump_ignore(old, false)) {
 		if (tc_fill_qdisc(skb, old, clid, portid, n->nlmsg_seq,
-				  0, RTM_DELQDISC) < 0)
+				  0, RTM_DELQDISC, extack) < 0)
 			goto err_out;
 	}
 	if (new && !tc_qdisc_dump_ignore(new, false)) {
 		if (tc_fill_qdisc(skb, new, clid, portid, n->nlmsg_seq,
-				  old ? NLM_F_REPLACE : 0, RTM_NEWQDISC) < 0)
+				  old ? NLM_F_REPLACE : 0, RTM_NEWQDISC, extack) < 0)
 			goto err_out;
 	}
 
@@ -1027,10 +1034,11 @@ static int qdisc_notify(struct net *net, struct sk_buff *oskb,
 
 static void notify_and_destroy(struct net *net, struct sk_buff *skb,
 			       struct nlmsghdr *n, u32 clid,
-			       struct Qdisc *old, struct Qdisc *new)
+			       struct Qdisc *old, struct Qdisc *new,
+			       struct netlink_ext_ack *extack)
 {
 	if (new || old)
-		qdisc_notify(net, skb, n, clid, old, new);
+		qdisc_notify(net, skb, n, clid, old, new, extack);
 
 	if (old)
 		qdisc_put(old);
@@ -1110,12 +1118,12 @@ static int qdisc_graft(struct net_device *dev, struct Qdisc *parent,
 				qdisc_refcount_inc(new);
 			rcu_assign_pointer(dev->qdisc, new ? : &noop_qdisc);
 
-			notify_and_destroy(net, skb, n, classid, old, new);
+			notify_and_destroy(net, skb, n, classid, old, new, extack);
 
 			if (new && new->ops->attach)
 				new->ops->attach(new);
 		} else {
-			notify_and_destroy(net, skb, n, classid, old, new);
+			notify_and_destroy(net, skb, n, classid, old, new, extack);
 		}
 
 		if (dev->flags & IFF_UP)
@@ -1146,7 +1154,7 @@ static int qdisc_graft(struct net_device *dev, struct Qdisc *parent,
 		err = cops->graft(parent, cl, new, &old, extack);
 		if (err)
 			return err;
-		notify_and_destroy(net, skb, n, classid, old, new);
+		notify_and_destroy(net, skb, n, classid, old, new, extack);
 	}
 	return 0;
 }
@@ -1519,7 +1527,7 @@ static int tc_get_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
 		if (err != 0)
 			return err;
 	} else {
-		qdisc_notify(net, skb, n, clid, NULL, q);
+		qdisc_notify(net, skb, n, clid, NULL, q, NULL);
 	}
 	return 0;
 }
@@ -1667,7 +1675,7 @@ static int tc_modify_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
 	}
 	err = qdisc_change(q, tca, extack);
 	if (err == 0)
-		qdisc_notify(net, skb, n, clid, NULL, q);
+		qdisc_notify(net, skb, n, clid, NULL, q, extack);
 	return err;
 
 create_n_graft:
@@ -1734,7 +1742,7 @@ static int tc_dump_qdisc_root(struct Qdisc *root, struct sk_buff *skb,
 		if (!tc_qdisc_dump_ignore(q, dump_invisible) &&
 		    tc_fill_qdisc(skb, q, q->parent, NETLINK_CB(cb->skb).portid,
 				  cb->nlh->nlmsg_seq, NLM_F_MULTI,
-				  RTM_NEWQDISC) <= 0)
+				  RTM_NEWQDISC, NULL) <= 0)
 			goto done;
 		q_idx++;
 	}
@@ -1756,7 +1764,7 @@ static int tc_dump_qdisc_root(struct Qdisc *root, struct sk_buff *skb,
 		if (!tc_qdisc_dump_ignore(q, dump_invisible) &&
 		    tc_fill_qdisc(skb, q, q->parent, NETLINK_CB(cb->skb).portid,
 				  cb->nlh->nlmsg_seq, NLM_F_MULTI,
-				  RTM_NEWQDISC) <= 0)
+				  RTM_NEWQDISC, NULL) <= 0)
 			goto done;
 		q_idx++;
 	}
@@ -1829,8 +1837,8 @@ static int tc_dump_qdisc(struct sk_buff *skb, struct netlink_callback *cb)
  ************************************************/
 
 static int tc_fill_tclass(struct sk_buff *skb, struct Qdisc *q,
-			  unsigned long cl,
-			  u32 portid, u32 seq, u16 flags, int event)
+			  unsigned long cl, u32 portid, u32 seq, u16 flags,
+			  int event, struct netlink_ext_ack *extack)
 {
 	struct tcmsg *tcm;
 	struct nlmsghdr  *nlh;
@@ -1865,7 +1873,12 @@ static int tc_fill_tclass(struct sk_buff *skb, struct Qdisc *q,
 	if (gnet_stats_finish_copy(&d) < 0)
 		goto nla_put_failure;
 
+	if (extack && extack->_msg &&
+	    nla_put_string(skb, TCA_EXT_WARN_MSG, extack->_msg))
+		goto out_nlmsg_trim;
+
 	nlh->nlmsg_len = skb_tail_pointer(skb) - b;
+
 	return skb->len;
 
 out_nlmsg_trim:
@@ -1876,7 +1889,7 @@ static int tc_fill_tclass(struct sk_buff *skb, struct Qdisc *q,
 
 static int tclass_notify(struct net *net, struct sk_buff *oskb,
 			 struct nlmsghdr *n, struct Qdisc *q,
-			 unsigned long cl, int event)
+			 unsigned long cl, int event, struct netlink_ext_ack *extack)
 {
 	struct sk_buff *skb;
 	u32 portid = oskb ? NETLINK_CB(oskb).portid : 0;
@@ -1885,7 +1898,7 @@ static int tclass_notify(struct net *net, struct sk_buff *oskb,
 	if (!skb)
 		return -ENOBUFS;
 
-	if (tc_fill_tclass(skb, q, cl, portid, n->nlmsg_seq, 0, event) < 0) {
+	if (tc_fill_tclass(skb, q, cl, portid, n->nlmsg_seq, 0, event, extack) < 0) {
 		kfree_skb(skb);
 		return -EINVAL;
 	}
@@ -1912,7 +1925,7 @@ static int tclass_del_notify(struct net *net,
 		return -ENOBUFS;
 
 	if (tc_fill_tclass(skb, q, cl, portid, n->nlmsg_seq, 0,
-			   RTM_DELTCLASS) < 0) {
+			   RTM_DELTCLASS, extack) < 0) {
 		kfree_skb(skb);
 		return -EINVAL;
 	}
@@ -2119,7 +2132,7 @@ static int tc_ctl_tclass(struct sk_buff *skb, struct nlmsghdr *n,
 			tc_bind_tclass(q, portid, clid, 0);
 			goto out;
 		case RTM_GETTCLASS:
-			err = tclass_notify(net, skb, n, q, cl, RTM_NEWTCLASS);
+			err = tclass_notify(net, skb, n, q, cl, RTM_NEWTCLASS, extack);
 			goto out;
 		default:
 			err = -EINVAL;
@@ -2137,7 +2150,7 @@ static int tc_ctl_tclass(struct sk_buff *skb, struct nlmsghdr *n,
 	if (cops->change)
 		err = cops->change(q, clid, portid, tca, &new_cl, extack);
 	if (err == 0) {
-		tclass_notify(net, skb, n, q, new_cl, RTM_NEWTCLASS);
+		tclass_notify(net, skb, n, q, new_cl, RTM_NEWTCLASS, extack);
 		/* We just create a new class, need to do reverse binding. */
 		if (cl != new_cl)
 			tc_bind_tclass(q, portid, clid, new_cl);
@@ -2159,7 +2172,7 @@ static int qdisc_class_dump(struct Qdisc *q, unsigned long cl,
 
 	return tc_fill_tclass(a->skb, q, cl, NETLINK_CB(a->cb->skb).portid,
 			      a->cb->nlh->nlmsg_seq, NLM_F_MULTI,
-			      RTM_NEWTCLASS);
+			      RTM_NEWTCLASS, NULL);
 }
 
 static int tc_dump_tclass_qdisc(struct Qdisc *q, struct sk_buff *skb,
-- 
2.39.2



