Return-Path: <stable+bounces-154985-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08DC4AE15E5
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 10:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92F555A36B5
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 08:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09052367B8;
	Fri, 20 Jun 2025 08:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ALNxkmp1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2B42367B6
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 08:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750408044; cv=none; b=H5NbHMEuLU5wzbgLJWrOSgU7rUdiAMPV6BIECduYSNscVlM0qpbtY41F5eNzNyV11pmfXHthWWO0IzEE+uLa5B4cXg3A2EutVUUnjFVPx6iUIde4iOe/XH+UvkxdCflITuwMHrWkqr+i7K+b1SzjrXuPCy0c1bvDVSIODEtiEOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750408044; c=relaxed/simple;
	bh=yPebTiARHgazzQ4mdl8nJwhxwzxqC090XkR+CjDyunU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=S+KRLqirc0b7z8l7RJrpWE2skYrZ2XC1AllFCoytgo+b9PC6EW9muj06Le0TCjAvv7pLLrPe6U5nWKEQd6X28vtZY9pFNMY8HnksooIPV1l0g/flbm/Zdh6Om+XDIUZeTkZRM2aDO4GNkzQubvKPEFuya9u2ZxjT+fGg9hjUigQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ALNxkmp1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CB00C4CEE3;
	Fri, 20 Jun 2025 08:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750408044;
	bh=yPebTiARHgazzQ4mdl8nJwhxwzxqC090XkR+CjDyunU=;
	h=Subject:To:Cc:From:Date:From;
	b=ALNxkmp1L5igaGqCLrTCKs3cavsa6CNfwgU35Scnp0myFUJqVzYOqMsy/ZmNoj5WM
	 mngDGDZqficQNM80g+CeCgeF/9zavcYz07nT6q6J8twYZwPrihpnGTqe+CFQvq3qjr
	 dTJncVTtszuNelFlHJwYDcw1qTbpPme/1KelQ1KY=
Subject: FAILED: patch "[PATCH] ext4: fix incorrect punch max_end" failed to apply to 5.15-stable tree
To: yi.zhang@huawei.com,jack@suse.cz,libaokun1@huawei.com,tytso@mit.edu
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 20 Jun 2025 10:27:10 +0200
Message-ID: <2025062010-lagoon-anatomy-8cbc@gregkh>
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
git cherry-pick -x 29ec9bed2395061350249ae356fb300dd82a78e7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062010-lagoon-anatomy-8cbc@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

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


