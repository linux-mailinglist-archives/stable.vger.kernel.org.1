Return-Path: <stable+bounces-86689-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 003FC9A2E51
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 22:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8028C1F23361
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 20:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE4D1D097F;
	Thu, 17 Oct 2024 20:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Vcj2g5Y/"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196381D07BA
	for <stable@vger.kernel.org>; Thu, 17 Oct 2024 20:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729196422; cv=none; b=J51v2U4Z5HyAaQ2dFGik2umlK5Qd047h/sH/Q7XqFG/8Y6adEZ3iMqIcOEdf7GZYiiogckvbvpf/AN6VNcXLtWv+uKJ7YaRcCFEDzluvpGKxYINkFtFW5zvzP8x+AOFO7HxezLlM9XRNr6xxetLmVhIflBfV6ozK93uOlk7tdAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729196422; c=relaxed/simple;
	bh=faDPUOJdGn81RKHKPGN673zBad0ieD4WwWQzLI6lIYM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gbbbR2fe9sipYFNx93yLcafsZYDWSov1x4BBA6x5YtUFm8FF7tnAuugNfLESNN+BppZic6tnxcd7bQCbRWsOkb2F6+uqA/kPGWGAVIFMzwW3uvu9Ae9wxyUB5sWn6DjhIB7R+wMCTZx8/Aut18d6fKrMPDtOYGsqy+grEFAVEBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Vcj2g5Y/; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=cRFZlIUppWV/HVV5/X24z4R77sW3iZo7WFULFn8GLgg=; b=Vcj2g5Y/ANhNwN/3NnFbXF0ZF9
	MsQLK1IKayBpzxVj2+r2ISccyumAh3cqraT58QUqQ9k0h1huLRZ77EkPJE3gt2ChFHJ3iHUQ9TDfB
	Ver+ngsOfFfBOl2ZXITuWVPtCM+USJC/AuB/JO+VGD3tnr3c7p5aetTcJWwMw/NLly/JwDY4UfajS
	4fNxuWSpiTnwYNvIeCJRfoVXdoZ2nYgMw1rXsd5n4lfxokp46EfpCO+QdQYB+SgswoHtQRssmcwa4
	fYhN8miDTVovQQUt/Y1fVBbWyCrrKBRVQMVFJdEeXynNIxXneato9AOSXK8bYPM20TXbNNmrsr8iq
	WIfR/5Rg==;
