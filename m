Return-Path: <stable+bounces-152456-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B47A0AD6089
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 23:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 505A9170848
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 21:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C5C28850C;
	Wed, 11 Jun 2025 21:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jqsL4GsM"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5B019A
	for <stable@vger.kernel.org>; Wed, 11 Jun 2025 21:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749675699; cv=none; b=KBnVPUKs9ZlPWACNAGN7ej+7dShEzpr+hPrTbWffM7SA3y79WHBiMnVPI7Neu0y+7i5Nt7n3dxPq035g4IjnCcY4O2o1bsozvM2gXShYFuCHqbtsvtLecLpCNPyLfWLRtUqIX48GAQBD9CKR7NOBEHcAqiDLuldLXQAoCx4s5zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749675699; c=relaxed/simple;
	bh=7cfXlU6+IMs/iQRNZ2VSNU5CNowuAaxuXcIQ/h/POjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bpswhMAiRttXfDZuG8tYjjwe7aUJO4uGmYRs1CvKwIHCV931abmdeHzTIxUOAkpju390FSSZ4cqtD7IBLi4ercorxgyiBiJzj6ijHkDeFDBjoasJCaRd/9s2Oi3MckkXSpzwpTrgEvPZUaCvU90TeR6j0/McyLiWpudqpyxap28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jqsL4GsM; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-234bfe37cccso4051835ad.0
        for <stable@vger.kernel.org>; Wed, 11 Jun 2025 14:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749675695; x=1750280495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hj3rkQk2AfxMhNkdMGzNcD1cg4Z9ZrkSiBWGgHpxmAE=;
        b=jqsL4GsMK8qVT5ZuHjHr//vQ+4ZNK4YCXAdk4S25p7OMK3qYrOMrOKZ4xGwPVz3u0m
         PW095sGnVvTg8nO/Rp+9TfXAt41yCcB1GRnv1T4ipMsel5yMYiw1SI4EEh2KqTfoxGQF
         W+8z5pv+gaD13Fkux52LI4VcbnVG7r+XzFOMGMrsdEoQTnYGSnUwgqwkB0Ktb03PveGI
         TpoRrQPOj9HW9SYIpry3ljiqd3xrJpVwJRrknMNQww5BXa2tYAd0H6zkOLtcrl9piftN
         zjpoKo6tcH/DwfyvDbWnYJJbTHX17k6K+eF+NPLdTvA7ivt8OXUYT6FFvsGx9a3eS+xL
         TjgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749675695; x=1750280495;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hj3rkQk2AfxMhNkdMGzNcD1cg4Z9ZrkSiBWGgHpxmAE=;
        b=vJ7MuD0hhsIdYIMiqNKhcWKLneN//ObVp/vu4RKNVFPHYDS/9l1SThF23l4CjKO/LC
         /7GM/sL7o52c/esMmPqcivwQTINvQLqQYalB5me2ikpap1jDvCAAh74TIsxlWLkpSuuk
         X76sb5/WTZBfp6PJnwq7ahdyKtgAv9wXUO1AujWFDcDWxPfZVb1kAHD7JNhr7mm2Ep8d
         fZXBU4ym/kqRUkgXMnIEcEDZpDhG7ERmNkKX37zELU8gQOcC35mc2f5ZpDBQLebiQWLR
         py8tMe+MSDXACbm7ojdNpCCoeeq1DpKHw9Yqa58iMujQHjDSndCKm32B9drRX6KeaApR
         L9Lg==
X-Gm-Message-State: AOJu0YyUPPNhQLMbOMjI/cuvpdlKz1LFmJXY3w5nUIrYkGVOCgpc1uYN
	87wn2GizL83Yu2W+3ZBjCubVhuPxjT4Y5myqq3TZFd0v500I2Ly/4R06iyq2LYjY
