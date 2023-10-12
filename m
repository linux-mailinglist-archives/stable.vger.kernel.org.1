Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 809707C7592
	for <lists+stable@lfdr.de>; Thu, 12 Oct 2023 20:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379687AbjJLSBE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 12 Oct 2023 14:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379688AbjJLSBE (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 12 Oct 2023 14:01:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FAD8E0
        for <stable@vger.kernel.org>; Thu, 12 Oct 2023 11:01:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3B50C433C8;
        Thu, 12 Oct 2023 18:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697133661;
        bh=KqeZRgYO0ZLCPRblChDUO8AjZ7CVzdpGhB30pQ5liM4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A9AsEBhT3MIcMrTxBshphm50LioFJ8gQTkTe1RfjHxVyJ3PsuSTq+2vyJUEMN6EQk
         ZJKMABiheDaQybJF5Vd0CVHU8dlMGCERf2Kbr/+xNGbL3HETByhN9Kp2HsWVnMepmI
         8rtBBS/BYnONULW9w17y8kORMcVhvGA2kLMgJQ9U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, poester <poester@internetbrands.com>,
        =?UTF-8?q?Daniel=20D=C3=ADaz?= <daniel.diaz@linaro.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 2/6] Revert "NFS: Use the correct commit info in nfs_join_page_group()"
Date:   Thu, 12 Oct 2023 20:00:44 +0200
Message-ID: <20231012180030.188151985@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231012180030.112560642@linuxfoundation.org>
References: <20231012180030.112560642@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

This reverts commit d4729af1c73cfacb64facda3d196e25940f0e7a5 which is
commit b193a78ddb5ee7dba074d3f28dc050069ba083c0 upstream.

There are reported NFS problems in the 6.1.56 release, so revert a set
of NFS patches to hopefully resolve the issue.

Reported-by: poester <poester@internetbrands.com>
Link: https://lore.kernel.org/r/20231012165439.137237-2-kernel@linuxace.com
Reported-by: Daniel Díaz <daniel.diaz@linaro.org>
Link: https://lore.kernel.org/r/2023100755-livestock-barcode-fe41@gregkh
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>
Cc: Anna Schumaker <Anna.Schumaker@Netapp.com>
Cc: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfs/direct.c          |    8 +++-----
 fs/nfs/write.c           |   23 +++++++++++------------
 include/linux/nfs_page.h |    4 +---
 3 files changed, 15 insertions(+), 20 deletions(-)

--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -500,9 +500,7 @@ static void nfs_direct_add_page_head(str
 	kref_get(&head->wb_kref);
 }
 
-static void nfs_direct_join_group(struct list_head *list,
-				  struct nfs_commit_info *cinfo,
-				  struct inode *inode)
+static void nfs_direct_join_group(struct list_head *list, struct inode *inode)
 {
 	struct nfs_page *req, *subreq;
 
@@ -524,7 +522,7 @@ static void nfs_direct_join_group(struct
 				nfs_release_request(subreq);
 			}
 		} while ((subreq = subreq->wb_this_page) != req);
-		nfs_join_page_group(req, cinfo, inode);
+		nfs_join_page_group(req, inode);
 	}
 }
 
