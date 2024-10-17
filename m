Return-Path: <stable+bounces-86657-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AEDC9A2AAD
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 19:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A867282F53
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 17:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C661DFD88;
	Thu, 17 Oct 2024 17:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="EN8za9Gk"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5821DF995
	for <stable@vger.kernel.org>; Thu, 17 Oct 2024 17:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729185591; cv=none; b=qjvHise16MS1eulKbnwJ1B8A4JAcr5DI6qY6kS7Esz9skKrxMVsLTWZ7bpwwa+XVQqKIGgnBpQj0hL22g31mVFxJ+ciymP4l/rL4ve5tTd11rBSuUdqvZibtsQatk9nRnbaLl9IrvqEGGFqudHPXdft+Tx8TbrcxhjOJ6B4DBUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729185591; c=relaxed/simple;
	bh=yfKascS/xJJlN1ROjdzDMH3DDDe6Rhm4VWwop5GXHfk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D6aRA23OX0XTkzcOOjYQEWq+lVvxPmgMqiq/TMMI7vI2oCjSNVCHFZ9tC+SA1mVPTyGlGQwbBNkN0QG10BBDGSezH/fCXtkR21MasxHTYGp2FQGXX/VL95hknXny6ykoAkdvB6nAmBLh1hOq8XYeMnqVoO0zmuLR9bkAS14heeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=EN8za9Gk; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=DmYsijrMytC8SNO280RXXNMN0H00pJ7PPqf5D1hPZoM=; b=EN8za9GkVIfT87LksMVL5bY4zz
	eUUf2Pd3b6f8l8PuoSSHIqqHNh+XiZOh2KdKc/DuJ35McOzJ45gjafl6/8RRPyKdLOMFumrIprGwa
	28kVH9ppooezfxRkOLRMcByerNCvqe4OTQRrDGqilXkol0h/tp30jrOCXlJ0t224PN2vfkTPuxC/6
	gnpVDiaqJDOKzLR+GU4FOXoVMz0Qyg5+Wc4gvxfkaDRQKNiY1Io5R0ofUgnnpz1aP/it8VbT3mgcm
	o2beLWrTGIhViozv7j9DYhOY7wgY0TvzMRE2GSrugstx11DelHboasEPTaED+U/6tcN3sOMFQxJkl
	m8hJ4giQ==;
Received: from 179-125-64-237-dinamico.pombonet.net.br ([179.125.64.237] helo=quatroqueijos.lan)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1t1UA3-00Biqr-7i; Thu, 17 Oct 2024 19:19:43 +0200
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: stable@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	kernel-dev@igalia.com,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: [PATCH 6.1 07/19] udf: Convert udf_readdir() to new directory iteration
Date: Thu, 17 Oct 2024 14:19:03 -0300
Message-Id: <20241017171915.311132-8-cascardo@igalia.com>
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

[ Upstream commit 7cd7a36ab44d3e8c1dee7185ef407b9831a8220b ]

Convert udf_readdir() to new directory iteration functions.

Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 fs/udf/dir.c | 148 ++++++++++-----------------------------------------
 1 file changed, 27 insertions(+), 121 deletions(-)

