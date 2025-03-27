Return-Path: <stable+bounces-126896-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A0AA7408D
	for <lists+stable@lfdr.de>; Thu, 27 Mar 2025 23:00:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 196333B8C16
	for <lists+stable@lfdr.de>; Thu, 27 Mar 2025 21:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7F92BB15;
	Thu, 27 Mar 2025 21:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kF0PDu7Y"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A672433B1
	for <stable@vger.kernel.org>; Thu, 27 Mar 2025 21:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743112778; cv=none; b=XDL1mT230XiPi6OsDMb7/ExmqejQlImq5kG3ucc+R6yM2EsKXV5N5ZjyoxxdauLxXln4htCqR6P5A4Pqr29OywnKx//j4sOGtlLGCjlwQ0nE5Pd/fPijNelPq595EgJ+DSowy/op6Ohh35dc4uZCqpOaleZTQB7VlKxbYqFRB/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743112778; c=relaxed/simple;
	bh=68iCxtq3eqh/5LrxNXP4pPWSsQmxG0byjo1XY31MPHs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Auiq48L47duSgHhHXFq7c0erCWshXr0Uy4mybf8MqL3XohwvFbJyq7EYDW1WWHRL60AaL6BZyExhYzSJ0gLAAdj6kLR+8UeNODbWnJb+tUifzMJKH7LnfOeK0aHZIBhbK4w0LWvCWmRPzFa9f9jjPT/t/nuPMDtbBYg2HQuk21A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kF0PDu7Y; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-22423adf751so30237625ad.2
        for <stable@vger.kernel.org>; Thu, 27 Mar 2025 14:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743112775; x=1743717575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l3Wh/ZlA2rCYVwKHlXRCit9ymWlD12bPdzvPo8LZOzk=;
        b=kF0PDu7Y5FNcAwa5nTbPE0VtZBmSI3G41Lt2dROD+jXSBX1RsPOb7ThbYm1luIuJCt
         JPcXIQ6EsgP3yruE6y6CiWiu79qnR+YT6pIo04zwWdJMsSZ6HQqqOLBr7viEzVSDdQRb
         DnkNMehehaKhaYiJrfW4SvoxmdzysfOpB49b9Nf4WyzUBnrQMTxE9kcFDIBokgPXrAGq
         QSLrm4l2gxt716idcJiyZRSouuoBK6d2XgZCI0x/Y7sXSN4goK8UhDrUWVmYslM7mNUR
         RvCxcnDU1dfA2ATXJ8ofDXui1HAyrR9W8pHfxgDn5dYb7R0thDsRl7cLE6FGn0vYdJXy
         4Ipw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743112775; x=1743717575;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l3Wh/ZlA2rCYVwKHlXRCit9ymWlD12bPdzvPo8LZOzk=;
        b=ZBv2FdmLnI/yqsu+dvdlNE2lPXPJH0sjzdUkn/o1jUs7+XAQAkXH2tnKChVZ7lvqDA
         sCmQFeKx/2t10g5UpawvcOpx8PHsqxEvvUAu8Lx/8IksHiT36sxm1nhhRuFMQ6hcdl8Y
         38l0FQ1kkTJQPqWM60LLmNFfOi408DMLRUbp8wRqeTVcFTaTKHPxNN5Vd8I+dLSAJ8Fk
         MgcuFL0lKzkWDUgWKM5FNEusdrnniWkCCjtMgECpH6XXjxLLJCni7QkCF2k3JBPs12r7
         BE+ekWoFtxtv3v42+EQc+aCIJXEh/Vf8T3kwcPUO8XzX8UQP/wpqShumMoSy5LdOZd9S
         UKDA==
X-Gm-Message-State: AOJu0YxlY8LePmYFZ0RULdSr/msP7ecgPgse6c9lryQGlvdniEjHKT58
	DL8Xm7R1T9wlq6Duy++W7qOYKGPuBnQW18tOV/9xfhXpJg5bcGRv9sp/RGBB
X-Gm-Gg: ASbGnctREPc+fu3zeXIcjatWmHkFfR2TcCqYDQngal3AE3Ud+pKgwp3CmrHvyMQ4nuR
	3KOGU9xWS+cZ7kVH3Vf6L5xhoJxRTlRwCUDCQnHL04kCfHYuYDHuyadgss4cGo3VUVuFT8Atduq
	5dLdWKqIrHwN6I4tkEe+HhbtoslGL5xAD1+2s5gio1Dt3A8RGbNgxqN4JbTgyYH31HyZzpiN+qs
	4xNtnW1mo2xoKH9+YdXMKbUFahfnOTdbI6aw+BhdEDGFMcpR7fqu/Bt4OHHzRbIZ8ltHLkj/Ifq
	JyL3oM8gL+Aj+7tAejNWlgI3Gp2LhdV/1+RhdOqi11DarzNeN/NTjs8PNMqk+BWJ1PlSYoXc
