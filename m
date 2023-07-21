Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51D1975D3AF
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbjGUTN2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231902AbjGUTN0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:13:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5066630ED
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:13:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C680B61D02
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:13:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8794C433C7;
        Fri, 21 Jul 2023 19:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689966804;
        bh=914J9IonftyI8kXIwYxtXjo3XX4hexMAHCqqEnE1Um8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fhLkibFUYdJcHyRvCenu5+hHcP47fPAiMm0JHg2XL6kONqOUDu0Qaehb2Y+++o/LC
         vqgfCyVU8BswalZ1G0zoHrvTmj7R9O1znMV2PXQFRBdD6NF4iavsyGG0mperVKdWJk
         4+TuigFuGOdPW1DdYDQSXjE6CWpmrLOehLB8kEC8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        butt3rflyh4ck <butterflyhuangxx@gmail.com>,
        Chao Yu <chao@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Stefan Ghinea <stefan.ghinea@windriver.com>
Subject: [PATCH 5.15 445/532] f2fs: fix to avoid NULL pointer dereference f2fs_write_end_io()
Date:   Fri, 21 Jul 2023 18:05:49 +0200
Message-ID: <20230721160638.686048385@linuxfoundation.org>
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

From: Chao Yu <chao@kernel.org>

commit d8189834d4348ae608083e1f1f53792cfcc2a9bc upstream.

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
Signed-off-by: Stefan Ghinea <stefan.ghinea@windriver.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/f2fs/f2fs.h |    2 +-
 fs/f2fs/file.c |    2 +-
 fs/f2fs/gc.c   |   21 ++++++++++++++++++---
 3 files changed, 20 insertions(+), 5 deletions(-)

--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3660,7 +3660,7 @@ block_t f2fs_start_bidx_of_node(unsigned
 int f2fs_gc(struct f2fs_sb_info *sbi, bool sync, bool background, bool force,
 			unsigned int segno);
 void f2fs_build_gc_manager(struct f2fs_sb_info *sbi);
-int f2fs_resize_fs(struct f2fs_sb_info *sbi, __u64 block_count);
+int f2fs_resize_fs(struct file *filp, __u64 block_count);
 int __init f2fs_create_garbage_collection_cache(void);
 void f2fs_destroy_garbage_collection_cache(void);
 
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3251,7 +3251,7 @@ static int f2fs_ioc_resize_fs(struct fil
 			   sizeof(block_count)))
 		return -EFAULT;
 
-	return f2fs_resize_fs(sbi, block_count);
+	return f2fs_resize_fs(filp, block_count);
 }
 
 static int f2fs_ioc_enable_verity(struct file *filp, unsigned long arg)
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1992,8 +1992,9 @@ static void update_fs_metadata(struct f2
 	}
 }
 
-int f2fs_resize_fs(struct f2fs_sb_info *sbi, __u64 block_count)
+int f2fs_resize_fs(struct file *filp, __u64 block_count)
 {
+	struct f2fs_sb_info *sbi = F2FS_I_SB(file_inode(filp));
 	__u64 old_block_count, shrunk_blocks;
 	struct cp_control cpc = { CP_RESIZE, 0, 0, 0 };
 	unsigned int secs;
@@ -2031,12 +2032,18 @@ int f2fs_resize_fs(struct f2fs_sb_info *
 		return -EINVAL;
 	}
 
+	err = mnt_want_write_file(filp);
+	if (err)
+		return err;
+
 	shrunk_blocks = old_block_count - block_count;
 	secs = div_u64(shrunk_blocks, BLKS_PER_SEC(sbi));
 
 	/* stop other GC */
-	if (!down_write_trylock(&sbi->gc_lock))
-		return -EAGAIN;
+	if (!down_write_trylock(&sbi->gc_lock)) {
+		err = -EAGAIN;
+		goto out_drop_write;
+	}
 
 	/* stop CP to protect MAIN_SEC in free_segment_range */
 	f2fs_lock_op(sbi);
@@ -2056,10 +2063,18 @@ int f2fs_resize_fs(struct f2fs_sb_info *
 out_unlock:
 	f2fs_unlock_op(sbi);
 	up_write(&sbi->gc_lock);
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
 	down_write(&sbi->gc_lock);
 	down_write(&sbi->cp_global_sem);
 


