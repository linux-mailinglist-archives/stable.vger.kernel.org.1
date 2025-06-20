Return-Path: <stable+bounces-154937-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B005DAE1502
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 09:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BD404A0D68
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 07:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18231F8756;
	Fri, 20 Jun 2025 07:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="P9kwY2vd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6B117583
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 07:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750404835; cv=none; b=BY8LqyLLiZNBFWLLQ0hNteelHXLO7N/22eVpjfU8HUnNAs/MAkSjaP79mE8KK70KOT4lAObsQCdZ6yfZvo8Nd+Blgd8wmsEL58O9klGm8Z4uAamPCYEQ/5aSynCV0hF89DT8qG1hda2f3ZCS5MIuYH6UQZeAmu92oZHC4CJcRew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750404835; c=relaxed/simple;
	bh=hA0QJz6iDvlBG0iXDGbxUa65PLZoN4CD8MvjVbyw3DM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=JTZTPeo/XOQol/T4sUKGsVYQko2u446Dg/6jfSYIN1c09jJKruNm/RZ/qoFA3SBWaAIZNc0xmd4f1QW6ZD4HkGcIx9GN5eCXHExqzOOGrhcctAKXeEmrX1yDkfbG0fAcOE/ShtuKox2HmgofAuBhUVdZg2ffoMqUBX27ZJt8yxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=P9kwY2vd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF6FCC4CEE3;
	Fri, 20 Jun 2025 07:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750404835;
	bh=hA0QJz6iDvlBG0iXDGbxUa65PLZoN4CD8MvjVbyw3DM=;
	h=Subject:To:Cc:From:Date:From;
	b=P9kwY2vdqDC75nSzyo+au1JFYnhW/KjhJHYNgJaNSxE5YmgKNRNRvZzb20e/hAuTK
	 xf51Ei/U7D61qxQvvfYb6I2NqW1k4Kn+mvpoisGEAnfz1IjA+wvgcJHF+fx8o82/3m
	 gSoFCgQFkM0pMBKb4roQtsM94ah3OoxnwxWmz/R8=
Subject: FAILED: patch "[PATCH] jbd2: fix data-race and null-ptr-deref in" failed to apply to 5.4-stable tree
To: aha310510@gmail.com,jack@suse.cz,tytso@mit.edu
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 20 Jun 2025 09:33:52 +0200
Message-ID: <2025062052-vigorous-overlaid-8bec@gregkh>
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
git cherry-pick -x af98b0157adf6504fade79b3e6cb260c4ff68e37
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062052-vigorous-overlaid-8bec@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From af98b0157adf6504fade79b3e6cb260c4ff68e37 Mon Sep 17 00:00:00 2001
From: Jeongjun Park <aha310510@gmail.com>
Date: Wed, 14 May 2025 22:08:55 +0900
Subject: [PATCH] jbd2: fix data-race and null-ptr-deref in
 jbd2_journal_dirty_metadata()

Since handle->h_transaction may be a NULL pointer, so we should change it
to call is_handle_aborted(handle) first before dereferencing it.

And the following data-race was reported in my fuzzer:

==================================================================
BUG: KCSAN: data-race in jbd2_journal_dirty_metadata / jbd2_journal_dirty_metadata

write to 0xffff888011024104 of 4 bytes by task 10881 on cpu 1:
 jbd2_journal_dirty_metadata+0x2a5/0x770 fs/jbd2/transaction.c:1556
 __ext4_handle_dirty_metadata+0xe7/0x4b0 fs/ext4/ext4_jbd2.c:358
 ext4_do_update_inode fs/ext4/inode.c:5220 [inline]
 ext4_mark_iloc_dirty+0x32c/0xd50 fs/ext4/inode.c:5869
 __ext4_mark_inode_dirty+0xe1/0x450 fs/ext4/inode.c:6074
 ext4_dirty_inode+0x98/0xc0 fs/ext4/inode.c:6103
....

read to 0xffff888011024104 of 4 bytes by task 10880 on cpu 0:
 jbd2_journal_dirty_metadata+0xf2/0x770 fs/jbd2/transaction.c:1512
 __ext4_handle_dirty_metadata+0xe7/0x4b0 fs/ext4/ext4_jbd2.c:358
 ext4_do_update_inode fs/ext4/inode.c:5220 [inline]
 ext4_mark_iloc_dirty+0x32c/0xd50 fs/ext4/inode.c:5869
 __ext4_mark_inode_dirty+0xe1/0x450 fs/ext4/inode.c:6074
 ext4_dirty_inode+0x98/0xc0 fs/ext4/inode.c:6103
....

value changed: 0x00000000 -> 0x00000001
==================================================================

This issue is caused by missing data-race annotation for jh->b_modified.
Therefore, the missing annotation needs to be added.

Reported-by: syzbot+de24c3fe3c4091051710@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=de24c3fe3c4091051710
Fixes: 6e06ae88edae ("jbd2: speedup jbd2_journal_dirty_metadata()")
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://patch.msgid.link/20250514130855.99010-1-aha310510@gmail.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@kernel.org

diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index cbc4785462f5..c7867139af69 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -1509,7 +1509,7 @@ int jbd2_journal_dirty_metadata(handle_t *handle, struct buffer_head *bh)
 				jh->b_next_transaction == transaction);
 		spin_unlock(&jh->b_state_lock);
 	}
-	if (jh->b_modified == 1) {
+	if (data_race(jh->b_modified == 1)) {
 		/* If it's in our transaction it must be in BJ_Metadata list. */
 		if (data_race(jh->b_transaction == transaction &&
 		    jh->b_jlist != BJ_Metadata)) {
@@ -1528,7 +1528,6 @@ int jbd2_journal_dirty_metadata(handle_t *handle, struct buffer_head *bh)
 		goto out;
 	}
 
-	journal = transaction->t_journal;
 	spin_lock(&jh->b_state_lock);
 
 	if (is_handle_aborted(handle)) {
@@ -1543,6 +1542,8 @@ int jbd2_journal_dirty_metadata(handle_t *handle, struct buffer_head *bh)
 		goto out_unlock_bh;
 	}
 
+	journal = transaction->t_journal;
+
 	if (jh->b_modified == 0) {
 		/*
 		 * This buffer's got modified and becoming part


