Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4A5792804
	for <lists+stable@lfdr.de>; Tue,  5 Sep 2023 18:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233893AbjIEQA3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 5 Sep 2023 12:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354510AbjIEMJ0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 5 Sep 2023 08:09:26 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61121AB
        for <stable@vger.kernel.org>; Tue,  5 Sep 2023 05:09:21 -0700 (PDT)
Received: from vefanov-Precision-3650-Tower.intra.ispras.ru (unknown [10.10.2.69])
        by mail.ispras.ru (Postfix) with ESMTPSA id 96C4440737B5;
        Tue,  5 Sep 2023 12:09:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 96C4440737B5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1693915758;
        bh=u2DxO+xP4H0fXk9iRZyKDRDt5xAjn7r5/mJCTJDCGa4=;
        h=From:To:Cc:Subject:Date:From;
        b=FfjRIjRpeYyM37a6aYsdnwAGO+SZbRlk1fZ9ncrNRchZClQIfRmYOkvx0ueDUb1G6
         3DKegGI+F6g5A4VOjv4BM16WqXqox0+tfXbVVT4ZoowRfR3+90s3D3d4NLP+NMhH65
         EyxUphUwRtdXIDrwqp/kk5Fzo7ypc+9lgsmgLJ10=
From:   Vladislav Efanov <VEfanov@ispras.ru>
To:     stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Vladislav Efanov <VEfanov@ispras.ru>, Jan Kara <jack@suse.com>,
        lvc-project@linuxtesting.org, Jan Kara <jack@suse.cz>
Subject: [PATCH 5.10/5.15/6.1 1/1] udf: Check consistency of Space Bitmap Descriptor
Date:   Tue,  5 Sep 2023 15:08:36 +0300
Message-Id: <20230905120837.836080-1-VEfanov@ispras.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Vladislav Efanov <VEfanov@ispras.ru>

commit 1e0d4adf17e7ef03281d7b16555e7c1508c8ed2d upstream

Bits, which are related to Bitmap Descriptor logical blocks,
are not reset when buffer headers are allocated for them. As the
result, these logical blocks can be treated as free and
be used for other blocks.This can cause usage of one buffer header
for several types of data. UDF issues WARNING in this situation:

WARNING: CPU: 0 PID: 2703 at fs/udf/inode.c:2014
  __udf_add_aext+0x685/0x7d0 fs/udf/inode.c:2014

RIP: 0010:__udf_add_aext+0x685/0x7d0 fs/udf/inode.c:2014
Call Trace:
 udf_setup_indirect_aext+0x573/0x880 fs/udf/inode.c:1980
 udf_add_aext+0x208/0x2e0 fs/udf/inode.c:2067
 udf_insert_aext fs/udf/inode.c:2233 [inline]
 udf_update_extents fs/udf/inode.c:1181 [inline]
 inode_getblk+0x1981/0x3b70 fs/udf/inode.c:885

Found by Linux Verification Center (linuxtesting.org) with syzkaller.

[JK: Somewhat cleaned up the boundary checks]

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Vladislav Efanov <VEfanov@ispras.ru>
Signed-off-by: Jan Kara <jack@suse.cz>
---
Syzkaller reports this problem in 5.10 stable release. The problem has
been fixed by the following patch which can be cleanly applied to the
5.10/5.15/6.1 branches.
 fs/udf/balloc.c | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/fs/udf/balloc.c b/fs/udf/balloc.c
index 8e597db4d971..ef50fd263315 100644
--- a/fs/udf/balloc.c
+++ b/fs/udf/balloc.c
@@ -36,18 +36,41 @@ static int read_block_bitmap(struct super_block *sb,
 			     unsigned long bitmap_nr)
 {
 	struct buffer_head *bh = NULL;
-	int retval = 0;
+	int i;
+	int max_bits, off, count;
 	struct kernel_lb_addr loc;
 
 	loc.logicalBlockNum = bitmap->s_extPosition;
 	loc.partitionReferenceNum = UDF_SB(sb)->s_partition;
 
 	bh = udf_tread(sb, udf_get_lb_pblock(sb, &loc, block));
+	bitmap->s_block_bitmap[bitmap_nr] = bh;
 	if (!bh)
-		retval = -EIO;
+		return -EIO;
 
-	bitmap->s_block_bitmap[bitmap_nr] = bh;
-	return retval;
+	/* Check consistency of Space Bitmap buffer. */
+	max_bits = sb->s_blocksize * 8;
+	if (!bitmap_nr) {
+		off = sizeof(struct spaceBitmapDesc) << 3;
+		count = min(max_bits - off, bitmap->s_nr_groups);
+	} else {
+		/*
+		 * Rough check if bitmap number is too big to have any bitmap
+		 * blocks reserved.
+		 */
+		if (bitmap_nr >
+		    (bitmap->s_nr_groups >> (sb->s_blocksize_bits + 3)) + 2)
+			return 0;
+		off = 0;
+		count = bitmap->s_nr_groups - bitmap_nr * max_bits +
+				(sizeof(struct spaceBitmapDesc) << 3);
+		count = min(count, max_bits);
+	}
+
+	for (i = 0; i < count; i++)
+		if (udf_test_bit(i + off, bh->b_data))
+			return -EFSCORRUPTED;
+	return 0;
 }
 
 static int __load_block_bitmap(struct super_block *sb,
-- 
2.34.1

