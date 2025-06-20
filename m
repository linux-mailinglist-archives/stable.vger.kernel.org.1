Return-Path: <stable+bounces-154988-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC34DAE15E7
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 10:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC5095A4BFD
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 08:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6667C2367B6;
	Fri, 20 Jun 2025 08:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tr+zUeDI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2650A2367B3
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 08:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750408053; cv=none; b=Gqs6Ng/GU5o48uMAZ6n34XVa0QECKVJJEBF0+iRNN5SZH/lB1StMnnrIxx8CjA+vobAvo3Fxu3YEIfqyk88/IhnNdrkIIb6WnvcDST3DLuI+9MshqcYdZnud3oTv9qlpPnx+XeyYONXHoG1a9H3zySpDrp0mlcofY07PnzXEKoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750408053; c=relaxed/simple;
	bh=hYnba7OffPDIAs20jdxiyLXCHR+PkV94Y3g6jaMnS5M=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=WlgYzpZvPL/ETMIrw/I4cqWEmNBEgVrRmGgcqBlgpdZDmvc6bHICBs3nNOyCKiUesncWutcb2exYNYZEq9F6MDCrnF8BvvfN1vYTXIUPYtn7bvbJlCNLTwXD/BXHpLbFYqFZ6I7pEttKbaj41k71RfzDK35G68TX/1Hh0Fp8Tsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tr+zUeDI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2863C4CEE3;
	Fri, 20 Jun 2025 08:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750408053;
	bh=hYnba7OffPDIAs20jdxiyLXCHR+PkV94Y3g6jaMnS5M=;
	h=Subject:To:Cc:From:Date:From;
	b=tr+zUeDI7CtyXgzn0IyYpl1bUztnoj2wN5Uyzrfox053t+/ADoI8Mvn8ZCjLfHpWc
	 py2v5/f4N/IJucrjxc9ZT4mqhE1UZSL57uPyS9B771GYb8zaFLcIIq+QDajrmytS8L
	 jLycVbVFeAHqY1xrJyVhT3HWoYq4PwvQXq09IJ1Y=
Subject: FAILED: patch "[PATCH] ext4: fix incorrect punch max_end" failed to apply to 5.10-stable tree
To: yi.zhang@huawei.com,jack@suse.cz,libaokun1@huawei.com,tytso@mit.edu
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 20 Jun 2025 10:27:11 +0200
Message-ID: <2025062011-sector-hungrily-7bc4@gregkh>
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
git cherry-pick -x 29ec9bed2395061350249ae356fb300dd82a78e7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062011-sector-hungrily-7bc4@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 29ec9bed2395061350249ae356fb300dd82a78e7 Mon Sep 17 00:00:00 2001
From: Zhang Yi <yi.zhang@huawei.com>
Date: Tue, 6 May 2025 09:20:07 +0800
Subject: [PATCH] ext4: fix incorrect punch max_end

For the extents based inodes, the maxbytes should be sb->s_maxbytes
instead of sbi->s_bitmap_maxbytes. Additionally, for the calculation of
max_end, the -sb->s_blocksize operation is necessary only for
indirect-block based inodes. Correct the maxbytes and max_end value to
correct the behavior of punch hole.

Fixes: 2da376228a24 ("ext4: limit length to bitmap_maxbytes - blocksize in punch_hole")
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Baokun Li <libaokun1@huawei.com>
Link: https://patch.msgid.link/20250506012009.3896990-2-yi.zhang@huaweicloud.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@kernel.org

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 99f30b9cfe17..01038b4ecee0 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4051,7 +4051,7 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
 	struct inode *inode = file_inode(file);
 	struct super_block *sb = inode->i_sb;
 	ext4_lblk_t start_lblk, end_lblk;
-	loff_t max_end = EXT4_SB(sb)->s_bitmap_maxbytes - sb->s_blocksize;
+	loff_t max_end = sb->s_maxbytes;
 	loff_t end = offset + length;
 	handle_t *handle;
 	unsigned int credits;
@@ -4060,14 +4060,20 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
 	trace_ext4_punch_hole(inode, offset, length, 0);
 	WARN_ON_ONCE(!inode_is_locked(inode));
 
+	/*
+	 * For indirect-block based inodes, make sure that the hole within
+	 * one block before last range.
+	 */
+	if (!ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
+		max_end = EXT4_SB(sb)->s_bitmap_maxbytes - sb->s_blocksize;
+
 	/* No need to punch hole beyond i_size */
 	if (offset >= inode->i_size || offset >= max_end)
 		return 0;
 
 	/*
 	 * If the hole extends beyond i_size, set the hole to end after
-	 * the page that contains i_size, and also make sure that the hole
-	 * within one block before last range.
+	 * the page that contains i_size.
 	 */
 	if (end > inode->i_size)
 		end = round_up(inode->i_size, PAGE_SIZE);


