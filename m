Return-Path: <stable+bounces-87334-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0129A647A
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 12:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8E4A280DE4
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 10:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D6D1F472D;
	Mon, 21 Oct 2024 10:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Y3IvUGfP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766471F471E;
	Mon, 21 Oct 2024 10:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729507295; cv=none; b=jv4TFQqzHO1ALWktbbxTPM2o7AhUgGw7gBz77CP4CFfAg1p9wD47heQ3Tx3F2PcVr/5OtGJWJ3NHXB6v5HnsynX8vP7N5UxBu/8Wb2gnO63DGrGM1Mc539YkdUOLVAp86enscxcJ2hJcTkf0VcNPCeWN7I8N19qUivoauXASuEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729507295; c=relaxed/simple;
	bh=gfjQlBuRec7l4rHMgFCcuFmRTaSTkZQsmXh8NtjM6fE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oISXvISeHLFs1/xyGloxaAt0pwwY4dwzpcP+bh+iqs2F+FmhXbFBOoaW1SQAbUNfHDiYu7xHrK36wh75tuV5w72r9t8biCkgaiUUcpcwRgCm9lkitt39dguBs0j6fsN870QO5X342tMi+z/6E+r5laheA3/mYXL71d5Z2jKQ4TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Y3IvUGfP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EA56C4CEC7;
	Mon, 21 Oct 2024 10:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729507295;
	bh=gfjQlBuRec7l4rHMgFCcuFmRTaSTkZQsmXh8NtjM6fE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y3IvUGfPugMdnlLDUAeqcalpYaNbPnvYk++bwHa9DIYSXws54Ck1YydMJjPUngM4v
	 9gxcfA7QQcaZBXUX995jXgyQsMtEb7MuBP4VfFHjpInwCBuMqI61/MPuC/yxT6+qSe
	 6ZXM10WDPsRvBSmCBC4akgrPdf8fk7cL88DbTi2w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jan Kara <jack@suse.cz>,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: [PATCH 6.1 22/91] udf: Remove old directory iteration code
Date: Mon, 21 Oct 2024 12:24:36 +0200
Message-ID: <20241021102250.686719879@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241021102249.791942892@linuxfoundation.org>
References: <20241021102249.791942892@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jan Kara <jack@suse.cz>

[ Upstream commit 1e0290d61a870ed61a6510863029939bbf6b0006 ]

Remove old directory iteration code that is now unused.

Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/udf/directory.c |  178 ------------------
 fs/udf/namei.c     |  505 -----------------------------------------------------
 fs/udf/udfdecl.h   |   22 --
 3 files changed, 705 deletions(-)

--- a/fs/udf/directory.c
+++ b/fs/udf/directory.c
@@ -470,184 +470,6 @@ int udf_fiiter_append_blk(struct udf_fil
 	return 0;
 }
 
