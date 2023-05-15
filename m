Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7360E7022AE
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 06:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238273AbjEOEMk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 00:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232090AbjEOEMi (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 00:12:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 271A5E48
        for <stable@vger.kernel.org>; Sun, 14 May 2023 21:12:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE47960ECB
        for <stable@vger.kernel.org>; Mon, 15 May 2023 04:12:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DAA8C433D2;
        Mon, 15 May 2023 04:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684123956;
        bh=r3Xzfvu0YIlxIXRRJrvZlSmO+nSCrheqhGd1h4nHg/o=;
        h=Subject:To:Cc:From:Date:From;
        b=FPJS2ZlbvNkOyPgqVK0T3BHo07pZeIx8tyalDxOH+MsPSAxTxXq/2kzw0iuDHM5ie
         WldwmVqAPQKjeJ934XmvWfWYLY4Bc+SSGmrRjU+raalDosB50pyjSK1GQLjyrNJBRt
         DEvFC2gVnjcyqf0ldqbjS25djPXpNfbOlXUnoVQE=
Subject: FAILED: patch "[PATCH] ext4: avoid deadlock in fs reclaim with page writeback" failed to apply to 5.15-stable tree
To:     jack@suse.cz, tytso@mit.edu
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Mon, 15 May 2023 06:12:30 +0200
Message-ID: <2023051530-pushcart-probably-f8cf@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 00d873c17e29cc32d90ca852b82685f1673acaa5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023051530-pushcart-probably-f8cf@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

00d873c17e29 ("ext4: avoid deadlock in fs reclaim with page writeback")
1f1a55f0bf06 ("ext4: Commit transaction before writing back pages in data=journal mode")
3f079114bf52 ("ext4: Convert data=journal writeback to use ext4_writepages()")
d8be7607de03 ("ext4: Move mpage_page_done() calls after error handling")
eaf2ca10ca4b ("ext4: Move page unlocking out of mpage_submit_page()")
f1496362e9d7 ("ext4: Don't unlock page in ext4_bio_write_page()")
d585bdbeb79a ("fs: convert writepage_t callback to pass a folio")
50ead2537441 ("ext4: convert mpage_prepare_extent_to_map() to use filemap_get_folios_tag()")
0fff435f060c ("page-writeback: convert write_cache_pages() to use filemap_get_folios_tag()")
c2ca7a59a419 ("mm: remove generic_writepages")
25a89826f270 ("ntfs3: remove ->writepage")
d4428bad14dd ("ntfs3: stop using generic_writepages")
851f657a8642 ("Merge tag '6.2-rc-smb3-client-fixes-part1' of git://git.samba.org/sfrench/cifs-2.6")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 00d873c17e29cc32d90ca852b82685f1673acaa5 Mon Sep 17 00:00:00 2001
From: Jan Kara <jack@suse.cz>
Date: Thu, 4 May 2023 14:47:23 +0200
Subject: [PATCH] ext4: avoid deadlock in fs reclaim with page writeback

Ext4 has a filesystem wide lock protecting ext4_writepages() calls to
avoid races with switching of journalled data flag or inode format. This
lock can however cause a deadlock like:

CPU0                            CPU1

ext4_writepages()
  percpu_down_read(sbi->s_writepages_rwsem);
                                ext4_change_inode_journal_flag()
                                  percpu_down_write(sbi->s_writepages_rwsem);
                                    - blocks, all readers block from now on
  ext4_do_writepages()
    ext4_init_io_end()
      kmem_cache_zalloc(io_end_cachep, GFP_KERNEL)
        fs_reclaim frees dentry...
          dentry_unlink_inode()
            iput() - last ref =>
              iput_final() - inode dirty =>
                write_inode_now()...
                  ext4_writepages() tries to acquire sbi->s_writepages_rwsem
                    and blocks forever

Make sure we cannot recurse into filesystem reclaim from writeback code
to avoid the deadlock.

Reported-by: syzbot+6898da502aef574c5f8a@syzkaller.appspotmail.com
Link: https://lore.kernel.org/all/0000000000004c66b405fa108e27@google.com
Fixes: c8585c6fcaf2 ("ext4: fix races between changing inode journal mode and ext4_writepages")
CC: stable@vger.kernel.org
Signed-off-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20230504124723.20205-1-jack@suse.cz
Signed-off-by: Theodore Ts'o <tytso@mit.edu>

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 7e8f66ba17f4..6948d673bba2 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1684,6 +1684,30 @@ static inline struct ext4_inode_info *EXT4_I(struct inode *inode)
 	return container_of(inode, struct ext4_inode_info, vfs_inode);
 }
 
