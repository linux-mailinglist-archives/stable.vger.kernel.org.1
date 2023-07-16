Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47E4D75569A
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232907AbjGPUwL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232775AbjGPUwK (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:52:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D3DDD9
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:52:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 02C8360EB0
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:52:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EBE5C433C8;
        Sun, 16 Jul 2023 20:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689540728;
        bh=4t5/bNFC02dYes9uoOJILvV3WGHTwwW0jVUd32v/GHY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NIeDONWn6oPaxleIJGgOY0c/O7CilV0+095SmyBt+1K5H6RRm2vsD16yWNxJCQ+iu
         ILLQTZdw1sbLaavRqgNeygZBj3bzqoeMC3AidjOb2RjNk4sKbpwYDIYwhXW3nT6ZYJ
         RaO0B1J+7EtZSJSJXOKqOHjWtmiDSuYFBU7CIFrA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        butt3rflyh4ck <butterflyhuangxx@gmail.com>,
        Chao Yu <chao@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 430/591] f2fs: fix to avoid NULL pointer dereference f2fs_write_end_io()
Date:   Sun, 16 Jul 2023 21:49:29 +0200
Message-ID: <20230716194935.042246110@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Chao Yu <chao@kernel.org>

[ Upstream commit d8189834d4348ae608083e1f1f53792cfcc2a9bc ]

butt3rflyh4ck reports a bug as below:

When a thread always calls F2FS_IOC_RESIZE_FS to resize fs, if resize fs is
failed, f2fs kernel thread would invoke callback function to update f2fs io
info, it would call  f2fs_write_end_io and may trigger null-ptr-deref in
NODE_MAPPING.

general protection fault, probably for non-canonical address
KASAN: null-ptr-deref in range [0x0000000000000030-0x0000000000000037]
RIP: 0010:NODE_MAPPING fs/f2fs/f2fs.h:1972 [inline]
RIP: 0010:f2fs_write_end_io+0x727/0x1050 fs/f2fs/data.c:370
 <TASK>
 bio_endio+0x5af/0x6c0 block/bio.c:1608
 req_bio_endio block/blk-mq.c:761 [inline]
 blk_update_request+0x5cc/0x1690 block/blk-mq.c:906
 blk_mq_end_request+0x59/0x4c0 block/blk-mq.c:1023
 lo_complete_rq+0x1c6/0x280 drivers/block/loop.c:370
 blk_complete_reqs+0xad/0xe0 block/blk-mq.c:1101
 __do_softirq+0x1d4/0x8ef kernel/softirq.c:571
 run_ksoftirqd kernel/softirq.c:939 [inline]
 run_ksoftirqd+0x31/0x60 kernel/softirq.c:931
 smpboot_thread_fn+0x659/0x9e0 kernel/smpboot.c:164
 kthread+0x33e/0x440 kernel/kthread.c:379
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

The root cause is below race case can cause leaving dirty metadata
in f2fs after filesystem is remount as ro:

Thread A				Thread B
- f2fs_ioc_resize_fs
 - f2fs_readonly   --- return false
 - f2fs_resize_fs
					- f2fs_remount
					 - write_checkpoint
					 - set f2fs as ro
  - free_segment_range
   - update meta_inode's data

Then, if f2fs_put_super()  fails to write_checkpoint due to readonly
status, and meta_inode's dirty data will be writebacked after node_inode
is put, finally, f2fs_write_end_io will access NULL pointer on
sbi->node_inode.

Thread A				IRQ context
- f2fs_put_super
 - write_checkpoint fails
 - iput(node_inode)
 - node_inode = NULL
 - iput(meta_inode)
  - write_inode_now
   - f2fs_write_meta_page
					- f2fs_write_end_io
					 - NODE_MAPPING(sbi)
					 : access NULL pointer on node_inode

Fixes: b4b10061ef98 ("f2fs: refactor resize_fs to avoid meta updates in progress")
Reported-by: butt3rflyh4ck <butterflyhuangxx@gmail.com>
Closes: https://lore.kernel.org/r/1684480657-2375-1-git-send-email-yangtiezhu@loongson.cn
Tested-by: butt3rflyh4ck <butterflyhuangxx@gmail.com>
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/f2fs.h |  2 +-
 fs/f2fs/file.c |  2 +-
 fs/f2fs/gc.c   | 21 ++++++++++++++++++---
 3 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 8d7dc76e6f935..4d1e48c676fab 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3817,7 +3817,7 @@ void f2fs_stop_gc_thread(struct f2fs_sb_info *sbi);
 block_t f2fs_start_bidx_of_node(unsigned int node_ofs, struct inode *inode);
 int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control);
 void f2fs_build_gc_manager(struct f2fs_sb_info *sbi);
-int f2fs_resize_fs(struct f2fs_sb_info *sbi, __u64 block_count);
+int f2fs_resize_fs(struct file *filp, __u64 block_count);
 int __init f2fs_create_garbage_collection_cache(void);
 void f2fs_destroy_garbage_collection_cache(void);
 
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 370c40858b42f..7b94f047cbf79 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3279,7 +3279,7 @@ static int f2fs_ioc_resize_fs(struct file *filp, unsigned long arg)
 			   sizeof(block_count)))
 		return -EFAULT;
 
-	return f2fs_resize_fs(sbi, block_count);
+	return f2fs_resize_fs(filp, block_count);
 }
 
 static int f2fs_ioc_enable_verity(struct file *filp, unsigned long arg)
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 7e497f5b349ce..3de887d07c060 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -2110,8 +2110,9 @@ static void update_fs_metadata(struct f2fs_sb_info *sbi, int secs)
 	}
 }
 
-int f2fs_resize_fs(struct f2fs_sb_info *sbi, __u64 block_count)
+int f2fs_resize_fs(struct file *filp, __u64 block_count)
 {
+	struct f2fs_sb_info *sbi = F2FS_I_SB(file_inode(filp));
 	__u64 old_block_count, shrunk_blocks;
 	struct cp_control cpc = { CP_RESIZE, 0, 0, 0 };
 	unsigned int secs;
@@ -2149,12 +2150,18 @@ int f2fs_resize_fs(struct f2fs_sb_info *sbi, __u64 block_count)
 		return -EINVAL;
 	}
 
+	err = mnt_want_write_file(filp);
+	if (err)
+		return err;
+
 	shrunk_blocks = old_block_count - block_count;
 	secs = div_u64(shrunk_blocks, BLKS_PER_SEC(sbi));
 
 	/* stop other GC */
-	if (!f2fs_down_write_trylock(&sbi->gc_lock))
-		return -EAGAIN;
+	if (!f2fs_down_write_trylock(&sbi->gc_lock)) {
+		err = -EAGAIN;
+		goto out_drop_write;
+	}
 
 	/* stop CP to protect MAIN_SEC in free_segment_range */
 	f2fs_lock_op(sbi);
@@ -2174,10 +2181,18 @@ int f2fs_resize_fs(struct f2fs_sb_info *sbi, __u64 block_count)
 out_unlock:
 	f2fs_unlock_op(sbi);
 	f2fs_up_write(&sbi->gc_lock);
+out_drop_write:
+	mnt_drop_write_file(filp);
 	if (err)
 		return err;
 
 	freeze_super(sbi->sb);
+
+	if (f2fs_readonly(sbi->sb)) {
+		thaw_super(sbi->sb);
+		return -EROFS;
+	}
+
 	f2fs_down_write(&sbi->gc_lock);
 	f2fs_down_write(&sbi->cp_global_sem);
 
-- 
2.39.2



