Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25CFE7E2464
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232394AbjKFNVY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:21:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232384AbjKFNVW (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:21:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C70F1112
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:21:19 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7F07C433C7;
        Mon,  6 Nov 2023 13:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699276879;
        bh=af6Q6hF1pjAiLv8rVysV4wx1GLrGQWCbDcW7OUgnYZo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aJkTYoqWTsC6eiHeyRPxj3Wixw45dj766AgYEk+ghxSvxOoSVdOlIAGMud6Hh0V2o
         KWty7O5aZTo+vgDPFa3vzSv8P0UD7uX7j9zdJRcbzDxkCuBY2rxZGPGWoaGkfAOVt4
         ajrdNkp63mrRunJWG5RBiaTD9wsOTIlaaWov1EN4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Wenqing Liu <wenqingliu0120@gmail.com>,
        Chao Yu <chao@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Kazunori Kobayashi <kazunori.kobayashi@miraclelinux.com>
Subject: [PATCH 5.4 37/74] f2fs: fix to do sanity check on inode type during garbage collection
Date:   Mon,  6 Nov 2023 14:03:57 +0100
Message-ID: <20231106130303.029285563@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130301.687882731@linuxfoundation.org>
References: <20231106130301.687882731@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/f2fs/gc.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1069,7 +1069,8 @@ next_step:
 
 		if (phase == 3) {
 			inode = f2fs_iget(sb, dni.ino);
-			if (IS_ERR(inode) || is_bad_inode(inode))
+			if (IS_ERR(inode) || is_bad_inode(inode) ||
+					special_file(inode->i_mode))
 				continue;
 
 			if (!down_write_trylock(


