Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA277347A2
	for <lists+stable@lfdr.de>; Sun, 18 Jun 2023 20:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjFRSfS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 18 Jun 2023 14:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjFRSfR (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 18 Jun 2023 14:35:17 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809B412D
        for <stable@vger.kernel.org>; Sun, 18 Jun 2023 11:35:16 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1b516978829so22576615ad.1
        for <stable@vger.kernel.org>; Sun, 18 Jun 2023 11:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687113316; x=1689705316;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FZydn1RPU3lTAxPh64XlaAGKQpnNyqJRJ6CUUsng+OU=;
        b=meu4ThyorQ9l2J1Ct2kQ5RdDb0k47xC+rqIK51RL/LDizKrjpY4e2bkQUF0RI0zV3s
         MuDrNH5F58c243NkLE2pA+KnFc0SKWI0NJbSr2TcItZ1t4xuxP07sST20a/DgyfV3kLx
         iFkm5gFA80wjZFWg8lBdq3sud1X8mkva9ZHs9C3aS+RaqI3P9u341377Eod5w41aUWme
         UUMmEkXPBu+lVvuCn3Aa/Nnuq+hyFL2LKqiK+JGW2PKLuSECvypvw0Egz+KtcDsLrOzA
         fWkKuNG7TaNNxNYyGDtnTh/uSwmRWeW9wQlw5g+jNygB71YjiuI7qf/NRc0DLJzN29nx
         YGkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687113316; x=1689705316;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FZydn1RPU3lTAxPh64XlaAGKQpnNyqJRJ6CUUsng+OU=;
        b=HR+G/fwjIRpvCLxgm7PiUtoHMkcEGme/8wjgi7gCyWCncwBpZSrhkZ1YgCrCezQYDE
         XxB0BHy/6AdRrroDH02eMnJwkcqXZRN1IYtuxsWhzuXDp2gMkMRqgcr86eHLgT/CIiO0
         MF9QIakqsOVxV53UyDuphTdLX1jcBBPioJ9UFfQSK6+AvtcwIAvvjQ59sNyzew/nRVYB
         hIHFhpZOTFPlepBbnR40QsiQb7Gqi8m+Wyx8UaQXkahiS211BLed0CVf/g73dAyYW/Zx
         OaFz0qO1y6h7WI9iCAsDwEgrwayHbitD7tY6G1TP/bIqCMxiFqxBwFOx/k6EAWkJKNK2
         jJDA==
X-Gm-Message-State: AC+VfDypha/cuGzvJnHxQwe/rQyAwdZdSnYvS0GbWVkhwBsI18vPhCHj
        ptJqHfpWOnHUWITS3ydq5l9/NHNNNEQ=
X-Google-Smtp-Source: ACHHUZ7PU3XgfhDJRa80a8r25dliiIxdpnAr85MfWjsh+Cvx+KxJh2v4A3UpM6Ec0n8PqGHjHXn4Kg==
X-Received: by 2002:a17:903:1107:b0:1ac:7345:f254 with SMTP id n7-20020a170903110700b001ac7345f254mr9693278plh.33.1687113315736;
        Sun, 18 Jun 2023 11:35:15 -0700 (PDT)
Received: from carrot.. (i220-108-176-104.s42.a014.ap.plala.or.jp. [220.108.176.104])
        by smtp.gmail.com with ESMTPSA id d8-20020a170902cec800b001b3d756a6f4sm12237562plg.13.2023.06.18.11.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jun 2023 11:35:15 -0700 (PDT)
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 5.10 5.15] nilfs2: reject devices with insufficient block count
Date:   Mon, 19 Jun 2023 03:35:19 +0900
Message-Id: <20230618183519.2411-1-konishi.ryusuke@gmail.com>
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

In this patch, "sb_bdev_nr_blocks()" is replaced with its equivalent since
it doesn't yet exist in these kernels.  With this tweak, this patch is
applicable from v5.9 to v5.15.  Also, this patch has been tested against
the title stable trees.

 fs/nilfs2/the_nilfs.c | 44 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/fs/nilfs2/the_nilfs.c b/fs/nilfs2/the_nilfs.c
index 0fa130362816..fe2e7197268b 100644
--- a/fs/nilfs2/the_nilfs.c
+++ b/fs/nilfs2/the_nilfs.c
@@ -405,6 +405,18 @@ unsigned long nilfs_nrsvsegs(struct the_nilfs *nilfs, unsigned long nsegs)
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
@@ -414,6 +426,8 @@ void nilfs_set_nsegments(struct the_nilfs *nilfs, unsigned long nsegs)
 static int nilfs_store_disk_layout(struct the_nilfs *nilfs,
 				   struct nilfs_super_block *sbp)
 {
+	u64 nsegments, nblocks;
+
 	if (le32_to_cpu(sbp->s_rev_level) < NILFS_MIN_SUPP_REV) {
 		nilfs_err(nilfs->ns_sb,
 			  "unsupported revision (superblock rev.=%d.%d, current rev.=%d.%d). Please check the version of mkfs.nilfs(2).",
@@ -457,7 +471,35 @@ static int nilfs_store_disk_layout(struct the_nilfs *nilfs,
 		return -EINVAL;
 	}
 
-	nilfs_set_nsegments(nilfs, le64_to_cpu(sbp->s_nsegments));
+	nsegments = le64_to_cpu(sbp->s_nsegments);
+	if (nsegments > nilfs_max_segment_count(nilfs)) {
+		nilfs_err(nilfs->ns_sb,
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
+			nilfs_err(nilfs->ns_sb,
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

