Return-Path: <stable+bounces-124361-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB33A6028B
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 21:26:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC6F719C57E3
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 20:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F801F4612;
	Thu, 13 Mar 2025 20:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ufa+ucaF"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BAE1F426F
	for <stable@vger.kernel.org>; Thu, 13 Mar 2025 20:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741897569; cv=none; b=cYPoodgPJnaoZHLkm3OjeKfWsDZzCdf4/K8boq0kxghY93JPr9m7x14ij+cPfi22KvbbpKu/JqXRfRF6yc4iw2YO0AilNOawyfN4BLGkKKC35ku6E3shipkV84yYweluYE/nRIXTgdFr5K7nuK5ZFIFk5dwC0x/PaRn08S2VRso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741897569; c=relaxed/simple;
	bh=GmC0+hQ44aQDycd/MzOFKn4EE5CzukaH2/jdmMu6t6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eBuozMs8QVcNQ4QBG3ImqAcavD/XFal0DzXYwmDx2TfXgI+eyie1MhTVWNNTcO8PeGqeckPrwkdGipcngp1i4cDzXivm+dRQ3MGPiBT4RZexk2prLiWF3cn1UsIVjQCRePKksd7MuoNNs21HNAQzUHD7535/QXPN24GPdeUoQCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ufa+ucaF; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ff797f8f1bso2611305a91.3
        for <stable@vger.kernel.org>; Thu, 13 Mar 2025 13:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741897567; x=1742502367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GmylYkk9a7+FT+fXSkvgjpuUiEJjXKb41rsG6Hn1Q0Q=;
        b=Ufa+ucaFbIKzJElN8e4/k8ARsq/bQVicE1q1sE2xqG73PeL83zCzUuHX4fbqSv/3ZF
         14FLPlPMHfvgCftAQXOF1ohbJ2eYkZxItwf/HAecUBtiEKRyDQwSoMsbCJddIPlkg15G
         rEbZCzJbe6Y2OdLLdgAz7OXRxOiaONjtuOOYO41ZXAP8gpIFIEphWPv2/XSnERkmtXGf
         tnvSZ5Hfr22yAZe7LgZtJYWHcIJWxfimpjRg7tMsneEkBilFhvimzFKoFEZ2YqdlJwW+
         rPHfjVY4I+QYP+Flj6Yuhtg/fYOA0y5m9nEurh2/t7KO5EP0a5IrBOMCVUFguRE/+aZv
         eHjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741897567; x=1742502367;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GmylYkk9a7+FT+fXSkvgjpuUiEJjXKb41rsG6Hn1Q0Q=;
        b=fBN2TkNc65fEi0vkBeXWnKg1eLWS8o4/cUwG2DhCjSoPtk7nfvPmCt8JftoRfWAmfW
         as7rs/9D1qyIJTKPI3/irC3QqIKvkeF1PjhZta3F0N0QN4uJiRhhar0M15mRJ21xF1Fo
         X2UWqsk9D0mQEIjfhRqeL/Sn01egcyYyv0n05fiaHm1fxGQtF6EumjcglmfOFLYFPeG+
         Q/xbttJH2nAfnG6dlBjFqfuIyGJVSABveYqqE3dq1DMnkz4kFW9dzsAdU0nuHiyYfCrP
         0hIeTTJWN78Vs/GDsoWwWKrs4g+oKkOuv/ZMFtYIOJhL1F+tHK+d+/LiKvKOPX5KPXS7
         cRtA==
X-Gm-Message-State: AOJu0YzHg2eLmyPKZuZITHxIU7Kzgj98eJOAkKjm4logGOHmuH7P9jQh
	AlneWqNbVOkkxaaygsfyptsJXrRk4X8NEA8ZlbrgLLKsz/Olt7G4V2z95w==
X-Gm-Gg: ASbGnctUt1CFUOwhhqGwLo9VwTqMIzbrqmTJqOQo6ZJcYhrt5UxXBg5MB1lXmbx6efr
	0gSPDERpeTt6bGic7pmYNOBXjGRFsFjizciIEg4bRjIb1RzDKpZvSrmelauleXS0RsUJD8GTgD/
	9tpHb0Cfi/TTtdJoBlNy0o6L1UXTft8kDr0yKyrR4rYD0tQTveZBtmCQHKDnKnKPYERpRPwWc6b
	y6i1ehnhggV9eaI9YtFOXBdgM0TvJeEStSAAjkw3Q5MZ1Ui3tv+1eCwOc9V/6tUN0YBjHggmqi0
	qlOg3becIeQuL/pnZCcNVuJrQ3w9ymYS1SxKowZN4ofjfto8dp7wEhDwQFITYDxdbIMuYGDtC2M
	JiEnUWQ==
