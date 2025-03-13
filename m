Return-Path: <stable+bounces-124360-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE58A6028A
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 21:26:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EFCB3AF8EE
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 20:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B6B1F460B;
	Thu, 13 Mar 2025 20:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KjOw3pf9"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA781F4180
	for <stable@vger.kernel.org>; Thu, 13 Mar 2025 20:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741897568; cv=none; b=FzxvVeyG6KRPcdq5GdCyXuQIDbhpg++BFccf7AZFjf7KqVs7OZtnVXtQnxglCfKha/K++jklILR2+EWtNOut/xBAk9XnRd6LPXKjtVWtT83xWnwL9cnDKagZDN2AO/3mEHqQC7Qw8gMYbNdjDXqPC28XUl3VHW3YxTG52FaZFyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741897568; c=relaxed/simple;
	bh=TywG6zOc5kb3dZ2xlxUqo5kkTKpwtx2g2rJICIdkWKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k1An2Zqa4KaLAJY2fn3i4mQmpJ302iAWS6tl+PMJlZMKgoseaHH2XMwWsnw7uGyDvDOJ973vWKaOVshlZSdLixhptbLJGUO/5uxbxvNcWR+KMbDi3g5GxOLbFCu7IeGbYXYwJ2WRmvjgLdbPv3z+AHi7eCIdlSWHXYsoE4+lSYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KjOw3pf9; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-224191d92e4so30359405ad.3
        for <stable@vger.kernel.org>; Thu, 13 Mar 2025 13:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741897566; x=1742502366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KlKTNyCK2BcIOuGEySH2zKy80IEmZXu/N/kPaWmpZxc=;
        b=KjOw3pf95BB8YQAWnNoyGs7LI1P7sXutHEeItGhnYV06zEJJ8Zodn8lAGAg3ok5Jts
         AkDMGWgeG3IQPtaHyG8sAeZWEfSTMqRqH7OFBXW59gvvvNn9Oy06CDFPBJnOu36atRVY
         hH0dP178ZIV7zu9YZP4Nhflk+nEj4/vtrPJe2Z4nWeDY0Sco4Y8ZJXt8O4D+NVOlNA9k
         5cuKK9Q+cCnOw0jwjbzL1bVVYSXtJ8nfEYtqsWGfpBNcPshqYXfdf0iA3IWXdysxzRZ8
         uDJVovjLeC96nFG0qCnxUZkoPbZPwlVuqfL+q46Yykgw6DzIkcR1BIgJb59g+WVQZePz
         1TWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741897566; x=1742502366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KlKTNyCK2BcIOuGEySH2zKy80IEmZXu/N/kPaWmpZxc=;
        b=YsZ8xacbe2sEyZR6LFy4sHSE9knHJzwLA8kxMxxd00db6a6j4oOhKMXT3ozPo3NCTO
         lhlHRsPC5ib3j41QOvjp2hatjC8z48KmPtjLE0SeKBGjIyzzFIC5HBWOI+V1rLc/lwLi
         rG+4yKxOKTYb7M7yhE7uMf4Llf3+P7Hu1j2Tv587jOK255LLWAhiQwxFJRJ1KaCHodL9
         r1Yj+bCcSNSIwJHrRSP/tPyZgg+Plhuy77I7d/o4L3DeA1UjqFRUkRidIHsr0uU2YB7X
         1LZkLF5NaSEoluiB4RFXsoNXcGAko7/rtymxSxOp4czHFXwzDXqcXihLuymEB4edxMhB
         jaGA==
X-Gm-Message-State: AOJu0YzLGax4lXOHmvhaDGRZM480MMkZb8JiSk5pGwBevotd9dzHTdYe
	JOwVAgzIFFP+dggAWJXw6jDPhWaeikH+hDG3F0HKChZtGnEtlW67OcYF2w==
X-Gm-Gg: ASbGncvqSPGUlTOnOw/8SA855+q+7aU9IsBBMepPgOFwOZ0YMRbiVNhmx2rYbG16rro
	D0iqf8T0KR5mbLanA16EIpnShIGS/5NaeuveIqkwjNJrBH0E9aXT2wkvZG8P0gv4xAB+M2GbZP2
	1CmGPtMLeO7GGAl0N4WX+uNRq0qwqQdSRcsltOVzwRmIMvqrH2dlpJ39oYe5Vq5sIpKYn95lk4W
	EXM9EiVsBqALQsnUgEvBivD41qLG0CSpoE/yKXBp7Z83qXtWDzkjCGAONKJj8JE/C2jS/ghJ4tW
	XAV90afQ3U0hPcOb4uVipNgqik/E4TUO+H7Ks3IZaQEG/w7VfnXr+dy63IcfUODS3zk4Q24=
