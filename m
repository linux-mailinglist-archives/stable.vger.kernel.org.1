Return-Path: <stable+bounces-124359-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E02A60289
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 21:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2097119C5818
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 20:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1221F3FEE;
	Thu, 13 Mar 2025 20:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eDw6MFQy"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F2D1F426F
	for <stable@vger.kernel.org>; Thu, 13 Mar 2025 20:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741897567; cv=none; b=MZmLL+tvjBxl9j2nh1VZoybbEq9kg61JIDEXfrEqshVbDhbndsCCVh5w6vDo7SUtn/+vRC0fj4ba01ww/2lwSIMfERKN1M0reHi/6Utt+jutuGWdKyjaOffqjAdzgj4Owj53Gy1w0ylAlfr2JoBe1WrwlFTC+8NHquo5w7i0pz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741897567; c=relaxed/simple;
	bh=/8KQR7pMqrgCwL/9g/qjQnSVE+XVIoHE/RXfcfLWGnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TWyU5PHbHy5tX8760rJaovGFVV5+0ZEs72TwOwsHRsmvAyQJN3RAS749C/i9vSWOzywaC6TG7kV/uSo3p5iyh2vyiMyQg0dud9nrc4mpPSb9AnkUm7dNbY//zxtZJV3WHezPaNfl3wvVK8ThrRpU8+ctIYg3x32D3DgMB79l6rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eDw6MFQy; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-223594b3c6dso28598435ad.2
        for <stable@vger.kernel.org>; Thu, 13 Mar 2025 13:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741897565; x=1742502365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6EIi9oohlOX35hkJs+x9Jfxms/2wjZJ5Tssf50wokGU=;
        b=eDw6MFQytDI8/gy4w+UmS9NYRxzdXIb9v1TmG+ocf4GV0b2n0WkCUIrSvej//SACLU
         hdxim/sXkdPzSTgwv3hY7L5ehes4IeS28oyT1xoJYPkcIN0fTG0Au0EJIBtr4qm9cauO
         N4hco4gjdm5FpyTSZQMzQTTUudZyZkVOOOp2wXFkilXEmWt+ReuTnelj6SSMPAx5WZzT
         qlhxUBgqj2O0lmJa6AxVXxAE0E3z0euWHZKpao96KfGrVFk9Zm1wlQ80uI6lRUqr+bF0
         yEdbt+K2z0VXa8va593UgJGe4zD24fqyejITNQTsjEyJMzzcTn4nk8t+Ke/QvfXlKV8O
         XI3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741897565; x=1742502365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6EIi9oohlOX35hkJs+x9Jfxms/2wjZJ5Tssf50wokGU=;
        b=GFIvQpc41Um7DwemvihB4IbGF2ntGZBlvmRS4n6hXk3Sr27b/cRPdonW6xSX+SW+Au
         OsjpyfyAucl1iF293s3tgs3J/mrv6knXg7ZR9h6BnCwXjM4HVvE5ZQijrI2Q+x5vkmFA
         E/ftJqBG2lfknSVIHShFYOGCnrRnfFRyOOLiwZKrF20+vaFGmGWeOIq7SEcSEId0n4HS
         CJt04HOMh5IizpmfiyyI44BhgGBsS73OZl+Y9N9wDhvHpU17+NLfuIsxe8QetBMGe5nU
         Ve2e8pZRVZBTq6isA35wwvuxFZefe/99rntE+E5VVfrk5yDi64o35l4CXyYyaSsbMUZJ
         yLww==
X-Gm-Message-State: AOJu0YxznDTjv9l+f0802B4YdC20rcSqTFUanUNkomxkbWOU3t8pZNWJ
	DK0eiSuWx+t+AyRCjY3/CnCVYSVH5mbT2E7MYyaGnanASIoal7hg9n0ToQ==
