Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 667C875BE39
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 08:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjGUGFz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 02:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbjGUGFZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 02:05:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31BBF1BEF
        for <stable@vger.kernel.org>; Thu, 20 Jul 2023 23:04:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A6C13612B3
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 06:04:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D8E8C433C7;
        Fri, 21 Jul 2023 06:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689919448;
        bh=VyCBvbFQGRMSfL7mSBYzMY1ItmHfvtMJIXl3yH79Ow8=;
        h=Subject:To:Cc:From:Date:From;
        b=oiu6wp1MW5uDeXg19VwPKU1WQ1vZ2Cp9guVDYv4802MvGWkOzxLtk4q8n94GOrA6K
         Jx9OsSriR1iMZAmnsTZ1G1Xht557gIMsta/Wk/rECEW80P80RG10KRa9gz/IlKrmhJ
         j54HSl/Z1LXs4XMMzzHj/W1nb+k0f7AnrOV5ngeI=
Subject: FAILED: patch "[PATCH] ext4: Fix reusing stale buffer heads from last failed" failed to apply to 5.4-stable tree
To:     chengzhihao1@huawei.com, jack@suse.cz, tytso@mit.edu
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 21 Jul 2023 08:04:06 +0200
Message-ID: <2023072106-retrial-nature-2689@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 26fb5290240dc31cae99b8b4dd2af7f46dfcba6b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023072106-retrial-nature-2689@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

26fb5290240d ("ext4: Fix reusing stale buffer heads from last failed mounting")
ee7ed3aa0f08 ("ext4: rename journal_dev to s_journal_dev inside ext4_sb_info")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 26fb5290240dc31cae99b8b4dd2af7f46dfcba6b Mon Sep 17 00:00:00 2001
From: Zhihao Cheng <chengzhihao1@huawei.com>
Date: Wed, 15 Mar 2023 09:31:23 +0800
Subject: [PATCH] ext4: Fix reusing stale buffer heads from last failed
 mounting

Following process makes ext4 load stale buffer heads from last failed
mounting in a new mounting operation:
mount_bdev
 ext4_fill_super
 | ext4_load_and_init_journal
 |  ext4_load_journal
 |   jbd2_journal_load
 |    load_superblock
 |     journal_get_superblock
 |      set_buffer_verified(bh) // buffer head is verified
 |   jbd2_journal_recover // failed caused by EIO
 | goto failed_mount3a // skip 'sb->s_root' initialization
 deactivate_locked_super
  kill_block_super
   generic_shutdown_super
    if (sb->s_root)
    // false, skip ext4_put_super->invalidate_bdev->
    // invalidate_mapping_pages->mapping_evict_folio->
    // filemap_release_folio->try_to_free_buffers, which
    // cannot drop buffer head.
   blkdev_put
    blkdev_put_whole
     if (atomic_dec_and_test(&bdev->bd_openers))
     // false, systemd-udev happens to open the device. Then
     // blkdev_flush_mapping->kill_bdev->truncate_inode_pages->
     // truncate_inode_folio->truncate_cleanup_folio->
     // folio_invalidate->block_invalidate_folio->
     // filemap_release_folio->try_to_free_buffers will be skipped,
     // dropping buffer head is missed again.

Second mount:
ext4_fill_super
 ext4_load_and_init_journal
  ext4_load_journal
   ext4_get_journal
    jbd2_journal_init_inode
     journal_init_common
      bh = getblk_unmovable
       bh = __find_get_block // Found stale bh in last failed mounting
      journal->j_sb_buffer = bh
   jbd2_journal_load
    load_superblock
     journal_get_superblock
      if (buffer_verified(bh))
      // true, skip journal->j_format_version = 2, value is 0
    jbd2_journal_recover
     do_one_pass
      next_log_block += count_tags(journal, bh)
      // According to journal_tag_bytes(), 'tag_bytes' calculating is
      // affected by jbd2_has_feature_csum3(), jbd2_has_feature_csum3()
      // returns false because 'j->j_format_version >= 2' is not true,
      // then we get wrong next_log_block. The do_one_pass may exit
      // early whenoccuring non JBD2_MAGIC_NUMBER in 'next_log_block'.

The filesystem is corrupted here, journal is partially replayed, and
new journal sequence number actually is already used by last mounting.

The invalidate_bdev() can drop all buffer heads even racing with bare
reading block device(eg. systemd-udev), so we can fix it by invalidating
bdev in error handling path in __ext4_fill_super().

Fetch a reproducer in [Link].

Link: https://bugzilla.kernel.org/show_bug.cgi?id=217171
Fixes: 25ed6e8a54df ("jbd2: enable journal clients to enable v2 checksumming")
Cc: stable@vger.kernel.org # v3.5
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20230315013128.3911115-2-chengzhihao1@huawei.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 7f9b087b9b20..6a8c5c3c9126 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1128,6 +1128,12 @@ static void ext4_blkdev_remove(struct ext4_sb_info *sbi)
 	struct block_device *bdev;
 	bdev = sbi->s_journal_bdev;
 	if (bdev) {
+		/*
+		 * Invalidate the journal device's buffers.  We don't want them
+		 * floating about in memory - the physical journal device may
+		 * hotswapped, and it breaks the `ro-after' testing code.
+		 */
+		invalidate_bdev(bdev);
 		ext4_blkdev_put(bdev);
 		sbi->s_journal_bdev = NULL;
 	}
@@ -1328,13 +1334,7 @@ static void ext4_put_super(struct super_block *sb)
 	sync_blockdev(sb->s_bdev);
 	invalidate_bdev(sb->s_bdev);
 	if (sbi->s_journal_bdev && sbi->s_journal_bdev != sb->s_bdev) {
-		/*
-		 * Invalidate the journal device's buffers.  We don't want them
-		 * floating about in memory - the physical journal device may
-		 * hotswapped, and it breaks the `ro-after' testing code.
-		 */
 		sync_blockdev(sbi->s_journal_bdev);
-		invalidate_bdev(sbi->s_journal_bdev);
 		ext4_blkdev_remove(sbi);
 	}
 
@@ -5655,6 +5655,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 	brelse(sbi->s_sbh);
 	ext4_blkdev_remove(sbi);
 out_fail:
+	invalidate_bdev(sb->s_bdev);
 	sb->s_fs_info = NULL;
 	return err;
 }

