Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5E3677AC8A
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232056AbjHMVeR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232048AbjHMVeQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:34:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 878DB10F5
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:34:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 25F2462C4B
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:34:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35E6DC433C8;
        Sun, 13 Aug 2023 21:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691962456;
        bh=15wlXXtqclz+Ns1jYZxbdLnWih14cMx6AIe2qjz4U/g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HMQbX9F84okZur3GoOBCVX3d1wGngrTqHWezIfXLV4JP8FIWY3XEvBAYDIOzOjrF0
         HWK/HxvqWX2gZ4+0m/rdsFW17CwYSKoUjqVy1OVEr+3BFPUGEmHxYj/AXWPjoD3SKO
         YXqRmdHunm962jyksw8Jd4sienm+sDxZAhqMj3sI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        syzbot+74db8b3087f293d3a13a@syzkaller.appspotmail.com,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.1 036/149] nilfs2: fix use-after-free of nilfs_root in dirtying inodes via iput
Date:   Sun, 13 Aug 2023 23:18:01 +0200
Message-ID: <20230813211719.888271996@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211718.757428827@linuxfoundation.org>
References: <20230813211718.757428827@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Ryusuke Konishi <konishi.ryusuke@gmail.com>

commit f8654743a0e6909dc634cbfad6db6816f10f3399 upstream.

During unmount process of nilfs2, nothing holds nilfs_root structure after
nilfs2 detaches its writer in nilfs_detach_log_writer().  Previously,
nilfs_evict_inode() could cause use-after-free read for nilfs_root if
inodes are left in "garbage_list" and released by nilfs_dispose_list at
the end of nilfs_detach_log_writer(), and this bug was fixed by commit
9b5a04ac3ad9 ("nilfs2: fix use-after-free bug of nilfs_root in
nilfs_evict_inode()").

However, it turned out that there is another possibility of UAF in the
call path where mark_inode_dirty_sync() is called from iput():

nilfs_detach_log_writer()
  nilfs_dispose_list()
    iput()
      mark_inode_dirty_sync()
        __mark_inode_dirty()
          nilfs_dirty_inode()
            __nilfs_mark_inode_dirty()
              nilfs_load_inode_block() --> causes UAF of nilfs_root struct

This can happen after commit 0ae45f63d4ef ("vfs: add support for a
lazytime mount option"), which changed iput() to call
mark_inode_dirty_sync() on its final reference if i_state has I_DIRTY_TIME
flag and i_nlink is non-zero.

This issue appears after commit 28a65b49eb53 ("nilfs2: do not write dirty
data after degenerating to read-only") when using the syzbot reproducer,
but the issue has potentially existed before.

Fix this issue by adding a "purging flag" to the nilfs structure, setting
that flag while disposing the "garbage_list" and checking it in
__nilfs_mark_inode_dirty().

Unlike commit 9b5a04ac3ad9 ("nilfs2: fix use-after-free bug of nilfs_root
in nilfs_evict_inode()"), this patch does not rely on ns_writer to
determine whether to skip operations, so as not to break recovery on
mount.  The nilfs_salvage_orphan_logs routine dirties the buffer of
salvaged data before attaching the log writer, so changing
__nilfs_mark_inode_dirty() to skip the operation when ns_writer is NULL
will cause recovery write to fail.  The purpose of using the cleanup-only
flag is to allow for narrowing of such conditions.

Link: https://lkml.kernel.org/r/20230728191318.33047-1-konishi.ryusuke@gmail.com
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Reported-by: syzbot+74db8b3087f293d3a13a@syzkaller.appspotmail.com
Closes: https://lkml.kernel.org/r/000000000000b4e906060113fd63@google.com
Fixes: 0ae45f63d4ef ("vfs: add support for a lazytime mount option")
Tested-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: <stable@vger.kernel.org> # 4.0+
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nilfs2/inode.c     |    8 ++++++++
 fs/nilfs2/segment.c   |    2 ++
 fs/nilfs2/the_nilfs.h |    2 ++
 3 files changed, 12 insertions(+)

--- a/fs/nilfs2/inode.c
+++ b/fs/nilfs2/inode.c
@@ -1101,9 +1101,17 @@ int nilfs_set_file_dirty(struct inode *i
 
 int __nilfs_mark_inode_dirty(struct inode *inode, int flags)
 {
+	struct the_nilfs *nilfs = inode->i_sb->s_fs_info;
 	struct buffer_head *ibh;
 	int err;
 
+	/*
+	 * Do not dirty inodes after the log writer has been detached
+	 * and its nilfs_root struct has been freed.
+	 */
+	if (unlikely(nilfs_purging(nilfs)))
+		return 0;
+
 	err = nilfs_load_inode_block(inode, &ibh);
 	if (unlikely(err)) {
 		nilfs_warn(inode->i_sb,
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -2843,6 +2843,7 @@ void nilfs_detach_log_writer(struct supe
 		nilfs_segctor_destroy(nilfs->ns_writer);
 		nilfs->ns_writer = NULL;
 	}
+	set_nilfs_purging(nilfs);
 
 	/* Force to free the list of dirty files */
 	spin_lock(&nilfs->ns_inode_lock);
@@ -2855,4 +2856,5 @@ void nilfs_detach_log_writer(struct supe
 	up_write(&nilfs->ns_segctor_sem);
 
 	nilfs_dispose_list(nilfs, &garbage_list, 1);
+	clear_nilfs_purging(nilfs);
 }
--- a/fs/nilfs2/the_nilfs.h
+++ b/fs/nilfs2/the_nilfs.h
@@ -29,6 +29,7 @@ enum {
 	THE_NILFS_DISCONTINUED,	/* 'next' pointer chain has broken */
 	THE_NILFS_GC_RUNNING,	/* gc process is running */
 	THE_NILFS_SB_DIRTY,	/* super block is dirty */
+	THE_NILFS_PURGING,	/* disposing dirty files for cleanup */
 };
 
 /**
@@ -208,6 +209,7 @@ THE_NILFS_FNS(INIT, init)
 THE_NILFS_FNS(DISCONTINUED, discontinued)
 THE_NILFS_FNS(GC_RUNNING, gc_running)
 THE_NILFS_FNS(SB_DIRTY, sb_dirty)
+THE_NILFS_FNS(PURGING, purging)
 
 /*
  * Mount option operations


