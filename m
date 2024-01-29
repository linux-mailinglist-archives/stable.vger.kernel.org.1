Return-Path: <stable+bounces-17187-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8579084102C
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 18:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A85101C239AB
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 17:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC00315A490;
	Mon, 29 Jan 2024 17:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Uic+wYnv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B10515A489;
	Mon, 29 Jan 2024 17:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706548574; cv=none; b=NERdtn/VPb6jaM+eM+k54VLo1pfYsXHq/A+DnULPxWY1fPoh4uSL0o87aiuAof8ucXEayS+m/f2xaP+81ExqcOpAiwcEktAwXMvhUSkFxJHgQLTv0J6w9z6ZO7eSvSSRHzP9py+ogaiTp0k27rs7UxX6X9hO/OqY+KCktqlkknc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706548574; c=relaxed/simple;
	bh=nhmhldWy1O9C4JLdq7+GKw39Xk2yCc+dJtAE6h/wGqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b67269iT86rk7Qq7HXtPINnvRgNVOucPwhXqXdvcQV9a26VsxHbgDDe1uG1D/tCIagVr24yXmfbRcnILFVPBsNaEO0+H3qgm/Yo2oFWjip5rnwBc1hUOPSq9tbeogVUzxn2dQBDHAxS+M6sjhUEIt9siKuTB34j/HMPB0+tB620=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Uic+wYnv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52F4BC433C7;
	Mon, 29 Jan 2024 17:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706548574;
	bh=nhmhldWy1O9C4JLdq7+GKw39Xk2yCc+dJtAE6h/wGqo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Uic+wYnvJooz8Ex+X0cdtL4iOu/ERV7ie6dsWGwWCoSxF/u1BM0YXUMfKL8oBr8M/
	 mwymaw89hLAlJgQuQm5R9KHgs2smaynq/HNewUEarNzv4Dmte6djnJcMSgCsprxdWz
	 Ykx4dFYvNRx8Jeajy4bSrpgw+S6X3C5fthmBVGrE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 191/331] net/sched: flower: Fix chain template offload
Date: Mon, 29 Jan 2024 09:04:15 -0800
Message-ID: <20240129170020.478699049@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129170014.969142961@linuxfoundation.org>
References: <20240129170014.969142961@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ido Schimmel <idosch@nvidia.com>

[ Upstream commit 32f2a0afa95fae0d1ceec2ff06e0e816939964b8 ]

When a qdisc is deleted from a net device the stack instructs the
underlying driver to remove its flow offload callback from the
associated filter block using the 'FLOW_BLOCK_UNBIND' command. The stack
then continues to replay the removal of the filters in the block for
this driver by iterating over the chains in the block and invoking the
'reoffload' operation of the classifier being used. In turn, the
classifier in its 'reoffload' operation prepares and emits a
'FLOW_CLS_DESTROY' command for each filter.

However, the stack does not do the same for chain templates and the
underlying driver never receives a 'FLOW_CLS_TMPLT_DESTROY' command when
a qdisc is deleted. This results in a memory leak [1] which can be
reproduced using [2].

Fix by introducing a 'tmplt_reoffload' operation and have the stack
invoke it with the appropriate arguments as part of the replay.
Implement the operation in the sole classifier that supports chain
templates (flower) by emitting the 'FLOW_CLS_TMPLT_{CREATE,DESTROY}'
command based on whether a flow offload callback is being bound to a
filter block or being unbound from one.

As far as I can tell, the issue happens since cited commit which
reordered tcf_block_offload_unbind() before tcf_block_flush_all_chains()
in __tcf_block_put(). The order cannot be reversed as the filter block
is expected to be freed after flushing all the chains.

