Return-Path: <stable+bounces-111217-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D60AEA22431
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 19:47:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34BB0168298
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 18:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9446E1E25E8;
	Wed, 29 Jan 2025 18:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RcRRgGPY"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02ED1E0DFE
	for <stable@vger.kernel.org>; Wed, 29 Jan 2025 18:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738176459; cv=none; b=eHOf2lP5QP2yswihhYskwB5Gr9ropm1gDQuhJLYprsH7Gj0R5T2mFXXcWeofvJe5HdPE4e61z2cPEHo646VmutAmn8lrbuqXcaFGDAcJmslV6Bb8haEg4rg9wt869jRNbcLl+s2RqaBupPN4v9XBn2mhPhCCcOvIEOG1Fr17u5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738176459; c=relaxed/simple;
	bh=WGH65OyG650g0iCiSwRZlYu8XrnPMibzvq5SJI4RvQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tz4GbBhpABIbYAEFAC0psvMjq0wY8m7rYoMpjtwO/xWMxfCj9+N+GiRwJQe97M4xJF1E/xbPwEM7CgVeeP5DUApj8dJFxDiVCkmTg+BNKVbe2AxCjBtOTPDkkrzGeLnZnVTZxBAVdKGov3knxvsZjQndE7Y+5Lfkoz/5sg1/vjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RcRRgGPY; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-21661be2c2dso125379135ad.1
        for <stable@vger.kernel.org>; Wed, 29 Jan 2025 10:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738176457; x=1738781257; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3PXHUuyqneUoc6n+4MvWGjKQdspUTdvpjKCCoc9v2Xg=;
        b=RcRRgGPY2j2WM0CEWQY00iA/AC1pJESGCZoOvFpJe4URK94wgRDs+m18Y1kttqGOhJ
         VebY53rAPDPlUPzlntFF40ufvlfFrbs/EfO432qzAJ1y21GuXec7boB2hEQknPWuFHYP
         cs0x6y1/rhwSpsUgA8ei6qj261V6v07U3OFVv4hhzs1Ki6UJNN3mh5Xzxl13FBYCJIXO
         lwCN5KkKUH6P3QxlrhpDloFVi4xUP/7Tr0ut5Y8a+/K7tFm8mcp1laK2HUhZqVeA1bWW
         sqgYgn+R00qkxHcLBh+Mp/sN4zsBiq1j9Ev2IsSi5vaitaMJkhJ9s0ojkxB1L4QLAzWY
         ltuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738176457; x=1738781257;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3PXHUuyqneUoc6n+4MvWGjKQdspUTdvpjKCCoc9v2Xg=;
        b=uVjbwB+vsDeVdbLnL0E8Xpc8atqYpz5K9QZtXCuD875O61JZ7VoctvIuhjB8o1pzdk
         aW0vFiaK9x/VP189rh4wS7k20Efe+img5gS/u1lvjoOITzTocyfMQEZskzK+BWTL5DKP
         +GWKpeJms0aM+00AYJVv/8V9R8p/LatWHvn8CZRUbefjgLKeJtKYav3CujWEdB06R6hD
         zYUTvmcDkA3xXSSPmvHPJEK186zHMoGMyJFy91MD7x9N0RNEFi/FC4S9wxpgSgC3QlN4
         fdmyzUCgHNXBwyxvpeO5PNkWkFrG0KoWW//tZd+5ZwZvlu/aBItxSs2nrhBu6Db2Nl9B
         YLzQ==
X-Gm-Message-State: AOJu0YyGwVhqLCE0QwQtw4AVT56/AbyqtihgqDbYp8LHTf4k2tE5htW7
	KdGFUH0E41k7vUXu+K2zHtmR0pZvEROvnzQJXRaTCcyFDEwJvdy62FdK1A==
X-Gm-Gg: ASbGncuWTeGlBD1ifU8c9wVbaQfcPXF53y0owUW0XkP0XwiQ+19xfgfdlDTsM2+EG+5
	jfeQphorgm7/Tp8MVSnkuOaEu3cPlNeuwDuksyPbnOAdru2w5Y22gO0VUWMNsYqFpt4bL+1hN78
	skRaJb/u1PEBJvbSnhOhgCIzQ3J99pigzZCfCwuejg8N8QC/prK79J7n+e/bkVRnnlNhbWVaS7b
	SY3pxMzIYm7RoY5d4rv/EvWkec30tm6oBYusYzAqzuM9KgzMJ0hndVW1DMpqNgWq7YGIr3iE4Rs
	dvicZv9RfWJGr3WosyzkQ0qLIp1FoUlCMRevCI+DRb0=
X-Google-Smtp-Source: AGHT+IEXnPl1lwAl2NkNLHlFWa/Xk903I0rhpcZXcPY4TxZQqKJjRBl2lAlcB23g//jxlklyX0+yMg==
X-Received: by 2002:a17:902:d542:b0:216:2b14:b625 with SMTP id d9443c01a7336-21dd7d7f818mr71419875ad.31.1738176456644;
        Wed, 29 Jan 2025 10:47:36 -0800 (PST)
