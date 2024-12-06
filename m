Return-Path: <stable+bounces-99457-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BBD69E71CB
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 16:00:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B616168FCD
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 15:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A9913AA5F;
	Fri,  6 Dec 2024 15:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ID1gnGxi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3351E871;
	Fri,  6 Dec 2024 15:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733497229; cv=none; b=HrH54s82DZr03uJlDYwkt9JE4WuJqKsIGqC3/OpvBlrTdcMaR4aB7Aksnn2bstXm3NBt1rnCMDlDiHwW97UR1fPELzuD+Cs6GZXLoWJdLGopqscw9uqN/RBm9i0rl/W5GAj7pBHsspeW+AbJ4qBcVl709OIpbuNhFdo0r6yUS/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733497229; c=relaxed/simple;
	bh=6BNqBGCCLkBB+VMl/25Xi6/sqnB+DI494Xf1+wHfVks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GZ1x8bOZEB0gxOWRvOS0a/EDn9DMgwJwoXJeQqUSn6K++1Kwm3tNm14F4lEYzOk7K+p0CtLDU4hQslseOMFtBIrda0E06hBiyIv1XXeU+891QS4RV0W7/QbgTN25U/qdR2z8/kJz6laCb8UeU4AwZ1XhN7XDwOjFRnmR+IexQgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ID1gnGxi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB743C4CED1;
	Fri,  6 Dec 2024 15:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733497229;
	bh=6BNqBGCCLkBB+VMl/25Xi6/sqnB+DI494Xf1+wHfVks=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ID1gnGxi22Q/t1er7fBIJMVST3O/zMlQnHEsJ5SNj0V9G7ba1Heh3eZ0rNX8qWyeo
	 jPbdrU3F93oM3msOtA8Bljk6Ch2b/kE1FDyeaaI7B1wk6GHmPjT9jVLt+7O9a7G6LC
	 QkLjbjMoNu4AqOCn40c9rVDOKvRExBC7Z2ZtLULg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Florian Westphal <fw@strlen.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 231/676] netfilter: nf_tables: must hold rcu read lock while iterating object type list
Date: Fri,  6 Dec 2024 15:30:50 +0100
Message-ID: <20241206143702.356653840@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241206143653.344873888@linuxfoundation.org>
References: <20241206143653.344873888@linuxfoundation.org>
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

From: Florian Westphal <fw@strlen.de>

[ Upstream commit cddc04275f95ca3b18da5c0fb111705ac173af89 ]

Update of stateful object triggers:
WARNING: suspicious RCU usage
net/netfilter/nf_tables_api.c:7759 RCU-list traversed in non-reader section!!

other info that might help us debug this:
rcu_scheduler_active = 2, debug_locks = 1
1 lock held by nft/3060:
 #0: ffff88810f0578c8 (&nft_net->commit_mutex){+.+.}-{4:4}, [..]

... but this list is not protected by the transaction mutex but the
nfnl nftables subsystem mutex.

Switch to nft_obj_type_get which will acquire rcu read lock,
bump refcount, and returns the result.

v3: Dan Carpenter points out nft_obj_type_get returns error pointer, not
NULL, on error.

Fixes: dad3bdeef45f ("netfilter: nf_tables: fix memory leak during stateful obj update").
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_tables_api.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index abab78148c6c8..eee7997048fb9 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -7615,9 +7615,7 @@ static int nf_tables_updobj(const struct nft_ctx *ctx,
 	struct nft_trans *trans;
 	int err = -ENOMEM;
 
-	if (!try_module_get(type->owner))
-		return -ENOENT;
-
+	/* caller must have obtained type->owner reference. */
 	trans = nft_trans_alloc(ctx, NFT_MSG_NEWOBJ,
 				sizeof(struct nft_trans_obj));
 	if (!trans)
@@ -7685,15 +7683,16 @@ static int nf_tables_newobj(struct sk_buff *skb, const struct nfnl_info *info,
 		if (info->nlh->nlmsg_flags & NLM_F_REPLACE)
 			return -EOPNOTSUPP;
 
-		type = __nft_obj_type_get(objtype, family);
-		if (WARN_ON_ONCE(!type))
-			return -ENOENT;
-
 		if (!obj->ops->update)
 			return 0;
 
+		type = nft_obj_type_get(net, objtype, family);
+		if (WARN_ON_ONCE(IS_ERR(type)))
+			return PTR_ERR(type);
+
 		nft_ctx_init(&ctx, net, skb, info->nlh, family, table, NULL, nla);
 
+		/* type->owner reference is put when transaction object is released. */
 		return nf_tables_updobj(&ctx, type, nla[NFTA_OBJ_DATA], obj);
 	}
 
-- 
2.43.0




