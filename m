Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 081A87D151A
	for <lists+stable@lfdr.de>; Fri, 20 Oct 2023 19:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377710AbjJTRpL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 20 Oct 2023 13:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377702AbjJTRpK (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 20 Oct 2023 13:45:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D38F0A3
        for <stable@vger.kernel.org>; Fri, 20 Oct 2023 10:45:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F58BC433C8;
        Fri, 20 Oct 2023 17:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697823908;
        bh=RfojcVtUqp6b0r0WQh5rvLPlE4PZr6Q0ChCBd55rW+E=;
        h=Subject:To:Cc:From:Date:From;
        b=JdR8ux+430QiePxyQl5YTLH36H28oda5Pens0548NGE9lX7fxVbL7orOqL5cg5GrQ
         +amdRIm5AC54TRjHhEtPU5uAy2yEklZMBiiyTyu+078WW+nrM3YmgFTcfaaGMY2ZAA
         cajo30qLKsS5N57l3HmLVyo34Vx45+3s6PUJyDTs=
Subject: FAILED: patch "[PATCH] fs/ntfs3: Fix shift-out-of-bounds in ntfs_fill_super" failed to apply to 5.15-stable tree
To:     almaz.alexandrovich@paragon-software.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 20 Oct 2023 19:44:57 +0200
Message-ID: <2023102057-luminous-preface-e664@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
git cherry-pick -x 91a4b1ee78cb100b19b70f077c247f211110348f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023102057-luminous-preface-e664@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 91a4b1ee78cb100b19b70f077c247f211110348f Mon Sep 17 00:00:00 2001
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Date: Fri, 30 Jun 2023 16:25:25 +0400
Subject: [PATCH] fs/ntfs3: Fix shift-out-of-bounds in ntfs_fill_super

Reported-by: syzbot+478c1bf0e6bf4a8f3a04@syzkaller.appspotmail.com
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index 629403ede6e5..788567d71d93 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -42,9 +42,11 @@ enum utf16_endian;
 #define MINUS_ONE_T			((size_t)(-1))
 /* Biggest MFT / smallest cluster */
 #define MAXIMUM_BYTES_PER_MFT		4096
+#define MAXIMUM_SHIFT_BYTES_PER_MFT	12
 #define NTFS_BLOCKS_PER_MFT_RECORD	(MAXIMUM_BYTES_PER_MFT / 512)
 
 #define MAXIMUM_BYTES_PER_INDEX		4096
+#define MAXIMUM_SHIFT_BYTES_PER_INDEX	12
 #define NTFS_BLOCKS_PER_INODE		(MAXIMUM_BYTES_PER_INDEX / 512)
 
 /* NTFS specific error code when fixup failed. */
diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index ea4e218c3f75..f78c67452b2a 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -899,9 +899,17 @@ static int ntfs_init_from_boot(struct super_block *sb, u32 sector_size,
 		goto out;
 	}
 
-	sbi->record_size = record_size =
-		boot->record_size < 0 ? 1 << (-boot->record_size) :
-					(u32)boot->record_size << cluster_bits;
+	if (boot->record_size >= 0) {
+		record_size = (u32)boot->record_size << cluster_bits;
+	} else if (-boot->record_size <= MAXIMUM_SHIFT_BYTES_PER_MFT) {
+		record_size = 1u << (-boot->record_size);
+	} else {
+		ntfs_err(sb, "%s: invalid record size %d.", hint,
+			 boot->record_size);
+		goto out;
+	}
+
+	sbi->record_size = record_size;
 	sbi->record_bits = blksize_bits(record_size);
 	sbi->attr_size_tr = (5 * record_size >> 4); // ~320 bytes
 
@@ -918,9 +926,15 @@ static int ntfs_init_from_boot(struct super_block *sb, u32 sector_size,
 		goto out;
 	}
 
-	sbi->index_size = boot->index_size < 0 ?
-				  1u << (-boot->index_size) :
-				  (u32)boot->index_size << cluster_bits;
+	if (boot->index_size >= 0) {
+		sbi->index_size = (u32)boot->index_size << cluster_bits;
+	} else if (-boot->index_size <= MAXIMUM_SHIFT_BYTES_PER_INDEX) {
+		sbi->index_size = 1u << (-boot->index_size);
+	} else {
+		ntfs_err(sb, "%s: invalid index size %d.", hint,
+			 boot->index_size);
+		goto out;
+	}
 
 	/* Check index record size. */
 	if (sbi->index_size < SECTOR_SIZE || !is_power_of_2(sbi->index_size)) {