[1]
unreferenced object 0xffff888107e28800 (size 2048):
  comm "tc", pid 1079, jiffies 4294958525 (age 3074.287s)
  hex dump (first 32 bytes):
    b1 a6 7c 11 81 88 ff ff e0 5b b3 10 81 88 ff ff  ..|......[......
    01 00 00 00 00 00 00 00 e0 aa b0 84 ff ff ff ff  ................
  backtrace:
    [<ffffffff81c06a68>] __kmem_cache_alloc_node+0x1e8/0x320
    [<ffffffff81ab374e>] __kmalloc+0x4e/0x90
    [<ffffffff832aec6d>] mlxsw_sp_acl_ruleset_get+0x34d/0x7a0
    [<ffffffff832bc195>] mlxsw_sp_flower_tmplt_create+0x145/0x180
    [<ffffffff832b2e1a>] mlxsw_sp_flow_block_cb+0x1ea/0x280
    [<ffffffff83a10613>] tc_setup_cb_call+0x183/0x340
    [<ffffffff83a9f85a>] fl_tmplt_create+0x3da/0x4c0
    [<ffffffff83a22435>] tc_ctl_chain+0xa15/0x1170
    [<ffffffff838a863c>] rtnetlink_rcv_msg+0x3cc/0xed0
    [<ffffffff83ac87f0>] netlink_rcv_skb+0x170/0x440
    [<ffffffff83ac6270>] netlink_unicast+0x540/0x820
    [<ffffffff83ac6e28>] netlink_sendmsg+0x8d8/0xda0
    [<ffffffff83793def>] ____sys_sendmsg+0x30f/0xa80
    [<ffffffff8379d29a>] ___sys_sendmsg+0x13a/0x1e0
    [<ffffffff8379d50c>] __sys_sendmsg+0x11c/0x1f0
    [<ffffffff843b9ce0>] do_syscall_64+0x40/0xe0
unreferenced object 0xffff88816d2c0400 (size 1024):
  comm "tc", pid 1079, jiffies 4294958525 (age 3074.287s)
  hex dump (first 32 bytes):
    40 00 00 00 00 00 00 00 57 f6 38 be 00 00 00 00  @.......W.8.....
    10 04 2c 6d 81 88 ff ff 10 04 2c 6d 81 88 ff ff  ..,m......,m....
  backtrace:
    [<ffffffff81c06a68>] __kmem_cache_alloc_node+0x1e8/0x320
    [<ffffffff81ab36c1>] __kmalloc_node+0x51/0x90
    [<ffffffff81a8ed96>] kvmalloc_node+0xa6/0x1f0
    [<ffffffff82827d03>] bucket_table_alloc.isra.0+0x83/0x460
    [<ffffffff82828d2b>] rhashtable_init+0x43b/0x7c0
    [<ffffffff832aed48>] mlxsw_sp_acl_ruleset_get+0x428/0x7a0
    [<ffffffff832bc195>] mlxsw_sp_flower_tmplt_create+0x145/0x180
    [<ffffffff832b2e1a>] mlxsw_sp_flow_block_cb+0x1ea/0x280
    [<ffffffff83a10613>] tc_setup_cb_call+0x183/0x340
    [<ffffffff83a9f85a>] fl_tmplt_create+0x3da/0x4c0
    [<ffffffff83a22435>] tc_ctl_chain+0xa15/0x1170
    [<ffffffff838a863c>] rtnetlink_rcv_msg+0x3cc/0xed0
    [<ffffffff83ac87f0>] netlink_rcv_skb+0x170/0x440
    [<ffffffff83ac6270>] netlink_unicast+0x540/0x820
    [<ffffffff83ac6e28>] netlink_sendmsg+0x8d8/0xda0
    [<ffffffff83793def>] ____sys_sendmsg+0x30f/0xa80

[2]
 # tc qdisc add dev swp1 clsact
 # tc chain add dev swp1 ingress proto ip chain 1 flower dst_ip 0.0.0.0/32
 # tc qdisc del dev swp1 clsact
 # devlink dev reload pci/0000:06:00.0

Fixes: bbf73830cd48 ("net: sched: traverse chains in block with tcf_get_next_chain()")
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/sch_generic.h |  4 ++++
 net/sched/cls_api.c       |  9 ++++++++-
 net/sched/cls_flower.c    | 23 +++++++++++++++++++++++
 3 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index f232512505f8..e940debac400 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -376,6 +376,10 @@ struct tcf_proto_ops {
 						struct nlattr **tca,
 						struct netlink_ext_ack *extack);
 	void			(*tmplt_destroy)(void *tmplt_priv);
+	void			(*tmplt_reoffload)(struct tcf_chain *chain,
+						   bool add,
+						   flow_setup_cb_t *cb,
+						   void *cb_priv);
 	struct tcf_exts *	(*get_exts)(const struct tcf_proto *tp,
 					    u32 handle);
 
diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index a193cc7b3241..84e18b5f72a3 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -1536,6 +1536,9 @@ tcf_block_playback_offloads(struct tcf_block *block, flow_setup_cb_t *cb,
 	     chain_prev = chain,
 		     chain = __tcf_get_next_chain(block, chain),
 		     tcf_chain_put(chain_prev)) {
+		if (chain->tmplt_ops && add)
+			chain->tmplt_ops->tmplt_reoffload(chain, true, cb,
+							  cb_priv);
 		for (tp = __tcf_get_next_proto(chain, NULL); tp;
 		     tp_prev = tp,
 			     tp = __tcf_get_next_proto(chain, tp),
@@ -1551,6 +1554,9 @@ tcf_block_playback_offloads(struct tcf_block *block, flow_setup_cb_t *cb,
 				goto err_playback_remove;
 			}
 		}
+		if (chain->tmplt_ops && !add)
+			chain->tmplt_ops->tmplt_reoffload(chain, false, cb,
+							  cb_priv);
 	}
 
 	return 0;
@@ -2950,7 +2956,8 @@ static int tc_chain_tmplt_add(struct tcf_chain *chain, struct net *net,
 	ops = tcf_proto_lookup_ops(name, true, extack);
 	if (IS_ERR(ops))
 		return PTR_ERR(ops);
-	if (!ops->tmplt_create || !ops->tmplt_destroy || !ops->tmplt_dump) {
+	if (!ops->tmplt_create || !ops->tmplt_destroy || !ops->tmplt_dump ||
+	    !ops->tmplt_reoffload) {
 		NL_SET_ERR_MSG(extack, "Chain templates are not supported with specified classifier");
 		module_put(ops->owner);
 		return -EOPNOTSUPP;
diff --git a/net/sched/cls_flower.c b/net/sched/cls_flower.c
index e5314a31f75a..efb9d2811b73 100644
--- a/net/sched/cls_flower.c
+++ b/net/sched/cls_flower.c
@@ -2721,6 +2721,28 @@ static void fl_tmplt_destroy(void *tmplt_priv)
 	kfree(tmplt);
 }
 
+static void fl_tmplt_reoffload(struct tcf_chain *chain, bool add,
+			       flow_setup_cb_t *cb, void *cb_priv)
+{
+	struct fl_flow_tmplt *tmplt = chain->tmplt_priv;
+	struct flow_cls_offload cls_flower = {};
+
+	cls_flower.rule = flow_rule_alloc(0);
+	if (!cls_flower.rule)
+		return;
+
+	cls_flower.common.chain_index = chain->index;
+	cls_flower.command = add ? FLOW_CLS_TMPLT_CREATE :
+				   FLOW_CLS_TMPLT_DESTROY;
+	cls_flower.cookie = (unsigned long) tmplt;
+	cls_flower.rule->match.dissector = &tmplt->dissector;
+	cls_flower.rule->match.mask = &tmplt->mask;
+	cls_flower.rule->match.key = &tmplt->dummy_key;
+
+	cb(TC_SETUP_CLSFLOWER, &cls_flower, cb_priv);
+	kfree(cls_flower.rule);
+}
+
 static int fl_dump_key_val(struct sk_buff *skb,
 			   void *val, int val_type,
 			   void *mask, int mask_type, int len)
@@ -3628,6 +3650,7 @@ static struct tcf_proto_ops cls_fl_ops __read_mostly = {
 	.bind_class	= fl_bind_class,
 	.tmplt_create	= fl_tmplt_create,
 	.tmplt_destroy	= fl_tmplt_destroy,
+	.tmplt_reoffload = fl_tmplt_reoffload,
 	.tmplt_dump	= fl_tmplt_dump,
 	.get_exts	= fl_get_exts,
 	.owner		= THIS_MODULE,
-- 
2.43.0




