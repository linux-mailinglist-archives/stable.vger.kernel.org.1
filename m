Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D674F7D1BE1
	for <lists+stable@lfdr.de>; Sat, 21 Oct 2023 11:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjJUJEo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 21 Oct 2023 05:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjJUJEo (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 21 Oct 2023 05:04:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E4CDD
        for <stable@vger.kernel.org>; Sat, 21 Oct 2023 02:04:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86E17C433C8;
        Sat, 21 Oct 2023 09:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697879078;
        bh=+NRr4CcLPJJpk7pY0RZvLMZeYWtvdg64CMOgFatwWwY=;
        h=Subject:To:Cc:From:Date:From;
        b=mneSJz0Ajcxp79rwugE4m7SqPJxNxN4wtkhFJFuFutuxddz3i3tO+ic7H1176k56r
         f8NAZPwhYvT9+k1wcmDz0JjtVLDDUmrlgXCBKlZ6ORrFEKjZ0V88E8lFlDq42ht663
         YZRH26Q6HSqwpyMFYRJXmTD63srxoXQ8LNeCbJwo=
Subject: FAILED: patch "[PATCH] pNFS: Fix a hang in nfs4_evict_inode()" failed to apply to 5.4-stable tree
To:     trond.myklebust@hammerspace.com, Anna.Schumaker@Netapp.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 21 Oct 2023 11:04:36 +0200
Message-ID: <2023102135-blurt-entree-54ec@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x f63955721a8020e979b99cc417dcb6da3106aa24
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023102135-blurt-entree-54ec@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f63955721a8020e979b99cc417dcb6da3106aa24 Mon Sep 17 00:00:00 2001
From: Trond Myklebust <trond.myklebust@hammerspace.com>
Date: Sun, 8 Oct 2023 14:20:19 -0400
Subject: [PATCH] pNFS: Fix a hang in nfs4_evict_inode()

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

diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index 306cba0b9e69..84343aefbbd6 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -2634,31 +2634,44 @@ pnfs_should_return_unused_layout(struct pnfs_layout_hdr *lo,
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