X-Gm-Gg: ASbGncu8/hHTHSEzyz3EPmFWdxjt8YYFmqhUmd5SRI47wierzo+1/SJMlkmrunIVWhP
	u9iZ2Rq0KVJ2+XBRGQYirS1IMSwMhcZmVIzPUV20YTDPzyvx0J3EvJ9g3kZ+9W0BGbNIVau9oy5
	AnlnkgHqaXyLcZeYhG6mGe9ZAUW+sKHkVpupH02GbYP2EvdmLHjykm7LjSaH6Lo/wBJ1nxp20eO
	eF2+9J5wDCxeFYLzK7aQMLTtPWpaXfr56AECfU9hDi/e/crt9qB1oCezfi4fNjZ5baj9NSHJ/Ek
	ZZWsYE5nfGRVtIk1Wkc32hHyrwu0xQggsv36vx9bXi6bq6g3KtGqvcEB8XkgLmifBIkKoYU=
X-Google-Smtp-Source: AGHT+IGzgdk4w2504xvGclLFhOgqJfQ6oS62dxm+Jzfvv+/z3KjbFv0LhuCALBL59PO5nJXX+BGjMQ==
X-Received: by 2002:a05:6a00:3d47:b0:736:2ff4:f255 with SMTP id d2e1a72fcca58-7371f199725mr789756b3a.15.1741897564737;
        Thu, 13 Mar 2025 13:26:04 -0700 (PDT)
Received: from lrumancik.svl.corp.google.com ([2620:15c:2c5:11:b233:743:91db:ac7b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56e9c94cesm1724455a12.6.2025.03.13.13.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 13:26:04 -0700 (PDT)
From: Leah Rumancik <leah.rumancik@gmail.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev,
	"Darrick J. Wong" <djwong@kernel.org>,
	Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH 6.1 02/29] xfs: pass xfs_extent_free_item directly through the log intent code
Date: Thu, 13 Mar 2025 13:25:22 -0700
Message-ID: <20250313202550.2257219-3-leah.rumancik@gmail.com>
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

[ Upstream commit 72ba455599ad13d08c29dafa22a32360e07b1961 ]

Pass the incore xfs_extent_free_item through the EFI logging code
instead of repeatedly boxing and unboxing parameters.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
Acked-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/xfs_extfree_item.c | 55 +++++++++++++++++++++------------------
 1 file changed, 30 insertions(+), 25 deletions(-)

diff --git a/fs/xfs/xfs_extfree_item.c b/fs/xfs/xfs_extfree_item.c
index d5130d1fcfae..618d2f9ff535 100644
--- a/fs/xfs/xfs_extfree_item.c
+++ b/fs/xfs/xfs_extfree_item.c
@@ -343,42 +343,49 @@ xfs_trans_get_efd(
  */
 static int
 xfs_trans_free_extent(
 	struct xfs_trans		*tp,
 	struct xfs_efd_log_item		*efdp,
-	xfs_fsblock_t			start_block,
-	xfs_extlen_t			ext_len,
-	const struct xfs_owner_info	*oinfo,
-	bool				skip_discard)
+	struct xfs_extent_free_item	*free)
 {
+	struct xfs_owner_info		oinfo = { };
 	struct xfs_mount		*mp = tp->t_mountp;
 	struct xfs_extent		*extp;
 	uint				next_extent;
-	xfs_agnumber_t			agno = XFS_FSB_TO_AGNO(mp, start_block);
+	xfs_agnumber_t			agno = XFS_FSB_TO_AGNO(mp,
+							free->xefi_startblock);
 	xfs_agblock_t			agbno = XFS_FSB_TO_AGBNO(mp,
-								start_block);
+							free->xefi_startblock);
 	int				error;
 
-	trace_xfs_bmap_free_deferred(tp->t_mountp, agno, 0, agbno, ext_len);
+	oinfo.oi_owner = free->xefi_owner;
+	if (free->xefi_flags & XFS_EFI_ATTR_FORK)
+		oinfo.oi_flags |= XFS_OWNER_INFO_ATTR_FORK;
+	if (free->xefi_flags & XFS_EFI_BMBT_BLOCK)
+		oinfo.oi_flags |= XFS_OWNER_INFO_BMBT_BLOCK;
+
+	trace_xfs_bmap_free_deferred(tp->t_mountp, agno, 0, agbno,
+			free->xefi_blockcount);
 
-	error = __xfs_free_extent(tp, start_block, ext_len,
-				  oinfo, XFS_AG_RESV_NONE, skip_discard);
+	error = __xfs_free_extent(tp, free->xefi_startblock,
+			free->xefi_blockcount, &oinfo, XFS_AG_RESV_NONE,
+			free->xefi_flags & XFS_EFI_SKIP_DISCARD);
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
-	extp->ext_start = start_block;
-	extp->ext_len = ext_len;
+	extp->ext_start = free->xefi_startblock;
+	extp->ext_len = free->xefi_blockcount;
 	efdp->efd_next_extent++;
 
 	return error;
 }
 
