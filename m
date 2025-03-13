Return-Path: <stable+bounces-124358-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E38A60288
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 21:26:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 038F03AE0F9
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 20:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EAF61F4170;
	Thu, 13 Mar 2025 20:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="huIJ7Ct7"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E961BB6BA
	for <stable@vger.kernel.org>; Thu, 13 Mar 2025 20:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741897566; cv=none; b=CNyERJKMI2rohVFNE6oGvCex8qXCVEnL9E0NTTrVMCLG8g6/4ltCf+fPEyxElZT2X6mHcxITwnB3GcNhVFVDv4zKEQeYQvSvEJ81AR2rRd4IBuWbMBLmhUe5Pz3auWvI39WduSJmIzYpP6kXWBdlr9+ZM5PdvOwoq2WHjZGYVbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741897566; c=relaxed/simple;
	bh=SNpu6ko6/HcmE/yWnx6I2BPUDmbFwxaSNOCndb1Wjh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mU2YCvO4xshnty3u6HwJkvmQjQVLsZxGg0yIDJ1wjN+WAneYgEUp6BDCYc2f89Cb7AOd+w+vzQg1SMKtsnNfuVSUowStPwEVcRItvTSwUP+e/9WM67v/G5XcwFTOCNbUnM92IsLCOIJtwk0X2veEZELzzIC1vNHVOe5aXpHhejI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=huIJ7Ct7; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22438c356c8so28479295ad.1
        for <stable@vger.kernel.org>; Thu, 13 Mar 2025 13:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741897563; x=1742502363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cQhzid8c2XHSPbJGiBvlCeEUKnOJOAdFAKWdnndAxro=;
        b=huIJ7Ct71ZQsNupxeqeH/3+iGAa5+zW7z4uRTdqA6JHn7cKkKl2VOU6ttXH+e4nG3K
         Oo5pc8ZZBxCrdWsNt1GlzHrBBOLbEs2rubQV/9i+IelKi/MUAIbpUIfSW0iEZNunQWdq
         lNgATc2XCbsc5kw5GrMhnnmY4TJIojFp3rxyUFIIfHQjpnuMEdrxgj1FMGFJ8HTYCM7G
         ip0G6abIn93/gC+FILhACGN0ptqUwhOOhm8IzkhnhcUuD8xjuqW6UbsZ32SLEq/gN1jh
         opQimPTZv34s8PBuzVEVFpaeNCeZRUnuw4C6xAW1quhC8Sgc29FI+gyzxQF+YuUNHeYU
         vtNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741897563; x=1742502363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cQhzid8c2XHSPbJGiBvlCeEUKnOJOAdFAKWdnndAxro=;
        b=Pp1Y6yu+XOK0CbMvHIHM5HiMYCFp8u5VEeoTNontQNopGPFKxg6PjrUfh1VL/3l8Zl
         kshLhVDIaOa1PZQwmznlNs6hy4FxpHoL/UK6BpZH3FP9E6PLAQXn7WnP3Mr9IfYhhKlW
         3Ydh2/N72hnoVySGKsPvzltRPub/XF/RUXKUEhA639s7g/+mmQwhW76aXslpz5jGmj78
         Ny/lok/+Upaly+w8u9qSkGvrYn5VSwDAFkY+jnhpK1bm8sYW7p7H5TCgyTKMIxPAztA1
         oW5vnW/3aLZySqdboWjzD+bhyHWp/8SiJdPUwBR5O/vuT7I5EAvlElPVeEtkiCBa/pzo
         BjBw==
X-Gm-Message-State: AOJu0Yz7kk74pivTrbh1XQN17Z8qIqpHfNdO/G+8wkXRokOavJPv8saa
	6m/kLoTzIGD1K2SqnPzIJwNQsovQMvdZsCuorJ9SPYF09yZ44o8iFlighw==
X-Gm-Gg: ASbGncvtq/VToA5+Qy9FUErRy5TSsCZrpB2YsP1+pw0nDDFtkF4vVVoNwzeXFegmy2a
	SlQjcENAziNuVAV8S/usaxnzLKyUvVbZouK0SjqHkuegaxZkbg0l3Hfd/r6qx3hjL34EVpNqR/u
	MMoWqqR7pAxFgUkynk+ZUvAZUjVUH1Kq462S6OGXCQg0XwqMdDbymmxFtJKKWOa+MjUs27DQjgl
	8plsmxYZs9Qnt9BIm05ZL0D8XaEABkQoFsYGLstI6KbIj4GfRLgAscgaA5xaJ6EDPRthdaKsAXJ
	7R3X5CALXKOL4/HqFoFnPi/D+GBQAMVmIZIMkFQaT1o471atoD418JW2/RwpXr4HZxyYm6s=
