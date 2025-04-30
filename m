Return-Path: <stable+bounces-139243-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C29AAA576A
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 23:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FB399C3D9B
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 21:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99592D26A7;
	Wed, 30 Apr 2025 21:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VjxrvptQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052A922A7E3
	for <stable@vger.kernel.org>; Wed, 30 Apr 2025 21:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746048450; cv=none; b=g6LiWu0417FhpjR3j6X410ekLP73PvwHPHArqmrfOsrmDYWAZhu748VI/oCjlaNEkcStQ1F/uqcm6SNL0ul59Of2iWrTiy6GyAjOz0yEMK4CJQZE3tivB7NC/aqFF8b2bxripzh0N+1XD1JfH83GPFQS+gU/d2KSVvljBT03cZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746048450; c=relaxed/simple;
	bh=djp4sAxdbJ4J6UXDfGQXxUc9rrWBaxtpBHuENC7fvlw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wj5+kxMpWNA6u4t0DRIEXpUrHfP9M/sghYm/ZWkChIe7wcA2dG1wTCxr4kRFk6whUU4xiPkZe2uXTM+vXtccWMOB4RDMJzn/+xEHsKOCwCEpb1tKSZVzH9PESHZoEAwaL+wTUitmxFpWQ3cFZqvu8Y3b7MxSRpC/U2Liy/POFMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VjxrvptQ; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-73972a54919so406688b3a.3
        for <stable@vger.kernel.org>; Wed, 30 Apr 2025 14:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746048448; x=1746653248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ycH44kNk3XV0JpHrerP9yeDYt2k0LuqOZ7qpSG+R+nE=;
        b=VjxrvptQeIWHN3FNy2DOKKYUAE5hWJsP32Dqw6e0h3ynr55oE3z6GaGgQXEDDeYALx
         8Ko3nseow8q4a+9J1ys6PoIRbAC7GlETrMlazn5HWQSY6RmmusRQSWGDHlpfldVw/YNI
         TjLZcNinVc9cDRazKpobzhaC+Lu6V8cRWYM3hNXCAvwYe5EcY+mLCey9oyBtefvEk+hf
         GyBAp4TuhqEpyOugEBlMSgfJ4QKnKAxzBjSQCB5EOVHgWcJFCzvdd39eaDDPal2Go7+S
         Nz14MVdmBYdSJ5UWoS+hn0HUG0bim5ymUCl8LgHckpdC1FScq6QZgdrW4BQ+nvbfUEHG
         SURg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746048448; x=1746653248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ycH44kNk3XV0JpHrerP9yeDYt2k0LuqOZ7qpSG+R+nE=;
        b=ZM03+lfOm+6RRSnU0ZZtJRNNV1jfFQucO/GsbdrNXePqYFT+bLTQVjPKvPhYLWfMJS
         UYTRREMIBG0qd5flo1GlAS7klLcaVcIBzc3KDZYmMKCUp7+Yf95HWE29GxM9+LLXiSO8
         7YneoI9VgnyPmqrq/Ho6KaCQShfqTA9NygMF+bm3ywzEAFtyChkjyBT6Kp1naCkh252j
         /uokdlUYtkIleBnYxYO3QhQC3fAmw/4lYyHooVC8ZNUkSPUpSsEfXjuCF7GTQmqiHNjO
         +50WpWiZoY2cy0JA2w0vVdK7yfJV0hzsCS33veonB5ZosPp1BBWTmz0XKaILHB7h50A+
         gMHA==
X-Gm-Message-State: AOJu0YzDjxQD5ZUKW2GGMSmrXubMsyiwrI+DGM9dt18qY/omf59PfJ5e
	B/xcGRK9CvGZq4sSltrFZ4heZUD0PkTyjGHu/wVcXMoBRTwFZo9h0BOioN/Z
X-Gm-Gg: ASbGnctLIMmfMdHBnys8G1WgyMmg/vES/yN18TGQM4C0fg07F21EUJN/N38wk496Fvt
	v1uD7vFcZCkayflV3fOMTyFgkoe1mAPzHxol8juMj9/Y7OzMlirdE8lQB/JUctB2Kg0+RKwQ6kG
	zMgg5b9jn0eHsovJAB1Iw9cABunUTgxD7XF294B7PJWil3BbmHINtYbU9eqSVBrK/YOqD5aH/7w
	7Zh8T4g1ZBXY0aDPabAuWY0IpAT+mWbGiCHl4uXbrUzUTPY8bcot/2yHbqSSRd2iRBGLoqUssTP
	U57kdy7HbBVOKNsSB61+g/L2S/FizfQBmsQ8BOOcMgvgxb7XSNLKKpb4PYXB9YcrqwVV1PNQkfB
	DJV0=
