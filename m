Return-Path: <stable+bounces-86691-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B05829A2E55
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 22:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F562284152
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 20:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA53C227BA9;
	Thu, 17 Oct 2024 20:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="PfQiaU8h"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18AB71CCB33
	for <stable@vger.kernel.org>; Thu, 17 Oct 2024 20:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729196425; cv=none; b=WAzmGOriKLNLw+6L5VhTB/9cNAxDOVPuublR9tPgtYTGtDrco7GwlF6NutrgC73yWxm4klZjqBQiMCvuZQ0RB+6j/5T+eGj/V12SPu2xwxNqY4A/X3ZDnB6BFqYyPPHGiwLb0QxW7bQneSfeM9ebGz2ifRTh4Ah18tCa5St7iGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729196425; c=relaxed/simple;
	bh=WMuZzvgvGVG9jF7bjVhjT4VYoiTMO+5f9Ee6k3BKNL0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OENCxHHcq9ux4bToyG3o8msDLA5bikuuZiJ2ojVEm3PTndhe69TOKLMlmrIyEgDRVcPnU5myBPs3//rpKmgkixsaEZprdggacBlgArDe0rRg2Rg35GP7VjHI382aSl4NFD2i3rHgB1/2HLJljcoHEeWxlSs/+lH7XKslW4J5Wpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=PfQiaU8h; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=N13USN72jAVMHzZa6D/5CKmZAvPTTbac+eeSB0Trb5w=; b=PfQiaU8hAIiyXvP80QzAR3C0yi
	DIfns1G29Lh7Aw5wpMvl/VUh1O4p44vNJAoi8ZAOnpzjx1TJ8LwhhuW7Paq7WxDSZy3APtlcd9PnH
	bsBrIT2cQIxazQbuQrVmD3M78CDP8wyBCveQTqsyVSBZTuTpv3w/EaXz4F1mZlh6/GnPFJ+Snn6Pd
	DvEy6rlIF1mkkccb1HniIi0bbonhDd0fPf9/2UIUxh7y/3JAQtfuX5PwrXKUHPWTi3pbgtcfwwjGP
	0BRw2wk0DnrBVWpaPw7UMVqRpFudYJGX2n16BvGSPz6mqjiWNvpO79QNytD3HVaLo10KIHBMgvL5v
	76CIlw+g==;
Received: from 179-125-64-237-dinamico.pombonet.net.br ([179.125.64.237] helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1t1Wyl-00BmZ7-Hy; Thu, 17 Oct 2024 22:20:16 +0200
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: stable@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	kernel-dev@igalia.com,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: [PATCH 5.15 02/20] udf: Convert udf_expand_dir_adinicb() to new directory iteration
Date: Thu, 17 Oct 2024 17:19:44 -0300
Message-Id: <20241017202002.406428-3-cascardo@igalia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241017202002.406428-1-cascardo@igalia.com>
References: <20241017202002.406428-1-cascardo@igalia.com>
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
index da6fb28b4eea..acb7cebc1aac 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -330,14 +330,12 @@ struct buffer_head *udf_expand_dir_adinicb(struct inode *inode,
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
@@ -365,38 +363,14 @@ struct buffer_head *udf_expand_dir_adinicb(struct inode *inode,
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
@@ -407,10 +381,28 @@ struct buffer_head *udf_expand_dir_adinicb(struct inode *inode,
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