X-Google-Smtp-Source: AGHT+IGAyZKIdYKO8Y6D7SlUNVHB5+2+HiWWh5C+gTHGTsKIwu4s8rMJGrIjvCS3Lg/4yVG0m8kyJw==
X-Received: by 2002:a17:902:cf07:b0:218:a43c:571e with SMTP id d9443c01a7336-225dd89b28amr13254645ad.28.1741897563515;
        Thu, 13 Mar 2025 13:26:03 -0700 (PDT)
Received: from lrumancik.svl.corp.google.com ([2620:15c:2c5:11:b233:743:91db:ac7b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56e9c94cesm1724455a12.6.2025.03.13.13.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 13:26:03 -0700 (PDT)
From: Leah Rumancik <leah.rumancik@gmail.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev,
	"Darrick J. Wong" <djwong@kernel.org>,
	Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH 6.1 01/29] xfs: pass refcount intent directly through the log intent code
Date: Thu, 13 Mar 2025 13:25:21 -0700
Message-ID: <20250313202550.2257219-2-leah.rumancik@gmail.com>
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

[ Upstream commit 0b11553ec54a6d88907e60d0595dbcef98539747 ]

Pass the incore refcount intent through the CUI logging code instead of
repeatedly boxing and unboxing parameters.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
Acked-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_refcount.c | 96 ++++++++++++++++--------------------
 fs/xfs/libxfs/xfs_refcount.h |  4 +-
 fs/xfs/xfs_refcount_item.c   | 62 ++++++++++-------------
 fs/xfs/xfs_trace.h           | 15 ++----
 4 files changed, 74 insertions(+), 103 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_refcount.c b/fs/xfs/libxfs/xfs_refcount.c
index 6f7ed9288fe4..bcf46aa0d08b 100644
--- a/fs/xfs/libxfs/xfs_refcount.c
+++ b/fs/xfs/libxfs/xfs_refcount.c
@@ -1211,60 +1211,56 @@ xfs_refcount_adjust_extents(
 
 /* Adjust the reference count of a range of AG blocks. */
 STATIC int
 xfs_refcount_adjust(
 	struct xfs_btree_cur	*cur,
-	xfs_agblock_t		agbno,
-	xfs_extlen_t		aglen,
-	xfs_agblock_t		*new_agbno,
-	xfs_extlen_t		*new_aglen,
+	xfs_agblock_t		*agbno,
+	xfs_extlen_t		*aglen,
 	enum xfs_refc_adjust_op	adj)
 {
 	bool			shape_changed;
 	int			shape_changes = 0;
 	int			error;
 
-	*new_agbno = agbno;
-	*new_aglen = aglen;
 	if (adj == XFS_REFCOUNT_ADJUST_INCREASE)
-		trace_xfs_refcount_increase(cur->bc_mp, cur->bc_ag.pag->pag_agno,
-				agbno, aglen);
+		trace_xfs_refcount_increase(cur->bc_mp,
+				cur->bc_ag.pag->pag_agno, *agbno, *aglen);
 	else
-		trace_xfs_refcount_decrease(cur->bc_mp, cur->bc_ag.pag->pag_agno,
-				agbno, aglen);
+		trace_xfs_refcount_decrease(cur->bc_mp,
+				cur->bc_ag.pag->pag_agno, *agbno, *aglen);
 
 	/*
 	 * Ensure that no rcextents cross the boundary of the adjustment range.
 	 */
 	error = xfs_refcount_split_extent(cur, XFS_REFC_DOMAIN_SHARED,
-			agbno, &shape_changed);
+			*agbno, &shape_changed);
 	if (error)
 		goto out_error;
 	if (shape_changed)
 		shape_changes++;
 
 	error = xfs_refcount_split_extent(cur, XFS_REFC_DOMAIN_SHARED,
-			agbno + aglen, &shape_changed);
+			*agbno + *aglen, &shape_changed);
 	if (error)
 		goto out_error;
 	if (shape_changed)
 		shape_changes++;
 
 	/*
 	 * Try to merge with the left or right extents of the range.
 	 */
 	error = xfs_refcount_merge_extents(cur, XFS_REFC_DOMAIN_SHARED,
-			new_agbno, new_aglen, adj, &shape_changed);
+			agbno, aglen, adj, &shape_changed);
 	if (error)
 		goto out_error;
 	if (shape_changed)
 		shape_changes++;
 	if (shape_changes)
 		cur->bc_ag.refc.shape_changes++;
 
 	/* Now that we've taken care of the ends, adjust the middle extents */
