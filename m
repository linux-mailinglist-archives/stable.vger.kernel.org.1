Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2970B754CCF
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 01:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjGOX2i (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 15 Jul 2023 19:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjGOX2i (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 15 Jul 2023 19:28:38 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D111B9
        for <stable@vger.kernel.org>; Sat, 15 Jul 2023 16:28:36 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-666eb03457cso2044113b3a.1
        for <stable@vger.kernel.org>; Sat, 15 Jul 2023 16:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689463716; x=1692055716;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rxdDGFgKi6T11oeh14znfdo2pyDiJNLt/6xzQQRf+uk=;
        b=Gva7qgSgNnSKQF+drj8+fV5EXI+s5BUVIyGbv/QbC2oQdM0+mQBYH8tpE4uDyATRix
         T032H1Vy6b0BC2ye8+uAmgLW54/R8j1y3KlHyr3tRpqtu85Q8ZIk5nh93UBZJIAlkmKd
         jSEUojbPujECpf60z09YDzlDnN7tQDK3jTlKsIouAWd2wIdYk1+zthEX9LWPF+0YItuP
         lA+L6ssv4hUHDNjHONNMbIQcAUjzX64iSghjTd8xK/Ywg1t9QikMA8WEGkjvWS1W4Lhe
         skDLe9wPmRud7O+uU/8oydUpWxZt6h+FGW7GuicXsiB8qPu0TgA9Sy2SpM/DEaHSBziu
         ltyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689463716; x=1692055716;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rxdDGFgKi6T11oeh14znfdo2pyDiJNLt/6xzQQRf+uk=;
        b=k+rx48EzuqUaLA3BhhmAynyzd+hnkDJZZFmJiMjBn/V8/hcH+yQ88IQhsrkcXxAzTS
         bw9yYGmXX2flD71ITtLULJyhY2fUcP87YXnzkiYkDkLyJWBcd9Fn6SrHWA8+AQ/larbI
         iXd50oz1HJ9g4y07XTe1wS72EmqRZV/OKp9ZD6KDb5VP/vSYzexAe/gvZj+VoXo+IIvv
         nufi+v5PGCQbl5KdF6E4OLHJadsl4sP4ji0TayGgjbaXa603qDqSqBpt/wAXrjlFVFVb
         Zf1a7q2zI40aNaE1J4zqkXnmVRqGuhxvBWv3pIYI3VceJXfdMnbL+kzgGRQIzX7/YUfP
         EeBw==
X-Gm-Message-State: ABy/qLa+IIyIPNYuzWJUvTP6s/cDrmaCIT5Le4VxB1PBtScepriZB5QK
        Im4GMIcBKsZC+6cFUsc6rUAEDVVc4tg=
X-Google-Smtp-Source: APBJJlEbZTJzHExV3wJmCdwcCo27PE5nOjcDDkc58IWUKY86xVH0kq4c0BRjfOzq55rczTEga3cB5w==
X-Received: by 2002:a05:6a21:7892:b0:134:9868:812e with SMTP id bf18-20020a056a21789200b001349868812emr235183pzc.39.1689463715958;
        Sat, 15 Jul 2023 16:28:35 -0700 (PDT)
Received: from xplor.waratah.dyndns.org (222-152-184-54-fibre.sparkbb.co.nz. [222.152.184.54])
        by smtp.gmail.com with ESMTPSA id e30-20020a63745e000000b0055c02b8688asm9849219pgn.20.2023.07.15.16.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jul 2023 16:28:35 -0700 (PDT)
Received: by xplor.waratah.dyndns.org (Postfix, from userid 1000)
        id 4A9FD360318; Sun, 16 Jul 2023 11:28:32 +1200 (NZST)
From:   Michael Schmitz <schmitzmic@gmail.com>
To:     stable@vger.kernel.org
Cc:     schmitzmic@gmail.com, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5.10.y] block: add overflow checks for Amiga partition support
Date:   Sun, 16 Jul 2023 11:28:20 +1200
Message-Id: <20230715232820.8735-1-schmitzmic@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <2023071116-umbrella-fog-a65f@gregkh>
References: <2023071116-umbrella-fog-a65f@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

The Amiga partition parser module uses signed int for partition sector
address and count, which will overflow for disks larger than 1 TB.

Use u64 as type for sector address and size to allow using disks up to
2 TB without LBD support, and disks larger than 2 TB with LBD. The RBD
format allows to specify disk sizes up to 2^128 bytes (though native
OS limitations reduce this somewhat, to max 2^68 bytes), so check for
u64 overflow carefully to protect against overflowing sector_t.

Bail out if sector addresses overflow 32 bits on kernels without LBD
support.

This bug was reported originally in 2012, and the fix was created by
the RDB author, Joanne Dow <jdow@earthlink.net>. A patch had been
discussed and reviewed on linux-m68k at that time but never officially
submitted (now resubmitted as patch 1 in this series).
This patch adds additional error checking and warning messages.

Reported-by: Martin Steigerwald <Martin@lichtvoll.de>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=43511
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Message-ID: <201206192146.09327.Martin@lichtvoll.de>
Cc: <stable@vger.kernel.org> # 5.2
Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Reviewed-by: Christoph Hellwig <hch@infradead.org>
Link: https://lore.kernel.org/r/20230620201725.7020-4-schmitzmic@gmail.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
(cherry picked from commit b6f3f28f604ba3de4724ad82bea6adb1300c0b5f)
Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>

---

Changes since 5.10-stable:

- fix merge conflicts
---
 block/partitions/amiga.c | 103 ++++++++++++++++++++++++++++++++-------
 1 file changed, 85 insertions(+), 18 deletions(-)

diff --git a/block/partitions/amiga.c b/block/partitions/amiga.c
index 64f0844468aa..7abc09d8fc73 100644
--- a/block/partitions/amiga.c
+++ b/block/partitions/amiga.c
@@ -11,10 +11,18 @@
 #define pr_fmt(fmt) fmt
 
 #include <linux/types.h>
+#include <linux/mm_types.h>
+#include <linux/overflow.h>
 #include <linux/affs_hardblocks.h>
 
 #include "check.h"
 
+/* magic offsets in partition DosEnvVec */
+#define NR_HD	3
+#define NR_SECT	5
+#define LO_CYL	9
+#define HI_CYL	10
+
 static __inline__ u32
 checksum_block(__be32 *m, int size)
 {
@@ -31,9 +39,12 @@ int amiga_partition(struct parsed_partitions *state)
 	unsigned char *data;
 	struct RigidDiskBlock *rdb;
 	struct PartitionBlock *pb;
-	sector_t start_sect, nr_sects;
-	int blk, part, res = 0;
-	int blksize = 1;	/* Multiplier for disk block size */
+	u64 start_sect, nr_sects;
+	sector_t blk, end_sect;
+	u32 cylblk;		/* rdb_CylBlocks = nr_heads*sect_per_track */
+	u32 nr_hd, nr_sect, lo_cyl, hi_cyl;
+	int part, res = 0;
+	unsigned int blksize = 1;	/* Multiplier for disk block size */
 	int slot = 1;
 	char b[BDEVNAME_SIZE];
 
@@ -42,7 +53,7 @@ int amiga_partition(struct parsed_partitions *state)
 			goto rdb_done;
 		data = read_part_sector(state, blk, &sect);
 		if (!data) {
-			pr_err("Dev %s: unable to read RDB block %d\n",
+			pr_err("Dev %s: unable to read RDB block %llu\n",
 			       bdevname(state->bdev, b), blk);
 			res = -1;
 			goto rdb_done;
@@ -59,12 +70,12 @@ int amiga_partition(struct parsed_partitions *state)
 		*(__be32 *)(data+0xdc) = 0;
 		if (checksum_block((__be32 *)data,
 				be32_to_cpu(rdb->rdb_SummedLongs) & 0x7F)==0) {
-			pr_err("Trashed word at 0xd0 in block %d ignored in checksum calculation\n",
+			pr_err("Trashed word at 0xd0 in block %llu ignored in checksum calculation\n",
 			       blk);
 			break;
 		}
 
-		pr_err("Dev %s: RDB in block %d has bad checksum\n",
+		pr_err("Dev %s: RDB in block %llu has bad checksum\n",
 		       bdevname(state->bdev, b), blk);
 	}
 
@@ -81,10 +92,15 @@ int amiga_partition(struct parsed_partitions *state)
 	blk = be32_to_cpu(rdb->rdb_PartitionList);
 	put_dev_sector(sect);
 	for (part = 1; blk>0 && part<=16; part++, put_dev_sector(sect)) {
-		blk *= blksize;	/* Read in terms partition table understands */
+		/* Read in terms partition table understands */
+		if (check_mul_overflow(blk, (sector_t) blksize, &blk)) {
+			pr_err("Dev %s: overflow calculating partition block %llu! Skipping partitions %u and beyond\n",
+				bdevname(state->bdev, b), blk, part);
+			break;
+		}
 		data = read_part_sector(state, blk, &sect);
 		if (!data) {
-			pr_err("Dev %s: unable to read partition block %d\n",
+			pr_err("Dev %s: unable to read partition block %llu\n",
 			       bdevname(state->bdev, b), blk);
 			res = -1;
 			goto rdb_done;
@@ -96,19 +112,70 @@ int amiga_partition(struct parsed_partitions *state)
 		if (checksum_block((__be32 *)pb, be32_to_cpu(pb->pb_SummedLongs) & 0x7F) != 0 )
 			continue;
 
-		/* Tell Kernel about it */
+		/* RDB gives us more than enough rope to hang ourselves with,
+		 * many times over (2^128 bytes if all fields max out).
+		 * Some careful checks are in order, so check for potential
+		 * overflows.
+		 * We are multiplying four 32 bit numbers to one sector_t!
+		 */
+
+		nr_hd   = be32_to_cpu(pb->pb_Environment[NR_HD]);
+		nr_sect = be32_to_cpu(pb->pb_Environment[NR_SECT]);
+
+		/* CylBlocks is total number of blocks per cylinder */
+		if (check_mul_overflow(nr_hd, nr_sect, &cylblk)) {
+			pr_err("Dev %s: heads*sects %u overflows u32, skipping partition!\n",
+				bdevname(state->bdev, b), cylblk);
+			continue;
+		}
+
+		/* check for consistency with RDB defined CylBlocks */
+		if (cylblk > be32_to_cpu(rdb->rdb_CylBlocks)) {
+			pr_warn("Dev %s: cylblk %u > rdb_CylBlocks %u!\n",
+				bdevname(state->bdev, b), cylblk,
+				be32_to_cpu(rdb->rdb_CylBlocks));
+		}
+
+		/* RDB allows for variable logical block size -
+		 * normalize to 512 byte blocks and check result.
+		 */
+
+		if (check_mul_overflow(cylblk, blksize, &cylblk)) {
+			pr_err("Dev %s: partition %u bytes per cyl. overflows u32, skipping partition!\n",
+				bdevname(state->bdev, b), part);
+			continue;
+		}
+
+		/* Calculate partition start and end. Limit of 32 bit on cylblk
+		 * guarantees no overflow occurs if LBD support is enabled.
+		 */
+
+		lo_cyl = be32_to_cpu(pb->pb_Environment[LO_CYL]);
+		start_sect = ((u64) lo_cyl * cylblk);
+
+		hi_cyl = be32_to_cpu(pb->pb_Environment[HI_CYL]);
+		nr_sects = (((u64) hi_cyl - lo_cyl + 1) * cylblk);
 
-		nr_sects = ((sector_t)be32_to_cpu(pb->pb_Environment[10]) + 1 -
-			   be32_to_cpu(pb->pb_Environment[9])) *
-			   be32_to_cpu(pb->pb_Environment[3]) *
-			   be32_to_cpu(pb->pb_Environment[5]) *
-			   blksize;
 		if (!nr_sects)
 			continue;
-		start_sect = (sector_t)be32_to_cpu(pb->pb_Environment[9]) *
-			     be32_to_cpu(pb->pb_Environment[3]) *
-			     be32_to_cpu(pb->pb_Environment[5]) *
-			     blksize;
+
+		/* Warn user if partition end overflows u32 (AmigaDOS limit) */
+
+		if ((start_sect + nr_sects) > UINT_MAX) {
+			pr_warn("Dev %s: partition %u (%llu-%llu) needs 64 bit device support!\n",
+				bdevname(state->bdev, b), part,
+				start_sect, start_sect + nr_sects);
+		}
+
+		if (check_add_overflow(start_sect, nr_sects, &end_sect)) {
+			pr_err("Dev %s: partition %u (%llu-%llu) needs LBD device support, skipping partition!\n",
+				bdevname(state->bdev, b), part,
+				start_sect, end_sect);
+			continue;
+		}
+
+		/* Tell Kernel about it */
+
 		put_partition(state,slot++,start_sect,nr_sects);
 		{
 			/* Be even more informative to aid mounting */
-- 
2.17.1

