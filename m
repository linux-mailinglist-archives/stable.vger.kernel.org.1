Return-Path: <stable+bounces-86701-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 671C59A2E5F
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 22:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BB272841C3
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 20:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5162E1E0DF4;
	Thu, 17 Oct 2024 20:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="n5BIexkb"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02211D0E1F
	for <stable@vger.kernel.org>; Thu, 17 Oct 2024 20:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729196445; cv=none; b=GT8V+k+CL93/uM4ctedwjebcImbokiLNKYoolc4TE0GD0bj/MLL6u+7mdK7nuiNSTuRALOaguDL6k1LB19wBLLofIPGpPTbbnDNThJDKDTsvDZ69q07oxVuNl8F7p7UF3FawfXXU1d1uczzPsou/4XPV6S+n3DJNVNsEfaqYM8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729196445; c=relaxed/simple;
	bh=BUV1P4Eir+y4XIc1dNnzGQFGEfl/eD5PSP3vT/TlwFw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pSWc8G5/xaMSlgUv6yEC9Ff9sFeXwrDVSFofXFRtE5Qg8OPZK3tGPjQbqvZCZHgpcqIIghEEl1sxEKJwqd8cpjLsVGGB2Z5BCjrOHb68b4CygAvtghc1kqffSaNTPkv2Fu0wK8g9gwuTA/KyhhnBz0QCEmNnzRb9bMotaRbwu/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=n5BIexkb; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=cBmY2PC2A4uGnHf9PX9q/5Ly1x+JtSoS1kdsi513CgI=; b=n5BIexkbXNoopNFWnaKjG9mpDa
	F/+3OWMl6qHgsK3sPqrgbvr+oE3uUCt9dPhOZlde9UxGt0+7UaZkNarOoP0l0cBugmpIPV8xFNXn2
	AngRUtmRMRENL/5TrgfE/W6/1VAsiQCiBF/EXp9Dx3LkI+McCCcO0uunUpob6AsE9KVIrw9PuqKsL
	M5vlAR4OYTfbkArEf0bTC+XJQj15Lr38PV4CfoNkTpImXWJY7mM8I9h26CITd5mwUkAVs2vwl9qCk
	rTXOZeqQfaux/AL4RSiaQNAHX5wUUfwTxBmS1nedtt13f0SM15o6AkwiWyraEQn2oNKYEF8vp1lMZ
	xM3emEmw==;
Received: from 179-125-64-237-dinamico.pombonet.net.br ([179.125.64.237] helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1t1Wz6-00BmZ7-B0; Thu, 17 Oct 2024 22:20:36 +0200
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: stable@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	kernel-dev@igalia.com,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: [PATCH 5.15 11/20] udf: Convert udf_rmdir() to new directory iteration code
Date: Thu, 17 Oct 2024 17:19:53 -0300
Message-Id: <20241017202002.406428-12-cascardo@igalia.com>
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

[ Upstream commit d11ffa8d3ec11fdb665f12f95d58d74673051a93 ]

Convert udf_rmdir() to use new directory iteration code.

Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 fs/udf/namei.c | 32 +++++++++++---------------------
 1 file changed, 11 insertions(+), 21 deletions(-)

diff --git a/fs/udf/namei.c b/fs/udf/namei.c
index d73870371766..432e325f955a 100644
--- a/fs/udf/namei.c
+++ b/fs/udf/namei.c
@@ -898,30 +898,23 @@ static int empty_dir(struct inode *dir)
 
 static int udf_rmdir(struct inode *dir, struct dentry *dentry)
 {
-	int retval;
+	int ret;
 	struct inode *inode = d_inode(dentry);
-	struct udf_fileident_bh fibh;
-	struct fileIdentDesc *fi, cfi;
+	struct udf_fileident_iter iter;
 	struct kernel_lb_addr tloc;
 
-	retval = -ENOENT;
-	fi = udf_find_entry(dir, &dentry->d_name, &fibh, &cfi);
-	if (IS_ERR_OR_NULL(fi)) {
-		if (fi)
-			retval = PTR_ERR(fi);
+	ret = udf_fiiter_find_entry(dir, &dentry->d_name, &iter);
+	if (ret)
 		goto out;
-	}
 
-	retval = -EIO;
-	tloc = lelb_to_cpu(cfi.icb.extLocation);
+	ret = -EFSCORRUPTED;
+	tloc = lelb_to_cpu(iter.fi.icb.extLocation);
 	if (udf_get_lb_pblock(dir->i_sb, &tloc, 0) != inode->i_ino)
 		goto end_rmdir;
-	retval = -ENOTEMPTY;
+	ret = -ENOTEMPTY;
 	if (!empty_dir(inode))
 		goto end_rmdir;
-	retval = udf_delete_entry(dir, fi, &fibh, &cfi);
-	if (retval)
-		goto end_rmdir;
+	udf_fiiter_delete_entry(&iter);
 	if (inode->i_nlink != 2)
 		udf_warn(inode->i_sb, "empty directory has nlink != 2 (%u)\n",
 			 inode->i_nlink);
@@ -931,14 +924,11 @@ static int udf_rmdir(struct inode *dir, struct dentry *dentry)
 	inode->i_ctime = dir->i_ctime = dir->i_mtime =
 						current_time(inode);
 	mark_inode_dirty(dir);
-
+	ret = 0;
 end_rmdir:
-	if (fibh.sbh != fibh.ebh)
-		brelse(fibh.ebh);
-	brelse(fibh.sbh);
-
+	udf_fiiter_release(&iter);
 out:
-	return retval;
+	return ret;
 }
 
 static int udf_unlink(struct inode *dir, struct dentry *dentry)
-- 
2.34.1