-	error = xfs_refcount_adjust_extents(cur, new_agbno, new_aglen, adj);
+	error = xfs_refcount_adjust_extents(cur, agbno, aglen, adj);
 	if (error)
 		goto out_error;
 
 	return 0;
 
@@ -1296,62 +1292,56 @@ xfs_refcount_finish_one_cleanup(
  * Checks to make sure we're not going to run off the end of the AG.
  */
 static inline int
 xfs_refcount_continue_op(
 	struct xfs_btree_cur		*cur,
-	xfs_fsblock_t			startblock,
-	xfs_agblock_t			new_agbno,
-	xfs_extlen_t			new_len,
-	xfs_fsblock_t			*new_fsbno)
+	struct xfs_refcount_intent	*ri,
+	xfs_agblock_t			new_agbno)
 {
 	struct xfs_mount		*mp = cur->bc_mp;
 	struct xfs_perag		*pag = cur->bc_ag.pag;
 
-	if (XFS_IS_CORRUPT(mp, !xfs_verify_agbext(pag, new_agbno, new_len)))
+	if (XFS_IS_CORRUPT(mp, !xfs_verify_agbext(pag, new_agbno,
+					ri->ri_blockcount)))
 		return -EFSCORRUPTED;
 
-	*new_fsbno = XFS_AGB_TO_FSB(mp, pag->pag_agno, new_agbno);
+	ri->ri_startblock = XFS_AGB_TO_FSB(mp, pag->pag_agno, new_agbno);
 
-	ASSERT(xfs_verify_fsbext(mp, *new_fsbno, new_len));
-	ASSERT(pag->pag_agno == XFS_FSB_TO_AGNO(mp, *new_fsbno));
+	ASSERT(xfs_verify_fsbext(mp, ri->ri_startblock, ri->ri_blockcount));
+	ASSERT(pag->pag_agno == XFS_FSB_TO_AGNO(mp, ri->ri_startblock));
 
 	return 0;
 }
 
 /*
  * Process one of the deferred refcount operations.  We pass back the
  * btree cursor to maintain our lock on the btree between calls.
  * This saves time and eliminates a buffer deadlock between the
  * superblock and the AGF because we'll always grab them in the same
  * order.
  */
 int
 xfs_refcount_finish_one(
 	struct xfs_trans		*tp,
-	enum xfs_refcount_intent_type	type,
-	xfs_fsblock_t			startblock,
-	xfs_extlen_t			blockcount,
-	xfs_fsblock_t			*new_fsb,
-	xfs_extlen_t			*new_len,
+	struct xfs_refcount_intent	*ri,
 	struct xfs_btree_cur		**pcur)
 {
 	struct xfs_mount		*mp = tp->t_mountp;
 	struct xfs_btree_cur		*rcur;
 	struct xfs_buf			*agbp = NULL;
 	int				error = 0;
 	xfs_agblock_t			bno;
-	xfs_agblock_t			new_agbno;
 	unsigned long			nr_ops = 0;
 	int				shape_changes = 0;
 	struct xfs_perag		*pag;
 
-	pag = xfs_perag_get(mp, XFS_FSB_TO_AGNO(mp, startblock));
-	bno = XFS_FSB_TO_AGBNO(mp, startblock);
+	pag = xfs_perag_get(mp, XFS_FSB_TO_AGNO(mp, ri->ri_startblock));
+	bno = XFS_FSB_TO_AGBNO(mp, ri->ri_startblock);
 
-	trace_xfs_refcount_deferred(mp, XFS_FSB_TO_AGNO(mp, startblock),
-			type, XFS_FSB_TO_AGBNO(mp, startblock),
-			blockcount);
+	trace_xfs_refcount_deferred(mp, XFS_FSB_TO_AGNO(mp, ri->ri_startblock),
+			ri->ri_type, XFS_FSB_TO_AGBNO(mp, ri->ri_startblock),
+			ri->ri_blockcount);
 
 	if (XFS_TEST_ERROR(false, mp, XFS_ERRTAG_REFCOUNT_FINISH_ONE)) {
 		error = -EIO;
 		goto out_drop;
 	}
@@ -1378,46 +1368,46 @@ xfs_refcount_finish_one(
 		rcur->bc_ag.refc.nr_ops = nr_ops;
 		rcur->bc_ag.refc.shape_changes = shape_changes;
 	}
 	*pcur = rcur;
 
-	switch (type) {
+	switch (ri->ri_type) {
 	case XFS_REFCOUNT_INCREASE:
-		error = xfs_refcount_adjust(rcur, bno, blockcount, &new_agbno,
-				new_len, XFS_REFCOUNT_ADJUST_INCREASE);
+		error = xfs_refcount_adjust(rcur, &bno, &ri->ri_blockcount,
+				XFS_REFCOUNT_ADJUST_INCREASE);
 		if (error)
 			goto out_drop;
-		if (*new_len > 0)
-			error = xfs_refcount_continue_op(rcur, startblock,
-					new_agbno, *new_len, new_fsb);
+		if (ri->ri_blockcount > 0)
+			error = xfs_refcount_continue_op(rcur, ri, bno);
 		break;
 	case XFS_REFCOUNT_DECREASE:
-		error = xfs_refcount_adjust(rcur, bno, blockcount, &new_agbno,
-				new_len, XFS_REFCOUNT_ADJUST_DECREASE);
+		error = xfs_refcount_adjust(rcur, &bno, &ri->ri_blockcount,
+				XFS_REFCOUNT_ADJUST_DECREASE);
 		if (error)
 			goto out_drop;
-		if (*new_len > 0)
-			error = xfs_refcount_continue_op(rcur, startblock,
-					new_agbno, *new_len, new_fsb);
+		if (ri->ri_blockcount > 0)
+			error = xfs_refcount_continue_op(rcur, ri, bno);
 		break;
 	case XFS_REFCOUNT_ALLOC_COW:
-		*new_fsb = startblock + blockcount;
-		*new_len = 0;
-		error = __xfs_refcount_cow_alloc(rcur, bno, blockcount);
+		error = __xfs_refcount_cow_alloc(rcur, bno, ri->ri_blockcount);
+		if (error)
+			goto out_drop;
+		ri->ri_blockcount = 0;
 		break;
 	case XFS_REFCOUNT_FREE_COW:
-		*new_fsb = startblock + blockcount;
-		*new_len = 0;
-		error = __xfs_refcount_cow_free(rcur, bno, blockcount);
+		error = __xfs_refcount_cow_free(rcur, bno, ri->ri_blockcount);
+		if (error)
+			goto out_drop;
+		ri->ri_blockcount = 0;
 		break;
 	default:
 		ASSERT(0);
 		error = -EFSCORRUPTED;
 	}
-	if (!error && *new_len > 0)
-		trace_xfs_refcount_finish_one_leftover(mp, pag->pag_agno, type,
-				bno, blockcount, new_agbno, *new_len);
+	if (!error && ri->ri_blockcount > 0)
+		trace_xfs_refcount_finish_one_leftover(mp, pag->pag_agno,
+				ri->ri_type, bno, ri->ri_blockcount);
 out_drop:
 	xfs_perag_put(pag);
 	return error;
 }
 
diff --git a/fs/xfs/libxfs/xfs_refcount.h b/fs/xfs/libxfs/xfs_refcount.h
index 452f30556f5a..c633477ce3ce 100644
--- a/fs/xfs/libxfs/xfs_refcount.h
+++ b/fs/xfs/libxfs/xfs_refcount.h
@@ -73,13 +73,11 @@ void xfs_refcount_decrease_extent(struct xfs_trans *tp,
 		struct xfs_bmbt_irec *irec);
 
 extern void xfs_refcount_finish_one_cleanup(struct xfs_trans *tp,
 		struct xfs_btree_cur *rcur, int error);
 extern int xfs_refcount_finish_one(struct xfs_trans *tp,
-		enum xfs_refcount_intent_type type, xfs_fsblock_t startblock,
-		xfs_extlen_t blockcount, xfs_fsblock_t *new_fsb,
-		xfs_extlen_t *new_len, struct xfs_btree_cur **pcur);
+		struct xfs_refcount_intent *ri, struct xfs_btree_cur **pcur);
 
 extern int xfs_refcount_find_shared(struct xfs_btree_cur *cur,
 		xfs_agblock_t agbno, xfs_extlen_t aglen, xfs_agblock_t *fbno,
 		xfs_extlen_t *flen, bool find_end_of_shared);
 
