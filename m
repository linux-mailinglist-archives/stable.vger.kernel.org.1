Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB9877C758F
	for <lists+stable@lfdr.de>; Thu, 12 Oct 2023 20:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379612AbjJLSBB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 12 Oct 2023 14:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442046AbjJLSA5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 12 Oct 2023 14:00:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C520E5
        for <stable@vger.kernel.org>; Thu, 12 Oct 2023 11:00:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0500C433C8;
        Thu, 12 Oct 2023 18:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697133653;
        bh=jjgW1Of+8sJ+mB5PIwyM2BvarnzEMHxrjOjlWlHxAcg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DEF9CQ3I9YO/TkQWI/ED3T6tSRY9FWAW8Pz0RDP7J5BcNAZgmzoZAKFXMrgPLm/Dw
         ij78xufoviS3vjZZ7UnljOLopKu7WMs1ic8ny2JLXcWQfny8S20tzv/7KJYzXMAwdm
         Mma9XfQOY8z71OWzr9pHV3ohE0fNulN6eeP5cCHo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, poester <poester@internetbrands.com>,
        =?UTF-8?q?Daniel=20D=C3=ADaz?= <daniel.diaz@linaro.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 1/6] Revert "NFS: More fixes for nfs_direct_write_reschedule_io()"
Date:   Thu, 12 Oct 2023 20:00:43 +0200
Message-ID: <20231012180030.165297018@linuxfoundation.org>
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

This reverts commit edd1f06145101dab83497806bb6162641255ef50 which is
commit b11243f720ee5f9376861099019c8542969b6318 upstream.

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
 fs/nfs/direct.c |   17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -782,23 +782,18 @@ static void nfs_write_sync_pgio_error(st
 static void nfs_direct_write_reschedule_io(struct nfs_pgio_header *hdr)
 {
 	struct nfs_direct_req *dreq = hdr->dreq;
-	struct nfs_page *req;
-	struct nfs_commit_info cinfo;
 
 	trace_nfs_direct_write_reschedule_io(dreq);
 
-	nfs_init_cinfo_from_dreq(&cinfo, dreq);
 	spin_lock(&dreq->lock);
-	if (dreq->error == 0)
+	if (dreq->error == 0) {
 		dreq->flags = NFS_ODIRECT_RESCHED_WRITES;
-	set_bit(NFS_IOHDR_REDO, &hdr->flags);
-	spin_unlock(&dreq->lock);
-	while (!list_empty(&hdr->pages)) {
-		req = nfs_list_entry(hdr->pages.next);
-		nfs_list_remove_request(req);
-		nfs_unlock_request(req);
-		nfs_mark_request_commit(req, NULL, &cinfo, 0);
+		/* fake unstable write to let common nfs resend pages */
+		hdr->verf.committed = NFS_UNSTABLE;
+		hdr->good_bytes = hdr->args.offset + hdr->args.count -
+			hdr->io_start;
 	}
+	spin_unlock(&dreq->lock);
 }
 
 static const struct nfs_pgio_completion_ops nfs_direct_write_completion_ops = {


