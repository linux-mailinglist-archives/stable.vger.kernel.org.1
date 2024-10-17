Return-Path: <stable+bounces-86652-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0219A2AA9
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 19:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 386F41F21D7A
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 17:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831E71DF98B;
	Thu, 17 Oct 2024 17:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="cw9cZDec"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9071DF998
	for <stable@vger.kernel.org>; Thu, 17 Oct 2024 17:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729185579; cv=none; b=hQTH56fgh1oJVwy2pmUVZExDB46Gz4dJs8qad21Ogj52xlcgoF+kgQA7JOzmJLc/mmeDX+V2tP1BYN+6Jq90iAYmKARXA5MXMV37DUG2vyNSiXIqXWS2YmXNUYQdN1REtp/E8Lx8vXMvhTxISPCy/Ug/VbHnSu8RJfGROV1syEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729185579; c=relaxed/simple;
	bh=jk2S5qvpH+q80HJgOflRLrn5/IhgOBBP8Jho7s7x0xM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dhUBbhE77dMyLGthedly2uKhODJ8vNgu7zlcDpT+sMEOrc+b4Cy/Nd5nLKm52QDxSdARHPqoAnFnFBi0kYHOVzb49im1EXo447FYZLfDoETrfiF4QjZ/sQ/e2hPDmiDPp4w9gumzvQ5Fgp/ZbIbfYY1ITS6ihF/b8Cw5ronQ4HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=cw9cZDec; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=dVtQgaqyiKe27u7kIMUTxBwAkid/XOhRPZUbEHYDlBo=; b=cw9cZDecvT5kO49XJhHMUrV5wt
	aB3E414N8k6IdLfdr+Xl/BLnntqTY0CcQh8iW2hHjswDdHGRzkdw+jGx9nZ4XWC0EXD7cSIMd7Hn2
	3reMwxe/V3MtjY+LlHmdmB/FNTnVvKimC9hdRLHPjtu6t4LzoLGHak3+bt6N8aCbayswoVItGnW+O
	yWTgTmEJf6VVdFBannQTSgRr0PxjJx8qI8RNho/F0lrcQ/jOx5AqI2+B4NMIB/68cpUZ1XLYZRCC/
	XMHMbMWEAhEh9LyL23erkotltuk22AYM0c6dRwWMXKIjwkofHPBuoLXiF9zWZoLyKaoEp0cfOnXsN
	HfQ8DWMA==;
Received: from 179-125-64-237-dinamico.pombonet.net.br ([179.125.64.237] helo=quatroqueijos.lan)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1t1U9r-00Biqr-29; Thu, 17 Oct 2024 19:19:31 +0200
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: stable@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	kernel-dev@igalia.com,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: [PATCH 6.1 02/19] udf: Convert udf_expand_dir_adinicb() to new directory iteration
Date: Thu, 17 Oct 2024 14:18:58 -0300
Message-Id: <20241017171915.311132-3-cascardo@igalia.com>
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

[ Upstream commit 57bda9fb169d689bff4108265a897d324b5fb8c3 ]

Convert udf_expand_dir_adinicb() to new directory iteration code.

Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 fs/udf/inode.c | 66 ++++++++++++++++++++++----------------------------
 1 file changed, 29 insertions(+), 37 deletions(-)

diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index b574c2a9ce7b..4db51493e70c 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -331,14 +331,12 @@ struct buffer_head *udf_expand_dir_adinicb(struct inode *inode,
 	udf_pblk_t newblock;
 	struct buffer_head *dbh = NULL;
 	struct kernel_lb_addr eloc;
-	uint8_t alloctype;
 	struct extent_position epos;
-
-	struct udf_fileident_bh sfibh, dfibh;
-	loff_t f_pos = udf_ext0_offset(inode);
-	int size = udf_ext0_offset(inode) + inode->i_size;
-	struct fileIdentDesc cfi, *sfi, *dfi;
+	uint8_t alloctype;
 	struct udf_inode_info *iinfo = UDF_I(inode);
+	struct udf_fileident_iter iter;
+	uint8_t *impuse;
+	int ret;
 
 	if (UDF_QUERY_FLAG(inode->i_sb, UDF_FLAG_USE_SHORT_AD))
 		alloctype = ICBTAG_FLAG_AD_SHORT;
@@ -366,38 +364,14 @@ struct buffer_head *udf_expand_dir_adinicb(struct inode *inode,
 	if (!dbh)
 		return NULL;
 	lock_buffer(dbh);
-	memset(dbh->b_data, 0x00, inode->i_sb->s_blocksize);
+	memcpy(dbh->b_data, iinfo->i_data, inode->i_size);
+	memset(dbh->b_data + inode->i_size, 0,
+	       inode->i_sb->s_blocksize - inode->i_size);
 	set_buffer_uptodate(dbh);
 	unlock_buffer(dbh);
-	mark_buffer_dirty_inode(dbh, inode);
-
-	sfibh.soffset = sfibh.eoffset =
-			f_pos & (inode->i_sb->s_blocksize - 1);
-	sfibh.sbh = sfibh.ebh = NULL;
-	dfibh.soffset = dfibh.eoffset = 0;
-	dfibh.sbh = dfibh.ebh = dbh;
-	while (f_pos < size) {
-		iinfo->i_alloc_type = ICBTAG_FLAG_AD_IN_ICB;
-		sfi = udf_fileident_read(inode, &f_pos, &sfibh, &cfi, NULL,
-					 NULL, NULL, NULL);
-		if (!sfi) {
-			brelse(dbh);
-			return NULL;
-		}
-		iinfo->i_alloc_type = alloctype;
-		sfi->descTag.tagLocation = cpu_to_le32(*block);
-		dfibh.soffset = dfibh.eoffset;
-		dfibh.eoffset += (sfibh.eoffset - sfibh.soffset);
-		dfi = (struct fileIdentDesc *)(dbh->b_data + dfibh.soffset);
-		if (udf_write_fi(inode, sfi, dfi, &dfibh, sfi->impUse,
-				 udf_get_fi_ident(sfi))) {
-			iinfo->i_alloc_type = ICBTAG_FLAG_AD_IN_ICB;
-			brelse(dbh);
-			return NULL;
-		}
-	}
-	mark_buffer_dirty_inode(dbh, inode);
 
+	/* Drop inline data, add block instead */
+	iinfo->i_alloc_type = alloctype;
 	memset(iinfo->i_data + iinfo->i_lenEAttr, 0, iinfo->i_lenAlloc);
 	iinfo->i_lenAlloc = 0;
 	eloc.logicalBlockNum = *block;
@@ -408,10 +382,28 @@ struct buffer_head *udf_expand_dir_adinicb(struct inode *inode,
 	epos.block = iinfo->i_location;
 	epos.offset = udf_file_entry_alloc_offset(inode);
 	udf_add_aext(inode, &epos, &eloc, inode->i_size, 0);
-	/* UniqueID stuff */
-
 	brelse(epos.bh);
 	mark_inode_dirty(inode);
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
 	return dbh;
 }
 
-- 
2.34.1


