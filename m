Return-Path: <stable+bounces-81244-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 306879928FC
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 12:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E85DB281D5F
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 10:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3BB1B5EDE;
	Mon,  7 Oct 2024 10:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UcTAj3wh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0D9158A36
	for <stable@vger.kernel.org>; Mon,  7 Oct 2024 10:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728296321; cv=none; b=HRhlNxu9S+xtMg2CnqHMvrVEWis/b7Vg2dhcxuvH2+x+2jCtCs812IaSiRfK/qfxYZgJgCE9OupJbuRSRiudi3+rGc2mRYhv8s1heAXsRyLM601ipDNsabzrzuJhwPXIlEWvutcjOuLSCTwuxH9Et5qH0bqOv0Zfv5uMauNL1JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728296321; c=relaxed/simple;
	bh=tr5dwW4pXVBUfBW+TlELkOI9002TPoAfOTN7Y3iI4FE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=El6WQiNA7r0B5P18YoYZ8WGAKMRYaL+l1ZyE+va6P6+ffqAkz7cUKs7yfGwIe2PjqphvJD/5/Vq9ztflp6saoZrUx9+YNr0Lcp5quvVVxGYi9RKvkCI5AD0M01JqdVYNKv+2UxqjMXm2AAtqHpxnSvUqEdNyOuq7if0aZX7dcog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UcTAj3wh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86FDAC4CEC6;
	Mon,  7 Oct 2024 10:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728296321;
	bh=tr5dwW4pXVBUfBW+TlELkOI9002TPoAfOTN7Y3iI4FE=;
	h=Subject:To:Cc:From:Date:From;
	b=UcTAj3whVqDcCYN0RiwUBjXxtiuV1zODZ7FL/9qFx13N1WWjBEhfs2wSdoRi3/Gwq
	 YJDtFwin/F3TzUYkvcp/9Fhu6UsBoIroS0wvTsb0OdciWMFJmw+uV4cAzzDJ7Y81uF
	 w1wOjHFDLa6sCO7xhmcRs/xw7VQKiMoKq/qURbM8=
Subject: FAILED: patch "[PATCH] ext4: dax: fix overflowing extents beyond inode size when" failed to apply to 5.4-stable tree
To: chengzhihao1@huawei.com,jack@suse.cz,tytso@mit.edu
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 07 Oct 2024 12:18:33 +0200
Message-ID: <2024100732-outscore-hardcore-8271@gregkh>
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
git cherry-pick -x dda898d7ffe85931f9cca6d702a51f33717c501e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100732-outscore-hardcore-8271@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

dda898d7ffe8 ("ext4: dax: fix overflowing extents beyond inode size when partially writing")
91562895f803 ("ext4: properly sync file size update after O_SYNC direct IO")
5899593f51e6 ("ext4: Fix occasional generic/418 failure")
60263d5889e6 ("iomap: fall back to buffered writes for invalidation failures")
54752de928c4 ("iomap: Only invalidate page cache pages on direct IO writes")
4209ae12b122 ("ext4: handle ext4_mark_inode_dirty errors")
9c94b39560c3 ("Merge tag 'ext4_for_linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From dda898d7ffe85931f9cca6d702a51f33717c501e Mon Sep 17 00:00:00 2001
From: Zhihao Cheng <chengzhihao1@huawei.com>
Date: Fri, 9 Aug 2024 20:15:32 +0800
Subject: [PATCH] ext4: dax: fix overflowing extents beyond inode size when
 partially writing

The dax_iomap_rw() does two things in each iteration: map written blocks
and copy user data to blocks. If the process is killed by user(See signal
handling in dax_iomap_iter()), the copied data will be returned and added
on inode size, which means that the length of written extents may exceed
the inode size, then fsck will fail. An example is given as:

dd if=/dev/urandom of=file bs=4M count=1
 dax_iomap_rw
  iomap_iter // round 1
   ext4_iomap_begin
    ext4_iomap_alloc // allocate 0~2M extents(written flag)
  dax_iomap_iter // copy 2M data
  iomap_iter // round 2
   iomap_iter_advance
    iter->pos += iter->processed // iter->pos = 2M
   ext4_iomap_begin
    ext4_iomap_alloc // allocate 2~4M extents(written flag)
  dax_iomap_iter
   fatal_signal_pending
  done = iter->pos - iocb->ki_pos // done = 2M
 ext4_handle_inode_extension
  ext4_update_inode_size // inode size = 2M

fsck reports: Inode 13, i_size is 2097152, should be 4194304.  Fix?

Fix the problem by truncating extents if the written length is smaller
than expected.

Fixes: 776722e85d3b ("ext4: DAX iomap write support")
CC: stable@vger.kernel.org
Link: https://bugzilla.kernel.org/show_bug.cgi?id=219136
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
Link: https://patch.msgid.link/20240809121532.2105494-1-chengzhihao@huaweicloud.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index c89e434db6b7..be061bb64067 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -334,10 +334,10 @@ static ssize_t ext4_handle_inode_extension(struct inode *inode, loff_t offset,
  * Clean up the inode after DIO or DAX extending write has completed and the
  * inode size has been updated using ext4_handle_inode_extension().
  */
-static void ext4_inode_extension_cleanup(struct inode *inode, ssize_t count)
+static void ext4_inode_extension_cleanup(struct inode *inode, bool need_trunc)
 {
 	lockdep_assert_held_write(&inode->i_rwsem);
-	if (count < 0) {
+	if (need_trunc) {
 		ext4_truncate_failed_write(inode);
 		/*
 		 * If the truncate operation failed early, then the inode may
@@ -586,7 +586,7 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		 * writeback of delalloc blocks.
 		 */
 		WARN_ON_ONCE(ret == -EIOCBQUEUED);
-		ext4_inode_extension_cleanup(inode, ret);
+		ext4_inode_extension_cleanup(inode, ret < 0);
 	}
 
 out:
@@ -670,7 +670,7 @@ ext4_dax_write_iter(struct kiocb *iocb, struct iov_iter *from)
 
 	if (extend) {
 		ret = ext4_handle_inode_extension(inode, offset, ret);
-		ext4_inode_extension_cleanup(inode, ret);
+		ext4_inode_extension_cleanup(inode, ret < (ssize_t)count);
 	}
 out:
 	inode_unlock(inode);