-struct fileIdentDesc *udf_fileident_read(struct inode *dir, loff_t *nf_pos,
-					 struct udf_fileident_bh *fibh,
-					 struct fileIdentDesc *cfi,
-					 struct extent_position *epos,
-					 struct kernel_lb_addr *eloc, uint32_t *elen,
-					 sector_t *offset)
-{
-	struct fileIdentDesc *fi;
-	int i, num;
-	udf_pblk_t block;
-	struct buffer_head *tmp, *bha[16];
-	struct udf_inode_info *iinfo = UDF_I(dir);
-
-	fibh->soffset = fibh->eoffset;
-
-	if (iinfo->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB) {
-		fi = udf_get_fileident(iinfo->i_data -
-				       (iinfo->i_efe ?
-					sizeof(struct extendedFileEntry) :
-					sizeof(struct fileEntry)),
-				       dir->i_sb->s_blocksize,
-				       &(fibh->eoffset));
-		if (!fi)
-			return NULL;
-
-		*nf_pos += fibh->eoffset - fibh->soffset;
-
-		memcpy((uint8_t *)cfi, (uint8_t *)fi,
-		       sizeof(struct fileIdentDesc));
-
-		return fi;
-	}
-
-	if (fibh->eoffset == dir->i_sb->s_blocksize) {
-		uint32_t lextoffset = epos->offset;
-		unsigned char blocksize_bits = dir->i_sb->s_blocksize_bits;
-
-		if (udf_next_aext(dir, epos, eloc, elen, 1) !=
-		    (EXT_RECORDED_ALLOCATED >> 30))
-			return NULL;
-
-		block = udf_get_lb_pblock(dir->i_sb, eloc, *offset);
-
-		(*offset)++;
-
-		if ((*offset << blocksize_bits) >= *elen)
-			*offset = 0;
-		else
-			epos->offset = lextoffset;
-
-		brelse(fibh->sbh);
-		fibh->sbh = fibh->ebh = udf_tread(dir->i_sb, block);
-		if (!fibh->sbh)
-			return NULL;
-		fibh->soffset = fibh->eoffset = 0;
-
-		if (!(*offset & ((16 >> (blocksize_bits - 9)) - 1))) {
-			i = 16 >> (blocksize_bits - 9);
-			if (i + *offset > (*elen >> blocksize_bits))
-				i = (*elen >> blocksize_bits)-*offset;
-			for (num = 0; i > 0; i--) {
-				block = udf_get_lb_pblock(dir->i_sb, eloc,
-							  *offset + i);
-				tmp = udf_tgetblk(dir->i_sb, block);
-				if (tmp && !buffer_uptodate(tmp) &&
-						!buffer_locked(tmp))
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
-	} else if (fibh->sbh != fibh->ebh) {
-		brelse(fibh->sbh);
-		fibh->sbh = fibh->ebh;
-	}
-
-	fi = udf_get_fileident(fibh->sbh->b_data, dir->i_sb->s_blocksize,
-			       &(fibh->eoffset));
-
-	if (!fi)
-		return NULL;
-
-	*nf_pos += fibh->eoffset - fibh->soffset;
-
-	if (fibh->eoffset <= dir->i_sb->s_blocksize) {
-		memcpy((uint8_t *)cfi, (uint8_t *)fi,
-		       sizeof(struct fileIdentDesc));
-	} else if (fibh->eoffset > dir->i_sb->s_blocksize) {
-		uint32_t lextoffset = epos->offset;
-
-		if (udf_next_aext(dir, epos, eloc, elen, 1) !=
-		    (EXT_RECORDED_ALLOCATED >> 30))
-			return NULL;
-
-		block = udf_get_lb_pblock(dir->i_sb, eloc, *offset);
-
-		(*offset)++;
-
-		if ((*offset << dir->i_sb->s_blocksize_bits) >= *elen)
-			*offset = 0;
-		else
-			epos->offset = lextoffset;
-
-		fibh->soffset -= dir->i_sb->s_blocksize;
-		fibh->eoffset -= dir->i_sb->s_blocksize;
-
-		fibh->ebh = udf_tread(dir->i_sb, block);
-		if (!fibh->ebh)
-			return NULL;
-
-		if (sizeof(struct fileIdentDesc) > -fibh->soffset) {
-			int fi_len;
-
-			memcpy((uint8_t *)cfi, (uint8_t *)fi, -fibh->soffset);
-			memcpy((uint8_t *)cfi - fibh->soffset,
-			       fibh->ebh->b_data,
-			       sizeof(struct fileIdentDesc) + fibh->soffset);
-
-			fi_len = udf_dir_entry_len(cfi);
-			*nf_pos += fi_len - (fibh->eoffset - fibh->soffset);
-			fibh->eoffset = fibh->soffset + fi_len;
-		} else {
-			memcpy((uint8_t *)cfi, (uint8_t *)fi,
-			       sizeof(struct fileIdentDesc));
-		}
-	}
-	/* Got last entry outside of dir size - fs is corrupted! */
-	if (*nf_pos > dir->i_size)
-		return NULL;
-	return fi;
-}
-
-struct fileIdentDesc *udf_get_fileident(void *buffer, int bufsize, int *offset)
-{
-	struct fileIdentDesc *fi;
-	int lengthThisIdent;
-	uint8_t *ptr;
-	int padlen;
-
-	if ((!buffer) || (!offset)) {
-		udf_debug("invalidparms, buffer=%p, offset=%p\n",
-			  buffer, offset);
-		return NULL;
-	}
-
-	ptr = buffer;
-
-	if ((*offset > 0) && (*offset < bufsize))
-		ptr += *offset;
-	fi = (struct fileIdentDesc *)ptr;
-	if (fi->descTag.tagIdent != cpu_to_le16(TAG_IDENT_FID)) {
-		udf_debug("0x%x != TAG_IDENT_FID\n",
-			  le16_to_cpu(fi->descTag.tagIdent));
-		udf_debug("offset: %d sizeof: %lu bufsize: %d\n",
-			  *offset, (unsigned long)sizeof(struct fileIdentDesc),
-			  bufsize);
-		return NULL;
-	}
-	if ((*offset + sizeof(struct fileIdentDesc)) > bufsize)
-		lengthThisIdent = sizeof(struct fileIdentDesc);
-	else
-		lengthThisIdent = sizeof(struct fileIdentDesc) +
-			fi->lengthFileIdent + le16_to_cpu(fi->lengthOfImpUse);
-
-	/* we need to figure padding, too! */
-	padlen = lengthThisIdent % UDF_NAME_PAD;
-	if (padlen)
-		lengthThisIdent += (UDF_NAME_PAD - padlen);
-	*offset = *offset + lengthThisIdent;
-
-	return fi;
-}
-
 struct short_ad *udf_get_fileshortad(uint8_t *ptr, int maxoffset, uint32_t *offset,
 			      int inc)
 {
--- a/fs/udf/namei.c
+++ b/fs/udf/namei.c
@@ -41,105 +41,6 @@ static inline int udf_match(int len1, co
 	return !memcmp(name1, name2, len1);
 }
 
-int udf_write_fi(struct inode *inode, struct fileIdentDesc *cfi,
-		 struct fileIdentDesc *sfi, struct udf_fileident_bh *fibh,
-		 uint8_t *impuse, uint8_t *fileident)
-{
-	uint16_t crclen = fibh->eoffset - fibh->soffset - sizeof(struct tag);
-	uint16_t crc;
-	int offset;
-	uint16_t liu = le16_to_cpu(cfi->lengthOfImpUse);
-	uint8_t lfi = cfi->lengthFileIdent;
-	int padlen = fibh->eoffset - fibh->soffset - liu - lfi -
-		sizeof(struct fileIdentDesc);
-	int adinicb = 0;
-
-	if (UDF_I(inode)->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB)
-		adinicb = 1;
-
-	offset = fibh->soffset + sizeof(struct fileIdentDesc);
-
-	if (impuse) {
-		if (adinicb || (offset + liu < 0)) {
-			memcpy((uint8_t *)sfi->impUse, impuse, liu);
-		} else if (offset >= 0) {
-			memcpy(fibh->ebh->b_data + offset, impuse, liu);
-		} else {
-			memcpy((uint8_t *)sfi->impUse, impuse, -offset);
-			memcpy(fibh->ebh->b_data, impuse - offset,
-				liu + offset);
-		}
-	}
-
-	offset += liu;
-
-	if (fileident) {
-		if (adinicb || (offset + lfi < 0)) {
-			memcpy(sfi->impUse + liu, fileident, lfi);
-		} else if (offset >= 0) {
-			memcpy(fibh->ebh->b_data + offset, fileident, lfi);
-		} else {
-			memcpy(sfi->impUse + liu, fileident, -offset);
-			memcpy(fibh->ebh->b_data, fileident - offset,
-				lfi + offset);
-		}
-	}
-
-	offset += lfi;
-
-	if (adinicb || (offset + padlen < 0)) {
-		memset(sfi->impUse + liu + lfi, 0x00, padlen);
-	} else if (offset >= 0) {
-		memset(fibh->ebh->b_data + offset, 0x00, padlen);
-	} else {
-		memset(sfi->impUse + liu + lfi, 0x00, -offset);
-		memset(fibh->ebh->b_data, 0x00, padlen + offset);
-	}
-
-	crc = crc_itu_t(0, (uint8_t *)cfi + sizeof(struct tag),
-		      sizeof(struct fileIdentDesc) - sizeof(struct tag));
-
-	if (fibh->sbh == fibh->ebh) {
-		crc = crc_itu_t(crc, (uint8_t *)sfi->impUse,
-			      crclen + sizeof(struct tag) -
-			      sizeof(struct fileIdentDesc));
-	} else if (sizeof(struct fileIdentDesc) >= -fibh->soffset) {
-		crc = crc_itu_t(crc, fibh->ebh->b_data +
-					sizeof(struct fileIdentDesc) +
-					fibh->soffset,
-			      crclen + sizeof(struct tag) -
-					sizeof(struct fileIdentDesc));
-	} else {
-		crc = crc_itu_t(crc, (uint8_t *)sfi->impUse,
-			      -fibh->soffset - sizeof(struct fileIdentDesc));
-		crc = crc_itu_t(crc, fibh->ebh->b_data, fibh->eoffset);
-	}
-
-	cfi->descTag.descCRC = cpu_to_le16(crc);
-	cfi->descTag.descCRCLength = cpu_to_le16(crclen);
-	cfi->descTag.tagChecksum = udf_tag_checksum(&cfi->descTag);
-
-	if (adinicb || (sizeof(struct fileIdentDesc) <= -fibh->soffset)) {
-		memcpy((uint8_t *)sfi, (uint8_t *)cfi,
-			sizeof(struct fileIdentDesc));
-	} else {
-		memcpy((uint8_t *)sfi, (uint8_t *)cfi, -fibh->soffset);
-		memcpy(fibh->ebh->b_data, (uint8_t *)cfi - fibh->soffset,
-		       sizeof(struct fileIdentDesc) + fibh->soffset);
-	}
-
-	if (adinicb) {
-		mark_inode_dirty(inode);
-	} else {
-		if (fibh->sbh != fibh->ebh)
-			mark_buffer_dirty_inode(fibh->ebh, inode);
-		mark_buffer_dirty_inode(fibh->sbh, inode);
-	}
-	inode_inc_iversion(inode);
-
-	return 0;
-}
-
 /**
  * udf_fiiter_find_entry - find entry in given directory.
  *
@@ -207,161 +108,6 @@ out_ok:
 	return ret;
 }
 
-/**
- * udf_find_entry - find entry in given directory.
- *
- * @dir:	directory inode to search in
- * @child:	qstr of the name
- * @fibh:	buffer head / inode with file identifier descriptor we found
- * @cfi:	found file identifier descriptor with given name
- *
- * This function searches in the directory @dir for a file name @child. When
- * found, @fibh points to the buffer head(s) (bh is NULL for in ICB
- * directories) containing the file identifier descriptor (FID). In that case
- * the function returns pointer to the FID in the buffer or inode - but note
- * that FID may be split among two buffers (blocks) so accessing it via that
- * pointer isn't easily possible. This pointer can be used only as an iterator
- * for other directory manipulation functions. For inspection of the FID @cfi
- * can be used - the found FID is copied there.
- *
- * Returns pointer to FID, NULL when nothing found, or error code.
- */
-static struct fileIdentDesc *udf_find_entry(struct inode *dir,
-					    const struct qstr *child,
-					    struct udf_fileident_bh *fibh,
-					    struct fileIdentDesc *cfi)
-{
-	struct fileIdentDesc *fi = NULL;
-	loff_t f_pos;
-	udf_pblk_t block;
-	int flen;
-	unsigned char *fname = NULL, *copy_name = NULL;
-	unsigned char *nameptr;
-	uint8_t lfi;
-	uint16_t liu;
-	loff_t size;
-	struct kernel_lb_addr eloc;
-	uint32_t elen;
-	sector_t offset;
-	struct extent_position epos = {};
-	struct udf_inode_info *dinfo = UDF_I(dir);
-	int isdotdot = child->len == 2 &&
-		child->name[0] == '.' && child->name[1] == '.';
-	struct super_block *sb = dir->i_sb;
-
-	size = udf_ext0_offset(dir) + dir->i_size;
-	f_pos = udf_ext0_offset(dir);
-
-	fibh->sbh = fibh->ebh = NULL;
-	fibh->soffset = fibh->eoffset = f_pos & (sb->s_blocksize - 1);
-	if (dinfo->i_alloc_type != ICBTAG_FLAG_AD_IN_ICB) {
-		if (inode_bmap(dir, f_pos >> sb->s_blocksize_bits, &epos,
-		    &eloc, &elen, &offset) != (EXT_RECORDED_ALLOCATED >> 30)) {
-			fi = ERR_PTR(-EIO);
-			goto out_err;
-		}
-
-		block = udf_get_lb_pblock(sb, &eloc, offset);
-		if ((++offset << sb->s_blocksize_bits) < elen) {
-			if (dinfo->i_alloc_type == ICBTAG_FLAG_AD_SHORT)
-				epos.offset -= sizeof(struct short_ad);
-			else if (dinfo->i_alloc_type == ICBTAG_FLAG_AD_LONG)
-				epos.offset -= sizeof(struct long_ad);
-		} else
-			offset = 0;
-
-		fibh->sbh = fibh->ebh = udf_tread(sb, block);
-		if (!fibh->sbh) {
-			fi = ERR_PTR(-EIO);
-			goto out_err;
-		}
-	}
-
-	fname = kmalloc(UDF_NAME_LEN, GFP_NOFS);
-	if (!fname) {
-		fi = ERR_PTR(-ENOMEM);
-		goto out_err;
-	}
-
-	while (f_pos < size) {
-		fi = udf_fileident_read(dir, &f_pos, fibh, cfi, &epos, &eloc,
-					&elen, &offset);
-		if (!fi) {
-			fi = ERR_PTR(-EIO);
-			goto out_err;
-		}
-
-		liu = le16_to_cpu(cfi->lengthOfImpUse);
-		lfi = cfi->lengthFileIdent;
-
-		if (fibh->sbh == fibh->ebh) {
-			nameptr = udf_get_fi_ident(fi);
-		} else {
-			int poffset;	/* Unpaded ending offset */
-
-			poffset = fibh->soffset + sizeof(struct fileIdentDesc) +
-					liu + lfi;
-
-			if (poffset >= lfi)
-				nameptr = (uint8_t *)(fibh->ebh->b_data +
-						      poffset - lfi);
-			else {
-				if (!copy_name) {
-					copy_name = kmalloc(UDF_NAME_LEN_CS0,
-							    GFP_NOFS);
-					if (!copy_name) {
-						fi = ERR_PTR(-ENOMEM);
-						goto out_err;
-					}
-				}
-				nameptr = copy_name;
-				memcpy(nameptr, udf_get_fi_ident(fi),
-					lfi - poffset);
-				memcpy(nameptr + lfi - poffset,
-					fibh->ebh->b_data, poffset);
-			}
-		}
-
-		if ((cfi->fileCharacteristics & FID_FILE_CHAR_DELETED) != 0) {
-			if (!UDF_QUERY_FLAG(sb, UDF_FLAG_UNDELETE))
-				continue;
-		}
-
-		if ((cfi->fileCharacteristics & FID_FILE_CHAR_HIDDEN) != 0) {
-			if (!UDF_QUERY_FLAG(sb, UDF_FLAG_UNHIDE))
-				continue;
-		}
-
-		if ((cfi->fileCharacteristics & FID_FILE_CHAR_PARENT) &&
-		    isdotdot)
-			goto out_ok;
-
-		if (!lfi)
-			continue;
-
-		flen = udf_get_filename(sb, nameptr, lfi, fname, UDF_NAME_LEN);
-		if (flen < 0) {
-			fi = ERR_PTR(flen);
-			goto out_err;
-		}
-
-		if (udf_match(flen, fname, child->len, child->name))
-			goto out_ok;
-	}
-
-	fi = NULL;
-out_err:
-	if (fibh->sbh != fibh->ebh)
-		brelse(fibh->ebh);
-	brelse(fibh->sbh);
-out_ok:
-	brelse(epos.bh);
-	kfree(fname);
-	kfree(copy_name);
-
-	return fi;
-}
-
 static struct dentry *udf_lookup(struct inode *dir, struct dentry *dentry,
 				 unsigned int flags)
 {
@@ -582,245 +328,6 @@ store_fi:
 	return 0;
 }
 
-static struct fileIdentDesc *udf_add_entry(struct inode *dir,
-					   struct dentry *dentry,
-					   struct udf_fileident_bh *fibh,
-					   struct fileIdentDesc *cfi, int *err)
-{
-	struct super_block *sb = dir->i_sb;
-	struct fileIdentDesc *fi = NULL;
-	unsigned char *name = NULL;
-	int namelen;
-	loff_t f_pos;
-	loff_t size = udf_ext0_offset(dir) + dir->i_size;
-	int nfidlen;
-	udf_pblk_t block;
-	struct kernel_lb_addr eloc;
-	uint32_t elen = 0;
-	sector_t offset;
-	struct extent_position epos = {};
-	struct udf_inode_info *dinfo;
-
-	fibh->sbh = fibh->ebh = NULL;
-	name = kmalloc(UDF_NAME_LEN_CS0, GFP_NOFS);
-	if (!name) {
-		*err = -ENOMEM;
-		goto out_err;
-	}
-
-	if (dentry) {
-		if (!dentry->d_name.len) {
-			*err = -EINVAL;
-			goto out_err;
-		}
-		namelen = udf_put_filename(sb, dentry->d_name.name,
-					   dentry->d_name.len,
-					   name, UDF_NAME_LEN_CS0);
-		if (!namelen) {
-			*err = -ENAMETOOLONG;
-			goto out_err;
-		}
-	} else {
-		namelen = 0;
-	}
-
-	nfidlen = ALIGN(sizeof(struct fileIdentDesc) + namelen, UDF_NAME_PAD);
-
-	f_pos = udf_ext0_offset(dir);
-
-	fibh->soffset = fibh->eoffset = f_pos & (dir->i_sb->s_blocksize - 1);
-	dinfo = UDF_I(dir);
-	if (dinfo->i_alloc_type != ICBTAG_FLAG_AD_IN_ICB) {
-		if (inode_bmap(dir, f_pos >> dir->i_sb->s_blocksize_bits, &epos,
-		    &eloc, &elen, &offset) != (EXT_RECORDED_ALLOCATED >> 30)) {
-			block = udf_get_lb_pblock(dir->i_sb,
-					&dinfo->i_location, 0);
-			fibh->soffset = fibh->eoffset = sb->s_blocksize;
-			goto add;
-		}
-		block = udf_get_lb_pblock(dir->i_sb, &eloc, offset);
-		if ((++offset << dir->i_sb->s_blocksize_bits) < elen) {
-			if (dinfo->i_alloc_type == ICBTAG_FLAG_AD_SHORT)
-				epos.offset -= sizeof(struct short_ad);
-			else if (dinfo->i_alloc_type == ICBTAG_FLAG_AD_LONG)
-				epos.offset -= sizeof(struct long_ad);
-		} else
-			offset = 0;
-
-		fibh->sbh = fibh->ebh = udf_tread(dir->i_sb, block);
-		if (!fibh->sbh) {
-			*err = -EIO;
-			goto out_err;
-		}
-
-		block = dinfo->i_location.logicalBlockNum;
-	}
-
-	while (f_pos < size) {
-		fi = udf_fileident_read(dir, &f_pos, fibh, cfi, &epos, &eloc,
-					&elen, &offset);
-
-		if (!fi) {
-			*err = -EIO;
-			goto out_err;
-		}
-
-		if ((cfi->fileCharacteristics & FID_FILE_CHAR_DELETED) != 0) {
-			if (udf_dir_entry_len(cfi) == nfidlen) {
-				cfi->descTag.tagSerialNum = cpu_to_le16(1);
-				cfi->fileVersionNum = cpu_to_le16(1);
-				cfi->fileCharacteristics = 0;
-				cfi->lengthFileIdent = namelen;
-				cfi->lengthOfImpUse = cpu_to_le16(0);
-				if (!udf_write_fi(dir, cfi, fi, fibh, NULL,
-						  name))
-					goto out_ok;
-				else {
-					*err = -EIO;
-					goto out_err;
-				}
-			}
-		}
-	}
-
-add:
-	f_pos += nfidlen;
-
-	if (dinfo->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB &&
-	    sb->s_blocksize - fibh->eoffset < nfidlen) {
-		brelse(epos.bh);
-		epos.bh = NULL;
-		fibh->soffset -= udf_ext0_offset(dir);
-		fibh->eoffset -= udf_ext0_offset(dir);
-		f_pos -= udf_ext0_offset(dir);
-		if (fibh->sbh != fibh->ebh)
-			brelse(fibh->ebh);
-		brelse(fibh->sbh);
-		fibh->sbh = fibh->ebh =
-				udf_expand_dir_adinicb(dir, &block, err);
-		if (!fibh->sbh)
-			goto out_err;
-		epos.block = dinfo->i_location;
-		epos.offset = udf_file_entry_alloc_offset(dir);
-		/* Load extent udf_expand_dir_adinicb() has created */
-		udf_current_aext(dir, &epos, &eloc, &elen, 1);
-	}
-
-	/* Entry fits into current block? */
-	if (sb->s_blocksize - fibh->eoffset >= nfidlen) {
-		fibh->soffset = fibh->eoffset;
-		fibh->eoffset += nfidlen;
-		if (fibh->sbh != fibh->ebh) {
-			brelse(fibh->sbh);
-			fibh->sbh = fibh->ebh;
-		}
-
-		if (dinfo->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB) {
-			block = dinfo->i_location.logicalBlockNum;
-			fi = (struct fileIdentDesc *)
-					(dinfo->i_data + fibh->soffset -
-					 udf_ext0_offset(dir) +
-					 dinfo->i_lenEAttr);
-		} else {
-			block = eloc.logicalBlockNum +
-					((elen - 1) >>
-						dir->i_sb->s_blocksize_bits);
-			fi = (struct fileIdentDesc *)
-				(fibh->sbh->b_data + fibh->soffset);
-		}
-	} else {
-		/* Round up last extent in the file */
-		elen = (elen + sb->s_blocksize - 1) & ~(sb->s_blocksize - 1);
-		if (dinfo->i_alloc_type == ICBTAG_FLAG_AD_SHORT)
-			epos.offset -= sizeof(struct short_ad);
-		else if (dinfo->i_alloc_type == ICBTAG_FLAG_AD_LONG)
-			epos.offset -= sizeof(struct long_ad);
-		udf_write_aext(dir, &epos, &eloc, elen, 1);
-		dinfo->i_lenExtents = (dinfo->i_lenExtents + sb->s_blocksize
-					- 1) & ~(sb->s_blocksize - 1);
-
-		fibh->soffset = fibh->eoffset - sb->s_blocksize;
-		fibh->eoffset += nfidlen - sb->s_blocksize;
-		if (fibh->sbh != fibh->ebh) {
-			brelse(fibh->sbh);
-			fibh->sbh = fibh->ebh;
-		}
-
-		block = eloc.logicalBlockNum + ((elen - 1) >>
-						dir->i_sb->s_blocksize_bits);
-		fibh->ebh = udf_bread(dir,
-				f_pos >> dir->i_sb->s_blocksize_bits, 1, err);
-		if (!fibh->ebh)
-			goto out_err;
-		/* Extents could have been merged, invalidate our position */
-		brelse(epos.bh);
-		epos.bh = NULL;
-		epos.block = dinfo->i_location;
-		epos.offset = udf_file_entry_alloc_offset(dir);
-
-		if (!fibh->soffset) {
-			/* Find the freshly allocated block */
-			while (udf_next_aext(dir, &epos, &eloc, &elen, 1) ==
-				(EXT_RECORDED_ALLOCATED >> 30))
-				;
-			block = eloc.logicalBlockNum + ((elen - 1) >>
-					dir->i_sb->s_blocksize_bits);
-			brelse(fibh->sbh);
-			fibh->sbh = fibh->ebh;
-			fi = (struct fileIdentDesc *)(fibh->sbh->b_data);
-		} else {
-			fi = (struct fileIdentDesc *)
-				(fibh->sbh->b_data + sb->s_blocksize +
-					fibh->soffset);
-		}
-	}
-
-	memset(cfi, 0, sizeof(struct fileIdentDesc));
-	if (UDF_SB(sb)->s_udfrev >= 0x0200)
-		udf_new_tag((char *)cfi, TAG_IDENT_FID, 3, 1, block,
-			    sizeof(struct tag));
-	else
-		udf_new_tag((char *)cfi, TAG_IDENT_FID, 2, 1, block,
-			    sizeof(struct tag));
-	cfi->fileVersionNum = cpu_to_le16(1);
-	cfi->lengthFileIdent = namelen;
-	cfi->lengthOfImpUse = cpu_to_le16(0);
-	if (!udf_write_fi(dir, cfi, fi, fibh, NULL, name)) {
-		dir->i_size += nfidlen;
-		if (dinfo->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB)
-			dinfo->i_lenAlloc += nfidlen;
-		else {
-			/* Find the last extent and truncate it to proper size */
-			while (udf_next_aext(dir, &epos, &eloc, &elen, 1) ==
-				(EXT_RECORDED_ALLOCATED >> 30))
-				;
-			elen -= dinfo->i_lenExtents - dir->i_size;
-			if (dinfo->i_alloc_type == ICBTAG_FLAG_AD_SHORT)
-				epos.offset -= sizeof(struct short_ad);
-			else if (dinfo->i_alloc_type == ICBTAG_FLAG_AD_LONG)
-				epos.offset -= sizeof(struct long_ad);
-			udf_write_aext(dir, &epos, &eloc, elen, 1);
-			dinfo->i_lenExtents = dir->i_size;
-		}
-
-		mark_inode_dirty(dir);
-		goto out_ok;
-	} else {
-		*err = -EIO;
-		goto out_err;
-	}
-
-out_err:
-	fi = NULL;
-	if (fibh->sbh != fibh->ebh)
-		brelse(fibh->ebh);
-	brelse(fibh->sbh);
-out_ok:
-	brelse(epos.bh);
-	kfree(name);
-	return fi;
-}
-
 static void udf_fiiter_delete_entry(struct udf_fileident_iter *iter)
 {
 	iter->fi.fileCharacteristics |= FID_FILE_CHAR_DELETED;
@@ -831,18 +338,6 @@ static void udf_fiiter_delete_entry(stru
 	udf_fiiter_write_fi(iter, NULL);
 }
 
-static int udf_delete_entry(struct inode *inode, struct fileIdentDesc *fi,
-			    struct udf_fileident_bh *fibh,
-			    struct fileIdentDesc *cfi)
-{
-	cfi->fileCharacteristics |= FID_FILE_CHAR_DELETED;
-
-	if (UDF_QUERY_FLAG(inode->i_sb, UDF_FLAG_STRICT))
-		memset(&(cfi->icb), 0x00, sizeof(struct long_ad));
-
-	return udf_write_fi(inode, cfi, fi, fibh, NULL, NULL);
-}
-
 static int udf_add_nondir(struct dentry *dentry, struct inode *inode)
 {
 	struct udf_inode_info *iinfo = UDF_I(inode);
--- a/fs/udf/udfdecl.h
+++ b/fs/udf/udfdecl.h
@@ -104,13 +104,6 @@ struct udf_fileident_iter {
 					 */
 };
 
-struct udf_fileident_bh {
-	struct buffer_head *sbh;
-	struct buffer_head *ebh;
-	int soffset;
-	int eoffset;
-};
-
 struct udf_vds_record {
 	uint32_t block;
 	uint32_t volDescSeqNum;
@@ -139,19 +132,12 @@ struct inode *udf_find_metadata_inode_ef
 					u32 meta_file_loc, u32 partition_num);
 
 /* namei.c */
-extern int udf_write_fi(struct inode *inode, struct fileIdentDesc *,
-			struct fileIdentDesc *, struct udf_fileident_bh *,
-			uint8_t *, uint8_t *);
 static inline unsigned int udf_dir_entry_len(struct fileIdentDesc *cfi)
 {
 	return ALIGN(sizeof(struct fileIdentDesc) +
 		le16_to_cpu(cfi->lengthOfImpUse) + cfi->lengthFileIdent,
 		UDF_NAME_PAD);
 }
-static inline uint8_t *udf_get_fi_ident(struct fileIdentDesc *fi)
-{
-	return ((uint8_t *)(fi + 1)) + le16_to_cpu(fi->lengthOfImpUse);
-}
 
 /* file.c */
 extern long udf_ioctl(struct file *, unsigned int, unsigned long);
@@ -266,14 +252,6 @@ void udf_fiiter_release(struct udf_filei
 void udf_fiiter_write_fi(struct udf_fileident_iter *iter, uint8_t *impuse);
 void udf_fiiter_update_elen(struct udf_fileident_iter *iter, uint32_t new_elen);
 int udf_fiiter_append_blk(struct udf_fileident_iter *iter);
-extern struct fileIdentDesc *udf_fileident_read(struct inode *, loff_t *,
-						struct udf_fileident_bh *,
-						struct fileIdentDesc *,
-						struct extent_position *,
-						struct kernel_lb_addr *, uint32_t *,
-						sector_t *);
-extern struct fileIdentDesc *udf_get_fileident(void *buffer, int bufsize,
-					       int *offset);
 extern struct long_ad *udf_get_filelongad(uint8_t *, int, uint32_t *, int);
 extern struct short_ad *udf_get_fileshortad(uint8_t *, int, uint32_t *, int);
 