+static inline int ext4_writepages_down_read(struct super_block *sb)
+{
+	percpu_down_read(&EXT4_SB(sb)->s_writepages_rwsem);
+	return memalloc_nofs_save();
+}
+
+static inline void ext4_writepages_up_read(struct super_block *sb, int ctx)
+{
+	memalloc_nofs_restore(ctx);
+	percpu_up_read(&EXT4_SB(sb)->s_writepages_rwsem);
+}
+
+static inline int ext4_writepages_down_write(struct super_block *sb)
+{
+	percpu_down_write(&EXT4_SB(sb)->s_writepages_rwsem);
+	return memalloc_nofs_save();
+}
+
+static inline void ext4_writepages_up_write(struct super_block *sb, int ctx)
+{
+	memalloc_nofs_restore(ctx);
+	percpu_up_write(&EXT4_SB(sb)->s_writepages_rwsem);
+}
+
 static inline int ext4_valid_inum(struct super_block *sb, unsigned long ino)
 {
 	return ino == EXT4_ROOT_INO ||
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 0d5ba922e411..3cb774d9e3f1 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2783,11 +2783,12 @@ static int ext4_writepages(struct address_space *mapping,
 		.can_map = 1,
 	};
 	int ret;
+	int alloc_ctx;
 
 	if (unlikely(ext4_forced_shutdown(EXT4_SB(sb))))
 		return -EIO;
 
-	percpu_down_read(&EXT4_SB(sb)->s_writepages_rwsem);
+	alloc_ctx = ext4_writepages_down_read(sb);
 	ret = ext4_do_writepages(&mpd);
 	/*
 	 * For data=journal writeback we could have come across pages marked
@@ -2796,7 +2797,7 @@ static int ext4_writepages(struct address_space *mapping,
 	 */
 	if (!ret && mpd.journalled_more_data)
 		ret = ext4_do_writepages(&mpd);
-	percpu_up_read(&EXT4_SB(sb)->s_writepages_rwsem);
+	ext4_writepages_up_read(sb, alloc_ctx);
 
 	return ret;
 }
@@ -2824,17 +2825,18 @@ static int ext4_dax_writepages(struct address_space *mapping,
 	long nr_to_write = wbc->nr_to_write;
 	struct inode *inode = mapping->host;
 	struct ext4_sb_info *sbi = EXT4_SB(mapping->host->i_sb);
+	int alloc_ctx;
 
 	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb))))
 		return -EIO;
 
-	percpu_down_read(&sbi->s_writepages_rwsem);
+	alloc_ctx = ext4_writepages_down_read(inode->i_sb);
 	trace_ext4_writepages(inode, wbc);
 
 	ret = dax_writeback_mapping_range(mapping, sbi->s_daxdev, wbc);
 	trace_ext4_writepages_result(inode, wbc, ret,
 				     nr_to_write - wbc->nr_to_write);
-	percpu_up_read(&sbi->s_writepages_rwsem);
+	ext4_writepages_up_read(inode->i_sb, alloc_ctx);
 	return ret;
 }
 
@@ -5928,7 +5930,7 @@ int ext4_change_inode_journal_flag(struct inode *inode, int val)
 	journal_t *journal;
 	handle_t *handle;
 	int err;
