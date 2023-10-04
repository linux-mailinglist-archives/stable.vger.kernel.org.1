Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4031A7B892C
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244131AbjJDSXY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244129AbjJDSXY (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:23:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2FF3A6
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:23:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6F7FC433C8;
        Wed,  4 Oct 2023 18:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696443800;
        bh=OInkGBaRO9UjIoIF7Qtcg6jeJj0hB9CX5y2rkxvjUIo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BeDP9KeffmWM9QPPWdkwgaSTf16qR8FLI0OsvNEOQ7l4nfW6fWhw4Qn11xTK09UtC
         raCr4l2ygBzNnuP6ilHPJV70hhxI41anBXRKGvYKYNaa9GtYx6jnG1M0QsfbBNO+Ar
         uJz8m8Wm/aza4XdFK6EFdnkVGTAYb2cTLFYjkeZk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 005/321] NFS: More fixes for nfs_direct_write_reschedule_io()
Date:   Wed,  4 Oct 2023 19:52:30 +0200
Message-ID: <20231004175229.469858383@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175229.211487444@linuxfoundation.org>
References: <20231004175229.211487444@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Trond Myklebust <trond.myklebust@hammerspace.com>

[ Upstream commit b11243f720ee5f9376861099019c8542969b6318 ]

Ensure that all requests are put back onto the commit list so that they
can be rescheduled.

Fixes: 4daaeba93822 ("NFS: Fix nfs_direct_write_reschedule_io()")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/direct.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index 3391c8b97da5e..f6c74f4246917 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -780,18 +780,23 @@ static void nfs_write_sync_pgio_error(struct list_head *head, int error)
 static void nfs_direct_write_reschedule_io(struct nfs_pgio_header *hdr)
 {
 	struct nfs_direct_req *dreq = hdr->dreq;
+	struct nfs_page *req;
+	struct nfs_commit_info cinfo;
 
 	trace_nfs_direct_write_reschedule_io(dreq);
 
+	nfs_init_cinfo_from_dreq(&cinfo, dreq);
 	spin_lock(&dreq->lock);
-	if (dreq->error == 0) {
+	if (dreq->error == 0)
 		dreq->flags = NFS_ODIRECT_RESCHED_WRITES;
-		/* fake unstable write to let common nfs resend pages */
-		hdr->verf.committed = NFS_UNSTABLE;
-		hdr->good_bytes = hdr->args.offset + hdr->args.count -
-			hdr->io_start;
-	}
+	set_bit(NFS_IOHDR_REDO, &hdr->flags);
 	spin_unlock(&dreq->lock);
+	while (!list_empty(&hdr->pages)) {
+		req = nfs_list_entry(hdr->pages.next);
+		nfs_list_remove_request(req);
+		nfs_unlock_request(req);
+		nfs_mark_request_commit(req, NULL, &cinfo, 0);
+	}
 }
 
 static const struct nfs_pgio_completion_ops nfs_direct_write_completion_ops = {
-- 
2.40.1



