Return-Path: <stable+bounces-39011-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE70E8A1174
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 12:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF6741C21C2D
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 10:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB74A146D4D;
	Thu, 11 Apr 2024 10:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="U3zemGEe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECDF146A8D;
	Thu, 11 Apr 2024 10:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712832254; cv=none; b=ktibsq6HzaorRLhSm+L0f86SKx6Sh2qKvq/HilhgsUU8SEV85F1naYirTtelF/u9z+ouBr2hHJEkxoaxw4wBRDDR+on3ZCCPUCXN+XqBOs97GSJ07Qb56O2ui+utSATwAH29wtGw/WqSiFEbA3LCG6fsvR6V6WyUYDZO47Yo0Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712832254; c=relaxed/simple;
	bh=YurgdaU/nSgksSMLFFJo0/8oPOwSW3JZUEGKG9j+QUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uUtFICZ+MkG4jkVNM28+hMandvF+rMBogR4ybivhOzK8PnSHlhSsXGqq2DPvAdzmgIw8qMS9FRqdMcMriC7EMsQJPxHtxYipTyTM96e3AMy6Qs4EubEd+9y+htDndI3C46LwTYlQDjQz7j4V0YONh/GhTxiuo/ufvn5jMx686CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=U3zemGEe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3C22C43390;
	Thu, 11 Apr 2024 10:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712832254;
	bh=YurgdaU/nSgksSMLFFJo0/8oPOwSW3JZUEGKG9j+QUU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U3zemGEeJ60+s2yiEQtYXyp0TwUcKzpYOnO7bSWMSSQNsf9jgaR/Go6zAiCPPqhFO
	 xggB+r39L4sWzXHt55pmTqXUW+W45bmLZIYzkrl5lqv/d7llYX7aEPN1lkEx1QB4mP
	 HM62gFOVmnZ/9qSR65VB6uQtc8iUeAOyBUDszQ7A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 282/294] netfilter: nf_tables: release batch on table validation from abort path
Date: Thu, 11 Apr 2024 11:57:25 +0200
Message-ID: <20240411095444.027478608@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411095435.633465671@linuxfoundation.org>
References: <20240411095435.633465671@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pablo Neira Ayuso <pablo@netfilter.org>

commit a45e6889575c2067d3c0212b6bc1022891e65b91 upstream.

Unlike early commit path stage which triggers a call to abort, an
explicit release of the batch is required on abort, otherwise mutex is
released and commit_list remains in place.

Add WARN_ON_ONCE to ensure commit_list is empty from the abort path
before releasing the mutex.

After this patch, commit_list is always assumed to be empty before
grabbing the mutex, therefore

  03c1f1ef1584 ("netfilter: Cleanup nft_net->module_list from nf_tables_exit_net()")

only needs to release the pending modules for registration.

Cc: stable@vger.kernel.org
Fixes: c0391b6ab810 ("netfilter: nf_tables: missing validation from the abort path")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_tables_api.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index dd440d7910a62..6c5de620da9f1 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -8800,10 +8800,11 @@ static int __nf_tables_abort(struct net *net, enum nfnl_abort_action action)
 	struct nft_trans *trans, *next;
 	LIST_HEAD(set_update_list);
 	struct nft_trans_elem *te;
+	int err = 0;
 
 	if (action == NFNL_ABORT_VALIDATE &&
 	    nf_tables_validate(net) < 0)
-		return -EAGAIN;
+		err = -EAGAIN;
 
 	list_for_each_entry_safe_reverse(trans, next, &nft_net->commit_list,
 					 list) {
@@ -8968,7 +8969,7 @@ static int __nf_tables_abort(struct net *net, enum nfnl_abort_action action)
 	else
 		nf_tables_module_autoload_cleanup(net);
 
-	return 0;
+	return err;
 }
 
 static int nf_tables_abort(struct net *net, struct sk_buff *skb,
@@ -8982,6 +8983,8 @@ static int nf_tables_abort(struct net *net, struct sk_buff *skb,
 	ret = __nf_tables_abort(net, action);
 	nft_gc_seq_end(nft_net, gc_seq);
 
+	WARN_ON_ONCE(!list_empty(&nft_net->commit_list));
+
 	mutex_unlock(&nft_net->commit_mutex);
 
 	return ret;
@@ -9716,8 +9719,11 @@ static void __net_exit nf_tables_exit_net(struct net *net)
 
 	gc_seq = nft_gc_seq_begin(nft_net);
 
-	if (!list_empty(&nft_net->commit_list))
-		__nf_tables_abort(net, NFNL_ABORT_NONE);
+	WARN_ON_ONCE(!list_empty(&nft_net->commit_list));
+
+	if (!list_empty(&nft_net->module_list))
+		nf_tables_module_autoload_cleanup(net);
+
 	__nft_release_tables(net);
 
 	nft_gc_seq_end(nft_net, gc_seq);
-- 
2.43.0