X-Google-Smtp-Source: AGHT+IHxLTG/tR5wGxk6InRt2IWu/YNMq0KUdkrOkhy6Xgu146vmZZrSEx91JgU4qKet6tniKkJ8ew==
X-Received: by 2002:a17:903:18c:b0:220:ca39:d453 with SMTP id d9443c01a7336-22804855e3emr57630495ad.17.1743112775259;
        Thu, 27 Mar 2025 14:59:35 -0700 (PDT)
Received: from lrumancik.svl.corp.google.com ([2620:15c:2c5:11:4c1f:714f:2dac:8baf])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291f1ecec0sm4662275ad.241.2025.03.27.14.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 14:59:34 -0700 (PDT)
From: Leah Rumancik <leah.rumancik@gmail.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev,
	"Darrick J. Wong" <djwong@kernel.org>,
	Dave Chinner <dchinner@redhat.com>,
	Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH 6.1] xfs: give xfs_extfree_intent its own perag reference
Date: Thu, 27 Mar 2025 14:59:24 -0700
Message-ID: <20250327215925.3423507-1-leah.rumancik@gmail.com>
X-Mailer: git-send-email 2.49.0.472.ge94155a9ec-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Darrick J. Wong" <djwong@kernel.org>

[ Upstream commit f6b384631e1e3482c24e35b53adbd3da50e47e8f ]

Give the xfs_extfree_intent an passive reference to the perag structure
data.  This reference will be used to enable scrub intent draining
functionality in subsequent patches.  The space being freed must already
be allocated, so we need to able to run even if the AG is being offlined
or shrunk.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Dave Chinner <dchinner@redhat.com>
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
Acked-by: "Darrick J. Wong" <djwong@kernel.org>
---

This is to fix build fialure noted here:
https://lore.kernel.org/stable/8c6125d7-363c-42b3-bdbb-f802cb8b4408@web.de/

Tested on auto group x 9 configs with no regressions seen.

Already ack'd on xfs-stable list.

fs/xfs/libxfs/xfs_alloc.c |  7 +++--
 fs/xfs/libxfs/xfs_alloc.h |  4 +++
 fs/xfs/xfs_extfree_item.c | 58 +++++++++++++++++++++++++--------------
 3 files changed, 47 insertions(+), 22 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_alloc.c b/fs/xfs/libxfs/xfs_alloc.c
