Return-Path: <stable+bounces-176505-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8D9B38443
	for <lists+stable@lfdr.de>; Wed, 27 Aug 2025 16:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49BB25E4EF6
	for <lists+stable@lfdr.de>; Wed, 27 Aug 2025 14:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C5435A290;
	Wed, 27 Aug 2025 14:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EVF+8DB8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9795F35A283
	for <stable@vger.kernel.org>; Wed, 27 Aug 2025 14:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756303204; cv=none; b=WKi5nPwMOrPw8oJhTXiCM9KSsCGS7nJQ4ix6ebTM0jiDbfxn8HDxeBQcfbJHesgsEiple/Lz+WXWMIrz+yaSN0frwFjCyYPg1GYwwooKV8iDLjMq/5VmMvoB7HWdBnp0SvKz/PE/Rpbj5nCbRKMQsgmh5OXoWE5KlXIHJdJLRKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756303204; c=relaxed/simple;
	bh=0FJR0RV5hpJPIg6ZH/g95PAvdxfP4f+u9vCZTetj9Ok=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R9xSILYT6BcgWQEytdO+SFU6gdR4NLlmJK000f0pDrwPGlNBxPfbisYlJsrz/uWI5VGgaYCLpv/AUbZsld/b4qnuYwSz2b0vdrK2vAFVqc1D5wnJe1XviNQHxyXg1TZih2PgJOCUY5Nh8IiP8kVT/n2nl/fSke0jaZOrd51prc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EVF+8DB8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F1E5C4CEEB
	for <stable@vger.kernel.org>; Wed, 27 Aug 2025 14:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756303204;
	bh=0FJR0RV5hpJPIg6ZH/g95PAvdxfP4f+u9vCZTetj9Ok=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=EVF+8DB8jzBNjkBEKBc1MK5i4CSFw13MoQuZbWnCVb3/1hdRtLDd+nQznCzAC4/Tg
	 /eeFH1oAyxp3JLtHRJV4GP8ZomrrikHZpo7fFYbtqd+tNNCGB7B5IC8yvhzINm7b7e
	 ih8uiPg6lNv05o4BKISaxLyVEO0RNCuH15r9wxi8+UAeCuJSIALxGoJXWjniUMndWB
	 f1ZU6/1M14MNVZaJYWFTqx924Ckvy+cGYpoTxGoISdX17LTSeGQTNKPqMqoLY9cUi8
	 AoFcYsf+prjq7/NIZIKlA8chEhBt6VHmZ+uAdSjr6ofpLxOtk/uw3WU8OhRjmBztmW
	 yd0sf5oBs9ANg==
From: Trond Myklebust <trondmy@kernel.org>
To: stable@vger.kernel.org
Subject: [PATCH 6.6.y 2/2] NFS: Fix a race when updating an existing write
Date: Wed, 27 Aug 2025 07:00:01 -0700
Message-ID: <f8903f2f89b3108903a9877192477a34c046bb62.1756303039.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025082224-submersed-commend-be4c@gregkh>
References: <2025082224-submersed-commend-be4c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

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
(cherry picked from commit 76d2e3890fb169168c73f2e4f8375c7cc24a765e)
---
 fs/nfs/pagelist.c        |  9 ++---
 fs/nfs/write.c           | 71 ++++++++++++++--------------------------
 include/linux/nfs_page.h |  1 +
 3 files changed, 31 insertions(+), 50 deletions(-)

diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
index 30e2488eb84c..0ea3916ed1dc 100644
--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -272,13 +272,14 @@ nfs_page_group_unlock(struct nfs_page *req)
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
index 289ff8e9f78a..cb1e9996fcc8 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -156,20 +156,10 @@ nfs_page_set_inode_ref(struct nfs_page *req, struct inode *inode)
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
 
 static struct nfs_page *nfs_folio_private_request(struct folio *folio)
@@ -238,36 +228,6 @@ static struct nfs_page *nfs_folio_find_head_request(struct folio *folio)
 	return req;
 }
 