X-Google-Smtp-Source: AGHT+IEFz5iqfmAWYnRwdZRZG2mdf2QvWG+/9XVOYOD6ZbjxJ7uyannohO1w3HgCIG0rZRyuEgr3uA==
X-Received: by 2002:a05:6a20:3955:b0:1f5:7d57:8322 with SMTP id adf61e73a8af0-20bd8140426mr35731637.26.1746048448149;
        Wed, 30 Apr 2025 14:27:28 -0700 (PDT)
Received: from lrumancik.svl.corp.google.com ([2620:15c:2c5:11:c94d:a5fe:c768:2a7f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74039a62e23sm2240586b3a.147.2025.04.30.14.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 14:27:27 -0700 (PDT)
From: Leah Rumancik <leah.rumancik@gmail.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev,
	chandan.babu@oracle.com,
	catherine.hoang@oracle.com,
	djwong@kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Chandan Babu R <chandanbabu@kernel.org>,
	Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH 6.1 16/16] xfs: restrict when we try to align cow fork delalloc to cowextsz hints
Date: Wed, 30 Apr 2025 14:27:03 -0700
Message-ID: <20250430212704.2905795-17-leah.rumancik@gmail.com>
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
In-Reply-To: <20250430212704.2905795-1-leah.rumancik@gmail.com>
References: <20250430212704.2905795-1-leah.rumancik@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Darrick J. Wong" <djwong@kernel.org>

[ Upstream commit 288e1f693f04e66be99f27e7cbe4a45936a66745 ]

xfs/205 produces the following failure when always_cow is enabled:

  --- a/tests/xfs/205.out	2024-02-28 16:20:24.437887970 -0800
  +++ b/tests/xfs/205.out.bad	2024-06-03 21:13:40.584000000 -0700
  @@ -1,4 +1,5 @@
   QA output created by 205
   *** one file
  +   !!! disk full (expected)
   *** one file, a few bytes at a time
   *** done

This is the result of overly aggressive attempts to align cow fork
delalloc reservations to the CoW extent size hint.  Looking at the trace
data, we're trying to append a single fsblock to the "fred" file.
Trying to create a speculative post-eof reservation fails because
there's not enough space.

We then set @prealloc_blocks to zero and try again, but the cowextsz
alignment code triggers, which expands our request for a 1-fsblock
reservation into a 39-block reservation.  There's not enough space for
that, so the whole write fails with ENOSPC even though there's
sufficient space in the filesystem to allocate the single block that we
need to land the write.

There are two things wrong here -- first, we shouldn't be attempting
speculative preallocations beyond what was requested when we're low on
space.  Second, if we've already computed a posteof preallocation, we
shouldn't bother trying to align that to the cowextsize hint.

Fix both of these problems by adding a flag that only enables the
expansion of the delalloc reservation to the cowextsize if we're doing a
non-extending write, and only if we're not doing an ENOSPC retry.  This
requires us to move the ENOSPC retry logic to xfs_bmapi_reserve_delalloc.

I probably should have caught this six years ago when 6ca30729c206d was
being reviewed, but oh well.  Update the comments to reflect what the
code does now.

Fixes: 6ca30729c206d ("xfs: bmap code cleanup")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
Acked-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_bmap.c | 31 +++++++++++++++++++++++++++----
 fs/xfs/xfs_iomap.c       | 34 ++++++++++++----------------------
 2 files changed, 39 insertions(+), 26 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
index a3c4d4a442af..14b0d230f61b 100644
--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -3957,43 +3957,55 @@ xfs_bmapi_reserve_delalloc(
 	struct xfs_mount	*mp = ip->i_mount;
 	struct xfs_ifork	*ifp = xfs_ifork_ptr(ip, whichfork);
 	xfs_extlen_t		alen;
 	xfs_extlen_t		indlen;
 	int			error;
-	xfs_fileoff_t		aoff = off;
+	xfs_fileoff_t		aoff;
+	bool			use_cowextszhint =
+					whichfork == XFS_COW_FORK && !prealloc;
 
+retry:
 	/*
 	 * Cap the alloc length. Keep track of prealloc so we know whether to
 	 * tag the inode before we return.
 	 */
+	aoff = off;
 	alen = XFS_FILBLKS_MIN(len + prealloc, XFS_MAX_BMBT_EXTLEN);
 	if (!eof)
 		alen = XFS_FILBLKS_MIN(alen, got->br_startoff - aoff);
 	if (prealloc && alen >= len)
 		prealloc = alen - len;
 
-	/* Figure out the extent size, adjust alen */
-	if (whichfork == XFS_COW_FORK) {
+	/*
+	 * If we're targetting the COW fork but aren't creating a speculative
+	 * posteof preallocation, try to expand the reservation to align with
+	 * the COW extent size hint if there's sufficient free space.
+	 *
+	 * Unlike the data fork, the CoW cancellation functions will free all
+	 * the reservations at inactivation, so we don't require that every
+	 * delalloc reservation have a dirty pagecache.
+	 */
+	if (use_cowextszhint) {
 		struct xfs_bmbt_irec	prev;
 		xfs_extlen_t		extsz = xfs_get_cowextsz_hint(ip);
 
 		if (!xfs_iext_peek_prev_extent(ifp, icur, &prev))
 			prev.br_startoff = NULLFILEOFF;
 
 		error = xfs_bmap_extsize_align(mp, got, &prev, extsz, 0, eof,
 					       1, 0, &aoff, &alen);
 		ASSERT(!error);
 	}
 
 	/*
 	 * Make a transaction-less quota reservation for delayed allocation
 	 * blocks.  This number gets adjusted later.  We return if we haven't
 	 * allocated blocks already inside this loop.
 	 */
 	error = xfs_quota_reserve_blkres(ip, alen);
 	if (error)
-		return error;
+		goto out;
 
 	/*
 	 * Split changing sb for alen and indlen since they could be coming
 	 * from different places.
 	 */
@@ -4034,10 +4046,21 @@ xfs_bmapi_reserve_delalloc(
 out_unreserve_blocks:
 	xfs_mod_fdblocks(mp, alen, false);
 out_unreserve_quota:
 	if (XFS_IS_QUOTA_ON(mp))
 		xfs_quota_unreserve_blkres(ip, alen);
+out:
+	if (error == -ENOSPC || error == -EDQUOT) {
+		trace_xfs_delalloc_enospc(ip, off, len);
+
+		if (prealloc || use_cowextszhint) {
+			/* retry without any preallocation */
+			use_cowextszhint = false;
+			prealloc = 0;
+			goto retry;
+		}
+	}
 	return error;
 }
 
 static int
 xfs_bmap_alloc_userdata(
diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index fab191a09442..28a1c19dfdb3 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -1113,37 +1113,27 @@ xfs_buffered_write_iomap_begin(
 			ASSERT(p_end_fsb > offset_fsb);
 			prealloc_blocks = p_end_fsb - end_fsb;
 		}
 	}
 
-retry:
-	error = xfs_bmapi_reserve_delalloc(ip, allocfork, offset_fsb,
-			end_fsb - offset_fsb, prealloc_blocks,
-			allocfork == XFS_DATA_FORK ? &imap : &cmap,
-			allocfork == XFS_DATA_FORK ? &icur : &ccur,
-			allocfork == XFS_DATA_FORK ? eof : cow_eof);
-	switch (error) {
-	case 0:
-		break;
-	case -ENOSPC:
-	case -EDQUOT:
-		/* retry without any preallocation */
-		trace_xfs_delalloc_enospc(ip, offset, count);
-		if (prealloc_blocks) {
-			prealloc_blocks = 0;
-			goto retry;
-		}
-		fallthrough;
-	default:
-		goto out_unlock;
-	}
-
 	if (allocfork == XFS_COW_FORK) {
+		error = xfs_bmapi_reserve_delalloc(ip, allocfork, offset_fsb,
+				end_fsb - offset_fsb, prealloc_blocks, &cmap,
+				&ccur, cow_eof);
+		if (error)
+			goto out_unlock;
+
 		trace_xfs_iomap_alloc(ip, offset, count, allocfork, &cmap);
 		goto found_cow;
 	}
 
+	error = xfs_bmapi_reserve_delalloc(ip, allocfork, offset_fsb,
+			end_fsb - offset_fsb, prealloc_blocks, &imap, &icur,
+			eof);
+	if (error)
+		goto out_unlock;
+
 	/*
 	 * Flag newly allocated delalloc blocks with IOMAP_F_NEW so we punch
 	 * them out if the write happens to fail.
 	 */
 	seq = xfs_iomap_inode_sequence(ip, IOMAP_F_NEW);
-- 
2.49.0.906.g1f30a19c02-goog


