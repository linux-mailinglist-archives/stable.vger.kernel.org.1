Return-Path: <stable+bounces-62100-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 720C993E30A
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 03:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E769B23586
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 01:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8CCD19FA9F;
	Sun, 28 Jul 2024 00:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JNjecJRa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948BB19FA95;
	Sun, 28 Jul 2024 00:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722128138; cv=none; b=jePZDGRREuQXTJOjpZV3E88ck9+9ChttiX6lQ6HVIEMkPkLjuR08SjFEpkWF+7VXunh5uFo0npFsUsyvbfbuIZTUObnC5I3PPRLOoOG/dde3t0Wxs5BWd9AY2jZEjPLizfhjZyx4gMDbYckfYoewCePs1qO4d9P86Vjrk3knTug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722128138; c=relaxed/simple;
	bh=kFevJLBujr1xQ5pThVVFKbQjVbolhn003MqkEybtqMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hSyk7rbPCEvemU8QfhuL69HZipKiKlRN+QCQwOqUAESk7ZT1y0PqGMUHICZc9evw8i0PbF1H9xoI1vw28XNzbmGG5xD+uuuAH+CA6QSHtKXdkgQgV3eWJDgQ+yicTN026LfgrzmiMOe7IEAyF0rGParU0hteI11K0zof9E0bDf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JNjecJRa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A64DAC32781;
	Sun, 28 Jul 2024 00:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722128138;
	bh=kFevJLBujr1xQ5pThVVFKbQjVbolhn003MqkEybtqMY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JNjecJRa/r4FT/aYcfiToc0Di3t5MZZ2VtrkqjdMs+RVukbahH+E1Q5vytnkFM/+N
	 HoI+0eYDjCeglmzBMnE9fdAgNJjy3iNSjGeJYHlfkTMjWKxDjmA5jGPN6Bqi+d1i9T
	 uIF7nfcy2tCM60UKwgWgXuwYEzYt1DpjQgKkPCMzcYfV1MdCyjkv9EEdMHdjr4lrzT
	 1FgJY1C5auBv+iLZOA5wmRYOtaWTn5CQr/GkqX1mg976nUIQKkYYrF+zTgc1YoZVqc
	 X3HFtDZwTvX/tWweTdlbXAGWr6vyGJaQaqbQUJAgj6kvGKJNawf5E7wLubmHVGHGu4
	 pprqm/lpttokQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Roman Smirnov <r.smirnov@omp.ru>,
	Jan Kara <jack@suse.com>,
	Jan Kara <jack@suse.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.1 07/11] udf: prevent integer overflow in udf_bitmap_free_blocks()
Date: Sat, 27 Jul 2024 20:55:12 -0400
Message-ID: <20240728005522.1731999-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728005522.1731999-1-sashal@kernel.org>
References: <20240728005522.1731999-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.102
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
index f416b7fe092fc..aeaa6d1f0e015 100644
--- a/fs/udf/balloc.c
+++ b/fs/udf/balloc.c
@@ -22,6 +22,7 @@
 #include "udfdecl.h"
 
 #include <linux/bitops.h>
+#include <linux/overflow.h>
 
 #include "udf_i.h"
 #include "udf_sb.h"
@@ -133,7 +134,6 @@ static void udf_bitmap_free_blocks(struct super_block *sb,
 {
 	struct udf_sb_info *sbi = UDF_SB(sb);
 	struct buffer_head *bh = NULL;
-	struct udf_part_map *partmap;
 	unsigned long block;
 	unsigned long block_group;
 	unsigned long bit;
@@ -142,19 +142,9 @@ static void udf_bitmap_free_blocks(struct super_block *sb,
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
@@ -384,7 +374,6 @@ static void udf_table_free_blocks(struct super_block *sb,
 				  uint32_t count)
 {
 	struct udf_sb_info *sbi = UDF_SB(sb);
-	struct udf_part_map *partmap;
 	uint32_t start, end;
 	uint32_t elen;
 	struct kernel_lb_addr eloc;
@@ -393,16 +382,6 @@ static void udf_table_free_blocks(struct super_block *sb,
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
 
@@ -677,6 +656,17 @@ void udf_free_blocks(struct super_block *sb, struct inode *inode,
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


