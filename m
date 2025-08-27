Return-Path: <stable+bounces-176504-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08314B38442
	for <lists+stable@lfdr.de>; Wed, 27 Aug 2025 16:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C32625E4DFD
	for <lists+stable@lfdr.de>; Wed, 27 Aug 2025 14:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC36235A28E;
	Wed, 27 Aug 2025 14:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rdPJolt3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBD135691D
	for <stable@vger.kernel.org>; Wed, 27 Aug 2025 14:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756303204; cv=none; b=Oxs/BpitoF60zQ9Az4FHqYg+vvPwiLadtixPiLinCbIAp4GTMiNGedwTDUG13MAPZXNdABaoBpG+DdNyy3ai1+NXhCJMoSPexFQaSHbmTSlCMId51JP45pyHNa9sfhsCr6XfJPlW0mA1RaC8d6mgJHjgP0ZneOQ9AVkNQifvlz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756303204; c=relaxed/simple;
	bh=4wKbxr0gBFO/DQr7vKcNPb9Ysmwi22GpAr7iQagO+Fc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FLuM3F5HgIi6W2cuwg+ZDq/pzi8MeTFaUyjdE5Sb36KAiYIyLvg6dbv/OnmyJvUt0Vk3eFwUgE1xt+XaarsP64JsdqR/NEFYZ5xzScP77bpM+RRv93iolpVjQ7aXjskAWvPtJN7/AVlJ4/5eD5zYVi/B0xGuV1OnOUTJYL8CPK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rdPJolt3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4EB9C4CEF0
	for <stable@vger.kernel.org>; Wed, 27 Aug 2025 14:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756303204;
	bh=4wKbxr0gBFO/DQr7vKcNPb9Ysmwi22GpAr7iQagO+Fc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=rdPJolt3FYCok9i0pcWTZ2Ht0bp5iNxQMZZuwATv0A569vNp5W2g/0TRKHPvEcOyZ
	 meq9mB4FUwI7W8pnIOBNmuXS9bGMYG+VRS9MZqdFdQJAuhf47Elkk+keoOzbLCsFxR
	 dVTmFNuD0EGqTJg4KnOYdFtnlPSxUkBMi9Ni3p9hiSQ5Xm2IdZtfbaD3j0I4qraxSl
	 6voHV1kLxQOEAFYUtTN+gUwKCdTHeAq0dRytA3KzqRYb+1YqGTMVLN+tbrO+rfEdIL
	 sX+52uvKSgONRHQ6MuZNSLRAQuFuSe/o5zPLIhLTRyHbZ1Xl+0DkII84QSNFGF9fRS
	 uDSiX5KJxS40g==
From: Trond Myklebust <trondmy@kernel.org>
To: stable@vger.kernel.org
Subject: [PATCH 6.6.y 1/2] nfs: fold nfs_page_group_lock_subrequests into nfs_lock_and_join_requests
Date: Wed, 27 Aug 2025 07:00:00 -0700
Message-ID: <446e6d8861242b960dd711ffe787acf7d1bee107.1756303039.git.trond.myklebust@hammerspace.com>
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
 fs/nfs/write.c           | 75 ++++++++++++++++++++++++++++++++++----
 include/linux/nfs_page.h |  1 -
 3 files changed, 69 insertions(+), 84 deletions(-)

diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
index 040b6b79c75e..30e2488eb84c 100644
--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -206,83 +206,6 @@ nfs_page_group_lock_head(struct nfs_page *req)
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
index 7d03811f44a4..289ff8e9f78a 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -548,6 +548,57 @@ void nfs_join_page_group(struct nfs_page *head, struct nfs_commit_info *cinfo,
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
  * @folio: the folio used to lookup the "page group" of nfs_page structures
@@ -566,7 +617,7 @@ void nfs_join_page_group(struct nfs_page *head, struct nfs_commit_info *cinfo,
 static struct nfs_page *nfs_lock_and_join_requests(struct folio *folio)
 {
 	struct inode *inode = folio_file_mapping(folio)->host;
-	struct nfs_page *head;
+	struct nfs_page *head, *subreq;
 	struct nfs_commit_info cinfo;
 	int ret;
 
@@ -580,16 +631,28 @@ static struct nfs_page *nfs_lock_and_join_requests(struct folio *folio)
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
 
+	nfs_init_cinfo_from_inode(&cinfo, inode);
+	nfs_join_page_group(head, &cinfo, inode);
 	return head;
+
+out_unlock:
+	nfs_unlock_and_release_request(head);
+	return ERR_PTR(ret);
 }
 
 static void nfs_write_error(struct nfs_page *req, int error)
diff --git a/include/linux/nfs_page.h b/include/linux/nfs_page.h
index 1c315f854ea8..3a0f7ebe5388 100644
--- a/include/linux/nfs_page.h
+++ b/include/linux/nfs_page.h
@@ -156,7 +156,6 @@ extern  int nfs_wait_on_request(struct nfs_page *);
 extern	void nfs_unlock_request(struct nfs_page *req);
 extern	void nfs_unlock_and_release_request(struct nfs_page *);
 extern	struct nfs_page *nfs_page_group_lock_head(struct nfs_page *req);
-extern	int nfs_page_group_lock_subrequests(struct nfs_page *head);
 extern void nfs_join_page_group(struct nfs_page *head,
 				struct nfs_commit_info *cinfo,
 				struct inode *inode);
-- 
2.51.0