@@ -461,24 +468,16 @@ xfs_extent_free_finish_item(
 	struct xfs_trans		*tp,
 	struct xfs_log_item		*done,
 	struct list_head		*item,
 	struct xfs_btree_cur		**state)
 {
-	struct xfs_owner_info		oinfo = { };
 	struct xfs_extent_free_item	*free;
 	int				error;
 
 	free = container_of(item, struct xfs_extent_free_item, xefi_list);
-	oinfo.oi_owner = free->xefi_owner;
-	if (free->xefi_flags & XFS_EFI_ATTR_FORK)
-		oinfo.oi_flags |= XFS_OWNER_INFO_ATTR_FORK;
-	if (free->xefi_flags & XFS_EFI_BMBT_BLOCK)
-		oinfo.oi_flags |= XFS_OWNER_INFO_BMBT_BLOCK;
-	error = xfs_trans_free_extent(tp, EFD_ITEM(done),
-			free->xefi_startblock,
-			free->xefi_blockcount,
-			&oinfo, free->xefi_flags & XFS_EFI_SKIP_DISCARD);
+
+	error = xfs_trans_free_extent(tp, EFD_ITEM(done), free);
 	kmem_cache_free(xfs_extfree_item_cache, free);
 	return error;
 }
 
 /* Abort all pending EFIs. */
@@ -597,39 +596,45 @@ xfs_efi_item_recover(
 {
 	struct xfs_efi_log_item		*efip = EFI_ITEM(lip);
 	struct xfs_mount		*mp = lip->li_log->l_mp;
 	struct xfs_efd_log_item		*efdp;
 	struct xfs_trans		*tp;
-	struct xfs_extent		*extp;
 	int				i;
 	int				error = 0;
 
 	/*
 	 * First check the validity of the extents described by the
 	 * EFI.  If any are bad, then assume that all are bad and
 	 * just toss the EFI.
 	 */
 	for (i = 0; i < efip->efi_format.efi_nextents; i++) {
 		if (!xfs_efi_validate_ext(mp,
 					&efip->efi_format.efi_extents[i])) {
 			XFS_CORRUPTION_ERROR(__func__, XFS_ERRLEVEL_LOW, mp,
 					&efip->efi_format,
 					sizeof(efip->efi_format));
 			return -EFSCORRUPTED;
 		}
 	}
 
 	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_itruncate, 0, 0, 0, &tp);
 	if (error)
 		return error;
 	efdp = xfs_trans_get_efd(tp, efip, efip->efi_format.efi_nextents);
 
 	for (i = 0; i < efip->efi_format.efi_nextents; i++) {
+		struct xfs_extent_free_item	fake = {
+			.xefi_owner		= XFS_RMAP_OWN_UNKNOWN,
+		};
+		struct xfs_extent		*extp;
+
 		extp = &efip->efi_format.efi_extents[i];
-		error = xfs_trans_free_extent(tp, efdp, extp->ext_start,
-					      extp->ext_len,
-					      &XFS_RMAP_OINFO_ANY_OWNER, false);
+
+		fake.xefi_startblock = extp->ext_start;
+		fake.xefi_blockcount = extp->ext_len;
+
+		error = xfs_trans_free_extent(tp, efdp, &fake);
 		if (error == -EFSCORRUPTED)
 			XFS_CORRUPTION_ERROR(__func__, XFS_ERRLEVEL_LOW, mp,
 					extp, sizeof(*extp));
 		if (error)
 			goto abort_error;
-- 
2.49.0.rc1.451.g8f38331e32-goog