X-Google-Smtp-Source: AGHT+IEfaU8L7XAYMFvKAojHGNQvg5bH59vKvNxePF1UMHYVtRpWS57nCPkFfQEYCcFzkCj4GZK4mg==
X-Received: by 2002:a05:6a21:328a:b0:1ee:c7c8:ca4 with SMTP id adf61e73a8af0-1f5c1317ea2mr40992637.36.1741897566859;
        Thu, 13 Mar 2025 13:26:06 -0700 (PDT)
Received: from lrumancik.svl.corp.google.com ([2620:15c:2c5:11:b233:743:91db:ac7b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56e9c94cesm1724455a12.6.2025.03.13.13.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 13:26:06 -0700 (PDT)
From: Leah Rumancik <leah.rumancik@gmail.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev,
	"Darrick J. Wong" <djwong@kernel.org>,
	Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH 6.1 04/29] xfs: pass the xfs_bmbt_irec directly through the log intent code
Date: Thu, 13 Mar 2025 13:25:24 -0700
Message-ID: <20250313202550.2257219-5-leah.rumancik@gmail.com>
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

From: "Darrick J. Wong" <djwong@kernel.org>

[ Upstream commit ddccb81b26ec021ae1f3366aa996cc4c68dd75ce ]

Instead of repeatedly boxing and unboxing the incore extent mapping
structure as it passes through the BUI code, pass the pointer directly
through.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
Acked-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_bmap.c | 32 ++++++++--------
 fs/xfs/libxfs/xfs_bmap.h |  5 +--
 fs/xfs/xfs_bmap_item.c   | 81 +++++++++++++++-------------------------
 3 files changed, 46 insertions(+), 72 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
index 27d3121e6da9..d523ac51c662 100644
--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -6117,43 +6117,41 @@ xfs_bmap_unmap_extent(
  * btree cursor to maintain our lock on the bmapbt between calls.
  */
 int
 xfs_bmap_finish_one(
 	struct xfs_trans		*tp,
-	struct xfs_inode		*ip,
-	enum xfs_bmap_intent_type	type,
-	int				whichfork,
-	xfs_fileoff_t			startoff,
-	xfs_fsblock_t			startblock,
-	xfs_filblks_t			*blockcount,
-	xfs_exntst_t			state)
+	struct xfs_bmap_intent		*bi)
 {
+	struct xfs_bmbt_irec		*bmap = &bi->bi_bmap;
 	int				error = 0;
 
 	ASSERT(tp->t_firstblock == NULLFSBLOCK);
 
 	trace_xfs_bmap_deferred(tp->t_mountp,
-			XFS_FSB_TO_AGNO(tp->t_mountp, startblock), type,
-			XFS_FSB_TO_AGBNO(tp->t_mountp, startblock),
-			ip->i_ino, whichfork, startoff, *blockcount, state);
+			XFS_FSB_TO_AGNO(tp->t_mountp, bmap->br_startblock),
+			bi->bi_type,
+			XFS_FSB_TO_AGBNO(tp->t_mountp, bmap->br_startblock),
+			bi->bi_owner->i_ino, bi->bi_whichfork,
+			bmap->br_startoff, bmap->br_blockcount,
+			bmap->br_state);
 
-	if (WARN_ON_ONCE(whichfork != XFS_DATA_FORK))
+	if (WARN_ON_ONCE(bi->bi_whichfork != XFS_DATA_FORK))
 		return -EFSCORRUPTED;
 
 	if (XFS_TEST_ERROR(false, tp->t_mountp,
 			XFS_ERRTAG_BMAP_FINISH_ONE))
 		return -EIO;
 
-	switch (type) {
+	switch (bi->bi_type) {
 	case XFS_BMAP_MAP:
-		error = xfs_bmapi_remap(tp, ip, startoff, *blockcount,
-				startblock, 0);
-		*blockcount = 0;
+		error = xfs_bmapi_remap(tp, bi->bi_owner, bmap->br_startoff,
+				bmap->br_blockcount, bmap->br_startblock, 0);
+		bmap->br_blockcount = 0;
 		break;
 	case XFS_BMAP_UNMAP:
-		error = __xfs_bunmapi(tp, ip, startoff, blockcount,
-				XFS_BMAPI_REMAP, 1);
+		error = __xfs_bunmapi(tp, bi->bi_owner, bmap->br_startoff,
+				&bmap->br_blockcount, XFS_BMAPI_REMAP, 1);
 		break;
 	default:
 		ASSERT(0);
 		error = -EFSCORRUPTED;
 	}
diff --git a/fs/xfs/libxfs/xfs_bmap.h b/fs/xfs/libxfs/xfs_bmap.h
index 08c16e4edc0f..524912f276f8 100644
--- a/fs/xfs/libxfs/xfs_bmap.h
+++ b/fs/xfs/libxfs/xfs_bmap.h
@@ -234,14 +234,11 @@ struct xfs_bmap_intent {
 	int					bi_whichfork;
 	struct xfs_inode			*bi_owner;
 	struct xfs_bmbt_irec			bi_bmap;
 };
 
-int	xfs_bmap_finish_one(struct xfs_trans *tp, struct xfs_inode *ip,
-		enum xfs_bmap_intent_type type, int whichfork,
-		xfs_fileoff_t startoff, xfs_fsblock_t startblock,
-		xfs_filblks_t *blockcount, xfs_exntst_t state);
+int	xfs_bmap_finish_one(struct xfs_trans *tp, struct xfs_bmap_intent *bi);
 void	xfs_bmap_map_extent(struct xfs_trans *tp, struct xfs_inode *ip,
 		struct xfs_bmbt_irec *imap);
 void	xfs_bmap_unmap_extent(struct xfs_trans *tp, struct xfs_inode *ip,
 		struct xfs_bmbt_irec *imap);
 
diff --git a/fs/xfs/xfs_bmap_item.c b/fs/xfs/xfs_bmap_item.c
index 41323da523d1..13aa5359c02f 100644
--- a/fs/xfs/xfs_bmap_item.c
+++ b/fs/xfs/xfs_bmap_item.c
@@ -244,22 +244,15 @@ xfs_trans_get_bud(
  */
 static int
 xfs_trans_log_finish_bmap_update(
 	struct xfs_trans		*tp,
 	struct xfs_bud_log_item		*budp,
-	enum xfs_bmap_intent_type	type,
-	struct xfs_inode		*ip,
-	int				whichfork,
-	xfs_fileoff_t			startoff,
-	xfs_fsblock_t			startblock,
-	xfs_filblks_t			*blockcount,
-	xfs_exntst_t			state)
+	struct xfs_bmap_intent		*bi)
 {
 	int				error;
 
-	error = xfs_bmap_finish_one(tp, ip, type, whichfork, startoff,
-			startblock, blockcount, state);
+	error = xfs_bmap_finish_one(tp, bi);
 
 	/*
 	 * Mark the transaction dirty, even on error. This ensures the
 	 * transaction is aborted, which:
 	 *
@@ -376,29 +369,21 @@ xfs_bmap_update_finish_item(
 	struct xfs_trans		*tp,
 	struct xfs_log_item		*done,
 	struct list_head		*item,
 	struct xfs_btree_cur		**state)
 {
-	struct xfs_bmap_intent		*bmap;
-	xfs_filblks_t			count;
+	struct xfs_bmap_intent		*bi;
 	int				error;
 
-	bmap = container_of(item, struct xfs_bmap_intent, bi_list);
-	count = bmap->bi_bmap.br_blockcount;
-	error = xfs_trans_log_finish_bmap_update(tp, BUD_ITEM(done),
-			bmap->bi_type,
-			bmap->bi_owner, bmap->bi_whichfork,
-			bmap->bi_bmap.br_startoff,
-			bmap->bi_bmap.br_startblock,
-			&count,
-			bmap->bi_bmap.br_state);
-	if (!error && count > 0) {
-		ASSERT(bmap->bi_type == XFS_BMAP_UNMAP);
-		bmap->bi_bmap.br_blockcount = count;
+	bi = container_of(item, struct xfs_bmap_intent, bi_list);
+
+	error = xfs_trans_log_finish_bmap_update(tp, BUD_ITEM(done), bi);
+	if (!error && bi->bi_bmap.br_blockcount > 0) {
+		ASSERT(bi->bi_type == XFS_BMAP_UNMAP);
 		return -EAGAIN;
 	}
-	kmem_cache_free(xfs_bmap_intent_cache, bmap);
+	kmem_cache_free(xfs_bmap_intent_cache, bi);
 	return error;
 }
 
 /* Abort all pending BUIs. */
 STATIC void
@@ -469,79 +454,73 @@ xfs_bui_validate(
 STATIC int
 xfs_bui_item_recover(
 	struct xfs_log_item		*lip,
 	struct list_head		*capture_list)
 {
-	struct xfs_bmbt_irec		irec;
+	struct xfs_bmap_intent		fake = { };
 	struct xfs_bui_log_item		*buip = BUI_ITEM(lip);
 	struct xfs_trans		*tp;
 	struct xfs_inode		*ip = NULL;
 	struct xfs_mount		*mp = lip->li_log->l_mp;
-	struct xfs_map_extent		*bmap;
+	struct xfs_map_extent		*map;
 	struct xfs_bud_log_item		*budp;
-	xfs_filblks_t			count;
-	xfs_exntst_t			state;
-	unsigned int			bui_type;
-	int				whichfork;
 	int				iext_delta;
 	int				error = 0;
 
 	if (!xfs_bui_validate(mp, buip)) {
 		XFS_CORRUPTION_ERROR(__func__, XFS_ERRLEVEL_LOW, mp,
 				&buip->bui_format, sizeof(buip->bui_format));
 		return -EFSCORRUPTED;
 	}
 
-	bmap = &buip->bui_format.bui_extents[0];
-	state = (bmap->me_flags & XFS_BMAP_EXTENT_UNWRITTEN) ?
-			XFS_EXT_UNWRITTEN : XFS_EXT_NORM;
-	whichfork = (bmap->me_flags & XFS_BMAP_EXTENT_ATTR_FORK) ?
+	map = &buip->bui_format.bui_extents[0];
+	fake.bi_whichfork = (map->me_flags & XFS_BMAP_EXTENT_ATTR_FORK) ?
 			XFS_ATTR_FORK : XFS_DATA_FORK;
-	bui_type = bmap->me_flags & XFS_BMAP_EXTENT_TYPE_MASK;
+	fake.bi_type = map->me_flags & XFS_BMAP_EXTENT_TYPE_MASK;
 
-	error = xlog_recover_iget(mp, bmap->me_owner, &ip);
+	error = xlog_recover_iget(mp, map->me_owner, &ip);
 	if (error)
 		return error;
 
 	/* Allocate transaction and do the work. */
 	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_itruncate,
 			XFS_EXTENTADD_SPACE_RES(mp, XFS_DATA_FORK), 0, 0, &tp);
 	if (error)
 		goto err_rele;
 
 	budp = xfs_trans_get_bud(tp, buip);
 	xfs_ilock(ip, XFS_ILOCK_EXCL);
 	xfs_trans_ijoin(tp, ip, 0);
 
-	if (bui_type == XFS_BMAP_MAP)
+	if (fake.bi_type == XFS_BMAP_MAP)
 		iext_delta = XFS_IEXT_ADD_NOSPLIT_CNT;
 	else
 		iext_delta = XFS_IEXT_PUNCH_HOLE_CNT;
 
-	error = xfs_iext_count_may_overflow(ip, whichfork, iext_delta);
+	error = xfs_iext_count_may_overflow(ip, fake.bi_whichfork, iext_delta);
 	if (error == -EFBIG)
 		error = xfs_iext_count_upgrade(tp, ip, iext_delta);
 	if (error)
 		goto err_cancel;
 
-	count = bmap->me_len;
-	error = xfs_trans_log_finish_bmap_update(tp, budp, bui_type, ip,
-			whichfork, bmap->me_startoff, bmap->me_startblock,
-			&count, state);
+	fake.bi_owner = ip;
+	fake.bi_bmap.br_startblock = map->me_startblock;
+	fake.bi_bmap.br_startoff = map->me_startoff;
+	fake.bi_bmap.br_blockcount = map->me_len;
+	fake.bi_bmap.br_state = (map->me_flags & XFS_BMAP_EXTENT_UNWRITTEN) ?
+			XFS_EXT_UNWRITTEN : XFS_EXT_NORM;
+
+	error = xfs_trans_log_finish_bmap_update(tp, budp, &fake);
 	if (error == -EFSCORRUPTED)
-		XFS_CORRUPTION_ERROR(__func__, XFS_ERRLEVEL_LOW, mp, bmap,
-				sizeof(*bmap));
+		XFS_CORRUPTION_ERROR(__func__, XFS_ERRLEVEL_LOW, mp, map,
+				sizeof(*map));
 	if (error)
 		goto err_cancel;
 
-	if (count > 0) {
-		ASSERT(bui_type == XFS_BMAP_UNMAP);
-		irec.br_startblock = bmap->me_startblock;
-		irec.br_blockcount = count;
-		irec.br_startoff = bmap->me_startoff;
-		irec.br_state = state;
-		xfs_bmap_unmap_extent(tp, ip, &irec);
+	if (fake.bi_bmap.br_blockcount > 0) {
+		ASSERT(fake.bi_type == XFS_BMAP_UNMAP);
+		xfs_bmap_unmap_extent(tp, ip, &fake.bi_bmap);
 	}
 
 	/*
 	 * Commit transaction, which frees the transaction and saves the inode
 	 * for later replay activities.
-- 
2.49.0.rc1.451.g8f38331e32-goog


