Return-Path: <stable+bounces-144463-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CAA0AB7ABF
	for <lists+stable@lfdr.de>; Thu, 15 May 2025 02:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CE334E18DA
	for <lists+stable@lfdr.de>; Thu, 15 May 2025 00:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A347618C034;
	Thu, 15 May 2025 00:49:44 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DD3191F8F;
	Thu, 15 May 2025 00:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747270184; cv=none; b=Q6ERE0Upz0DLycg0i6QFQB5XRGY79SHYjSWVl7sA/eLoiMH4dM7KiIoG0hsJchRK0kVpa6qXGrWjBFjSw9lkgdfX/CCy3ZDo+f3YBI/J0zxh2yxbaKMuz7qRP9yhlIsfhM4s4YWhfVOTUGSherO5sPZWNq4AVfXcUmQco08K710=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747270184; c=relaxed/simple;
	bh=CTBGn+FAblEG8xDs0u55dsuE1wYtE1s9QGMT0UlaHwM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kXqCMPxy5fiIy+rpErqg/5H9DAGT4vAzeOCOjhYoLAdqIr7+wkRvW+z3dImH+UvYw9GBKOe8Us8Try17bzkTMPb060hejpm70q/6Qqw6ctP7FEf9n+gd05fan9YDbon2CgxNhJ38d6mgjLk7jC66bT7QkvkDYczGUwqRwTi6EeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54F0k3U7016375;
	Thu, 15 May 2025 00:49:25 GMT
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 46mbc8sxgb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 15 May 2025 00:49:24 +0000 (GMT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Wed, 14 May 2025 17:49:20 -0700
Received: from pek-lpg-core1.wrs.com (147.11.136.210) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Wed, 14 May 2025 17:49:16 -0700
From: <jianqi.ren.cn@windriver.com>
To: <gregkh@linuxfoundation.org>, <stable@vger.kernel.org>
CC: <patches@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <jianqi.ren.cn@windriver.com>, <idosch@nvidia.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <jhs@mojatatu.com>, <xiyou.wangcong@gmail.com>,
        <jiri@resnulli.us>, <vladbu@mellanox.com>, <netdev@vger.kernel.org>
Subject: [PATCH 5.10.y] net/sched: flower: Fix chain template offload
Date: Thu, 15 May 2025 08:49:13 +0800
Message-ID: <20250515004913.3611901-1-jianqi.ren.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 4rEBOr7PsorjKeEQ0GcwI45B7qS8RyVX
X-Proofpoint-ORIG-GUID: 4rEBOr7PsorjKeEQ0GcwI45B7qS8RyVX
X-Authority-Analysis: v=2.4 cv=IIACChvG c=1 sm=1 tr=0 ts=68253a15 cx=c_pps a=/ZJR302f846pc/tyiSlYyQ==:117 a=/ZJR302f846pc/tyiSlYyQ==:17 a=dt9VzEwgFbYA:10 a=Ikd4Dj_1AAAA:8 a=J1Y8HTJGAAAA:8 a=t7CeM3EgAAAA:8 a=uSdy2bKQw3vfi-H1j0oA:9 a=y1Q9-5lHfBjTkpIzbSAN:22
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDAwNSBTYWx0ZWRfX8Z/iYC9pUWTF BWO0+I1GOyFjkwM5N39aFOgQ+yJHv4H1Sk8j5OdQBjMYQoB7Rktvs9x8QIZ1mvfL6bHoyc02vVl lEkRYrbtpWRIlfwqkS/sS93U+k01p8JjAcbtDr4L/lOp+TqK+5awtMLyCAHGC5a3UphZtceyEml
 P4wFCDQveFiVKG5C7BK9UniFS83obmYa0M1ZKQYFV1dxR5sosayn45NM8m3QsnkjEaa4UxtrCdf G8VkICH9izbUQe4ZcIfxQ3zbCbpexV2BAsh8c+Qhk13+H/aODDSCCbG1gYpbsnyJ5FK2t57UTiQ e7vN7FarFzf9XyAv37rGRRZtAksTG9xP6+i9FDeTqizpkMGgsJNrB0azeyN36VDYk2y7R4CCpeM
 KcWQxm9hwU5DSREA1Lh2G2+abvUiraxotZKpaPJsfzFAUow/GC108eCmkj+IUFsxR3Lh/L6N
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_05,2025-05-14_03,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 mlxscore=0 suspectscore=0 malwarescore=0 phishscore=0
 bulkscore=0 impostorscore=0 mlxlogscore=999 priorityscore=1501
 clxscore=1015 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2505070000
 definitions=main-2505150005

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
[Minor conflict resolved due to code context change.]
Signed-off-by: Jianqi Ren <jianqi.ren.cn@windriver.com>
Signed-off-by: He Zhe <zhe.he@windriver.com>
---
Verified the build test
---
 include/net/sch_generic.h |  4 ++++
 net/sched/cls_api.c       |  9 ++++++++-
 net/sched/cls_flower.c    | 23 +++++++++++++++++++++++
 3 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index 4db11c4695cf..22d2f739692a 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -361,6 +361,10 @@ struct tcf_proto_ops {
 						struct nlattr **tca,
 						struct netlink_ext_ack *extack);
 	void			(*tmplt_destroy)(void *tmplt_priv);
+	void			(*tmplt_reoffload)(struct tcf_chain *chain,
+						   bool add,
+						   flow_setup_cb_t *cb,
+						   void *cb_priv);
 
 	/* rtnetlink specific */
 	int			(*dump)(struct net*, struct tcf_proto*, void *,
diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index beedd0d2b509..521fd4d6eb31 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -1413,6 +1413,9 @@ tcf_block_playback_offloads(struct tcf_block *block, flow_setup_cb_t *cb,
 	     chain_prev = chain,
 		     chain = __tcf_get_next_chain(block, chain),
 		     tcf_chain_put(chain_prev)) {
+		if (chain->tmplt_ops && add)
+			chain->tmplt_ops->tmplt_reoffload(chain, true, cb,
+							  cb_priv);
 		for (tp = __tcf_get_next_proto(chain, NULL); tp;
 		     tp_prev = tp,
 			     tp = __tcf_get_next_proto(chain, tp),
@@ -1428,6 +1431,9 @@ tcf_block_playback_offloads(struct tcf_block *block, flow_setup_cb_t *cb,
 				goto err_playback_remove;
 			}
 		}
+		if (chain->tmplt_ops && !add)
+			chain->tmplt_ops->tmplt_reoffload(chain, false, cb,
+							  cb_priv);
 	}
 
 	return 0;
@@ -2772,7 +2778,8 @@ static int tc_chain_tmplt_add(struct tcf_chain *chain, struct net *net,
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
index 9f6f8430d037..6c9d2afd91fe 100644
--- a/net/sched/cls_flower.c
+++ b/net/sched/cls_flower.c
@@ -2409,6 +2409,28 @@ static void fl_tmplt_destroy(void *tmplt_priv)
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
@@ -3214,6 +3236,7 @@ static struct tcf_proto_ops cls_fl_ops __read_mostly = {
 	.bind_class	= fl_bind_class,
 	.tmplt_create	= fl_tmplt_create,
 	.tmplt_destroy	= fl_tmplt_destroy,
+	.tmplt_reoffload = fl_tmplt_reoffload,
 	.tmplt_dump	= fl_tmplt_dump,
 	.owner		= THIS_MODULE,
 	.flags		= TCF_PROTO_OPS_DOIT_UNLOCKED,
-- 
2.34.1


