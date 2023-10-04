Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0786E7B87ED
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243913AbjJDSK7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243911AbjJDSK6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:10:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49EF8BF
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:10:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94D58C433C8;
        Wed,  4 Oct 2023 18:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696443054;
        bh=FmwJgAGHBiPodnztgzhYuHTr7uRugQuctoAf82kvrw4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cbT1yd4lmHBxIOtakmocwv73cecTOtQbOpM78q3/dK/4YB+79ai/K/qUOorTGcbuJ
         hv5SbZs2ctaEIdBcQTZ+gCIn1BG1Abdi6v2+ZbYwGvbmDIsmlbQQsutavNRrkrM+ap
         7lR1dGJoUi5mrIEDC1vDzUyRORn+pMIDinw328cI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 002/259] NFS: Fix O_DIRECT locking issues
Date:   Wed,  4 Oct 2023 19:52:55 +0200
Message-ID: <20231004175217.530094213@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175217.404851126@linuxfoundation.org>
References: <20231004175217.404851126@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Trond Myklebust <trond.myklebust@hammerspace.com>

[ Upstream commit 7c6339322ce0c6128acbe36aacc1eeb986dd7bf1 ]

The dreq fields are protected by the dreq->lock.

Fixes: 954998b60caa ("NFS: Fix error handling for O_DIRECT write scheduling")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/direct.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index d71762f32b6c4..449d248fc1ec7 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -555,7 +555,7 @@ static void nfs_direct_write_reschedule(struct nfs_direct_req *dreq)
 		/* Bump the transmission count */
 		req->wb_nio++;
 		if (!nfs_pageio_add_request(&desc, req)) {
-			spin_lock(&cinfo.inode->i_lock);
+			spin_lock(&dreq->lock);
 			if (dreq->error < 0) {
 				desc.pg_error = dreq->error;
 			} else if (desc.pg_error != -EAGAIN) {
@@ -565,7 +565,7 @@ static void nfs_direct_write_reschedule(struct nfs_direct_req *dreq)
 				dreq->error = desc.pg_error;
 			} else
 				dreq->flags = NFS_ODIRECT_RESCHED_WRITES;
-			spin_unlock(&cinfo.inode->i_lock);
+			spin_unlock(&dreq->lock);
 			break;
 		}
 		nfs_release_request(req);
@@ -875,9 +875,9 @@ static ssize_t nfs_direct_write_schedule_iovec(struct nfs_direct_req *dreq,
 
 			/* If the error is soft, defer remaining requests */
 			nfs_init_cinfo_from_dreq(&cinfo, dreq);
-			spin_lock(&cinfo.inode->i_lock);
+			spin_lock(&dreq->lock);
 			dreq->flags = NFS_ODIRECT_RESCHED_WRITES;
-			spin_unlock(&cinfo.inode->i_lock);
+			spin_unlock(&dreq->lock);
 			nfs_unlock_request(req);
 			nfs_mark_request_commit(req, NULL, &cinfo, 0);
 			desc.pg_error = 0;
-- 
2.40.1



