Return-Path: <stable+bounces-86664-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 015869A2AB2
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 19:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 257BF1C214A8
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 17:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228011DF98A;
	Thu, 17 Oct 2024 17:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Kl1agQce"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDB61DF995
	for <stable@vger.kernel.org>; Thu, 17 Oct 2024 17:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729185604; cv=none; b=AxdGTettvkyi0h2stL/MTt4q2OJwvKriyi6Bqny4vo6XGszdiiVcxQbfN+WnHxzUPYudVEisavmZmdsYgkcPH6qAhPQNutnX/ylkc95hcoCEt6+mt4VaYh2CP1Bn/wM/S6IT66meYhc8lFckhEnOunW/gjmrwXhtLejXop0x5QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729185604; c=relaxed/simple;
	bh=Kevl6O6I/tNr+DKDOxwamhoL50oap43DRlg/0gSb/oE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IdZsir50YhfK5lx3wuiIbI9E/KWYZoTmqq9VTA9fn79FPZ7Z04qAOT6CqjLqXv0aaovCNceefp3ylUbe4eoGbXH5hBwCQXPoGMwJ6CjnlEGjCGSIgJq4p1NOtMqqpAs55nVBoGYDPSwWbyWEi/8SqTfWUw09KH9j433ilkic5JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Kl1agQce; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=SOxCrfRlacU1cJ0HV6uwSsBvbaDOu952trePZVcWoiE=; b=Kl1agQceMpC0EQvOUeAxezzGQ6
	Xh27PVd5AvvS7CQ1edEc4n+9CDwku04mWB+ul1AKf3cT1MHJ+LSWL3J0mnHwUQ8GsFKC9x75psSfK
	XRfk0u9fwhK88zxrX/JxMXJTd6LSpQB9+6GBG9stgqygj1lgwmRBGgIRme9yQADHdUqlZZlRYw/7T
	//lxWBkeUnzAcu0HMPhH+H+1+1JV++FzQBvonP45i9q+qIMuhopXEsSmrmaimXBf9XAf9nc4vgnXr
	JbTp+Nup/4QzBUTnaku0s5Cy0F5NQD3Fqr9X0YmZ17fgGqmSmtHwXja1/WWsqGOhMnUMkyFBmC7/Q
	9kjuDtuw==;
Received: from 179-125-64-237-dinamico.pombonet.net.br ([179.125.64.237] helo=quatroqueijos.lan)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1t1UAG-00Biqr-IB; Thu, 17 Oct 2024 19:19:57 +0200
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: stable@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	kernel-dev@igalia.com,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: [PATCH 6.1 13/19] udf: Implement adding of dir entries using new iteration code
Date: Thu, 17 Oct 2024 14:19:09 -0300
Message-Id: <20241017171915.311132-14-cascardo@igalia.com>
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

[ Upstream commit f2844803404d9729f893e279ddea12678710e7fb ]

Implement function udf_fiiter_add_entry() adding new directory entries
using new directory iteration code.

Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 fs/udf/directory.c |  57 +++++++++++++++++++++++
 fs/udf/namei.c     | 110 +++++++++++++++++++++++++++++++++++++++++++++
 fs/udf/udfdecl.h   |   2 +
 3 files changed, 169 insertions(+)

diff --git a/fs/udf/directory.c b/fs/udf/directory.c
index 2842c463725c..be85d1b2a6cf 100644
--- a/fs/udf/directory.c
+++ b/fs/udf/directory.c
@@ -413,6 +413,63 @@ void udf_fiiter_write_fi(struct udf_fileident_iter *iter, uint8_t *impuse)
 	inode_inc_iversion(iter->dir);
 }
 
