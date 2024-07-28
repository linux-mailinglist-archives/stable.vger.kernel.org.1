Return-Path: <stable+bounces-62124-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E65293E358
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 03:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C35BDB212DA
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 01:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA801465AC;
	Sun, 28 Jul 2024 00:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XNvoo1CJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDA81AD3EA;
	Sun, 28 Jul 2024 00:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722128203; cv=none; b=FZnz2RwwqQzztEdhpx5WLDLrP6xvxg76JszuT0aagcp783+jh5DUHyXz2B2wf6iNBYI8kXbTB7J6qt8FLafLkIb24UeCEevVBhrOSUI/DkYExHYJbpQY8VYf27gOMkTyaZeoT7y8+w7+n9UDN5dvolAYPwlxRlC45wS2gjAOW0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722128203; c=relaxed/simple;
	bh=EqysIhRjeOUu7h/ujY+sQfsp3gZ9rCBVsmjYS7HPazY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tZHX9oFvub+9eX8q7U+l7+YKoel3ePW3qb5b8/rcqxm4T15z6+KCDK3n+/CLAPw64KX1QLW5eASPVRxkXvSOHZT5+CGzwHfgwNCKL0aX5pbPw479Ixh8cKNYZyeLfjOfqOfKd1GgXAHZcJCL5rw4qNq7SJAEDtoHmg4Obry/MNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XNvoo1CJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A16CBC4AF0F;
	Sun, 28 Jul 2024 00:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722128202;
	bh=EqysIhRjeOUu7h/ujY+sQfsp3gZ9rCBVsmjYS7HPazY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XNvoo1CJDkOwSmoDjLC/7yZYDN5zHTXGlPQnVBnN01mHaN/s+R2LMMLaKyJ2IY+nv
	 PoOzJ5Kq0vrNYcMYZwUHbNpKw0lLjfyMwRigUBDbqY5yBYgGraUrFhLBSWh6KGikrj
	 CdKY5WvSdh3tj2itxZs2fmyjpaaHg99aJHv9fqBInAMxGzL+SZtpothtTRLf/k3yxO
	 xfkEVWlTWPesnuDyOLCR30pRBizxl1udGcZBsygXMovV6UDRHwN5Tb0VwlIawuLacU
	 yeOgEFYwikJTg+IAWQX7/qCEuW3mzxlTa2BahSafOe0Wqu6JhhqkmrrywqP9g6DWOc
	 gERNQTVasXiYA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Roman Smirnov <r.smirnov@omp.ru>,
	Jan Kara <jack@suse.com>,
	Jan Kara <jack@suse.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 2/4] udf: prevent integer overflow in udf_bitmap_free_blocks()
Date: Sat, 27 Jul 2024 20:56:36 -0400
Message-ID: <20240728005638.1737527-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728005638.1737527-1-sashal@kernel.org>
References: <20240728005638.1737527-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.319
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
index 0dc98bbad9c46..ac45f25bf40cc 100644
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
@@ -375,7 +365,6 @@ static void udf_table_free_blocks(struct super_block *sb,
 				  uint32_t count)
 {
 	struct udf_sb_info *sbi = UDF_SB(sb);
-	struct udf_part_map *partmap;
 	uint32_t start, end;
 	uint32_t elen;
 	struct kernel_lb_addr eloc;
@@ -384,16 +373,6 @@ static void udf_table_free_blocks(struct super_block *sb,
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
 
@@ -668,6 +647,17 @@ void udf_free_blocks(struct super_block *sb, struct inode *inode,
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


