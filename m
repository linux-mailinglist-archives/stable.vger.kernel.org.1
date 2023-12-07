Return-Path: <stable+bounces-4886-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9354807CD3
	for <lists+stable@lfdr.de>; Thu,  7 Dec 2023 01:13:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA8321C211A3
	for <lists+stable@lfdr.de>; Thu,  7 Dec 2023 00:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD15367;
	Thu,  7 Dec 2023 00:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="kRcUjPwB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20AF7E
	for <stable@vger.kernel.org>; Thu,  7 Dec 2023 00:13:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D325C433CB;
	Thu,  7 Dec 2023 00:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1701908027;
	bh=OXyyZjXHuVBzSNd6xhzYBujd1k8HzwdZSK3FzeE40pk=;
	h=Date:To:From:Subject:From;
	b=kRcUjPwBVGFkTGyOjwXLYFx5ApWb8XU28JbLFP3kO5LM8MFYog2k+xjfE2rXtxMGu
	 //3TNHxpI2g1UvQHS45uOsx0Lgqe0zV1wYVsRZqRkoeqLs0aXMQUwiguk6lLJWQK59
	 cpVEQEYQTR33hBFBaA3KO89WQQKxg2pPVGnSyaHI=
Date: Wed, 06 Dec 2023 16:13:47 -0800
To: mm-commits@vger.kernel.org,stable@vger.kernel.org,konishi.ryusuke@gmail.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: [merged mm-hotfixes-stable] nilfs2-prevent-warning-in-nilfs_sufile_set_segment_usage.patch removed from -mm tree
Message-Id: <20231207001347.8D325C433CB@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>


The quilt patch titled
     Subject: nilfs2: prevent WARNING in nilfs_sufile_set_segment_usage()
has been removed from the -mm tree.  Its filename was
     nilfs2-prevent-warning-in-nilfs_sufile_set_segment_usage.patch

This patch was dropped because it was merged into the mm-hotfixes-stable branch
of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

------------------------------------------------------
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Subject: nilfs2: prevent WARNING in nilfs_sufile_set_segment_usage()
Date: Tue, 5 Dec 2023 17:59:47 +0900

If nilfs2 reads a disk image with corrupted segment usage metadata, and
its segment usage information is marked as an error for the segment at the
write location, nilfs_sufile_set_segment_usage() can trigger WARN_ONs
during log writing.

Segments newly allocated for writing with nilfs_sufile_alloc() will not
have this error flag set, but this unexpected situation will occur if the
segment indexed by either nilfs->ns_segnum or nilfs->ns_nextnum (active
segment) was marked in error.

Fix this issue by inserting a sanity check to treat it as a file system
corruption.

Since error returns are not allowed during the execution phase where
nilfs_sufile_set_segment_usage() is used, this inserts the sanity check
into nilfs_sufile_mark_dirty() which pre-reads the buffer containing the
segment usage record to be updated and sets it up in a dirty state for
writing.

In addition, nilfs_sufile_set_segment_usage() is also called when
canceling log writing and undoing segment usage update, so in order to
avoid issuing the same kernel warning in that case, in case of
cancellation, avoid checking the error flag in
nilfs_sufile_set_segment_usage().

Link: https://lkml.kernel.org/r/20231205085947.4431-1-konishi.ryusuke@gmail.com
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Reported-by: syzbot+14e9f834f6ddecece094@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=14e9f834f6ddecece094
Tested-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 fs/nilfs2/sufile.c |   42 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 35 insertions(+), 7 deletions(-)

--- a/fs/nilfs2/sufile.c~nilfs2-prevent-warning-in-nilfs_sufile_set_segment_usage
+++ a/fs/nilfs2/sufile.c
@@ -501,15 +501,38 @@ int nilfs_sufile_mark_dirty(struct inode
 
 	down_write(&NILFS_MDT(sufile)->mi_sem);
 	ret = nilfs_sufile_get_segment_usage_block(sufile, segnum, 0, &bh);
-	if (!ret) {
-		mark_buffer_dirty(bh);
-		nilfs_mdt_mark_dirty(sufile);
-		kaddr = kmap_atomic(bh->b_page);
-		su = nilfs_sufile_block_get_segment_usage(sufile, segnum, bh, kaddr);
+	if (ret)
+		goto out_sem;
+
+	kaddr = kmap_atomic(bh->b_page);
+	su = nilfs_sufile_block_get_segment_usage(sufile, segnum, bh, kaddr);
+	if (unlikely(nilfs_segment_usage_error(su))) {
+		struct the_nilfs *nilfs = sufile->i_sb->s_fs_info;
+
+		kunmap_atomic(kaddr);
+		brelse(bh);
+		if (nilfs_segment_is_active(nilfs, segnum)) {
+			nilfs_error(sufile->i_sb,
+				    "active segment %llu is erroneous",
+				    (unsigned long long)segnum);
+		} else {
+			/*
+			 * Segments marked erroneous are never allocated by
+			 * nilfs_sufile_alloc(); only active segments, ie,
+			 * the segments indexed by ns_segnum or ns_nextnum,
+			 * can be erroneous here.
+			 */
+			WARN_ON_ONCE(1);
+		}
+		ret = -EIO;
+	} else {
 		nilfs_segment_usage_set_dirty(su);
 		kunmap_atomic(kaddr);
+		mark_buffer_dirty(bh);
+		nilfs_mdt_mark_dirty(sufile);
 		brelse(bh);
 	}
+out_sem:
 	up_write(&NILFS_MDT(sufile)->mi_sem);
 	return ret;
 }
@@ -536,9 +559,14 @@ int nilfs_sufile_set_segment_usage(struc
 
 	kaddr = kmap_atomic(bh->b_page);
 	su = nilfs_sufile_block_get_segment_usage(sufile, segnum, bh, kaddr);
-	WARN_ON(nilfs_segment_usage_error(su));
-	if (modtime)
+	if (modtime) {
+		/*
+		 * Check segusage error and set su_lastmod only when updating
+		 * this entry with a valid timestamp, not for cancellation.
+		 */
+		WARN_ON_ONCE(nilfs_segment_usage_error(su));
 		su->su_lastmod = cpu_to_le64(modtime);
+	}
 	su->su_nblocks = cpu_to_le32(nblocks);
 	kunmap_atomic(kaddr);
 
_

Patches currently in -mm which might be from konishi.ryusuke@gmail.com are

nilfs2-move-page-release-outside-of-nilfs_delete_entry-and-nilfs_set_link.patch
nilfs2-eliminate-staggered-calls-to-kunmap-in-nilfs_rename.patch


