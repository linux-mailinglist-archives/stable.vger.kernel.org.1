Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD6D775960
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232840AbjHILAB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232846AbjHIK77 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 06:59:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B25082107
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 03:59:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 52DC66312F
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 10:59:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6147CC433C7;
        Wed,  9 Aug 2023 10:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691578797;
        bh=8C+hyQoZWiWot1x9Sn6RDYUxgkJeOYwFxoyRMAmzKMY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ce3K4X9IbZsxbNKHdGMl1BLlSXoeSQFb9u11IZttaDLY/N3i3+0I1AZsTPOpRFwaA
         y6Neqt+PvJo5mLEclFkfgktaFl1cy8h9g1NsLWNJv4UskdCu76HaAl9x9Ill9upJFX
         PuHdJa115QHS5yTtxZIeAG4Xp/u7aJDmLB26qjpA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        syzbot+1741a5d9b79989c10bdc@syzkaller.appspotmail.com,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH 5.15 61/92] exfat: release s_lock before calling dir_emit()
Date:   Wed,  9 Aug 2023 12:41:37 +0200
Message-ID: <20230809103635.703715689@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103633.485906560@linuxfoundation.org>
References: <20230809103633.485906560@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Sungjong Seo <sj1557.seo@samsung.com>

commit ff84772fd45d486e4fc78c82e2f70ce5333543e6 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/exfat/dir.c |   27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

--- a/fs/exfat/dir.c
+++ b/fs/exfat/dir.c
@@ -211,7 +211,10 @@ static void exfat_free_namebuf(struct ex
 	exfat_init_namebuf(nb);
 }
 
-/* skip iterating emit_dots when dir is empty */
+/*
+ * Before calling dir_emit*(), sbi->s_lock should be released
+ * because page fault can occur in dir_emit*().
+ */
 #define ITER_POS_FILLED_DOTS    (2)
 static int exfat_iterate(struct file *filp, struct dir_context *ctx)
 {
@@ -226,11 +229,10 @@ static int exfat_iterate(struct file *fi
 	int err = 0, fake_offset = 0;
 
 	exfat_init_namebuf(nb);
-	mutex_lock(&EXFAT_SB(sb)->s_lock);
 
 	cpos = ctx->pos;
 	if (!dir_emit_dots(filp, ctx))
-		goto unlock;
+		goto out;
 
 	if (ctx->pos == ITER_POS_FILLED_DOTS) {
 		cpos = 0;
@@ -242,16 +244,18 @@ static int exfat_iterate(struct file *fi
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
@@ -274,16 +278,10 @@ get_new:
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
 
@@ -291,9 +289,8 @@ end_of_dir:
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


