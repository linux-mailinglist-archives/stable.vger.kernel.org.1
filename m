Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE027035A1
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243409AbjEORAK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243336AbjEOQ7r (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 12:59:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ABA57DAC
        for <stable@vger.kernel.org>; Mon, 15 May 2023 09:59:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8AA8062A5B
        for <stable@vger.kernel.org>; Mon, 15 May 2023 16:59:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B018C433EF;
        Mon, 15 May 2023 16:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684169971;
        bh=0MTfPhKCROBkq8f6Ik4vo8/aTi3UAAUvz5F0z125Tok=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NCQjKLOPsOdDZlYxi/M/6EYcCgZLSTPiRIdhF2kYZkocDheeUCLLPO34TCKlm+7Ez
         7qVngVwxPSLB9onx2pz41KtNcLaCtXlSGsFSlSMPim+lvBiajYkW1ol8aNr/HwQXfg
         aco+tdS09UwMhGiKmJRq+vnL+zdx4JWuvnmQTCHY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        syzbot+6898da502aef574c5f8a@syzkaller.appspotmail.com,
        Jan Kara <jack@suse.cz>, Theodore Tso <tytso@mit.edu>
Subject: [PATCH 6.3 230/246] ext4: avoid deadlock in fs reclaim with page writeback
Date:   Mon, 15 May 2023 18:27:22 +0200
Message-Id: <20230515161729.508843417@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161722.610123835@linuxfoundation.org>
References: <20230515161722.610123835@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jan Kara <jack@suse.cz>

commit 00d873c17e29cc32d90ca852b82685f1673acaa5 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ext4/ext4.h    |   24 ++++++++++++++++++++++++
 fs/ext4/inode.c   |   18 ++++++++++--------
 fs/ext4/migrate.c |   11 ++++++-----
 3 files changed, 40 insertions(+), 13 deletions(-)

--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1774,6 +1774,30 @@ static inline struct ext4_inode_info *EX
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
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2956,13 +2956,14 @@ static int ext4_writepages(struct addres
 		.can_map = 1,
 	};
 	int ret;
+	int alloc_ctx;
 
 	if (unlikely(ext4_forced_shutdown(EXT4_SB(sb))))
 		return -EIO;
 
-	percpu_down_read(&EXT4_SB(sb)->s_writepages_rwsem);
+	alloc_ctx = ext4_writepages_down_read(sb);
 	ret = ext4_do_writepages(&mpd);
-	percpu_up_read(&EXT4_SB(sb)->s_writepages_rwsem);
+	ext4_writepages_up_read(sb, alloc_ctx);
 
 	return ret;
 }
@@ -2990,17 +2991,18 @@ static int ext4_dax_writepages(struct ad
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
 
@@ -6122,7 +6124,7 @@ int ext4_change_inode_journal_flag(struc
 	journal_t *journal;
 	handle_t *handle;
 	int err;
-	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
+	int alloc_ctx;
 
 	/*
 	 * We have to be very careful here: changing a data block's
@@ -6160,7 +6162,7 @@ int ext4_change_inode_journal_flag(struc
 		}
 	}
 
-	percpu_down_write(&sbi->s_writepages_rwsem);
+	alloc_ctx = ext4_writepages_down_write(inode->i_sb);
 	jbd2_journal_lock_updates(journal);
 
 	/*
@@ -6177,7 +6179,7 @@ int ext4_change_inode_journal_flag(struc
 		err = jbd2_journal_flush(journal, 0);
 		if (err < 0) {
 			jbd2_journal_unlock_updates(journal);
-			percpu_up_write(&sbi->s_writepages_rwsem);
+			ext4_writepages_up_write(inode->i_sb, alloc_ctx);
 			return err;
 		}
 		ext4_clear_inode_flag(inode, EXT4_INODE_JOURNAL_DATA);
@@ -6185,7 +6187,7 @@ int ext4_change_inode_journal_flag(struc
 	ext4_set_aops(inode);
 
 	jbd2_journal_unlock_updates(journal);
-	percpu_up_write(&sbi->s_writepages_rwsem);
+	ext4_writepages_up_write(inode->i_sb, alloc_ctx);
 
 	if (val)
 		filemap_invalidate_unlock(inode->i_mapping);
--- a/fs/ext4/migrate.c
+++ b/fs/ext4/migrate.c
@@ -408,7 +408,6 @@ static int free_ext_block(handle_t *hand
 
 int ext4_ext_migrate(struct inode *inode)
 {
-	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
 	handle_t *handle;
 	int retval = 0, i;
 	__le32 *i_data;
@@ -418,6 +417,7 @@ int ext4_ext_migrate(struct inode *inode
 	unsigned long max_entries;
 	__u32 goal, tmp_csum_seed;
 	uid_t owner[2];
+	int alloc_ctx;
 
 	/*
 	 * If the filesystem does not support extents, or the inode
@@ -434,7 +434,7 @@ int ext4_ext_migrate(struct inode *inode
 		 */
 		return retval;
 
-	percpu_down_write(&sbi->s_writepages_rwsem);
+	alloc_ctx = ext4_writepages_down_write(inode->i_sb);
 
 	/*
 	 * Worst case we can touch the allocation bitmaps and a block
@@ -586,7 +586,7 @@ out_tmp_inode:
 	unlock_new_inode(tmp_inode);
 	iput(tmp_inode);
 out_unlock:
-	percpu_up_write(&sbi->s_writepages_rwsem);
+	ext4_writepages_up_write(inode->i_sb, alloc_ctx);
 	return retval;
 }
 
@@ -605,6 +605,7 @@ int ext4_ind_migrate(struct inode *inode
 	ext4_fsblk_t			blk;
 	handle_t			*handle;
 	int				ret, ret2 = 0;
+	int				alloc_ctx;
 
 	if (!ext4_has_feature_extents(inode->i_sb) ||
 	    (!ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)))
@@ -621,7 +622,7 @@ int ext4_ind_migrate(struct inode *inode
 	if (test_opt(inode->i_sb, DELALLOC))
 		ext4_alloc_da_blocks(inode);
 
-	percpu_down_write(&sbi->s_writepages_rwsem);
+	alloc_ctx = ext4_writepages_down_write(inode->i_sb);
 
 	handle = ext4_journal_start(inode, EXT4_HT_MIGRATE, 1);
 	if (IS_ERR(handle)) {
@@ -665,6 +666,6 @@ errout:
 	ext4_journal_stop(handle);
 	up_write(&EXT4_I(inode)->i_data_sem);
 out_unlock:
-	percpu_up_write(&sbi->s_writepages_rwsem);
+	ext4_writepages_up_write(inode->i_sb, alloc_ctx);
 	return ret;
 }


