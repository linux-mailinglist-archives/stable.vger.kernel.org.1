Return-Path: <stable+bounces-20586-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E7185A881
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 17:17:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83E9A1C22CFC
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 16:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B805B3B7A9;
	Mon, 19 Feb 2024 16:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IAX25bUz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2493737704
	for <stable@vger.kernel.org>; Mon, 19 Feb 2024 16:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708359432; cv=none; b=rdxTkIbOubiXEShwGszp90YJTBbWm5enc/n7LGrXvuvqnyRH5PFLj3QidWIQphiLzhShjjv4totfjoeqcgdfPyTacrNJafS/6Th42vPVCOxzTjxQMndXhxr/504mfYjitE+y9NgEGHALCx00qUqIeOrw0BEFu2r+eDHkrGIpgtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708359432; c=relaxed/simple;
	bh=zUWOt+OPWTY2eIUSI3xWKIU5X0EtvP+ZaMD3OQRLFw4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=kR2EJ7lk6rS+qlrpmGcX4WIBcVxnooA5w1Yu4iGxtRM0f9xKjkx/7gD6r2BE+oVh7gu7lhclZaRvNBvASbEReqASEtP0BIAtqM5gEbVw9jJ3sMS8C0YT6YTRVv1qaEDSXi89OuQPN9pDKgTQO+65jwTEEDj+H0dFjGgOPv/3jw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IAX25bUz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E8F0C433F1;
	Mon, 19 Feb 2024 16:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708359431;
	bh=zUWOt+OPWTY2eIUSI3xWKIU5X0EtvP+ZaMD3OQRLFw4=;
	h=Subject:To:Cc:From:Date:From;
	b=IAX25bUzgM8xWYpDz7prwBSgwzPmFEr94ra1Ew1kdMhbisj4OozHGAF9sGvCItM7q
	 omNxg4KLYGoQ3MFkoYpjc6fLUH3KDZpSLI8eWeAZD7JGJYOL6OnTuzqAb+yWehVm97
	 jJBaocS+TjF7qctG0CL9lLaNthzNv3VZUWMlKnQc=
Subject: FAILED: patch "[PATCH] ext4: avoid bb_free and bb_fragments inconsistency in" failed to apply to 5.15-stable tree
To: libaokun1@huawei.com,jack@suse.cz,stable@vger.kernel.org,tytso@mit.edu
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Feb 2024 17:17:08 +0100
Message-ID: <2024021908-deferred-oppose-2c8f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 2331fd4a49864e1571b4f50aa3aa1536ed6220d0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024021908-deferred-oppose-2c8f@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

2331fd4a4986 ("ext4: avoid bb_free and bb_fragments inconsistency in mb_free_blocks()")
c9b528c35795 ("ext4: regenerate buddy after block freeing failed if under fc replay")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2331fd4a49864e1571b4f50aa3aa1536ed6220d0 Mon Sep 17 00:00:00 2001
From: Baokun Li <libaokun1@huawei.com>
Date: Thu, 4 Jan 2024 22:20:36 +0800
Subject: [PATCH] ext4: avoid bb_free and bb_fragments inconsistency in
 mb_free_blocks()

After updating bb_free in mb_free_blocks, it is possible to return without
updating bb_fragments because the block being freed is found to have
already been freed, which leads to inconsistency between bb_free and
bb_fragments.

Since the group may be unlocked in ext4_grp_locked_error(), this can lead
to problems such as dividing by zero when calculating the average fragment
length. Hence move the update of bb_free to after the block double-free
check guarantees that the corresponding statistics are updated only after
the core block bitmap is modified.

Fixes: eabe0444df90 ("ext4: speed-up releasing blocks on commit")
CC:  <stable@vger.kernel.org> # 3.10
Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20240104142040.2835097-5-libaokun1@huawei.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index c97ad0e77831..fa351aa323dc 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -1909,11 +1909,6 @@ static void mb_free_blocks(struct inode *inode, struct ext4_buddy *e4b,
 	mb_check_buddy(e4b);
 	mb_free_blocks_double(inode, e4b, first, count);
 
-	this_cpu_inc(discard_pa_seq);
-	e4b->bd_info->bb_free += count;
-	if (first < e4b->bd_info->bb_first_free)
-		e4b->bd_info->bb_first_free = first;
-
 	/* access memory sequentially: check left neighbour,
 	 * clear range and then check right neighbour
 	 */
@@ -1927,23 +1922,31 @@ static void mb_free_blocks(struct inode *inode, struct ext4_buddy *e4b,
 		struct ext4_sb_info *sbi = EXT4_SB(sb);
 		ext4_fsblk_t blocknr;
 
+		/*
+		 * Fastcommit replay can free already freed blocks which
+		 * corrupts allocation info. Regenerate it.
+		 */
+		if (sbi->s_mount_state & EXT4_FC_REPLAY) {
+			mb_regenerate_buddy(e4b);
+			goto check;
+		}
+
 		blocknr = ext4_group_first_block_no(sb, e4b->bd_group);
 		blocknr += EXT4_C2B(sbi, block);
-		if (!(sbi->s_mount_state & EXT4_FC_REPLAY)) {
-			ext4_grp_locked_error(sb, e4b->bd_group,
-					      inode ? inode->i_ino : 0,
-					      blocknr,
-					      "freeing already freed block (bit %u); block bitmap corrupt.",
-					      block);
-			ext4_mark_group_bitmap_corrupted(
-				sb, e4b->bd_group,
+		ext4_grp_locked_error(sb, e4b->bd_group,
+				      inode ? inode->i_ino : 0, blocknr,
+				      "freeing already freed block (bit %u); block bitmap corrupt.",
+				      block);
+		ext4_mark_group_bitmap_corrupted(sb, e4b->bd_group,
 				EXT4_GROUP_INFO_BBITMAP_CORRUPT);
-		} else {
-			mb_regenerate_buddy(e4b);
-		}
-		goto done;
+		return;
 	}
 
+	this_cpu_inc(discard_pa_seq);
+	e4b->bd_info->bb_free += count;
+	if (first < e4b->bd_info->bb_first_free)
+		e4b->bd_info->bb_first_free = first;
+
 	/* let's maintain fragments counter */
 	if (left_is_free && right_is_free)
 		e4b->bd_info->bb_fragments--;
@@ -1968,9 +1971,9 @@ static void mb_free_blocks(struct inode *inode, struct ext4_buddy *e4b,
 	if (first <= last)
 		mb_buddy_mark_free(e4b, first >> 1, last >> 1);
 
-done:
 	mb_set_largest_free_order(sb, e4b->bd_info);
 	mb_update_avg_fragment_size(sb, e4b->bd_info);
+check:
 	mb_check_buddy(e4b);
 }
 


