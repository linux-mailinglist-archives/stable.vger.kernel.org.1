Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFAF2733C7A
	for <lists+stable@lfdr.de>; Sat, 17 Jun 2023 00:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231928AbjFPWgc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 16 Jun 2023 18:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231912AbjFPWg0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Jun 2023 18:36:26 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E1430FD;
        Fri, 16 Jun 2023 15:36:25 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-666683eb028so1138304b3a.0;
        Fri, 16 Jun 2023 15:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686954985; x=1689546985;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3LLDiVG+RQa/fzfc+Aret+vyoXqbU6usti8V8wN1jVg=;
        b=hYfPZ1GthrDXNW2Cq9FPRXbeIFvqiBknYw4+m6A/+d8AapL/B9dU/TO/aQtLGIlbM3
         Loz1v5A6doepPWWIvFZUmOX0Sa2/vXAGwAC0wtzpvwRDVgW4hBmQ24aL+DWzmSmmjAfR
         84VCmM8/kjcd6zTbdU+4A9xS8sgcIenTgargXnxmZo9qO7UEMokgROA245JyeSjbgPkM
         Yoxej384hseOx2s5tY6FzqnH5ss/9gc71xCfTIKPZzAqhC8skGGy07sb7NKgrOwKF3nv
         bpEcbzh5shZdXohtDm163lQsxJVFn6uNz4GHjuXOb/baRSYmv3VfSflYHi0SaD795ytW
         Gvxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686954985; x=1689546985;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3LLDiVG+RQa/fzfc+Aret+vyoXqbU6usti8V8wN1jVg=;
        b=Em81FfNeyQQLeMP2tLPsv/y3U8+ZfJKORwst/Hjekvtnh402oSQ8Hr9oAl5j4NHvaB
         TTpMwTcj7LUXnDRRmvoLEnZzJgVvwP5MgTe/gTM91T2lgQJK+qjAV+f1zNGVFP5pk7OM
         t9ZwUS2rl3jVKk6tjb9yCSrQjSqUFY/CAy/ITuILwnO6CzfZSdL6S1+rOtIiiOrcn/hr
         12k+GuOSZj9BXxvYE1/DmnVSQhSJZi8FZNvA7zfneKjcUa1eGI2EnmPuPFnedpUd7jlQ
         hgmupAxXQeRUACBBNTfAoywxhTr+UPb5a4tqpXGEZbviPXqnan8WZrpvTzyt6ShbBzmA
         5Uaw==
X-Gm-Message-State: AC+VfDzp6HjCwy753cFnmg2TsAf8YtsvmdFk6HjVl4hmnV6z9p1svrSl
        ojIxGVF3fOnqd0xQmcBpnEY=
X-Google-Smtp-Source: ACHHUZ4j/c3eaO1aMc52MGEKTC5l/E5Fiq0xI7Y3JeGPWD2RZkTcnh1ZGKYUaP4vDZvxkT0eGQXlSw==
X-Received: by 2002:a05:6a00:1ace:b0:64f:daa9:d7af with SMTP id f14-20020a056a001ace00b0064fdaa9d7afmr3659307pfv.7.1686954984784;
        Fri, 16 Jun 2023 15:36:24 -0700 (PDT)
Received: from xplor.waratah.dyndns.org (222-152-217-2-adsl.sparkbb.co.nz. [222.152.217.2])
        by smtp.gmail.com with ESMTPSA id c4-20020a62e804000000b00666b012baedsm1822239pfi.158.2023.06.16.15.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 15:36:24 -0700 (PDT)
Received: by xplor.waratah.dyndns.org (Postfix, from userid 1000)
        id 3A89C36045B; Sat, 17 Jun 2023 10:36:20 +1200 (NZST)
From:   Michael Schmitz <schmitzmic@gmail.com>
To:     linux-block@vger.kernel.org, axboe@kernel.dk
Cc:     linux-m68k@vger.kernel.org, geert@linux-m68k.org, hch@lst.de,
        martin@lichtvoll.de, fthain@linux-m68k.org,
        Michael Schmitz <schmitzmic@gmail.com>, stable@vger.kernel.org
Subject: [PATCH v12 3/3] block: add overflow checks for Amiga partition support
Date:   Sat, 17 Jun 2023 10:36:16 +1200
Message-Id: <20230616223616.6002-4-schmitzmic@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230616223616.6002-1-schmitzmic@gmail.com>
References: <20230616223616.6002-1-schmitzmic@gmail.com>
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

---

Changes from RFC:

- use u64 instead of sector_t, since that may be u32 without LBD support
- check multiplication overflows each step - 3 u32 values may exceed u64!
- warn against use on AmigaDOS if partition data overflow u32 sector count.
- warn if partition CylBlocks larger than what's stored in the RDSK header.
- bail out if we were to overflow sector_t (32 or 64 bit).

