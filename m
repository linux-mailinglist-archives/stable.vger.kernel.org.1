Return-Path: <stable+bounces-176507-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC714B38450
	for <lists+stable@lfdr.de>; Wed, 27 Aug 2025 16:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 362C15E7A14
	for <lists+stable@lfdr.de>; Wed, 27 Aug 2025 14:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC3C3570BA;
	Wed, 27 Aug 2025 14:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q11yeoIF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D12350D41
	for <stable@vger.kernel.org>; Wed, 27 Aug 2025 14:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756303339; cv=none; b=bJg1VOs0MT4Dm7kMeJqVf11RWGDOenKQRSvKaHiVYiYsTkQwY2qQakaQ7gLBtQpiA5qsUNvVplojvvwyugV5UnsNnmIbD/5DXTmgOjqnqCeh6/Dg2mMLuIpUvEvvzmoTaUC7uyiSHv4mTl4n87JTDCr8kg8mJS1WDUwYuPvVuMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756303339; c=relaxed/simple;
	bh=tRhj8FjRaseYSxtlAtbcBMoQDkGnzQgvHzbZPS935oE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c1Udvy1kGkexqtt9YUQa8WlMWcsm2oY3qb/M6I0+KQO/v+EAZ8KyXOqb+mi5QaYmwMKgkWuNFNXPuEGH63SzZS2Ogwh5dMZeqoTbbnsyqaSW8/pFkPWL66Orcm/lnitY/C2fR2NOmvBOpInXeLzXFeaKDV3J+tD5yiziIbFNDek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q11yeoIF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59997C4CEF0
	for <stable@vger.kernel.org>; Wed, 27 Aug 2025 14:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756303338;
	bh=tRhj8FjRaseYSxtlAtbcBMoQDkGnzQgvHzbZPS935oE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=q11yeoIFMlpQGGySQLVxIXI+JJt2TzgQmsvNTmypjJFX2SthaobO9+I6g25I6XwBF
	 phvtNoOi5e3vb+4RVHXPmaNEsiSzGrKfjbM44n9ju5AMHu3guKr8VGKAiyuF3BjBub
	 ziaJOVxU6tb14ldm500nNf5urBBBSPqN2oSJpE3H+xLmJ3xPHeu6m4CM4Mc57rwfTk
	 48gO0xXaRo2g/DlFjeuJQaV75YKCs5bToMhqREl+Rq0y8iD1VeHP7Trdq5y0fgEeSb
	 us/SKoZokMKDmtZX061qmuxaxdM8KRODlNSXnFDrVXVtSP/0OFud4x8jH8IlyxS/RX
	 TkcSnI8ESOkDQ==
From: Trond Myklebust <trondmy@kernel.org>
To: stable@vger.kernel.org
Subject: [PATCH 6.1.y 1/2] nfs: fold nfs_page_group_lock_subrequests into nfs_lock_and_join_requests
Date: Wed, 27 Aug 2025 07:02:15 -0700
Message-ID: <5dc3ac62337072587f77cb7d5a66a527b258576d.1756303256.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025082224-payment-unworthy-d165@gregkh>
References: <2025082224-payment-unworthy-d165@gregkh>
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
index 317cedfa52bf..99e756139a5d 100644
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
index 8e21caae4cae..eaf712d9d905 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -547,6 +547,57 @@ nfs_join_page_group(struct nfs_page *head, struct inode *inode)
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
@@ -566,7 +617,7 @@ static struct nfs_page *
 nfs_lock_and_join_requests(struct page *page)
 {
 	struct inode *inode = page_file_mapping(page)->host;
-	struct nfs_page *head;
+	struct nfs_page *head, *subreq;
 	int ret;
 
 	/*
@@ -578,16 +629,27 @@ nfs_lock_and_join_requests(struct page *page)
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
 
-	nfs_join_page_group(head, inode);
+	nfs_page_group_unlock(head);
 
+	nfs_join_page_group(head, inode);
 	return head;
+
+out_unlock:
+	nfs_unlock_and_release_request(head);
+	return ERR_PTR(ret);
 }
 
 static void nfs_write_error(struct nfs_page *req, int error)
diff --git a/include/linux/nfs_page.h b/include/linux/nfs_page.h
index ba7e2e4b0926..d7a08d18a6c5 100644
--- a/include/linux/nfs_page.h
+++ b/include/linux/nfs_page.h
@@ -144,7 +144,6 @@ extern  int nfs_wait_on_request(struct nfs_page *);
 extern	void nfs_unlock_request(struct nfs_page *req);
 extern	void nfs_unlock_and_release_request(struct nfs_page *);
 extern	struct nfs_page *nfs_page_group_lock_head(struct nfs_page *req);
-extern	int nfs_page_group_lock_subrequests(struct nfs_page *head);
 extern	void nfs_join_page_group(struct nfs_page *head, struct inode *inode);
 extern int nfs_page_group_lock(struct nfs_page *);
 extern void nfs_page_group_unlock(struct nfs_page *);
-- 
2.51.0


