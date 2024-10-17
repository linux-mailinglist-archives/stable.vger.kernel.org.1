Return-Path: <stable+bounces-86708-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE619A2E67
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 22:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FF8C283FDB
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 20:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513831E0DF4;
	Thu, 17 Oct 2024 20:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="f3ld7yVj"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5191D0DC4
	for <stable@vger.kernel.org>; Thu, 17 Oct 2024 20:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729196460; cv=none; b=r4Y5U8B0+iUvzmb7TnLhyg6nksE4GXzDgei4jN3XxTSjsDwDDY1K0vmOxrcmDM2a3rEC8vVf9UPyiFhJ3E5lKu4VeiUsxvQfZQyTYG5A9xQkLFytW1YuPrHTkiKBWjx+V1pNOH1qxa8ulvE1KssHLfI4IPsxgZl48Fy4un7gHOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729196460; c=relaxed/simple;
	bh=YJHllwPVjtovQ9Opr7A7G91Wzi6SW/Ah3U96IzI76Rs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nQ8wuquJsVWCS+pxc1NXijsQKaWqfAmG/m2juGkFMepbV5G+xuhnjViYbMP8OkyYrIvPrFESOu7xc4T2EKGHwfbHvrddcjUrSyw6oO6o5uSJZug7f/AGWOv+7huGWq0pzk4fy11earHfIHH1V/cq50XUenQWKD+W78G6WoadMKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=f3ld7yVj; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=RQvxYJ0Njk8ijuXGca5E/pNax8Fj9qOBXRZgveV4L48=; b=f3ld7yVjhLLIZGXkR7xlM1PYhu
	Hjlpe/mM8n59Djr35XoW2w05jDPVdXg354EHwxW7ZxhwiDnfDV4+AEoi/9UlU4feYqwqbTm+GDTl1
	48V3J370ApE6K7UKVeoD+Rw9MhHiMcpaZZpds1Q6mar9Nv1agFV0aRmzeuwDXiet/F11EwEw31tIC
	j05hoVyau9WZYR2DBG2ycEpilyfH21Yb3G7Va5VaBbDkKeKMq1rCJH7wFA3hJcuqsby3ln41NqYEc
	wq2f7khZ6IgFeN1V2xXtpi+Huc9S26rv2vN3ZdknKiK2PZwtr+vwFcHu4ecl49nzZrkCdLfLX6IhB
	gWuTkM/w==;
Received: from 179-125-64-237-dinamico.pombonet.net.br ([179.125.64.237] helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1t1WzO-00BmZ7-3h; Thu, 17 Oct 2024 22:20:54 +0200
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: stable@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	kernel-dev@igalia.com,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: [PATCH 5.15 19/20] udf: Don't return bh from udf_expand_dir_adinicb()
Date: Thu, 17 Oct 2024 17:20:01 -0300
Message-Id: <20241017202002.406428-20-cascardo@igalia.com>
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

[ Upstream commit f386c802a6fda8f9fe4a5cf418c49aa84dfc52e4 ]

Nobody uses the bh returned from udf_expand_dir_adinicb(). Don't return
it.

Signed-off-by: Jan Kara <jack@suse.cz>
[cascardo: skip backport of 101ee137d32a ("udf: Drop VARCONV support")]
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 fs/udf/namei.c | 33 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/fs/udf/namei.c b/fs/udf/namei.c
index ced58595a474..093de955ba10 100644
--- a/fs/udf/namei.c
+++ b/fs/udf/namei.c
@@ -136,8 +136,7 @@ static struct dentry *udf_lookup(struct inode *dir, struct dentry *dentry,
 	return d_splice_alias(inode, dentry);
 }
 
-static struct buffer_head *udf_expand_dir_adinicb(struct inode *inode,
-					udf_pblk_t *block, int *err)
+static int udf_expand_dir_adinicb(struct inode *inode, udf_pblk_t *block)
 {
 	udf_pblk_t newblock;
 	struct buffer_head *dbh = NULL;
@@ -157,23 +156,23 @@ static struct buffer_head *udf_expand_dir_adinicb(struct inode *inode,
 	if (!inode->i_size) {
 		iinfo->i_alloc_type = alloctype;
 		mark_inode_dirty(inode);
-		return NULL;
+		return 0;
 	}
 
 	/* alloc block, and copy data to it */
 	*block = udf_new_block(inode->i_sb, inode,
 			       iinfo->i_location.partitionReferenceNum,
-			       iinfo->i_location.logicalBlockNum, err);
+			       iinfo->i_location.logicalBlockNum, &ret);
 	if (!(*block))
-		return NULL;
+		return ret;
 	newblock = udf_get_pblock(inode->i_sb, *block,
 				  iinfo->i_location.partitionReferenceNum,
 				0);
-	if (!newblock)
-		return NULL;
+	if (newblock == 0xffffffff)
+		return -EFSCORRUPTED;
 	dbh = udf_tgetblk(inode->i_sb, newblock);
 	if (!dbh)
-		return NULL;
+		return -ENOMEM;
 	lock_buffer(dbh);
 	memcpy(dbh->b_data, iinfo->i_data, inode->i_size);
 	memset(dbh->b_data + inode->i_size, 0,
@@ -195,9 +194,9 @@ static struct buffer_head *udf_expand_dir_adinicb(struct inode *inode,
 	ret = udf_add_aext(inode, &epos, &eloc, inode->i_size, 0);
 	brelse(epos.bh);
 	if (ret < 0) {
-		*err = ret;
+		brelse(dbh);
 		udf_free_blocks(inode->i_sb, inode, &eloc, 0, 1);
-		return NULL;
+		return ret;
 	}
 	mark_inode_dirty(inode);
 
@@ -213,6 +212,7 @@ static struct buffer_head *udf_expand_dir_adinicb(struct inode *inode,
 			impuse = NULL;
 		udf_fiiter_write_fi(&iter, impuse);
 	}
+	brelse(dbh);
 	/*
 	 * We don't expect the iteration to fail as the directory has been
 	 * already verified to be correct
@@ -220,7 +220,7 @@ static struct buffer_head *udf_expand_dir_adinicb(struct inode *inode,
 	WARN_ON_ONCE(ret);
 	udf_fiiter_release(&iter);
 
-	return dbh;
+	return 0;
 }
 
 static int udf_fiiter_add_entry(struct inode *dir, struct dentry *dentry,
@@ -266,17 +266,10 @@ static int udf_fiiter_add_entry(struct inode *dir, struct dentry *dentry,
 	}
 	if (dinfo->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB &&
 	    blksize - udf_ext0_offset(dir) - iter->pos < nfidlen) {
-		struct buffer_head *retbh;
-
 		udf_fiiter_release(iter);
-		/*
-		 * FIXME: udf_expand_dir_adinicb does not need to return bh
-		 * once other users are gone
-		 */
-		retbh = udf_expand_dir_adinicb(dir, &block, &ret);
-		if (!retbh)
+		ret = udf_expand_dir_adinicb(dir, &block);
+		if (ret)
 			return ret;
-		brelse(retbh);
 		ret = udf_fiiter_init(iter, dir, dir->i_size);
 		if (ret < 0)
 			return ret;
-- 
2.34.1


