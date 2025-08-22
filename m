Return-Path: <stable+bounces-172439-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AAAADB31CA5
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 16:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FED51D22432
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 14:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAFB33126BE;
	Fri, 22 Aug 2025 14:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="si1iyxnd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6C23126AB
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 14:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755873824; cv=none; b=u0ptabP99lOYA3jwd/rREtXdvjyh/IU5RYwF8+7U4cEsMAO83fmoqGLBWTnb/7tXZ5lipeeRQC5YBuf6pa/zzYVn9yPZ+n03b/kNDGJY8vzTPApJz1beWQpoKShisZDZV1Mgymbrtk0ftPE26eIHqIWsNJEhmsLqkXbkDhYTnqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755873824; c=relaxed/simple;
	bh=56R/ndJLH7iLfZ45rJTa8Ge/JJfTv+Hq5gjod9+/7zE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=EcXNTApnA5aTqcG1uvtcS9S0y2Nclv36d+rycltlvbGxNELGg0TtKpsjmxz5qFKMtjKFxpEhnbrKxKvhyNwF88vogWJ7Uki7j9Q/tO3hcAXOqOagKfvtQ6OIeyN+GczK4S35U0rMqXgHljgtaNlUBKdbYVnPmqjHYv2lFQez1d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=si1iyxnd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E239C4CEED;
	Fri, 22 Aug 2025 14:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755873823;
	bh=56R/ndJLH7iLfZ45rJTa8Ge/JJfTv+Hq5gjod9+/7zE=;
	h=Subject:To:Cc:From:Date:From;
	b=si1iyxndZDAOl0goi0X/JIxX56/5V2g3GyTbuOb3MbOM1WJdKeeL8HuK1f7JxkpoK
	 Sdr4Imy8SykPolzjI27pY9AD8JgOjyl6Zx4bOE/2DP+w9hjIGPm+x31nLtnTcnQFfq
	 2InbNWDZc6BTKIAxx1uSs0QA3VAs5E+qyLrNzJes=
Subject: FAILED: patch "[PATCH] NFS: Fix a race when updating an existing write" failed to apply to 5.15-stable tree
To: trond.myklebust@hammerspace.com,aksteffen@meta.com,jdq@meta.com,jlayton@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 22 Aug 2025 16:43:25 +0200
Message-ID: <2025082225-cling-drainer-d884@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 76d2e3890fb169168c73f2e4f8375c7cc24a765e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025082225-cling-drainer-d884@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 76d2e3890fb169168c73f2e4f8375c7cc24a765e Mon Sep 17 00:00:00 2001
From: Trond Myklebust <trond.myklebust@hammerspace.com>
Date: Sat, 16 Aug 2025 07:25:20 -0700
Subject: [PATCH] NFS: Fix a race when updating an existing write

After nfs_lock_and_join_requests() tests for whether the request is
still attached to the mapping, nothing prevents a call to
nfs_inode_remove_request() from succeeding until we actually lock the
page group.
The reason is that whoever called nfs_inode_remove_request() doesn't
necessarily have a lock on the page group head.

So in order to avoid races, let's take the page group lock earlier in
nfs_lock_and_join_requests(), and hold it across the removal of the
request in nfs_inode_remove_request().

Reported-by: Jeff Layton <jlayton@kernel.org>
Tested-by: Joe Quanaim <jdq@meta.com>
Tested-by: Andrew Steffen <aksteffen@meta.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Fixes: bd37d6fce184 ("NFSv4: Convert nfs_lock_and_join_requests() to use nfs_page_find_head_request()")
Cc: stable@vger.kernel.org
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>

diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
index 11968dcb7243..6e69ce43a13f 100644
--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -253,13 +253,14 @@ nfs_page_group_unlock(struct nfs_page *req)
 	nfs_page_clear_headlock(req);
 }
 
