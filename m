Return-Path: <stable+bounces-176641-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB9FB3A833
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 19:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72BF81783F8
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 17:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF0E337681;
	Thu, 28 Aug 2025 17:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T1vUWP6c"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7D22C11C3
	for <stable@vger.kernel.org>; Thu, 28 Aug 2025 17:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756402520; cv=none; b=um+72kGibWmYEn21mbQh3ZpRZHrJesbKvBzoE/1srqAqDlBRVzuzW42rMcCBttasfZckwHLr0RZufSRybyJq4EoulY17VpQA+J8ScpS4YMssZNDHrC8SbXVyy7sgsJJZTXS0Q4JdRZUdnwIYsKtSd39Y5mubzoQsNAc4d0ilImE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756402520; c=relaxed/simple;
	bh=luuabEwYXaA1Jeo9RVbYGTSJ/Hig5nO6Pi47tTZPDgc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LpiPa+g1LX9XH+UEyZWcpNveX7KQ1soTF3KyFNWx7M5wmfNNSYvpDkHHMBYaCTFDdnV4RclIujx5swzIIi9PoYTyg5Yzl1qFkIRbK3AM6OEyrmbvkYGikOLb5fgjE2H2GEGYBuP842djk0cgcdqGgGA9lkolrpor6KDh/qPdSEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T1vUWP6c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86C7BC4CEF5;
	Thu, 28 Aug 2025 17:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756402519;
	bh=luuabEwYXaA1Jeo9RVbYGTSJ/Hig5nO6Pi47tTZPDgc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=T1vUWP6cgmHY04yTPj5mHH8vgt3RcbBf+CxL81tTO+KfnzCDeo1kXG88ATiuO/nC9
	 gJbeHK0HQ6KeTn/l5sXQFoUwm2cruNRJGtNFUraXFBp5EcMZMjAbyPwLQpBhVqsMIL
	 58J2KO8N8wQO4xwESS0w97w0fr4fheZVCPWYoB6nu6MbMrKqgJK7W/PqN1L4XSYATU
	 1RuWB6q0KcP0p+Ncpbex19NvHMrPvLkQVpsPHAyl0BeILAGx5vok6ZU3JbHatqLYHm
	 Q1dUmdI2LBCIQ9j/5kfatwQNdqo2AAqUK4t97WPoAR62vTO9cegMOjFc/ea8VlJYIB
	 SViyNa/3EMLCA==
From: Trond Myklebust <trondmy@kernel.org>
To: stable@vger.kernel.org
Subject: [PATCH 5.15.y 1/2] nfs: fold nfs_page_group_lock_subrequests into nfs_lock_and_join_requests
Date: Thu, 28 Aug 2025 10:35:16 -0700
Message-ID: <aab653aafa9b43704671370c110c2f80326f638b.1756402339.git.trond.myklebust@hammerspace.com>
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

From: Christoph Hellwig <hch@lst.de>

Fold nfs_page_group_lock_subrequests into nfs_lock_and_join_requests to
prepare for future changes to this code, and move the helpers to write.c
as well.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
(cherry picked from commit 25edbcac6e32eab345e470d56ca9974a577b878b)
---
 fs/nfs/pagelist.c        | 77 ----------------------------------------
 fs/nfs/write.c           | 74 ++++++++++++++++++++++++++++++++++----
 include/linux/nfs_page.h |  1 -
 3 files changed, 68 insertions(+), 84 deletions(-)

diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
index fdecf729fa92..73817063791a 100644
--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -167,83 +167,6 @@ nfs_page_group_lock_head(struct nfs_page *req)
 	return head;
 }
 
