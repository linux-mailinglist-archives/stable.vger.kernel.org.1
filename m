Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90444771ADC
	for <lists+stable@lfdr.de>; Mon,  7 Aug 2023 08:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbjHGGz6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 7 Aug 2023 02:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbjHGGz6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 7 Aug 2023 02:55:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB21E78
        for <stable@vger.kernel.org>; Sun,  6 Aug 2023 23:55:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 95AD961585
        for <stable@vger.kernel.org>; Mon,  7 Aug 2023 06:55:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0330C433C8;
        Mon,  7 Aug 2023 06:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691391356;
        bh=t9SVBuGgcygFNB9dnQq43JrMBwkVz+taurDcUt4q86c=;
        h=Subject:To:Cc:From:Date:From;
        b=QlSLMwCMs3iqJt3JV3qjuAfNJIXMhZTj8/VyZuudIuXtpl+JvEhESVXCMKv+DxxnE
         4jjaRaCFLpnOisYgAYnFHlh/bGJBA9En1n3Y9/HTixG1iC+6TMII6uka045cPlMvPq
         Uq0wds5cdPq7ird1NjBuYlYDCOwUqB1oU0WlWpak=
Subject: FAILED: patch "[PATCH] exfat: release s_lock before calling dir_emit()" failed to apply to 5.15-stable tree
To:     sj1557.seo@samsung.com, linkinjeon@kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Mon, 07 Aug 2023 08:55:53 +0200
Message-ID: <2023080753-shortage-helium-c261@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x ff84772fd45d486e4fc78c82e2f70ce5333543e6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023080753-shortage-helium-c261@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

ff84772fd45d ("exfat: release s_lock before calling dir_emit()")
703e3e9a9cb1 ("exfat_iterate(): don't open-code file_inode(file)")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ff84772fd45d486e4fc78c82e2f70ce5333543e6 Mon Sep 17 00:00:00 2001
From: Sungjong Seo <sj1557.seo@samsung.com>
Date: Fri, 14 Jul 2023 17:43:54 +0900
Subject: [PATCH] exfat: release s_lock before calling dir_emit()

There is a potential deadlock reported by syzbot as below:

======================================================
WARNING: possible circular locking dependency detected
6.4.0-next-20230707-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor330/5073 is trying to acquire lock:
ffff8880218527a0 (&mm->mmap_lock){++++}-{3:3}, at: mmap_read_lock_killable include/linux/mmap_lock.h:151 [inline]
ffff8880218527a0 (&mm->mmap_lock){++++}-{3:3}, at: get_mmap_lock_carefully mm/memory.c:5293 [inline]
ffff8880218527a0 (&mm->mmap_lock){++++}-{3:3}, at: lock_mm_and_find_vma+0x369/0x510 mm/memory.c:5344
but task is already holding lock:
ffff888019f760e0 (&sbi->s_lock){+.+.}-{3:3}, at: exfat_iterate+0x117/0xb50 fs/exfat/dir.c:232

which lock already depends on the new lock.

Chain exists of:
  &mm->mmap_lock --> mapping.invalidate_lock#3 --> &sbi->s_lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&sbi->s_lock);
                               lock(mapping.invalidate_lock#3);
                               lock(&sbi->s_lock);
  rlock(&mm->mmap_lock);

Let's try to avoid above potential deadlock condition by moving dir_emit*()
out of sbi->s_lock coverage.

Fixes: ca06197382bd ("exfat: add directory operations")
Cc: stable@vger.kernel.org #v5.7+
Reported-by: syzbot+1741a5d9b79989c10bdc@syzkaller.appspotmail.com
Link: https://lore.kernel.org/lkml/00000000000078ee7e060066270b@google.com/T/#u
Tested-by: syzbot+1741a5d9b79989c10bdc@syzkaller.appspotmail.com
Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>

diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
index bc48f3329921..598081d0d059 100644
--- a/fs/exfat/dir.c
+++ b/fs/exfat/dir.c
@@ -218,7 +218,10 @@ static void exfat_free_namebuf(struct exfat_dentry_namebuf *nb)
 	exfat_init_namebuf(nb);
 }
 
-/* skip iterating emit_dots when dir is empty */
+/*
+ * Before calling dir_emit*(), sbi->s_lock should be released
+ * because page fault can occur in dir_emit*().
+ */
 #define ITER_POS_FILLED_DOTS    (2)
 static int exfat_iterate(struct file *file, struct dir_context *ctx)
 {
@@ -233,11 +236,10 @@ static int exfat_iterate(struct file *file, struct dir_context *ctx)
 	int err = 0, fake_offset = 0;
 
 	exfat_init_namebuf(nb);
-	mutex_lock(&EXFAT_SB(sb)->s_lock);
 
 	cpos = ctx->pos;
 	if (!dir_emit_dots(file, ctx))
-		goto unlock;
+		goto out;
 
 	if (ctx->pos == ITER_POS_FILLED_DOTS) {
 		cpos = 0;
@@ -249,16 +251,18 @@ static int exfat_iterate(struct file *file, struct dir_context *ctx)
 	/* name buffer should be allocated before use */
 	err = exfat_alloc_namebuf(nb);
 	if (err)
-		goto unlock;
+		goto out;
 get_new:
+	mutex_lock(&EXFAT_SB(sb)->s_lock);
+
 	if (ei->flags == ALLOC_NO_FAT_CHAIN && cpos >= i_size_read(inode))
 		goto end_of_dir;
 
 	err = exfat_readdir(inode, &cpos, &de);
 	if (err) {
 		/*
-		 * At least we tried to read a sector.  Move cpos to next sector
-		 * position (should be aligned).
+		 * At least we tried to read a sector.
+		 * Move cpos to next sector position (should be aligned).
 		 */
 		if (err == -EIO) {
 			cpos += 1 << (sb->s_blocksize_bits);
@@ -281,16 +285,10 @@ static int exfat_iterate(struct file *file, struct dir_context *ctx)
 		inum = iunique(sb, EXFAT_ROOT_INO);
 	}
 
-	/*
-	 * Before calling dir_emit(), sb_lock should be released.
-	 * Because page fault can occur in dir_emit() when the size
-	 * of buffer given from user is larger than one page size.
-	 */
 	mutex_unlock(&EXFAT_SB(sb)->s_lock);
 	if (!dir_emit(ctx, nb->lfn, strlen(nb->lfn), inum,
 			(de.attr & ATTR_SUBDIR) ? DT_DIR : DT_REG))
-		goto out_unlocked;
-	mutex_lock(&EXFAT_SB(sb)->s_lock);
+		goto out;
 	ctx->pos = cpos;
 	goto get_new;
 
@@ -298,9 +296,8 @@ static int exfat_iterate(struct file *file, struct dir_context *ctx)
 	if (!cpos && fake_offset)
 		cpos = ITER_POS_FILLED_DOTS;
 	ctx->pos = cpos;
-unlock:
 	mutex_unlock(&EXFAT_SB(sb)->s_lock);
-out_unlocked:
+out:
 	/*
 	 * To improve performance, free namebuf after unlock sb_lock.
 	 * If namebuf is not allocated, this function do nothing

