Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4286A7B871F
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233210AbjJDSBs (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232583AbjJDSBr (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:01:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8166E9E
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:01:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5316C433C7;
        Wed,  4 Oct 2023 18:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696442504;
        bh=C5giSE+b8BGO3t3LZSdujQv138aJM2RZ9BODUj1MwX8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wJqo7x2XySDebcvU//DUDGWkd7ysEy7j5KBpZRmcbqIvPOrfWPMgq3QNJrznPm2Yc
         WLKnHE1VpN+hUryYpFf/+203wq6sYtrcNgvDNmwjNgk/ZNYzI4bB3bwtXxLi/xoT06
         2DhRPNN0e8lEp3I65Tjp/yw/uQS4duEER+WfYTbA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 001/183] NFS: Use the correct commit info in nfs_join_page_group()
Date:   Wed,  4 Oct 2023 19:53:52 +0200
Message-ID: <20231004175204.021573439@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175203.943277832@linuxfoundation.org>
References: <20231004175203.943277832@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Trond Myklebust <trond.myklebust@hammerspace.com>

[ Upstream commit b193a78ddb5ee7dba074d3f28dc050069ba083c0 ]

Ensure that nfs_clear_request_commit() updates the correct counters when
it removes them from the commit list.

Fixes: ed5d588fe47f ("NFS: Try to join page groups before an O_DIRECT retransmission")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/direct.c          |  8 +++++---
 fs/nfs/write.c           | 23 ++++++++++++-----------
 include/linux/nfs_page.h |  4 +++-
 3 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index 018af6ec97b40..5d86ffa72ceab 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -525,7 +525,9 @@ static void nfs_direct_add_page_head(struct list_head *list,
 	kref_get(&head->wb_kref);
 }
 
-static void nfs_direct_join_group(struct list_head *list, struct inode *inode)
+static void nfs_direct_join_group(struct list_head *list,
+				  struct nfs_commit_info *cinfo,
+				  struct inode *inode)
 {
 	struct nfs_page *req, *subreq;
 
@@ -547,7 +549,7 @@ static void nfs_direct_join_group(struct list_head *list, struct inode *inode)
 				nfs_release_request(subreq);
 			}
 		} while ((subreq = subreq->wb_this_page) != req);
-		nfs_join_page_group(req, inode);
+		nfs_join_page_group(req, cinfo, inode);
 	}
 }
 
@@ -573,7 +575,7 @@ static void nfs_direct_write_reschedule(struct nfs_direct_req *dreq)
 	nfs_init_cinfo_from_dreq(&cinfo, dreq);
 	nfs_direct_write_scan_commit_list(dreq->inode, &reqs, &cinfo);
 
-	nfs_direct_join_group(&reqs, dreq->inode);
+	nfs_direct_join_group(&reqs, &cinfo, dreq->inode);
 
 	dreq->count = 0;
 	dreq->max_count = 0;
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index be70874bc3292..4231d51fc1add 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -58,7 +58,8 @@ static const struct nfs_pgio_completion_ops nfs_async_write_completion_ops;
 static const struct nfs_commit_completion_ops nfs_commit_completion_ops;
 static const struct nfs_rw_ops nfs_rw_write_ops;
 static void nfs_inode_remove_request(struct nfs_page *req);
-static void nfs_clear_request_commit(struct nfs_page *req);
+static void nfs_clear_request_commit(struct nfs_commit_info *cinfo,
+				     struct nfs_page *req);
 static void nfs_init_cinfo_from_inode(struct nfs_commit_info *cinfo,
 				      struct inode *inode);
 static struct nfs_page *
@@ -500,8 +501,8 @@ nfs_destroy_unlinked_subrequests(struct nfs_page *destroy_list,
  * the (former) group.  All subrequests are removed from any write or commit
  * lists, unlinked from the group and destroyed.
  */
-void
-nfs_join_page_group(struct nfs_page *head, struct inode *inode)
+void nfs_join_page_group(struct nfs_page *head, struct nfs_commit_info *cinfo,
+			 struct inode *inode)
 {
 	struct nfs_page *subreq;
 	struct nfs_page *destroy_list = NULL;
@@ -531,7 +532,7 @@ nfs_join_page_group(struct nfs_page *head, struct inode *inode)
 	 * Commit list removal accounting is done after locks are dropped */
 	subreq = head;
 	do {
-		nfs_clear_request_commit(subreq);
+		nfs_clear_request_commit(cinfo, subreq);
 		subreq = subreq->wb_this_page;
 	} while (subreq != head);
 
@@ -565,8 +566,10 @@ nfs_lock_and_join_requests(struct page *page)
 {
 	struct inode *inode = page_file_mapping(page)->host;
 	struct nfs_page *head;
+	struct nfs_commit_info cinfo;
 	int ret;
 
+	nfs_init_cinfo_from_inode(&cinfo, inode);
 	/*
 	 * A reference is taken only on the head request which acts as a
 	 * reference to the whole page group - the group will not be destroyed
@@ -583,7 +586,7 @@ nfs_lock_and_join_requests(struct page *page)
 		return ERR_PTR(ret);
 	}
 
-	nfs_join_page_group(head, inode);
+	nfs_join_page_group(head, &cinfo, inode);
 
 	return head;
 }
@@ -945,18 +948,16 @@ nfs_clear_page_commit(struct page *page)
 }
 
 /* Called holding the request lock on @req */
-static void
-nfs_clear_request_commit(struct nfs_page *req)
+static void nfs_clear_request_commit(struct nfs_commit_info *cinfo,
+				     struct nfs_page *req)
 {
 	if (test_bit(PG_CLEAN, &req->wb_flags)) {
 		struct nfs_open_context *ctx = nfs_req_openctx(req);
 		struct inode *inode = d_inode(ctx->dentry);
-		struct nfs_commit_info cinfo;
 
-		nfs_init_cinfo_from_inode(&cinfo, inode);
 		mutex_lock(&NFS_I(inode)->commit_mutex);
-		if (!pnfs_clear_request_commit(req, &cinfo)) {
-			nfs_request_remove_commit_list(req, &cinfo);
+		if (!pnfs_clear_request_commit(req, cinfo)) {
+			nfs_request_remove_commit_list(req, cinfo);
 		}
 		mutex_unlock(&NFS_I(inode)->commit_mutex);
 		nfs_clear_page_commit(req->wb_page);
diff --git a/include/linux/nfs_page.h b/include/linux/nfs_page.h
index f0373a6cb5fb6..40aa09a21f75d 100644
--- a/include/linux/nfs_page.h
+++ b/include/linux/nfs_page.h
@@ -145,7 +145,9 @@ extern	void nfs_unlock_request(struct nfs_page *req);
 extern	void nfs_unlock_and_release_request(struct nfs_page *);
 extern	struct nfs_page *nfs_page_group_lock_head(struct nfs_page *req);
 extern	int nfs_page_group_lock_subrequests(struct nfs_page *head);
-extern	void nfs_join_page_group(struct nfs_page *head, struct inode *inode);
+extern void nfs_join_page_group(struct nfs_page *head,
+				struct nfs_commit_info *cinfo,
+				struct inode *inode);
 extern int nfs_page_group_lock(struct nfs_page *);
 extern void nfs_page_group_unlock(struct nfs_page *);
 extern bool nfs_page_group_sync_on_bit(struct nfs_page *, unsigned int);
-- 
2.40.1