-/*
- * nfs_unroll_locks -  unlock all newly locked reqs and wait on @req
- * @head: head request of page group, must be holding head lock
- * @req: request that couldn't lock and needs to wait on the req bit lock
- *
- * This is a helper function for nfs_lock_and_join_requests
- * returns 0 on success, < 0 on error.
- */
-static void
-nfs_unroll_locks(struct nfs_page *head, struct nfs_page *req)
-{
-	struct nfs_page *tmp;
-
-	/* relinquish all the locks successfully grabbed this run */
-	for (tmp = head->wb_this_page ; tmp != req; tmp = tmp->wb_this_page) {
-		if (!kref_read(&tmp->wb_kref))
-			continue;
-		nfs_unlock_and_release_request(tmp);
-	}
-}
-
-/*
- * nfs_page_group_lock_subreq -  try to lock a subrequest
- * @head: head request of page group
- * @subreq: request to lock
- *
- * This is a helper function for nfs_lock_and_join_requests which
- * must be called with the head request and page group both locked.
- * On error, it returns with the page group unlocked.
- */
-static int
-nfs_page_group_lock_subreq(struct nfs_page *head, struct nfs_page *subreq)
-{
-	int ret;
-
-	if (!kref_get_unless_zero(&subreq->wb_kref))
-		return 0;
-	while (!nfs_lock_request(subreq)) {
-		nfs_page_group_unlock(head);
-		ret = nfs_wait_on_request(subreq);
-		if (!ret)
-			ret = nfs_page_group_lock(head);
-		if (ret < 0) {
-			nfs_unroll_locks(head, subreq);
-			nfs_release_request(subreq);
-			return ret;
-		}
-	}
-	return 0;
-}
-
-/*
- * nfs_page_group_lock_subrequests -  try to lock the subrequests
- * @head: head request of page group
- *
- * This is a helper function for nfs_lock_and_join_requests which
- * must be called with the head request locked.
- */
-int nfs_page_group_lock_subrequests(struct nfs_page *head)
-{
-	struct nfs_page *subreq;
-	int ret;
-
-	ret = nfs_page_group_lock(head);
-	if (ret < 0)
-		return ret;
-	/* lock each request in the page group */
-	for (subreq = head->wb_this_page; subreq != head;
-			subreq = subreq->wb_this_page) {
-		ret = nfs_page_group_lock_subreq(head, subreq);
-		if (ret < 0)
-			return ret;
-	}
-	nfs_page_group_unlock(head);
-	return 0;
-}
-
 /*
  * nfs_page_set_headlock - set the request PG_HEADLOCK
  * @req: request that is to be locked
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index bb401d37fe26..6500aeb959f9 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -546,6 +546,57 @@ void nfs_join_page_group(struct nfs_page *head, struct nfs_commit_info *cinfo,
 	nfs_destroy_unlinked_subrequests(destroy_list, head, inode);
 }
 
+/*
+ * nfs_unroll_locks -  unlock all newly locked reqs and wait on @req
+ * @head: head request of page group, must be holding head lock
+ * @req: request that couldn't lock and needs to wait on the req bit lock
+ *
+ * This is a helper function for nfs_lock_and_join_requests
+ * returns 0 on success, < 0 on error.
+ */
+static void
+nfs_unroll_locks(struct nfs_page *head, struct nfs_page *req)
+{
+	struct nfs_page *tmp;
+
+	/* relinquish all the locks successfully grabbed this run */
+	for (tmp = head->wb_this_page ; tmp != req; tmp = tmp->wb_this_page) {
+		if (!kref_read(&tmp->wb_kref))
+			continue;
+		nfs_unlock_and_release_request(tmp);
+	}
+}
+
+/*
+ * nfs_page_group_lock_subreq -  try to lock a subrequest
+ * @head: head request of page group
+ * @subreq: request to lock
+ *
+ * This is a helper function for nfs_lock_and_join_requests which
+ * must be called with the head request and page group both locked.
+ * On error, it returns with the page group unlocked.
+ */
+static int
+nfs_page_group_lock_subreq(struct nfs_page *head, struct nfs_page *subreq)
+{
+	int ret;
+
+	if (!kref_get_unless_zero(&subreq->wb_kref))
+		return 0;
+	while (!nfs_lock_request(subreq)) {
+		nfs_page_group_unlock(head);
+		ret = nfs_wait_on_request(subreq);
+		if (!ret)
+			ret = nfs_page_group_lock(head);
+		if (ret < 0) {
+			nfs_unroll_locks(head, subreq);
+			nfs_release_request(subreq);
+			return ret;
+		}
+	}
+	return 0;
+}
+
 /*
  * nfs_lock_and_join_requests - join all subreqs to the head req
  * @page: the page used to lookup the "page group" of nfs_page structures
@@ -565,7 +616,7 @@ static struct nfs_page *
 nfs_lock_and_join_requests(struct page *page)
 {
 	struct inode *inode = page_file_mapping(page)->host;
-	struct nfs_page *head;
+	struct nfs_page *head, *subreq;
 	struct nfs_commit_info cinfo;
 	int ret;
 
@@ -579,16 +630,27 @@ nfs_lock_and_join_requests(struct page *page)
 	if (IS_ERR_OR_NULL(head))
 		return head;
 
+	ret = nfs_page_group_lock(head);
+	if (ret < 0)
+		goto out_unlock;
+
 	/* lock each request in the page group */
-	ret = nfs_page_group_lock_subrequests(head);
-	if (ret < 0) {
-		nfs_unlock_and_release_request(head);
-		return ERR_PTR(ret);
+	for (subreq = head->wb_this_page;
+	     subreq != head;
+	     subreq = subreq->wb_this_page) {
+		ret = nfs_page_group_lock_subreq(head, subreq);
+		if (ret < 0)
+			goto out_unlock;
 	}
 
-	nfs_join_page_group(head, &cinfo, inode);
+	nfs_page_group_unlock(head);
 
+	nfs_join_page_group(head, &cinfo, inode);
 	return head;
+
+out_unlock:
+	nfs_unlock_and_release_request(head);
+	return ERR_PTR(ret);
 }
 
 static void nfs_write_error(struct nfs_page *req, int error)
diff --git a/include/linux/nfs_page.h b/include/linux/nfs_page.h
index 40aa09a21f75..7c5e704a7520 100644
--- a/include/linux/nfs_page.h
+++ b/include/linux/nfs_page.h
@@ -144,7 +144,6 @@ extern  int nfs_wait_on_request(struct nfs_page *);
 extern	void nfs_unlock_request(struct nfs_page *req);
 extern	void nfs_unlock_and_release_request(struct nfs_page *);
 extern	struct nfs_page *nfs_page_group_lock_head(struct nfs_page *req);
-extern	int nfs_page_group_lock_subrequests(struct nfs_page *head);
 extern void nfs_join_page_group(struct nfs_page *head,
 				struct nfs_commit_info *cinfo,
 				struct inode *inode);
-- 
2.51.0


