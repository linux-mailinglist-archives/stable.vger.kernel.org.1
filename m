Return-Path: <stable+bounces-86666-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C479A2AF0
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 19:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78145B28069
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 17:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2DB01DF996;
	Thu, 17 Oct 2024 17:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="GH+24TVP"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A1B1DE2C8
	for <stable@vger.kernel.org>; Thu, 17 Oct 2024 17:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729185607; cv=none; b=cifzorYG3XGyKy47bZsRdRMU717dP6BbsiyeWn2tOu3656WiTPostAfi1ZtFh9pE3ijQ/DbeMUr6fJPXXxOvzVdnZcE1Ke0Z9SKyvZqbyT4IfEiM3VpQNzNTQd0p6dWlr3FVBN5MRoCO8PhyjVGHg0HD0vgfPU0o0ANgij06FgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729185607; c=relaxed/simple;
	bh=fJR/USYaMCsq8LUKossf1PKmZQ9n+IfWh3sNeajC/w0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MN6BKLMIFCe8qSsu6phezuKskgMQxVbdo+V1hHFubzlIWvUwCrWUdiVNiGNYQN2vtK/87cPnrD557Oqz+HrvQx0/tLCEKYpia3gku3t8NZA8MWse64FMmAab/SffYTIzBz5wFRYp8hNqF+UnfG75btPZ1lXIfBQHoH2oJlrgh/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=GH+24TVP; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=s+KubDS9tj9TRekQZShE66XPqvyOx/Gnv7ZrrmCNaNY=; b=GH+24TVPqN5LSnknNYA1vQDCy/
	8tSOgMbzp94Fi579TZ+SRYZzJf7DxEuBc+ZNbulTZB0hDX0TZaI1Rvr4aT9H5dXbnqpTBGxtiqK57
	D4g1H6unL/SKMCQw4K9c9b0o8sUIjmmrhN+7PDNGP0I4PPpkWMCvi5/Tj2+dRlDt21GSBtFvkNKnq
	H+aXeN7LPiEWn5ydT7ljmEYzEZOQmZvBvCnvceu7CYIQPKsWPdlK2wxdZOOzyCxBxVg9LGYd/k/Qi
	w/rM4OBoeJ74COvvQ7mXjNKSk+zr3fkKns5bHwj+BBkLdUbqV3rm1bUfuC9bIjE8gQsMGbToRQUUE
	lGZei1vw==;
Received: from 179-125-64-237-dinamico.pombonet.net.br ([179.125.64.237] helo=quatroqueijos.lan)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1t1UAK-00Biqr-Rt; Thu, 17 Oct 2024 19:20:01 +0200
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: stable@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	kernel-dev@igalia.com,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: [PATCH 6.1 15/19] udf: Convert udf_mkdir() to new directory iteration code
Date: Thu, 17 Oct 2024 14:19:11 -0300
Message-Id: <20241017171915.311132-16-cascardo@igalia.com>
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

[ Upstream commit 00bce6f792caccefa73daeaf9bde82d24d50037f ]

Convert udf_mkdir() to new directory iteration code.

Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 fs/udf/namei.c | 48 +++++++++++++++++++++---------------------------
 1 file changed, 21 insertions(+), 27 deletions(-)

diff --git a/fs/udf/namei.c b/fs/udf/namei.c
index 0c3b06030f9d..7984abb79de1 100644
--- a/fs/udf/namei.c
+++ b/fs/udf/namei.c
@@ -928,8 +928,7 @@ static int udf_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
 		     struct dentry *dentry, umode_t mode)
 {
 	struct inode *inode;
-	struct udf_fileident_bh fibh;
-	struct fileIdentDesc cfi, *fi;
+	struct udf_fileident_iter iter;
 	int err;
 	struct udf_inode_info *dinfo = UDF_I(dir);
 	struct udf_inode_info *iinfo;
@@ -941,47 +940,42 @@ static int udf_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
 	iinfo = UDF_I(inode);
 	inode->i_op = &udf_dir_inode_operations;
 	inode->i_fop = &udf_dir_operations;
-	fi = udf_add_entry(inode, NULL, &fibh, &cfi, &err);
-	if (!fi) {
-		inode_dec_link_count(inode);
+	err = udf_fiiter_add_entry(inode, NULL, &iter);
+	if (err) {
+		clear_nlink(inode);
 		discard_new_inode(inode);
-		goto out;
+		return err;
 	}
 	set_nlink(inode, 2);
-	cfi.icb.extLength = cpu_to_le32(inode->i_sb->s_blocksize);
-	cfi.icb.extLocation = cpu_to_lelb(dinfo->i_location);
-	*(__le32 *)((struct allocDescImpUse *)cfi.icb.impUse)->impUse =
+	iter.fi.icb.extLength = cpu_to_le32(inode->i_sb->s_blocksize);
+	iter.fi.icb.extLocation = cpu_to_lelb(dinfo->i_location);
+	*(__le32 *)((struct allocDescImpUse *)iter.fi.icb.impUse)->impUse =
 		cpu_to_le32(dinfo->i_unique & 0x00000000FFFFFFFFUL);
-	cfi.fileCharacteristics =
+	iter.fi.fileCharacteristics =
 			FID_FILE_CHAR_DIRECTORY | FID_FILE_CHAR_PARENT;
-	udf_write_fi(inode, &cfi, fi, &fibh, NULL, NULL);
-	brelse(fibh.sbh);
+	udf_fiiter_write_fi(&iter, NULL);
+	udf_fiiter_release(&iter);
 	mark_inode_dirty(inode);
 
-	fi = udf_add_entry(dir, dentry, &fibh, &cfi, &err);
-	if (!fi) {
+	err = udf_fiiter_add_entry(dir, dentry, &iter);
+	if (err) {
 		clear_nlink(inode);
-		mark_inode_dirty(inode);
 		discard_new_inode(inode);
-		goto out;
+		return err;
 	}
-	cfi.icb.extLength = cpu_to_le32(inode->i_sb->s_blocksize);
-	cfi.icb.extLocation = cpu_to_lelb(iinfo->i_location);
-	*(__le32 *)((struct allocDescImpUse *)cfi.icb.impUse)->impUse =
+	iter.fi.icb.extLength = cpu_to_le32(inode->i_sb->s_blocksize);
+	iter.fi.icb.extLocation = cpu_to_lelb(iinfo->i_location);
+	*(__le32 *)((struct allocDescImpUse *)iter.fi.icb.impUse)->impUse =
 		cpu_to_le32(iinfo->i_unique & 0x00000000FFFFFFFFUL);
-	cfi.fileCharacteristics |= FID_FILE_CHAR_DIRECTORY;
-	udf_write_fi(dir, &cfi, fi, &fibh, NULL, NULL);
+	iter.fi.fileCharacteristics |= FID_FILE_CHAR_DIRECTORY;
+	udf_fiiter_write_fi(&iter, NULL);
+	udf_fiiter_release(&iter);
 	inc_nlink(dir);
 	dir->i_ctime = dir->i_mtime = current_time(dir);
 	mark_inode_dirty(dir);
 	d_instantiate_new(dentry, inode);
-	if (fibh.sbh != fibh.ebh)
-		brelse(fibh.ebh);
-	brelse(fibh.sbh);
-	err = 0;
 
-out:
-	return err;
+	return 0;
 }
 
 static int empty_dir(struct inode *dir)
-- 
2.34.1


