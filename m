Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F14677022C6
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 06:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238157AbjEOEOy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 00:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238839AbjEOEOw (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 00:14:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13A4CE50
        for <stable@vger.kernel.org>; Sun, 14 May 2023 21:14:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B7DD61207
        for <stable@vger.kernel.org>; Mon, 15 May 2023 04:14:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EAA4C433D2;
        Mon, 15 May 2023 04:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684124090;
        bh=Ul6Y59DyDRc+blQI7n8QDWgqdOM9kw5p8k+0xGO8P2U=;
        h=Subject:To:Cc:From:Date:From;
        b=ugJ0+2vS7//prPqPgdcEcqssHtrL5JJaoGWgcr/ky0M+IrzRxWKYig9nJNahQ8DSH
         P1aPt7HSLxVT4qYIcaHv8i9qgXPn5vxV7v65ccxdVMa67gjEwAy8O7mz/u/ft1DV9P
         uS2X/3oE1ofMKXFSVYjgFRYzrOlak5yZfPacCkyw=
Subject: FAILED: patch "[PATCH] ext4: fix deadlock when converting an inline directory in" failed to apply to 4.14-stable tree
To:     tytso@mit.edu
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Mon, 15 May 2023 06:14:41 +0200
Message-ID: <2023051541-whacking-until-c2b2@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 4.14-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.14.y
git checkout FETCH_HEAD
git cherry-pick -x f4ce24f54d9cca4f09a395f3eecce20d6bec4663
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023051541-whacking-until-c2b2@gregkh' --subject-prefix 'PATCH 4.14.y' HEAD^..

Possible dependencies:

f4ce24f54d9c ("ext4: fix deadlock when converting an inline directory in nojournal mode")
f036adb39976 ("ext4: rename "dirent_csum" functions to use "dirblock"")
b886ee3e778e ("ext4: Support case-insensitive file name lookups")
ee73f9a52a34 ("ext4: convert to new i_version API")
ae5e165d855d ("fs: new API for handling inode->i_version")
5cea7647e646 ("Merge branch 'for-4.15' of git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f4ce24f54d9cca4f09a395f3eecce20d6bec4663 Mon Sep 17 00:00:00 2001
From: Theodore Ts'o <tytso@mit.edu>
Date: Sat, 6 May 2023 21:04:01 -0400
Subject: [PATCH] ext4: fix deadlock when converting an inline directory in
 nojournal mode

In no journal mode, ext4_finish_convert_inline_dir() can self-deadlock
by calling ext4_handle_dirty_dirblock() when it already has taken the
directory lock.  There is a similar self-deadlock in
ext4_incvert_inline_data_nolock() for data files which we'll fix at
the same time.

A simple reproducer demonstrating the problem:

    mke2fs -Fq -t ext2 -O inline_data -b 4k /dev/vdc 64
    mount -t ext4 -o dirsync /dev/vdc /vdc
    cd /vdc
    mkdir file0
    cd file0
    touch file0
    touch file1
    attr -s BurnSpaceInEA -V abcde .
    touch supercalifragilisticexpialidocious

Cc: stable@kernel.org
Link: https://lore.kernel.org/r/20230507021608.1290720-1-tytso@mit.edu
Reported-by: syzbot+91dccab7c64e2850a4e5@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?id=ba84cc80a9491d65416bc7877e1650c87530fe8a
Signed-off-by: Theodore Ts'o <tytso@mit.edu>

diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 859bc4e2c9b0..d3dfc51a43c5 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -1175,6 +1175,7 @@ static int ext4_finish_convert_inline_dir(handle_t *handle,
 		ext4_initialize_dirent_tail(dir_block,
 					    inode->i_sb->s_blocksize);
 	set_buffer_uptodate(dir_block);
+	unlock_buffer(dir_block);
 	err = ext4_handle_dirty_dirblock(handle, inode, dir_block);
 	if (err)
 		return err;
@@ -1249,6 +1250,7 @@ static int ext4_convert_inline_data_nolock(handle_t *handle,
 	if (!S_ISDIR(inode->i_mode)) {
 		memcpy(data_bh->b_data, buf, inline_size);
 		set_buffer_uptodate(data_bh);
+		unlock_buffer(data_bh);
 		error = ext4_handle_dirty_metadata(handle,
 						   inode, data_bh);
 	} else {
@@ -1256,7 +1258,6 @@ static int ext4_convert_inline_data_nolock(handle_t *handle,
 						       buf, inline_size);
 	}
 
-	unlock_buffer(data_bh);
 out_restore:
 	if (error)
 		ext4_restore_inline_data(handle, inode, iloc, buf, inline_size);

