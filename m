Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7F4079B1F7
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377598AbjIKW1d (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239106AbjIKOL6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:11:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86CCEDE
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:11:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAA2FC433CA;
        Mon, 11 Sep 2023 14:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694441513;
        bh=FSFeApgv77ez1fnk35C6OXSXMwKOFJXYJ3HuWUUWQVc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q0swTtFnR6bdgGALfGd1Vsq5wOzhZWgv4eOHBUXyT3zuUNRSa3CDdcJEisxbpRjQG
         XhD27q5xz2Z4ZztGZGnIwCvQeEXzfXoFDkTLvTiCIPvut8MI1jv07wMHLF99QeGjpR
         fb39DQb/LqpZiA1OLyQWp+H27BN28Irhl4h46XE4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zhihao Cheng <chengzhihao1@huawei.com>,
        Jan Kara <jack@suse.cz>, Theodore Tso <tytso@mit.edu>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 440/739] ext4: fix unttached inode after power cut with orphan file feature enabled
Date:   Mon, 11 Sep 2023 15:43:59 +0200
Message-ID: <20230911134703.458840161@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

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
index 0caf6c730ce34..6bcc3770ee19f 100644
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
@@ -3436,6 +3437,7 @@ static int ext4_symlink(struct mnt_idmap *idmap, struct inode *dir,
 
 err_drop_inode:
 	clear_nlink(inode);
+	ext4_mark_inode_dirty(handle, inode);
 	ext4_orphan_add(handle, inode);
 	unlock_new_inode(inode);
 	if (handle)
@@ -4021,6 +4023,7 @@ static int ext4_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 			ext4_resetent(handle, &old,
 				      old.inode->i_ino, old_file_type);
 			drop_nlink(whiteout);
+			ext4_mark_inode_dirty(handle, whiteout);
 			ext4_orphan_add(handle, whiteout);
 		}
 		unlock_new_inode(whiteout);
-- 
2.40.1



