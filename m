Return-Path: <stable+bounces-36013-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39366899547
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 08:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEEFE1F22461
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 06:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D597C22616;
	Fri,  5 Apr 2024 06:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="H3npJxLP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968F11803D
	for <stable@vger.kernel.org>; Fri,  5 Apr 2024 06:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712298437; cv=none; b=m42MUZ0poQCUAj0oH7RV6B/QbcWD182nnWHLXDUazYvgJK0uK2JvRVjkqYK3ZluNsXFvLx26+K/P24ssVqyA6fHFZ8tyvWhc2ZWg6sigtj903IuvNcbUQIXsR7SwjijaTgw6XBTJjhclIrQIHW2afjhOdFA9MhfgLhUurGTuwXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712298437; c=relaxed/simple;
	bh=96gC5syfvMfAJ3HWw4C9Kv8ts4YOYXlXSSYuXl9++5I=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=J5jB0zL44eJTL26W8j5hvQ5ZtDvwNM/rfWFnAMLB73LijzQtKnyRG/xPGaHDXDSC4UQmykEBCRHwzmgjCTxSUioWoHdMi5Mdt7dqZeI4vR/d9fGmBgJ5JsDXylu6EkgoUhDcD28hOmo5yykxOFGCk3KJ1pm+6bAJgRhmyMhG9Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=H3npJxLP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA9C5C433F1;
	Fri,  5 Apr 2024 06:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712298437;
	bh=96gC5syfvMfAJ3HWw4C9Kv8ts4YOYXlXSSYuXl9++5I=;
	h=Subject:To:Cc:From:Date:From;
	b=H3npJxLPQ6I8MC7DievoCg8h2Wbf0cSQfqTB9UFGEZ3/qLA0cup3J7tw5nkv60G9h
	 8otsKUleAZeQxqejMuEydWrzBzXTwMTxp6zd63M8HEk2N/zCiUGaGSb5Vbia97VmuR
	 ghUnz3NbenXpTHRHLNSSEtn6HKM4BgjMkOBXtD24=
Subject: FAILED: patch "[PATCH] netfilter: nf_tables: release batch on table validation from" failed to apply to 5.4-stable tree
To: pablo@netfilter.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 05 Apr 2024 08:27:01 +0200
Message-ID: <2024040501-playpen-squeezing-60a4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x a45e6889575c2067d3c0212b6bc1022891e65b91
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024040501-playpen-squeezing-60a4@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a45e6889575c2067d3c0212b6bc1022891e65b91 Mon Sep 17 00:00:00 2001
From: Pablo Neira Ayuso <pablo@netfilter.org>
Date: Thu, 28 Mar 2024 13:27:36 +0100
Subject: [PATCH] netfilter: nf_tables: release batch on table validation from
 abort path

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

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index fd86f2720c9e..ffcd3213c335 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -10455,10 +10455,11 @@ static int __nf_tables_abort(struct net *net, enum nfnl_abort_action action)
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
@@ -10655,7 +10656,7 @@ static int __nf_tables_abort(struct net *net, enum nfnl_abort_action action)
 	else
 		nf_tables_module_autoload_cleanup(net);
 
-	return 0;
+	return err;
 }
 
 static int nf_tables_abort(struct net *net, struct sk_buff *skb,
@@ -10668,6 +10669,9 @@ static int nf_tables_abort(struct net *net, struct sk_buff *skb,
 	gc_seq = nft_gc_seq_begin(nft_net);
 	ret = __nf_tables_abort(net, action);
 	nft_gc_seq_end(nft_net, gc_seq);
+
+	WARN_ON_ONCE(!list_empty(&nft_net->commit_list));
+
 	mutex_unlock(&nft_net->commit_mutex);
 
 	return ret;
@@ -11473,9 +11477,10 @@ static void __net_exit nf_tables_exit_net(struct net *net)
 
 	gc_seq = nft_gc_seq_begin(nft_net);
 
-	if (!list_empty(&nft_net->commit_list) ||
-	    !list_empty(&nft_net->module_list))
-		__nf_tables_abort(net, NFNL_ABORT_NONE);
+	WARN_ON_ONCE(!list_empty(&nft_net->commit_list));
+
+	if (!list_empty(&nft_net->module_list))
+		nf_tables_module_autoload_cleanup(net);
 
 	__nft_release_tables(net);
 


