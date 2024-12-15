Return-Path: <stable+bounces-104241-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A4B9F22A1
	for <lists+stable@lfdr.de>; Sun, 15 Dec 2024 09:37:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 962B1165C07
	for <lists+stable@lfdr.de>; Sun, 15 Dec 2024 08:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659B447F69;
	Sun, 15 Dec 2024 08:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IKSssXMs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E967483
	for <stable@vger.kernel.org>; Sun, 15 Dec 2024 08:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734251822; cv=none; b=ko1mv3t/6tj32jxi1czrd5TWBxZFk4vHRF9DvyInYgoZjP/c/pbpzeKviX4DH+r4ODqWmj/idLk6vtMe9mDjOCoSLRjauz6cqDj/rQuc86Hh5n52enwN1f8hpWJSokwxdx1cWiMgv47rhdN78kD865pIT12jN4zpbCTEUhD2d7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734251822; c=relaxed/simple;
	bh=dOIYv2tIRzTBx9dBAqIQgil0dPht4olQffO0dMaMFQg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Ng4wViPTot27OZQkzGmMU7wkkTXAOYU6dw/eMN+FMiREZx1hEPL0eEt1mX/WxfBFF7HjTi75JYT/4hi17zBRtsqRqHVVuIKpXdNuJSccLkFJ6qGyq9V4n+2R0JdcFBPZ1ykYGMpHJm43yoMY+EBTCkvW4ulqYRmqCZgdAmyiKdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IKSssXMs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC66FC4CECE;
	Sun, 15 Dec 2024 08:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734251821;
	bh=dOIYv2tIRzTBx9dBAqIQgil0dPht4olQffO0dMaMFQg=;
	h=Subject:To:Cc:From:Date:From;
	b=IKSssXMsWTFE248LnRAcb252+YSsbI6ekx++VgGe6G86w7DlYBEQxCWHfzSeImKp1
	 EdTMknDxZPmWWyGBIG2oxn3wsKQwLgjdR3EnsT7G5rZEO37FWm2XsSmAb00Wjq5L/p
	 8z1WqSesr4cu+LQjNe1PWrVvDvwua/Yqv9iL+dEM=
Subject: FAILED: patch "[PATCH] xfs: update btree keys correctly when _insrec splits an inode" failed to apply to 5.10-stable tree
To: djwong@kernel.org,hch@lst.de,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 15 Dec 2024 09:36:58 +0100
Message-ID: <2024121557-maker-flint-95f1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 6d7b4bc1c3e00b1a25b7a05141a64337b4629337
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024121557-maker-flint-95f1@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6d7b4bc1c3e00b1a25b7a05141a64337b4629337 Mon Sep 17 00:00:00 2001
From: "Darrick J. Wong" <djwong@kernel.org>
Date: Mon, 2 Dec 2024 10:57:31 -0800
Subject: [PATCH] xfs: update btree keys correctly when _insrec splits an inode
 root block

In commit 2c813ad66a72, I partially fixed a bug wherein xfs_btree_insrec
would erroneously try to update the parent's key for a block that had
been split if we decided to insert the new record into the new block.
The solution was to detect this situation and update the in-core key
value that we pass up to the caller so that the caller will (eventually)
add the new block to the parent level of the tree with the correct key.

However, I missed a subtlety about the way inode-rooted btrees work.  If
the full block was a maximally sized inode root block, we'll solve that
fullness by moving the root block's records to a new block, resizing the
root block, and updating the root to point to the new block.  We don't
pass a pointer to the new block to the caller because that work has
already been done.  The new record will /always/ land in the new block,
so in this case we need to use xfs_btree_update_keys to update the keys.

This bug can theoretically manifest itself in the very rare case that we
split a bmbt root block and the new record lands in the very first slot
of the new block, though I've never managed to trigger it in practice.
However, it is very easy to reproduce by running generic/522 with the
realtime rmapbt patchset if rtinherit=1.

Cc: <stable@vger.kernel.org> # v4.8
Fixes: 2c813ad66a7218 ("xfs: support btrees with overlapping intervals for keys")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>

diff --git a/fs/xfs/libxfs/xfs_btree.c b/fs/xfs/libxfs/xfs_btree.c
index c748866ef923..68ee1c299c25 100644
--- a/fs/xfs/libxfs/xfs_btree.c
+++ b/fs/xfs/libxfs/xfs_btree.c
@@ -3557,14 +3557,31 @@ xfs_btree_insrec(
 	xfs_btree_log_block(cur, bp, XFS_BB_NUMRECS);
 
 	/*
-	 * If we just inserted into a new tree block, we have to
-	 * recalculate nkey here because nkey is out of date.
+	 * Update btree keys to reflect the newly added record or keyptr.
+	 * There are three cases here to be aware of.  Normally, all we have to
+	 * do is walk towards the root, updating keys as necessary.
 	 *
-	 * Otherwise we're just updating an existing block (having shoved
-	 * some records into the new tree block), so use the regular key
-	 * update mechanism.
+	 * If the caller had us target a full block for the insertion, we dealt
+	 * with that by calling the _make_block_unfull function.  If the
+	 * "make unfull" function splits the block, it'll hand us back the key
+	 * and pointer of the new block.  We haven't yet added the new block to
+	 * the next level up, so if we decide to add the new record to the new
+	 * block (bp->b_bn != old_bn), we have to update the caller's pointer
+	 * so that the caller adds the new block with the correct key.
+	 *
+	 * However, there is a third possibility-- if the selected block is the
+	 * root block of an inode-rooted btree and cannot be expanded further,
+	 * the "make unfull" function moves the root block contents to a new
+	 * block and updates the root block to point to the new block.  In this
+	 * case, no block pointer is passed back because the block has already
+	 * been added to the btree.  In this case, we need to use the regular
+	 * key update function, just like the first case.  This is critical for
+	 * overlapping btrees, because the high key must be updated to reflect
+	 * the entire tree, not just the subtree accessible through the first
+	 * child of the root (which is now two levels down from the root).
 	 */
-	if (bp && xfs_buf_daddr(bp) != old_bn) {
+	if (!xfs_btree_ptr_is_null(cur, &nptr) &&
+	    bp && xfs_buf_daddr(bp) != old_bn) {
 		xfs_btree_get_keys(cur, block, lkey);
 	} else if (xfs_btree_needs_key_update(cur, optr)) {
 		error = xfs_btree_update_keys(cur, level);


