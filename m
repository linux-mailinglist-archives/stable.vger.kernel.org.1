Return-Path: <stable+bounces-86670-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 272279A2AD8
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 19:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E036FB26449
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 17:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87DF51DF98A;
	Thu, 17 Oct 2024 17:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="ePhdAxGQ"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBA21D95BE
	for <stable@vger.kernel.org>; Thu, 17 Oct 2024 17:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729185618; cv=none; b=eEPZv8icsuWq7Wa0RDeWD/2JWyHm0jHs+D+x74To4+aZa28uyfSYcntNmCo6s6xEJ6eDKcSsmbflIRwqT53xCcBTZC53CF7nhzIDl2ja4FYJ68IyL1yQtia0SYLnNtMDfileAJuW6K41a1803b5skCIPr5ias4SeLUjkyzGJetQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729185618; c=relaxed/simple;
	bh=6zjdr+qKzultaec+HN/A6SnOxkvj4gv3vHKCI9zUct0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nru6UOz09v1mno8ncM/v8jMCYssqljsdldA0CkSbpbPZ2bN6xh63t+LAolLGVph6/1XEB2S7Zf8Q2/JRtZOvrekEM9/OU4PSAG4QHqKtmfBSlXs/AwsdtUFpBhyM23CYSP4fKIQ3K5mGRDAfqVovViQQpkHCsXl/6Pm3dqg0lwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=ePhdAxGQ; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Mx9pOLls1+7LKX9ETIPWMMk7MdwLXpK4Zl9c43y4ykk=; b=ePhdAxGQcnA/S6P0vqiK07IkbX
	LENZY/krxok5qgk+uy+XL/F7ytImj023GW1A/FHu+a+6hUNN7JAe3l9UVkPORi5R0t7ki+dIQggks
	a10EOtqPWHncnr9ROXC1SBJCVGpXv0up67r+KE/dpxpwyPbTyp0Rcgb6uagQPmBHWUpaQqV5tUHj4
	rX8glPC16oEbk66gBByDcJy9tRP17AVZ+QO+qY8oCFMqXhG3/XED7hS0ZNkwwF8Dcqky2IGwt/pJT
	JQVbP3HhcOBWqRYGbBjrhwgImDFAhrnQ3l7JZekGiC7XmZavZqLUbxW+5MhMm4HhdbEZGNDamc+YE
	pfqwMCKw==;
Received: from 179-125-64-237-dinamico.pombonet.net.br ([179.125.64.237] helo=quatroqueijos.lan)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1t1UAV-00Biqr-6m; Thu, 17 Oct 2024 19:20:11 +0200
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: stable@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	kernel-dev@igalia.com,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: [PATCH 6.1 19/19] udf: Don't return bh from udf_expand_dir_adinicb()
Date: Thu, 17 Oct 2024 14:19:15 -0300
Message-Id: <20241017171915.311132-20-cascardo@igalia.com>
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
index 7271aa8d7557..29ab5f80dd41 100644
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


