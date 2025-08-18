Return-Path: <stable+bounces-169958-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5726DB29E90
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 11:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 051D81702CC
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 09:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B84230FF20;
	Mon, 18 Aug 2025 09:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tmiJjo1c"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C70530FF1D
	for <stable@vger.kernel.org>; Mon, 18 Aug 2025 09:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755511019; cv=none; b=JfKLF/CLkbS+GXwh5RmJq0wZToyxVAfaxAV63Y0cyrQRT/5ZYvggNmMzJCGJ61sEbGfG94HtK6n8CV5Ig9E5kloSW60Ht+Sk0lv6DFRPLA9ao7/+QxedKOeZv2Vr7YDA7VCtOhg+UvPIH5rzjtj/aroZwL1Zc6+Zxavm15BjHwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755511019; c=relaxed/simple;
	bh=8xl2U/oqt8pd8SqfGOeOThtSHeaulPbD38qPw+MGOL8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=O1mh2IoJlm9OiP7VDKk9Q0RHLdW+3zY0h85TdYNMkQSpqiGffgznDsi/Mjnj52jldk01fL2S1IYGv6fOuNTx93WqAiOBRrS9absxkNvmq2+jxYUUynPXTpbj3u2EZX+g8e8oWYgbI9k4WVW9LSF2jAoCAP/j17DiPaHsyQn9UrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tmiJjo1c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66A34C4CEEB;
	Mon, 18 Aug 2025 09:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755511018;
	bh=8xl2U/oqt8pd8SqfGOeOThtSHeaulPbD38qPw+MGOL8=;
	h=Subject:To:Cc:From:Date:From;
	b=tmiJjo1c3i95hw1DyuH5P2MK4aNOyht3SNviTFp2JEeqEcGGY/1Gjyj74Asisv0dN
	 xPAnVNXlw81Cvp5BZEAfiYsGXrjMpPYnB+IIvzUn6T25zppTEhiiBzHxYhBdKuuq/2
	 /BKBTtfSkodI/LRwe+ToOQ5o5cvZ7of3pFDYeF9E=
Subject: FAILED: patch "[PATCH] ext4: fix zombie groups in average fragment size lists" failed to apply to 5.15-stable tree
To: libaokun1@huawei.com,jack@suse.cz,tytso@mit.edu,yi.zhang@huawei.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 18 Aug 2025 11:56:55 +0200
Message-ID: <2025081855-sensation-survivor-0dde@gregkh>
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
git cherry-pick -x 1c320d8e92925bb7615f83a7b6e3f402a5c2ca63
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025081855-sensation-survivor-0dde@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1c320d8e92925bb7615f83a7b6e3f402a5c2ca63 Mon Sep 17 00:00:00 2001
From: Baokun Li <libaokun1@huawei.com>
Date: Mon, 14 Jul 2025 21:03:20 +0800
Subject: [PATCH] ext4: fix zombie groups in average fragment size lists

Groups with no free blocks shouldn't be in any average fragment size list.
However, when all blocks in a group are allocated(i.e., bb_fragments or
bb_free is 0), we currently skip updating the average fragment size, which
means the group isn't removed from its previous s_mb_avg_fragment_size[old]
list.

This created "zombie" groups that were always skipped during traversal as
they couldn't satisfy any block allocation requests, negatively impacting
traversal efficiency.

Therefore, when a group becomes completely full, bb_avg_fragment_size_order
is now set to -1. If the old order was not -1, a removal operation is
performed; if the new order is not -1, an insertion is performed.

Fixes: 196e402adf2e ("ext4: improve cr 0 / cr 1 group scanning")
CC: stable@vger.kernel.org
Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
Link: https://patch.msgid.link/20250714130327.1830534-11-libaokun1@huawei.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 6d98f2a5afc4..72b20fc52bbf 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -841,30 +841,30 @@ static void
 mb_update_avg_fragment_size(struct super_block *sb, struct ext4_group_info *grp)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
-	int new_order;
+	int new, old;
 
-	if (!test_opt2(sb, MB_OPTIMIZE_SCAN) || grp->bb_fragments == 0)
+	if (!test_opt2(sb, MB_OPTIMIZE_SCAN))
 		return;
 
-	new_order = mb_avg_fragment_size_order(sb,
-					grp->bb_free / grp->bb_fragments);
-	if (new_order == grp->bb_avg_fragment_size_order)
+	old = grp->bb_avg_fragment_size_order;
+	new = grp->bb_fragments == 0 ? -1 :
+	      mb_avg_fragment_size_order(sb, grp->bb_free / grp->bb_fragments);
+	if (new == old)
 		return;
 
-	if (grp->bb_avg_fragment_size_order != -1) {
-		write_lock(&sbi->s_mb_avg_fragment_size_locks[
-					grp->bb_avg_fragment_size_order]);
+	if (old >= 0) {
+		write_lock(&sbi->s_mb_avg_fragment_size_locks[old]);
 		list_del(&grp->bb_avg_fragment_size_node);
-		write_unlock(&sbi->s_mb_avg_fragment_size_locks[
-					grp->bb_avg_fragment_size_order]);
+		write_unlock(&sbi->s_mb_avg_fragment_size_locks[old]);
+	}
+
+	grp->bb_avg_fragment_size_order = new;
+	if (new >= 0) {
+		write_lock(&sbi->s_mb_avg_fragment_size_locks[new]);
+		list_add_tail(&grp->bb_avg_fragment_size_node,
+				&sbi->s_mb_avg_fragment_size[new]);
+		write_unlock(&sbi->s_mb_avg_fragment_size_locks[new]);
 	}
-	grp->bb_avg_fragment_size_order = new_order;
-	write_lock(&sbi->s_mb_avg_fragment_size_locks[
-					grp->bb_avg_fragment_size_order]);
-	list_add_tail(&grp->bb_avg_fragment_size_node,
-		&sbi->s_mb_avg_fragment_size[grp->bb_avg_fragment_size_order]);
-	write_unlock(&sbi->s_mb_avg_fragment_size_locks[
-					grp->bb_avg_fragment_size_order]);
 }
 
 /*