Changes from v1:

Kars de Jong:
- use defines for magic offsets in DosEnvec struct

Geert Uytterhoeven:
- use u64 cast for multiplications of u32 numbers
- use array3_size for overflow checks
- change pr_err to pr_warn
- discontinue use of pr_cont
- reword log messages
- drop redundant nr_sects overflow test
- warn against 32 bit overflow for each affected partition
- skip partitions that overflow sector_t size instead of aborting scan

Changes from v2:

- further trim 32 bit overflow test
- correct duplicate types.h inclusion introduced in v2

Changes from v3:

- split off sector address type fix for independent review
- change blksize to unsigned
- use check_mul_overflow() instead of array3_size()
- rewrite checks to avoid 64 bit divisions in check_mul_overflow()

Changes from v5:

Geert Uytterhoeven:
- correct ineffective u64 cast to avoid 32 bit mult. overflow
- fix mult. overflow in partition block address calculation

Changes from v6:

Geert Uytterhoeven:
- don't fail hard on partition block address overflow

Changes from v7:

- replace bdevname(state->bdev, b) by state->disk->disk_name
- drop warn_no_part conditionals
- remove remaining warn_no_part

Changes from v8:

Christoph Hellwig:
- whitespace fix, drop unnecessary u64 casts

kbuild warning:
- sparse warning fix

Changes from v9:

- revert ineffective sparse warning fix, and rely on
  change to annotation of rdb_CylBlocks (patch 2 this
  series) instead.
- add Fixes: tags and stable backport prereq
---
 block/partitions/amiga.c | 103 ++++++++++++++++++++++++++++++++-------
 1 file changed, 85 insertions(+), 18 deletions(-)

diff --git a/block/partitions/amiga.c b/block/partitions/amiga.c
index 85c5c79aae48..ed222b9c901b 100644
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
 
 	for (blk = 0; ; blk++, put_dev_sector(sect)) {
@@ -41,7 +52,7 @@ int amiga_partition(struct parsed_partitions *state)
 			goto rdb_done;
 		data = read_part_sector(state, blk, &sect);
 		if (!data) {
-			pr_err("Dev %s: unable to read RDB block %d\n",
+			pr_err("Dev %s: unable to read RDB block %llu\n",
 			       state->disk->disk_name, blk);
 			res = -1;
 			goto rdb_done;
@@ -58,12 +69,12 @@ int amiga_partition(struct parsed_partitions *state)
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
 		       state->disk->disk_name, blk);
 	}
 
@@ -80,10 +91,15 @@ int amiga_partition(struct parsed_partitions *state)
 	blk = be32_to_cpu(rdb->rdb_PartitionList);
 	put_dev_sector(sect);
 	for (part = 1; blk>0 && part<=16; part++, put_dev_sector(sect)) {
-		blk *= blksize;	/* Read in terms partition table understands */
+		/* Read in terms partition table understands */
+		if (check_mul_overflow(blk, (sector_t) blksize, &blk)) {
+			pr_err("Dev %s: overflow calculating partition block %llu! Skipping partitions %u and beyond\n",
+				state->disk->disk_name, blk, part);
+			break;
+		}
 		data = read_part_sector(state, blk, &sect);
 		if (!data) {
-			pr_err("Dev %s: unable to read partition block %d\n",
+			pr_err("Dev %s: unable to read partition block %llu\n",
 			       state->disk->disk_name, blk);
 			res = -1;
 			goto rdb_done;
@@ -95,19 +111,70 @@ int amiga_partition(struct parsed_partitions *state)
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
+				state->disk->disk_name, cylblk);
+			continue;
+		}
+
+		/* check for consistency with RDB defined CylBlocks */
+		if (cylblk > be32_to_cpu(rdb->rdb_CylBlocks)) {
+			pr_warn("Dev %s: cylblk %u > rdb_CylBlocks %u!\n",
+				state->disk->disk_name, cylblk,
+				be32_to_cpu(rdb->rdb_CylBlocks));
+		}
+
+		/* RDB allows for variable logical block size -
+		 * normalize to 512 byte blocks and check result.
+		 */
+
+		if (check_mul_overflow(cylblk, blksize, &cylblk)) {
+			pr_err("Dev %s: partition %u bytes per cyl. overflows u32, skipping partition!\n",
+				state->disk->disk_name, part);
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
+				state->disk->disk_name, part,
+				start_sect, start_sect + nr_sects);
+		}
+
+		if (check_add_overflow(start_sect, nr_sects, &end_sect)) {
+			pr_err("Dev %s: partition %u (%llu-%llu) needs LBD device support, skipping partition!\n",
+				state->disk->disk_name, part,
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

