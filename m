Return-Path: <stable+bounces-20587-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA8A885A883
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 17:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89BADB22BEA
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 16:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF923CF56;
	Mon, 19 Feb 2024 16:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Zke7Awqy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77E63A29A
	for <stable@vger.kernel.org>; Mon, 19 Feb 2024 16:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708359441; cv=none; b=rn60iGlgb8mxdCNfq5HX+Vn+pQaJ54Gb5mOaTaMfJz6ZwlbOrtLVT2dASfJxgPXt9zFkYAnuiAdO6tiqf2epOP7GmRRsmbvuvIiP03Pa+1UeQaBYeBIYBJHN3eMKNw8V1Z/ZOOoiPzykYxeX9QO6koceO5i5qrynVB6b1xpBWNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708359441; c=relaxed/simple;
	bh=XHeDviC1jUNOG/WmcsND7dL5kFdlviJZi56I6RVT3rw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=kG17jpOB7dsILQ5pwNcTv5gUkH8b9fBjYDB5roidqyjRYww4VFIn3ZAnJZyWG6d1X3+YGe5kB7A+vpsLz3JEiXpPD4/vGSazZjSmwGv6SjAQH9sRgKx1Th4cS6BCgXwjsFFT1IuyBNTi4Le+1kVGJzljwWoo0yaBdaxg8brJ4lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Zke7Awqy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 174ADC433F1;
	Mon, 19 Feb 2024 16:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708359440;
	bh=XHeDviC1jUNOG/WmcsND7dL5kFdlviJZi56I6RVT3rw=;
	h=Subject:To:Cc:From:Date:From;
	b=Zke7Awqyd2azWSfMyDXtyu/8LxkbOdjdzcI+9kcSBI1iYhNQFN6x22ZrkHRk+0tCZ
	 v2QruxkfliD5+UeINPnNldV6xe1Y8OAeJKvvg/gOmAmSY+yX6jWk2xzghghV2fOWsQ
	 5t0kx6e8tHxc9x30IHFV613fgr+ZcfEqLl1oP4kw=
Subject: FAILED: patch "[PATCH] ext4: avoid bb_free and bb_fragments inconsistency in" failed to apply to 5.10-stable tree
To: libaokun1@huawei.com,jack@suse.cz,stable@vger.kernel.org,tytso@mit.edu
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Feb 2024 17:17:09 +0100
Message-ID: <2024021909-marmalade-causal-dfed@gregkh>
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
git cherry-pick -x 2331fd4a49864e1571b4f50aa3aa1536ed6220d0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024021909-marmalade-causal-dfed@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

2331fd4a4986 ("ext4: avoid bb_free and bb_fragments inconsistency in mb_free_blocks()")
c9b528c35795 ("ext4: regenerate buddy after block freeing failed if under fc replay")
196e402adf2e ("ext4: improve cr 0 / cr 1 group scanning")
4b68f6df1059 ("ext4: add MB_NUM_ORDERS macro")
a6c75eaf1103 ("ext4: add mballoc stats proc file")
b237e3044450 ("ext4: add ability to return parsed options from parse_options")
67d251860461 ("ext4: drop s_mb_bal_lock and convert protected fields to atomic")
6bd97bf273bd ("ext4: remove redundant mb_regenerate_buddy()")

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
 


