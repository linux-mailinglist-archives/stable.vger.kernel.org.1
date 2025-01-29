Return-Path: <stable+bounces-111213-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A63F2A2242F
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 19:47:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CCA81885998
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 18:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221B01E2312;
	Wed, 29 Jan 2025 18:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kS8otByE"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5211C1E0E0D
	for <stable@vger.kernel.org>; Wed, 29 Jan 2025 18:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738176454; cv=none; b=Cw85M7ionMDi1U+pQ1x5dA4XMDifTarTLZOVl0mdgdFvSnMeHnx7Jd9et+IzYB8qBn1h+yZOF/6+XQq1rTzuI3HtJU7jI/Xqal3tj0OtjqyDtCYABcmWvOqpYMs1D3kXhAX3uHWVLx2FYNevAma8egj/Ha0YRw2Ds1AjXns109E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738176454; c=relaxed/simple;
	bh=UbMZLyPFinpak3iINRkfyJec6VsG8vXCuuq1TVCIfJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dHIpC0tZCJsS0Q9w2fJ1WMVK3IfEYj4qxNBQ0BdAUWJgyw2aDw8yq/VgL3lRzYVceXCXWhIL95ns66IDkUy7r7YI6ZfNzHZrWeC/4CHineowOPfsgVaGI+w06vdC9DM3a6He5psjheAlhhzOaOydbWqbg3bLwF/drBdIBx4QlaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kS8otByE; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21619108a6bso125574765ad.3
        for <stable@vger.kernel.org>; Wed, 29 Jan 2025 10:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738176452; x=1738781252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eIcKhJ/qftP4WM7OOaMuiMGX8iNhVvixJeWIn/UeREY=;
        b=kS8otByE5GWJNGBFskKGvzQvbYL5Bo9OcZD56ob8DAdBp9ki9IA4D8D4ahr0ptLCke
         WheFbAnTYMEAt/3fRtfusX53m28WQvyVFZ5HYx4lsjd4xBoxPgkuiEioEpAv7xE4iNHH
         0vwdmRE/7WQUa8+MqTBoUYHouMV39wLK/0fjXGbYSEGBZ0Dskv03WaWef6FFmlKro8XI
         slzEJO3E8LXShlC0v6Uq2BPU/axfxnKoQbjyZJNLh4GqXY9czXlAw9YwOMwHuRqB5DmZ
         IjVuopJcIEpDbsG51/GQQ0LZgQ4FGM+4UV30842EhkL/HIeU1SRkFOb9ysH4DhzsVQcR
         S46w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738176452; x=1738781252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eIcKhJ/qftP4WM7OOaMuiMGX8iNhVvixJeWIn/UeREY=;
        b=t1VVv8U1ST390PHWu6dq9kEPNd07XbhPXcrl4a7VXpu5Q9YL71kv05Tk4asg6gQwcc
         dvhtW02LwZoIhKlmmcsqGF7aw9ZZH5ZuAPgJnXFNzwbJsgzX+RVyD12lkL8RrQ00VLG6
         g3d3Cs0NMolaK17hDfjGbuAmMFKsoO40TJCc+Hagb5igKxrFAFH8ZzjamJiJ6UnsL6an
         7DjxFMv2IVkUZCAVRT7cUv/JNCqp9As2rjWvF9Qa5VfNPqGwFNTn/CFL7SDKp7L4jxw8
         vebZxTROOu8XtqM/GXofD42AwyqswToE0Exzodasvt65e8BpntS5CiZ1f318lBAQ2ZeD
         C7Pw==
X-Gm-Message-State: AOJu0YxtKmVoRj9N9XqPN3sufmsxcSzg6KZ0PVd+SZkgWf5CqBHJU6yh
	c6wGtn+Wzut1eUlkKhoL6+lgeVtauq3c5mJ4qjII5/f+u7RAWSI8CVt0NA==
