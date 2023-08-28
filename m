Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E01A78AD41
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbjH1Kqz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231966AbjH1Kq0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:46:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A6C2E43
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:46:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F00B364215
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:46:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B852C433CD;
        Mon, 28 Aug 2023 10:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693219562;
        bh=x8LUe+/NZ9JrESZ9lXf4F6RaVQXYfdxNSAL7KgjomnE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h3Hc6xzMygAQgx18j1SblDk3exVPSY0L3yDdszTxCx1HJUlEEZ77heDbyp5vxYbfP
         qdZPMTK6L8QnMnQW2egKc97oVHRS6p1dymx0ZFic1QCjyHYNDX2lZUtgitKzBmTjoq
         9+QNoH1KAzaP5LItPRF9/CIWNHV3AB4fSF0++S8Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Chris Mason <clm@fb.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: [PATCH 5.15 52/89] NFS: Fix a use after free in nfs_direct_join_group()
Date:   Mon, 28 Aug 2023 12:13:53 +0200
Message-ID: <20230828101151.922052879@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101150.163430842@linuxfoundation.org>
References: <20230828101150.163430842@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Trond Myklebust <trond.myklebust@hammerspace.com>

commit be2fd1560eb57b7298aa3c258ddcca0d53ecdea3 upstream.

Be more careful when tearing down the subrequests of an O_DIRECT write
as part of a retransmission.

Reported-by: Chris Mason <clm@fb.com>
Fixes: ed5d588fe47f ("NFS: Try to join page groups before an O_DIRECT retransmission")
Cc: stable@vger.kernel.org
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfs/direct.c |   26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -509,20 +509,26 @@ out:
 	return result;
 }
 
-static void
-nfs_direct_join_group(struct list_head *list, struct inode *inode)
+static void nfs_direct_join_group(struct list_head *list, struct inode *inode)
 {
-	struct nfs_page *req, *next;
+	struct nfs_page *req, *subreq;
 
 	list_for_each_entry(req, list, wb_list) {
-		if (req->wb_head != req || req->wb_this_page == req)
+		if (req->wb_head != req)
 			continue;
-		for (next = req->wb_this_page;
-				next != req->wb_head;
-				next = next->wb_this_page) {
-			nfs_list_remove_request(next);
-			nfs_release_request(next);
-		}
+		subreq = req->wb_this_page;
+		if (subreq == req)
+			continue;
+		do {
+			/*
+			 * Remove subrequests from this list before freeing
+			 * them in the call to nfs_join_page_group().
+			 */
+			if (!list_empty(&subreq->wb_list)) {
+				nfs_list_remove_request(subreq);
+				nfs_release_request(subreq);
+			}
+		} while ((subreq = subreq->wb_this_page) != req);
 		nfs_join_page_group(req, inode);
 	}
 }


