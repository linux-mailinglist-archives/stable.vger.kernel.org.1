Return-Path: <stable+bounces-86653-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0CC99A2AAA
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 19:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6280E1F2061E
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 17:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14711DFD8A;
	Thu, 17 Oct 2024 17:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="PVH83yPs"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBB61DFD82
	for <stable@vger.kernel.org>; Thu, 17 Oct 2024 17:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729185582; cv=none; b=u34BtjevBw0BQ3U890jbwzE204YII2+HPaK2Bb+o42LlDOpQpRG78KqjW+BRkKx+GNuMdA9mzntaavwzXdL7kZXPfmldsxEUkY+bxIVJdIpRIEpYhCUWHOB2gaVD+iurI4OQCV+ryCYg6I00f5hKJPLONEaWz3tfYm09me0vAtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729185582; c=relaxed/simple;
	bh=S9l5aBEo4SMZeDZc1TQNjJ3jRQUmIVGfCmO5B77uhpQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Nsz/1WAcvv2shG9tiYR9kunizli3c0EYN//+Ys5OqyzEOgIURP94U2I2GOk1qhSou9smRxPmd/dDoCdaBDM6D2AnCtOz478uMpkCrl3k9ilOI3w4nu5ekk4+4QYP0RTXq+mtdWdyi0r9QzGp8eUJZaNDRc1pSOpzcXmLoLAgJu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=PVH83yPs; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=PsFKz3N9bcnEU9hNXaihmfN30+L/Q7cDnvZumuKlkS4=; b=PVH83yPsdvFSrpZ1Bgx+wXFlnB
	7535p1S7VTyXpDgyYMOkeQAOciBG2pnqEirJtR/gUqXSLiyV6areq5LipxlMyIzDT0YGAZa9xNScC
	F5lvlvVD1rFXhjjjNtCAoMKjOaJrIo1Q/qaY0TAEdozDTmK2N5xH07BkhiqUxHb5HeD2R2LUawfef
	033Azbl6NyQ4WrEBAyfJhv2Q/EI6NAeiojjyWmwqkmGYi7LdCDME1fumUESdRP8drHcyIeKU51x+6
	9ThRqYvkxbnCUwKe8xJOspMt4ZS+DOncI0+lSqmXR1g0ZlRy0BF06oElm2BT3nXgXOw0aNiIYR1YF
	ve3wwR5Q==;
Received: from 179-125-64-237-dinamico.pombonet.net.br ([179.125.64.237] helo=quatroqueijos.lan)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1t1U9t-00Biqr-Gu; Thu, 17 Oct 2024 19:19:34 +0200
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: stable@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	kernel-dev@igalia.com,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: [PATCH 6.1 03/19] udf: Move udf_expand_dir_adinicb() to its callsite
Date: Thu, 17 Oct 2024 14:18:59 -0300
Message-Id: <20241017171915.311132-4-cascardo@igalia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241017171915.311132-1-cascardo@igalia.com>
References: <20241017171915.311132-1-cascardo@igalia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jan Kara <jack@suse.cz>

[ Upstream commit a27b2923de7efaa1da1e243fb80ff0fa432e4be0 ]

There is just one caller of udf_expand_dir_adinicb(). Move the function
to its caller into namei.c as it is more about directory handling than
anything else anyway.

Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 fs/udf/inode.c   | 82 ------------------------------------------------
 fs/udf/namei.c   | 82 ++++++++++++++++++++++++++++++++++++++++++++++++
 fs/udf/udfdecl.h |  2 --
 3 files changed, 82 insertions(+), 84 deletions(-)

diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index 4db51493e70c..77471e33ccf7 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -325,88 +325,6 @@ int udf_expand_file_adinicb(struct inode *inode)
 	return err;
 }
 
