Return-Path: <stable+bounces-171558-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 633DAB2AA40
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 16:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15B705A375D
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 14:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345133376A7;
	Mon, 18 Aug 2025 14:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uD6eE6lU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58A131CA62;
	Mon, 18 Aug 2025 14:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755526338; cv=none; b=ZcG5k0VjwvyZTRTxMRx6cUXx5jUKsWaO4sbqe9CaCDvp9GDYcjAMKnt3AgjnhoF+ATEdoyftBSgDRwC6RHw9FI7hrs9I7FDIW1RVXvmVb973JsaD67uTqeX+BXziYDyCkSNAEKmqiq50lBgU48vNjMD50q96f/Ks2u8Qi7ditYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755526338; c=relaxed/simple;
	bh=JadKqP8lX1r5AUIL069c9vVao6QponhCCnGQ0KPcpV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MT4ltp7KbHJk5PKFpoXyW1gGTSCClhH0azvZSRzuGJPyz9iztx/Aa/pqbOnyEXJS0QvrCJ6MVaTX8n1K7O5VQTyoJhCbhYyB4z+5x0bgT1Va3JJjJgfLHQCOnwhS2Ub/lB3NafFrSnXrUykppFvnCJmNbNo2edMjzimSvQjB9DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uD6eE6lU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFCD2C4CEEB;
	Mon, 18 Aug 2025 14:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755526338;
	bh=JadKqP8lX1r5AUIL069c9vVao6QponhCCnGQ0KPcpV8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uD6eE6lU1Gkmm8vIMPrT6vo1B2/g+g6GD7oRbRxy0YT/os4pB60adXeGtExgF/Jdk
	 kK3Osmv4SGzko8CX36ShQmR5nsFaU8hdqhQoD7xNllsNqA2nM3IBJ8zFWgzf/Ifgc2
	 M11rBzT6WkImTM76C1UQ/Ppm+w6sVSWfZ4kdx5DY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Peter Jung <ptr1337@cachyos.org>,
	burneddi <burneddi@protonmail.com>,
	Russell Haley <yumpusamongus@gmail.com>,
	Boris Burkov <boris@bur.io>,
	Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>
Subject: [PATCH 6.16 527/570] btrfs: fix log tree replay failure due to file with 0 links and extents
Date: Mon, 18 Aug 2025 14:48:34 +0200
Message-ID: <20250818124526.168797108@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818124505.781598737@linuxfoundation.org>
References: <20250818124505.781598737@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Filipe Manana <fdmanana@suse.com>

commit 0a32e4f0025a74c70dcab4478e9b29c22f5ecf2f upstream.

If we log a new inode (not persisted in a past transaction) that has 0
links and extents, then log another inode with an higher inode number, we
end up with failing to replay the log tree with -EINVAL. The steps for
this are:

1) create new file A
2) write some data to file A
3) open an fd on file A
4) unlink file A
5) fsync file A using the previously open fd
6) create file B (has higher inode number than file A)
7) fsync file B
8) power fail before current transaction commits

Now when attempting to mount the fs, the log replay will fail with
-ENOENT at replay_one_extent() when attempting to replay the first
extent of file A. The failure comes when trying to open the inode for
file A in the subvolume tree, since it doesn't exist.