-	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
+	int alloc_ctx;
 
 	/*
 	 * We have to be very careful here: changing a data block's
@@ -5966,7 +5968,7 @@ int ext4_change_inode_journal_flag(struct inode *inode, int val)
 		}
 	}
 
-	percpu_down_write(&sbi->s_writepages_rwsem);
+	alloc_ctx = ext4_writepages_down_write(inode->i_sb);
 	jbd2_journal_lock_updates(journal);
 
 	/*
@@ -5983,7 +5985,7 @@ int ext4_change_inode_journal_flag(struct inode *inode, int val)
 		err = jbd2_journal_flush(journal, 0);
 		if (err < 0) {
 			jbd2_journal_unlock_updates(journal);
-			percpu_up_write(&sbi->s_writepages_rwsem);
+			ext4_writepages_up_write(inode->i_sb, alloc_ctx);
 			return err;
 		}
 		ext4_clear_inode_flag(inode, EXT4_INODE_JOURNAL_DATA);
@@ -5991,7 +5993,7 @@ int ext4_change_inode_journal_flag(struct inode *inode, int val)
 	ext4_set_aops(inode);
 
 	jbd2_journal_unlock_updates(journal);
-	percpu_up_write(&sbi->s_writepages_rwsem);
+	ext4_writepages_up_write(inode->i_sb, alloc_ctx);
 
 	if (val)
 		filemap_invalidate_unlock(inode->i_mapping);
diff --git a/fs/ext4/migrate.c b/fs/ext4/migrate.c
index a19a9661646e..d98ac2af8199 100644
--- a/fs/ext4/migrate.c
+++ b/fs/ext4/migrate.c
@@ -408,7 +408,6 @@ static int free_ext_block(handle_t *handle, struct inode *inode)
 
 int ext4_ext_migrate(struct inode *inode)
 {
-	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
 	handle_t *handle;
 	int retval = 0, i;
 	__le32 *i_data;
@@ -418,6 +417,7 @@ int ext4_ext_migrate(struct inode *inode)
 	unsigned long max_entries;
 	__u32 goal, tmp_csum_seed;
 	uid_t owner[2];
+	int alloc_ctx;
 
 	/*
 	 * If the filesystem does not support extents, or the inode
@@ -434,7 +434,7 @@ int ext4_ext_migrate(struct inode *inode)
 		 */
 		return retval;
 
-	percpu_down_write(&sbi->s_writepages_rwsem);
+	alloc_ctx = ext4_writepages_down_write(inode->i_sb);
 
 	/*
 	 * Worst case we can touch the allocation bitmaps and a block
@@ -586,7 +586,7 @@ int ext4_ext_migrate(struct inode *inode)
 	unlock_new_inode(tmp_inode);
 	iput(tmp_inode);
 out_unlock:
-	percpu_up_write(&sbi->s_writepages_rwsem);
+	ext4_writepages_up_write(inode->i_sb, alloc_ctx);
 	return retval;
 }
 
@@ -605,6 +605,7 @@ int ext4_ind_migrate(struct inode *inode)
 	ext4_fsblk_t			blk;
 	handle_t			*handle;
 	int				ret, ret2 = 0;
+	int				alloc_ctx;
 
 	if (!ext4_has_feature_extents(inode->i_sb) ||
 	    (!ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)))
@@ -621,7 +622,7 @@ int ext4_ind_migrate(struct inode *inode)
 	if (test_opt(inode->i_sb, DELALLOC))
 		ext4_alloc_da_blocks(inode);
 
-	percpu_down_write(&sbi->s_writepages_rwsem);
+	alloc_ctx = ext4_writepages_down_write(inode->i_sb);
 
 	handle = ext4_journal_start(inode, EXT4_HT_MIGRATE, 1);
 	if (IS_ERR(handle)) {
@@ -665,6 +666,6 @@ int ext4_ind_migrate(struct inode *inode)
 	ext4_journal_stop(handle);
 	up_write(&EXT4_I(inode)->i_data_sem);
 out_unlock:
-	percpu_up_write(&sbi->s_writepages_rwsem);
+	ext4_writepages_up_write(inode->i_sb, alloc_ctx);
 	return ret;
 }

