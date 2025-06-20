Return-Path: <stable+bounces-154986-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0502AAE15E4
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 10:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D2DF4A3CFE
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 08:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D114F2367C1;
	Fri, 20 Jun 2025 08:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="T/ciPZi2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FDF2367B3
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 08:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750408047; cv=none; b=LFp8vQHVOwNDopNDQhc8sGl8737ICb+dh4SfsIWfFSLv86kxzeZOJMzzJ3ALd608tNV4rF2B0SEyV6QRQnc1px1CsyMDL474AGwd9sQFnt3mC/RFQJF7czStSHi8zrO3PZY/o6nCX/+3zPpp2W+xvRtz5FCMoxKdGEmB++1MFEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750408047; c=relaxed/simple;
	bh=XirezOoSxvy1gmvFyMGe1N4Muon1GLPYP2jHneku/2c=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=YPgCOAHtK+CYT308sS2CJ+fB2cSZnzzEbgb4+N2qc5TxvudNPOChSkKS/xAkSBJJIi+F19PeM/ZGD8idClGhtuYdWzLHBiErRZrq/NH/tHEMvTMjOzOVBLJheK5RmZbK/dPzfke2qGoaRD0ZwhKLtUOIAh8O5axR6EyFLbGqeVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=T/ciPZi2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22ECAC4CEED;
	Fri, 20 Jun 2025 08:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750408047;
	bh=XirezOoSxvy1gmvFyMGe1N4Muon1GLPYP2jHneku/2c=;
	h=Subject:To:Cc:From:Date:From;
	b=T/ciPZi2nBOcDUinBUAOcu4TzEhohgdIy8QgiRehxUCoEO9cmOwTYvuQCOh0s0DVn
	 7Smq2SF77HHVaDgcNY6SlSQ7RCWHtuscbLk8wzE7UbZ2GkQmhC4LLiipPLID1F76S7
	 e1iq1/FwHfIksjRGj9Qs2/UFjckoOCRPIKEJRDaM=
Subject: FAILED: patch "[PATCH] ext4: fix incorrect punch max_end" failed to apply to 6.6-stable tree
To: yi.zhang@huawei.com,jack@suse.cz,libaokun1@huawei.com,tytso@mit.edu
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 20 Jun 2025 10:27:10 +0200
Message-ID: <2025062009-circle-bulginess-3a5e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 29ec9bed2395061350249ae356fb300dd82a78e7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062009-circle-bulginess-3a5e@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

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


