Return-Path: <stable+bounces-106268-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 546F89FE3CB
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 09:39:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11B9D161E9E
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 08:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557F61A0BC9;
	Mon, 30 Dec 2024 08:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ywjZ27Ls"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142E91A0B12
	for <stable@vger.kernel.org>; Mon, 30 Dec 2024 08:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735547980; cv=none; b=lrybzthEATKbVVOP47lzgiwlJrER5ydX1P864hFU0gX+Jo6eMnE8pyKcrAkG35kfXZV4syTZ9GGS8NVz9rCZgWz/lUeT4HI4lRmH0eCjskDr9xtK4Pj1tWRrzJrunY/XjvSsEz4N/VB87QglQnwzENaQOIkJySK4WuEmzsSnJxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735547980; c=relaxed/simple;
	bh=meZH4pTUmkJYPq+Pp5jT02IHkbj+BPa6c9bGbneCZ7g=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=r0S6jCXIZBNfdK7CNrPwCzXljhDrBjpC2KUKbfqBuO+pRTwG6F3mXnx+65b9oJmwva8HKE2MB9QbLrRm175wu1+3NyC1/oGwKUA1jTWj++Hv8AMfavbI6oykrTlr/XZJ1Qow4VhnOgS8Xu12UOqWm2fAk828QIPU03M8AG7pGrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ywjZ27Ls; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8508AC4CED0;
	Mon, 30 Dec 2024 08:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1735547979;
	bh=meZH4pTUmkJYPq+Pp5jT02IHkbj+BPa6c9bGbneCZ7g=;
	h=Subject:To:Cc:From:Date:From;
	b=ywjZ27LsY0YLayCTxP0op1nr1Yb4DBc7QHZcYLCikD6AcCowjVONNKbjJ4FPt235S
	 oAOTDKdLPvp8pF1l/hTXnNpdH55+E/x1h+SrECcp4ZlFU7jEfVQtAXVMknNsXYB+kV
	 l0ifVtHuFy4bsHr1FAcPnbqkBjzVfu5QHE0yPb3g=
Subject: FAILED: patch "[PATCH] btrfs: fix use-after-free when COWing tree bock and tracing" failed to apply to 5.4-stable tree
To: fdmanana@suse.com,dsterba@suse.com,wqu@suse.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 30 Dec 2024 09:39:28 +0100
Message-ID: <2024123027-yeah-suitcase-41e7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 44f52bbe96dfdbe4aca3818a2534520082a07040
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024123027-yeah-suitcase-41e7@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 44f52bbe96dfdbe4aca3818a2534520082a07040 Mon Sep 17 00:00:00 2001
From: Filipe Manana <fdmanana@suse.com>
Date: Wed, 11 Dec 2024 16:08:07 +0000
Subject: [PATCH] btrfs: fix use-after-free when COWing tree bock and tracing
 is enabled

When a COWing a tree block, at btrfs_cow_block(), and we have the
tracepoint trace_btrfs_cow_block() enabled and preemption is also enabled
(CONFIG_PREEMPT=y), we can trigger a use-after-free in the COWed extent
buffer while inside the tracepoint code. This is because in some paths
that call btrfs_cow_block(), such as btrfs_search_slot(), we are holding
the last reference on the extent buffer @buf so btrfs_force_cow_block()
drops the last reference on the @buf extent buffer when it calls
free_extent_buffer_stale(buf), which schedules the release of the extent
buffer with RCU. This means that if we are on a kernel with preemption,
the current task may be preempted before calling trace_btrfs_cow_block()
and the extent buffer already released by the time trace_btrfs_cow_block()
is called, resulting in a use-after-free.

Fix this by moving the trace_btrfs_cow_block() from btrfs_cow_block() to
btrfs_force_cow_block() before the COWed extent buffer is freed.
This also has a side effect of invoking the tracepoint in the tree defrag
code, at defrag.c:btrfs_realloc_node(), since btrfs_force_cow_block() is
called there, but this is fine and it was actually missing there.

Reported-by: syzbot+8517da8635307182c8a5@syzkaller.appspotmail.com
Link: https://lore.kernel.org/linux-btrfs/6759a9b9.050a0220.1ac542.000d.GAE@google.com/
CC: stable@vger.kernel.org # 5.4+
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 693dc27ffb89..185985a337b3 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -654,6 +654,8 @@ int btrfs_force_cow_block(struct btrfs_trans_handle *trans,
 			goto error_unlock_cow;
 		}
 	}
+
+	trace_btrfs_cow_block(root, buf, cow);
 	if (unlock_orig)
 		btrfs_tree_unlock(buf);
 	free_extent_buffer_stale(buf);
@@ -710,7 +712,6 @@ int btrfs_cow_block(struct btrfs_trans_handle *trans,
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	u64 search_start;
-	int ret;
 
 	if (unlikely(test_bit(BTRFS_ROOT_DELETING, &root->state))) {
 		btrfs_abort_transaction(trans, -EUCLEAN);
@@ -751,12 +752,8 @@ int btrfs_cow_block(struct btrfs_trans_handle *trans,
 	 * Also We don't care about the error, as it's handled internally.
 	 */
 	btrfs_qgroup_trace_subtree_after_cow(trans, root, buf);
-	ret = btrfs_force_cow_block(trans, root, buf, parent, parent_slot,
-				    cow_ret, search_start, 0, nest);
-
-	trace_btrfs_cow_block(root, buf, *cow_ret);
-
-	return ret;
+	return btrfs_force_cow_block(trans, root, buf, parent, parent_slot,
+				     cow_ret, search_start, 0, nest);
 }
 ALLOW_ERROR_INJECTION(btrfs_cow_block, ERRNO);
 