X-Gm-Gg: ASbGncugJ4oEdCEMltZwEwVBHCnwbkxQdEzU4aVfbOi60+zT1GXhHtTvAhGXyKGRT4h
	NPx46BvjwvjNmhNXWbcqKDcNTrA+XGM8I92/VV41BzIKtPlF/n7cV/McNWlgIpzK67wSn3h5QaF
	MaBz8wr3RvFfYESCnCA65hnU4e9CK6g5c0B6LVv0tPv+PMTUar9XMJM64mRDRicq3sttEy0PZ0/
	LDvAgAvfHQohoukz1KG9y4dUK4Nxwadq3DcwZ/PLwjIpu7nBOv41hpBaPBW4zevuha9vBaRNBGe
	IJHcl8tkOSil/ewG9E6l5eI/sh4iFPXPwKoSaexeEr8=
X-Google-Smtp-Source: AGHT+IFKuhdxsO0xMjQ/oZGIVVqmZxAbRDb7iZgu4JVZ5X5uFa3M0EiPozwx20ze6j2DLkFdSVnW9A==
X-Received: by 2002:a17:902:da86:b0:215:6b4c:89fa with SMTP id d9443c01a7336-21dd7c4e3aamr49263575ad.8.1738176452288;
        Wed, 29 Jan 2025 10:47:32 -0800 (PST)