+void udf_fiiter_update_elen(struct udf_fileident_iter *iter, uint32_t new_elen)
+{
+	struct udf_inode_info *iinfo = UDF_I(iter->dir);
+	int diff = new_elen - iter->elen;
+
+	/* Skip update when we already went past the last extent */
+	if (!iter->elen)
+		return;
+	iter->elen = new_elen;
+	if (iinfo->i_alloc_type == ICBTAG_FLAG_AD_SHORT)
+		iter->epos.offset -= sizeof(struct short_ad);
+	else if (iinfo->i_alloc_type == ICBTAG_FLAG_AD_LONG)
+		iter->epos.offset -= sizeof(struct long_ad);
+	udf_write_aext(iter->dir, &iter->epos, &iter->eloc, iter->elen, 1);
+	iinfo->i_lenExtents += diff;
+	mark_inode_dirty(iter->dir);
+}
+
+/* Append new block to directory. @iter is expected to point at EOF */
+int udf_fiiter_append_blk(struct udf_fileident_iter *iter)
+{
+	struct udf_inode_info *iinfo = UDF_I(iter->dir);
+	int blksize = 1 << iter->dir->i_blkbits;
+	struct buffer_head *bh;
+	sector_t block;
+	uint32_t old_elen = iter->elen;
+	int err;
+
+	if (WARN_ON_ONCE(iinfo->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB))
+		return -EINVAL;
+
+	/* Round up last extent in the file */
+	udf_fiiter_update_elen(iter, ALIGN(iter->elen, blksize));
+
+	/* Allocate new block and refresh mapping information */
+	block = iinfo->i_lenExtents >> iter->dir->i_blkbits;
+	bh = udf_bread(iter->dir, block, 1, &err);
+	if (!bh) {
+		udf_fiiter_update_elen(iter, old_elen);
+		return err;
+	}
+	if (inode_bmap(iter->dir, block, &iter->epos, &iter->eloc, &iter->elen,
+		       &iter->loffset) != (EXT_RECORDED_ALLOCATED >> 30)) {
+		udf_err(iter->dir->i_sb,
+			"block %llu not allocated in directory (ino %lu)\n",
+			(unsigned long long)block, iter->dir->i_ino);
+		return -EFSCORRUPTED;
+	}
+	if (!(iter->pos & (blksize - 1))) {
+		brelse(iter->bh[0]);
+		iter->bh[0] = bh;
+	} else {
+		iter->bh[1] = bh;
+	}
+	return 0;
+}
+
 struct fileIdentDesc *udf_fileident_read(struct inode *dir, loff_t *nf_pos,
 					 struct udf_fileident_bh *fibh,
 					 struct fileIdentDesc *cfi,
diff --git a/fs/udf/namei.c b/fs/udf/namei.c
index 39508a2e25c9..bdf237dee120 100644
--- a/fs/udf/namei.c
+++ b/fs/udf/namei.c
@@ -472,6 +472,116 @@ static struct buffer_head *udf_expand_dir_adinicb(struct inode *inode,
 	return dbh;
 }
 
+static int udf_fiiter_add_entry(struct inode *dir, struct dentry *dentry,
+				struct udf_fileident_iter *iter)
+{
+	struct udf_inode_info *dinfo = UDF_I(dir);
+	int nfidlen, namelen = 0;
+	int ret;
+	int off, blksize = 1 << dir->i_blkbits;
+	udf_pblk_t block;
+	char name[UDF_NAME_LEN_CS0];
+
+	if (dentry) {
+		if (!dentry->d_name.len)
+			return -EINVAL;
+		namelen = udf_put_filename(dir->i_sb, dentry->d_name.name,
+					   dentry->d_name.len,
+					   name, UDF_NAME_LEN_CS0);
+		if (!namelen)
+			return -ENAMETOOLONG;
+	}
+	nfidlen = ALIGN(sizeof(struct fileIdentDesc) + namelen, UDF_NAME_PAD);
+
+	for (ret = udf_fiiter_init(iter, dir, 0);
+	     !ret && iter->pos < dir->i_size;
+	     ret = udf_fiiter_advance(iter)) {
+		if (iter->fi.fileCharacteristics & FID_FILE_CHAR_DELETED) {
+			if (udf_dir_entry_len(&iter->fi) == nfidlen) {
+				iter->fi.descTag.tagSerialNum = cpu_to_le16(1);
+				iter->fi.fileVersionNum = cpu_to_le16(1);
+				iter->fi.fileCharacteristics = 0;
+				iter->fi.lengthFileIdent = namelen;
+				iter->fi.lengthOfImpUse = cpu_to_le16(0);
+				memcpy(iter->namebuf, name, namelen);
+				iter->name = iter->namebuf;
+				return 0;
+			}
+		}
+	}
+	if (ret) {
+		udf_fiiter_release(iter);
+		return ret;
+	}
+	if (dinfo->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB &&
+	    blksize - udf_ext0_offset(dir) - iter->pos < nfidlen) {
+		struct buffer_head *retbh;
+
+		udf_fiiter_release(iter);
+		/*
+		 * FIXME: udf_expand_dir_adinicb does not need to return bh
+		 * once other users are gone
+		 */
+		retbh = udf_expand_dir_adinicb(dir, &block, &ret);
+		if (!retbh)
+			return ret;
+		brelse(retbh);
+		ret = udf_fiiter_init(iter, dir, dir->i_size);
+		if (ret < 0)
+			return ret;
+	}
+
+	/* Get blocknumber to use for entry tag */
+	if (dinfo->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB) {
+		block = dinfo->i_location.logicalBlockNum;
+	} else {
+		block = iter->eloc.logicalBlockNum +
+				((iter->elen - 1) >> dir->i_blkbits);
+	}
+	off = iter->pos & (blksize - 1);
+	if (!off)
+		off = blksize;
+	/* Entry fits into current block? */
+	if (blksize - udf_ext0_offset(dir) - off >= nfidlen)
+		goto store_fi;
+
+	ret = udf_fiiter_append_blk(iter);
+	if (ret) {
+		udf_fiiter_release(iter);
+		return ret;
+	}
+
+	/* Entry will be completely in the new block? Update tag location... */
+	if (!(iter->pos & (blksize - 1)))
+		block = iter->eloc.logicalBlockNum +
+				((iter->elen - 1) >> dir->i_blkbits);
+store_fi:
+	memset(&iter->fi, 0, sizeof(struct fileIdentDesc));
+	if (UDF_SB(dir->i_sb)->s_udfrev >= 0x0200)
+		udf_new_tag((char *)(&iter->fi), TAG_IDENT_FID, 3, 1, block,
+			    sizeof(struct tag));
+	else
+		udf_new_tag((char *)(&iter->fi), TAG_IDENT_FID, 2, 1, block,
+			    sizeof(struct tag));
+	iter->fi.fileVersionNum = cpu_to_le16(1);
+	iter->fi.lengthFileIdent = namelen;
+	iter->fi.lengthOfImpUse = cpu_to_le16(0);
+	memcpy(iter->namebuf, name, namelen);
+	iter->name = iter->namebuf;
+
+	dir->i_size += nfidlen;
+	if (dinfo->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB) {
+		dinfo->i_lenAlloc += nfidlen;
+	} else {
+		/* Truncate last extent to proper size */
+		udf_fiiter_update_elen(iter, iter->elen -
+					(dinfo->i_lenExtents - dir->i_size));
+	}
+	mark_inode_dirty(dir);
+
+	return 0;
+}
+
 static struct fileIdentDesc *udf_add_entry(struct inode *dir,
 					   struct dentry *dentry,
 					   struct udf_fileident_bh *fibh,
diff --git a/fs/udf/udfdecl.h b/fs/udf/udfdecl.h
index 676fa2996ffe..e47b2f0c3e05 100644
--- a/fs/udf/udfdecl.h
+++ b/fs/udf/udfdecl.h
@@ -264,6 +264,8 @@ int udf_fiiter_init(struct udf_fileident_iter *iter, struct inode *dir,
 int udf_fiiter_advance(struct udf_fileident_iter *iter);
 void udf_fiiter_release(struct udf_fileident_iter *iter);
 void udf_fiiter_write_fi(struct udf_fileident_iter *iter, uint8_t *impuse);
+void udf_fiiter_update_elen(struct udf_fileident_iter *iter, uint32_t new_elen);
+int udf_fiiter_append_blk(struct udf_fileident_iter *iter);
 extern struct fileIdentDesc *udf_fileident_read(struct inode *, loff_t *,
 						struct udf_fileident_bh *,
 						struct fileIdentDesc *,
-- 
2.34.1


