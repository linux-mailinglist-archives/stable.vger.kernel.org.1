Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E04377C90F
	for <lists+stable@lfdr.de>; Tue, 15 Aug 2023 10:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232714AbjHOIBg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 15 Aug 2023 04:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235529AbjHOIBG (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 15 Aug 2023 04:01:06 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4702B172A
        for <stable@vger.kernel.org>; Tue, 15 Aug 2023 01:01:05 -0700 (PDT)
Received: from vefanov-Precision-3650-Tower.intra.ispras.ru (unknown [10.10.2.69])
        by mail.ispras.ru (Postfix) with ESMTPSA id 8A05740F1DEA;
        Tue, 15 Aug 2023 08:01:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 8A05740F1DEA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1692086461;
        bh=lC5JNkuu0ff1C0uQr3xYyGnA2TncFsFL7Ypk20AoszQ=;
        h=From:To:Cc:Subject:Date:From;
        b=aPzXnx+WT2nTHgYndPeYIkBDxqAQwvQtlUmzLcXs0VOO+0QxWpJtgM7/7wDXSMVbm
         C9ZrQEMAN7NCKmEkwjkPhMKjrtxoLL1rxM/mE0fw2bWwy3OWx+SrcXtV+U/ML8P3KE
         xaKvHpr4LAzgyEY85bEg0U37gwXYSunZtyvlMOXk=
From:   Vladislav Efanov <VEfanov@ispras.ru>
To:     stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Vladislav Efanov <VEfanov@ispras.ru>, Jan Kara <jack@suse.com>,
        lvc-project@linuxtesting.org, Jan Kara <jack@suse.cz>
Subject: [PATCH 5.10 1/1] udf: Check consistency of Space Bitmap Descriptor
Date:   Tue, 15 Aug 2023 10:59:39 +0300
Message-Id: <20230815075939.2205503-1-VEfanov@ispras.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
5.10 branch.
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

