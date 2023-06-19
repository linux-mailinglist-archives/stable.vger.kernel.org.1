Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2E7D735466
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbjFSKzh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbjFSKzK (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:55:10 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA85E1998
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:53:35 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1b52bf6e669so27439555ad.2
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687172015; x=1689764015;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BUtsXi8FqNDaOW6Ut8tC9Iex2JamTnbfV3vD68H4FSg=;
        b=EtGjp3m/J/xkDyKiHW0RqHn1ry1cucSIKwvmL1yZYAifEQJmRZQqGQP1nCRQ/XMKu1
         HeImsOOEplGBRHT4dJR678OWFFA9GKLn3ZxJtUWP0ANlwRFTKBxfE4iZHbiL6S577+Do
         9yZm5Cw7asTQQYYjoQ2i4bFEuzkKMHGzWD3bFvo2cd0MGTWzTyyUePfujGrfft1uF4mM
         XHuWsOvohEQqlioGc8OZYZAAQhz3cxlYnQNxRVoOuync7x/dlxgWpOf9Ax5WSzMGkzg7
         +lnAhwJpKVhxbmuKQ0m6wgBuoTu/uNxzu1E4AiJKyBhIFwVu5c1lmrfx/Fm7OIr78aSf
         Xl6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687172015; x=1689764015;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BUtsXi8FqNDaOW6Ut8tC9Iex2JamTnbfV3vD68H4FSg=;
        b=PFBz5NQqrCv2qyA7JGiQ3kP1n4bnQ1iv54GJtTU1yCS3yBOkSsvnY0WDkmylyW6tlh
         WjRfI8lSRXoTQpU+gwZj70X1Fuz/0q+b7Uv8L5tDB2fPmcrRKYn5GWrZsbPqm/C4Z3gb
         fvdrsOqGPKzb5yM9V/dFyw4XD5vzgP6u8fQAag+6lA+dVC/8TsjxFtzMUU9nVKCKqtmG
         S1j71XKNoEY2QgFFF+Ef/HKgHO9T7ZhFrWlFyPcWoWqGnB9kqY9wjRMnBCJZKNYlazLe
         /PbeacLiLDlZMOL9Js8LsbxwIO+1rtd8pIpuap2hUyHu4AhXADUURlQ63nQQZtdBfYEs
         pxHA==
X-Gm-Message-State: AC+VfDxpNY+4+5g+NLY7BJV3fJOcDHriv7MFfD1fwKIZP0mhHbMnXnr7
        /+25hpfwnmD3BiJxzaXRAER3LW87Zs0=
X-Google-Smtp-Source: ACHHUZ5f9zJU829H17HhhaWyWFH7FbnD4TU+Z+/jjilUGidiJvtjVWxQeIf3XSYzzfC+IAfu9jKavA==
X-Received: by 2002:a17:902:dac9:b0:1b3:e68e:815a with SMTP id q9-20020a170902dac900b001b3e68e815amr12556189plx.7.1687172015110;
        Mon, 19 Jun 2023 03:53:35 -0700 (PDT)
Received: from carrot.. (i220-108-176-104.s42.a014.ap.plala.or.jp. [220.108.176.104])
        by smtp.gmail.com with ESMTPSA id p18-20020a1709028a9200b001b4fee3ea25sm9470530plo.277.2023.06.19.03.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 03:53:34 -0700 (PDT)
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 4.14 4.19 5.4] nilfs2: reject devices with insufficient block count
Date:   Mon, 19 Jun 2023 19:55:24 +0900
Message-Id: <20230619105524.3932-1-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

commit 92c5d1b860e9581d64baca76779576c0ab0d943d upstream.

The current sanity check for nilfs2 geometry information lacks checks for
the number of segments stored in superblocks, so even for device images
that have been destructively truncated or have an unusually high number of
segments, the mount operation may succeed.

This causes out-of-bounds block I/O on file system block reads or log
writes to the segments, the latter in particular causing
"a_ops->writepages" to repeatedly fail, resulting in sync_inodes_sb() to
hang.

Fix this issue by checking the number of segments stored in the superblock
and avoiding mounting devices that can cause out-of-bounds accesses.  To
eliminate the possibility of overflow when calculating the number of
blocks required for the device from the number of segments, this also adds
a helper function to calculate the upper bound on the number of segments
and inserts a check using it.

