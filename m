Return-Path: <stable+bounces-2526-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C64B7F849E
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 20:28:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6A22B28497
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD6439FFD;
	Fri, 24 Nov 2023 19:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oYgnecXf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBCE35F1A;
	Fri, 24 Nov 2023 19:28:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69DEBC433C7;
	Fri, 24 Nov 2023 19:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700854101;
	bh=2qkPU4Da+f23tR4KBie2TIBAtPY6mXa8XIGGM+ZC0ZY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oYgnecXfea7BCD4vKyKggTRhIIocrx9khuklNXYEpfIPbffWLeUJn5afP+Z0IaDop
	 pu//zpnH4zlIhdpafmVL0WCI9LUGnWhMSn1lINBrsCtIMNO8Z8wHt95AwotiQ7zO9u
	 NNaWyzNmL1lRGGwLXkB98vaDugU0tnv7pMOqBBKY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org,
	netfilter-devel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+7ad5cd1615f2d89c6e7e@syzkaller.appspotmail.com,
	Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 5.4 157/159] netfilter: nf_tables: fix table flag updates
Date: Fri, 24 Nov 2023 17:56:14 +0000
Message-ID: <20231124171948.326553575@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124171941.909624388@linuxfoundation.org>
References: <20231124171941.909624388@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pablo Neira Ayuso <pablo@netfilter.org>

commit 179d9ba5559a756f4322583388b3213fe4e391b0 upstream.

The dormant flag need to be updated from the preparation phase,
otherwise, two consecutive requests to dorm a table in the same batch
might try to remove the same hooks twice, resulting in the following
warning:

 hook not found, pf 3 num 0
 WARNING: CPU: 0 PID: 334 at net/netfilter/core.c:480 __nf_unregister_net_hook+0x1eb/0x610 net/netfilter/core.c:480
 Modules linked in:
 CPU: 0 PID: 334 Comm: kworker/u4:5 Not tainted 5.12.0-syzkaller #0
 Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
 Workqueue: netns cleanup_net
 RIP: 0010:__nf_unregister_net_hook+0x1eb/0x610 net/netfilter/core.c:480

