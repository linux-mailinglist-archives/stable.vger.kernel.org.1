Return-Path: <stable+bounces-152471-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0510CAD6099
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 23:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 670093AAAD7
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 21:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 944F72BDC05;
	Wed, 11 Jun 2025 21:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DKBrbKll"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4031F4CB7
	for <stable@vger.kernel.org>; Wed, 11 Jun 2025 21:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749675713; cv=none; b=raeFX/umoEMx1qHAMPurTU3RJEEGQKY2AM2CTzp7M/8/NH/b7nlBZ1MAgP3Zy+ShfOr1h7aYM2bEnYMf+L34IjuJTtT0e4Oj19gKFs1vGE+2et+cc6EFgN1/P13eY7aXqWpoSnLuS4CMgZSuuh5AJ3DgbiDpPejBRV0ooS2vl7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749675713; c=relaxed/simple;
	bh=3cYqKyE3rtr5/IoFjzq7Gg+TVLLgiOQBR4jEF5G4l2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WNWulfIPAiGIxy97uf3GaL5O15gp9eDYsTCv7tDL6/CCgFb7lAKlCYZo5x6kEIRvm8C+hbVwH7jQ99EZ3SLJ6h5BAd8JPPioDCFF7mJwDsDMdBX8SmOJcotEeBese1Fi0tTTCtetycCyse+3GTEyaA2r38LGDjJfJGsz4+But9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DKBrbKll; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-23649faf69fso2693155ad.0
        for <stable@vger.kernel.org>; Wed, 11 Jun 2025 14:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749675711; x=1750280511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xzx3cXsGp4lgfaOd6w50l/WGB863lp3UvnbI9//8/rM=;
        b=DKBrbKllOGa1M+6FVQEPOYsqIHWTKoqrEu/iURyyo2h0WLIFaahX9Au++O9h0nmqNL
         beLQ3v0GnzqXfJ9YbILzd7HRocspUtkjqYyKgQTl26a85RJWnVMXbVYj7L+p9Oj+p29h
         YwL+z0Ra+rZA7Md3afhUFPmVnU6mHAO4DNNNH8jRd4zLGOyaS98zfz9jTRa3Zm2mlXwN
         1FGcErZ/mXRd798em8/dPlHur+BVc0byMkjgOaS9WM+cOTOvFR/KcOZcHtk9AXrEjxBB
         Ml4DJwKCBVeqh59oOehnkBzHSyiviy+fsEkTRX7wXmIThNv2JJEzGXcHBoUJgKmjgX4e
         l8tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749675711; x=1750280511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xzx3cXsGp4lgfaOd6w50l/WGB863lp3UvnbI9//8/rM=;
        b=MXAxvtAiWcHDw8hOGqNKgRrkp7+bPcYyC7ZjJBHkRD/L/EqF+kjIOMq5G7xe8AtbAi
         /Kl537iztyjU5ZuEIi6TS1S/wmdwvlvMg6u8x5CRayaD4DhRDhNz4WfbpIUGpcMYQAe/
         YikgEVhtier5nCL5w182BZde3KrFHSm7YGl8KBeztp6dxHdhHh0cs8YUZFvRca5npr8L
         okkKdz2sl3tIWd8pQ4691eY8V8+NPRk2q9xI7RtTNZ/vEbiU79UfquklqvMZ3amABYLr
         hHAxNaSZqfODqSyaZKA8RYt0pSgT4+pHFUt63rBkj0H8DbgK5H0raKa0XRODfvLtNWFU
         UHBQ==
X-Gm-Message-State: AOJu0YxHYyLruVd+saiElI7QLkVMGElmZ8c+YNK2kjC669eWQN6tda5W
	dbXlT2uWRKNpzgs/+o6peGM1SLygtMjj9mokv7SJtWDvIdxOuo667OhtVDjr6qTE
