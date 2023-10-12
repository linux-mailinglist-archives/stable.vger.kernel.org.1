Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B93C7C7593
	for <lists+stable@lfdr.de>; Thu, 12 Oct 2023 20:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347361AbjJLSBK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 12 Oct 2023 14:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347364AbjJLSBJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 12 Oct 2023 14:01:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE46A9
        for <stable@vger.kernel.org>; Thu, 12 Oct 2023 11:01:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCCAEC433C8;
        Thu, 12 Oct 2023 18:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697133664;
        bh=rG+LI9+hmd+I9q4dI6tdGur6vH0MXcR/Xx2Tyucp+CI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pEhToTnBV6pN4XKFhaHXDqBZbfyeD0Op2boX1GXMweG48tka3dtVUDQZIEmkyDmhC
         9LmBZ8hT904PSZDU0mB/pI5b/xne0l/two2mmgCv7mjFjXdpTpy7+79QM0jfYESQrX
         1XGk9DBFV7sODa9OKyDaIAXMVT+qbvDRZO0BnRuI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, poester <poester@internetbrands.com>,
        =?UTF-8?q?Daniel=20D=C3=ADaz?= <daniel.diaz@linaro.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 3/6] Revert "NFS: More O_DIRECT accounting fixes for error paths"
Date:   Thu, 12 Oct 2023 20:00:45 +0200
Message-ID: <20231012180030.211372855@linuxfoundation.org>
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

This reverts commit 1f49386d67792424028acfe781d466b010f8fa3f which is
commit 8982f7aff39fb526aba4441fff2525fcedd5e1a3 upstream.

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
 fs/nfs/direct.c |   47 ++++++++++++++++-------------------------------
 1 file changed, 16 insertions(+), 31 deletions(-)

--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -93,10 +93,12 @@ nfs_direct_handle_truncated(struct nfs_d
 		dreq->max_count = dreq_len;
 		if (dreq->count > dreq_len)
 			dreq->count = dreq_len;
-	}
 
-	if (test_bit(NFS_IOHDR_ERROR, &hdr->flags) && !dreq->error)
-		dreq->error = hdr->error;
+		if (test_bit(NFS_IOHDR_ERROR, &hdr->flags))
+			dreq->error = hdr->error;
+		else /* Clear outstanding error if this is EOF */
+			dreq->error = 0;
+	}
 }
 
 static void
@@ -118,18 +120,6 @@ nfs_direct_count_bytes(struct nfs_direct
 		dreq->count = dreq_len;
 }
 
-static void nfs_direct_truncate_request(struct nfs_direct_req *dreq,
-					struct nfs_page *req)
-{
-	loff_t offs = req_offset(req);
-	size_t req_start = (size_t)(offs - dreq->io_start);
-
-	if (req_start < dreq->max_count)
-		dreq->max_count = req_start;
-	if (req_start < dreq->count)
-		dreq->count = req_start;
-}
-
 /**
  * nfs_swap_rw - NFS address space operation for swap I/O
  * @iocb: target I/O control block
@@ -549,6 +539,10 @@ static void nfs_direct_write_reschedule(
 
 	nfs_direct_join_group(&reqs, dreq->inode);
 
+	dreq->count = 0;
+	dreq->max_count = 0;
+	list_for_each_entry(req, &reqs, wb_list)
+		dreq->max_count += req->wb_bytes;
 	nfs_clear_pnfs_ds_commit_verifiers(&dreq->ds_cinfo);
 	get_dreq(dreq);
 
@@ -582,14 +576,10 @@ static void nfs_direct_write_reschedule(
 		req = nfs_list_entry(reqs.next);
 		nfs_list_remove_request(req);
 		nfs_unlock_and_release_request(req);
-		if (desc.pg_error == -EAGAIN) {
+		if (desc.pg_error == -EAGAIN)
 			nfs_mark_request_commit(req, NULL, &cinfo, 0);
-		} else {
-			spin_lock(&dreq->lock);
-			nfs_direct_truncate_request(dreq, req);
-			spin_unlock(&dreq->lock);
+		else
 			nfs_release_request(req);
-		}
 	}
 
 	if (put_dreq(dreq))
@@ -609,6 +599,8 @@ static void nfs_direct_commit_complete(s
 	if (status < 0) {
 		/* Errors in commit are fatal */
 		dreq->error = status;
+		dreq->max_count = 0;
+		dreq->count = 0;
 		dreq->flags = NFS_ODIRECT_DONE;
 	} else {
 		status = dreq->error;
@@ -619,12 +611,7 @@ static void nfs_direct_commit_complete(s
 	while (!list_empty(&data->pages)) {
 		req = nfs_list_entry(data->pages.next);
 		nfs_list_remove_request(req);
-		if (status < 0) {
-			spin_lock(&dreq->lock);
-			nfs_direct_truncate_request(dreq, req);
-			spin_unlock(&dreq->lock);
-			nfs_release_request(req);
-		} else if (!nfs_write_match_verf(verf, req)) {
+		if (status >= 0 && !nfs_write_match_verf(verf, req)) {
 			dreq->flags = NFS_ODIRECT_RESCHED_WRITES;
 			/*
 			 * Despite the reboot, the write was successful,
@@ -632,7 +619,7 @@ static void nfs_direct_commit_complete(s
 			 */
 			req->wb_nio = 0;
 			nfs_mark_request_commit(req, NULL, &cinfo, 0);
-		} else
+		} else /* Error or match */
 			nfs_release_request(req);
 		nfs_unlock_and_release_request(req);
 	}
@@ -685,7 +672,6 @@ static void nfs_direct_write_clear_reqs(
 	while (!list_empty(&reqs)) {
 		req = nfs_list_entry(reqs.next);
 		nfs_list_remove_request(req);
-		nfs_direct_truncate_request(dreq, req);
 		nfs_release_request(req);
 		nfs_unlock_and_release_request(req);
 	}
@@ -735,8 +721,7 @@ static void nfs_direct_write_completion(
 	}
 
 	nfs_direct_count_bytes(dreq, hdr);
-	if (test_bit(NFS_IOHDR_UNSTABLE_WRITES, &hdr->flags) &&
-	    !test_bit(NFS_IOHDR_ERROR, &hdr->flags)) {
+	if (test_bit(NFS_IOHDR_UNSTABLE_WRITES, &hdr->flags)) {
 		if (!dreq->flags)
 			dreq->flags = NFS_ODIRECT_DO_COMMIT;
 		flags = dreq->flags;


