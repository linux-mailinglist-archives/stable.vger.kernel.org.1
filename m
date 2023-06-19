Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F50E7353A2
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232042AbjFSKrS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232048AbjFSKq6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:46:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B930E7E
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:46:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7AA3360B73
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:46:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84F86C433C8;
        Mon, 19 Jun 2023 10:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687171589;
        bh=qEDMJvTUqh1NP1VW+lxt0xbWtMqxPBWzkFOtGDfpPzA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cjEcXBNBAQoZkemXgoy71U/RuTcMKYR3DwjdH37kX4UbbZF5lFsr7ajAuZ79OCeUF
         1e1sNV9X9UwiujJ5NerbjGuutUezc32cz115joo4aONVfLwFNFtysvhYTGrGAYTd6a
         hA15FM1uIH2tAsc07sExpt3dMQi5mSOlMXulNRC0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        syzbot+7d50f1e54a12ba3aeae2@syzkaller.appspotmail.com,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.1 052/166] nilfs2: reject devices with insufficient block count
Date:   Mon, 19 Jun 2023 12:28:49 +0200
Message-ID: <20230619102157.291423833@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102154.568541872@linuxfoundation.org>
References: <20230619102154.568541872@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Ryusuke Konishi <konishi.ryusuke@gmail.com>

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nilfs2/the_nilfs.c |   43 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

--- a/fs/nilfs2/the_nilfs.c
+++ b/fs/nilfs2/the_nilfs.c
@@ -405,6 +405,18 @@ unsigned long nilfs_nrsvsegs(struct the_
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
@@ -414,6 +426,8 @@ void nilfs_set_nsegments(struct the_nilf
 static int nilfs_store_disk_layout(struct the_nilfs *nilfs,
 				   struct nilfs_super_block *sbp)
 {
+	u64 nsegments, nblocks;
+
 	if (le32_to_cpu(sbp->s_rev_level) < NILFS_MIN_SUPP_REV) {
 		nilfs_err(nilfs->ns_sb,
 			  "unsupported revision (superblock rev.=%d.%d, current rev.=%d.%d). Please check the version of mkfs.nilfs(2).",
@@ -457,7 +471,34 @@ static int nilfs_store_disk_layout(struc
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
+	nblocks = sb_bdev_nr_blocks(nilfs->ns_sb);
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