index e44f3f5c6d27..c08265f19136 100644
--- a/fs/xfs/libxfs/xfs_alloc.c
+++ b/fs/xfs/libxfs/xfs_alloc.c
@@ -2509,30 +2509,31 @@ xfs_defer_agfl_block(
 	xefi->xefi_owner = oinfo->oi_owner;
 	xefi->xefi_agresv = XFS_AG_RESV_AGFL;
 
 	trace_xfs_agfl_free_defer(mp, agno, 0, agbno, 1);
 
+	xfs_extent_free_get_group(mp, xefi);
 	xfs_defer_add(tp, XFS_DEFER_OPS_TYPE_AGFL_FREE, &xefi->xefi_list);
 	return 0;
 }
 
 /*
  * Add the extent to the list of extents to be free at transaction end.
  * The list is maintained sorted (by block number).
  */
 int
 __xfs_free_extent_later(
 	struct xfs_trans		*tp,
 	xfs_fsblock_t			bno,
 	xfs_filblks_t			len,
 	const struct xfs_owner_info	*oinfo,
 	enum xfs_ag_resv_type		type,
 	bool				skip_discard)
 {
 	struct xfs_extent_free_item	*xefi;
-#ifdef DEBUG
 	struct xfs_mount		*mp = tp->t_mountp;
+#ifdef DEBUG
 	xfs_agnumber_t			agno;
 	xfs_agblock_t			agbno;
 
 	ASSERT(bno != NULLFSBLOCK);
 	ASSERT(len > 0);
@@ -2567,13 +2568,15 @@ __xfs_free_extent_later(
 			xefi->xefi_flags |= XFS_EFI_BMBT_BLOCK;
 		xefi->xefi_owner = oinfo->oi_owner;
 	} else {
 		xefi->xefi_owner = XFS_RMAP_OWN_NULL;
 	}
-	trace_xfs_bmap_free_defer(tp->t_mountp,
+	trace_xfs_bmap_free_defer(mp,
 			XFS_FSB_TO_AGNO(tp->t_mountp, bno), 0,
 			XFS_FSB_TO_AGBNO(tp->t_mountp, bno), len);
+
+	xfs_extent_free_get_group(mp, xefi);
 	xfs_defer_add(tp, XFS_DEFER_OPS_TYPE_FREE, &xefi->xefi_list);
 	return 0;
 }
 
 #ifdef DEBUG
diff --git a/fs/xfs/libxfs/xfs_alloc.h b/fs/xfs/libxfs/xfs_alloc.h
index bbedb18651de..2dd93d62150f 100644
--- a/fs/xfs/libxfs/xfs_alloc.h
+++ b/fs/xfs/libxfs/xfs_alloc.h
@@ -224,14 +224,18 @@ int __xfs_free_extent_later(struct xfs_trans *tp, xfs_fsblock_t bno,
 struct xfs_extent_free_item {
 	struct list_head	xefi_list;
 	uint64_t		xefi_owner;
 	xfs_fsblock_t		xefi_startblock;/* starting fs block number */
 	xfs_extlen_t		xefi_blockcount;/* number of blocks in extent */
+	struct xfs_perag	*xefi_pag;
 	unsigned int		xefi_flags;
 	enum xfs_ag_resv_type	xefi_agresv;
 };
 
+void xfs_extent_free_get_group(struct xfs_mount *mp,
+		struct xfs_extent_free_item *xefi);
+
 #define XFS_EFI_SKIP_DISCARD	(1U << 0) /* don't issue discard */
 #define XFS_EFI_ATTR_FORK	(1U << 1) /* freeing attr fork block */
 #define XFS_EFI_BMBT_BLOCK	(1U << 2) /* freeing bmap btree block */
 
 static inline int
diff --git a/fs/xfs/xfs_extfree_item.c b/fs/xfs/xfs_extfree_item.c
index 9c726f082285..ab9d0e8b77da 100644
--- a/fs/xfs/xfs_extfree_item.c
+++ b/fs/xfs/xfs_extfree_item.c
@@ -348,32 +348,27 @@ xfs_trans_free_extent(
 	struct xfs_extent_free_item	*xefi)
 {
 	struct xfs_owner_info		oinfo = { };
 	struct xfs_mount		*mp = tp->t_mountp;
 	struct xfs_extent		*extp;
-	struct xfs_perag		*pag;
 	uint				next_extent;
-	xfs_agnumber_t			agno = XFS_FSB_TO_AGNO(mp,
-							xefi->xefi_startblock);
 	xfs_agblock_t			agbno = XFS_FSB_TO_AGBNO(mp,
 							xefi->xefi_startblock);
 	int				error;
 
 	oinfo.oi_owner = xefi->xefi_owner;
 	if (xefi->xefi_flags & XFS_EFI_ATTR_FORK)
 		oinfo.oi_flags |= XFS_OWNER_INFO_ATTR_FORK;
 	if (xefi->xefi_flags & XFS_EFI_BMBT_BLOCK)
 		oinfo.oi_flags |= XFS_OWNER_INFO_BMBT_BLOCK;
 
-	trace_xfs_bmap_free_deferred(tp->t_mountp, agno, 0, agbno,
-			xefi->xefi_blockcount);
+	trace_xfs_bmap_free_deferred(tp->t_mountp, xefi->xefi_pag->pag_agno, 0,
+			agbno, xefi->xefi_blockcount);
 
-	pag = xfs_perag_get(mp, agno);
-	error = __xfs_free_extent(tp, pag, agbno, xefi->xefi_blockcount,
-			&oinfo, xefi->xefi_agresv,
+	error = __xfs_free_extent(tp, xefi->xefi_pag, agbno,
+			xefi->xefi_blockcount, &oinfo, xefi->xefi_agresv,
 			xefi->xefi_flags & XFS_EFI_SKIP_DISCARD);
-	xfs_perag_put(pag);
 
 	/*
 	 * Mark the transaction dirty, even on error. This ensures the
 	 * transaction is aborted, which:
 	 *
@@ -398,18 +393,17 @@ static int
 xfs_extent_free_diff_items(
 	void				*priv,
 	const struct list_head		*a,
 	const struct list_head		*b)
 {
-	struct xfs_mount		*mp = priv;
 	struct xfs_extent_free_item	*ra;
 	struct xfs_extent_free_item	*rb;
 
 	ra = container_of(a, struct xfs_extent_free_item, xefi_list);
 	rb = container_of(b, struct xfs_extent_free_item, xefi_list);
-	return  XFS_FSB_TO_AGNO(mp, ra->xefi_startblock) -
-		XFS_FSB_TO_AGNO(mp, rb->xefi_startblock);
+
+	return ra->xefi_pag->pag_agno - rb->xefi_pag->pag_agno;
 }
 
 /* Log a free extent to the intent item. */
 STATIC void
 xfs_extent_free_log_item(
@@ -464,44 +458,68 @@ xfs_extent_free_create_done(
 	unsigned int			count)
 {
 	return &xfs_trans_get_efd(tp, EFI_ITEM(intent), count)->efd_item;
 }
 
+/* Take a passive ref to the AG containing the space we're freeing. */
+void
+xfs_extent_free_get_group(
+	struct xfs_mount		*mp,
+	struct xfs_extent_free_item	*xefi)
+{
+	xfs_agnumber_t			agno;
+
+	agno = XFS_FSB_TO_AGNO(mp, xefi->xefi_startblock);
+	xefi->xefi_pag = xfs_perag_get(mp, agno);
+}
+
+/* Release a passive AG ref after some freeing work. */
+static inline void
+xfs_extent_free_put_group(
+	struct xfs_extent_free_item	*xefi)
+{
+	xfs_perag_put(xefi->xefi_pag);
+}
+
 /* Process a free extent. */
 STATIC int
 xfs_extent_free_finish_item(
 	struct xfs_trans		*tp,
 	struct xfs_log_item		*done,
 	struct list_head		*item,
 	struct xfs_btree_cur		**state)
 {
 	struct xfs_extent_free_item	*xefi;
 	int				error;
 
 	xefi = container_of(item, struct xfs_extent_free_item, xefi_list);
 
 	error = xfs_trans_free_extent(tp, EFD_ITEM(done), xefi);
+
+	xfs_extent_free_put_group(xefi);
 	kmem_cache_free(xfs_extfree_item_cache, xefi);
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
 	struct xfs_extent_free_item	*xefi;
 
 	xefi = container_of(item, struct xfs_extent_free_item, xefi_list);
+
+	xfs_extent_free_put_group(xefi);
 	kmem_cache_free(xfs_extfree_item_cache, xefi);
 }
 
 const struct xfs_defer_op_type xfs_extent_free_defer_type = {
 	.max_items	= XFS_EFI_MAX_FAST_EXTENTS,
@@ -528,46 +546,44 @@ xfs_agfl_free_finish_item(
 	struct xfs_efd_log_item		*efdp = EFD_ITEM(done);
 	struct xfs_extent_free_item	*xefi;
 	struct xfs_extent		*extp;
 	struct xfs_buf			*agbp;
 	int				error;
-	xfs_agnumber_t			agno;
 	xfs_agblock_t			agbno;
 	uint				next_extent;
-	struct xfs_perag		*pag;
 
 	xefi = container_of(item, struct xfs_extent_free_item, xefi_list);
 	ASSERT(xefi->xefi_blockcount == 1);
-	agno = XFS_FSB_TO_AGNO(mp, xefi->xefi_startblock);
 	agbno = XFS_FSB_TO_AGBNO(mp, xefi->xefi_startblock);
 	oinfo.oi_owner = xefi->xefi_owner;
 
-	trace_xfs_agfl_free_deferred(mp, agno, 0, agbno, xefi->xefi_blockcount);
+	trace_xfs_agfl_free_deferred(mp, xefi->xefi_pag->pag_agno, 0, agbno,
+			xefi->xefi_blockcount);
 
-	pag = xfs_perag_get(mp, agno);
-	error = xfs_alloc_read_agf(pag, tp, 0, &agbp);
+	error = xfs_alloc_read_agf(xefi->xefi_pag, tp, 0, &agbp);
 	if (!error)
-		error = xfs_free_agfl_block(tp, agno, agbno, agbp, &oinfo);
-	xfs_perag_put(pag);
+		error = xfs_free_agfl_block(tp, xefi->xefi_pag->pag_agno,
+				agbno, agbp, &oinfo);
 
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
 	extp->ext_start = xefi->xefi_startblock;
 	extp->ext_len = xefi->xefi_blockcount;
 	efdp->efd_next_extent++;
 
+	xfs_extent_free_put_group(xefi);
 	kmem_cache_free(xfs_extfree_item_cache, xefi);
 	return error;
 }
 
 /* sub-type with special handling for AGFL deferred frees */
@@ -640,11 +656,13 @@ xfs_efi_item_recover(
 		extp = &efip->efi_format.efi_extents[i];
 
 		fake.xefi_startblock = extp->ext_start;
 		fake.xefi_blockcount = extp->ext_len;
 
+		xfs_extent_free_get_group(mp, &fake);
 		error = xfs_trans_free_extent(tp, efdp, &fake);
+		xfs_extent_free_put_group(&fake);
 		if (error == -EFSCORRUPTED)
 			XFS_CORRUPTION_ERROR(__func__, XFS_ERRLEVEL_LOW, mp,
 					extp, sizeof(*extp));
 		if (error)
 			goto abort_error;
-- 
2.49.0.472.ge94155a9ec-goog


