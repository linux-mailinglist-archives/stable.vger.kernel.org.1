Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 647D975D3A3
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbjGUTM4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231902AbjGUTMx (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:12:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8460630EA
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:12:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D7DA461D70
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:12:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4FD1C433C7;
        Fri, 21 Jul 2023 19:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689966770;
        bh=gR0UuzEL7MF1LC4l+ehYTsAWvYBneRxN+0nxSNbIjC0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wTkcZ6mmyqPi3rpH2HFoYT6AMsFCWOOLGMd+bdvjTlh2QG3I1C8aQaCY66+jb8Hsz
         Vnd2UHmhhoT8onKmZoFJr/ghmHVBlOPKVxkyahaqV1AN5T6lql57ASY4ZBGrZQZ18X
         s3mxCRQdi8aqfoczd6x+eoxUjtoskn0TrgBBknmg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zhihao Cheng <chengzhihao1@huawei.com>,
        Jan Kara <jack@suse.cz>, Theodore Tso <tytso@mit.edu>
Subject: [PATCH 5.15 461/532] ext4: Fix reusing stale buffer heads from last failed mounting
Date:   Fri, 21 Jul 2023 18:06:05 +0200
Message-ID: <20230721160639.534415710@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Zhihao Cheng <chengzhihao1@huawei.com>

commit 26fb5290240dc31cae99b8b4dd2af7f46dfcba6b upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ext4/super.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1097,6 +1097,12 @@ static void ext4_blkdev_remove(struct ex
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
@@ -1239,13 +1245,7 @@ static void ext4_put_super(struct super_
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
 
@@ -5100,6 +5100,7 @@ failed_mount:
 	brelse(bh);
 	ext4_blkdev_remove(sbi);
 out_fail:
+	invalidate_bdev(sb->s_bdev);
 	sb->s_fs_info = NULL;
 	kfree(sbi->s_blockgroup_lock);
 out_free_base:


