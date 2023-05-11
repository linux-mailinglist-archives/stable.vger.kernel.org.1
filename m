Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7E06FF63D
	for <lists+stable@lfdr.de>; Thu, 11 May 2023 17:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238362AbjEKPmK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 11 May 2023 11:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238787AbjEKPmI (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 11 May 2023 11:42:08 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4332526B3;
        Thu, 11 May 2023 08:42:05 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     fw@strlen.de, gregkh@linuxfoundation.org, sashal@kernel.org,
        stable@vger.kernel.org
Subject: [PATCH -stable,4.14 4/6] netfilter: nf_tables: use-after-free in failing rule with bound set
Date:   Thu, 11 May 2023 17:41:41 +0200
Message-Id: <20230511154143.52469-5-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230511154143.52469-1-pablo@netfilter.org>
References: <20230511154143.52469-1-pablo@netfilter.org>
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

[ backport for 4.14 of 6a0a8d10a3661a036b55af695542a714c429ab7c ]

If a rule that has already a bound anonymous set fails to be added, the
preparation phase releases the rule and the bound set. However, the
transaction object from the abort path still has a reference to the set
object that is stale, leading to a use-after-free when checking for the
set->bound field. Add a new field to the transaction that specifies if
the set is bound, so the abort path can skip releasing it since the rule
command owns it and it takes care of releasing it. After this update,
the set->bound field is removed.

[   24.649883] Unable to handle kernel paging request at virtual address 0000000000040434
[   24.657858] Mem abort info:
[   24.660686]   ESR = 0x96000004
[   24.663769]   Exception class = DABT (current EL), IL = 32 bits
[   24.669725]   SET = 0, FnV = 0
[   24.672804]   EA = 0, S1PTW = 0
[   24.675975] Data abort info:
[   24.678880]   ISV = 0, ISS = 0x00000004
[   24.682743]   CM = 0, WnR = 0
[   24.685723] user pgtable: 4k pages, 48-bit VAs, pgdp=0000000428952000
[   24.692207] [0000000000040434] pgd=0000000000000000
[   24.697119] Internal error: Oops: 96000004 [#1] SMP
[...]
[   24.889414] Call trace:
[   24.891870]  __nf_tables_abort+0x3f0/0x7a0
[   24.895984]  nf_tables_abort+0x20/0x40
[   24.899750]  nfnetlink_rcv_batch+0x17c/0x588
[   24.904037]  nfnetlink_rcv+0x13c/0x190
[   24.907803]  netlink_unicast+0x18c/0x208
[   24.911742]  netlink_sendmsg+0x1b0/0x350
[   24.915682]  sock_sendmsg+0x4c/0x68
[   24.919185]  ___sys_sendmsg+0x288/0x2c8
[   24.923037]  __sys_sendmsg+0x7c/0xd0
[   24.926628]  __arm64_sys_sendmsg+0x2c/0x38
[   24.930744]  el0_svc_common.constprop.0+0x94/0x158
[   24.935556]  el0_svc_handler+0x34/0x90
[   24.939322]  el0_svc+0x8/0xc
[   24.942216] Code: 37280300 f9404023 91014262 aa1703e0 (f9401863)
[   24.948336] ---[ end trace cebbb9dcbed3b56f ]---

Fixes: f6ac85858976 ("netfilter: nf_tables: unbind set in rule from commit path")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 include/net/netfilter/nf_tables.h |  3 +++
 net/netfilter/nf_tables_api.c     | 22 +++++++++++++++++-----
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index cc6ba7e593e7..ca82f32d10cd 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -1335,12 +1335,15 @@ struct nft_trans_table {
 struct nft_trans_elem {
 	struct nft_set			*set;
 	struct nft_set_elem		elem;
+	bool				bound;
 };
 
 #define nft_trans_elem_set(trans)	\
 	(((struct nft_trans_elem *)trans->data)->set)
 #define nft_trans_elem(trans)	\
 	(((struct nft_trans_elem *)trans->data)->elem)
+#define nft_trans_elem_set_bound(trans)	\
+	(((struct nft_trans_elem *)trans->data)->bound)
 
 struct nft_trans_obj {
 	struct nft_object		*obj;
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 5541ba7cc4a0..e9e3e7680a14 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -149,9 +149,14 @@ static void nft_set_trans_bind(const struct nft_ctx *ctx, struct nft_set *set)
 		return;
 
 	list_for_each_entry_reverse(trans, &net->nft.commit_list, list) {
-		if (trans->msg_type == NFT_MSG_NEWSET &&
-		    nft_trans_set(trans) == set) {
-			nft_trans_set_bound(trans) = true;
+		switch (trans->msg_type) {
+		case NFT_MSG_NEWSET:
+			if (nft_trans_set(trans) == set)
+				nft_trans_set_bound(trans) = true;
+			break;
+		case NFT_MSG_NEWSETELEM:
+			if (nft_trans_elem_set(trans) == set)
+				nft_trans_elem_set_bound(trans) = true;
 			break;
 		}
 	}
@@ -5340,8 +5345,11 @@ static int nf_tables_abort(struct net *net, struct sk_buff *skb)
 			break;
 		case NFT_MSG_NEWSET:
 			trans->ctx.table->use--;
-			if (!nft_trans_set_bound(trans))
-				list_del_rcu(&nft_trans_set(trans)->list);
+			if (nft_trans_set_bound(trans)) {
+				nft_trans_destroy(trans);
+				break;
+			}
+			list_del_rcu(&nft_trans_set(trans)->list);
 			break;
 		case NFT_MSG_DELSET:
 			trans->ctx.table->use++;
@@ -5349,6 +5357,10 @@ static int nf_tables_abort(struct net *net, struct sk_buff *skb)
 			nft_trans_destroy(trans);
 			break;
 		case NFT_MSG_NEWSETELEM:
+			if (nft_trans_elem_set_bound(trans)) {
+				nft_trans_destroy(trans);
+				break;
+			}
 			te = (struct nft_trans_elem *)trans->data;
 
 			te->set->ops->remove(net, te->set, &te->elem);
-- 
2.30.2

