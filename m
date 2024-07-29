Return-Path: <stable+bounces-62551-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3FC893F55C
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 14:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6C6C1C21FDD
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 12:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E3B1482F8;
	Mon, 29 Jul 2024 12:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DyQ8ve1X"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9E514830E
	for <stable@vger.kernel.org>; Mon, 29 Jul 2024 12:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722256081; cv=none; b=u/ocSnyeIX7KiO9fIBnTSFz+oBl76iJoLUbim1bcFiQnnKlp7xC4uM8dINOliAj8ahzkBGs9BtpJC/si6L6nR5Qx3LHAxeT6CPjLSz+6svAM3heZak3Ql9+JY8laTsuO+mGM/67uNj5cCqKRFWU6WsX0tvcxgmxgKqPda36wjaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722256081; c=relaxed/simple;
	bh=6oh1S6/1/l90+SrFZMKVClLir9b/Gp1Bj7jXdSwRO1w=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=YF047PF/WPuM5XjMVEZn5LHTdj6kA3yHFXS8n/sfOQpU4REPL+ecBnN9g8wp3udMSQTq+chXsOvic5I+C6YByPnxFFgsrkPKqFbXvlrjVeFeuX21WHg3tXx+0fYiD7cBmgj7e/z7Eq0dN5ra+n7cOns/spwYb8/vJK9gdd+ZYtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DyQ8ve1X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D79C2C32786;
	Mon, 29 Jul 2024 12:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722256081;
	bh=6oh1S6/1/l90+SrFZMKVClLir9b/Gp1Bj7jXdSwRO1w=;
	h=Subject:To:Cc:From:Date:From;
	b=DyQ8ve1Xvmn8dxQ588mwsvDCOQHFIiWYSHflDt82/e67bM/C4LM1pDSSdS/HUvmDU
	 vc4ONU7YxL/dqhumErvwm/lUxc790FOePovPFXDvHfgQj636uVMRJtzFR9hoiWoEP0
	 YZxbzwn+dXd5x1nOuc4Y8P0DIbn8LD8YmRzHqHH4=
Subject: FAILED: patch "[PATCH] nilfs2: handle inconsistent state in" failed to apply to 4.19-stable tree
To: konishi.ryusuke@gmail.com,akpm@linux-foundation.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Jul 2024 14:27:30 +0200
Message-ID: <2024072930-unbridle-negotiate-9977@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 4811f7af6090e8f5a398fbdd766f903ef6c0d787
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024072930-unbridle-negotiate-9977@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

4811f7af6090 ("nilfs2: handle inconsistent state in nilfs_btnode_create_block()")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4811f7af6090e8f5a398fbdd766f903ef6c0d787 Mon Sep 17 00:00:00 2001
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Thu, 25 Jul 2024 14:20:07 +0900
Subject: [PATCH] nilfs2: handle inconsistent state in
 nilfs_btnode_create_block()

Syzbot reported that a buffer state inconsistency was detected in
nilfs_btnode_create_block(), triggering a kernel bug.

It is not appropriate to treat this inconsistency as a bug; it can occur
if the argument block address (the buffer index of the newly created
block) is a virtual block number and has been reallocated due to
corruption of the bitmap used to manage its allocation state.

So, modify nilfs_btnode_create_block() and its callers to treat it as a
possible filesystem error, rather than triggering a kernel bug.

Link: https://lkml.kernel.org/r/20240725052007.4562-1-konishi.ryusuke@gmail.com
Fixes: a60be987d45d ("nilfs2: B-tree node cache")
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Reported-by: syzbot+89cc4f2324ed37988b60@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=89cc4f2324ed37988b60
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/fs/nilfs2/btnode.c b/fs/nilfs2/btnode.c
index 0131d83b912d..c034080c334b 100644
--- a/fs/nilfs2/btnode.c
+++ b/fs/nilfs2/btnode.c
@@ -51,12 +51,21 @@ nilfs_btnode_create_block(struct address_space *btnc, __u64 blocknr)
 
 	bh = nilfs_grab_buffer(inode, btnc, blocknr, BIT(BH_NILFS_Node));
 	if (unlikely(!bh))
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	if (unlikely(buffer_mapped(bh) || buffer_uptodate(bh) ||
 		     buffer_dirty(bh))) {
-		brelse(bh);
-		BUG();
+		/*
+		 * The block buffer at the specified new address was already
+		 * in use.  This can happen if it is a virtual block number
+		 * and has been reallocated due to corruption of the bitmap
+		 * used to manage its allocation state (if not, the buffer
+		 * clearing of an abandoned b-tree node is missing somewhere).
+		 */
+		nilfs_error(inode->i_sb,
+			    "state inconsistency probably due to duplicate use of b-tree node block address %llu (ino=%lu)",
+			    (unsigned long long)blocknr, inode->i_ino);
+		goto failed;
 	}
 	memset(bh->b_data, 0, i_blocksize(inode));
 	bh->b_bdev = inode->i_sb->s_bdev;
@@ -67,6 +76,12 @@ nilfs_btnode_create_block(struct address_space *btnc, __u64 blocknr)
 	folio_unlock(bh->b_folio);
 	folio_put(bh->b_folio);
 	return bh;
+
+failed:
+	folio_unlock(bh->b_folio);
+	folio_put(bh->b_folio);
+	brelse(bh);
+	return ERR_PTR(-EIO);
 }
 
 int nilfs_btnode_submit_block(struct address_space *btnc, __u64 blocknr,
@@ -217,8 +232,8 @@ int nilfs_btnode_prepare_change_key(struct address_space *btnc,
 	}
 
 	nbh = nilfs_btnode_create_block(btnc, newkey);
-	if (!nbh)
-		return -ENOMEM;
+	if (IS_ERR(nbh))
+		return PTR_ERR(nbh);
 
 	BUG_ON(nbh == obh);
 	ctxt->newbh = nbh;
diff --git a/fs/nilfs2/btree.c b/fs/nilfs2/btree.c
index a139970e4804..862bdf23120e 100644
--- a/fs/nilfs2/btree.c
+++ b/fs/nilfs2/btree.c
@@ -63,8 +63,8 @@ static int nilfs_btree_get_new_block(const struct nilfs_bmap *btree,
 	struct buffer_head *bh;
 
 	bh = nilfs_btnode_create_block(btnc, ptr);
-	if (!bh)
-		return -ENOMEM;
+	if (IS_ERR(bh))
+		return PTR_ERR(bh);
 
 	set_buffer_nilfs_volatile(bh);
 	*bhp = bh;


