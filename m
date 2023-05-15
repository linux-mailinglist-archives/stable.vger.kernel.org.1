Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7B27022CC
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 06:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238999AbjEOEQE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 00:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238599AbjEOEP5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 00:15:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A85E6A
        for <stable@vger.kernel.org>; Sun, 14 May 2023 21:15:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D1E1161E99
        for <stable@vger.kernel.org>; Mon, 15 May 2023 04:15:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2919C433D2;
        Mon, 15 May 2023 04:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684124155;
        bh=rQkQkQikSpMdyiQl3hBXMIgs7EfF/O3Mh3szPaAlO8Q=;
        h=Subject:To:Cc:From:Date:From;
        b=reTTXUhzzpYYldHgrOMxJ3CIW9jknKpsx6HxOEs02qHHtfP6vgeV0PSm3ZAfDc5rX
         2AmCvHaRY46OfB0un3oa0WF3kN0Wyh0p+3tkSLHDncbVz/DTgsQuLxshJhL+waGYyP
         DXIbVzbKkTPUnkS2ziAqL6WHKTUkgYAn96kAyKiQ=
Subject: FAILED: patch "[PATCH] ext4: fix lockdep warning when enabling MMP" failed to apply to 4.19-stable tree
To:     jack@suse.cz, brauner@kernel.org, tytso@mit.edu
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Mon, 15 May 2023 06:15:45 +0200
Message-ID: <2023051545-occupant-cottage-bfa2@gregkh>
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


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 949f95ff39bf188e594e7ecd8e29b82eb108f5bf
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023051545-occupant-cottage-bfa2@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

949f95ff39bf ("ext4: fix lockdep warning when enabling MMP")
6810fad956df ("ext4: fix ext4_error_err save negative errno into superblock")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 949f95ff39bf188e594e7ecd8e29b82eb108f5bf Mon Sep 17 00:00:00 2001
From: Jan Kara <jack@suse.cz>
Date: Tue, 11 Apr 2023 14:10:19 +0200
Subject: [PATCH] ext4: fix lockdep warning when enabling MMP

When we enable MMP in ext4_multi_mount_protect() during mount or
remount, we end up calling sb_start_write() from write_mmp_block(). This
triggers lockdep warning because freeze protection ranks above s_umount
semaphore we are holding during mount / remount. The problem is harmless
because we are guaranteed the filesystem is not frozen during mount /
remount but still let's fix the warning by not grabbing freeze
protection from ext4_multi_mount_protect().

Cc: stable@kernel.org
Reported-by: syzbot+6b7df7d5506b32467149@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?id=ab7e5b6f400b7778d46f01841422e5718fb81843
Signed-off-by: Jan Kara <jack@suse.cz>
Reviewed-by: Christian Brauner <brauner@kernel.org>
Link: https://lore.kernel.org/r/20230411121019.21940-1-jack@suse.cz
Signed-off-by: Theodore Ts'o <tytso@mit.edu>

diff --git a/fs/ext4/mmp.c b/fs/ext4/mmp.c
index 4022bc713421..0aaf38ffcb6e 100644
--- a/fs/ext4/mmp.c
+++ b/fs/ext4/mmp.c
@@ -39,28 +39,36 @@ static void ext4_mmp_csum_set(struct super_block *sb, struct mmp_struct *mmp)
  * Write the MMP block using REQ_SYNC to try to get the block on-disk
  * faster.
  */
-static int write_mmp_block(struct super_block *sb, struct buffer_head *bh)
+static int write_mmp_block_thawed(struct super_block *sb,
+				  struct buffer_head *bh)
 {
 	struct mmp_struct *mmp = (struct mmp_struct *)(bh->b_data);
 
-	/*
-	 * We protect against freezing so that we don't create dirty buffers
-	 * on frozen filesystem.
-	 */
-	sb_start_write(sb);
 	ext4_mmp_csum_set(sb, mmp);
 	lock_buffer(bh);
 	bh->b_end_io = end_buffer_write_sync;
 	get_bh(bh);
 	submit_bh(REQ_OP_WRITE | REQ_SYNC | REQ_META | REQ_PRIO, bh);
 	wait_on_buffer(bh);
-	sb_end_write(sb);
 	if (unlikely(!buffer_uptodate(bh)))
 		return -EIO;
-
 	return 0;
 }
 
+static int write_mmp_block(struct super_block *sb, struct buffer_head *bh)
+{
+	int err;
+
+	/*
+	 * We protect against freezing so that we don't create dirty buffers
+	 * on frozen filesystem.
+	 */
+	sb_start_write(sb);
+	err = write_mmp_block_thawed(sb, bh);
+	sb_end_write(sb);
+	return err;
+}
+
 /*
  * Read the MMP block. It _must_ be read from disk and hence we clear the
  * uptodate flag on the buffer.
@@ -344,7 +352,11 @@ int ext4_multi_mount_protect(struct super_block *sb,
 	seq = mmp_new_seq();
 	mmp->mmp_seq = cpu_to_le32(seq);
 
-	retval = write_mmp_block(sb, bh);
+	/*
+	 * On mount / remount we are protected against fs freezing (by s_umount
+	 * semaphore) and grabbing freeze protection upsets lockdep
+	 */
+	retval = write_mmp_block_thawed(sb, bh);
 	if (retval)
 		goto failed;
 

