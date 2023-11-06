Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7587E22CC
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbjKFNFk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:05:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbjKFNFj (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:05:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE2291
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:05:36 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A63DC433C8;
        Mon,  6 Nov 2023 13:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699275936;
        bh=lTYl4UpV7UeoT4zk6S6kRV2/gHlGjvR0s6VbmPvfAro=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LAe7lTsR4sVfX9n3/WTVqd6aCVMVOfKvahplcoKBZcg7qCAMIULH7zOvC6hqsdEfL
         Mnn4eL10ADlLCxq7OaXFYz2GCnTnyrVwIrRNZFMLMfRZUTlgh1dEq4osKrIV+8worr
         BhLQOoTDwOw7Idh05W85BQb4pcxYON4xCFnFCwns=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 14/48] NFS: Dont call generic_error_remove_page() while holding locks
Date:   Mon,  6 Nov 2023 14:03:05 +0100
Message-ID: <20231106130258.339876168@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130257.862199836@linuxfoundation.org>
References: <20231106130257.862199836@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Trond Myklebust <trondmy@gmail.com>

[ Upstream commit 22876f540bdf19af9e4fca893ce02ba7ee65ebcc ]

The NFS read code can trigger writeback while holding the page lock.
If an error then triggers a call to nfs_write_error_remove_page(),
we can deadlock.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/write.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 010733c8bdcd3..1b5791d5537a3 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -587,9 +587,8 @@ nfs_lock_and_join_requests(struct page *page)
 
 static void nfs_write_error_remove_page(struct nfs_page *req)
 {
+	SetPageError(req->wb_page);
 	nfs_end_page_writeback(req);
-	generic_error_remove_page(page_file_mapping(req->wb_page),
-				  req->wb_page);
 	nfs_release_request(req);
 }
 
-- 
2.42.0