X-Gm-Gg: ASbGncsVUljq7WiYq+36zzbbxWLqiTaeBZ7PJZPHi/Rk70VFp9ZdN0ogTC7HGrPZFvp
	EMzH2iv0DqwPDHH2BVfhSmkMqCQWd5lOkkjFF5L3gKfmq6zRc1XEgp+6yMcxUqdR6QU+tfIkGY6
	/vXzF18nSoYTokz71JLIX2ZutYAeliWgp8A/t1hIv6d3SkeszuSfelLlbBXaaIiX2HC3BOJMM62
	HEFp4vkbMIYq285jbbPPxce1SAFagjulr2t0i0BE6maC2q2+BhLSyPFxcaojHdkKwQlzEz+6s09
	YcemrsIQTTvGTOfSlpYnrvjMUXdErW6SpxcjNhymnWFCrpkqa6OjhmfEDCx8FVVa98tBGIZLsQa
	JATSbVkKgzeOKa6br+hIaIQ==
X-Google-Smtp-Source: AGHT+IEMTHgD8iWcG0qiA63R/Q/7aaE7nuowRNCbhAnUFIKRu+gJRMbbghTBmtUVTROsG0d6dwKsOA==
X-Received: by 2002:a17:903:288:b0:234:c22:c612 with SMTP id d9443c01a7336-2364ca9ba57mr15622215ad.43.1749675694997;
        Wed, 11 Jun 2025 14:01:34 -0700 (PDT)