-static struct nfs_page *nfs_folio_find_and_lock_request(struct folio *folio)
-{
-	struct inode *inode = folio_file_mapping(folio)->host;
-	struct nfs_page *req, *head;
-	int ret;
-
-	for (;;) {
-		req = nfs_folio_find_head_request(folio);
-		if (!req)
-			return req;
-		head = nfs_page_group_lock_head(req);
-		if (head != req)
-			nfs_release_request(req);
-		if (IS_ERR(head))
-			return head;
-		ret = nfs_cancel_remove_inode(head, inode);
-		if (ret < 0) {
-			nfs_unlock_and_release_request(head);
-			return ERR_PTR(ret);
-		}
-		/* Ensure that nobody removed the request before we locked it */
-		if (head == nfs_folio_private_request(folio))
-			break;
-		if (folio_test_swapcache(folio))
-			break;
-		nfs_unlock_and_release_request(head);
-	}
-	return head;
-}
-
 /* Adjust the file length if we're writing beyond the end */
 static void nfs_grow_file(struct folio *folio, unsigned int offset,
 			  unsigned int count)
@@ -621,20 +581,37 @@ static struct nfs_page *nfs_lock_and_join_requests(struct folio *folio)
 	struct nfs_commit_info cinfo;
 	int ret;
 
-	nfs_init_cinfo_from_inode(&cinfo, inode);
 	/*
 	 * A reference is taken only on the head request which acts as a
 	 * reference to the whole page group - the group will not be destroyed
 	 * until the head reference is released.
 	 */
-	head = nfs_folio_find_and_lock_request(folio);
-	if (IS_ERR_OR_NULL(head))
-		return head;
+retry:
+	head = nfs_folio_find_head_request(folio);
+	if (!head)
+		return NULL;
+
+	while (!nfs_lock_request(head)) {
+		ret = nfs_wait_on_request(head);
+		if (ret < 0) {
+			nfs_release_request(head);
+			return ERR_PTR(ret);
+		}
+	}
 
 	ret = nfs_page_group_lock(head);
 	if (ret < 0)
 		goto out_unlock;
 
+	/* Ensure that nobody removed the request before we locked it */
+	if (head != folio->private && !folio_test_swapcache(folio)) {
+		nfs_page_group_unlock(head);
+		nfs_unlock_and_release_request(head);
+		goto retry;
+	}
+
+	nfs_cancel_remove_inode(head, inode);
+
 	/* lock each request in the page group */
 	for (subreq = head->wb_this_page;
 	     subreq != head;
@@ -855,7 +832,8 @@ static void nfs_inode_remove_request(struct nfs_page *req)
 {
 	struct nfs_inode *nfsi = NFS_I(nfs_page_to_inode(req));
 
-	if (nfs_page_group_sync_on_bit(req, PG_REMOVE)) {
+	nfs_page_group_lock(req);
+	if (nfs_page_group_sync_on_bit_locked(req, PG_REMOVE)) {
 		struct folio *folio = nfs_page_to_folio(req->wb_head);
 		struct address_space *mapping = folio_file_mapping(folio);
 
@@ -867,6 +845,7 @@ static void nfs_inode_remove_request(struct nfs_page *req)
 		}
 		spin_unlock(&mapping->private_lock);
 	}
+	nfs_page_group_unlock(req);
 
 	if (test_and_clear_bit(PG_INODE_REF, &req->wb_flags)) {
 		atomic_long_dec(&nfsi->nrequests);
diff --git a/include/linux/nfs_page.h b/include/linux/nfs_page.h
index 3a0f7ebe5388..6a46069c5a36 100644
--- a/include/linux/nfs_page.h
+++ b/include/linux/nfs_page.h
@@ -162,6 +162,7 @@ extern void nfs_join_page_group(struct nfs_page *head,
 extern int nfs_page_group_lock(struct nfs_page *);
 extern void nfs_page_group_unlock(struct nfs_page *);
 extern bool nfs_page_group_sync_on_bit(struct nfs_page *, unsigned int);
+extern bool nfs_page_group_sync_on_bit_locked(struct nfs_page *, unsigned int);
 extern	int nfs_page_set_headlock(struct nfs_page *req);
 extern void nfs_page_clear_headlock(struct nfs_page *req);
 extern bool nfs_async_iocounter_wait(struct rpc_task *, struct nfs_lock_context *);
-- 
2.51.0


