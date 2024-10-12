Return-Path: <stable+bounces-83523-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C83CE99B380
	for <lists+stable@lfdr.de>; Sat, 12 Oct 2024 13:28:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34312283C30
	for <lists+stable@lfdr.de>; Sat, 12 Oct 2024 11:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC0F199FC1;
	Sat, 12 Oct 2024 11:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dz8JBkkf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BE2199EA7;
	Sat, 12 Oct 2024 11:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728732400; cv=none; b=iJgczNboPCpoN2KxDPeGQM979CrXEyDXD61lKdHNVMwR1eb5Hn0+3+rbP2vdzuc74k+I+SScIZmnwaprSWysq11bNjAHw10oTTk8k9c0z6a9O3nsWVav+4gWE62DNlOHdSnRZb6MWfj3YjA+nV9GY84VFUkEXLoPJb/veqFYlrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728732400; c=relaxed/simple;
	bh=dnoFWlLv24av7r4wXWs+CQG7xffgIXFKHeoN39hExmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cwhYGtsS1QGkYUfwMVucimRztb3VDljpemH5VybmAB8eFjFmXUK900I4yj/YiRsu1YlRVWpekq3bDyiBCVpGM6DdmKEzREDaETxPl7SX6Lz/gHOAPNuHDSNau1uFzH0C3hm7Z0u/qZTl9PTRMSyKTokSC+YdbpuR/zYIaTNQ5kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dz8JBkkf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0F40C4CEC7;
	Sat, 12 Oct 2024 11:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728732399;
	bh=dnoFWlLv24av7r4wXWs+CQG7xffgIXFKHeoN39hExmI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dz8JBkkfdB8Tho5cIRgP6JbtrT5JLN+klfnF/rkCH7pDQpa4o3hY/dymLfIyJaPMr
	 GSeS5A+QfOvvElHJ7mUXGa6ERFUrytjVylBw1jUR7wLNEaJzuhm7u7EMLET6k/J/p5
	 hiBwYpPee9x3ZsgN9zupo8TR1EsvTH/SWJGNa4sCSOdZGZUGLjh+C3jx+hXkBEdEuD
	 8q3vi2cfNWV0yKsnqvyVz56TNd4LnoKgEuHgAEp3InAToXS+T2bNrddifXipaewYsg
	 q9G0BmMO5KR2+Jeg89p0ng6QdOYmnKpmSDg+8ZrnEVn1heVA0jPY9PIM7WQdc1Gst/
	 1Wb4QbYVG1PQQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhao Mengmeng <zhaomengmeng@kylinos.cn>,
	Jan Kara <jack@suse.cz>,
	Sasha Levin <sashal@kernel.org>,
	jack@suse.com
Subject: [PATCH AUTOSEL 6.11 09/16] udf: refactor udf_next_aext() to handle error
Date: Sat, 12 Oct 2024 07:26:05 -0400
Message-ID: <20241012112619.1762860-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241012112619.1762860-1-sashal@kernel.org>
References: <20241012112619.1762860-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.3
Content-Transfer-Encoding: 8bit

From: Zhao Mengmeng <zhaomengmeng@kylinos.cn>

[ Upstream commit b405c1e58b73981da0f8df03b00666b22b9397ae ]

Since udf_current_aext() has error handling, udf_next_aext() should have
error handling too. Besides, when too many indirect extents found in one
inode, return -EFSCORRUPTED; when reading block failed, return -EIO.

Signed-off-by: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Jan Kara <jack@suse.cz>
Link: https://patch.msgid.link/20241001115425.266556-3-zhaomzhao@126.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/udf/balloc.c    |  38 +++++++++-----
 fs/udf/directory.c |  10 +++-
 fs/udf/inode.c     | 125 ++++++++++++++++++++++++++++++---------------
 fs/udf/super.c     |   3 +-
 fs/udf/truncate.c  |  27 ++++++++--
 fs/udf/udfdecl.h   |   5 +-
 6 files changed, 143 insertions(+), 65 deletions(-)

