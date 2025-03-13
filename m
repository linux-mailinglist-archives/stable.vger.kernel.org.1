Return-Path: <stable+bounces-124383-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F24ABA602A1
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 21:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EE1D17E8B7
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 20:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46EB71F4192;
	Thu, 13 Mar 2025 20:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lzQT/0y1"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797BC1F4604
	for <stable@vger.kernel.org>; Thu, 13 Mar 2025 20:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741897592; cv=none; b=XfWI9uAgLbpTw5KMXXoC222Hm1KHLh/pd27anMpKx+tOCqkDtXqZHtaBJmLEdGFggpnQZwOm7SBgc3McXbfT5OvoECBIgYf5q6s5K3AVjNw3xBXfsCm7Q9HIYJ8neG2pRMZBtTuBZ0I8GZuYZWbXQouv6BWfIvwtR/DSHwB/FvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741897592; c=relaxed/simple;
	bh=nMi66R/lVvKKaPjpOMKs9CVZiaNp2xXZphO+9G+oDGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X6WIuTJhNfyBO+Pd5oiarN9k99jyvUY9RdNnoUjPsIEhJeR3bKamDDWjm6mPpg0iyAES8oCk6j27Q57qfdXNN3DsBDmFmeAaQEDVz2DTAWWiY4hydX6UmtjpzMZAFj0b3T85crM3tZGBf4q3tz3qd8O9MG7jNnKsQNLgnlQwP1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lzQT/0y1; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-225df540edcso1392525ad.0
        for <stable@vger.kernel.org>; Thu, 13 Mar 2025 13:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741897590; x=1742502390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GlW6iaAQQOiZhd2XzKbHe81pS03CI8FDVdbOwoqeBBw=;
        b=lzQT/0y1CqQHSuBW9+iH1MzJ2lzblog408DgVULUtMZ1VzUVBWYsEz4agM6Xhpgxpo
         NB6Cd42V1vacnKb0yuHmcZx+i6xSa0DUoVvzmzW1s1rk/k0T82rVUZOgItOE0YlQO1n4
         v22Bu6ds80Dlo8QINi/JQGKLKawMxkWcfeOpwiZ2JDdBGx+jMtWf6OpygialCDovD/QP
         vk7FGbE9VkA1qeVb7uyrUXuW9uwQUqS7mEeC40rM4lWAkSyqNy9QQyNVqexnwkylMLqU
         3WnWVxoDjm3xxPZJD6S4BDppQ2Uq9/iZ7sh4rSdvsUxGERT6p9Hgs6dBT9pGClHhTqP/
         mXww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741897590; x=1742502390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GlW6iaAQQOiZhd2XzKbHe81pS03CI8FDVdbOwoqeBBw=;
        b=FrZ+hOX5ZhIyl8Za4hToBs1VNDDe+ybOIRqHT780kinwhBgZJ/3pWeScdbq/CB8uz5
         srR5DtEMyLa+lz88095c/NPCvd253xZdsKYmflyoyJZwZQNVyp2YC5ATzM7JdvmSIe5t
         6aUHo4umlZvVnvAXg0WM2t0ugZoCthfeNUfRj5RN6mKy0mcpWD/48yjnBcChZdnJ7Md2
         eiQdbEGnEOSmftJle19Q+GzZfJ5iJ29ND750qGmKVsPGaHtC6tBkcv+dI4wWh+moA0DM
         Eeo4oqDfKL0oh2BeVmmgn03tigl94FaIGJ/z3awOBrcj3Ewi0u3BK124Jd21NkK+GsrJ
         1KLw==
X-Gm-Message-State: AOJu0YwWkAhK+9Pz8+AGNd5tj8cFBnore5XBKRc+akeYLzDJLo5JGnzQ
	C286YJervQuqs0Z5JEZVgfvgKrwHlL+ltyIOJWDG29HUerT+BYO61xy/uoQZ