@@ -549,7 +547,7 @@ static void nfs_direct_write_reschedule(
 	nfs_init_cinfo_from_dreq(&cinfo, dreq);
 	nfs_direct_write_scan_commit_list(dreq->inode, &reqs, &cinfo);
 
-	nfs_direct_join_group(&reqs, &cinfo, dreq->inode);
+	nfs_direct_join_group(&reqs, dreq->inode);
 
 	nfs_clear_pnfs_ds_commit_verifiers(&dreq->ds_cinfo);
 	get_dreq(dreq);
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -58,8 +58,7 @@ static const struct nfs_pgio_completion_
 static const struct nfs_commit_completion_ops nfs_commit_completion_ops;
 static const struct nfs_rw_ops nfs_rw_write_ops;
 static void nfs_inode_remove_request(struct nfs_page *req);
-static void nfs_clear_request_commit(struct nfs_commit_info *cinfo,
-				     struct nfs_page *req);
+static void nfs_clear_request_commit(struct nfs_page *req);
 static void nfs_init_cinfo_from_inode(struct nfs_commit_info *cinfo,
 				      struct inode *inode);
 static struct nfs_page *
@@ -503,8 +502,8 @@ nfs_destroy_unlinked_subrequests(struct
  * the (former) group.  All subrequests are removed from any write or commit
  * lists, unlinked from the group and destroyed.
  */
-void nfs_join_page_group(struct nfs_page *head, struct nfs_commit_info *cinfo,
-			 struct inode *inode)
+void
+nfs_join_page_group(struct nfs_page *head, struct inode *inode)
 {
 	struct nfs_page *subreq;
 	struct nfs_page *destroy_list = NULL;
@@ -534,7 +533,7 @@ void nfs_join_page_group(struct nfs_page
 	 * Commit list removal accounting is done after locks are dropped */
 	subreq = head;
 	do {
-		nfs_clear_request_commit(cinfo, subreq);
+		nfs_clear_request_commit(subreq);
 		subreq = subreq->wb_this_page;
 	} while (subreq != head);
 
@@ -568,10 +567,8 @@ nfs_lock_and_join_requests(struct page *
 {
 	struct inode *inode = page_file_mapping(page)->host;
 	struct nfs_page *head;
-	struct nfs_commit_info cinfo;
 	int ret;
 
-	nfs_init_cinfo_from_inode(&cinfo, inode);
 	/*
 	 * A reference is taken only on the head request which acts as a
 	 * reference to the whole page group - the group will not be destroyed
@@ -588,7 +585,7 @@ nfs_lock_and_join_requests(struct page *
 		return ERR_PTR(ret);
 	}
 
-	nfs_join_page_group(head, &cinfo, inode);
+	nfs_join_page_group(head, inode);
 
 	return head;
 }
@@ -959,16 +956,18 @@ nfs_clear_page_commit(struct page *page)
 }
 
 /* Called holding the request lock on @req */
-static void nfs_clear_request_commit(struct nfs_commit_info *cinfo,
-				     struct nfs_page *req)
+static void
+nfs_clear_request_commit(struct nfs_page *req)
 {
 	if (test_bit(PG_CLEAN, &req->wb_flags)) {
 		struct nfs_open_context *ctx = nfs_req_openctx(req);
 		struct inode *inode = d_inode(ctx->dentry);
+		struct nfs_commit_info cinfo;
 
+		nfs_init_cinfo_from_inode(&cinfo, inode);
 		mutex_lock(&NFS_I(inode)->commit_mutex);
-		if (!pnfs_clear_request_commit(req, cinfo)) {
-			nfs_request_remove_commit_list(req, cinfo);
+		if (!pnfs_clear_request_commit(req, &cinfo)) {
+			nfs_request_remove_commit_list(req, &cinfo);
 		}
 		mutex_unlock(&NFS_I(inode)->commit_mutex);
 		nfs_clear_page_commit(req->wb_page);
--- a/include/linux/nfs_page.h
+++ b/include/linux/nfs_page.h
@@ -145,9 +145,7 @@ extern	void nfs_unlock_request(struct nf
 extern	void nfs_unlock_and_release_request(struct nfs_page *);
 extern	struct nfs_page *nfs_page_group_lock_head(struct nfs_page *req);
 extern	int nfs_page_group_lock_subrequests(struct nfs_page *head);
-extern void nfs_join_page_group(struct nfs_page *head,
-				struct nfs_commit_info *cinfo,
-				struct inode *inode);
+extern	void nfs_join_page_group(struct nfs_page *head, struct inode *inode);
 extern int nfs_page_group_lock(struct nfs_page *);
 extern void nfs_page_group_unlock(struct nfs_page *);
 extern bool nfs_page_group_sync_on_bit(struct nfs_page *, unsigned int);


