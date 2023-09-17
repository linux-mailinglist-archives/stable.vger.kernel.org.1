Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F10617A3A64
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240337AbjIQUCq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240542AbjIQUCk (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:02:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 588A7CC1
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:02:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89533C433D9;
        Sun, 17 Sep 2023 20:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694980934;
        bh=YMNrfYwfGcHibjtNZ5QK0sKA7Yj+7seU83m51hanu3s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F2nJ/Pu1yACHDpqJyD0rz/elmKRAjLcAhxCTmBajmCQ/kZ3enndj/RKQ5saC2mpA3
         Z/RtJ7OMdZqnkbgvUoKHejLGk45C47AmweIcjtztDE45wY9gHEJkutVd92yGN1KEKp
         eMcqr4T3wbRgQ0TgMTxD+Cf4KePzexShFxabRwGg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>
Subject: [PATCH 6.1 049/219] NFS: Fix a potential data corruption
Date:   Sun, 17 Sep 2023 21:12:56 +0200
Message-ID: <20230917191042.778246848@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191040.964416434@linuxfoundation.org>
References: <20230917191040.964416434@linuxfoundation.org>
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

commit 88975a55969e11f26fe3846bf4fbf8e7dc8cbbd4 upstream.

We must ensure that the subrequests are joined back into the head before
we can retransmit a request. If the head was not on the commit lists,
because the server wrote it synchronously, we still need to add it back
to the retransmission list.
Add a call that mirrors the effect of nfs_cancel_remove_inode() for
O_DIRECT.

Fixes: ed5d588fe47f ("NFS: Try to join page groups before an O_DIRECT retransmission")
Cc: stable@vger.kernel.org
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfs/direct.c |   20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -474,13 +474,31 @@ out:
 	return result;
 }
 
+static void nfs_direct_add_page_head(struct list_head *list,
+				     struct nfs_page *req)
+{
+	struct nfs_page *head = req->wb_head;
+
+	if (!list_empty(&head->wb_list) || !nfs_lock_request(head))
+		return;
+	if (!list_empty(&head->wb_list)) {
+		nfs_unlock_request(head);
+		return;
+	}
+	list_add(&head->wb_list, list);
+	kref_get(&head->wb_kref);
+	kref_get(&head->wb_kref);
+}
+
 static void nfs_direct_join_group(struct list_head *list, struct inode *inode)
 {
 	struct nfs_page *req, *subreq;
 
 	list_for_each_entry(req, list, wb_list) {
-		if (req->wb_head != req)
+		if (req->wb_head != req) {
+			nfs_direct_add_page_head(&req->wb_list, req);
 			continue;
+		}
 		subreq = req->wb_this_page;
 		if (subreq == req)
 			continue;