Received: from lrumancik.svl.corp.google.com ([2620:15c:2c5:11:391:76ae:2143:7d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2364e6d9c86sm62005ad.101.2025.06.11.14.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 14:01:34 -0700 (PDT)
From: Leah Rumancik <leah.rumancik@gmail.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev,
	chandan.babu@oracle.com,
	catherine.hoang@oracle.com,
	djwong@kernel.org,
	Dave Chinner <dchinner@redhat.com>,
	Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH 6.1 02/23] xfs: fix integer overflows in the fsmap rtbitmap and logdev backends
Date: Wed, 11 Jun 2025 14:01:06 -0700
Message-ID: <20250611210128.67687-3-leah.rumancik@gmail.com>
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

From: "Darrick J. Wong" <djwong@kernel.org>

[ Upstream commit 7975aba19cba4eba7ff60410f9294c90edc96dcf ]

It's not correct to use the rmap irec structure to hold query key
information to query the rtbitmap because the realtime volume can be
longer than 2^32 fsblocks in length.  Because the rt volume doesn't have
allocation groups, introduce a daddr-based record filtering algorithm
and compute the rtextent values using 64-bit variables.  The same
problem exists in the external log device fsmap implementation, so use
the same solution to fix it too.

After this patch, all the code that touches info->low and info->high
under xfs_getfsmap_logdev and __xfs_getfsmap_rtdev are unnecessary.
Cleaning this up will be done in subsequent patches.

Fixes: 4c934c7dd60c ("xfs: report realtime space information via the rtbitmap")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Dave Chinner <dchinner@redhat.com>
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
Acked-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/xfs_fsmap.c | 90 ++++++++++++++++++++++++++++++++--------------
 1 file changed, 64 insertions(+), 26 deletions(-)

diff --git a/fs/xfs/xfs_fsmap.c b/fs/xfs/xfs_fsmap.c
index 2011f1bf7ce0..5039d330ef98 100644
--- a/fs/xfs/xfs_fsmap.c
+++ b/fs/xfs/xfs_fsmap.c
@@ -158,10 +158,12 @@ struct xfs_getfsmap_info {
 	struct xfs_fsmap_head	*head;
 	struct fsmap		*fsmap_recs;	/* mapping records */
 	struct xfs_buf		*agf_bp;	/* AGF, for refcount queries */
 	struct xfs_perag	*pag;		/* AG info, if applicable */
 	xfs_daddr_t		next_daddr;	/* next daddr we expect */
+	/* daddr of low fsmap key when we're using the rtbitmap */
+	xfs_daddr_t		low_daddr;
 	u64			missing_owner;	/* owner of holes */
 	u32			dev;		/* device id */
 	/*
 	 * Low rmap key for the query.  If low.rm_blockcount is nonzero, this
 	 * is the second (or later) call to retrieve the recordset in pieces.
@@ -248,59 +250,66 @@ static inline bool
 xfs_getfsmap_rec_before_start(
 	struct xfs_getfsmap_info	*info,
 	const struct xfs_rmap_irec	*rec,
 	xfs_daddr_t			rec_daddr)
 {
+	if (info->low_daddr != -1ULL)
+		return rec_daddr < info->low_daddr;
 	if (info->low.rm_blockcount)
 		return xfs_rmap_compare(rec, &info->low) < 0;
 	return false;
 }
 
 /*
  * Format a reverse mapping for getfsmap, having translated rm_startblock
- * into the appropriate daddr units.
+ * into the appropriate daddr units.  Pass in a nonzero @len_daddr if the
+ * length could be larger than rm_blockcount in struct xfs_rmap_irec.
  */
 STATIC int
 xfs_getfsmap_helper(
 	struct xfs_trans		*tp,
 	struct xfs_getfsmap_info	*info,
 	const struct xfs_rmap_irec	*rec,
-	xfs_daddr_t			rec_daddr)
+	xfs_daddr_t			rec_daddr,
+	xfs_daddr_t			len_daddr)
 {
 	struct xfs_fsmap		fmr;
 	struct xfs_mount		*mp = tp->t_mountp;
 	bool				shared;
 	int				error;
 
 	if (fatal_signal_pending(current))
 		return -EINTR;
 
+	if (len_daddr == 0)
+		len_daddr = XFS_FSB_TO_BB(mp, rec->rm_blockcount);
+
 	/*
 	 * Filter out records that start before our startpoint, if the
 	 * caller requested that.
 	 */
 	if (xfs_getfsmap_rec_before_start(info, rec, rec_daddr)) {
-		rec_daddr += XFS_FSB_TO_BB(mp, rec->rm_blockcount);
+		rec_daddr += len_daddr;
 		if (info->next_daddr < rec_daddr)
 			info->next_daddr = rec_daddr;
 		return 0;
 	}
 
 	/* Are we just counting mappings? */
 	if (info->head->fmh_count == 0) {
 		if (info->head->fmh_entries == UINT_MAX)
 			return -ECANCELED;
 
 		if (rec_daddr > info->next_daddr)
 			info->head->fmh_entries++;
 
 		if (info->last)
 			return 0;
 
 		info->head->fmh_entries++;
 
-		rec_daddr += XFS_FSB_TO_BB(mp, rec->rm_blockcount);
+		rec_daddr += len_daddr;
 		if (info->next_daddr < rec_daddr)
 			info->next_daddr = rec_daddr;
 		return 0;
 	}
 
@@ -336,73 +345,73 @@ xfs_getfsmap_helper(
 	fmr.fmr_physical = rec_daddr;
 	error = xfs_fsmap_owner_from_rmap(&fmr, rec);
 	if (error)
 		return error;
 	fmr.fmr_offset = XFS_FSB_TO_BB(mp, rec->rm_offset);
-	fmr.fmr_length = XFS_FSB_TO_BB(mp, rec->rm_blockcount);
+	fmr.fmr_length = len_daddr;
 	if (rec->rm_flags & XFS_RMAP_UNWRITTEN)
 		fmr.fmr_flags |= FMR_OF_PREALLOC;
 	if (rec->rm_flags & XFS_RMAP_ATTR_FORK)
 		fmr.fmr_flags |= FMR_OF_ATTR_FORK;
 	if (rec->rm_flags & XFS_RMAP_BMBT_BLOCK)
 		fmr.fmr_flags |= FMR_OF_EXTENT_MAP;
 	if (fmr.fmr_flags == 0) {
 		error = xfs_getfsmap_is_shared(tp, info, rec, &shared);
 		if (error)
 			return error;
 		if (shared)
 			fmr.fmr_flags |= FMR_OF_SHARED;
 	}
 
 	xfs_getfsmap_format(mp, &fmr, info);
 out:
-	rec_daddr += XFS_FSB_TO_BB(mp, rec->rm_blockcount);
+	rec_daddr += len_daddr;
 	if (info->next_daddr < rec_daddr)
 		info->next_daddr = rec_daddr;
 	return 0;
 }
 
 /* Transform a rmapbt irec into a fsmap */
 STATIC int
 xfs_getfsmap_datadev_helper(
 	struct xfs_btree_cur		*cur,
 	const struct xfs_rmap_irec	*rec,
 	void				*priv)
 {
 	struct xfs_mount		*mp = cur->bc_mp;
 	struct xfs_getfsmap_info	*info = priv;
 	xfs_fsblock_t			fsb;
 	xfs_daddr_t			rec_daddr;
 
 	fsb = XFS_AGB_TO_FSB(mp, cur->bc_ag.pag->pag_agno, rec->rm_startblock);
 	rec_daddr = XFS_FSB_TO_DADDR(mp, fsb);
 
-	return xfs_getfsmap_helper(cur->bc_tp, info, rec, rec_daddr);
+	return xfs_getfsmap_helper(cur->bc_tp, info, rec, rec_daddr, 0);
 }
 
 /* Transform a bnobt irec into a fsmap */
 STATIC int
 xfs_getfsmap_datadev_bnobt_helper(
 	struct xfs_btree_cur		*cur,
 	const struct xfs_alloc_rec_incore *rec,
 	void				*priv)
 {
 	struct xfs_mount		*mp = cur->bc_mp;
 	struct xfs_getfsmap_info	*info = priv;
 	struct xfs_rmap_irec		irec;
 	xfs_daddr_t			rec_daddr;
 
 	rec_daddr = XFS_AGB_TO_DADDR(mp, cur->bc_ag.pag->pag_agno,
 			rec->ar_startblock);
 
 	irec.rm_startblock = rec->ar_startblock;
 	irec.rm_blockcount = rec->ar_blockcount;
 	irec.rm_owner = XFS_RMAP_OWN_NULL;	/* "free" */
 	irec.rm_offset = 0;
 	irec.rm_flags = 0;
 
-	return xfs_getfsmap_helper(cur->bc_tp, info, &irec, rec_daddr);
+	return xfs_getfsmap_helper(cur->bc_tp, info, &irec, rec_daddr, 0);
 }
 
 /* Set rmap flags based on the getfsmap flags */
 static void
 xfs_getfsmap_set_irec_flags(
@@ -425,133 +434,161 @@ xfs_getfsmap_logdev(
 	const struct xfs_fsmap		*keys,
 	struct xfs_getfsmap_info	*info)
 {
 	struct xfs_mount		*mp = tp->t_mountp;
 	struct xfs_rmap_irec		rmap;
+	xfs_daddr_t			rec_daddr, len_daddr;
+	xfs_fsblock_t			start_fsb;
 	int				error;
 
 	/* Set up search keys */
+	start_fsb = XFS_BB_TO_FSBT(mp,
+				keys[0].fmr_physical + keys[0].fmr_length);
 	info->low.rm_startblock = XFS_BB_TO_FSBT(mp, keys[0].fmr_physical);
 	info->low.rm_offset = XFS_BB_TO_FSBT(mp, keys[0].fmr_offset);
 	error = xfs_fsmap_owner_to_rmap(&info->low, keys);
 	if (error)
 		return error;
 	info->low.rm_blockcount = 0;
 	xfs_getfsmap_set_irec_flags(&info->low, &keys[0]);
 
+	/* Adjust the low key if we are continuing from where we left off. */
+	if (keys[0].fmr_length > 0)
+		info->low_daddr = XFS_FSB_TO_BB(mp, start_fsb);
+
 	error = xfs_fsmap_owner_to_rmap(&info->high, keys + 1);
 	if (error)
 		return error;
 	info->high.rm_startblock = -1U;
 	info->high.rm_owner = ULLONG_MAX;
 	info->high.rm_offset = ULLONG_MAX;
 	info->high.rm_blockcount = 0;
 	info->high.rm_flags = XFS_RMAP_KEY_FLAGS | XFS_RMAP_REC_FLAGS;
 	info->missing_owner = XFS_FMR_OWN_FREE;
 
 	trace_xfs_fsmap_low_key(mp, info->dev, NULLAGNUMBER, &info->low);
 	trace_xfs_fsmap_high_key(mp, info->dev, NULLAGNUMBER, &info->high);
 
-	if (keys[0].fmr_physical > 0)
+	if (start_fsb > 0)
 		return 0;
 
 	/* Fabricate an rmap entry for the external log device. */
 	rmap.rm_startblock = 0;
 	rmap.rm_blockcount = mp->m_sb.sb_logblocks;
 	rmap.rm_owner = XFS_RMAP_OWN_LOG;
 	rmap.rm_offset = 0;
 	rmap.rm_flags = 0;
 
-	return xfs_getfsmap_helper(tp, info, &rmap, 0);
+	rec_daddr = XFS_FSB_TO_BB(mp, rmap.rm_startblock);
+	len_daddr = XFS_FSB_TO_BB(mp, rmap.rm_blockcount);
+	return xfs_getfsmap_helper(tp, info, &rmap, rec_daddr, len_daddr);
 }
 
 #ifdef CONFIG_XFS_RT
 /* Transform a rtbitmap "record" into a fsmap */
 STATIC int
 xfs_getfsmap_rtdev_rtbitmap_helper(
 	struct xfs_mount		*mp,
 	struct xfs_trans		*tp,
 	const struct xfs_rtalloc_rec	*rec,
 	void				*priv)
 {
 	struct xfs_getfsmap_info	*info = priv;
 	struct xfs_rmap_irec		irec;
-	xfs_daddr_t			rec_daddr;
+	xfs_rtblock_t			rtbno;
+	xfs_daddr_t			rec_daddr, len_daddr;
+
+	rtbno = rec->ar_startext * mp->m_sb.sb_rextsize;
+	rec_daddr = XFS_FSB_TO_BB(mp, rtbno);
+	irec.rm_startblock = rtbno;
+
+	rtbno = rec->ar_extcount * mp->m_sb.sb_rextsize;
+	len_daddr = XFS_FSB_TO_BB(mp, rtbno);
+	irec.rm_blockcount = rtbno;
 
-	irec.rm_startblock = rec->ar_startext * mp->m_sb.sb_rextsize;
-	rec_daddr = XFS_FSB_TO_BB(mp, irec.rm_startblock);
-	irec.rm_blockcount = rec->ar_extcount * mp->m_sb.sb_rextsize;
 	irec.rm_owner = XFS_RMAP_OWN_NULL;	/* "free" */
 	irec.rm_offset = 0;
 	irec.rm_flags = 0;
 
-	return xfs_getfsmap_helper(tp, info, &irec, rec_daddr);
+	return xfs_getfsmap_helper(tp, info, &irec, rec_daddr, len_daddr);
 }
 
 /* Execute a getfsmap query against the realtime device. */
 STATIC int
 __xfs_getfsmap_rtdev(
 	struct xfs_trans		*tp,
 	const struct xfs_fsmap		*keys,
 	int				(*query_fn)(struct xfs_trans *,
-						    struct xfs_getfsmap_info *),
+						    struct xfs_getfsmap_info *,
+						    xfs_rtblock_t start_rtb,
+						    xfs_rtblock_t end_rtb),
 	struct xfs_getfsmap_info	*info)
 {
 	struct xfs_mount		*mp = tp->t_mountp;
-	xfs_fsblock_t			start_fsb;
-	xfs_fsblock_t			end_fsb;
+	xfs_rtblock_t			start_rtb;
+	xfs_rtblock_t			end_rtb;
 	uint64_t			eofs;
 	int				error = 0;
 
 	eofs = XFS_FSB_TO_BB(mp, mp->m_sb.sb_rblocks);
 	if (keys[0].fmr_physical >= eofs)
 		return 0;
-	start_fsb = XFS_BB_TO_FSBT(mp, keys[0].fmr_physical);
-	end_fsb = XFS_BB_TO_FSB(mp, min(eofs - 1, keys[1].fmr_physical));
+	start_rtb = XFS_BB_TO_FSBT(mp,
+				keys[0].fmr_physical + keys[0].fmr_length);
+	end_rtb = XFS_BB_TO_FSB(mp, min(eofs - 1, keys[1].fmr_physical));
 
 	/* Set up search keys */
-	info->low.rm_startblock = start_fsb;
+	info->low.rm_startblock = start_rtb;
 	error = xfs_fsmap_owner_to_rmap(&info->low, &keys[0]);
 	if (error)
 		return error;
 	info->low.rm_offset = XFS_BB_TO_FSBT(mp, keys[0].fmr_offset);
 	info->low.rm_blockcount = 0;
 	xfs_getfsmap_set_irec_flags(&info->low, &keys[0]);
 
-	info->high.rm_startblock = end_fsb;
+	/* Adjust the low key if we are continuing from where we left off. */
+	if (keys[0].fmr_length > 0) {
+		info->low_daddr = XFS_FSB_TO_BB(mp, start_rtb);
+		if (info->low_daddr >= eofs)
+			return 0;
+	}
+
+	info->high.rm_startblock = end_rtb;
 	error = xfs_fsmap_owner_to_rmap(&info->high, &keys[1]);
 	if (error)
 		return error;
 	info->high.rm_offset = XFS_BB_TO_FSBT(mp, keys[1].fmr_offset);
 	info->high.rm_blockcount = 0;
 	xfs_getfsmap_set_irec_flags(&info->high, &keys[1]);
 
 	trace_xfs_fsmap_low_key(mp, info->dev, NULLAGNUMBER, &info->low);
 	trace_xfs_fsmap_high_key(mp, info->dev, NULLAGNUMBER, &info->high);
 
-	return query_fn(tp, info);
+	return query_fn(tp, info, start_rtb, end_rtb);
 }
 
 /* Actually query the realtime bitmap. */
 STATIC int
 xfs_getfsmap_rtdev_rtbitmap_query(
 	struct xfs_trans		*tp,
-	struct xfs_getfsmap_info	*info)
+	struct xfs_getfsmap_info	*info,
+	xfs_rtblock_t			start_rtb,
+	xfs_rtblock_t			end_rtb)
 {
 	struct xfs_rtalloc_rec		alow = { 0 };
 	struct xfs_rtalloc_rec		ahigh = { 0 };
 	struct xfs_mount		*mp = tp->t_mountp;
 	int				error;
 
 	xfs_ilock(mp->m_rbmip, XFS_ILOCK_SHARED);
 
 	/*
 	 * Set up query parameters to return free rtextents covering the range
 	 * we want.
 	 */
-	alow.ar_startext = info->low.rm_startblock;
-	ahigh.ar_startext = info->high.rm_startblock;
+	alow.ar_startext = start_rtb;
+	ahigh.ar_startext = end_rtb;
 	do_div(alow.ar_startext, mp->m_sb.sb_rextsize);
 	if (do_div(ahigh.ar_startext, mp->m_sb.sb_rextsize))
 		ahigh.ar_startext++;
 	error = xfs_rtalloc_query_range(mp, tp, &alow, &ahigh,
 			xfs_getfsmap_rtdev_rtbitmap_helper, info);
@@ -986,10 +1023,11 @@ xfs_getfsmap(
 			break;
 
 		info.dev = handlers[i].dev;
 		info.last = false;
 		info.pag = NULL;
+		info.low_daddr = -1ULL;
 		info.low.rm_blockcount = 0;
 		error = handlers[i].fn(tp, dkeys, &info);
 		if (error)
 			break;
 		xfs_trans_cancel(tp);
-- 
2.50.0.rc1.591.g9c95f17f64-goog


