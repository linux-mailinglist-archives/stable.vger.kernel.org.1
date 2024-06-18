Return-Path: <stable+bounces-53600-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD97990D296
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 15:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B3271F248D5
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 13:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A63D15A868;
	Tue, 18 Jun 2024 13:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cZdqSsby"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0623B12D74D;
	Tue, 18 Jun 2024 13:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718716810; cv=none; b=XVqk4pynYAv2RIuXcTCyl03AJywL3/pf8NyOIyimx90w7u7TyVnKWmQSk3iKDJLT7j7EdavzKb8NyBQZoTU8OqJ2Qwk1vgSvr5BxldI1p6Hu76xbevx/9Qy77KGhIieQn2MsIJyjA/4IQbdJFckfDOksrhzjOhEkRbzqwAG8ZU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718716810; c=relaxed/simple;
	bh=UujEcCb2SvPH+hOOdBmQ7wmc59Q6TWC5t2B23+khsN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DVc734wzAG/D5JOn6XwRIVc65YrwSJ2KuMGe7FuCG6mVuPx06oudSBCFd9vhbpInhDJQGm4LeebBpsZAvlvzakYqwMjFti7MNqg51EM0MCYb73j21KQA8BHo1biF6XPu7aifgM6tXOIaujK3tlTMbFuHfASfpQCkmvn1V0fS+Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cZdqSsby; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81F20C32786;
	Tue, 18 Jun 2024 13:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718716809;
	bh=UujEcCb2SvPH+hOOdBmQ7wmc59Q6TWC5t2B23+khsN8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cZdqSsbyjygmhhPWieNyvldc5Z/Koldm3E/f8pJOdnm8cN8VTUZ/pZaP4aa+ZxIp+
	 /arHkv/7g8qE8c1UAxBx1XyRWYTHMQWh9jmX/axciUesr+/nZ9zN/A63QNC+TqJHz4
	 wKuRIFpCIBtUSi1E/G5Ca+yJ8VN0RulPoXkSBtPc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 753/770] nfsd: simplify the delayed disposal list code
Date: Tue, 18 Jun 2024 14:40:06 +0200
Message-ID: <20240618123436.335955080@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240618123407.280171066@linuxfoundation.org>
References: <20240618123407.280171066@linuxfoundation.org>
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

From: Jeff Layton <jlayton@kernel.org>

[ Upstream commit 92e4a6733f922f0fef1d0995f7b2d0eaff86c7ea ]

When queueing a dispose list to the appropriate "freeme" lists, it
pointlessly queues the objects one at a time to an intermediate list.

Remove a few helpers and just open code a list_move to make it more
clear and efficient. Better document the resulting functions with
kerneldoc comments.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/filecache.c | 64 ++++++++++++++++-----------------------------
 1 file changed, 22 insertions(+), 42 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 52e67ec267965..6b8706f23eaf0 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -401,49 +401,26 @@ nfsd_file_dispose_list(struct list_head *dispose)
 	}
 }
 
-static void
-nfsd_file_list_remove_disposal(struct list_head *dst,
-		struct nfsd_fcache_disposal *l)
-{
-	spin_lock(&l->lock);
-	list_splice_init(&l->freeme, dst);
-	spin_unlock(&l->lock);
-}
-
-static void
-nfsd_file_list_add_disposal(struct list_head *files, struct net *net)
-{
-	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
-	struct nfsd_fcache_disposal *l = nn->fcache_disposal;
-
-	spin_lock(&l->lock);
-	list_splice_tail_init(files, &l->freeme);
-	spin_unlock(&l->lock);
-	queue_work(nfsd_filecache_wq, &l->work);
-}
-
-static void
-nfsd_file_list_add_pernet(struct list_head *dst, struct list_head *src,
-		struct net *net)
-{
-	struct nfsd_file *nf, *tmp;
-
-	list_for_each_entry_safe(nf, tmp, src, nf_lru) {
-		if (nf->nf_net == net)
-			list_move_tail(&nf->nf_lru, dst);
-	}
-}
-
+/**
+ * nfsd_file_dispose_list_delayed - move list of dead files to net's freeme list
+ * @dispose: list of nfsd_files to be disposed
+ *
+ * Transfers each file to the "freeme" list for its nfsd_net, to eventually
+ * be disposed of by the per-net garbage collector.
+ */
 static void
 nfsd_file_dispose_list_delayed(struct list_head *dispose)
 {
-	LIST_HEAD(list);
-	struct nfsd_file *nf;
-
 	while(!list_empty(dispose)) {
-		nf = list_first_entry(dispose, struct nfsd_file, nf_lru);
-		nfsd_file_list_add_pernet(&list, dispose, nf->nf_net);
-		nfsd_file_list_add_disposal(&list, nf->nf_net);
+		struct nfsd_file *nf = list_first_entry(dispose,
+						struct nfsd_file, nf_lru);
+		struct nfsd_net *nn = net_generic(nf->nf_net, nfsd_net_id);
+		struct nfsd_fcache_disposal *l = nn->fcache_disposal;
+
+		spin_lock(&l->lock);
+		list_move_tail(&nf->nf_lru, &l->freeme);
+		spin_unlock(&l->lock);
+		queue_work(nfsd_filecache_wq, &l->work);
 	}
 }
 
@@ -664,8 +641,8 @@ nfsd_file_close_inode_sync(struct inode *inode)
  * nfsd_file_delayed_close - close unused nfsd_files
  * @work: dummy
  *
- * Walk the LRU list and destroy any entries that have not been used since
- * the last scan.
+ * Scrape the freeme list for this nfsd_net, and then dispose of them
+ * all.
  */
 static void
 nfsd_file_delayed_close(struct work_struct *work)
@@ -674,7 +651,10 @@ nfsd_file_delayed_close(struct work_struct *work)
 	struct nfsd_fcache_disposal *l = container_of(work,
 			struct nfsd_fcache_disposal, work);
 
-	nfsd_file_list_remove_disposal(&head, l);
+	spin_lock(&l->lock);
+	list_splice_init(&l->freeme, &head);
+	spin_unlock(&l->lock);
+
 	nfsd_file_dispose_list(&head);
 }
 
-- 
2.43.0