X-Google-Smtp-Source: AGHT+IEd7coE1hjcTowz4im2F8dtFPZtyo2BwHsJGMijUHF0Ko+XT38d8x6fRtB9C28gPIf1u/0Phg==
X-Received: by 2002:a05:6a21:7894:b0:1f5:619a:8f73 with SMTP id adf61e73a8af0-1f5c12c7973mr71388637.26.1741897565995;
        Thu, 13 Mar 2025 13:26:05 -0700 (PDT)
Received: from lrumancik.svl.corp.google.com ([2620:15c:2c5:11:b233:743:91db:ac7b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56e9c94cesm1724455a12.6.2025.03.13.13.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 13:26:05 -0700 (PDT)
From: Leah Rumancik <leah.rumancik@gmail.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev,
	"Darrick J. Wong" <djwong@kernel.org>,
	Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH 6.1 03/29] xfs: fix confusing xfs_extent_item variable names
Date: Thu, 13 Mar 2025 13:25:23 -0700
Message-ID: <20250313202550.2257219-4-leah.rumancik@gmail.com>
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

[ Upstream commit 578c714b215d474c52949e65a914dae67924f0fe ]

Change the name of all pointers to xfs_extent_item structures to "xefi"
to make the name consistent and because the current selections ("new"
and "free") mean other things in C.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
Acked-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_alloc.c | 32 +++++++++---------
 fs/xfs/xfs_extfree_item.c | 70 +++++++++++++++++++--------------------
 2 files changed, 51 insertions(+), 51 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_alloc.c b/fs/xfs/libxfs/xfs_alloc.c
index 74d039bdc9f7..cc5c954cda88 100644
--- a/fs/xfs/libxfs/xfs_alloc.c
+++ b/fs/xfs/libxfs/xfs_alloc.c
@@ -2491,78 +2491,78 @@ xfs_defer_agfl_block(
 	xfs_agnumber_t			agno,
 	xfs_fsblock_t			agbno,
 	struct xfs_owner_info		*oinfo)
 {
 	struct xfs_mount		*mp = tp->t_mountp;
-	struct xfs_extent_free_item	*new;		/* new element */
+	struct xfs_extent_free_item	*xefi;
 
 	ASSERT(xfs_extfree_item_cache != NULL);
 	ASSERT(oinfo != NULL);
 
-	new = kmem_cache_zalloc(xfs_extfree_item_cache,
+	xefi = kmem_cache_zalloc(xfs_extfree_item_cache,
 			       GFP_KERNEL | __GFP_NOFAIL);
-	new->xefi_startblock = XFS_AGB_TO_FSB(mp, agno, agbno);
-	new->xefi_blockcount = 1;
-	new->xefi_owner = oinfo->oi_owner;
+	xefi->xefi_startblock = XFS_AGB_TO_FSB(mp, agno, agbno);
+	xefi->xefi_blockcount = 1;
+	xefi->xefi_owner = oinfo->oi_owner;
 
 	trace_xfs_agfl_free_defer(mp, agno, 0, agbno, 1);
 
-	xfs_defer_add(tp, XFS_DEFER_OPS_TYPE_AGFL_FREE, &new->xefi_list);
+	xfs_defer_add(tp, XFS_DEFER_OPS_TYPE_AGFL_FREE, &xefi->xefi_list);
 }
 
 /*
  * Add the extent to the list of extents to be free at transaction end.
  * The list is maintained sorted (by block number).
  */
 void
 __xfs_free_extent_later(
 	struct xfs_trans		*tp,
 	xfs_fsblock_t			bno,
 	xfs_filblks_t			len,
 	const struct xfs_owner_info	*oinfo,
 	bool				skip_discard)
 {
-	struct xfs_extent_free_item	*new;		/* new element */
+	struct xfs_extent_free_item	*xefi;
 #ifdef DEBUG
 	struct xfs_mount		*mp = tp->t_mountp;
 	xfs_agnumber_t			agno;
 	xfs_agblock_t			agbno;
 
 	ASSERT(bno != NULLFSBLOCK);
 	ASSERT(len > 0);
 	ASSERT(len <= XFS_MAX_BMBT_EXTLEN);
 	ASSERT(!isnullstartblock(bno));
 	agno = XFS_FSB_TO_AGNO(mp, bno);
 	agbno = XFS_FSB_TO_AGBNO(mp, bno);
 	ASSERT(agno < mp->m_sb.sb_agcount);
 	ASSERT(agbno < mp->m_sb.sb_agblocks);
 	ASSERT(len < mp->m_sb.sb_agblocks);
 	ASSERT(agbno + len <= mp->m_sb.sb_agblocks);
 #endif
 	ASSERT(xfs_extfree_item_cache != NULL);
 
-	new = kmem_cache_zalloc(xfs_extfree_item_cache,
+	xefi = kmem_cache_zalloc(xfs_extfree_item_cache,
 			       GFP_KERNEL | __GFP_NOFAIL);
-	new->xefi_startblock = bno;
-	new->xefi_blockcount = (xfs_extlen_t)len;
+	xefi->xefi_startblock = bno;
+	xefi->xefi_blockcount = (xfs_extlen_t)len;
 	if (skip_discard)
-		new->xefi_flags |= XFS_EFI_SKIP_DISCARD;
+		xefi->xefi_flags |= XFS_EFI_SKIP_DISCARD;
 	if (oinfo) {
 		ASSERT(oinfo->oi_offset == 0);
 
 		if (oinfo->oi_flags & XFS_OWNER_INFO_ATTR_FORK)
-			new->xefi_flags |= XFS_EFI_ATTR_FORK;
+			xefi->xefi_flags |= XFS_EFI_ATTR_FORK;
 		if (oinfo->oi_flags & XFS_OWNER_INFO_BMBT_BLOCK)
-			new->xefi_flags |= XFS_EFI_BMBT_BLOCK;
-		new->xefi_owner = oinfo->oi_owner;
+			xefi->xefi_flags |= XFS_EFI_BMBT_BLOCK;
+		xefi->xefi_owner = oinfo->oi_owner;
 	} else {
-		new->xefi_owner = XFS_RMAP_OWN_NULL;
+		xefi->xefi_owner = XFS_RMAP_OWN_NULL;
 	}
 	trace_xfs_bmap_free_defer(tp->t_mountp,
 			XFS_FSB_TO_AGNO(tp->t_mountp, bno), 0,
 			XFS_FSB_TO_AGBNO(tp->t_mountp, bno), len);
-	xfs_defer_add(tp, XFS_DEFER_OPS_TYPE_FREE, &new->xefi_list);
+	xfs_defer_add(tp, XFS_DEFER_OPS_TYPE_FREE, &xefi->xefi_list);
 }
 
 #ifdef DEBUG
 /*
  * Check if an AGF has a free extent record whose length is equal to
diff --git a/fs/xfs/xfs_extfree_item.c b/fs/xfs/xfs_extfree_item.c
index 618d2f9ff535..011b50469301 100644
--- a/fs/xfs/xfs_extfree_item.c
+++ b/fs/xfs/xfs_extfree_item.c
@@ -343,49 +343,49 @@ xfs_trans_get_efd(
  */
 static int
 xfs_trans_free_extent(
 	struct xfs_trans		*tp,
 	struct xfs_efd_log_item		*efdp,
-	struct xfs_extent_free_item	*free)
+	struct xfs_extent_free_item	*xefi)
 {
 	struct xfs_owner_info		oinfo = { };
 	struct xfs_mount		*mp = tp->t_mountp;
 	struct xfs_extent		*extp;
 	uint				next_extent;
 	xfs_agnumber_t			agno = XFS_FSB_TO_AGNO(mp,
-							free->xefi_startblock);
+							xefi->xefi_startblock);
 	xfs_agblock_t			agbno = XFS_FSB_TO_AGBNO(mp,
-							free->xefi_startblock);
+							xefi->xefi_startblock);
 	int				error;
 
-	oinfo.oi_owner = free->xefi_owner;
-	if (free->xefi_flags & XFS_EFI_ATTR_FORK)
+	oinfo.oi_owner = xefi->xefi_owner;
+	if (xefi->xefi_flags & XFS_EFI_ATTR_FORK)
 		oinfo.oi_flags |= XFS_OWNER_INFO_ATTR_FORK;
-	if (free->xefi_flags & XFS_EFI_BMBT_BLOCK)
+	if (xefi->xefi_flags & XFS_EFI_BMBT_BLOCK)
 		oinfo.oi_flags |= XFS_OWNER_INFO_BMBT_BLOCK;
 
 	trace_xfs_bmap_free_deferred(tp->t_mountp, agno, 0, agbno,
-			free->xefi_blockcount);
+			xefi->xefi_blockcount);
 
