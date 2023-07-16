Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE6DA75564B
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232864AbjGPUtZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232865AbjGPUtO (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:49:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77AA10C6
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:49:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 97E0260EBA
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:49:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A30D0C433C8;
        Sun, 16 Jul 2023 20:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689540552;
        bh=g+3ruqFHovZ8MFFYXii+O9VihbOq6uqSxPTrEf1wkks=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j6u9b5P/8A9wgF5cZzgZlQVehhNkN5zOogceGD61Z2DYPv7CrFnyuyMCZx2GGLO69
         PZHmmz/JDB4CNaE5R6/g/0zRmxugImzCYRV77iVWrLlKEV4GyqSGE1sdu5yazLDwxj
         Y/izsaETQetCDU4cebdcO/wB/PoWSWaKLM4eRGw0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Martin Steigerwald <Martin@lichtvoll.de>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6.1 376/591] block: fix signed int overflow in Amiga partition support
Date:   Sun, 16 Jul 2023 21:48:35 +0200
Message-ID: <20230716194933.645708202@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Michael Schmitz <schmitzmic@gmail.com>

commit fc3d092c6bb48d5865fec15ed5b333c12f36288c upstream.

The Amiga partition parser module uses signed int for partition sector
address and count, which will overflow for disks larger than 1 TB.

Use sector_t as type for sector address and size to allow using disks
up to 2 TB without LBD support, and disks larger than 2 TB with LBD.

This bug was reported originally in 2012, and the fix was created by
the RDB author, Joanne Dow <jdow@earthlink.net>. A patch had been
discussed and reviewed on linux-m68k at that time but never officially
submitted. This patch differs from Joanne's patch only in its use of
sector_t instead of unsigned int. No checking for overflows is done
(see patch 3 of this series for that).

Reported-by: Martin Steigerwald <Martin@lichtvoll.de>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=43511
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Message-ID: <201206192146.09327.Martin@lichtvoll.de>
Cc: <stable@vger.kernel.org> # 5.2
Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
Tested-by: Martin Steigerwald <Martin@lichtvoll.de>
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/r/20230620201725.7020-2-schmitzmic@gmail.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 block/partitions/amiga.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/block/partitions/amiga.c
+++ b/block/partitions/amiga.c
@@ -31,7 +31,8 @@ int amiga_partition(struct parsed_partit
 	unsigned char *data;
 	struct RigidDiskBlock *rdb;
 	struct PartitionBlock *pb;
-	int start_sect, nr_sects, blk, part, res = 0;
+	sector_t start_sect, nr_sects;
+	int blk, part, res = 0;
 	int blksize = 1;	/* Multiplier for disk block size */
 	int slot = 1;
 
@@ -96,14 +97,14 @@ int amiga_partition(struct parsed_partit
 
 		/* Tell Kernel about it */
 
-		nr_sects = (be32_to_cpu(pb->pb_Environment[10]) + 1 -
-			    be32_to_cpu(pb->pb_Environment[9])) *
+		nr_sects = ((sector_t)be32_to_cpu(pb->pb_Environment[10]) + 1 -
+			   be32_to_cpu(pb->pb_Environment[9])) *
 			   be32_to_cpu(pb->pb_Environment[3]) *
 			   be32_to_cpu(pb->pb_Environment[5]) *
 			   blksize;
 		if (!nr_sects)
 			continue;
-		start_sect = be32_to_cpu(pb->pb_Environment[9]) *
+		start_sect = (sector_t)be32_to_cpu(pb->pb_Environment[9]) *
 			     be32_to_cpu(pb->pb_Environment[3]) *
 			     be32_to_cpu(pb->pb_Environment[5]) *
 			     blksize;