-struct buffer_head *udf_expand_dir_adinicb(struct inode *inode,
-					    udf_pblk_t *block, int *err)
-{
-	udf_pblk_t newblock;
-	struct buffer_head *dbh = NULL;
-	struct kernel_lb_addr eloc;
-	struct extent_position epos;
-	uint8_t alloctype;
-	struct udf_inode_info *iinfo = UDF_I(inode);
-	struct udf_fileident_iter iter;
-	uint8_t *impuse;
-	int ret;
-
-	if (UDF_QUERY_FLAG(inode->i_sb, UDF_FLAG_USE_SHORT_AD))
-		alloctype = ICBTAG_FLAG_AD_SHORT;
-	else
-		alloctype = ICBTAG_FLAG_AD_LONG;
-
-	if (!inode->i_size) {
-		iinfo->i_alloc_type = alloctype;
-		mark_inode_dirty(inode);
-		return NULL;
-	}
-
-	/* alloc block, and copy data to it */
-	*block = udf_new_block(inode->i_sb, inode,
-			       iinfo->i_location.partitionReferenceNum,
-			       iinfo->i_location.logicalBlockNum, err);
-	if (!(*block))
-		return NULL;
-	newblock = udf_get_pblock(inode->i_sb, *block,
-				  iinfo->i_location.partitionReferenceNum,
-				0);
-	if (!newblock)
-		return NULL;
-	dbh = udf_tgetblk(inode->i_sb, newblock);
-	if (!dbh)
-		return NULL;
-	lock_buffer(dbh);
-	memcpy(dbh->b_data, iinfo->i_data, inode->i_size);
-	memset(dbh->b_data + inode->i_size, 0,
-	       inode->i_sb->s_blocksize - inode->i_size);
-	set_buffer_uptodate(dbh);
-	unlock_buffer(dbh);
-
-	/* Drop inline data, add block instead */
-	iinfo->i_alloc_type = alloctype;
-	memset(iinfo->i_data + iinfo->i_lenEAttr, 0, iinfo->i_lenAlloc);
-	iinfo->i_lenAlloc = 0;
-	eloc.logicalBlockNum = *block;
-	eloc.partitionReferenceNum =
-				iinfo->i_location.partitionReferenceNum;
-	iinfo->i_lenExtents = inode->i_size;
-	epos.bh = NULL;
-	epos.block = iinfo->i_location;
-	epos.offset = udf_file_entry_alloc_offset(inode);
-	udf_add_aext(inode, &epos, &eloc, inode->i_size, 0);
-	brelse(epos.bh);
-	mark_inode_dirty(inode);
-
-	/* Now fixup tags in moved directory entries */
-	for (ret = udf_fiiter_init(&iter, inode, 0);
-	     !ret && iter.pos < inode->i_size;
-	     ret = udf_fiiter_advance(&iter)) {
-		iter.fi.descTag.tagLocation = cpu_to_le32(*block);
-		if (iter.fi.lengthOfImpUse != cpu_to_le16(0))
-			impuse = dbh->b_data + iter.pos +
-						sizeof(struct fileIdentDesc);
-		else
-			impuse = NULL;
-		udf_fiiter_write_fi(&iter, impuse);
-	}
-	/*
-	 * We don't expect the iteration to fail as the directory has been
-	 * already verified to be correct
-	 */
-	WARN_ON_ONCE(ret);
-	udf_fiiter_release(&iter);
-
-	return dbh;
-}
-
 static int udf_get_block(struct inode *inode, sector_t block,
 			 struct buffer_head *bh_result, int create)
 {
diff --git a/fs/udf/namei.c b/fs/udf/namei.c
index ded71044988a..fd096dcc5f15 100644
--- a/fs/udf/namei.c
+++ b/fs/udf/namei.c
@@ -326,6 +326,88 @@ static struct dentry *udf_lookup(struct inode *dir, struct dentry *dentry,
 	return d_splice_alias(inode, dentry);
 }
 
+static struct buffer_head *udf_expand_dir_adinicb(struct inode *inode,
+					udf_pblk_t *block, int *err)
+{
+	udf_pblk_t newblock;
+	struct buffer_head *dbh = NULL;
+	struct kernel_lb_addr eloc;
+	struct extent_position epos;
+	uint8_t alloctype;
+	struct udf_inode_info *iinfo = UDF_I(inode);
+	struct udf_fileident_iter iter;
+	uint8_t *impuse;
+	int ret;
+
+	if (UDF_QUERY_FLAG(inode->i_sb, UDF_FLAG_USE_SHORT_AD))
+		alloctype = ICBTAG_FLAG_AD_SHORT;
+	else
+		alloctype = ICBTAG_FLAG_AD_LONG;
+
+	if (!inode->i_size) {
+		iinfo->i_alloc_type = alloctype;
+		mark_inode_dirty(inode);
+		return NULL;
+	}
+
+	/* alloc block, and copy data to it */
+	*block = udf_new_block(inode->i_sb, inode,
+			       iinfo->i_location.partitionReferenceNum,
+			       iinfo->i_location.logicalBlockNum, err);
+	if (!(*block))
+		return NULL;
+	newblock = udf_get_pblock(inode->i_sb, *block,
+				  iinfo->i_location.partitionReferenceNum,
+				0);
+	if (!newblock)
+		return NULL;
+	dbh = udf_tgetblk(inode->i_sb, newblock);
+	if (!dbh)
+		return NULL;
+	lock_buffer(dbh);
+	memcpy(dbh->b_data, iinfo->i_data, inode->i_size);
+	memset(dbh->b_data + inode->i_size, 0,
+	       inode->i_sb->s_blocksize - inode->i_size);
+	set_buffer_uptodate(dbh);
+	unlock_buffer(dbh);
+
+	/* Drop inline data, add block instead */
+	iinfo->i_alloc_type = alloctype;
+	memset(iinfo->i_data + iinfo->i_lenEAttr, 0, iinfo->i_lenAlloc);
+	iinfo->i_lenAlloc = 0;
+	eloc.logicalBlockNum = *block;
+	eloc.partitionReferenceNum =
+				iinfo->i_location.partitionReferenceNum;
+	iinfo->i_lenExtents = inode->i_size;
+	epos.bh = NULL;
+	epos.block = iinfo->i_location;
+	epos.offset = udf_file_entry_alloc_offset(inode);
+	udf_add_aext(inode, &epos, &eloc, inode->i_size, 0);
+	brelse(epos.bh);
+	mark_inode_dirty(inode);
+
+	/* Now fixup tags in moved directory entries */
+	for (ret = udf_fiiter_init(&iter, inode, 0);
+	     !ret && iter.pos < inode->i_size;
+	     ret = udf_fiiter_advance(&iter)) {
+		iter.fi.descTag.tagLocation = cpu_to_le32(*block);
+		if (iter.fi.lengthOfImpUse != cpu_to_le16(0))
+			impuse = dbh->b_data + iter.pos +
+						sizeof(struct fileIdentDesc);
+		else
+			impuse = NULL;
+		udf_fiiter_write_fi(&iter, impuse);
+	}
+	/*
+	 * We don't expect the iteration to fail as the directory has been
+	 * already verified to be correct
+	 */
+	WARN_ON_ONCE(ret);
+	udf_fiiter_release(&iter);
+
+	return dbh;
+}
+
 static struct fileIdentDesc *udf_add_entry(struct inode *dir,
 					   struct dentry *dentry,
 					   struct udf_fileident_bh *fibh,
diff --git a/fs/udf/udfdecl.h b/fs/udf/udfdecl.h
index 22a8466e335c..676fa2996ffe 100644
--- a/fs/udf/udfdecl.h
+++ b/fs/udf/udfdecl.h
@@ -169,8 +169,6 @@ static inline struct inode *udf_iget(struct super_block *sb,
 	return __udf_iget(sb, ino, false);
 }
 extern int udf_expand_file_adinicb(struct inode *);
-extern struct buffer_head *udf_expand_dir_adinicb(struct inode *inode,
-						  udf_pblk_t *block, int *err);
 extern struct buffer_head *udf_bread(struct inode *inode, udf_pblk_t block,
 				      int create, int *err);
 extern int udf_setsize(struct inode *, loff_t);
-- 
2.34.1