Received: from 179-125-64-237-dinamico.pombonet.net.br ([179.125.64.237] helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1t1Wyj-00BmZ7-6K; Thu, 17 Oct 2024 22:20:13 +0200
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: stable@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	kernel-dev@igalia.com,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: [PATCH 5.15 01/20] udf: New directory iteration code
Date: Thu, 17 Oct 2024 17:19:43 -0300
Message-Id: <20241017202002.406428-2-cascardo@igalia.com>
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

[ Upstream commit d16076d9b684b7c8d3ccbe9c33d5ea9fe8fcca09 ]

Add new support code for iterating directory entries. The code is also
more carefully verifying validity of on-disk directory entries to avoid
crashes on malicious media.

Signed-off-by: Jan Kara <jack@suse.cz>
[cascardo: use ll_rw_block instead of bh_readahead_batch]
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 fs/udf/directory.c | 395 +++++++++++++++++++++++++++++++++++++++++++++
 fs/udf/udfdecl.h   |  23 +++
 2 files changed, 418 insertions(+)

diff --git a/fs/udf/directory.c b/fs/udf/directory.c
index 73720320f0ab..29ef51744034 100644
--- a/fs/udf/directory.c
+++ b/fs/udf/directory.c
@@ -17,6 +17,401 @@
 #include <linux/fs.h>
 #include <linux/string.h>
 #include <linux/bio.h>
+#include <linux/crc-itu-t.h>
+#include <linux/iversion.h>
+
+static int udf_verify_fi(struct udf_fileident_iter *iter)
+{
+	unsigned int len;
+
+	if (iter->fi.descTag.tagIdent != cpu_to_le16(TAG_IDENT_FID)) {
+		udf_err(iter->dir->i_sb,
+			"directory (ino %lu) has entry at pos %llu with incorrect tag %x\n",
+			iter->dir->i_ino, (unsigned long long)iter->pos,
+			le16_to_cpu(iter->fi.descTag.tagIdent));
+		return -EFSCORRUPTED;
+	}
+	len = udf_dir_entry_len(&iter->fi);
+	if (le16_to_cpu(iter->fi.lengthOfImpUse) & 3) {
+		udf_err(iter->dir->i_sb,
+			"directory (ino %lu) has entry at pos %llu with unaligned lenght of impUse field\n",
+			iter->dir->i_ino, (unsigned long long)iter->pos);
+		return -EFSCORRUPTED;
+	}
+	/*
+	 * This is in fact allowed by the spec due to long impUse field but
+	 * we don't support it. If there is real media with this large impUse
+	 * field, support can be added.
+	 */
+	if (len > 1 << iter->dir->i_blkbits) {
+		udf_err(iter->dir->i_sb,
+			"directory (ino %lu) has too big (%u) entry at pos %llu\n",
+			iter->dir->i_ino, len, (unsigned long long)iter->pos);
+		return -EFSCORRUPTED;
+	}
+	if (iter->pos + len > iter->dir->i_size) {
+		udf_err(iter->dir->i_sb,
+			"directory (ino %lu) has entry past directory size at pos %llu\n",
+			iter->dir->i_ino, (unsigned long long)iter->pos);
+		return -EFSCORRUPTED;
+	}
+	if (udf_dir_entry_len(&iter->fi) !=
+	    sizeof(struct tag) + le16_to_cpu(iter->fi.descTag.descCRCLength)) {
+		udf_err(iter->dir->i_sb,
+			"directory (ino %lu) has entry where CRC length (%u) does not match entry length (%u)\n",
+			iter->dir->i_ino,
+			(unsigned)le16_to_cpu(iter->fi.descTag.descCRCLength),
+			(unsigned)(udf_dir_entry_len(&iter->fi) -
+							sizeof(struct tag)));
+		return -EFSCORRUPTED;
+	}
+	return 0;
+}
+
+static int udf_copy_fi(struct udf_fileident_iter *iter)
+{
+	struct udf_inode_info *iinfo = UDF_I(iter->dir);
+	int blksize = 1 << iter->dir->i_blkbits;
+	int err, off, len, nameoff;
+
+	/* Skip copying when we are at EOF */
+	if (iter->pos >= iter->dir->i_size) {
+		iter->name = NULL;
+		return 0;
+	}
+	if (iter->dir->i_size < iter->pos + sizeof(struct fileIdentDesc)) {
+		udf_err(iter->dir->i_sb,
+			"directory (ino %lu) has entry straddling EOF\n",
+			iter->dir->i_ino);
+		return -EFSCORRUPTED;
+	}
+	if (iinfo->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB) {
+		memcpy(&iter->fi, iinfo->i_data + iinfo->i_lenEAttr + iter->pos,
+		       sizeof(struct fileIdentDesc));
+		err = udf_verify_fi(iter);
+		if (err < 0)
+			return err;
+		iter->name = iinfo->i_data + iinfo->i_lenEAttr + iter->pos +
+			sizeof(struct fileIdentDesc) +
+			le16_to_cpu(iter->fi.lengthOfImpUse);
+		return 0;
+	}
+
+	off = iter->pos & (blksize - 1);
+	len = min_t(int, sizeof(struct fileIdentDesc), blksize - off);
+	memcpy(&iter->fi, iter->bh[0]->b_data + off, len);
+	if (len < sizeof(struct fileIdentDesc))
+		memcpy((char *)(&iter->fi) + len, iter->bh[1]->b_data,
+		       sizeof(struct fileIdentDesc) - len);
+	err = udf_verify_fi(iter);
+	if (err < 0)
+		return err;
+
+	/* Handle directory entry name */
+	nameoff = off + sizeof(struct fileIdentDesc) +
+				le16_to_cpu(iter->fi.lengthOfImpUse);
+	if (off + udf_dir_entry_len(&iter->fi) <= blksize) {
+		iter->name = iter->bh[0]->b_data + nameoff;
+	} else if (nameoff >= blksize) {
+		iter->name = iter->bh[1]->b_data + (nameoff - blksize);
+	} else {
+		iter->name = iter->namebuf;
+		len = blksize - nameoff;
+		memcpy(iter->name, iter->bh[0]->b_data + nameoff, len);
+		memcpy(iter->name + len, iter->bh[1]->b_data,
+		       iter->fi.lengthFileIdent - len);
+	}
+	return 0;
+}
+
+/* Readahead 8k once we are at 8k boundary */
+static void udf_readahead_dir(struct udf_fileident_iter *iter)
+{
+	unsigned int ralen = 16 >> (iter->dir->i_blkbits - 9);
+	struct buffer_head *tmp, *bha[16];
+	int i, num;
+	udf_pblk_t blk;
+
+	if (iter->loffset & (ralen - 1))
+		return;
+
+	if (iter->loffset + ralen > (iter->elen >> iter->dir->i_blkbits))
+		ralen = (iter->elen >> iter->dir->i_blkbits) - iter->loffset;
+	num = 0;
+	for (i = 0; i < ralen; i++) {
+		blk = udf_get_lb_pblock(iter->dir->i_sb, &iter->eloc,
+					iter->loffset + i);
+		tmp = udf_tgetblk(iter->dir->i_sb, blk);
+		if (tmp && !buffer_uptodate(tmp) && !buffer_locked(tmp))
+			bha[num++] = tmp;
+		else
+			brelse(tmp);
+	}
+	if (num) {
+		ll_rw_block(REQ_OP_READ, REQ_RAHEAD, num, bha);
+		for (i = 0; i < num; i++)
+			brelse(bha[i]);
+	}
+}
+
+static struct buffer_head *udf_fiiter_bread_blk(struct udf_fileident_iter *iter)
+{
+	udf_pblk_t blk;
+
+	udf_readahead_dir(iter);
+	blk = udf_get_lb_pblock(iter->dir->i_sb, &iter->eloc, iter->loffset);
+	return udf_tread(iter->dir->i_sb, blk);
+}
+
+/*
+ * Updates loffset to point to next directory block; eloc, elen & epos are
+ * updated if we need to traverse to the next extent as well.
+ */
+static int udf_fiiter_advance_blk(struct udf_fileident_iter *iter)
+{
+	iter->loffset++;
+	if (iter->loffset < iter->elen >> iter->dir->i_blkbits)
+		return 0;
+
+	iter->loffset = 0;
+	if (udf_next_aext(iter->dir, &iter->epos, &iter->eloc, &iter->elen, 1)
+			!= (EXT_RECORDED_ALLOCATED >> 30)) {
+		if (iter->pos == iter->dir->i_size) {
+			iter->elen = 0;
+			return 0;
+		}
+		udf_err(iter->dir->i_sb,
+			"extent after position %llu not allocated in directory (ino %lu)\n",
+			(unsigned long long)iter->pos, iter->dir->i_ino);
+		return -EFSCORRUPTED;
+	}
+	return 0;
+}
+
+static int udf_fiiter_load_bhs(struct udf_fileident_iter *iter)
+{
+	int blksize = 1 << iter->dir->i_blkbits;
+	int off = iter->pos & (blksize - 1);
+	int err;
+	struct fileIdentDesc *fi;
+
+	/* Is there any further extent we can map from? */
+	if (!iter->bh[0] && iter->elen) {
+		iter->bh[0] = udf_fiiter_bread_blk(iter);
+		if (!iter->bh[0]) {
+			err = -ENOMEM;
+			goto out_brelse;
+		}
+		if (!buffer_uptodate(iter->bh[0])) {
+			err = -EIO;
+			goto out_brelse;
+		}
+	}
+	/* There's no next block so we are done */
+	if (iter->pos >= iter->dir->i_size)
+		return 0;
+	/* Need to fetch next block as well? */
+	if (off + sizeof(struct fileIdentDesc) > blksize)
+		goto fetch_next;
+	fi = (struct fileIdentDesc *)(iter->bh[0]->b_data + off);
+	/* Need to fetch next block to get name? */
+	if (off + udf_dir_entry_len(fi) > blksize) {
+fetch_next:
+		udf_fiiter_advance_blk(iter);
+		iter->bh[1] = udf_fiiter_bread_blk(iter);
+		if (!iter->bh[1]) {
+			err = -ENOMEM;
+			goto out_brelse;
+		}
+		if (!buffer_uptodate(iter->bh[1])) {
+			err = -EIO;
+			goto out_brelse;
+		}
+	}
+	return 0;
+out_brelse:
+	brelse(iter->bh[0]);
+	brelse(iter->bh[1]);
+	iter->bh[0] = iter->bh[1] = NULL;
+	return err;
+}
+
+int udf_fiiter_init(struct udf_fileident_iter *iter, struct inode *dir,
+		    loff_t pos)
+{
+	struct udf_inode_info *iinfo = UDF_I(dir);
+	int err = 0;
+
+	iter->dir = dir;
+	iter->bh[0] = iter->bh[1] = NULL;
+	iter->pos = pos;
+	iter->elen = 0;
+	iter->epos.bh = NULL;
+	iter->name = NULL;
+
+	if (iinfo->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB)
+		return udf_copy_fi(iter);
+
+	if (inode_bmap(dir, iter->pos >> dir->i_blkbits, &iter->epos,
+		       &iter->eloc, &iter->elen, &iter->loffset) !=
+	    (EXT_RECORDED_ALLOCATED >> 30)) {
+		if (pos == dir->i_size)
+			return 0;
+		udf_err(dir->i_sb,
+			"position %llu not allocated in directory (ino %lu)\n",
+			(unsigned long long)pos, dir->i_ino);
+		return -EFSCORRUPTED;
+	}
+	err = udf_fiiter_load_bhs(iter);
+	if (err < 0)
+		return err;
+	err = udf_copy_fi(iter);
+	if (err < 0) {
+		udf_fiiter_release(iter);
+		return err;
+	}
+	return 0;
+}
+
+int udf_fiiter_advance(struct udf_fileident_iter *iter)
+{
+	unsigned int oldoff, len;
+	int blksize = 1 << iter->dir->i_blkbits;
+	int err;
+
+	oldoff = iter->pos & (blksize - 1);
+	len = udf_dir_entry_len(&iter->fi);
+	iter->pos += len;
+	if (UDF_I(iter->dir)->i_alloc_type != ICBTAG_FLAG_AD_IN_ICB) {
+		if (oldoff + len >= blksize) {
+			brelse(iter->bh[0]);
+			iter->bh[0] = NULL;
+			/* Next block already loaded? */
+			if (iter->bh[1]) {
+				iter->bh[0] = iter->bh[1];
+				iter->bh[1] = NULL;
+			} else {
+				udf_fiiter_advance_blk(iter);
+			}
+		}
+		err = udf_fiiter_load_bhs(iter);
+		if (err < 0)
+			return err;
+	}
+	return udf_copy_fi(iter);
+}
+
+void udf_fiiter_release(struct udf_fileident_iter *iter)
+{
+	iter->dir = NULL;
+	brelse(iter->bh[0]);
+	brelse(iter->bh[1]);
+	iter->bh[0] = iter->bh[1] = NULL;
+}
+
+static void udf_copy_to_bufs(void *buf1, int len1, void *buf2, int len2,
+			     int off, void *src, int len)
+{
+	int copy;
+
+	if (off >= len1) {
+		off -= len1;
+	} else {
+		copy = min(off + len, len1) - off;
+		memcpy(buf1 + off, src, copy);
+		src += copy;
+		len -= copy;
+		off = 0;
+	}
+	if (len > 0) {
+		if (WARN_ON_ONCE(off + len > len2 || !buf2))
+			return;
+		memcpy(buf2 + off, src, len);
+	}
+}
+
+static uint16_t udf_crc_fi_bufs(void *buf1, int len1, void *buf2, int len2,
+				int off, int len)
+{
+	int copy;
+	uint16_t crc = 0;
+
+	if (off >= len1) {
+		off -= len1;
+	} else {
+		copy = min(off + len, len1) - off;
+		crc = crc_itu_t(crc, buf1 + off, copy);
+		len -= copy;
+		off = 0;
+	}
+	if (len > 0) {
+		if (WARN_ON_ONCE(off + len > len2 || !buf2))
+			return 0;
+		crc = crc_itu_t(crc, buf2 + off, len);
+	}
+	return crc;
+}
+
+static void udf_copy_fi_to_bufs(char *buf1, int len1, char *buf2, int len2,
+				int off, struct fileIdentDesc *fi,
+				uint8_t *impuse, uint8_t *name)
+{
+	uint16_t crc;
+	int fioff = off;
+	int crcoff = off + sizeof(struct tag);
+	unsigned int crclen = udf_dir_entry_len(fi) - sizeof(struct tag);
+
+	udf_copy_to_bufs(buf1, len1, buf2, len2, off, fi,
+			 sizeof(struct fileIdentDesc));
+	off += sizeof(struct fileIdentDesc);
+	if (impuse)
+		udf_copy_to_bufs(buf1, len1, buf2, len2, off, impuse,
+				 le16_to_cpu(fi->lengthOfImpUse));
+	off += le16_to_cpu(fi->lengthOfImpUse);
+	if (name)
+		udf_copy_to_bufs(buf1, len1, buf2, len2, off, name,
+				 fi->lengthFileIdent);
+
+	crc = udf_crc_fi_bufs(buf1, len1, buf2, len2, crcoff, crclen);
+	fi->descTag.descCRC = cpu_to_le16(crc);
+	fi->descTag.descCRCLength = cpu_to_le16(crclen);
+	fi->descTag.tagChecksum = udf_tag_checksum(&fi->descTag);
+
+	udf_copy_to_bufs(buf1, len1, buf2, len2, fioff, fi, sizeof(struct tag));
+}
+
+void udf_fiiter_write_fi(struct udf_fileident_iter *iter, uint8_t *impuse)
+{
+	struct udf_inode_info *iinfo = UDF_I(iter->dir);
+	void *buf1, *buf2 = NULL;
+	int len1, len2 = 0, off;
+	int blksize = 1 << iter->dir->i_blkbits;
+
+	off = iter->pos & (blksize - 1);
+	if (iinfo->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB) {
+		buf1 = iinfo->i_data + iinfo->i_lenEAttr;
+		len1 = iter->dir->i_size;
+	} else {
+		buf1 = iter->bh[0]->b_data;
+		len1 = blksize;
+		if (iter->bh[1]) {
+			buf2 = iter->bh[1]->b_data;
+			len2 = blksize;
+		}
+	}
+
+	udf_copy_fi_to_bufs(buf1, len1, buf2, len2, off, &iter->fi, impuse,
+			    iter->name == iter->namebuf ? iter->name : NULL);
+
+	if (iinfo->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB) {
+		mark_inode_dirty(iter->dir);
+	} else {
+		mark_buffer_dirty_inode(iter->bh[0], iter->dir);
+		if (iter->bh[1])
+			mark_buffer_dirty_inode(iter->bh[1], iter->dir);
+	}
+	inode_inc_iversion(iter->dir);
+}
 
 struct fileIdentDesc *udf_fileident_read(struct inode *dir, loff_t *nf_pos,
 					 struct udf_fileident_bh *fibh,
diff --git a/fs/udf/udfdecl.h b/fs/udf/udfdecl.h
index 7e258f15b8ef..22a8466e335c 100644
--- a/fs/udf/udfdecl.h
+++ b/fs/udf/udfdecl.h
@@ -86,6 +86,24 @@ extern const struct address_space_operations udf_aops;
 extern const struct address_space_operations udf_adinicb_aops;
 extern const struct address_space_operations udf_symlink_aops;
 
+struct udf_fileident_iter {
+	struct inode *dir;		/* Directory we are working with */
+	loff_t pos;			/* Logical position in a dir */
+	struct buffer_head *bh[2];	/* Buffer containing 'pos' and possibly
+					 * next buffer if entry straddles
+					 * blocks */
+	struct kernel_lb_addr eloc;	/* Start of extent containing 'pos' */
+	uint32_t elen;			/* Length of extent containing 'pos' */
+	sector_t loffset;		/* Block offset of 'pos' within above
+					 * extent */
+	struct extent_position epos;	/* Position after the above extent */
+	struct fileIdentDesc fi;	/* Copied directory entry */
+	uint8_t *name;			/* Pointer to entry name */
+	uint8_t namebuf[UDF_NAME_LEN_CS0]; /* Storage for entry name in case
+					 * the name is split between two blocks
+					 */
+};
+
 struct udf_fileident_bh {
 	struct buffer_head *sbh;
 	struct buffer_head *ebh;
@@ -243,6 +261,11 @@ extern udf_pblk_t udf_new_block(struct super_block *sb, struct inode *inode,
 				 uint16_t partition, uint32_t goal, int *err);
 
 /* directory.c */
+int udf_fiiter_init(struct udf_fileident_iter *iter, struct inode *dir,
+		    loff_t pos);
+int udf_fiiter_advance(struct udf_fileident_iter *iter);
+void udf_fiiter_release(struct udf_fileident_iter *iter);
+void udf_fiiter_write_fi(struct udf_fileident_iter *iter, uint8_t *impuse);
 extern struct fileIdentDesc *udf_fileident_read(struct inode *, loff_t *,
 						struct udf_fileident_bh *,
 						struct fileIdentDesc *,
-- 
2.34.1