diff --git a/fs/udf/balloc.c b/fs/udf/balloc.c
index d8fc11765d612..807c493ed0cd5 100644
--- a/fs/udf/balloc.c
+++ b/fs/udf/balloc.c
@@ -370,6 +370,7 @@ static void udf_table_free_blocks(struct super_block *sb,
 	struct extent_position oepos, epos;
 	int8_t etype;
 	struct udf_inode_info *iinfo;
+	int ret = 0;
 
 	mutex_lock(&sbi->s_alloc_mutex);
 	iinfo = UDF_I(table);
@@ -383,8 +384,12 @@ static void udf_table_free_blocks(struct super_block *sb,
 	epos.block = oepos.block = iinfo->i_location;
 	epos.bh = oepos.bh = NULL;
 
-	while (count &&
-	       (etype = udf_next_aext(table, &epos, &eloc, &elen, 1)) != -1) {
+	while (count) {
+		ret = udf_next_aext(table, &epos, &eloc, &elen, &etype, 1);
+		if (ret < 0)
+			goto error_return;
+		if (ret == 0)
+			break;
 		if (((eloc.logicalBlockNum +
 			(elen >> sb->s_blocksize_bits)) == start)) {
 			if ((0x3FFFFFFF - elen) <
@@ -459,11 +464,8 @@ static void udf_table_free_blocks(struct super_block *sb,
 			adsize = sizeof(struct short_ad);
 		else if (iinfo->i_alloc_type == ICBTAG_FLAG_AD_LONG)
 			adsize = sizeof(struct long_ad);
-		else {
-			brelse(oepos.bh);
-			brelse(epos.bh);
+		else
 			goto error_return;
-		}
 
 		if (epos.offset + (2 * adsize) > sb->s_blocksize) {
 			/* Steal a block from the extent being free'd */
@@ -479,10 +481,10 @@ static void udf_table_free_blocks(struct super_block *sb,
 			__udf_add_aext(table, &epos, &eloc, elen, 1);
 	}
 
+error_return:
 	brelse(epos.bh);
 	brelse(oepos.bh);
 
-error_return:
 	mutex_unlock(&sbi->s_alloc_mutex);
 	return;
 }
@@ -498,6 +500,7 @@ static int udf_table_prealloc_blocks(struct super_block *sb,
 	struct extent_position epos;
 	int8_t etype = -1;
 	struct udf_inode_info *iinfo;
+	int ret = 0;
 
 	if (first_block >= sbi->s_partmaps[partition].s_partition_len)
 		return 0;
@@ -516,11 +519,14 @@ static int udf_table_prealloc_blocks(struct super_block *sb,
 	epos.bh = NULL;
 	eloc.logicalBlockNum = 0xFFFFFFFF;
 
-	while (first_block != eloc.logicalBlockNum &&
-	       (etype = udf_next_aext(table, &epos, &eloc, &elen, 1)) != -1) {
+	while (first_block != eloc.logicalBlockNum) {
+		ret = udf_next_aext(table, &epos, &eloc, &elen, &etype, 1);
+		if (ret < 0)
+			goto err_out;
+		if (ret == 0)
+			break;
 		udf_debug("eloc=%u, elen=%u, first_block=%u\n",
 			  eloc.logicalBlockNum, elen, first_block);
-		; /* empty loop body */
 	}
 
 	if (first_block == eloc.logicalBlockNum) {
@@ -539,6 +545,7 @@ static int udf_table_prealloc_blocks(struct super_block *sb,
 		alloc_count = 0;
 	}
 
+err_out:
 	brelse(epos.bh);
 
 	if (alloc_count)
@@ -560,6 +567,7 @@ static udf_pblk_t udf_table_new_block(struct super_block *sb,
 	struct extent_position epos, goal_epos;
 	int8_t etype;
 	struct udf_inode_info *iinfo = UDF_I(table);
+	int ret = 0;
 
 	*err = -ENOSPC;
 
@@ -583,8 +591,10 @@ static udf_pblk_t udf_table_new_block(struct super_block *sb,
 	epos.block = iinfo->i_location;
 	epos.bh = goal_epos.bh = NULL;
 
-	while (spread &&
-	       (etype = udf_next_aext(table, &epos, &eloc, &elen, 1)) != -1) {
+	while (spread) {
+		ret = udf_next_aext(table, &epos, &eloc, &elen, &etype, 1);
+		if (ret <= 0)
+			break;
 		if (goal >= eloc.logicalBlockNum) {
 			if (goal < eloc.logicalBlockNum +
 					(elen >> sb->s_blocksize_bits))
@@ -612,9 +622,11 @@ static udf_pblk_t udf_table_new_block(struct super_block *sb,
 
 	brelse(epos.bh);
 
-	if (spread == 0xFFFFFFFF) {
+	if (ret < 0 || spread == 0xFFFFFFFF) {
 		brelse(goal_epos.bh);
 		mutex_unlock(&sbi->s_alloc_mutex);
+		if (ret < 0)
+			*err = ret;
 		return 0;
 	}
 
diff --git a/fs/udf/directory.c b/fs/udf/directory.c
index 93153665eb374..c6950050e7aeb 100644
--- a/fs/udf/directory.c
+++ b/fs/udf/directory.c
@@ -166,13 +166,19 @@ static struct buffer_head *udf_fiiter_bread_blk(struct udf_fileident_iter *iter)
  */
 static int udf_fiiter_advance_blk(struct udf_fileident_iter *iter)
 {
+	int8_t etype = -1;
+	int err = 0;
+
 	iter->loffset++;
 	if (iter->loffset < DIV_ROUND_UP(iter->elen, 1<<iter->dir->i_blkbits))
 		return 0;
 
 	iter->loffset = 0;
-	if (udf_next_aext(iter->dir, &iter->epos, &iter->eloc, &iter->elen, 1)
-			!= (EXT_RECORDED_ALLOCATED >> 30)) {
+	err = udf_next_aext(iter->dir, &iter->epos, &iter->eloc,
+			    &iter->elen, &etype, 1);
+	if (err < 0)
+		return err;
+	else if (err == 0 || etype != (EXT_RECORDED_ALLOCATED >> 30)) {
 		if (iter->pos == iter->dir->i_size) {
 			iter->elen = 0;
 			return 0;
diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index c64c2eff3399a..0459a87d4c02a 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -545,6 +545,7 @@ static int udf_do_extend_file(struct inode *inode,
 	} else {
 		struct kernel_lb_addr tmploc;
 		uint32_t tmplen;
+		int8_t tmptype;
 
 		udf_write_aext(inode, last_pos, &last_ext->extLocation,
 				last_ext->extLength, 1);
@@ -554,8 +555,12 @@ static int udf_do_extend_file(struct inode *inode,
 		 * more extents, we may need to enter possible following
 		 * empty indirect extent.
 		 */
-		if (new_block_bytes)
-			udf_next_aext(inode, last_pos, &tmploc, &tmplen, 0);
+		if (new_block_bytes) {
+			err = udf_next_aext(inode, last_pos, &tmploc, &tmplen,
+					    &tmptype, 0);
+			if (err < 0)
+				goto out_err;
+		}
 	}
 	iinfo->i_lenExtents += add;
 
@@ -674,8 +679,10 @@ static int udf_extend_file(struct inode *inode, loff_t newsize)
 		extent.extLength = EXT_NOT_RECORDED_NOT_ALLOCATED;
 	} else {
 		epos.offset -= adsize;
-		etype = udf_next_aext(inode, &epos, &extent.extLocation,
-				      &extent.extLength, 0);
+		err = udf_next_aext(inode, &epos, &extent.extLocation,
+				    &extent.extLength, &etype, 0);
+		if (err <= 0)
+			goto out;
 		extent.extLength |= etype << 30;
 	}
 
@@ -712,11 +719,11 @@ static int inode_getblk(struct inode *inode, struct udf_map_rq *map)
 	loff_t lbcount = 0, b_off = 0;
 	udf_pblk_t newblocknum;
 	sector_t offset = 0;
-	int8_t etype;
+	int8_t etype, tmpetype;
 	struct udf_inode_info *iinfo = UDF_I(inode);
 	udf_pblk_t goal = 0, pgoal = iinfo->i_location.logicalBlockNum;
 	int lastblock = 0;
-	bool isBeyondEOF;
+	bool isBeyondEOF = false;
 	int ret = 0;
 
 	prev_epos.offset = udf_file_entry_alloc_offset(inode);
@@ -748,9 +755,13 @@ static int inode_getblk(struct inode *inode, struct udf_map_rq *map)
 		prev_epos.offset = cur_epos.offset;
 		cur_epos.offset = next_epos.offset;
 
-		etype = udf_next_aext(inode, &next_epos, &eloc, &elen, 1);
-		if (etype == -1)
+		ret = udf_next_aext(inode, &next_epos, &eloc, &elen, &etype, 1);
+		if (ret < 0) {
+			goto out_free;
+		} else if (ret == 0) {
+			isBeyondEOF = true;
 			break;
+		}
 
 		c = !c;
 
@@ -771,13 +782,17 @@ static int inode_getblk(struct inode *inode, struct udf_map_rq *map)
 	 * Move prev_epos and cur_epos into indirect extent if we are at
 	 * the pointer to it
 	 */
-	udf_next_aext(inode, &prev_epos, &tmpeloc, &tmpelen, 0);
-	udf_next_aext(inode, &cur_epos, &tmpeloc, &tmpelen, 0);
+	ret = udf_next_aext(inode, &prev_epos, &tmpeloc, &tmpelen, &tmpetype, 0);
+	if (ret < 0)
+		goto out_free;
+	ret = udf_next_aext(inode, &cur_epos, &tmpeloc, &tmpelen, &tmpetype, 0);
+	if (ret < 0)
+		goto out_free;
 
 	/* if the extent is allocated and recorded, return the block
 	   if the extent is not a multiple of the blocksize, round up */
 
-	if (etype == (EXT_RECORDED_ALLOCATED >> 30)) {
+	if (!isBeyondEOF && etype == (EXT_RECORDED_ALLOCATED >> 30)) {
 		if (elen & (inode->i_sb->s_blocksize - 1)) {
 			elen = EXT_RECORDED_ALLOCATED |
 				((elen + inode->i_sb->s_blocksize - 1) &
@@ -793,10 +808,9 @@ static int inode_getblk(struct inode *inode, struct udf_map_rq *map)
 	}
 
 	/* Are we beyond EOF and preallocated extent? */
-	if (etype == -1) {
+	if (isBeyondEOF) {
 		loff_t hole_len;
 
-		isBeyondEOF = true;
 		if (count) {
 			if (c)
 				laarr[0] = laarr[1];
@@ -832,7 +846,6 @@ static int inode_getblk(struct inode *inode, struct udf_map_rq *map)
 		endnum = c + 1;
 		lastblock = 1;
 	} else {
-		isBeyondEOF = false;
 		endnum = startnum = ((count > 2) ? 2 : count);
 
 		/* if the current extent is in position 0,
@@ -846,15 +859,17 @@ static int inode_getblk(struct inode *inode, struct udf_map_rq *map)
 
 		/* if the current block is located in an extent,
 		   read the next extent */
-		etype = udf_next_aext(inode, &next_epos, &eloc, &elen, 0);
-		if (etype != -1) {
+		ret = udf_next_aext(inode, &next_epos, &eloc, &elen, &etype, 0);
+		if (ret > 0) {
 			laarr[c + 1].extLength = (etype << 30) | elen;
 			laarr[c + 1].extLocation = eloc;
 			count++;
 			startnum++;
 			endnum++;
-		} else
+		} else if (ret == 0)
 			lastblock = 1;
+		else
+			goto out_free;
 	}
 
 	/* if the current extent is not recorded but allocated, get the
@@ -1172,6 +1187,7 @@ static int udf_update_extents(struct inode *inode, struct kernel_long_ad *laarr,
 	int start = 0, i;
 	struct kernel_lb_addr tmploc;
 	uint32_t tmplen;
+	int8_t tmpetype;
 	int err;
 
 	if (startnum > endnum) {
@@ -1189,14 +1205,19 @@ static int udf_update_extents(struct inode *inode, struct kernel_long_ad *laarr,
 			 */
 			if (err < 0)
 				return err;
-			udf_next_aext(inode, epos, &laarr[i].extLocation,
-				      &laarr[i].extLength, 1);
+			err = udf_next_aext(inode, epos, &laarr[i].extLocation,
+				      &laarr[i].extLength, &tmpetype, 1);
+			if (err < 0)
+				return err;
 			start++;
 		}
 	}
 
 	for (i = start; i < endnum; i++) {
-		udf_next_aext(inode, epos, &tmploc, &tmplen, 0);
+		err = udf_next_aext(inode, epos, &tmploc, &tmplen, &tmpetype, 0);
+		if (err < 0)
+			return err;
+
 		udf_write_aext(inode, epos, &laarr[i].extLocation,
 			       laarr[i].extLength, 1);
 	}
@@ -2168,24 +2189,30 @@ void udf_write_aext(struct inode *inode, struct extent_position *epos,
  */
 #define UDF_MAX_INDIR_EXTS 16
 
-int8_t udf_next_aext(struct inode *inode, struct extent_position *epos,
-		     struct kernel_lb_addr *eloc, uint32_t *elen, int inc)
+/*
+ * Returns 1 on success, -errno on error, 0 on hit EOF.
+ */
+int udf_next_aext(struct inode *inode, struct extent_position *epos,
+		  struct kernel_lb_addr *eloc, uint32_t *elen, int8_t *etype,
+		  int inc)
 {
-	int8_t etype;
 	unsigned int indirections = 0;
 	int ret = 0;
+	udf_pblk_t block;
 
-	while ((ret = udf_current_aext(inode, epos, eloc, elen,
-				       &etype, inc)) > 0) {
-		if (etype != (EXT_NEXT_EXTENT_ALLOCDESCS >> 30))
-			break;
-		udf_pblk_t block;
+	while (1) {
+		ret = udf_current_aext(inode, epos, eloc, elen,
+				       etype, inc);
+		if (ret <= 0)
+			return ret;
+		if (*etype != (EXT_NEXT_EXTENT_ALLOCDESCS >> 30))
+			return ret;
 
 		if (++indirections > UDF_MAX_INDIR_EXTS) {
 			udf_err(inode->i_sb,
 				"too many indirect extents in inode %lu\n",
 				inode->i_ino);
-			return -1;
+			return -EFSCORRUPTED;
 		}
 
 		epos->block = *eloc;
@@ -2195,11 +2222,9 @@ int8_t udf_next_aext(struct inode *inode, struct extent_position *epos,
 		epos->bh = sb_bread(inode->i_sb, block);
 		if (!epos->bh) {
 			udf_debug("reading block %u failed!\n", block);
-			return -1;
+			return -EIO;
 		}
 	}
-
-	return ret > 0 ? etype : -1;
 }
 
 /*
@@ -2265,20 +2290,24 @@ static int udf_insert_aext(struct inode *inode, struct extent_position epos,
 	struct kernel_lb_addr oeloc;
 	uint32_t oelen;
 	int8_t etype;
-	int err;
+	int ret;
 
 	if (epos.bh)
 		get_bh(epos.bh);
 
-	while ((etype = udf_next_aext(inode, &epos, &oeloc, &oelen, 0)) != -1) {
+	while (1) {
+		ret = udf_next_aext(inode, &epos, &oeloc, &oelen, &etype, 0);
+		if (ret <= 0)
+			break;
 		udf_write_aext(inode, &epos, &neloc, nelen, 1);
 		neloc = oeloc;
 		nelen = (etype << 30) | oelen;
 	}
-	err = udf_add_aext(inode, &epos, &neloc, nelen, 1);
+	if (ret == 0)
+		ret = udf_add_aext(inode, &epos, &neloc, nelen, 1);
 	brelse(epos.bh);
 
-	return err;
+	return ret;
 }
 
 int8_t udf_delete_aext(struct inode *inode, struct extent_position epos)
@@ -2290,6 +2319,7 @@ int8_t udf_delete_aext(struct inode *inode, struct extent_position epos)
 	struct udf_inode_info *iinfo;
 	struct kernel_lb_addr eloc;
 	uint32_t elen;
+	int ret;
 
 	if (epos.bh) {
 		get_bh(epos.bh);
@@ -2305,10 +2335,18 @@ int8_t udf_delete_aext(struct inode *inode, struct extent_position epos)
 		adsize = 0;
 
 	oepos = epos;
-	if (udf_next_aext(inode, &epos, &eloc, &elen, 1) == -1)
+	if (udf_next_aext(inode, &epos, &eloc, &elen, &etype, 1) <= 0)
 		return -1;
 
-	while ((etype = udf_next_aext(inode, &epos, &eloc, &elen, 1)) != -1) {
+	while (1) {
+		ret = udf_next_aext(inode, &epos, &eloc, &elen, &etype, 1);
+		if (ret < 0) {
+			brelse(epos.bh);
+			brelse(oepos.bh);
+			return -1;
+		}
+		if (ret == 0)
+			break;
 		udf_write_aext(inode, &oepos, &eloc, (etype << 30) | elen, 1);
 		if (oepos.bh != epos.bh) {
 			oepos.block = epos.block;
@@ -2373,6 +2411,7 @@ int8_t inode_bmap(struct inode *inode, sector_t block,
 	loff_t lbcount = 0, bcount = (loff_t) block << blocksize_bits;
 	int8_t etype;
 	struct udf_inode_info *iinfo;
+	int err = 0;
 
 	iinfo = UDF_I(inode);
 	if (!udf_read_extent_cache(inode, bcount, &lbcount, pos)) {
@@ -2382,10 +2421,12 @@ int8_t inode_bmap(struct inode *inode, sector_t block,
 	}
 	*elen = 0;
 	do {
-		etype = udf_next_aext(inode, pos, eloc, elen, 1);
-		if (etype == -1) {
-			*offset = (bcount - lbcount) >> blocksize_bits;
-			iinfo->i_lenExtents = lbcount;
+		err = udf_next_aext(inode, pos, eloc, elen, &etype, 1);
+		if (err <= 0) {
+			if (err == 0) {
+				*offset = (bcount - lbcount) >> blocksize_bits;
+				iinfo->i_lenExtents = lbcount;
+			}
 			return -1;
 		}
 		lbcount += *elen;
diff --git a/fs/udf/super.c b/fs/udf/super.c
index 3460ecc826d16..1c8a736b33097 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -2482,13 +2482,14 @@ static unsigned int udf_count_free_table(struct super_block *sb,
 	uint32_t elen;
 	struct kernel_lb_addr eloc;
 	struct extent_position epos;
+	int8_t etype;
 
 	mutex_lock(&UDF_SB(sb)->s_alloc_mutex);
 	epos.block = UDF_I(table)->i_location;
 	epos.offset = sizeof(struct unallocSpaceEntry);
 	epos.bh = NULL;
 
-	while (udf_next_aext(table, &epos, &eloc, &elen, 1) != -1)
+	while (udf_next_aext(table, &epos, &eloc, &elen, &etype, 1) > 0)
 		accum += (elen >> table->i_sb->s_blocksize_bits);
 
 	brelse(epos.bh);
diff --git a/fs/udf/truncate.c b/fs/udf/truncate.c
index 4758ba7b5f51c..399958f891d14 100644
--- a/fs/udf/truncate.c
+++ b/fs/udf/truncate.c
@@ -69,6 +69,7 @@ void udf_truncate_tail_extent(struct inode *inode)
 	int8_t etype = -1, netype;
 	int adsize;
 	struct udf_inode_info *iinfo = UDF_I(inode);
+	int ret;
 
 	if (iinfo->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB ||
 	    inode->i_size == iinfo->i_lenExtents)
@@ -85,7 +86,10 @@ void udf_truncate_tail_extent(struct inode *inode)
 		BUG();
 
 	/* Find the last extent in the file */
-	while ((netype = udf_next_aext(inode, &epos, &eloc, &elen, 1)) != -1) {
+	while (1) {
+		ret = udf_next_aext(inode, &epos, &eloc, &elen, &netype, 1);
+		if (ret <= 0)
+			break;
 		etype = netype;
 		lbcount += elen;
 		if (lbcount > inode->i_size) {
@@ -101,7 +105,8 @@ void udf_truncate_tail_extent(struct inode *inode)
 			epos.offset -= adsize;
 			extent_trunc(inode, &epos, &eloc, etype, elen, nelen);
 			epos.offset += adsize;
-			if (udf_next_aext(inode, &epos, &eloc, &elen, 1) != -1)
+			if (udf_next_aext(inode, &epos, &eloc, &elen,
+					  &netype, 1) > 0)
 				udf_err(inode->i_sb,
 					"Extent after EOF in inode %u\n",
 					(unsigned)inode->i_ino);
@@ -110,7 +115,8 @@ void udf_truncate_tail_extent(struct inode *inode)
 	}
 	/* This inode entry is in-memory only and thus we don't have to mark
 	 * the inode dirty */
-	iinfo->i_lenExtents = inode->i_size;
+	if (ret == 0)
+		iinfo->i_lenExtents = inode->i_size;
 	brelse(epos.bh);
 }
 
@@ -124,6 +130,8 @@ void udf_discard_prealloc(struct inode *inode)
 	int8_t etype = -1;
 	struct udf_inode_info *iinfo = UDF_I(inode);
 	int bsize = i_blocksize(inode);
+	int8_t tmpetype = -1;
+	int ret;
 
 	if (iinfo->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB ||
 	    ALIGN(inode->i_size, bsize) == ALIGN(iinfo->i_lenExtents, bsize))
@@ -132,15 +140,23 @@ void udf_discard_prealloc(struct inode *inode)
 	epos.block = iinfo->i_location;
 
 	/* Find the last extent in the file */
-	while (udf_next_aext(inode, &epos, &eloc, &elen, 0) != -1) {
+	while (1) {
+		ret = udf_next_aext(inode, &epos, &eloc, &elen, &tmpetype, 0);
+		if (ret < 0)
+			goto out;
+		if (ret == 0)
+			break;
 		brelse(prev_epos.bh);
 		prev_epos = epos;
 		if (prev_epos.bh)
 			get_bh(prev_epos.bh);
 
-		etype = udf_next_aext(inode, &epos, &eloc, &elen, 1);
+		ret = udf_next_aext(inode, &epos, &eloc, &elen, &etype, 1);
+		if (ret < 0)
+			goto out;
 		lbcount += elen;
 	}
+
 	if (etype == (EXT_NOT_RECORDED_ALLOCATED >> 30)) {
 		lbcount -= elen;
 		udf_delete_aext(inode, prev_epos);
@@ -150,6 +166,7 @@ void udf_discard_prealloc(struct inode *inode)
 	/* This inode entry is in-memory only and thus we don't have to mark
 	 * the inode dirty */
 	iinfo->i_lenExtents = lbcount;
+out:
 	brelse(epos.bh);
 	brelse(prev_epos.bh);
 }
diff --git a/fs/udf/udfdecl.h b/fs/udf/udfdecl.h
index d893db95ac70e..5067ed68a8b45 100644
--- a/fs/udf/udfdecl.h
+++ b/fs/udf/udfdecl.h
@@ -169,8 +169,9 @@ extern int udf_add_aext(struct inode *, struct extent_position *,
 extern void udf_write_aext(struct inode *, struct extent_position *,
 			   struct kernel_lb_addr *, uint32_t, int);
 extern int8_t udf_delete_aext(struct inode *, struct extent_position);
-extern int8_t udf_next_aext(struct inode *, struct extent_position *,
-			    struct kernel_lb_addr *, uint32_t *, int);
+extern int udf_next_aext(struct inode *inode, struct extent_position *epos,
+			 struct kernel_lb_addr *eloc, uint32_t *elen,
+			 int8_t *etype, int inc);
 extern int udf_current_aext(struct inode *inode, struct extent_position *epos,
 			    struct kernel_lb_addr *eloc, uint32_t *elen,
 			    int8_t *etype, int inc);
-- 
2.43.0


