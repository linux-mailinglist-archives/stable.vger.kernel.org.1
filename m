Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A222E754CCE
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 01:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjGOX1H (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 15 Jul 2023 19:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjGOX1G (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 15 Jul 2023 19:27:06 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14FA11B9
        for <stable@vger.kernel.org>; Sat, 15 Jul 2023 16:27:05 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1b8bbce9980so19036215ad.2
        for <stable@vger.kernel.org>; Sat, 15 Jul 2023 16:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689463624; x=1692055624;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9kFckUyA19ohDArb00ubnLcooTg0tpvSPj+yFk6MbW8=;
        b=pvZC7O7NPdByCqJh6BEORiauTQI5YQpXyY+q6L9g8q4+SG+m39+4mr14Do5bWviuuJ
         MJfm+fGMi6EmcF6fufhXJz3X6AbfXdtbnBBtXioQG29YSzmZHagnN/+VFludbRI+qu63
         0qfiqg8OKeUvjPDOs9XfiAr7t8wX7QBVnSs7UQ3oUl/QIEYRvfv/2P/eUH/Ca6oF8b/V
         ssr1N68Gj66Pk99NmCcHl4t9iD5k9LOsaDiusCi0wSWAnLqmyGCld0wcDCzEgZac+jht
         fxTU0Fgcrc1b1RdK2hZfuPUHRDTLAITysWb0ZLe/AGWO3Y17kNGThwnnLx4Qx3kr72VA
         olQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689463624; x=1692055624;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9kFckUyA19ohDArb00ubnLcooTg0tpvSPj+yFk6MbW8=;
        b=Y76Z7Xt1lULn1pOcUKI26Kb7BoGQotEUK+9Ks57UhucJ5EV9FvxXQfvs7zSM18JIOV
         1ERi5hW+ChdWNqvnFRd37JBusijKVrF9A5LbhWBblrUKR02ORHodkdPw0KHlzU//OMGl
         zfbNtYF+l+KxqwX8pKp7Q2+8/iRXccZe53o2MPOzLNrvGgpWaHhUrjJQft0M03lRL0F5
         DC5sO68hccd/7vyYFflgdnr8DxAPdwVeA2+2cK4a+lqPzJmby3llQjnD7MiZBGCvRvPt
         oHuSD37xSH44ioLmtmYEuO9idxlUulxRZyU0EdeKhm/UuoltT1XetVNFs8fpah9jnNwn
         iCgg==
X-Gm-Message-State: ABy/qLZ9b/HvOwmBS7oIgi3rPSAP9dz2g0TvwJWn2Q1WwkBRaWko1cEc
        U6jW1hULlU5K83dWTPyJCtE0OGhrRCM=
X-Google-Smtp-Source: APBJJlGcOwBViyZ9wSgM6t+bWtwAftaABxHWXvcuaa1+Q+SAKXCVI5lqDUBWMbVfSTvAzhVdiWC1Ig==
X-Received: by 2002:a17:903:26c9:b0:1b8:6850:c3c4 with SMTP id jg9-20020a17090326c900b001b86850c3c4mr6884747plb.22.1689463624324;
        Sat, 15 Jul 2023 16:27:04 -0700 (PDT)
Received: from xplor.waratah.dyndns.org (222-152-184-54-fibre.sparkbb.co.nz. [222.152.184.54])
        by smtp.gmail.com with ESMTPSA id o17-20020a637e51000000b0055b30275adasm9842685pgn.37.2023.07.15.16.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jul 2023 16:27:03 -0700 (PDT)
Received: by xplor.waratah.dyndns.org (Postfix, from userid 1000)
        id D73E0360318; Sun, 16 Jul 2023 11:26:59 +1200 (NZST)
From:   Michael Schmitz <schmitzmic@gmail.com>
To:     stable@vger.kernel.org
Cc:     schmitzmic@gmail.com, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5.4.y] block: add overflow checks for Amiga partition support
Date:   Sun, 16 Jul 2023 11:26:56 +1200
Message-Id: <20230715232656.8632-1-schmitzmic@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <2023071117-convene-mockup-27f2@gregkh>
References: <2023071117-convene-mockup-27f2@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
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

Changes from linux-block:

- fix merge conflict in 5.4-stable
---
 block/partitions/amiga.c | 103 ++++++++++++++++++++++++++++++++-------
 1 file changed, 85 insertions(+), 18 deletions(-)

diff --git a/block/partitions/amiga.c b/block/partitions/amiga.c
index 4a4160221183..a38fe08778c3 100644
--- a/block/partitions/amiga.c
+++ b/block/partitions/amiga.c
@@ -11,11 +11,19 @@
 #define pr_fmt(fmt) fmt
 
 #include <linux/types.h>
+#include <linux/mm_types.h>
+#include <linux/overflow.h>
 #include <linux/affs_hardblocks.h>
 
 #include "check.h"
 #include "amiga.h"
 
+/* magic offsets in partition DosEnvVec */
+#define NR_HD	3
+#define NR_SECT	5
+#define LO_CYL	9
+#define HI_CYL	10
+
 static __inline__ u32
 checksum_block(__be32 *m, int size)
 {
@@ -32,9 +40,12 @@ int amiga_partition(struct parsed_partitions *state)
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
 
@@ -44,7 +55,7 @@ int amiga_partition(struct parsed_partitions *state)
 		data = read_part_sector(state, blk, &sect);
 		if (!data) {
 			if (warn_no_part)
-				pr_err("Dev %s: unable to read RDB block %d\n",
+				pr_err("Dev %s: unable to read RDB block %llu\n",
 				       bdevname(state->bdev, b), blk);
 			res = -1;
 			goto rdb_done;
@@ -61,12 +72,12 @@ int amiga_partition(struct parsed_partitions *state)
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
 
@@ -83,11 +94,16 @@ int amiga_partition(struct parsed_partitions *state)
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
 			if (warn_no_part)
-				pr_err("Dev %s: unable to read partition block %d\n",
+				pr_err("Dev %s: unable to read partition block %llu\n",
 				       bdevname(state->bdev, b), blk);
 			res = -1;
 			goto rdb_done;
@@ -99,19 +115,70 @@ int amiga_partition(struct parsed_partitions *state)
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

