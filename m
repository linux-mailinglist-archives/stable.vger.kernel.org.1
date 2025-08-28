Return-Path: <stable+bounces-176649-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF531B3A87A
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 19:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1C291893992
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 17:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5FD0322DB3;
	Thu, 28 Aug 2025 17:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GrJnk5uW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845F1340D83
	for <stable@vger.kernel.org>; Thu, 28 Aug 2025 17:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756402920; cv=none; b=IYnyGvipAxQF/1m+bwDgGfht0BZMl1ro/YTKaq4LAD6QIOsqkLuk4HfAnYnlUD10qRHkcsJquHhCB072fZc+4Ii/1V6sylE4u0ZE13b5GDqkcZosl4NcnTu1uweqfHzQWcLRrD/VEFaMO1A31AWzFaHuYEEYeTAZhEO5os5GkD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756402920; c=relaxed/simple;
	bh=0HCe6pe+DPLQodLXLprWPcvX+lqpDmyd3nKKTft9KJA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HQzhsOAIev8oaPEFrpNqIs0Lva5n9k7gqyFQibwezc/eq/Juawg03Omp2qWZt0/rjANhyZ7ci3TBihmF9onasovcKtdX6PlLAx32P4NEsRasaPMD2vZdVyMFkcPzYOavfTMhKZr0FczK+UuQY2IoxBiRI+X7h1RwYDWFzx4g7Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GrJnk5uW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F151DC4CEEB
	for <stable@vger.kernel.org>; Thu, 28 Aug 2025 17:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756402920;
	bh=0HCe6pe+DPLQodLXLprWPcvX+lqpDmyd3nKKTft9KJA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=GrJnk5uWdLiTqe1CxlTI5oNTgiXSt4JOvA6Ll3eu9zMj9LuLfhuWlF5Cqm8+1h2w6
	 0xYjPIuQKF7AjakCUudjKFvNdR7Id85R/aFEafRLNoUwX/CHoWR2pQonSrF3S0wwoy
	 xG3XNa5sz5J6q/Z2fItGzsH2jbeGOf7/lzzcrcju+y4ppSwxDdR/q9RcqJE9WSdFG1
	 +cgEeoI8kEin3JPhKRfrm5IV9VPwgWTotfQ0ivbSKP8MhSNCxDP1LsRPRQHz96wRCT
	 5qBd3WYpVcVPWq660nHt2mhnIPkoXOIvs2Q0ROfaAv5osQD7CGG1oglAGGL9N/gtMq
	 DhAj5KcLbl8bA==
From: Trond Myklebust <trondmy@kernel.org>
To: stable@vger.kernel.org
Subject: [PATCH 5.10.y 2/2] NFS: Fix a race when updating an existing write
Date: Thu, 28 Aug 2025 10:41:58 -0700
Message-ID: <5cadfa963bb3f2719b8e3fce85fcd61f3d9aeeb3.1756402795.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1756402795.git.trond.myklebust@hammerspace.com>
References: <2025082225-attribute-embark-823b@gregkh> <cover.1756402795.git.trond.myklebust@hammerspace.com>
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
index 7ac70f7e83b1..41f755365a61 100644
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
index d0a5dafdac54..0b05a40a21f3 100644
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
@@ -842,7 +820,8 @@ static void nfs_inode_remove_request(struct nfs_page *req)
 	struct nfs_inode *nfsi = NFS_I(inode);
 	struct nfs_page *head;
 
-	if (nfs_page_group_sync_on_bit(req, PG_REMOVE)) {
+	nfs_page_group_lock(req);
+	if (nfs_page_group_sync_on_bit_locked(req, PG_REMOVE)) {
 		head = req->wb_head;
 
 		spin_lock(&mapping->private_lock);
@@ -853,6 +832,7 @@ static void nfs_inode_remove_request(struct nfs_page *req)
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


