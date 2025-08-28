Return-Path: <stable+bounces-176643-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E287EB3A835
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 19:35:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8FBB188CD98
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 17:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4170321446;
	Thu, 28 Aug 2025 17:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AY2iFRQn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935B1338F32
	for <stable@vger.kernel.org>; Thu, 28 Aug 2025 17:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756402520; cv=none; b=EuoO2Ra4b7ecwEG9RdubPm3ThW6Ads+r6u3R4r4aDKf8OR3Ec1mOujeRA2WY/5TWlzqWsjshiV0t+WcKPjY6ffXHy1nSl3w59sFz5t7lVJ5oJ1M3z+xgG+ZkSD6yA9OD6Q3jD91TpHFwTyHf3mKbErqijC8BAsYmEZg4hiwHHPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756402520; c=relaxed/simple;
	bh=BdoZc9kKtyEuyEqAwwDZoL7JL2x0uvxSL/6cbrjYj94=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qp6p9RZ+0M9bRni8o27tXkJDmvxIGDpRy1ZpCgCXMAVaIeji352QyGRKWb6gKjvmOpur4g6YRfUET8jNVHsMpkOcNfW25KTNMQ9eYRU85piB+XLn2+5M5MEQ6PFTPCOmser6VPdJU11rpoOjRBpdJYmtQEnOchVRFH9njIWzB4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AY2iFRQn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00044C4CEED;
	Thu, 28 Aug 2025 17:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756402520;
	bh=BdoZc9kKtyEuyEqAwwDZoL7JL2x0uvxSL/6cbrjYj94=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=AY2iFRQnateIYpiD42fc8X3xuMwYULs7ZL+nsh9TnS3yIgg+YPeQSoL+hAqD0x7dV
	 stpIKkR5bk6ZAmP2aNQg6+6IjvTNDPS4ZMN7tOG2TjEV2rdiG5/QcmkFX/eftfso2L
	 dTqNjQiOwNyPjHezeKkdVEED7XzCsvubXMNWtrRZhdbd6pRGyvKAhZO+/NF2AvHXuB
	 hyspj33+mxpLib06Tl59E8+rPoivd7BEDDIXVtm66V5Xxbep84O++RME1luwElGER3
	 K860HtZ3SrUgb9XraKfLk9TRiNAy7Szd8jr+qwFbfQtvKqBSx+iXGG0Jm8MKzruntv
	 +UvusJPJwSQKQ==
From: Trond Myklebust <trondmy@kernel.org>
To: stable@vger.kernel.org
Subject: [PATCH 5.15.y 2/2] NFS: Fix a race when updating an existing write
Date: Thu, 28 Aug 2025 10:35:17 -0700
Message-ID: <326931e7438b6519a3e08b28448dad1f38770ff2.1756402339.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1756402339.git.trond.myklebust@hammerspace.com>
References: <2025082225-cling-drainer-d884@gregkh> <cover.1756402339.git.trond.myklebust@hammerspace.com>
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
 fs/nfs/pagelist.c        |  9 +++---
 fs/nfs/write.c           | 66 ++++++++++++++--------------------------
 include/linux/nfs_page.h |  1 +
 3 files changed, 29 insertions(+), 47 deletions(-)

diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
index 73817063791a..d6b18100a4cf 100644
--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -234,13 +234,14 @@ nfs_page_group_unlock(struct nfs_page *req)
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
index 6500aeb959f9..9323631f4889 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -155,20 +155,10 @@ nfs_page_set_inode_ref(struct nfs_page *req, struct inode *inode)
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
 
 static struct nfs_page *
@@ -240,36 +230,6 @@ static struct nfs_page *nfs_page_find_head_request(struct page *page)
 	return req;
 }
 
-static struct nfs_page *nfs_find_and_lock_page_request(struct page *page)
-{
-	struct inode *inode = page_file_mapping(page)->host;
-	struct nfs_page *req, *head;
-	int ret;
-
-	for (;;) {
-		req = nfs_page_find_head_request(page);
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
-		if (head == nfs_page_private_request(page))
-			break;
-		if (PageSwapCache(page))
-			break;
-		nfs_unlock_and_release_request(head);
-	}
-	return head;
-}
-
 /* Adjust the file length if we're writing beyond the end */
 static void nfs_grow_file(struct page *page, unsigned int offset, unsigned int count)
 {
@@ -626,14 +586,32 @@ nfs_lock_and_join_requests(struct page *page)
 	 * reference to the whole page group - the group will not be destroyed
 	 * until the head reference is released.
 	 */
-	head = nfs_find_and_lock_page_request(page);
+retry:
+	head = nfs_page_find_head_request(page);
 	if (IS_ERR_OR_NULL(head))
 		return head;
 
+	while (!nfs_lock_request(head)) {
+		ret = nfs_wait_on_request(head);
+		if (ret < 0) {
+			nfs_release_request(head);
+			return ERR_PTR(ret);
+		}
+	}
+
 	ret = nfs_page_group_lock(head);
 	if (ret < 0)
 		goto out_unlock;
 
+	/* Ensure that nobody removed the request before we locked it */
+	if (head != nfs_page_private_request(page) && !PageSwapCache(page)) {
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
@@ -843,7 +821,8 @@ static void nfs_inode_remove_request(struct nfs_page *req)
 	struct nfs_inode *nfsi = NFS_I(inode);
 	struct nfs_page *head;
 
-	if (nfs_page_group_sync_on_bit(req, PG_REMOVE)) {
+	nfs_page_group_lock(req);
+	if (nfs_page_group_sync_on_bit_locked(req, PG_REMOVE)) {
 		head = req->wb_head;
 
 		spin_lock(&mapping->private_lock);
@@ -854,6 +833,7 @@ static void nfs_inode_remove_request(struct nfs_page *req)
 		}
 		spin_unlock(&mapping->private_lock);
 	}
+	nfs_page_group_unlock(req);
 
 	if (test_and_clear_bit(PG_INODE_REF, &req->wb_flags)) {
 		nfs_release_request(req);
diff --git a/include/linux/nfs_page.h b/include/linux/nfs_page.h
index 7c5e704a7520..137b790ea1a4 100644
--- a/include/linux/nfs_page.h
+++ b/include/linux/nfs_page.h
@@ -150,6 +150,7 @@ extern void nfs_join_page_group(struct nfs_page *head,
 extern int nfs_page_group_lock(struct nfs_page *);
 extern void nfs_page_group_unlock(struct nfs_page *);
 extern bool nfs_page_group_sync_on_bit(struct nfs_page *, unsigned int);
+extern bool nfs_page_group_sync_on_bit_locked(struct nfs_page *, unsigned int);
 extern	int nfs_page_set_headlock(struct nfs_page *req);
 extern void nfs_page_clear_headlock(struct nfs_page *req);
 extern bool nfs_async_iocounter_wait(struct rpc_task *, struct nfs_lock_context *);
-- 
2.51.0