Link: https://lkml.kernel.org/r/20230526021332.3431-1-konishi.ryusuke@gmail.com
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Reported-by: syzbot+7d50f1e54a12ba3aeae2@syzkaller.appspotmail.com
  Link: https://syzkaller.appspot.com/bug?extid=7d50f1e54a12ba3aeae2
Tested-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
Please apply this patch to the above stable trees instead of the patch
that could not be applied to them.  The hang issue reported by syzbot was
confirmed to reproduce on these stable kernels using its reproducer.
This fixes it.

In this patch, "sb_bdev_nr_blocks()" and "nilfs_err()" are replaced with
their equivalents since they don't yet exist in these kernels.  With these
tweaks, this patch is applicable from v4.8 to v5.8.  Also, this patch has
been tested against the title stable trees.

 fs/nilfs2/the_nilfs.c | 44 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/fs/nilfs2/the_nilfs.c b/fs/nilfs2/the_nilfs.c
index 24f626e7d012..d550a564645e 100644
--- a/fs/nilfs2/the_nilfs.c
+++ b/fs/nilfs2/the_nilfs.c
@@ -375,6 +375,18 @@ unsigned long nilfs_nrsvsegs(struct the_nilfs *nilfs, unsigned long nsegs)
 				  100));
 }
 
+/**
+ * nilfs_max_segment_count - calculate the maximum number of segments
+ * @nilfs: nilfs object
+ */
+static u64 nilfs_max_segment_count(struct the_nilfs *nilfs)
+{
+	u64 max_count = U64_MAX;
+
+	do_div(max_count, nilfs->ns_blocks_per_segment);
+	return min_t(u64, max_count, ULONG_MAX);
+}
+
 void nilfs_set_nsegments(struct the_nilfs *nilfs, unsigned long nsegs)
 {
 	nilfs->ns_nsegments = nsegs;
@@ -384,6 +396,8 @@ void nilfs_set_nsegments(struct the_nilfs *nilfs, unsigned long nsegs)
 static int nilfs_store_disk_layout(struct the_nilfs *nilfs,
 				   struct nilfs_super_block *sbp)
 {
+	u64 nsegments, nblocks;
+
 	if (le32_to_cpu(sbp->s_rev_level) < NILFS_MIN_SUPP_REV) {
 		nilfs_msg(nilfs->ns_sb, KERN_ERR,
 			  "unsupported revision (superblock rev.=%d.%d, current rev.=%d.%d). Please check the version of mkfs.nilfs(2).",
@@ -430,7 +444,35 @@ static int nilfs_store_disk_layout(struct the_nilfs *nilfs,
 		return -EINVAL;
 	}
 
-	nilfs_set_nsegments(nilfs, le64_to_cpu(sbp->s_nsegments));
+	nsegments = le64_to_cpu(sbp->s_nsegments);
+	if (nsegments > nilfs_max_segment_count(nilfs)) {
+		nilfs_msg(nilfs->ns_sb, KERN_ERR,
+			  "segment count %llu exceeds upper limit (%llu segments)",
+			  (unsigned long long)nsegments,
+			  (unsigned long long)nilfs_max_segment_count(nilfs));
+		return -EINVAL;
+	}
+
+	nblocks = (u64)i_size_read(nilfs->ns_sb->s_bdev->bd_inode) >>
+		nilfs->ns_sb->s_blocksize_bits;
+	if (nblocks) {
+		u64 min_block_count = nsegments * nilfs->ns_blocks_per_segment;
+		/*
+		 * To avoid failing to mount early device images without a
+		 * second superblock, exclude that block count from the
+		 * "min_block_count" calculation.
+		 */
+
+		if (nblocks < min_block_count) {
+			nilfs_msg(nilfs->ns_sb, KERN_ERR,
+				  "total number of segment blocks %llu exceeds device size (%llu blocks)",
+				  (unsigned long long)min_block_count,
+				  (unsigned long long)nblocks);
+			return -EINVAL;
+		}
+	}
+
+	nilfs_set_nsegments(nilfs, nsegments);
 	nilfs->ns_crc_seed = le32_to_cpu(sbp->s_crc_seed);
 	return 0;
 }
-- 
2.39.3

