Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C130979B47B
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358430AbjIKWKt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242143AbjIKPXV (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:23:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F2CD8
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:23:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3ADFC433C8;
        Mon, 11 Sep 2023 15:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694445796;
        bh=hw5HgrVKt25hQm0s76l8FtQTLhEpIspi2KfWRskZx5w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gnUONw8EdzLBAxwMr/IxPlxR3jy31NWEEqOMFEOe8gqDuYAzICj29MmLfx9zvttKp
         gH49/Zc91uOyFXkD38cYLme+YG6pVGAVQmtTz3Hwg46lbEF2qT3WKdYcYoX0xFczKy
         OBaSTtMH4Sb2bkfSNgWj7d5eMwYsykCnwxqf3tSE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Chao Yu <chao@kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 474/600] f2fs: fix to avoid mmap vs set_compress_option case
Date:   Mon, 11 Sep 2023 15:48:27 +0200
Message-ID: <20230911134647.637599755@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
References: <20230911134633.619970489@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chao Yu <chao@kernel.org>

[ Upstream commit b5ab3276eb69cacf44ecfb11b2bfab73096ff4e4 ]

Compression option in inode should not be changed after they have
been used, however, it may happen in below race case:

Thread A				Thread B
- f2fs_ioc_set_compress_option
 - check f2fs_is_mmap_file()
 - check get_dirty_pages()
 - check F2FS_HAS_BLOCKS()
					- f2fs_file_mmap
					 - set_inode_flag(FI_MMAP_FILE)
					- fault
					 - do_page_mkwrite
					  - f2fs_vm_page_mkwrite
					  - f2fs_get_block_locked
					 - fault_dirty_shared_page
					  - set_page_dirty
 - update i_compress_algorithm
 - update i_log_cluster_size
 - update i_cluster_size

Avoid such race condition by covering f2fs_file_mmap() w/ i_sem lock,
meanwhile add mmap file check condition in f2fs_may_compress() as well.

Fixes: e1e8debec656 ("f2fs: add F2FS_IOC_SET_COMPRESS_OPTION ioctl")
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/f2fs.h |  3 ++-
 fs/f2fs/file.c | 23 ++++++++++++++++++-----
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 4d1e48c676fab..c2b7d09238941 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4453,7 +4453,8 @@ static inline bool f2fs_low_mem_mode(struct f2fs_sb_info *sbi)
 static inline bool f2fs_may_compress(struct inode *inode)
 {
 	if (IS_SWAPFILE(inode) || f2fs_is_pinned_file(inode) ||
-		f2fs_is_atomic_file(inode) || f2fs_has_inline_data(inode))
+		f2fs_is_atomic_file(inode) || f2fs_has_inline_data(inode) ||
+		f2fs_is_mmap_file(inode))
 		return false;
 	return S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode);
 }
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 7b94f047cbf79..746c71716bead 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -530,7 +530,11 @@ static int f2fs_file_mmap(struct file *file, struct vm_area_struct *vma)
 
 	file_accessed(file);
 	vma->vm_ops = &f2fs_file_vm_ops;
+
+	f2fs_down_read(&F2FS_I(inode)->i_sem);
 	set_inode_flag(inode, FI_MMAP_FILE);
+	f2fs_up_read(&F2FS_I(inode)->i_sem);
+
 	return 0;
 }
 
@@ -1927,12 +1931,19 @@ static int f2fs_setflags_common(struct inode *inode, u32 iflags, u32 mask)
 			int err = f2fs_convert_inline_inode(inode);
 			if (err)
 				return err;
-			if (!f2fs_may_compress(inode))
-				return -EINVAL;
-			if (S_ISREG(inode->i_mode) && F2FS_HAS_BLOCKS(inode))
+
+			f2fs_down_write(&F2FS_I(inode)->i_sem);
+			if (!f2fs_may_compress(inode) ||
+					(S_ISREG(inode->i_mode) &&
+					F2FS_HAS_BLOCKS(inode))) {
+				f2fs_up_write(&F2FS_I(inode)->i_sem);
 				return -EINVAL;
-			if (set_compress_context(inode))
-				return -EOPNOTSUPP;
+			}
+			err = set_compress_context(inode);
+			f2fs_up_write(&F2FS_I(inode)->i_sem);
+
+			if (err)
+				return err;
 		}
 	}
 
@@ -3958,6 +3969,7 @@ static int f2fs_ioc_set_compress_option(struct file *filp, unsigned long arg)
 	file_start_write(filp);
 	inode_lock(inode);
 
+	f2fs_down_write(&F2FS_I(inode)->i_sem);
 	if (f2fs_is_mmap_file(inode) || get_dirty_pages(inode)) {
 		ret = -EBUSY;
 		goto out;
@@ -3977,6 +3989,7 @@ static int f2fs_ioc_set_compress_option(struct file *filp, unsigned long arg)
 		f2fs_warn(sbi, "compression algorithm is successfully set, "
 			"but current kernel doesn't support this algorithm.");
 out:
+	f2fs_up_write(&F2FS_I(inode)->i_sem);
 	inode_unlock(inode);
 	file_end_write(filp);
 
-- 
2.40.1