X-Gm-Gg: ASbGncsxYgPHdFBqWM1ieH7ZDJui53tLL/kQx8F7iURYky9V08NE6WAYbRaY7nUxfLU
	E7yOnc9Z1A2D+GrvQF4JE0NnLmLHJYV+ttbHtzQcZf0H448MwFsJfN7gGMEecxwFbQWczyhDHe/
	YxVZ4k3w2RUPMx+L6m9ydkx+QKpi2t2HXTVyVm4TQfWepD5fld46pF/2TXF5E6mv8nZ0ZPwElGu
	/v9B0FaEYk+pzpOLaBwAvKnCB6cpD0WhMvPACO4tSu9Wog/97VRFl+HeO/Mr7auonRN2tCHxYwe
	wnC4yBXYQuDIoxUcONgCWNoVqzxqiOudubTHB2+/XbiVDALLDqj+k9rLG2zcCp1sC2D4aJHSCXk
	VPdBVew==
X-Google-Smtp-Source: AGHT+IFqCG9whLN1d438MnZeS2M7OCQ255QYRNP1HzEywHWvXzw5biv8Nq+3LKPmJ2s/qMy6BjYYbg==
X-Received: by 2002:a05:6a21:9015:b0:1ee:c8a4:c329 with SMTP id adf61e73a8af0-1f5b053695fmr5446313637.0.1741897589753;
        Thu, 13 Mar 2025 13:26:29 -0700 (PDT)
