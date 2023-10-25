Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5311B7D6623
	for <lists+stable@lfdr.de>; Wed, 25 Oct 2023 11:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233692AbjJYJDK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 25 Oct 2023 05:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233714AbjJYJDJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Oct 2023 05:03:09 -0400
Received: from smtp.priv.miraclelinux.com (202x210x215x66.ap202.ftth.ucom.ne.jp [202.210.215.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F2EB192
        for <stable@vger.kernel.org>; Wed, 25 Oct 2023 02:03:07 -0700 (PDT)
Received: from cip-lava-a.miraclelinux.com (cip-lava-a.miraclelinux.com [10.2.1.116])
        by smtp.priv.miraclelinux.com (Postfix) with ESMTP id 77053140036;
        Wed, 25 Oct 2023 17:54:38 +0900 (JST)
From:   Kazunori Kobayashi <kazunori.kobayashi@miraclelinux.com>
To:     linux-f2fs-devel@lists.sourceforge.net
Cc:     hiraku.toyooka@miraclelinux.com, Chao Yu <chao@kernel.org>,
        stable@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Kazunori Kobayashi <kazunori.kobayashi@miraclelinux.com>
Subject: [PATCH 4.19] f2fs: fix to do sanity check on inode type during garbage collection
Date:   Wed, 25 Oct 2023 08:54:32 +0000
Message-Id: <20231025085432.11639-1-kazunori.kobayashi@miraclelinux.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SORBS_DUL,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Chao Yu <chao@kernel.org>

commit 9056d6489f5a41cfbb67f719d2c0ce61ead72d9f upstream.

As report by Wenqing Liu in bugzilla:

https://bugzilla.kernel.org/show_bug.cgi?id=215231

- Overview
kernel NULL pointer dereference triggered  in folio_mark_dirty() when mount and operate on a crafted f2fs image

- Reproduce
tested on kernel 5.16-rc3, 5.15.X under root

1. mkdir mnt
2. mount -t f2fs tmp1.img mnt
3. touch tmp
4. cp tmp mnt

F2FS-fs (loop0): sanity_check_inode: inode (ino=49) extent info [5942, 4294180864, 4] is incorrect, run fsck to fix
F2FS-fs (loop0): f2fs_check_nid_range: out-of-range nid=31340049, run fsck to fix.
BUG: kernel NULL pointer dereference, address: 0000000000000000
 folio_mark_dirty+0x33/0x50
 move_data_page+0x2dd/0x460 [f2fs]
 do_garbage_collect+0xc18/0x16a0 [f2fs]
 f2fs_gc+0x1d3/0xd90 [f2fs]
 f2fs_balance_fs+0x13a/0x570 [f2fs]
 f2fs_create+0x285/0x840 [f2fs]
 path_openat+0xe6d/0x1040
 do_filp_open+0xc5/0x140
 do_sys_openat2+0x23a/0x310
 do_sys_open+0x57/0x80

The root cause is for special file: e.g. character, block, fifo or socket file,
f2fs doesn't assign address space operations pointer array for mapping->a_ops field,
so, in a fuzzed image, SSA table indicates a data block belong to special file, when
f2fs tries to migrate that block, it causes NULL pointer access once move_data_page()
calls a_ops->set_dirty_page().

Cc: stable@vger.kernel.org
Reported-by: Wenqing Liu <wenqingliu0120@gmail.com>
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Kazunori Kobayashi <kazunori.kobayashi@miraclelinux.com>
---
 fs/f2fs/gc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index ff447bbb5248..fb4494c54484 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -958,7 +958,8 @@ static void gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 
 		if (phase == 3) {
 			inode = f2fs_iget(sb, dni.ino);
-			if (IS_ERR(inode) || is_bad_inode(inode))
+			if (IS_ERR(inode) || is_bad_inode(inode) ||
+					special_file(inode->i_mode))
 				continue;
 
 			if (!down_write_trylock(
-- 
2.39.2