diff --git a/fs/xfs/xfs_refcount_item.c b/fs/xfs/xfs_refcount_item.c
index 858e3e9eb4a8..ff4d5087ba00 100644
--- a/fs/xfs/xfs_refcount_item.c
+++ b/fs/xfs/xfs_refcount_item.c
@@ -250,21 +250,16 @@ xfs_trans_get_cud(
  */
 static int
 xfs_trans_log_finish_refcount_update(
 	struct xfs_trans		*tp,
 	struct xfs_cud_log_item		*cudp,
-	enum xfs_refcount_intent_type	type,
-	xfs_fsblock_t			startblock,
-	xfs_extlen_t			blockcount,
-	xfs_fsblock_t			*new_fsb,
-	xfs_extlen_t			*new_len,
+	struct xfs_refcount_intent	*ri,
 	struct xfs_btree_cur		**pcur)
 {
 	int				error;
 
-	error = xfs_refcount_finish_one(tp, type, startblock,
-			blockcount, new_fsb, new_len, pcur);
+	error = xfs_refcount_finish_one(tp, ri, pcur);
 
 	/*
 	 * Mark the transaction dirty, even on error. This ensures the
 	 * transaction is aborted, which:
 	 *
@@ -376,29 +371,24 @@ xfs_refcount_update_finish_item(
 	struct xfs_trans		*tp,
 	struct xfs_log_item		*done,
 	struct list_head		*item,
 	struct xfs_btree_cur		**state)
 {
-	struct xfs_refcount_intent	*refc;
-	xfs_fsblock_t			new_fsb;
-	xfs_extlen_t			new_aglen;
+	struct xfs_refcount_intent	*ri;
 	int				error;
 
-	refc = container_of(item, struct xfs_refcount_intent, ri_list);
-	error = xfs_trans_log_finish_refcount_update(tp, CUD_ITEM(done),
-			refc->ri_type, refc->ri_startblock, refc->ri_blockcount,
-			&new_fsb, &new_aglen, state);
+	ri = container_of(item, struct xfs_refcount_intent, ri_list);
+	error = xfs_trans_log_finish_refcount_update(tp, CUD_ITEM(done), ri,
+			state);
 
 	/* Did we run out of reservation?  Requeue what we didn't finish. */
-	if (!error && new_aglen > 0) {
-		ASSERT(refc->ri_type == XFS_REFCOUNT_INCREASE ||
-		       refc->ri_type == XFS_REFCOUNT_DECREASE);
-		refc->ri_startblock = new_fsb;
-		refc->ri_blockcount = new_aglen;
+	if (!error && ri->ri_blockcount > 0) {
+		ASSERT(ri->ri_type == XFS_REFCOUNT_INCREASE ||
+		       ri->ri_type == XFS_REFCOUNT_DECREASE);
 		return -EAGAIN;
 	}
-	kmem_cache_free(xfs_refcount_intent_cache, refc);
+	kmem_cache_free(xfs_refcount_intent_cache, ri);
 	return error;
 }
 
 /* Abort all pending CUIs. */
 STATIC void
@@ -461,22 +451,17 @@ xfs_cui_validate_phys(
 STATIC int
 xfs_cui_item_recover(
 	struct xfs_log_item		*lip,
 	struct list_head		*capture_list)
 {
-	struct xfs_bmbt_irec		irec;
 	struct xfs_cui_log_item		*cuip = CUI_ITEM(lip);
-	struct xfs_phys_extent		*refc;
 	struct xfs_cud_log_item		*cudp;
 	struct xfs_trans		*tp;
 	struct xfs_btree_cur		*rcur = NULL;
 	struct xfs_mount		*mp = lip->li_log->l_mp;
-	xfs_fsblock_t			new_fsb;
-	xfs_extlen_t			new_len;
 	unsigned int			refc_type;
 	bool				requeue_only = false;
-	enum xfs_refcount_intent_type	type;
 	int				i;
 	int				error = 0;
 
 	/*
 	 * First check the validity of the extents described by the
@@ -511,45 +496,50 @@ xfs_cui_item_recover(
 		return error;
 
 	cudp = xfs_trans_get_cud(tp, cuip);
 
 	for (i = 0; i < cuip->cui_format.cui_nextents; i++) {
+		struct xfs_refcount_intent	fake = { };
+		struct xfs_phys_extent		*refc;
+
 		refc = &cuip->cui_format.cui_extents[i];
 		refc_type = refc->pe_flags & XFS_REFCOUNT_EXTENT_TYPE_MASK;
 		switch (refc_type) {
 		case XFS_REFCOUNT_INCREASE:
 		case XFS_REFCOUNT_DECREASE:
 		case XFS_REFCOUNT_ALLOC_COW:
 		case XFS_REFCOUNT_FREE_COW:
-			type = refc_type;
+			fake.ri_type = refc_type;
 			break;
 		default:
 			XFS_CORRUPTION_ERROR(__func__, XFS_ERRLEVEL_LOW, mp,
 					&cuip->cui_format,
 					sizeof(cuip->cui_format));
 			error = -EFSCORRUPTED;
 			goto abort_error;
 		}
-		if (requeue_only) {
-			new_fsb = refc->pe_startblock;
-			new_len = refc->pe_len;
-		} else
+
+		fake.ri_startblock = refc->pe_startblock;
+		fake.ri_blockcount = refc->pe_len;
+		if (!requeue_only)
 			error = xfs_trans_log_finish_refcount_update(tp, cudp,
-				type, refc->pe_startblock, refc->pe_len,
-				&new_fsb, &new_len, &rcur);
+					&fake, &rcur);
 		if (error == -EFSCORRUPTED)
 			XFS_CORRUPTION_ERROR(__func__, XFS_ERRLEVEL_LOW, mp,
 					&cuip->cui_format,
 					sizeof(cuip->cui_format));
 		if (error)
 			goto abort_error;
 
 		/* Requeue what we didn't finish. */
-		if (new_len > 0) {
-			irec.br_startblock = new_fsb;
-			irec.br_blockcount = new_len;
-			switch (type) {
+		if (fake.ri_blockcount > 0) {
+			struct xfs_bmbt_irec	irec = {
+				.br_startblock	= fake.ri_startblock,
+				.br_blockcount	= fake.ri_blockcount,
+			};
+
+			switch (fake.ri_type) {
 			case XFS_REFCOUNT_INCREASE:
 				xfs_refcount_increase_extent(tp, &irec);
 				break;
 			case XFS_REFCOUNT_DECREASE:
 				xfs_refcount_decrease_extent(tp, &irec);
diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index 0cd62031e53f..20e2ec8b73aa 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -3206,39 +3206,32 @@ DEFINE_AG_ERROR_EVENT(xfs_refcount_find_shared_error);
 DEFINE_REFCOUNT_DEFERRED_EVENT(xfs_refcount_defer);
 DEFINE_REFCOUNT_DEFERRED_EVENT(xfs_refcount_deferred);
 
 TRACE_EVENT(xfs_refcount_finish_one_leftover,
 	TP_PROTO(struct xfs_mount *mp, xfs_agnumber_t agno,
-		 int type, xfs_agblock_t agbno, xfs_extlen_t len,
-		 xfs_agblock_t new_agbno, xfs_extlen_t new_len),
-	TP_ARGS(mp, agno, type, agbno, len, new_agbno, new_len),
+		 int type, xfs_agblock_t agbno, xfs_extlen_t len),
+	TP_ARGS(mp, agno, type, agbno, len),
 	TP_STRUCT__entry(
 		__field(dev_t, dev)
 		__field(xfs_agnumber_t, agno)
 		__field(int, type)
 		__field(xfs_agblock_t, agbno)
 		__field(xfs_extlen_t, len)
-		__field(xfs_agblock_t, new_agbno)
-		__field(xfs_extlen_t, new_len)
 	),
 	TP_fast_assign(
 		__entry->dev = mp->m_super->s_dev;
 		__entry->agno = agno;
 		__entry->type = type;
 		__entry->agbno = agbno;
 		__entry->len = len;
-		__entry->new_agbno = new_agbno;
-		__entry->new_len = new_len;
 	),
-	TP_printk("dev %d:%d type %d agno 0x%x agbno 0x%x fsbcount 0x%x new_agbno 0x%x new_fsbcount 0x%x",
+	TP_printk("dev %d:%d type %d agno 0x%x agbno 0x%x fsbcount 0x%x",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
 		  __entry->type,
 		  __entry->agno,
 		  __entry->agbno,
-		  __entry->len,
-		  __entry->new_agbno,
-		  __entry->new_len)
+		  __entry->len)
 );
 
 /* simple inode-based error/%ip tracepoint class */
 DECLARE_EVENT_CLASS(xfs_inode_error_class,
 	TP_PROTO(struct xfs_inode *ip, int error, unsigned long caller_ip),
-- 
2.49.0.rc1.451.g8f38331e32-goog


