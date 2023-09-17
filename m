Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4B67A3C13
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240905AbjIQU0N (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240938AbjIQU0B (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:26:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 212B8101
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:25:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B0FAC433C7;
        Sun, 17 Sep 2023 20:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694982355;
        bh=pPzdarMD75wZwxhHbbjEvCxr6rjQRc9X6SOBCsTM0uA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dBF4J6Z7u63kGOeCMZjSCdE03OC80vzc5cOdFZu1TfC1xeUkbPlfRyft1QCtam9+2
         Nrp29RKiBPg3orvbf+xzvZYrGVIodLHi2n7VgX3mfwrMTb30oLpuF57CPxJ/KpI0If
         PPyFOmXNzMGg7Ysqzh51oOg0t0ZtgTgcYrdsldWM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zhihao Cheng <chengzhihao1@huawei.com>,
        Jan Kara <jack@suse.cz>, Theodore Tso <tytso@mit.edu>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 227/511] ext4: fix unttached inode after power cut with orphan file feature enabled
Date:   Sun, 17 Sep 2023 21:10:54 +0200
Message-ID: <20230917191119.288800312@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191113.831992765@linuxfoundation.org>
References: <20230917191113.831992765@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhihao Cheng <chengzhihao1@huawei.com>

[ Upstream commit 1524773425ae8113b0b782886366e68656b34e53 ]

Running generic/475(filesystem consistent tests after power cut) could
easily trigger unattached inode error while doing fsck:
  Unattached zero-length inode 39405.  Clear? no

  Unattached inode 39405
  Connect to /lost+found? no

Above inconsistence is caused by following process:
       P1                       P2
ext4_create
 inode = ext4_new_inode_start_handle  // itable records nlink=1
 ext4_add_nondir
   err = ext4_add_entry  // ENOSPC
    ext4_append
     ext4_bread
      ext4_getblk
       ext4_map_blocks // returns ENOSPC
   drop_nlink(inode) // won't be updated into disk inode
   ext4_orphan_add(handle, inode)
    ext4_orphan_file_add
 ext4_journal_stop(handle)
		      jbd2_journal_commit_transaction // commit success
              >> power cut <<
ext4_fill_super
 ext4_load_and_init_journal   // itable records nlink=1
 ext4_orphan_cleanup
  ext4_process_orphan
   if (inode->i_nlink)        // true, inode won't be deleted

Then, allocated inode will be reserved on disk and corresponds to no
dentries, so e2fsck reports 'unattached inode' problem.

The problem won't happen if orphan file feature is disabled, because
ext4_orphan_add() will update disk inode in orphan list mode. There
are several places not updating disk inode while putting inode into
orphan area, such as ext4_add_nondir(), ext4_symlink() and whiteout
in ext4_rename(). Fix it by updating inode into disk in all error
branches of these places.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=217605
Fixes: 02f310fcf47f ("ext4: Speedup ext4 orphan inode handling")
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20230628132011.650383-1-chengzhihao1@huawei.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/namei.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 2629e90f8dbb5..d44fe5b1a7255 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -2799,6 +2799,7 @@ static int ext4_add_nondir(handle_t *handle,
 		return err;
 	}
 	drop_nlink(inode);
+	ext4_mark_inode_dirty(handle, inode);
 	ext4_orphan_add(handle, inode);
 	unlock_new_inode(inode);
 	return err;
@@ -3455,6 +3456,7 @@ static int ext4_symlink(struct user_namespace *mnt_userns, struct inode *dir,
 	if (handle)
 		ext4_journal_stop(handle);
 	clear_nlink(inode);
+	ext4_mark_inode_dirty(handle, inode);
 	unlock_new_inode(inode);
 	iput(inode);
 out_free_encrypted_link:
@@ -4028,6 +4030,7 @@ static int ext4_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 			ext4_resetent(handle, &old,
 				      old.inode->i_ino, old_file_type);
 			drop_nlink(whiteout);
+			ext4_mark_inode_dirty(handle, whiteout);
 			ext4_orphan_add(handle, whiteout);
 		}
 		unlock_new_inode(whiteout);
-- 
2.40.1



