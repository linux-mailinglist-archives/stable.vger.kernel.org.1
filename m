Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB89F74F947
	for <lists+stable@lfdr.de>; Tue, 11 Jul 2023 22:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjGKUqL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 11 Jul 2023 16:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbjGKUqL (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 11 Jul 2023 16:46:11 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C27F41986
        for <stable@vger.kernel.org>; Tue, 11 Jul 2023 13:45:36 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-66f5faba829so3645574b3a.3
        for <stable@vger.kernel.org>; Tue, 11 Jul 2023 13:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689108335; x=1691700335;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kZlRzDjtjoYZ/DTuUKBf9MtFcf3ZvRdBFb+rzKNEhVo=;
        b=qB116eoCRC3Lxvx/gMz36r1h7ABe3ueBU2QqPBAiN5syCwvwKyc/D4CAgmbYCTesUP
         2QSeQKiB8JJptOoD4njRxr0woT1ODqANWomJq7dzsLACD+9tXLq/Ive3hsp/EjqSzaE4
         afz9FQ9AvVi8Ua2jhVWa9TEVFSOLtplASNGY0eoHEBl90DBbMjIAhPAEg8d1h9H4x3DV
         MRlAeGSJpEmilUI5Vl4mF7tbbwNfeLiwVsVzPAzzFH0kTmOondkI+qFtCu5WErSwktnp
         FqObBYISDyuvHvlgdtrMtOGxjZcmA0I6XSnJ+Zfs96Z419SR3ODHSMr0kzGeyxRz4X58
         YKzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689108335; x=1691700335;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kZlRzDjtjoYZ/DTuUKBf9MtFcf3ZvRdBFb+rzKNEhVo=;
        b=NJL58TTtTuyIa4x8geMy6rOLlsWVfYQk6s1kxfqY+1FHDuKzsuFWWU4Q74t9JQWgfa
         BEy6arnF/fy+gLRUARkDkBu7UsbaBKlf1alywTyYI25yonGCHGl6U0MUj/wwTZilJ16P
         jWa7ADDZiVBhxo/lghMMuVuhP9kVudl9hcLNjQNjXvv/en+64Fsl9ZmyJcQaUY8LgYSX
         a8YChNNeN9ueOz5UepFOsSol+Ap2pC272MxrLKIgNL5zxCm92jIB7oQlzL8MZ53Xe6me
         CmbXmOfBi3b7uM/TXTiQpJU/bjwVvdFnheH3BoP0P/C4G5kZZyoPb6tM0nCK3RGrmSgP
         NiDg==
X-Gm-Message-State: ABy/qLZurhINHPmjsWw8qGS/VK+UbXCwHYZ4pzzOcoLaeCtp09AYh1Ku
        QWqMKwxamRnHZUntCniuqN4=
X-Google-Smtp-Source: APBJJlGPC/GnmUB0cy3sxJmiBaOrWB7vsDzNSlyHO0quUFy7aZXqi02qQ7j5KP3Ggdf9wXfJCUv5Bw==
X-Received: by 2002:a05:6a00:2489:b0:668:99aa:3f17 with SMTP id c9-20020a056a00248900b0066899aa3f17mr17771554pfv.16.1689108334663;
        Tue, 11 Jul 2023 13:45:34 -0700 (PDT)
Received: from ?IPV6:2001:df0:0:200c:7107:8d5f:27ba:c525? ([2001:df0:0:200c:7107:8d5f:27ba:c525])
        by smtp.gmail.com with ESMTPSA id e26-20020a62aa1a000000b006749c22d079sm2094327pff.167.2023.07.11.13.45.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 13:45:34 -0700 (PDT)
Message-ID: <357b640e-5d24-7779-f4a6-d704bd623934@gmail.com>
Date:   Wed, 12 Jul 2023 08:45:27 +1200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: FAILED: patch "[PATCH] block: add overflow checks for Amiga
 partition support" failed to apply to 5.10-stable tree
Content-Language: en-US
To:     gregkh@linuxfoundation.org, Martin@lichtvoll.de, axboe@kernel.dk,
        geert@linux-m68k.org, hch@infradead.org, jdow@earthlink.net,
        stable@vger.kernel.org
References: <2023071116-umbrella-fog-a65f@gregkh>
From:   Michael Schmitz <schmitzmic@gmail.com>
In-Reply-To: <2023071116-umbrella-fog-a65f@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Greg,

this patch was part of a series of three patches 
(fc3d092c6bb48d5865fec15ed5b333c12f36288c, 
95a55437dc49fb3342c82e61f5472a71c63d9ed0, 
b6f3f28f604ba3de4724ad82bea6adb1300c0b5f). The first in that series must 
also be cherry-picked in order for the third one to apply cleanly.

You appear to have applied fc3d092c6bb48d5865fec15ed5b333c12f36288c to 
5.4 and 5.10 now, so I'd expect re-applying 
b6f3f28f604ba3de4724ad82bea6adb1300c0b5f would work OK>

Please note that after these have all been applied, we still need 
7eb1e47696aa231b1a567846bbe3a1e1befe1854 ("block/partition: fix 
signedness issue for Amiga partitions") which is a bugfix for 
b6f3f28f604ba3de4724ad82bea6adb1300c0b5f.

Thanks!

Cheers,

     Michael


On 12/07/23 08:30, gregkh@linuxfoundation.org wrote:
> The patch below does not apply to the 5.10-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
>
> To reproduce the conflict and resubmit, you may use the following commands:
>
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
> git checkout FETCH_HEAD
> git cherry-pick -x b6f3f28f604ba3de4724ad82bea6adb1300c0b5f
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023071116-umbrella-fog-a65f@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..
>
> Possible dependencies:
>
>
>
> thanks,
>
> greg k-h
>
> ------------------ original commit in Linus's tree ------------------
>
>  From b6f3f28f604ba3de4724ad82bea6adb1300c0b5f Mon Sep 17 00:00:00 2001
> From: Michael Schmitz <schmitzmic@gmail.com>
> Date: Wed, 21 Jun 2023 08:17:25 +1200
> Subject: [PATCH] block: add overflow checks for Amiga partition support
>
> The Amiga partition parser module uses signed int for partition sector
> address and count, which will overflow for disks larger than 1 TB.
>
> Use u64 as type for sector address and size to allow using disks up to
> 2 TB without LBD support, and disks larger than 2 TB with LBD. The RBD
> format allows to specify disk sizes up to 2^128 bytes (though native
> OS limitations reduce this somewhat, to max 2^68 bytes), so check for
> u64 overflow carefully to protect against overflowing sector_t.
>
> Bail out if sector addresses overflow 32 bits on kernels without LBD
> support.
>
> This bug was reported originally in 2012, and the fix was created by
> the RDB author, Joanne Dow <jdow@earthlink.net>. A patch had been
> discussed and reviewed on linux-m68k at that time but never officially
> submitted (now resubmitted as patch 1 in this series).
> This patch adds additional error checking and warning messages.
>
> Reported-by: Martin Steigerwald <Martin@lichtvoll.de>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=43511
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Message-ID: <201206192146.09327.Martin@lichtvoll.de>
> Cc: <stable@vger.kernel.org> # 5.2
> Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Reviewed-by: Christoph Hellwig <hch@infradead.org>
> Link: https://lore.kernel.org/r/20230620201725.7020-4-schmitzmic@gmail.com
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>
> diff --git a/block/partitions/amiga.c b/block/partitions/amiga.c
> index 85c5c79aae48..ed222b9c901b 100644
> --- a/block/partitions/amiga.c
> +++ b/block/partitions/amiga.c
> @@ -11,10 +11,18 @@
>   #define pr_fmt(fmt) fmt
>   
>   #include <linux/types.h>
> +#include <linux/mm_types.h>
> +#include <linux/overflow.h>
>   #include <linux/affs_hardblocks.h>
>   
>   #include "check.h"
>   
> +/* magic offsets in partition DosEnvVec */
> +#define NR_HD	3
> +#define NR_SECT	5
> +#define LO_CYL	9
> +#define HI_CYL	10
> +
>   static __inline__ u32
>   checksum_block(__be32 *m, int size)
>   {
> @@ -31,9 +39,12 @@ int amiga_partition(struct parsed_partitions *state)
>   	unsigned char *data;
>   	struct RigidDiskBlock *rdb;
>   	struct PartitionBlock *pb;
> -	sector_t start_sect, nr_sects;
> -	int blk, part, res = 0;
> -	int blksize = 1;	/* Multiplier for disk block size */
> +	u64 start_sect, nr_sects;
> +	sector_t blk, end_sect;
> +	u32 cylblk;		/* rdb_CylBlocks = nr_heads*sect_per_track */
> +	u32 nr_hd, nr_sect, lo_cyl, hi_cyl;
> +	int part, res = 0;
> +	unsigned int blksize = 1;	/* Multiplier for disk block size */
>   	int slot = 1;
>   
>   	for (blk = 0; ; blk++, put_dev_sector(sect)) {
> @@ -41,7 +52,7 @@ int amiga_partition(struct parsed_partitions *state)
>   			goto rdb_done;
>   		data = read_part_sector(state, blk, &sect);
>   		if (!data) {
> -			pr_err("Dev %s: unable to read RDB block %d\n",
> +			pr_err("Dev %s: unable to read RDB block %llu\n",
>   			       state->disk->disk_name, blk);
>   			res = -1;
>   			goto rdb_done;
> @@ -58,12 +69,12 @@ int amiga_partition(struct parsed_partitions *state)
>   		*(__be32 *)(data+0xdc) = 0;
>   		if (checksum_block((__be32 *)data,
>   				be32_to_cpu(rdb->rdb_SummedLongs) & 0x7F)==0) {
> -			pr_err("Trashed word at 0xd0 in block %d ignored in checksum calculation\n",
> +			pr_err("Trashed word at 0xd0 in block %llu ignored in checksum calculation\n",
>   			       blk);
>   			break;
>   		}
>   
> -		pr_err("Dev %s: RDB in block %d has bad checksum\n",
> +		pr_err("Dev %s: RDB in block %llu has bad checksum\n",
>   		       state->disk->disk_name, blk);
>   	}
>   
> @@ -80,10 +91,15 @@ int amiga_partition(struct parsed_partitions *state)
>   	blk = be32_to_cpu(rdb->rdb_PartitionList);
>   	put_dev_sector(sect);
>   	for (part = 1; blk>0 && part<=16; part++, put_dev_sector(sect)) {
> -		blk *= blksize;	/* Read in terms partition table understands */
> +		/* Read in terms partition table understands */
> +		if (check_mul_overflow(blk, (sector_t) blksize, &blk)) {
> +			pr_err("Dev %s: overflow calculating partition block %llu! Skipping partitions %u and beyond\n",
> +				state->disk->disk_name, blk, part);
> +			break;
> +		}
>   		data = read_part_sector(state, blk, &sect);
>   		if (!data) {
> -			pr_err("Dev %s: unable to read partition block %d\n",
> +			pr_err("Dev %s: unable to read partition block %llu\n",
>   			       state->disk->disk_name, blk);
>   			res = -1;
>   			goto rdb_done;
> @@ -95,19 +111,70 @@ int amiga_partition(struct parsed_partitions *state)
>   		if (checksum_block((__be32 *)pb, be32_to_cpu(pb->pb_SummedLongs) & 0x7F) != 0 )
>   			continue;
>   
> -		/* Tell Kernel about it */
> +		/* RDB gives us more than enough rope to hang ourselves with,
> +		 * many times over (2^128 bytes if all fields max out).
> +		 * Some careful checks are in order, so check for potential
> +		 * overflows.
> +		 * We are multiplying four 32 bit numbers to one sector_t!
> +		 */
> +
> +		nr_hd   = be32_to_cpu(pb->pb_Environment[NR_HD]);
> +		nr_sect = be32_to_cpu(pb->pb_Environment[NR_SECT]);
> +
> +		/* CylBlocks is total number of blocks per cylinder */
> +		if (check_mul_overflow(nr_hd, nr_sect, &cylblk)) {
> +			pr_err("Dev %s: heads*sects %u overflows u32, skipping partition!\n",
> +				state->disk->disk_name, cylblk);
> +			continue;
> +		}
> +
> +		/* check for consistency with RDB defined CylBlocks */
> +		if (cylblk > be32_to_cpu(rdb->rdb_CylBlocks)) {
> +			pr_warn("Dev %s: cylblk %u > rdb_CylBlocks %u!\n",
> +				state->disk->disk_name, cylblk,
> +				be32_to_cpu(rdb->rdb_CylBlocks));
> +		}
> +
> +		/* RDB allows for variable logical block size -
> +		 * normalize to 512 byte blocks and check result.
> +		 */
> +
> +		if (check_mul_overflow(cylblk, blksize, &cylblk)) {
> +			pr_err("Dev %s: partition %u bytes per cyl. overflows u32, skipping partition!\n",
> +				state->disk->disk_name, part);
> +			continue;
> +		}
> +
> +		/* Calculate partition start and end. Limit of 32 bit on cylblk
> +		 * guarantees no overflow occurs if LBD support is enabled.
> +		 */
> +
> +		lo_cyl = be32_to_cpu(pb->pb_Environment[LO_CYL]);
> +		start_sect = ((u64) lo_cyl * cylblk);
> +
> +		hi_cyl = be32_to_cpu(pb->pb_Environment[HI_CYL]);
> +		nr_sects = (((u64) hi_cyl - lo_cyl + 1) * cylblk);
>   
> -		nr_sects = ((sector_t)be32_to_cpu(pb->pb_Environment[10]) + 1 -
> -			   be32_to_cpu(pb->pb_Environment[9])) *
> -			   be32_to_cpu(pb->pb_Environment[3]) *
> -			   be32_to_cpu(pb->pb_Environment[5]) *
> -			   blksize;
>   		if (!nr_sects)
>   			continue;
> -		start_sect = (sector_t)be32_to_cpu(pb->pb_Environment[9]) *
> -			     be32_to_cpu(pb->pb_Environment[3]) *
> -			     be32_to_cpu(pb->pb_Environment[5]) *
> -			     blksize;
> +
> +		/* Warn user if partition end overflows u32 (AmigaDOS limit) */
> +
> +		if ((start_sect + nr_sects) > UINT_MAX) {
> +			pr_warn("Dev %s: partition %u (%llu-%llu) needs 64 bit device support!\n",
> +				state->disk->disk_name, part,
> +				start_sect, start_sect + nr_sects);
> +		}
> +
> +		if (check_add_overflow(start_sect, nr_sects, &end_sect)) {
> +			pr_err("Dev %s: partition %u (%llu-%llu) needs LBD device support, skipping partition!\n",
> +				state->disk->disk_name, part,
> +				start_sect, end_sect);
> +			continue;
> +		}
> +
> +		/* Tell Kernel about it */
> +
>   		put_partition(state,slot++,start_sect,nr_sects);
>   		{
>   			/* Be even more informative to aid mounting */
>
