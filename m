Return-Path: <stable+bounces-5602-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8670C80D590
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 19:26:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8DEC1C21468
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 18:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128F55101E;
	Mon, 11 Dec 2023 18:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eA1FbKL6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA32E4E1B8;
	Mon, 11 Dec 2023 18:26:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49A48C433C7;
	Mon, 11 Dec 2023 18:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702319162;
	bh=ZBsUJIZ306CV2vaatuNjX/W3SJz2RwIg6A8M9yfOdnc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eA1FbKL61eYuEa+qrPzttBOFMftxz5EbLkVhwXTAd5uWqDQtupNwaqdbkTvA8qCWP
	 HI0WH6nXNNTvEoqieIfwBm1yTEjO7K89TbC59ToT3f5yqU7g32FYGEp9gGr8fk5P1i
	 olBOoLKUN7glHbajf2ekHj8bhx2FQOyquQ9GskYU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	syzbot+14e9f834f6ddecece094@syzkaller.appspotmail.com,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 4.19 32/55] nilfs2: prevent WARNING in nilfs_sufile_set_segment_usage()
Date: Mon, 11 Dec 2023 19:21:42 +0100
Message-ID: <20231211182013.418991238@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211182012.263036284@linuxfoundation.org>
References: <20231211182012.263036284@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ryusuke Konishi <konishi.ryusuke@gmail.com>

commit 675abf8df1353e0e3bde314993e0796c524cfbf0 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nilfs2/sufile.c |   42 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 35 insertions(+), 7 deletions(-)

--- a/fs/nilfs2/sufile.c
+++ b/fs/nilfs2/sufile.c
@@ -504,15 +504,38 @@ int nilfs_sufile_mark_dirty(struct inode
 
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
@@ -539,9 +562,14 @@ int nilfs_sufile_set_segment_usage(struc
 
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
 