diff --git a/fs/udf/dir.c b/fs/udf/dir.c
index be640f4b2f2c..212393b12c22 100644
--- a/fs/udf/dir.c
+++ b/fs/udf/dir.c
@@ -39,26 +39,13 @@
 static int udf_readdir(struct file *file, struct dir_context *ctx)
 {
 	struct inode *dir = file_inode(file);
-	struct udf_inode_info *iinfo = UDF_I(dir);
-	struct udf_fileident_bh fibh = { .sbh = NULL, .ebh = NULL};
-	struct fileIdentDesc *fi = NULL;
-	struct fileIdentDesc cfi;
-	udf_pblk_t block, iblock;
 	loff_t nf_pos, emit_pos = 0;
 	int flen;
-	unsigned char *fname = NULL, *copy_name = NULL;
-	unsigned char *nameptr;
-	uint16_t liu;
-	uint8_t lfi;
-	loff_t size = udf_ext0_offset(dir) + dir->i_size;
-	struct buffer_head *tmp, *bha[16];
-	struct kernel_lb_addr eloc;
-	uint32_t elen;
-	sector_t offset;
-	int i, num, ret = 0;
-	struct extent_position epos = { NULL, 0, {0, 0} };
+	unsigned char *fname = NULL;
+	int ret = 0;
 	struct super_block *sb = dir->i_sb;
 	bool pos_valid = false;
+	struct udf_fileident_iter iter;
 
 	if (ctx->pos == 0) {
 		if (!dir_emit_dot(file, ctx))
@@ -66,7 +53,7 @@ static int udf_readdir(struct file *file, struct dir_context *ctx)
 		ctx->pos = 1;
 	}
 	nf_pos = (ctx->pos - 1) << 2;
-	if (nf_pos >= size)
+	if (nf_pos >= dir->i_size)
 		goto out;
 
 	/*
@@ -90,138 +77,57 @@ static int udf_readdir(struct file *file, struct dir_context *ctx)
 		goto out;
 	}
 
-	if (nf_pos == 0)
-		nf_pos = udf_ext0_offset(dir);
-
-	fibh.soffset = fibh.eoffset = nf_pos & (sb->s_blocksize - 1);
-	if (iinfo->i_alloc_type != ICBTAG_FLAG_AD_IN_ICB) {
-		if (inode_bmap(dir, nf_pos >> sb->s_blocksize_bits,
-		    &epos, &eloc, &elen, &offset)
-		    != (EXT_RECORDED_ALLOCATED >> 30)) {
-			ret = -ENOENT;
-			goto out;
-		}
-		block = udf_get_lb_pblock(sb, &eloc, offset);
-		if ((++offset << sb->s_blocksize_bits) < elen) {
-			if (iinfo->i_alloc_type == ICBTAG_FLAG_AD_SHORT)
-				epos.offset -= sizeof(struct short_ad);
-			else if (iinfo->i_alloc_type ==
-					ICBTAG_FLAG_AD_LONG)
-				epos.offset -= sizeof(struct long_ad);
-		} else {
-			offset = 0;
-		}
-
-		if (!(fibh.sbh = fibh.ebh = udf_tread(sb, block))) {
-			ret = -EIO;
-			goto out;
-		}
-
-		if (!(offset & ((16 >> (sb->s_blocksize_bits - 9)) - 1))) {
-			i = 16 >> (sb->s_blocksize_bits - 9);
-			if (i + offset > (elen >> sb->s_blocksize_bits))
-				i = (elen >> sb->s_blocksize_bits) - offset;
-			for (num = 0; i > 0; i--) {
-				block = udf_get_lb_pblock(sb, &eloc, offset + i);
-				tmp = udf_tgetblk(sb, block);
-				if (tmp && !buffer_uptodate(tmp) && !buffer_locked(tmp))
-					bha[num++] = tmp;
-				else
-					brelse(tmp);
-			}
-			if (num) {
-				bh_readahead_batch(num, bha, REQ_RAHEAD);
-				for (i = 0; i < num; i++)
-					brelse(bha[i]);
-			}
-		}
-	}
-
-	while (nf_pos < size) {
+	for (ret = udf_fiiter_init(&iter, dir, nf_pos);
+	     !ret && iter.pos < dir->i_size;
+	     ret = udf_fiiter_advance(&iter)) {
 		struct kernel_lb_addr tloc;
-		loff_t cur_pos = nf_pos;
+		udf_pblk_t iblock;
 
-		/* Update file position only if we got past the current one */
-		if (nf_pos >= emit_pos) {
-			ctx->pos = (nf_pos >> 2) + 1;
-			pos_valid = true;
-		}
-
-		fi = udf_fileident_read(dir, &nf_pos, &fibh, &cfi, &epos, &eloc,
-					&elen, &offset);
-		if (!fi)
-			goto out;
 		/* Still not at offset where user asked us to read from? */
-		if (cur_pos < emit_pos)
+		if (iter.pos < emit_pos)
 			continue;
 
-		liu = le16_to_cpu(cfi.lengthOfImpUse);
-		lfi = cfi.lengthFileIdent;
-
-		if (fibh.sbh == fibh.ebh) {
-			nameptr = udf_get_fi_ident(fi);
-		} else {
-			int poffset;	/* Unpaded ending offset */
-
-			poffset = fibh.soffset + sizeof(struct fileIdentDesc) + liu + lfi;
-
-			if (poffset >= lfi) {
-				nameptr = (char *)(fibh.ebh->b_data + poffset - lfi);
-			} else {
-				if (!copy_name) {
-					copy_name = kmalloc(UDF_NAME_LEN,
-							    GFP_NOFS);
-					if (!copy_name) {
-						ret = -ENOMEM;
-						goto out;
-					}
-				}
-				nameptr = copy_name;
-				memcpy(nameptr, udf_get_fi_ident(fi),
-				       lfi - poffset);
-				memcpy(nameptr + lfi - poffset,
-				       fibh.ebh->b_data, poffset);
-			}
-		}
+		/* Update file position only if we got past the current one */
+		pos_valid = true;
+		ctx->pos = (iter.pos >> 2) + 1;
 
-		if ((cfi.fileCharacteristics & FID_FILE_CHAR_DELETED) != 0) {
+		if (iter.fi.fileCharacteristics & FID_FILE_CHAR_DELETED) {
 			if (!UDF_QUERY_FLAG(sb, UDF_FLAG_UNDELETE))
 				continue;
 		}
 
-		if ((cfi.fileCharacteristics & FID_FILE_CHAR_HIDDEN) != 0) {
+		if (iter.fi.fileCharacteristics & FID_FILE_CHAR_HIDDEN) {
 			if (!UDF_QUERY_FLAG(sb, UDF_FLAG_UNHIDE))
 				continue;
 		}
 
-		if (cfi.fileCharacteristics & FID_FILE_CHAR_PARENT) {
+		if (iter.fi.fileCharacteristics & FID_FILE_CHAR_PARENT) {
 			if (!dir_emit_dotdot(file, ctx))
-				goto out;
+				goto out_iter;
 			continue;
 		}
 
-		flen = udf_get_filename(sb, nameptr, lfi, fname, UDF_NAME_LEN);
+		flen = udf_get_filename(sb, iter.name,
+				iter.fi.lengthFileIdent, fname, UDF_NAME_LEN);
 		if (flen < 0)
 			continue;
 
-		tloc = lelb_to_cpu(cfi.icb.extLocation);
+		tloc = lelb_to_cpu(iter.fi.icb.extLocation);
 		iblock = udf_get_lb_pblock(sb, &tloc, 0);
 		if (!dir_emit(ctx, fname, flen, iblock, DT_UNKNOWN))
-			goto out;
-	} /* end while */
-
-	ctx->pos = (nf_pos >> 2) + 1;
-	pos_valid = true;
+			goto out_iter;
+	}
 
+	if (!ret) {
+		ctx->pos = (iter.pos >> 2) + 1;
+		pos_valid = true;
+	}
+out_iter:
+	udf_fiiter_release(&iter);
 out:
 	if (pos_valid)
 		file->f_version = inode_query_iversion(dir);
-	if (fibh.sbh != fibh.ebh)
-		brelse(fibh.ebh);
-	brelse(fibh.sbh);
-	brelse(epos.bh);
 	kfree(fname);
-	kfree(copy_name);
 
 	return ret;
 }
-- 
2.34.1


