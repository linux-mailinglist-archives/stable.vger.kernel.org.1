Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAF8D79ACDA
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237831AbjIKWip (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240773AbjIKOx0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:53:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20531118
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:53:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6143FC433C8;
        Mon, 11 Sep 2023 14:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694444001;
        bh=hNBwZtF4d/OdSDpaywte4+zYM78PZhRzU9gGOv6Hvm8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yIBfNDeZEAegypchYts1OFa1iS2EKRW0P2T4c2H8yCeNWZQUczNKQuNAo8V4ct70U
         XfR8n0Ru0g0Yehp5Is2PF6OXxYUFz4XmBp0yBmHtCXN7SME+JvlF9oUi682NhcG9KO
         u3i6okJzEfJsOrAaqpKh0aJ6GmEl+Wm6PC+T8B/4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Chao Yu <chao@kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 575/737] f2fs: fix to avoid mmap vs set_compress_option case
Date:   Mon, 11 Sep 2023 15:47:14 +0200
Message-ID: <20230911134706.596899720@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
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

6.4-stable review patch.  If anyone has any objections, please let me know.

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
index 271d4e7b22c91..395d23ab149da 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4469,7 +4469,8 @@ static inline bool f2fs_low_mem_mode(struct f2fs_sb_info *sbi)
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
index ead75c4e833d2..f1be41014180a 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -528,7 +528,11 @@ static int f2fs_file_mmap(struct file *file, struct vm_area_struct *vma)
 
 	file_accessed(file);
 	vma->vm_ops = &f2fs_file_vm_ops;
+
+	f2fs_down_read(&F2FS_I(inode)->i_sem);
 	set_inode_flag(inode, FI_MMAP_FILE);
+	f2fs_up_read(&F2FS_I(inode)->i_sem);
+
 	return 0;
 }
 
@@ -1920,12 +1924,19 @@ static int f2fs_setflags_common(struct inode *inode, u32 iflags, u32 mask)
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
 
@@ -3953,6 +3964,7 @@ static int f2fs_ioc_set_compress_option(struct file *filp, unsigned long arg)
 	file_start_write(filp);
 	inode_lock(inode);
 
+	f2fs_down_write(&F2FS_I(inode)->i_sem);
 	if (f2fs_is_mmap_file(inode) || get_dirty_pages(inode)) {
 		ret = -EBUSY;
 		goto out;
@@ -3972,6 +3984,7 @@ static int f2fs_ioc_set_compress_option(struct file *filp, unsigned long arg)
 		f2fs_warn(sbi, "compression algorithm is successfully set, "
 			"but current kernel doesn't support this algorithm.");
 out:
+	f2fs_up_write(&F2FS_I(inode)->i_sem);
 	inode_unlock(inode);
 	file_end_write(filp);
 
-- 
2.40.1