This patch is a partial revert of 0ce7cf4127f1 ("netfilter: nftables:
update table flags from the commit phase") to restore the previous
behaviour.

However, there is still another problem: A batch containing a series of
dorm-wakeup-dorm table and vice-versa also trigger the warning above
since hook unregistration happens from the preparation phase, while hook
registration occurs from the commit phase.

To fix this problem, this patch adds two internal flags to annotate the
original dormant flag status which are __NFT_TABLE_F_WAS_DORMANT and
__NFT_TABLE_F_WAS_AWAKEN, to restore it from the abort path.

The __NFT_TABLE_F_UPDATE bitmask allows to handle the dormant flag update
with one single transaction.

Reported-by: syzbot+7ad5cd1615f2d89c6e7e@syzkaller.appspotmail.com
Fixes: 0ce7cf4127f1 ("netfilter: nftables: update table flags from the commit phase")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/netfilter/nf_tables.h        |    6 ---
 include/uapi/linux/netfilter/nf_tables.h |    1 
 net/netfilter/nf_tables_api.c            |   59 +++++++++++++++++++++----------
 3 files changed, 41 insertions(+), 25 deletions(-)

--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -1392,16 +1392,10 @@ struct nft_trans_chain {
 
 struct nft_trans_table {
 	bool				update;
-	u8				state;
-	u32				flags;
 };
 
 #define nft_trans_table_update(trans)	\
 	(((struct nft_trans_table *)trans->data)->update)
-#define nft_trans_table_state(trans)	\
-	(((struct nft_trans_table *)trans->data)->state)
-#define nft_trans_table_flags(trans)	\
-	(((struct nft_trans_table *)trans->data)->flags)
 
 struct nft_trans_elem {
 	struct nft_set			*set;
--- a/include/uapi/linux/netfilter/nf_tables.h
+++ b/include/uapi/linux/netfilter/nf_tables.h
@@ -162,6 +162,7 @@ enum nft_hook_attributes {
 enum nft_table_flags {
 	NFT_TABLE_F_DORMANT	= 0x1,
 };
+#define NFT_TABLE_F_MASK       (NFT_TABLE_F_DORMANT)
 
 /**
  * enum nft_table_attributes - nf_tables table netlink attributes
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -701,7 +701,8 @@ static int nf_tables_fill_table_info(str
 		goto nla_put_failure;
 
 	if (nla_put_string(skb, NFTA_TABLE_NAME, table->name) ||
-	    nla_put_be32(skb, NFTA_TABLE_FLAGS, htonl(table->flags)) ||
+	    nla_put_be32(skb, NFTA_TABLE_FLAGS,
+			 htonl(table->flags & NFT_TABLE_F_MASK)) ||
 	    nla_put_be32(skb, NFTA_TABLE_USE, htonl(table->use)) ||
 	    nla_put_be64(skb, NFTA_TABLE_HANDLE, cpu_to_be64(table->handle),
 			 NFTA_TABLE_PAD))
@@ -890,20 +891,22 @@ err:
 
 static void nf_tables_table_disable(struct net *net, struct nft_table *table)
 {
+	table->flags &= ~NFT_TABLE_F_DORMANT;
 	nft_table_disable(net, table, 0);
+	table->flags |= NFT_TABLE_F_DORMANT;
 }
 
-enum {
-	NFT_TABLE_STATE_UNCHANGED	= 0,
-	NFT_TABLE_STATE_DORMANT,
-	NFT_TABLE_STATE_WAKEUP
-};
+#define __NFT_TABLE_F_INTERNAL		(NFT_TABLE_F_MASK + 1)
+#define __NFT_TABLE_F_WAS_DORMANT	(__NFT_TABLE_F_INTERNAL << 0)
+#define __NFT_TABLE_F_WAS_AWAKEN	(__NFT_TABLE_F_INTERNAL << 1)
+#define __NFT_TABLE_F_UPDATE		(__NFT_TABLE_F_WAS_DORMANT | \
+					 __NFT_TABLE_F_WAS_AWAKEN)
 
 static int nf_tables_updtable(struct nft_ctx *ctx)
 {
 	struct nft_trans *trans;
 	u32 flags;
-	int ret = 0;
+	int ret;
 
 	if (!ctx->nla[NFTA_TABLE_FLAGS])
 		return 0;
@@ -922,21 +925,27 @@ static int nf_tables_updtable(struct nft
 
 	if ((flags & NFT_TABLE_F_DORMANT) &&
 	    !(ctx->table->flags & NFT_TABLE_F_DORMANT)) {
-		nft_trans_table_state(trans) = NFT_TABLE_STATE_DORMANT;
+		ctx->table->flags |= NFT_TABLE_F_DORMANT;
+		if (!(ctx->table->flags & __NFT_TABLE_F_UPDATE))
+			ctx->table->flags |= __NFT_TABLE_F_WAS_AWAKEN;
 	} else if (!(flags & NFT_TABLE_F_DORMANT) &&
 		   ctx->table->flags & NFT_TABLE_F_DORMANT) {
-		ret = nf_tables_table_enable(ctx->net, ctx->table);
-		if (ret >= 0)
-			nft_trans_table_state(trans) = NFT_TABLE_STATE_WAKEUP;
+		ctx->table->flags &= ~NFT_TABLE_F_DORMANT;
+		if (!(ctx->table->flags & __NFT_TABLE_F_UPDATE)) {
+			ret = nf_tables_table_enable(ctx->net, ctx->table);
+			if (ret < 0)
+				goto err_register_hooks;
+
+			ctx->table->flags |= __NFT_TABLE_F_WAS_DORMANT;
+		}
 	}
-	if (ret < 0)
-		goto err;
 
-	nft_trans_table_flags(trans) = flags;
 	nft_trans_table_update(trans) = true;
 	nft_trans_commit_list_add_tail(ctx->net, trans);
+
 	return 0;
-err:
+
+err_register_hooks:
 	nft_trans_destroy(trans);
 	return ret;
 }
@@ -7302,10 +7311,14 @@ static int nf_tables_commit(struct net *
 		switch (trans->msg_type) {
 		case NFT_MSG_NEWTABLE:
 			if (nft_trans_table_update(trans)) {
-				if (nft_trans_table_state(trans) == NFT_TABLE_STATE_DORMANT)
+				if (!(trans->ctx.table->flags & __NFT_TABLE_F_UPDATE)) {
+					nft_trans_destroy(trans);
+					break;
+				}
+				if (trans->ctx.table->flags & NFT_TABLE_F_DORMANT)
 					nf_tables_table_disable(net, trans->ctx.table);
 
-				trans->ctx.table->flags = nft_trans_table_flags(trans);
+				trans->ctx.table->flags &= ~__NFT_TABLE_F_UPDATE;
 			} else {
 				nft_clear(net, trans->ctx.table);
 			}
@@ -7500,9 +7513,17 @@ static int __nf_tables_abort(struct net
 		switch (trans->msg_type) {
 		case NFT_MSG_NEWTABLE:
 			if (nft_trans_table_update(trans)) {
-				if (nft_trans_table_state(trans) == NFT_TABLE_STATE_WAKEUP)
+				if (!(trans->ctx.table->flags & __NFT_TABLE_F_UPDATE)) {
+					nft_trans_destroy(trans);
+					break;
+				}
+				if (trans->ctx.table->flags & __NFT_TABLE_F_WAS_DORMANT) {
 					nf_tables_table_disable(net, trans->ctx.table);
-
+					trans->ctx.table->flags |= NFT_TABLE_F_DORMANT;
+				} else if (trans->ctx.table->flags & __NFT_TABLE_F_WAS_AWAKEN) {
+					trans->ctx.table->flags &= ~NFT_TABLE_F_DORMANT;
+				}
+				trans->ctx.table->flags &= ~__NFT_TABLE_F_UPDATE;
 				nft_trans_destroy(trans);
 			} else {
 				list_del_rcu(&trans->ctx.table->list);