X-Gm-Gg: ASbGncsg/mZxMO8fh6B0U9S/Izka4GwV8c9YNnq8n+CTmDsAkkuwAM4Yu8bbq82uwIB
	KaZQZCNa6COC8xBA8prkxJoy0K4+fS2DUtslLeuGoQO5SVNxkOf/XW4KOUZ8LxSMaKg7EAOfbou
	qNYRSjsibqKCSCKIi4fMdPdbepUMCXMB4sUJk//5/SffHY5PiRPYD5yfdE/ovc4xG9llZL84/23
	fQ0EKprZHt9ip8pxD8AE5UzmA4YH1cy8lXgc6q0hYfOCRoGaK4ULGEqox2GLZ3ls8bJALPgsn3Q
	Cb8RXiDZ3zP1pXpc9V1U+tMHnSifRq088mVRn8OQnC2govVuSxIxcmTwTaHH6fpKZ078wjPicCu
	dxlVi44ZEriw=
X-Google-Smtp-Source: AGHT+IFGtnuVg4hpCEh/SUlPssgP2ZDjMxoKAQO/5U0hhEwAwxtsMMvFQ3inf1o+UGq6Q4SBPrLVNw==
X-Received: by 2002:a17:903:3bc5:b0:235:2375:7eaa with SMTP id d9443c01a7336-2364d6605a0mr9414045ad.22.1749675710992;
        Wed, 11 Jun 2025 14:01:50 -0700 (PDT)
Received: from lrumancik.svl.corp.google.com ([2620:15c:2c5:11:391:76ae:2143:7d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2364e6d9c86sm62005ad.101.2025.06.11.14.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 14:01:50 -0700 (PDT)
From: Leah Rumancik <leah.rumancik@gmail.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev,
	chandan.babu@oracle.com,
	catherine.hoang@oracle.com,
	djwong@kernel.org,
	Julian Sun <sunjunchao2870@gmail.com>,
	Chandan Babu R <chandanbabu@kernel.org>,
	Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH 6.1 17/23] xfs: remove unused parameter in macro XFS_DQUOT_LOGRES
Date: Wed, 11 Jun 2025 14:01:21 -0700
Message-ID: <20250611210128.67687-18-leah.rumancik@gmail.com>
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
In-Reply-To: <20250611210128.67687-1-leah.rumancik@gmail.com>
References: <20250611210128.67687-1-leah.rumancik@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Julian Sun <sunjunchao2870@gmail.com>

[ Upstream commit af5d92f2fad818663da2ce073b6fe15b9d56ffdc ]

In the macro definition of XFS_DQUOT_LOGRES, a parameter is accepted,
but it is not used. Hence, it should be removed.

This patch has only passed compilation test, but it should be fine.

Signed-off-by: Julian Sun <sunjunchao2870@gmail.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
Acked-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_quota_defs.h |  2 +-
 fs/xfs/libxfs/xfs_trans_resv.c | 28 ++++++++++++++--------------
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_quota_defs.h b/fs/xfs/libxfs/xfs_quota_defs.h
index cb035da3f990..fb05f44f6c75 100644
--- a/fs/xfs/libxfs/xfs_quota_defs.h
+++ b/fs/xfs/libxfs/xfs_quota_defs.h
@@ -54,11 +54,11 @@ typedef uint8_t		xfs_dqtype_t;
  * dquots can be unique and so 6 dquots can be modified....
  *
  * And, of course, we also need to take into account the dquot log format item
  * used to describe each dquot.
  */
-#define XFS_DQUOT_LOGRES(mp)	\
+#define XFS_DQUOT_LOGRES	\
 	((sizeof(struct xfs_dq_logformat) + sizeof(struct xfs_disk_dquot)) * 6)
 
 #define XFS_IS_QUOTA_ON(mp)		((mp)->m_qflags & XFS_ALL_QUOTA_ACCT)
 #define XFS_IS_UQUOTA_ON(mp)		((mp)->m_qflags & XFS_UQUOTA_ACCT)
 #define XFS_IS_PQUOTA_ON(mp)		((mp)->m_qflags & XFS_PQUOTA_ACCT)
diff --git a/fs/xfs/libxfs/xfs_trans_resv.c b/fs/xfs/libxfs/xfs_trans_resv.c
index 5b2f27cbdb80..1bb2891b26ff 100644
--- a/fs/xfs/libxfs/xfs_trans_resv.c
+++ b/fs/xfs/libxfs/xfs_trans_resv.c
@@ -332,15 +332,15 @@ xfs_calc_write_reservation(
 			adj = xfs_calc_buf_res(
 					xfs_refcountbt_block_count(mp, 2),
 					blksz);
 		t1 += adj;
 		t3 += adj;
-		return XFS_DQUOT_LOGRES(mp) + max3(t1, t2, t3);
+		return XFS_DQUOT_LOGRES + max3(t1, t2, t3);
 	}
 
 	t4 = xfs_calc_refcountbt_reservation(mp, 1);
-	return XFS_DQUOT_LOGRES(mp) + max(t4, max3(t1, t2, t3));
+	return XFS_DQUOT_LOGRES + max(t4, max3(t1, t2, t3));
 }
 
 unsigned int
 xfs_calc_write_reservation_minlogsize(
 	struct xfs_mount	*mp)