Received: from lrumancik.svl.corp.google.com ([2620:15c:2c5:11:b233:743:91db:ac7b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56e9c94cesm1724455a12.6.2025.03.13.13.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 13:26:29 -0700 (PDT)
From: Leah Rumancik <leah.rumancik@gmail.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev,
	Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>,
	Christoph Hellwig <hch@lst.de>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Chandan Babu R <chandanbabu@kernel.org>,
	Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH 6.1 26/29] xfs: ensure logflagsp is initialized in xfs_bmap_del_extent_real
Date: Thu, 13 Mar 2025 13:25:46 -0700
Message-ID: <20250313202550.2257219-27-leah.rumancik@gmail.com>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
In-Reply-To: <20250313202550.2257219-1-leah.rumancik@gmail.com>
References: <20250313202550.2257219-1-leah.rumancik@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>

[ Upstream commit e6af9c98cbf0164a619d95572136bfb54d482dd6 ]

In the case of returning -ENOSPC, ensure logflagsp is initialized by 0.
Otherwise the caller __xfs_bunmapi will set uninitialized illegal
tmp_logflags value into xfs log, which might cause unpredictable error
in the log recovery procedure.

Also, remove the flags variable and set the *logflagsp directly, so that
the code should be more robust in the long run.

Fixes: 1b24b633aafe ("xfs: move some more code into xfs_bmap_del_extent_real")
Signed-off-by: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
Acked-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_bmap.c | 73 +++++++++++++++++-----------------------
 1 file changed, 31 insertions(+), 42 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
index c99fd7fe242e..2a3b78032cb0 100644
--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -4997,242 +4997,231 @@ xfs_bmap_del_extent_real(
 {
 	xfs_fsblock_t		del_endblock=0;	/* first block past del */
 	xfs_fileoff_t		del_endoff;	/* first offset past del */
 	int			do_fx;	/* free extent at end of routine */
 	int			error;	/* error return value */
-	int			flags = 0;/* inode logging flags */
 	struct xfs_bmbt_irec	got;	/* current extent entry */
 	xfs_fileoff_t		got_endoff;	/* first offset past got */
 	int			i;	/* temp state */
 	struct xfs_ifork	*ifp;	/* inode fork pointer */
 	xfs_mount_t		*mp;	/* mount structure */
 	xfs_filblks_t		nblks;	/* quota/sb block count */
 	xfs_bmbt_irec_t		new;	/* new record to be inserted */
 	/* REFERENCED */
 	uint			qfield;	/* quota field to update */
 	uint32_t		state = xfs_bmap_fork_to_state(whichfork);
 	struct xfs_bmbt_irec	old;
 
+	*logflagsp = 0;
+
 	mp = ip->i_mount;
 	XFS_STATS_INC(mp, xs_del_exlist);
 
 	ifp = xfs_ifork_ptr(ip, whichfork);
 	ASSERT(del->br_blockcount > 0);
 	xfs_iext_get_extent(ifp, icur, &got);
 	ASSERT(got.br_startoff <= del->br_startoff);
 	del_endoff = del->br_startoff + del->br_blockcount;
 	got_endoff = got.br_startoff + got.br_blockcount;
 	ASSERT(got_endoff >= del_endoff);
 	ASSERT(!isnullstartblock(got.br_startblock));
 	qfield = 0;
-	error = 0;
 
 	/*
 	 * If it's the case where the directory code is running with no block
 	 * reservation, and the deleted block is in the middle of its extent,
 	 * and the resulting insert of an extent would cause transformation to
 	 * btree format, then reject it.  The calling code will then swap blocks
 	 * around instead.  We have to do this now, rather than waiting for the
 	 * conversion to btree format, since the transaction will be dirty then.
 	 */
 	if (tp->t_blk_res == 0 &&
 	    ifp->if_format == XFS_DINODE_FMT_EXTENTS &&
 	    ifp->if_nextents >= XFS_IFORK_MAXEXT(ip, whichfork) &&
 	    del->br_startoff > got.br_startoff && del_endoff < got_endoff)
 		return -ENOSPC;
 
-	flags = XFS_ILOG_CORE;
+	*logflagsp = XFS_ILOG_CORE;
 	if (whichfork == XFS_DATA_FORK && XFS_IS_REALTIME_INODE(ip)) {
 		if (!(bflags & XFS_BMAPI_REMAP)) {
 			error = xfs_rtfree_blocks(tp, del->br_startblock,
 					del->br_blockcount);
 			if (error)
-				goto done;
+				return error;
 		}
 
 		do_fx = 0;
 		qfield = XFS_TRANS_DQ_RTBCOUNT;
 	} else {
 		do_fx = 1;
 		qfield = XFS_TRANS_DQ_BCOUNT;
 	}
 	nblks = del->br_blockcount;
 
 	del_endblock = del->br_startblock + del->br_blockcount;
 	if (cur) {
 		error = xfs_bmbt_lookup_eq(cur, &got, &i);
 		if (error)
-			goto done;
-		if (XFS_IS_CORRUPT(mp, i != 1)) {
-			error = -EFSCORRUPTED;
-			goto done;
-		}
+			return error;
+		if (XFS_IS_CORRUPT(mp, i != 1))
+			return -EFSCORRUPTED;
 	}
 
 	if (got.br_startoff == del->br_startoff)
 		state |= BMAP_LEFT_FILLING;
 	if (got_endoff == del_endoff)
 		state |= BMAP_RIGHT_FILLING;
 
 	switch (state & (BMAP_LEFT_FILLING | BMAP_RIGHT_FILLING)) {
 	case BMAP_LEFT_FILLING | BMAP_RIGHT_FILLING:
 		/*
 		 * Matches the whole extent.  Delete the entry.
 		 */
 		xfs_iext_remove(ip, icur, state);
 		xfs_iext_prev(ifp, icur);
 		ifp->if_nextents--;
 
-		flags |= XFS_ILOG_CORE;
+		*logflagsp |= XFS_ILOG_CORE;
 		if (!cur) {
-			flags |= xfs_ilog_fext(whichfork);
+			*logflagsp |= xfs_ilog_fext(whichfork);
 			break;
 		}
 		if ((error = xfs_btree_delete(cur, &i)))
-			goto done;
-		if (XFS_IS_CORRUPT(mp, i != 1)) {
-			error = -EFSCORRUPTED;
-			goto done;
-		}
+			return error;
+		if (XFS_IS_CORRUPT(mp, i != 1))
+			return -EFSCORRUPTED;
 		break;
 	case BMAP_LEFT_FILLING:
 		/*
 		 * Deleting the first part of the extent.
 		 */
 		got.br_startoff = del_endoff;
 		got.br_startblock = del_endblock;
 		got.br_blockcount -= del->br_blockcount;
 		xfs_iext_update_extent(ip, state, icur, &got);
 		if (!cur) {
-			flags |= xfs_ilog_fext(whichfork);
+			*logflagsp |= xfs_ilog_fext(whichfork);
 			break;
 		}
 		error = xfs_bmbt_update(cur, &got);
 		if (error)
-			goto done;
+			return error;
 		break;
 	case BMAP_RIGHT_FILLING:
 		/*
 		 * Deleting the last part of the extent.
 		 */
 		got.br_blockcount -= del->br_blockcount;
 		xfs_iext_update_extent(ip, state, icur, &got);
 		if (!cur) {
-			flags |= xfs_ilog_fext(whichfork);
+			*logflagsp |= xfs_ilog_fext(whichfork);
 			break;
 		}
 		error = xfs_bmbt_update(cur, &got);
 		if (error)
-			goto done;
+			return error;
 		break;
 	case 0:
 		/*
 		 * Deleting the middle of the extent.
 		 */
 
 		old = got;
 
 		got.br_blockcount = del->br_startoff - got.br_startoff;
 		xfs_iext_update_extent(ip, state, icur, &got);
 
 		new.br_startoff = del_endoff;
 		new.br_blockcount = got_endoff - del_endoff;
 		new.br_state = got.br_state;
 		new.br_startblock = del_endblock;
 
-		flags |= XFS_ILOG_CORE;
+		*logflagsp |= XFS_ILOG_CORE;
 		if (cur) {
 			error = xfs_bmbt_update(cur, &got);
 			if (error)
-				goto done;
+				return error;
 			error = xfs_btree_increment(cur, 0, &i);
 			if (error)
-				goto done;
+				return error;
 			cur->bc_rec.b = new;
 			error = xfs_btree_insert(cur, &i);
 			if (error && error != -ENOSPC)
-				goto done;
+				return error;
 			/*
 			 * If get no-space back from btree insert, it tried a
 			 * split, and we have a zero block reservation.  Fix up
 			 * our state and return the error.
 			 */
 			if (error == -ENOSPC) {
 				/*
 				 * Reset the cursor, don't trust it after any
 				 * insert operation.
 				 */
 				error = xfs_bmbt_lookup_eq(cur, &got, &i);
 				if (error)
-					goto done;
-				if (XFS_IS_CORRUPT(mp, i != 1)) {
-					error = -EFSCORRUPTED;
-					goto done;
-				}
+					return error;
+				if (XFS_IS_CORRUPT(mp, i != 1))
+					return -EFSCORRUPTED;
 				/*
 				 * Update the btree record back
 				 * to the original value.
 				 */
 				error = xfs_bmbt_update(cur, &old);
 				if (error)
-					goto done;
+					return error;
 				/*
 				 * Reset the extent record back
 				 * to the original value.
 				 */
 				xfs_iext_update_extent(ip, state, icur, &old);
-				flags = 0;
-				error = -ENOSPC;
-				goto done;
-			}
-			if (XFS_IS_CORRUPT(mp, i != 1)) {
-				error = -EFSCORRUPTED;
-				goto done;
+				*logflagsp = 0;
+				return -ENOSPC;
 			}
+			if (XFS_IS_CORRUPT(mp, i != 1))
+				return -EFSCORRUPTED;
 		} else
-			flags |= xfs_ilog_fext(whichfork);
+			*logflagsp |= xfs_ilog_fext(whichfork);
 
 		ifp->if_nextents++;
 		xfs_iext_next(ifp, icur);
 		xfs_iext_insert(ip, icur, &new, state);
 		break;
 	}
 
 	/* remove reverse mapping */
 	xfs_rmap_unmap_extent(tp, ip, whichfork, del);
 
 	/*
 	 * If we need to, add to list of extents to delete.
 	 */
 	if (do_fx && !(bflags & XFS_BMAPI_REMAP)) {
 		if (xfs_is_reflink_inode(ip) && whichfork == XFS_DATA_FORK) {
 			xfs_refcount_decrease_extent(tp, del);
 		} else {
 			error = __xfs_free_extent_later(tp, del->br_startblock,
 					del->br_blockcount, NULL,
 					XFS_AG_RESV_NONE,
 					((bflags & XFS_BMAPI_NODISCARD) ||
 					del->br_state == XFS_EXT_UNWRITTEN));
 			if (error)
-				goto done;
+				return error;
 		}
 	}
 
 	/*
 	 * Adjust inode # blocks in the file.
 	 */
 	if (nblks)
 		ip->i_nblocks -= nblks;
 	/*
 	 * Adjust quota data.
 	 */
 	if (qfield && !(bflags & XFS_BMAPI_REMAP))
 		xfs_trans_mod_dquot_byino(tp, ip, qfield, (long)-nblks);
 
-done:
-	*logflagsp = flags;
-	return error;
+	return 0;
 }
 
 /*
  * Unmap (remove) blocks from a file.
  * If nexts is nonzero then the number of extents to remove is limited to
-- 
2.49.0.rc1.451.g8f38331e32-goog


