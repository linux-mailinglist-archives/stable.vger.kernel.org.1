Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80B5E70C6B6
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234399AbjEVTVa (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234385AbjEVTVa (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:21:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FFEFA3
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:21:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC1CB62811
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:21:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7214C433EF;
        Mon, 22 May 2023 19:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684783288;
        bh=S+BtWaFf8CqqZuuJLbLdVPaXC/TY9ZZpeGrDz0O8vNQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JF5+KUXAUs28Jgl50fk6RVxDwfWkwS+frRr9IG9d6RQMjxNkyDOYKbYHPocjVHcto
         2B+t1mSOZ2I3d7SGqKqsh5IWZsKQF3byXVZsRDjXDOyi81+nT02s1Le7ee8IAAvg/s
         hFJy3DELi64/Yiw+0/5mfM/4b7Tw0oTeSw93lkK0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        syzbot+78d4495558999f55d1da@syzkaller.appspotmail.com,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 5.15 199/203] nilfs2: fix use-after-free bug of nilfs_root in nilfs_evict_inode()
Date:   Mon, 22 May 2023 20:10:23 +0100
Message-Id: <20230522190400.547611810@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190354.935300867@linuxfoundation.org>
References: <20230522190354.935300867@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Ryusuke Konishi <konishi.ryusuke@gmail.com>

commit 9b5a04ac3ad9898c4745cba46ea26de74ba56a8e upstream.

During unmount process of nilfs2, nothing holds nilfs_root structure after
nilfs2 detaches its writer in nilfs_detach_log_writer().  However, since
nilfs_evict_inode() uses nilfs_root for some cleanup operations, it may
cause use-after-free read if inodes are left in "garbage_list" and
released by nilfs_dispose_list() at the end of nilfs_detach_log_writer().

Fix this issue by modifying nilfs_evict_inode() to only clear inode
without additional metadata changes that use nilfs_root if the file system
is degraded to read-only or the writer is detached.

Link: https://lkml.kernel.org/r/20230509152956.8313-1-konishi.ryusuke@gmail.com
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Reported-by: syzbot+78d4495558999f55d1da@syzkaller.appspotmail.com
Closes: https://lkml.kernel.org/r/00000000000099e5ac05fb1c3b85@google.com
Tested-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nilfs2/inode.c |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

--- a/fs/nilfs2/inode.c
+++ b/fs/nilfs2/inode.c
@@ -921,6 +921,7 @@ void nilfs_evict_inode(struct inode *ino
 	struct nilfs_transaction_info ti;
 	struct super_block *sb = inode->i_sb;
 	struct nilfs_inode_info *ii = NILFS_I(inode);
+	struct the_nilfs *nilfs;
 	int ret;
 
 	if (inode->i_nlink || !ii->i_root || unlikely(is_bad_inode(inode))) {
@@ -933,6 +934,23 @@ void nilfs_evict_inode(struct inode *ino
 
 	truncate_inode_pages_final(&inode->i_data);
 
+	nilfs = sb->s_fs_info;
+	if (unlikely(sb_rdonly(sb) || !nilfs->ns_writer)) {
+		/*
+		 * If this inode is about to be disposed after the file system
+		 * has been degraded to read-only due to file system corruption
+		 * or after the writer has been detached, do not make any
+		 * changes that cause writes, just clear it.
+		 * Do this check after read-locking ns_segctor_sem by
+		 * nilfs_transaction_begin() in order to avoid a race with
+		 * the writer detach operation.
+		 */
+		clear_inode(inode);
+		nilfs_clear_inode(inode);
+		nilfs_transaction_abort(sb);
+		return;
+	}
+
 	/* TODO: some of the following operations may fail.  */
 	nilfs_truncate_bmap(ii, 0);
 	nilfs_mark_inode_dirty(inode);