-	error = __xfs_free_extent(tp, free->xefi_startblock,
-			free->xefi_blockcount, &oinfo, XFS_AG_RESV_NONE,
-			free->xefi_flags & XFS_EFI_SKIP_DISCARD);
+	error = __xfs_free_extent(tp, xefi->xefi_startblock,
+			xefi->xefi_blockcount, &oinfo, XFS_AG_RESV_NONE,
+			xefi->xefi_flags & XFS_EFI_SKIP_DISCARD);
 	/*
 	 * Mark the transaction dirty, even on error. This ensures the
 	 * transaction is aborted, which:
 	 *
 	 * 1.) releases the EFI and frees the EFD
 	 * 2.) shuts down the filesystem
 	 */
 	tp->t_flags |= XFS_TRANS_DIRTY | XFS_TRANS_HAS_INTENT_DONE;
 	set_bit(XFS_LI_DIRTY, &efdp->efd_item.li_flags);
 
 	next_extent = efdp->efd_next_extent;
 	ASSERT(next_extent < efdp->efd_format.efd_nextents);
 	extp = &(efdp->efd_format.efd_extents[next_extent]);
-	extp->ext_start = free->xefi_startblock;
-	extp->ext_len = free->xefi_blockcount;
+	extp->ext_start = xefi->xefi_startblock;
+	extp->ext_len = xefi->xefi_blockcount;
 	efdp->efd_next_extent++;
 
 	return error;
 }
 