Received: from lrumancik.svl.corp.google.com ([2620:15c:2c5:11:fbc6:64ef:cffe:1cc8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da414151fsm103248795ad.121.2025.01.29.10.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 10:47:35 -0800 (PST)
From: Leah Rumancik <leah.rumancik@gmail.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev,
	amir73il@gmail.com,
	chandan.babu@oracle.com,
	catherine.hoang@oracle.com,
	"Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH 6.1 06/19] xfs: make sure maxlen is still congruent with prod when rounding down
Date: Wed, 29 Jan 2025 10:47:04 -0800
Message-ID: <20250129184717.80816-7-leah.rumancik@gmail.com>
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

[ Upstream commit f6a2dae2a1f52ea23f649c02615d073beba4cc35 ]

In commit 2a6ca4baed62, we tried to fix an overflow problem in the
realtime allocator that was caused by an overly large maxlen value
causing xfs_rtcheck_range to run off the end of the realtime bitmap.
Unfortunately, there is a subtle bug here -- maxlen (and minlen) both
have to be aligned with @prod, but @prod can be larger than 1 if the
user has set an extent size hint on the file, and that extent size hint
is larger than the realtime extent size.

If the rt free space extents are not aligned to this file's extszhint
because other files without extent size hints allocated space (or the
number of rt extents is similarly not aligned), then it's possible that
maxlen after clamping to sb_rextents will no longer be aligned to prod.
The allocation will succeed just fine, but we still trip the assertion.

Fix the problem by reducing maxlen by any misalignment with prod.  While
we're at it, split the assertions into two so that we can tell which
value had the bad alignment.

Fixes: 2a6ca4baed62 ("xfs: make sure the rt allocator doesn't run off the end")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
---
 fs/xfs/xfs_rtalloc.c | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/fs/xfs/xfs_rtalloc.c b/fs/xfs/xfs_rtalloc.c
index 34980d7c2dd6..0bfbbc1dd0da 100644
--- a/fs/xfs/xfs_rtalloc.c
+++ b/fs/xfs/xfs_rtalloc.c
@@ -209,10 +209,27 @@ xfs_rtallocate_range(
 	 */
 	error = xfs_rtmodify_range(mp, tp, start, len, 0);
 	return error;
 }
 
+/*
+ * Make sure we don't run off the end of the rt volume.  Be careful that
+ * adjusting maxlen downwards doesn't cause us to fail the alignment checks.
+ */
+static inline xfs_extlen_t
+xfs_rtallocate_clamp_len(
+	struct xfs_mount	*mp,
+	xfs_rtblock_t		startrtx,
+	xfs_extlen_t		rtxlen,
+	xfs_extlen_t		prod)
+{
+	xfs_extlen_t		ret;
+
+	ret = min(mp->m_sb.sb_rextents, startrtx + rtxlen) - startrtx;
+	return rounddown(ret, prod);
+}
+
 /*
  * Attempt to allocate an extent minlen<=len<=maxlen starting from
  * bitmap block bbno.  If we don't get maxlen then use prod to trim
  * the length, if given.  Returns error; returns starting block in *rtblock.
  * The lengths are all in rtextents.
@@ -246,11 +263,11 @@ xfs_rtallocate_extent_block(
 	for (i = XFS_BLOCKTOBIT(mp, bbno), besti = -1, bestlen = 0,
 		end = XFS_BLOCKTOBIT(mp, bbno + 1) - 1;
 	     i <= end;
 	     i++) {
 		/* Make sure we don't scan off the end of the rt volume. */
-		maxlen = min(mp->m_sb.sb_rextents, i + maxlen) - i;
+		maxlen = xfs_rtallocate_clamp_len(mp, i, maxlen, prod);
 
 		/*
 		 * See if there's a free extent of maxlen starting at i.
 		 * If it's not so then next will contain the first non-free.
 		 */
@@ -353,11 +370,12 @@ xfs_rtallocate_extent_exact(
 	int		error;		/* error value */
 	xfs_extlen_t	i;		/* extent length trimmed due to prod */
 	int		isfree;		/* extent is free */
 	xfs_rtblock_t	next;		/* next block to try (dummy) */
 
-	ASSERT(minlen % prod == 0 && maxlen % prod == 0);
+	ASSERT(minlen % prod == 0);
+	ASSERT(maxlen % prod == 0);
 	/*
 	 * Check if the range in question (for maxlen) is free.
 	 */
 	error = xfs_rtcheck_range(mp, tp, bno, maxlen, 1, &next, &isfree);
 	if (error) {
@@ -436,20 +454,22 @@ xfs_rtallocate_extent_near(
 	int		j;		/* secondary loop control */
 	int		log2len;	/* log2 of minlen */
 	xfs_rtblock_t	n;		/* next block to try */
 	xfs_rtblock_t	r;		/* result block */
 
-	ASSERT(minlen % prod == 0 && maxlen % prod == 0);
+	ASSERT(minlen % prod == 0);
+	ASSERT(maxlen % prod == 0);
+
 	/*
 	 * If the block number given is off the end, silently set it to
 	 * the last block.
 	 */
 	if (bno >= mp->m_sb.sb_rextents)
 		bno = mp->m_sb.sb_rextents - 1;
 
 	/* Make sure we don't run off the end of the rt volume. */
-	maxlen = min(mp->m_sb.sb_rextents, bno + maxlen) - bno;
+	maxlen = xfs_rtallocate_clamp_len(mp, bno, maxlen, prod);
 	if (maxlen < minlen) {
 		*rtblock = NULLRTBLOCK;
 		return 0;
 	}
 
@@ -636,11 +656,12 @@ xfs_rtallocate_extent_size(
 	int		l;		/* level number (loop control) */
 	xfs_rtblock_t	n;		/* next block to be tried */
 	xfs_rtblock_t	r;		/* result block number */
 	xfs_suminfo_t	sum;		/* summary information for extents */
 
-	ASSERT(minlen % prod == 0 && maxlen % prod == 0);
+	ASSERT(minlen % prod == 0);
+	ASSERT(maxlen % prod == 0);
 	ASSERT(maxlen != 0);
 
 	/*
 	 * Loop over all the levels starting with maxlen.
 	 * At each level, look at all the bitmap blocks, to see if there
-- 
2.48.1.362.g079036d154-goog


