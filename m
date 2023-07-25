Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECE087616C4
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235043AbjGYLmV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234999AbjGYLmG (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:42:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC6FC26B0
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:41:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 514E46169A
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:41:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65CF0C433C7;
        Tue, 25 Jul 2023 11:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690285288;
        bh=W9lKpO2hpnjOaCep9TJPM21+VDoQMnHx66l/UlLwexw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZLZdel0I0xdxta9//Tbjk8gb0WU/mj4fxgUcHDYa3IVRHLWUNiFR89u8kGUwmXrcW
         dDDDLVmVr/wMK/7jY1eNnj84dxbuc87jxB0LvzFTwqF7lY3A7WSRgl5gJgIl0kKheO
         6mhHgG+VA+bPxDYUQd8V25oj4GqOzwhdIbhLlrTY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Martin Steigerwald <Martin@lichtvoll.de>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5.4 124/313] block: change all __u32 annotations to __be32 in affs_hardblocks.h
Date:   Tue, 25 Jul 2023 12:44:37 +0200
Message-ID: <20230725104526.390095414@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104521.167250627@linuxfoundation.org>
References: <20230725104521.167250627@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Michael Schmitz <schmitzmic@gmail.com>

commit 95a55437dc49fb3342c82e61f5472a71c63d9ed0 upstream.

The Amiga partition parser module uses signed int for partition sector
address and count, which will overflow for disks larger than 1 TB.

Use u64 as type for sector address and size to allow using disks up to
2 TB without LBD support, and disks larger than 2 TB with LBD. The RBD
format allows to specify disk sizes up to 2^128 bytes (though native
OS limitations reduce this somewhat, to max 2^68 bytes), so check for
u64 overflow carefully to protect against overflowing sector_t.

This bug was reported originally in 2012, and the fix was created by
the RDB author, Joanne Dow <jdow@earthlink.net>. A patch had been
discussed and reviewed on linux-m68k at that time but never officially
submitted (now resubmitted as patch 1 of this series).

Patch 3 (this series) adds additional error checking and warning
messages. One of the error checks now makes use of the previously
unused rdb_CylBlocks field, which causes a 'sparse' warning
(cast to restricted __be32).

Annotate all 32 bit fields in affs_hardblocks.h as __be32, as the
on-disk format of RDB and partition blocks is always big endian.

Reported-by: Martin Steigerwald <Martin@lichtvoll.de>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=43511
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Message-ID: <201206192146.09327.Martin@lichtvoll.de>
Cc: <stable@vger.kernel.org> # 5.2
Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Link: https://lore.kernel.org/r/20230620201725.7020-3-schmitzmic@gmail.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/uapi/linux/affs_hardblocks.h |   68 +++++++++++++++++------------------
 1 file changed, 34 insertions(+), 34 deletions(-)

--- a/include/uapi/linux/affs_hardblocks.h
+++ b/include/uapi/linux/affs_hardblocks.h
@@ -7,42 +7,42 @@
 /* Just the needed definitions for the RDB of an Amiga HD. */
 
 struct RigidDiskBlock {
-	__u32	rdb_ID;
+	__be32	rdb_ID;
 	__be32	rdb_SummedLongs;
-	__s32	rdb_ChkSum;
-	__u32	rdb_HostID;
+	__be32	rdb_ChkSum;
+	__be32	rdb_HostID;
 	__be32	rdb_BlockBytes;
-	__u32	rdb_Flags;
-	__u32	rdb_BadBlockList;
+	__be32	rdb_Flags;
+	__be32	rdb_BadBlockList;
 	__be32	rdb_PartitionList;
-	__u32	rdb_FileSysHeaderList;
-	__u32	rdb_DriveInit;
-	__u32	rdb_Reserved1[6];
-	__u32	rdb_Cylinders;
-	__u32	rdb_Sectors;
-	__u32	rdb_Heads;
-	__u32	rdb_Interleave;
-	__u32	rdb_Park;
-	__u32	rdb_Reserved2[3];
-	__u32	rdb_WritePreComp;
-	__u32	rdb_ReducedWrite;
-	__u32	rdb_StepRate;
-	__u32	rdb_Reserved3[5];
-	__u32	rdb_RDBBlocksLo;
-	__u32	rdb_RDBBlocksHi;
-	__u32	rdb_LoCylinder;
-	__u32	rdb_HiCylinder;
-	__u32	rdb_CylBlocks;
-	__u32	rdb_AutoParkSeconds;
-	__u32	rdb_HighRDSKBlock;
-	__u32	rdb_Reserved4;
+	__be32	rdb_FileSysHeaderList;
+	__be32	rdb_DriveInit;
+	__be32	rdb_Reserved1[6];
+	__be32	rdb_Cylinders;
+	__be32	rdb_Sectors;
+	__be32	rdb_Heads;
+	__be32	rdb_Interleave;
+	__be32	rdb_Park;
+	__be32	rdb_Reserved2[3];
+	__be32	rdb_WritePreComp;
+	__be32	rdb_ReducedWrite;
+	__be32	rdb_StepRate;
+	__be32	rdb_Reserved3[5];
+	__be32	rdb_RDBBlocksLo;
+	__be32	rdb_RDBBlocksHi;
+	__be32	rdb_LoCylinder;
+	__be32	rdb_HiCylinder;
+	__be32	rdb_CylBlocks;
+	__be32	rdb_AutoParkSeconds;
+	__be32	rdb_HighRDSKBlock;
+	__be32	rdb_Reserved4;
 	char	rdb_DiskVendor[8];
 	char	rdb_DiskProduct[16];
 	char	rdb_DiskRevision[4];
 	char	rdb_ControllerVendor[8];
 	char	rdb_ControllerProduct[16];
 	char	rdb_ControllerRevision[4];
-	__u32	rdb_Reserved5[10];
+	__be32	rdb_Reserved5[10];
 };
 
 #define	IDNAME_RIGIDDISK	0x5244534B	/* "RDSK" */
@@ -50,16 +50,16 @@ struct RigidDiskBlock {
 struct PartitionBlock {
 	__be32	pb_ID;
 	__be32	pb_SummedLongs;
-	__s32	pb_ChkSum;
-	__u32	pb_HostID;
+	__be32	pb_ChkSum;
+	__be32	pb_HostID;
 	__be32	pb_Next;
-	__u32	pb_Flags;
-	__u32	pb_Reserved1[2];
-	__u32	pb_DevFlags;
+	__be32	pb_Flags;
+	__be32	pb_Reserved1[2];
+	__be32	pb_DevFlags;
 	__u8	pb_DriveName[32];
-	__u32	pb_Reserved2[15];
+	__be32	pb_Reserved2[15];
 	__be32	pb_Environment[17];
-	__u32	pb_EReserved[15];
+	__be32	pb_EReserved[15];
 };
 
 #define	IDNAME_PARTITION	0x50415254	/* "PART" */


