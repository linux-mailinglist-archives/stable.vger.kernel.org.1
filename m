Return-Path: <stable+bounces-86699-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C96A9A2E5D
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 22:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31FBA284252
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 20:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 036F1227BA8;
	Thu, 17 Oct 2024 20:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Fa/pqzo9"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348761DE2B2
	for <stable@vger.kernel.org>; Thu, 17 Oct 2024 20:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729196441; cv=none; b=MwgnmVOYoeAzyhUzRLyK9SkM48wMONWB2PM7xIN9lthNZHU4CgIO8bjz2UN7WGyYhzryd41bj9wXBYW/PKSjUQ8o93ZcSfIT+b9bvRbb7yF5ez5/m/MvQLXZ8AzsPlU/UAf5q3MpawZ2G9moF7Fi3CWpUqCX6t9pCvIH+HUM7xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729196441; c=relaxed/simple;
	bh=OPiyJI188/3knrQOeQCB6fHmGEtuhXrxOeUmu96vHe0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DC9xvL3wGmCmgjPjXhqTfE32LYTx1DS8I31WlC5WcYTFG/PNCNzlWrms4W9KFg/Q4eu9IG2F04Dn3OoS33uTzSZ7bzqOkz31aDfYw5I2/hfWND0K3f99loVRysPuoGtCf7m+zN/BqCU34DiAykCABUWxKkn/GqzZjPorq7xtGvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Fa/pqzo9; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=jufiyhSbB4Nt68z53bu0e207bKpaJhvEFkVlSkp+nJk=; b=Fa/pqzo9PBRH7TSRw0joUWfU7E
	uYvJqFyPedCWXdAlgpvq3aXNCEl8vB5QTH59RunhrpWZgx5KmfOuTT8Ef0RSg2/Kd2raVYd6hPD4v
	QJYyDQt1AZ1vVdmS9glcTevrl5RPWd+mqeOl+UblhE4OHbS0Gjew3N3D1T9MzkDrFRX/qoBoGMU4J
	VDxGYNRDEUUmKZ6dcyFG74OVFUmYtKi/mdHkwJlHTZXUQvo+TcZhO8GriiWjiN7CkQvms3YFbWQ9v
	f/uDgk41b+EDUBZ/ZF8sqAeOmC399otffH5gsfHDR7ClAfNmu2mEmGavyKhlViMxdUiDtcMHkwnxU
	450xuTJA==;
Received: from 179-125-64-237-dinamico.pombonet.net.br ([179.125.64.237] helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1t1Wz3-00BmZ7-Vk; Thu, 17 Oct 2024 22:20:34 +0200
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: stable@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	kernel-dev@igalia.com,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: [PATCH 5.15 10/20] udf: Convert empty_dir() to new directory iteration code
Date: Thu, 17 Oct 2024 17:19:52 -0300
Message-Id: <20241017202002.406428-11-cascardo@igalia.com>
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

[ Upstream commit afb525f466f9fdc140b975221cb43fbb5c59314e ]

Convert empty_dir() to new directory iteration code.

Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 fs/udf/namei.c | 68 +++++++-------------------------------------------
 1 file changed, 9 insertions(+), 59 deletions(-)

diff --git a/fs/udf/namei.c b/fs/udf/namei.c
index bc847e709fe6..d73870371766 100644
--- a/fs/udf/namei.c
+++ b/fs/udf/namei.c
@@ -879,69 +879,19 @@ static int udf_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
 
 static int empty_dir(struct inode *dir)
 {
-	struct fileIdentDesc *fi, cfi;
-	struct udf_fileident_bh fibh;
-	loff_t f_pos;
-	loff_t size = udf_ext0_offset(dir) + dir->i_size;
-	udf_pblk_t block;
-	struct kernel_lb_addr eloc;
-	uint32_t elen;
-	sector_t offset;
-	struct extent_position epos = {};
-	struct udf_inode_info *dinfo = UDF_I(dir);
-
-	f_pos = udf_ext0_offset(dir);
-	fibh.soffset = fibh.eoffset = f_pos & (dir->i_sb->s_blocksize - 1);
-
-	if (dinfo->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB)
-		fibh.sbh = fibh.ebh = NULL;
-	else if (inode_bmap(dir, f_pos >> dir->i_sb->s_blocksize_bits,
-			      &epos, &eloc, &elen, &offset) ==
-					(EXT_RECORDED_ALLOCATED >> 30)) {
-		block = udf_get_lb_pblock(dir->i_sb, &eloc, offset);
-		if ((++offset << dir->i_sb->s_blocksize_bits) < elen) {
-			if (dinfo->i_alloc_type == ICBTAG_FLAG_AD_SHORT)
-				epos.offset -= sizeof(struct short_ad);
-			else if (dinfo->i_alloc_type == ICBTAG_FLAG_AD_LONG)
-				epos.offset -= sizeof(struct long_ad);
-		} else
-			offset = 0;
-
-		fibh.sbh = fibh.ebh = udf_tread(dir->i_sb, block);
-		if (!fibh.sbh) {
-			brelse(epos.bh);
-			return 0;
-		}
-	} else {
-		brelse(epos.bh);
-		return 0;
-	}
-
-	while (f_pos < size) {
-		fi = udf_fileident_read(dir, &f_pos, &fibh, &cfi, &epos, &eloc,
-					&elen, &offset);
-		if (!fi) {
-			if (fibh.sbh != fibh.ebh)
-				brelse(fibh.ebh);
-			brelse(fibh.sbh);
-			brelse(epos.bh);
-			return 0;
-		}
+	struct udf_fileident_iter iter;
+	int ret;
 
-		if (cfi.lengthFileIdent &&
-		    (cfi.fileCharacteristics & FID_FILE_CHAR_DELETED) == 0) {
-			if (fibh.sbh != fibh.ebh)
-				brelse(fibh.ebh);
-			brelse(fibh.sbh);
-			brelse(epos.bh);
+	for (ret = udf_fiiter_init(&iter, dir, 0);
+	     !ret && iter.pos < dir->i_size;
+	     ret = udf_fiiter_advance(&iter)) {
+		if (iter.fi.lengthFileIdent &&
+		    !(iter.fi.fileCharacteristics & FID_FILE_CHAR_DELETED)) {
+			udf_fiiter_release(&iter);
 			return 0;
 		}
 	}
-
-	if (fibh.sbh != fibh.ebh)
-		brelse(fibh.ebh);
-	brelse(fibh.sbh);
-	brelse(epos.bh);
+	udf_fiiter_release(&iter);
 
 	return 1;
 }
-- 
2.34.1