Before commit 5f61b961599a ("btrfs: fix inode lookup error handling
during log replay"), the returned error was -EIO instead of -ENOENT,
since we converted any errors when attempting to read an inode during
log replay to -EIO.

The reason for this is that the log replay procedure fails to ignore
the current inode when we are at the stage LOG_WALK_REPLAY_ALL, our
current inode has 0 links and last inode we processed in the previous
stage has a non 0 link count. In other words, the issue is that at
replay_one_extent() we only update wc->ignore_cur_inode if the current
replay stage is LOG_WALK_REPLAY_INODES.

Fix this by updating wc->ignore_cur_inode whenever we find an inode item
regardless of the current replay stage. This is a simple solution and easy
to backport, but later we can do other alternatives like avoid logging
extents or inode items other than the inode item for inodes with a link
count of 0.

The problem with the wc->ignore_cur_inode logic has been around since
commit f2d72f42d5fa ("Btrfs: fix warning when replaying log after fsync
of a tmpfile") but it only became frequent to hit since the more recent
commit 5e85262e542d ("btrfs: fix fsync of files with no hard links not
persisting deletion"), because we stopped skipping inodes with a link
count of 0 when logging, while before the problem would only be triggered
if trying to replay a log tree created with an older kernel which has a
logged inode with 0 links.

A test case for fstests will be submitted soon.

Reported-by: Peter Jung <ptr1337@cachyos.org>
Link: https://lore.kernel.org/linux-btrfs/fce139db-4458-4788-bb97-c29acf6cb1df@cachyos.org/
Reported-by: burneddi <burneddi@protonmail.com>
Link: https://lore.kernel.org/linux-btrfs/lh4W-Lwc0Mbk-QvBhhQyZxf6VbM3E8VtIvU3fPIQgweP_Q1n7wtlUZQc33sYlCKYd-o6rryJQfhHaNAOWWRKxpAXhM8NZPojzsJPyHMf2qY=@protonmail.com/#t
Reported-by: Russell Haley <yumpusamongus@gmail.com>
Link: https://lore.kernel.org/linux-btrfs/598ecc75-eb80-41b3-83c2-f2317fbb9864@gmail.com/
Fixes: f2d72f42d5fa ("Btrfs: fix warning when replaying log after fsync of a tmpfile")
CC: stable@vger.kernel.org # 5.4+
Reviewed-by: Boris Burkov <boris@bur.io>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/tree-log.c |   48 ++++++++++++++++++++++++++++++------------------
 1 file changed, 30 insertions(+), 18 deletions(-)

--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -321,8 +321,7 @@ struct walk_control {
 
 	/*
 	 * Ignore any items from the inode currently being processed. Needs
-	 * to be set every time we find a BTRFS_INODE_ITEM_KEY and we are in
-	 * the LOG_WALK_REPLAY_INODES stage.
+	 * to be set every time we find a BTRFS_INODE_ITEM_KEY.
 	 */
 	bool ignore_cur_inode;
 
@@ -2434,23 +2433,30 @@ static int replay_one_buffer(struct btrf
 
 	nritems = btrfs_header_nritems(eb);
 	for (i = 0; i < nritems; i++) {
-		btrfs_item_key_to_cpu(eb, &key, i);
+		struct btrfs_inode_item *inode_item;
 
-		/* inode keys are done during the first stage */
-		if (key.type == BTRFS_INODE_ITEM_KEY &&
-		    wc->stage == LOG_WALK_REPLAY_INODES) {
-			struct btrfs_inode_item *inode_item;
-			u32 mode;
+		btrfs_item_key_to_cpu(eb, &key, i);
 
-			inode_item = btrfs_item_ptr(eb, i,
-					    struct btrfs_inode_item);
+		if (key.type == BTRFS_INODE_ITEM_KEY) {
+			inode_item = btrfs_item_ptr(eb, i, struct btrfs_inode_item);
 			/*
-			 * If we have a tmpfile (O_TMPFILE) that got fsync'ed
-			 * and never got linked before the fsync, skip it, as
-			 * replaying it is pointless since it would be deleted
-			 * later. We skip logging tmpfiles, but it's always
-			 * possible we are replaying a log created with a kernel
-			 * that used to log tmpfiles.
+			 * An inode with no links is either:
+			 *
+			 * 1) A tmpfile (O_TMPFILE) that got fsync'ed and never
+			 *    got linked before the fsync, skip it, as replaying
+			 *    it is pointless since it would be deleted later.
+			 *    We skip logging tmpfiles, but it's always possible
+			 *    we are replaying a log created with a kernel that
+			 *    used to log tmpfiles;
+			 *
+			 * 2) A non-tmpfile which got its last link deleted
+			 *    while holding an open fd on it and later got
+			 *    fsynced through that fd. We always log the
+			 *    parent inodes when inode->last_unlink_trans is
+			 *    set to the current transaction, so ignore all the
+			 *    inode items for this inode. We will delete the
+			 *    inode when processing the parent directory with
+			 *    replay_dir_deletes().
 			 */
 			if (btrfs_inode_nlink(eb, inode_item) == 0) {
 				wc->ignore_cur_inode = true;
@@ -2458,8 +2464,14 @@ static int replay_one_buffer(struct btrf
 			} else {
 				wc->ignore_cur_inode = false;
 			}
-			ret = replay_xattr_deletes(wc->trans, root, log,
-						   path, key.objectid);
+		}
+
+		/* Inode keys are done during the first stage. */
+		if (key.type == BTRFS_INODE_ITEM_KEY &&
+		    wc->stage == LOG_WALK_REPLAY_INODES) {
+			u32 mode;
+
+			ret = replay_xattr_deletes(wc->trans, root, log, path, key.objectid);
 			if (ret)
 				break;
 			mode = btrfs_inode_mode(eb, inode_item);



