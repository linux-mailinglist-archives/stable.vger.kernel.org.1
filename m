Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2A6A7D31B4
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233608AbjJWLMK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233628AbjJWLMJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:12:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4FE610C
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:12:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E31B7C433C8;
        Mon, 23 Oct 2023 11:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698059525;
        bh=t0b0x/PH7fgaTaHpq++5o5hDNbZDbdFdTeXJR+mwI8U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bniVkuld9SjCa0P/ommeoTX+8yX6sWnwZOVbtgHW8ctAOK9pT/LXZHKAl0ZLGGihW
         7i9f5wnUsF9GXKga78aFJDDuiNqddhsvmi35LzW10uowNktdBhJsp/Kd1Fj6HByKRE
         oSBdebsrz+B5svciRWvVz3oQB3gKy7UsmULWdV+g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>
Subject: [PATCH 6.5 179/241] pNFS: Fix a hang in nfs4_evict_inode()
Date:   Mon, 23 Oct 2023 12:56:05 +0200
Message-ID: <20231023104838.246889066@linuxfoundation.org>
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

From: Trond Myklebust <trond.myklebust@hammerspace.com>

commit f63955721a8020e979b99cc417dcb6da3106aa24 upstream.

We are not allowed to call pnfs_mark_matching_lsegs_return() without
also holding a reference to the layout header, since doing so could lead
to the reference count going to zero when we call
pnfs_layout_remove_lseg(). This again can lead to a hang when we get to
nfs4_evict_inode() and are unable to clear the layout pointer.

pnfs_layout_return_unused_byserver() is guilty of this behaviour, and
has been seen to trigger the refcount warning prior to a hang.

Fixes: b6d49ecd1081 ("NFSv4: Fix a pNFS layout related use-after-free race when freeing the inode")
Cc: stable@vger.kernel.org
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfs/pnfs.c |   33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -2634,31 +2634,44 @@ pnfs_should_return_unused_layout(struct
 	return mode == 0;
 }
 
-static int
-pnfs_layout_return_unused_byserver(struct nfs_server *server, void *data)
+static int pnfs_layout_return_unused_byserver(struct nfs_server *server,
+					      void *data)
 {
 	const struct pnfs_layout_range *range = data;
+	const struct cred *cred;
 	struct pnfs_layout_hdr *lo;
 	struct inode *inode;
+	nfs4_stateid stateid;
+	enum pnfs_iomode iomode;
+
 restart:
 	rcu_read_lock();
 	list_for_each_entry_rcu(lo, &server->layouts, plh_layouts) {
-		if (!pnfs_layout_can_be_returned(lo) ||
+		inode = lo->plh_inode;
+		if (!inode || !pnfs_layout_can_be_returned(lo) ||
 		    test_bit(NFS_LAYOUT_RETURN_REQUESTED, &lo->plh_flags))
 			continue;
-		inode = lo->plh_inode;
 		spin_lock(&inode->i_lock);
-		if (!pnfs_should_return_unused_layout(lo, range)) {
+		if (!lo->plh_inode ||
+		    !pnfs_should_return_unused_layout(lo, range)) {
 			spin_unlock(&inode->i_lock);
 			continue;
 		}
+		pnfs_get_layout_hdr(lo);
+		pnfs_set_plh_return_info(lo, range->iomode, 0);
+		if (pnfs_mark_matching_lsegs_return(lo, &lo->plh_return_segs,
+						    range, 0) != 0 ||
+		    !pnfs_prepare_layoutreturn(lo, &stateid, &cred, &iomode)) {
+			spin_unlock(&inode->i_lock);
+			rcu_read_unlock();
+			pnfs_put_layout_hdr(lo);
+			cond_resched();
+			goto restart;
+		}
 		spin_unlock(&inode->i_lock);
-		inode = pnfs_grab_inode_layout_hdr(lo);
-		if (!inode)
-			continue;
 		rcu_read_unlock();
-		pnfs_mark_layout_for_return(inode, range);
-		iput(inode);
+		pnfs_send_layoutreturn(lo, &stateid, &cred, iomode, false);
+		pnfs_put_layout_hdr(lo);
 		cond_resched();
 		goto restart;
 	}


