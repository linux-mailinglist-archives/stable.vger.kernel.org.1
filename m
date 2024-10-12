Return-Path: <stable+bounces-83521-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE0CB99B378
	for <lists+stable@lfdr.de>; Sat, 12 Oct 2024 13:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9FC4B22B39
	for <lists+stable@lfdr.de>; Sat, 12 Oct 2024 11:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97FDB156C69;
	Sat, 12 Oct 2024 11:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uQPj3HUy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CAE197A6A;
	Sat, 12 Oct 2024 11:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728732394; cv=none; b=s1OE0AelsI42xI/G3HxgxxC/RDANoOCDcBILCOKLvlL4xHrpdL1T3uc3UlzZwCPAHdx8h6o5f7ksQfGBVDupm5Ccs74npDPNlWbbTXaBnj+/N0zHnz0DiSuCwKsR/9Qz9WBxXnHO9vdTCjiW/3Cq6n6NHuSeLbLoXXts7Q1nfjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728732394; c=relaxed/simple;
	bh=zxAKMMdIqxL9YefAm6u+AhtgLghb/GgZUPvtgFgmYsg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WEPbLqYx2DF4tS1HQjxjAcYSf6GPPunUPmH63tZsDtRev2vWGG+UpNW5Y4d1VQRN6M3y8xgZePVuzzmX+no8gjH4V/MWqvD+VpEpdbf3yqgWvfzgDkNdiKpb8AqIJOthpQpD6LwkN8QoGiX4dVx4YysHKVF7WxIrpzQoFVvPz6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uQPj3HUy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73B4FC4CEC6;
	Sat, 12 Oct 2024 11:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728732394;
	bh=zxAKMMdIqxL9YefAm6u+AhtgLghb/GgZUPvtgFgmYsg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uQPj3HUyJFyj+Xe67FB1CETT2UWQTk4xcyXiHrpozkEV0x1opvfWLHRfBGG/ETwKQ
	 wNj4DaGSTgHRMq9vvr7lq2WEy4l+vHI8PuawiWQ16o1SxnnKqQqTsNigOhkeC56eSR
	 tUAvtx9cEtOaevldtK2WB2GupkKUIt7MiguIFgeq7vD35mUDmwv3h2zqtWnw7BzFm9
	 kWSdVgsvmPrg/DO5durUZB6I31fhPFwhB2XNyICDo/B2UZLi8BjpCpEC/LxbBUyjNn
	 UNI9u+VRr+9Jl4EMpEyenUO1Z7NIyCXlwuh2BjgJWODpySINvygAfOBM2QTlvIf1kA
	 G8OXwbpkQRplg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhao Mengmeng <zhaomengmeng@kylinos.cn>,
	Jan Kara <jack@suse.cz>,
	Sasha Levin <sashal@kernel.org>,
	jack@suse.com
Subject: [PATCH AUTOSEL 6.11 07/16] udf: refactor udf_current_aext() to handle error
Date: Sat, 12 Oct 2024 07:26:03 -0400
Message-ID: <20241012112619.1762860-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241012112619.1762860-1-sashal@kernel.org>
References: <20241012112619.1762860-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.3
Content-Transfer-Encoding: 8bit

From: Zhao Mengmeng <zhaomengmeng@kylinos.cn>

[ Upstream commit ee703a7068f95764cfb62b57db1d36e465cb9b26 ]

As Jan suggested in links below, refactor udf_current_aext() to
differentiate between error, hit EOF and success, it now takes pointer to
etype to store the extent type, return 1 when getting etype success,
return 0 when hitting EOF and return -errno when err.

Link: https://lore.kernel.org/all/20240912111235.6nr3wuqvktecy3vh@quack3/
Signed-off-by: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Jan Kara <jack@suse.cz>
Link: https://patch.msgid.link/20241001115425.266556-2-zhaomzhao@126.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/udf/inode.c    | 40 ++++++++++++++++++++++++++--------------
 fs/udf/truncate.c | 10 ++++++++--
 fs/udf/udfdecl.h  |  5 +++--
 3 files changed, 37 insertions(+), 18 deletions(-)

diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index 4726a4d014b60..c64c2eff3399a 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -1955,6 +1955,7 @@ int udf_setup_indirect_aext(struct inode *inode, udf_pblk_t block,
 	struct extent_position nepos;
 	struct kernel_lb_addr neloc;
 	int ver, adsize;
+	int err = 0;
 
 	if (UDF_I(inode)->i_alloc_type == ICBTAG_FLAG_AD_SHORT)
 		adsize = sizeof(struct short_ad);
@@ -1999,10 +2000,12 @@ int udf_setup_indirect_aext(struct inode *inode, udf_pblk_t block,
 	if (epos->offset + adsize > sb->s_blocksize) {
 		struct kernel_lb_addr cp_loc;
 		uint32_t cp_len;
-		int cp_type;
+		int8_t cp_type;
 
 		epos->offset -= adsize;
-		cp_type = udf_current_aext(inode, epos, &cp_loc, &cp_len, 0);
+		err = udf_current_aext(inode, epos, &cp_loc, &cp_len, &cp_type, 0);
+		if (err <= 0)
+			goto err_out;
 		cp_len |= ((uint32_t)cp_type) << 30;
 
 		__udf_add_aext(inode, &nepos, &cp_loc, cp_len, 1);
@@ -2017,6 +2020,9 @@ int udf_setup_indirect_aext(struct inode *inode, udf_pblk_t block,
 	*epos = nepos;
 
 	return 0;
+err_out:
+	brelse(bh);
+	return err;
 }
 
 /*
@@ -2167,9 +2173,12 @@ int8_t udf_next_aext(struct inode *inode, struct extent_position *epos,
 {
 	int8_t etype;
 	unsigned int indirections = 0;
+	int ret = 0;
 
-	while ((etype = udf_current_aext(inode, epos, eloc, elen, inc)) ==
-	       (EXT_NEXT_EXTENT_ALLOCDESCS >> 30)) {
+	while ((ret = udf_current_aext(inode, epos, eloc, elen,
+				       &etype, inc)) > 0) {
+		if (etype != (EXT_NEXT_EXTENT_ALLOCDESCS >> 30))
+			break;
 		udf_pblk_t block;
 
 		if (++indirections > UDF_MAX_INDIR_EXTS) {
@@ -2190,14 +2199,17 @@ int8_t udf_next_aext(struct inode *inode, struct extent_position *epos,
 		}
 	}
 
-	return etype;
+	return ret > 0 ? etype : -1;
 }
 
-int8_t udf_current_aext(struct inode *inode, struct extent_position *epos,
-			struct kernel_lb_addr *eloc, uint32_t *elen, int inc)
+/*
+ * Returns 1 on success, -errno on error, 0 on hit EOF.
+ */
+int udf_current_aext(struct inode *inode, struct extent_position *epos,
+		     struct kernel_lb_addr *eloc, uint32_t *elen, int8_t *etype,
+		     int inc)
 {
 	int alen;
-	int8_t etype;
 	uint8_t *ptr;
 	struct short_ad *sad;
 	struct long_ad *lad;
@@ -2224,8 +2236,8 @@ int8_t udf_current_aext(struct inode *inode, struct extent_position *epos,
 	case ICBTAG_FLAG_AD_SHORT:
 		sad = udf_get_fileshortad(ptr, alen, &epos->offset, inc);
 		if (!sad)
-			return -1;
-		etype = le32_to_cpu(sad->extLength) >> 30;
+			return 0;
+		*etype = le32_to_cpu(sad->extLength) >> 30;
 		eloc->logicalBlockNum = le32_to_cpu(sad->extPosition);
 		eloc->partitionReferenceNum =
 				iinfo->i_location.partitionReferenceNum;
@@ -2234,17 +2246,17 @@ int8_t udf_current_aext(struct inode *inode, struct extent_position *epos,
 	case ICBTAG_FLAG_AD_LONG:
 		lad = udf_get_filelongad(ptr, alen, &epos->offset, inc);
 		if (!lad)
-			return -1;
-		etype = le32_to_cpu(lad->extLength) >> 30;
+			return 0;
+		*etype = le32_to_cpu(lad->extLength) >> 30;
 		*eloc = lelb_to_cpu(lad->extLocation);
 		*elen = le32_to_cpu(lad->extLength) & UDF_EXTENT_LENGTH_MASK;
 		break;
 	default:
 		udf_debug("alloc_type = %u unsupported\n", iinfo->i_alloc_type);
-		return -1;
+		return -EINVAL;
 	}
 
-	return etype;
+	return 1;
 }
 
 static int udf_insert_aext(struct inode *inode, struct extent_position epos,
diff --git a/fs/udf/truncate.c b/fs/udf/truncate.c
index a686c10fd709d..4758ba7b5f51c 100644
--- a/fs/udf/truncate.c
+++ b/fs/udf/truncate.c
@@ -188,6 +188,7 @@ int udf_truncate_extents(struct inode *inode)
 	loff_t byte_offset;
 	int adsize;
 	struct udf_inode_info *iinfo = UDF_I(inode);
+	int ret = 0;
 
 	if (iinfo->i_alloc_type == ICBTAG_FLAG_AD_SHORT)
 		adsize = sizeof(struct short_ad);
@@ -217,8 +218,8 @@ int udf_truncate_extents(struct inode *inode)
 	else
 		lenalloc -= sizeof(struct allocExtDesc);
 
-	while ((etype = udf_current_aext(inode, &epos, &eloc,
-					 &elen, 0)) != -1) {
+	while ((ret = udf_current_aext(inode, &epos, &eloc,
+				       &elen, &etype, 0)) > 0) {
 		if (etype == (EXT_NEXT_EXTENT_ALLOCDESCS >> 30)) {
 			udf_write_aext(inode, &epos, &neloc, nelen, 0);
 			if (indirect_ext_len) {
@@ -253,6 +254,11 @@ int udf_truncate_extents(struct inode *inode)
 		}
 	}
 
+	if (ret < 0) {
+		brelse(epos.bh);
+		return ret;
+	}
+
 	if (indirect_ext_len) {
 		BUG_ON(!epos.bh);
 		udf_free_blocks(sb, NULL, &epos.block, 0, indirect_ext_len);
diff --git a/fs/udf/udfdecl.h b/fs/udf/udfdecl.h
index 88692512a4668..d893db95ac70e 100644
--- a/fs/udf/udfdecl.h
+++ b/fs/udf/udfdecl.h
@@ -171,8 +171,9 @@ extern void udf_write_aext(struct inode *, struct extent_position *,
 extern int8_t udf_delete_aext(struct inode *, struct extent_position);
 extern int8_t udf_next_aext(struct inode *, struct extent_position *,
 			    struct kernel_lb_addr *, uint32_t *, int);
-extern int8_t udf_current_aext(struct inode *, struct extent_position *,
-			       struct kernel_lb_addr *, uint32_t *, int);
+extern int udf_current_aext(struct inode *inode, struct extent_position *epos,
+			    struct kernel_lb_addr *eloc, uint32_t *elen,
+			    int8_t *etype, int inc);
 extern void udf_update_extra_perms(struct inode *inode, umode_t mode);
 
 /* misc.c */
-- 
2.43.0