Received: from lrumancik.svl.corp.google.com ([2620:15c:2c5:11:fbc6:64ef:cffe:1cc8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da414151fsm103248795ad.121.2025.01.29.10.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 10:47:31 -0800 (PST)
From: Leah Rumancik <leah.rumancik@gmail.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev,
	amir73il@gmail.com,
	chandan.babu@oracle.com,
	catherine.hoang@oracle.com,
	"Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH 6.1 02/19] xfs: hoist freeing of rt data fork extent mappings
Date: Wed, 29 Jan 2025 10:47:00 -0800
Message-ID: <20250129184717.80816-3-leah.rumancik@gmail.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
In-Reply-To: <20250129184717.80816-1-leah.rumancik@gmail.com>
References: <20250129184717.80816-1-leah.rumancik@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Darrick J. Wong" <djwong@kernel.org>

[ Upstream commit 6c664484337b37fa0cf6e958f4019623e30d40f7 ]

Currently, xfs_bmap_del_extent_real contains a bunch of code to convert
the physical extent of a data fork mapping for a realtime file into rt
extents and pass that to the rt extent freeing function.  Since the
details of this aren't needed when CONFIG_XFS_REALTIME=n, move it to
xfs_rtbitmap.c to reduce code size when realtime isn't enabled.

This will (one day) enable realtime EFIs to reuse the same
unit-converting call with less code duplication.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
---
 fs/xfs/libxfs/xfs_bmap.c     | 19 +++----------------
 fs/xfs/libxfs/xfs_rtbitmap.c | 33 +++++++++++++++++++++++++++++++++
 fs/xfs/xfs_rtalloc.h         |  5 +++++
 3 files changed, 41 insertions(+), 16 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
index 9dc33cdc2ab9..d45a2e681f93 100644
--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -5035,37 +5035,24 @@ xfs_bmap_del_extent_real(
 	    del->br_startoff > got.br_startoff && del_endoff < got_endoff)
 		return -ENOSPC;
 
 	flags = XFS_ILOG_CORE;
 	if (whichfork == XFS_DATA_FORK && XFS_IS_REALTIME_INODE(ip)) {
-		xfs_filblks_t	len;
-		xfs_extlen_t	mod;
-
-		len = div_u64_rem(del->br_blockcount, mp->m_sb.sb_rextsize,
-				  &mod);
-		ASSERT(mod == 0);
-
 		if (!(bflags & XFS_BMAPI_REMAP)) {
-			xfs_fsblock_t	bno;
-
-			bno = div_u64_rem(del->br_startblock,
-					mp->m_sb.sb_rextsize, &mod);
-			ASSERT(mod == 0);
-
-			error = xfs_rtfree_extent(tp, bno, (xfs_extlen_t)len);
+			error = xfs_rtfree_blocks(tp, del->br_startblock,
+					del->br_blockcount);
 			if (error)
 				goto done;
 		}
 
 		do_fx = 0;
-		nblks = len * mp->m_sb.sb_rextsize;
 		qfield = XFS_TRANS_DQ_RTBCOUNT;
 	} else {
 		do_fx = 1;
-		nblks = del->br_blockcount;
 		qfield = XFS_TRANS_DQ_BCOUNT;
 	}
+	nblks = del->br_blockcount;
 
 	del_endblock = del->br_startblock + del->br_blockcount;
 	if (cur) {
 		error = xfs_bmbt_lookup_eq(cur, &got, &i);
 		if (error)
diff --git a/fs/xfs/libxfs/xfs_rtbitmap.c b/fs/xfs/libxfs/xfs_rtbitmap.c
index fa180ab66b73..655108a4cd05 100644
--- a/fs/xfs/libxfs/xfs_rtbitmap.c
+++ b/fs/xfs/libxfs/xfs_rtbitmap.c
@@ -1003,10 +1003,43 @@ xfs_rtfree_extent(
 		xfs_trans_log_inode(tp, mp->m_rbmip, XFS_ILOG_CORE);
 	}
 	return 0;
 }
 
+/*
+ * Free some blocks in the realtime subvolume.  rtbno and rtlen are in units of
+ * rt blocks, not rt extents; must be aligned to the rt extent size; and rtlen
+ * cannot exceed XFS_MAX_BMBT_EXTLEN.
+ */
+int
+xfs_rtfree_blocks(
+	struct xfs_trans	*tp,
+	xfs_fsblock_t		rtbno,
+	xfs_filblks_t		rtlen)
+{
+	struct xfs_mount	*mp = tp->t_mountp;
+	xfs_rtblock_t		bno;
+	xfs_filblks_t		len;
+	xfs_extlen_t		mod;
+
+	ASSERT(rtlen <= XFS_MAX_BMBT_EXTLEN);
+
+	len = div_u64_rem(rtlen, mp->m_sb.sb_rextsize, &mod);
+	if (mod) {
+		ASSERT(mod == 0);
+		return -EIO;
+	}
+
+	bno = div_u64_rem(rtbno, mp->m_sb.sb_rextsize, &mod);
+	if (mod) {
+		ASSERT(mod == 0);
+		return -EIO;
+	}
+
+	return xfs_rtfree_extent(tp, bno, len);
+}
+
 /* Find all the free records within a given range. */
 int
 xfs_rtalloc_query_range(
 	struct xfs_mount		*mp,
 	struct xfs_trans		*tp,
diff --git a/fs/xfs/xfs_rtalloc.h b/fs/xfs/xfs_rtalloc.h
index 62c7ad79cbb6..3b2f1b499a11 100644
--- a/fs/xfs/xfs_rtalloc.h
+++ b/fs/xfs/xfs_rtalloc.h
@@ -56,10 +56,14 @@ int					/* error */
 xfs_rtfree_extent(
 	struct xfs_trans	*tp,	/* transaction pointer */
 	xfs_rtblock_t		bno,	/* starting block number to free */
 	xfs_extlen_t		len);	/* length of extent freed */
 
+/* Same as above, but in units of rt blocks. */
+int xfs_rtfree_blocks(struct xfs_trans *tp, xfs_fsblock_t rtbno,
+		xfs_filblks_t rtlen);
+
 /*
  * Initialize realtime fields in the mount structure.
  */
 int					/* error */
 xfs_rtmount_init(
@@ -137,10 +141,11 @@ int xfs_rtalloc_extent_is_free(struct xfs_mount *mp, struct xfs_trans *tp,
 			       bool *is_free);
 int xfs_rtalloc_reinit_frextents(struct xfs_mount *mp);
 #else
 # define xfs_rtallocate_extent(t,b,min,max,l,f,p,rb)    (ENOSYS)
 # define xfs_rtfree_extent(t,b,l)                       (ENOSYS)
+# define xfs_rtfree_blocks(t,rb,rl)			(ENOSYS)
 # define xfs_rtpick_extent(m,t,l,rb)                    (ENOSYS)
 # define xfs_growfs_rt(mp,in)                           (ENOSYS)
 # define xfs_rtalloc_query_range(t,l,h,f,p)             (ENOSYS)
 # define xfs_rtalloc_query_all(m,t,f,p)                 (ENOSYS)
 # define xfs_rtbuf_get(m,t,b,i,p)                       (ENOSYS)
-- 
2.48.1.362.g079036d154-goog