-/*
- * nfs_page_group_sync_on_bit_locked
+/**
+ * nfs_page_group_sync_on_bit_locked - Test if all requests have @bit set
+ * @req: request in page group
+ * @bit: PG_* bit that is used to sync page group
  *
  * must be called with page group lock held
  */
-static bool
-nfs_page_group_sync_on_bit_locked(struct nfs_page *req, unsigned int bit)
+bool nfs_page_group_sync_on_bit_locked(struct nfs_page *req, unsigned int bit)
 {
 	struct nfs_page *head = req->wb_head;
 	struct nfs_page *tmp;
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index fa5c41d0989a..8b7c04737967 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -153,20 +153,10 @@ nfs_page_set_inode_ref(struct nfs_page *req, struct inode *inode)
 	}
 }
 
-static int
-nfs_cancel_remove_inode(struct nfs_page *req, struct inode *inode)
+static void nfs_cancel_remove_inode(struct nfs_page *req, struct inode *inode)
 {
-	int ret;
-
-	if (!test_bit(PG_REMOVE, &req->wb_flags))
-		return 0;
-	ret = nfs_page_group_lock(req);
-	if (ret)
-		return ret;
 	if (test_and_clear_bit(PG_REMOVE, &req->wb_flags))
 		nfs_page_set_inode_ref(req, inode);
-	nfs_page_group_unlock(req);
-	return 0;
 }
 
 /**
@@ -585,19 +575,18 @@ retry:
 		}
 	}
 
+	ret = nfs_page_group_lock(head);
+	if (ret < 0)
+		goto out_unlock;
+
 	/* Ensure that nobody removed the request before we locked it */
 	if (head != folio->private) {
+		nfs_page_group_unlock(head);
 		nfs_unlock_and_release_request(head);
 		goto retry;
 	}
 
-	ret = nfs_cancel_remove_inode(head, inode);
-	if (ret < 0)
-		goto out_unlock;
-
-	ret = nfs_page_group_lock(head);
-	if (ret < 0)
-		goto out_unlock;
+	nfs_cancel_remove_inode(head, inode);
 
 	/* lock each request in the page group */
 	for (subreq = head->wb_this_page;
@@ -786,7 +775,8 @@ static void nfs_inode_remove_request(struct nfs_page *req)
 {
 	struct nfs_inode *nfsi = NFS_I(nfs_page_to_inode(req));
 
-	if (nfs_page_group_sync_on_bit(req, PG_REMOVE)) {
+	nfs_page_group_lock(req);
+	if (nfs_page_group_sync_on_bit_locked(req, PG_REMOVE)) {
 		struct folio *folio = nfs_page_to_folio(req->wb_head);
 		struct address_space *mapping = folio->mapping;
 
@@ -798,6 +788,7 @@ static void nfs_inode_remove_request(struct nfs_page *req)
 		}
 		spin_unlock(&mapping->i_private_lock);
 	}
+	nfs_page_group_unlock(req);
 
 	if (test_and_clear_bit(PG_INODE_REF, &req->wb_flags)) {
 		atomic_long_dec(&nfsi->nrequests);
diff --git a/include/linux/nfs_page.h b/include/linux/nfs_page.h
index 169b4ae30ff4..9aed39abc94b 100644
--- a/include/linux/nfs_page.h
+++ b/include/linux/nfs_page.h
@@ -160,6 +160,7 @@ extern void nfs_join_page_group(struct nfs_page *head,
 extern int nfs_page_group_lock(struct nfs_page *);
 extern void nfs_page_group_unlock(struct nfs_page *);
 extern bool nfs_page_group_sync_on_bit(struct nfs_page *, unsigned int);
+extern bool nfs_page_group_sync_on_bit_locked(struct nfs_page *, unsigned int);
 extern	int nfs_page_set_headlock(struct nfs_page *req);
 extern void nfs_page_clear_headlock(struct nfs_page *req);
 extern bool nfs_async_iocounter_wait(struct rpc_task *, struct nfs_lock_context *);