@@ -404,41 +404,41 @@ xfs_calc_itruncate_reservation(
 		if (xfs_has_reflink(mp))
 			t2 += xfs_calc_buf_res(
 					xfs_refcountbt_block_count(mp, 4),
 					blksz);
 
-		return XFS_DQUOT_LOGRES(mp) + max3(t1, t2, t3);
+		return XFS_DQUOT_LOGRES + max3(t1, t2, t3);
 	}
 
 	t4 = xfs_calc_refcountbt_reservation(mp, 2);
-	return XFS_DQUOT_LOGRES(mp) + max(t4, max3(t1, t2, t3));
+	return XFS_DQUOT_LOGRES + max(t4, max3(t1, t2, t3));
 }
 
 unsigned int
 xfs_calc_itruncate_reservation_minlogsize(
 	struct xfs_mount	*mp)
 {
 	return xfs_calc_itruncate_reservation(mp, true);
 }
 
 /*
  * In renaming a files we can modify:
  *    the five inodes involved: 5 * inode size
  *    the two directory btrees: 2 * (max depth + v2) * dir block size
  *    the two directory bmap btrees: 2 * max depth * block size
  * And the bmap_finish transaction can free dir and bmap blocks (two sets
  *	of bmap blocks) giving:
  *    the agf for the ags in which the blocks live: 3 * sector size
  *    the agfl for the ags in which the blocks live: 3 * sector size
  *    the superblock for the free block count: sector size
  *    the allocation btrees: 3 exts * 2 trees * (2 * max depth - 1) * block size
  */
 STATIC uint
 xfs_calc_rename_reservation(
 	struct xfs_mount	*mp)
 {
-	return XFS_DQUOT_LOGRES(mp) +
+	return XFS_DQUOT_LOGRES +
 		max((xfs_calc_inode_res(mp, 5) +
 		     xfs_calc_buf_res(2 * XFS_DIROP_LOG_COUNT(mp),
 				      XFS_FSB_TO_B(mp, 1))),
 		    (xfs_calc_buf_res(7, mp->m_sb.sb_sectsize) +
 		     xfs_calc_buf_res(xfs_allocfree_block_count(mp, 3),
@@ -473,11 +473,11 @@ xfs_calc_iunlink_remove_reservation(
  */
 STATIC uint
 xfs_calc_link_reservation(
 	struct xfs_mount	*mp)
 {
-	return XFS_DQUOT_LOGRES(mp) +
+	return XFS_DQUOT_LOGRES +
 		xfs_calc_iunlink_remove_reservation(mp) +
 		max((xfs_calc_inode_res(mp, 2) +
 		     xfs_calc_buf_res(XFS_DIROP_LOG_COUNT(mp),
 				      XFS_FSB_TO_B(mp, 1))),
 		    (xfs_calc_buf_res(3, mp->m_sb.sb_sectsize) +
@@ -511,11 +511,11 @@ xfs_calc_iunlink_add_reservation(xfs_mount_t *mp)
  */
 STATIC uint
 xfs_calc_remove_reservation(
 	struct xfs_mount	*mp)
 {
-	return XFS_DQUOT_LOGRES(mp) +
+	return XFS_DQUOT_LOGRES +
 		xfs_calc_iunlink_add_reservation(mp) +
 		max((xfs_calc_inode_res(mp, 2) +
 		     xfs_calc_buf_res(XFS_DIROP_LOG_COUNT(mp),
 				      XFS_FSB_TO_B(mp, 1))),
 		    (xfs_calc_buf_res(4, mp->m_sb.sb_sectsize) +
@@ -570,20 +570,20 @@ xfs_calc_icreate_resv_alloc(
 }
 
 STATIC uint
 xfs_calc_icreate_reservation(xfs_mount_t *mp)
 {
-	return XFS_DQUOT_LOGRES(mp) +
+	return XFS_DQUOT_LOGRES +
 		max(xfs_calc_icreate_resv_alloc(mp),
 		    xfs_calc_create_resv_modify(mp));
 }
 
 STATIC uint
 xfs_calc_create_tmpfile_reservation(
 	struct xfs_mount        *mp)
 {
-	uint	res = XFS_DQUOT_LOGRES(mp);
+	uint	res = XFS_DQUOT_LOGRES;
 
 	res += xfs_calc_icreate_resv_alloc(mp);
 	return res + xfs_calc_iunlink_add_reservation(mp);
 }
 
@@ -628,28 +628,28 @@ xfs_calc_symlink_reservation(
  */
 STATIC uint
 xfs_calc_ifree_reservation(
 	struct xfs_mount	*mp)
 {
-	return XFS_DQUOT_LOGRES(mp) +
+	return XFS_DQUOT_LOGRES +
 		xfs_calc_inode_res(mp, 1) +
 		xfs_calc_buf_res(3, mp->m_sb.sb_sectsize) +
 		xfs_calc_iunlink_remove_reservation(mp) +
 		xfs_calc_inode_chunk_res(mp, _FREE) +
 		xfs_calc_inobt_res(mp) +
 		xfs_calc_finobt_res(mp);
 }
 
 /*
  * When only changing the inode we log the inode and possibly the superblock
  * We also add a bit of slop for the transaction stuff.
  */
 STATIC uint
 xfs_calc_ichange_reservation(
 	struct xfs_mount	*mp)
 {
-	return XFS_DQUOT_LOGRES(mp) +
+	return XFS_DQUOT_LOGRES +
 		xfs_calc_inode_res(mp, 1) +
 		xfs_calc_buf_res(1, mp->m_sb.sb_sectsize);
 
 }
 
@@ -754,11 +754,11 @@ xfs_calc_writeid_reservation(
  */
 STATIC uint
 xfs_calc_addafork_reservation(
 	struct xfs_mount	*mp)
 {
-	return XFS_DQUOT_LOGRES(mp) +
+	return XFS_DQUOT_LOGRES +
 		xfs_calc_inode_res(mp, 1) +
 		xfs_calc_buf_res(2, mp->m_sb.sb_sectsize) +
 		xfs_calc_buf_res(1, mp->m_dir_geo->blksize) +
 		xfs_calc_buf_res(XFS_DAENTER_BMAP1B(mp, XFS_DATA_FORK) + 1,
 				 XFS_FSB_TO_B(mp, 1)) +
@@ -802,11 +802,11 @@ xfs_calc_attrinval_reservation(
  */
 STATIC uint
 xfs_calc_attrsetm_reservation(
 	struct xfs_mount	*mp)
 {
-	return XFS_DQUOT_LOGRES(mp) +
+	return XFS_DQUOT_LOGRES +
 		xfs_calc_inode_res(mp, 1) +
 		xfs_calc_buf_res(1, mp->m_sb.sb_sectsize) +
 		xfs_calc_buf_res(XFS_DA_NODE_MAXDEPTH, XFS_FSB_TO_B(mp, 1));
 }
 
@@ -842,11 +842,11 @@ xfs_calc_attrsetrt_reservation(
  */
 STATIC uint
 xfs_calc_attrrm_reservation(
 	struct xfs_mount	*mp)
 {
-	return XFS_DQUOT_LOGRES(mp) +
+	return XFS_DQUOT_LOGRES +
 		max((xfs_calc_inode_res(mp, 1) +
 		     xfs_calc_buf_res(XFS_DA_NODE_MAXDEPTH,
 				      XFS_FSB_TO_B(mp, 1)) +
 		     (uint)XFS_FSB_TO_B(mp,
 					XFS_BM_MAXLEVELS(mp, XFS_ATTR_FORK)) +
-- 
2.50.0.rc1.591.g9c95f17f64-goog


