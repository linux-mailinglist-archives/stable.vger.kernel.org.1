Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13C917D319D
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233523AbjJWLLH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233521AbjJWLLH (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:11:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA80C99
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:11:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 166E3C433CA;
        Mon, 23 Oct 2023 11:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698059465;
        bh=KNPtezlZ5hvGu2WTqWXxnVup4nSRBGNOdsJUYFIDgIg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OxtZIkLQaZ95xRy1+MDqZUBf1CiG/MIjiQjUljHK3V8QB1d72dztxNmmJh4lSF12W
         PAiN1npXgrhJy5ma60pGMQwUCbpHpSh0Fv9Tt6Jcao2bRUi6VQV1s4k/SasEzMCvwS
         yv41qls3Ft8SUcafCbOE82RkJhnSxsAah6LeGo3c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Scott Mayhew <smayhew@redhat.com>,
        Benjamin Coddington <bcodding@redhat.com>,
        Jeff Layton <jlayton@kernel.org>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>
Subject: [PATCH 6.5 187/241] NFS: Fix potential oops in nfs_inode_remove_request()
Date:   Mon, 23 Oct 2023 12:56:13 +0200
Message-ID: <20231023104838.440109672@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104833.832874523@linuxfoundation.org>
References: <20231023104833.832874523@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Scott Mayhew <smayhew@redhat.com>

commit 6a6d4644ce935ddec4f76223ac0ca68da56bd2d3 upstream.

Once a folio's private data has been cleared, it's possible for another
process to clear the folio->mapping (e.g. via invalidate_complete_folio2
or evict_mapping_folio), so it wouldn't be safe to call
nfs_page_to_inode() after that.

Fixes: 0c493b5cf16e ("NFS: Convert buffered writes to use folios")
Signed-off-by: Scott Mayhew <smayhew@redhat.com>
Reviewed-by: Benjamin Coddington <bcodding@redhat.com>
Tested-by: Benjamin Coddington <bcodding@redhat.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfs/write.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 7720b5e43014..9d82d50ce0b1 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -788,6 +788,8 @@ static void nfs_inode_add_request(struct nfs_page *req)
  */
 static void nfs_inode_remove_request(struct nfs_page *req)
 {
+	struct nfs_inode *nfsi = NFS_I(nfs_page_to_inode(req));
+
 	if (nfs_page_group_sync_on_bit(req, PG_REMOVE)) {
 		struct folio *folio = nfs_page_to_folio(req->wb_head);
 		struct address_space *mapping = folio_file_mapping(folio);
@@ -802,7 +804,7 @@ static void nfs_inode_remove_request(struct nfs_page *req)
 	}
 
 	if (test_and_clear_bit(PG_INODE_REF, &req->wb_flags)) {
-		atomic_long_dec(&NFS_I(nfs_page_to_inode(req))->nrequests);
+		atomic_long_dec(&nfsi->nrequests);
 		nfs_release_request(req);
 	}
 }
-- 
2.42.0



