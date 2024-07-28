Return-Path: <stable+bounces-62065-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B8693E292
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 03:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35CAD1C203AD
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 01:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302AE19048F;
	Sun, 28 Jul 2024 00:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RbGX/Pao"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1579190484;
	Sun, 28 Jul 2024 00:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722128051; cv=none; b=oPrhDruttMEoy9cPbfedaENiYQJZW/F6OoK6EjwyRMn7ss9+6UBWmSm+dy7QUUPu/7oMVR9D57GNgtfxgOsqynyvELWwZQ6cFkXG7Bwf5WPzoJr8yybr2S1WO9+ks5O9pPzN0jU+QFxJ3rBGeqXMbt+C+lz4f9zq+EjTjuw154U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722128051; c=relaxed/simple;
	bh=hFhTy+RSHEXj5DLqDabhTcEBzSq6QB/gNVSJNkPGQQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cDh2zlFVyHixZD+p6Y02kLObXQjOcSAYnxCgf3MFhkLHhjv1zXU5cJ5y+fY41CEUNbpFM1NBXIPn2XSAmz3xFMMNzUQUXSihYm4BwITZZQ8b3fOdMvUzzc1BUy1hFeADMzXIMLs46f31OQQVRyJmnRCPLnyv0lXOnAONJFoRg70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RbGX/Pao; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E05EC32781;
	Sun, 28 Jul 2024 00:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722128050;
	bh=hFhTy+RSHEXj5DLqDabhTcEBzSq6QB/gNVSJNkPGQQc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RbGX/PaofACRWu6O/LaGlPbvYX0BiaYokC2RZX5rohQ52Pc4QDOON2ydxNVUrxDZa
	 6UcJnEGMoEDHDyZ2gVspZ+/Ls6GVqpbY5bE3lTfHjUjrsv0/VnqZ8AoKF5x1ljD686
	 ibdKhrWigKm9yprtJ1bChOMhB9gkC6J5LfHfpyaUKWxm/tZAga0X8ggzJdLl/aFtiI
	 yRhgwxOihBKxQeEWx9y4kBYOON49xDrO4yS+wrTMSc9BbgZtRw/dXV/M/QEW5Oz4ff
	 KS0vmDjZetSNqOru51A9+gQxG81XK7OTmn0W2JzO55IFkwYG7kVpyMvOWtmsyv3TVJ
	 xwOhHnUuaHsuQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Roman Smirnov <r.smirnov@omp.ru>,
	Jan Kara <jack@suse.com>,
	Jan Kara <jack@suse.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.10 14/27] udf: prevent integer overflow in udf_bitmap_free_blocks()
Date: Sat, 27 Jul 2024 20:52:57 -0400
Message-ID: <20240728005329.1723272-14-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728005329.1723272-1-sashal@kernel.org>
References: <20240728005329.1723272-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
Content-Transfer-Encoding: 8bit

From: Roman Smirnov <r.smirnov@omp.ru>

[ Upstream commit 56e69e59751d20993f243fb7dd6991c4e522424c ]

An overflow may occur if the function is called with the last
block and an offset greater than zero. It is necessary to add
a check to avoid this.

Found by Linux Verification Center (linuxtesting.org) with Svace.

[JK: Make test cover also unalloc table freeing]

Link: https://patch.msgid.link/20240620072413.7448-1-r.smirnov@omp.ru
Suggested-by: Jan Kara <jack@suse.com>
Signed-off-by: Roman Smirnov <r.smirnov@omp.ru>
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/udf/balloc.c | 36 +++++++++++++-----------------------
 1 file changed, 13 insertions(+), 23 deletions(-)

diff --git a/fs/udf/balloc.c b/fs/udf/balloc.c
index ab3ffc355949d..2192c4a1ba98b 100644
--- a/fs/udf/balloc.c
+++ b/fs/udf/balloc.c
@@ -18,6 +18,7 @@
 #include "udfdecl.h"
 
 #include <linux/bitops.h>
+#include <linux/overflow.h>
 
 #include "udf_i.h"
 #include "udf_sb.h"
@@ -129,7 +130,6 @@ static void udf_bitmap_free_blocks(struct super_block *sb,
 {
 	struct udf_sb_info *sbi = UDF_SB(sb);
 	struct buffer_head *bh = NULL;
-	struct udf_part_map *partmap;
 	unsigned long block;
 	unsigned long block_group;
 	unsigned long bit;
@@ -138,19 +138,9 @@ static void udf_bitmap_free_blocks(struct super_block *sb,
 	unsigned long overflow;
 
 	mutex_lock(&sbi->s_alloc_mutex);
-	partmap = &sbi->s_partmaps[bloc->partitionReferenceNum];
-	if (bloc->logicalBlockNum + count < count ||
-	    (bloc->logicalBlockNum + count) > partmap->s_partition_len) {
-		udf_debug("%u < %d || %u + %u > %u\n",
-			  bloc->logicalBlockNum, 0,
-			  bloc->logicalBlockNum, count,
-			  partmap->s_partition_len);
-		goto error_return;
-	}
-
+	/* We make sure this cannot overflow when mounting the filesystem */
 	block = bloc->logicalBlockNum + offset +
 		(sizeof(struct spaceBitmapDesc) << 3);
-
 	do {
 		overflow = 0;
 		block_group = block >> (sb->s_blocksize_bits + 3);
@@ -380,7 +370,6 @@ static void udf_table_free_blocks(struct super_block *sb,
 				  uint32_t count)
 {
 	struct udf_sb_info *sbi = UDF_SB(sb);
-	struct udf_part_map *partmap;
 	uint32_t start, end;
 	uint32_t elen;
 	struct kernel_lb_addr eloc;
@@ -389,16 +378,6 @@ static void udf_table_free_blocks(struct super_block *sb,
 	struct udf_inode_info *iinfo;
 
 	mutex_lock(&sbi->s_alloc_mutex);
-	partmap = &sbi->s_partmaps[bloc->partitionReferenceNum];
-	if (bloc->logicalBlockNum + count < count ||
-	    (bloc->logicalBlockNum + count) > partmap->s_partition_len) {
-		udf_debug("%u < %d || %u + %u > %u\n",
-			  bloc->logicalBlockNum, 0,
-			  bloc->logicalBlockNum, count,
-			  partmap->s_partition_len);
-		goto error_return;
-	}
-
 	iinfo = UDF_I(table);
 	udf_add_free_space(sb, sbi->s_partition, count);
 
@@ -673,6 +652,17 @@ void udf_free_blocks(struct super_block *sb, struct inode *inode,
 {
 	uint16_t partition = bloc->partitionReferenceNum;
 	struct udf_part_map *map = &UDF_SB(sb)->s_partmaps[partition];
+	uint32_t blk;
+
+	if (check_add_overflow(bloc->logicalBlockNum, offset, &blk) ||
+	    check_add_overflow(blk, count, &blk) ||
+	    bloc->logicalBlockNum + count > map->s_partition_len) {
+		udf_debug("Invalid request to free blocks: (%d, %u), off %u, "
+			  "len %u, partition len %u\n",
+			  partition, bloc->logicalBlockNum, offset, count,
+			  map->s_partition_len);
+		return;
+	}
 
 	if (map->s_partition_flags & UDF_PART_FLAG_UNALLOC_BITMAP) {
 		udf_bitmap_free_blocks(sb, map->s_uspace.s_bitmap,
-- 
2.43.0


