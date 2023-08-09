Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA4DC7757EF
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 12:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232312AbjHIKub (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 06:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232297AbjHIKuO (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 06:50:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7624710FF
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 03:50:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D3EA62835
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 10:50:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 193FCC433C9;
        Wed,  9 Aug 2023 10:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691578212;
        bh=FjEX5l3mKlIfjp7b7M8r7uN5sP6NVLXum/qYlvvVsz8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eqHpK1lHoql19i22Xdil6pmtXxwIUvjLi/cDWwjB9VzVyy0At5KW2eup3juCFpr1A
         IE+mdD74ppvALGXFy9xLIPqE4pJltZ59wtuGT94UlaTNiUhts2HOEdVtgAW/5lfxKl
         k63S45+a1O2/CTX9MV119rqn16szXHYwPL5jADAg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Chao Yu <chao@kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        syzbot+12cb4425b22169b52036@syzkaller.appspotmail.com
Subject: [PATCH 6.4 146/165] f2fs: fix to do sanity check on direct node in truncate_dnode()
Date:   Wed,  9 Aug 2023 12:41:17 +0200
Message-ID: <20230809103647.569118702@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103642.720851262@linuxfoundation.org>
References: <20230809103642.720851262@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Chao Yu <chao@kernel.org>

commit a6ec83786ab9f13f25fb18166dee908845713a95 upstream.

syzbot reports below bug:

BUG: KASAN: slab-use-after-free in f2fs_truncate_data_blocks_range+0x122a/0x14c0 fs/f2fs/file.c:574
Read of size 4 at addr ffff88802a25c000 by task syz-executor148/5000

CPU: 1 PID: 5000 Comm: syz-executor148 Not tainted 6.4.0-rc7-syzkaller-00041-ge660abd551f1 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 print_address_description.constprop.0+0x2c/0x3c0 mm/kasan/report.c:351
 print_report mm/kasan/report.c:462 [inline]
 kasan_report+0x11c/0x130 mm/kasan/report.c:572
 f2fs_truncate_data_blocks_range+0x122a/0x14c0 fs/f2fs/file.c:574
 truncate_dnode+0x229/0x2e0 fs/f2fs/node.c:944
 f2fs_truncate_inode_blocks+0x64b/0xde0 fs/f2fs/node.c:1154
 f2fs_do_truncate_blocks+0x4ac/0xf30 fs/f2fs/file.c:721
 f2fs_truncate_blocks+0x7b/0x300 fs/f2fs/file.c:749
 f2fs_truncate.part.0+0x4a5/0x630 fs/f2fs/file.c:799
 f2fs_truncate include/linux/fs.h:825 [inline]
 f2fs_setattr+0x1738/0x2090 fs/f2fs/file.c:1006
 notify_change+0xb2c/0x1180 fs/attr.c:483
 do_truncate+0x143/0x200 fs/open.c:66
 handle_truncate fs/namei.c:3295 [inline]
 do_open fs/namei.c:3640 [inline]
 path_openat+0x2083/0x2750 fs/namei.c:3791
 do_filp_open+0x1ba/0x410 fs/namei.c:3818
 do_sys_openat2+0x16d/0x4c0 fs/open.c:1356
 do_sys_open fs/open.c:1372 [inline]
 __do_sys_creat fs/open.c:1448 [inline]
 __se_sys_creat fs/open.c:1442 [inline]
 __x64_sys_creat+0xcd/0x120 fs/open.c:1442
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The root cause is, inodeA references inodeB via inodeB's ino, once inodeA
is truncated, it calls truncate_dnode() to truncate data blocks in inodeB's
node page, it traverse mapping data from node->i.i_addr[0] to
node->i.i_addr[ADDRS_PER_BLOCK() - 1], result in out-of-boundary access.

This patch fixes to add sanity check on dnode page in truncate_dnode(),
so that, it can help to avoid triggering such issue, and once it encounters
such issue, it will record newly introduced ERROR_INVALID_NODE_REFERENCE
error into superblock, later fsck can detect such issue and try repairing.

Also, it removes f2fs_truncate_data_blocks() for cleanup due to the
function has only one caller, and uses f2fs_truncate_data_blocks_range()
instead.

Reported-and-tested-by: syzbot+12cb4425b22169b52036@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-f2fs-devel/000000000000f3038a05fef867f8@google.com
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/f2fs/f2fs.h          |    1 -
 fs/f2fs/file.c          |    5 -----
 fs/f2fs/node.c          |   14 ++++++++++++--
 include/linux/f2fs_fs.h |    1 +
 4 files changed, 13 insertions(+), 8 deletions(-)

--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3445,7 +3445,6 @@ static inline bool __is_valid_data_blkad
  * file.c
  */
 int f2fs_sync_file(struct file *file, loff_t start, loff_t end, int datasync);
-void f2fs_truncate_data_blocks(struct dnode_of_data *dn);
 int f2fs_do_truncate_blocks(struct inode *inode, u64 from, bool lock);
 int f2fs_truncate_blocks(struct inode *inode, u64 from, bool lock);
 int f2fs_truncate(struct inode *inode);
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -627,11 +627,6 @@ void f2fs_truncate_data_blocks_range(str
 					 dn->ofs_in_node, nr_free);
 }
 
-void f2fs_truncate_data_blocks(struct dnode_of_data *dn)
-{
-	f2fs_truncate_data_blocks_range(dn, ADDRS_PER_BLOCK(dn->inode));
-}
-
 static int truncate_partial_data_page(struct inode *inode, u64 from,
 								bool cache_only)
 {
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -925,6 +925,7 @@ static int truncate_node(struct dnode_of
 
 static int truncate_dnode(struct dnode_of_data *dn)
 {
+	struct f2fs_sb_info *sbi = F2FS_I_SB(dn->inode);
 	struct page *page;
 	int err;
 
@@ -932,16 +933,25 @@ static int truncate_dnode(struct dnode_o
 		return 1;
 
 	/* get direct node */
-	page = f2fs_get_node_page(F2FS_I_SB(dn->inode), dn->nid);
+	page = f2fs_get_node_page(sbi, dn->nid);
 	if (PTR_ERR(page) == -ENOENT)
 		return 1;
 	else if (IS_ERR(page))
 		return PTR_ERR(page);
 
+	if (IS_INODE(page) || ino_of_node(page) != dn->inode->i_ino) {
+		f2fs_err(sbi, "incorrect node reference, ino: %lu, nid: %u, ino_of_node: %u",
+				dn->inode->i_ino, dn->nid, ino_of_node(page));
+		set_sbi_flag(sbi, SBI_NEED_FSCK);
+		f2fs_handle_error(sbi, ERROR_INVALID_NODE_REFERENCE);
+		f2fs_put_page(page, 1);
+		return -EFSCORRUPTED;
+	}
+
 	/* Make dnode_of_data for parameter */
 	dn->node_page = page;
 	dn->ofs_in_node = 0;
-	f2fs_truncate_data_blocks(dn);
+	f2fs_truncate_data_blocks_range(dn, ADDRS_PER_BLOCK(dn->inode));
 	err = truncate_node(dn);
 	if (err) {
 		f2fs_put_page(page, 1);
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -103,6 +103,7 @@ enum f2fs_error {
 	ERROR_INCONSISTENT_SIT,
 	ERROR_CORRUPTED_VERITY_XATTR,
 	ERROR_CORRUPTED_XATTR,
+	ERROR_INVALID_NODE_REFERENCE,
 	ERROR_MAX,
 };
 