@@ -409,162 +409,162 @@ xfs_extent_free_diff_items(
 /* Log a free extent to the intent item. */
 STATIC void
 xfs_extent_free_log_item(
 	struct xfs_trans		*tp,
 	struct xfs_efi_log_item		*efip,
-	struct xfs_extent_free_item	*free)
+	struct xfs_extent_free_item	*xefi)
 {
 	uint				next_extent;
 	struct xfs_extent		*extp;
 
 	tp->t_flags |= XFS_TRANS_DIRTY;
 	set_bit(XFS_LI_DIRTY, &efip->efi_item.li_flags);
 
 	/*
 	 * atomic_inc_return gives us the value after the increment;
 	 * we want to use it as an array index so we need to subtract 1 from
 	 * it.
 	 */
 	next_extent = atomic_inc_return(&efip->efi_next_extent) - 1;
 	ASSERT(next_extent < efip->efi_format.efi_nextents);
 	extp = &efip->efi_format.efi_extents[next_extent];
-	extp->ext_start = free->xefi_startblock;
-	extp->ext_len = free->xefi_blockcount;
+	extp->ext_start = xefi->xefi_startblock;
+	extp->ext_len = xefi->xefi_blockcount;
 }
 
 static struct xfs_log_item *
 xfs_extent_free_create_intent(
 	struct xfs_trans		*tp,
 	struct list_head		*items,
 	unsigned int			count,
 	bool				sort)
 {
 	struct xfs_mount		*mp = tp->t_mountp;
 	struct xfs_efi_log_item		*efip = xfs_efi_init(mp, count);
-	struct xfs_extent_free_item	*free;
+	struct xfs_extent_free_item	*xefi;
 
 	ASSERT(count > 0);
 
 	xfs_trans_add_item(tp, &efip->efi_item);
 	if (sort)
 		list_sort(mp, items, xfs_extent_free_diff_items);
-	list_for_each_entry(free, items, xefi_list)
-		xfs_extent_free_log_item(tp, efip, free);
+	list_for_each_entry(xefi, items, xefi_list)
+		xfs_extent_free_log_item(tp, efip, xefi);
 	return &efip->efi_item;
 }
 
 /* Get an EFD so we can process all the free extents. */
 static struct xfs_log_item *
 xfs_extent_free_create_done(
 	struct xfs_trans		*tp,
 	struct xfs_log_item		*intent,
 	unsigned int			count)
 {
 	return &xfs_trans_get_efd(tp, EFI_ITEM(intent), count)->efd_item;
 }
 
 /* Process a free extent. */
 STATIC int
 xfs_extent_free_finish_item(
 	struct xfs_trans		*tp,
 	struct xfs_log_item		*done,
 	struct list_head		*item,
 	struct xfs_btree_cur		**state)
 {
-	struct xfs_extent_free_item	*free;
+	struct xfs_extent_free_item	*xefi;
 	int				error;
 
-	free = container_of(item, struct xfs_extent_free_item, xefi_list);
+	xefi = container_of(item, struct xfs_extent_free_item, xefi_list);
 
-	error = xfs_trans_free_extent(tp, EFD_ITEM(done), free);
-	kmem_cache_free(xfs_extfree_item_cache, free);
+	error = xfs_trans_free_extent(tp, EFD_ITEM(done), xefi);
+	kmem_cache_free(xfs_extfree_item_cache, xefi);
 	return error;
 }
 
 /* Abort all pending EFIs. */
 STATIC void
 xfs_extent_free_abort_intent(
 	struct xfs_log_item		*intent)
 {
 	xfs_efi_release(EFI_ITEM(intent));
 }
 
 /* Cancel a free extent. */
 STATIC void
 xfs_extent_free_cancel_item(
 	struct list_head		*item)
 {
-	struct xfs_extent_free_item	*free;
+	struct xfs_extent_free_item	*xefi;
 
-	free = container_of(item, struct xfs_extent_free_item, xefi_list);
-	kmem_cache_free(xfs_extfree_item_cache, free);
+	xefi = container_of(item, struct xfs_extent_free_item, xefi_list);
+	kmem_cache_free(xfs_extfree_item_cache, xefi);
 }
 
 const struct xfs_defer_op_type xfs_extent_free_defer_type = {
 	.max_items	= XFS_EFI_MAX_FAST_EXTENTS,
 	.create_intent	= xfs_extent_free_create_intent,
 	.abort_intent	= xfs_extent_free_abort_intent,
 	.create_done	= xfs_extent_free_create_done,
 	.finish_item	= xfs_extent_free_finish_item,
 	.cancel_item	= xfs_extent_free_cancel_item,
 };
 
 /*
  * AGFL blocks are accounted differently in the reserve pools and are not
  * inserted into the busy extent list.
  */
 STATIC int
 xfs_agfl_free_finish_item(
 	struct xfs_trans		*tp,
 	struct xfs_log_item		*done,
 	struct list_head		*item,
 	struct xfs_btree_cur		**state)
 {
 	struct xfs_owner_info		oinfo = { };
 	struct xfs_mount		*mp = tp->t_mountp;
 	struct xfs_efd_log_item		*efdp = EFD_ITEM(done);
-	struct xfs_extent_free_item	*free;
+	struct xfs_extent_free_item	*xefi;
 	struct xfs_extent		*extp;
 	struct xfs_buf			*agbp;
 	int				error;
 	xfs_agnumber_t			agno;
 	xfs_agblock_t			agbno;
 	uint				next_extent;
 	struct xfs_perag		*pag;
 
-	free = container_of(item, struct xfs_extent_free_item, xefi_list);
-	ASSERT(free->xefi_blockcount == 1);
-	agno = XFS_FSB_TO_AGNO(mp, free->xefi_startblock);
-	agbno = XFS_FSB_TO_AGBNO(mp, free->xefi_startblock);
-	oinfo.oi_owner = free->xefi_owner;
+	xefi = container_of(item, struct xfs_extent_free_item, xefi_list);
+	ASSERT(xefi->xefi_blockcount == 1);
+	agno = XFS_FSB_TO_AGNO(mp, xefi->xefi_startblock);
+	agbno = XFS_FSB_TO_AGBNO(mp, xefi->xefi_startblock);
+	oinfo.oi_owner = xefi->xefi_owner;
 
-	trace_xfs_agfl_free_deferred(mp, agno, 0, agbno, free->xefi_blockcount);
+	trace_xfs_agfl_free_deferred(mp, agno, 0, agbno, xefi->xefi_blockcount);
 
 	pag = xfs_perag_get(mp, agno);
 	error = xfs_alloc_read_agf(pag, tp, 0, &agbp);
 	if (!error)
 		error = xfs_free_agfl_block(tp, agno, agbno, agbp, &oinfo);
 	xfs_perag_put(pag);
 
 	/*
 	 * Mark the transaction dirty, even on error. This ensures the
 	 * transaction is aborted, which:
 	 *
 	 * 1.) releases the EFI and frees the EFD
 	 * 2.) shuts down the filesystem
 	 */
 	tp->t_flags |= XFS_TRANS_DIRTY;
 	set_bit(XFS_LI_DIRTY, &efdp->efd_item.li_flags);
 
 	next_extent = efdp->efd_next_extent;
 	ASSERT(next_extent < efdp->efd_format.efd_nextents);
 	extp = &(efdp->efd_format.efd_extents[next_extent]);
-	extp->ext_start = free->xefi_startblock;
-	extp->ext_len = free->xefi_blockcount;
+	extp->ext_start = xefi->xefi_startblock;
+	extp->ext_len = xefi->xefi_blockcount;
 	efdp->efd_next_extent++;
 
-	kmem_cache_free(xfs_extfree_item_cache, free);
+	kmem_cache_free(xfs_extfree_item_cache, xefi);
 	return error;
 }
 
 /* sub-type with special handling for AGFL deferred frees */
 const struct xfs_defer_op_type xfs_agfl_free_defer_type = {
-- 
2.49.0.rc1.451.g8f38331e32-goog


