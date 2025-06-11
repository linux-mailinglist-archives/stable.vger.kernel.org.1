Return-Path: <stable+bounces-152461-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36481AD608F
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 23:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E5843A9F90
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 21:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1252BDC28;
	Wed, 11 Jun 2025 21:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nbpDTbtE"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3553A2BD586
	for <stable@vger.kernel.org>; Wed, 11 Jun 2025 21:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749675702; cv=none; b=ArgJqpCwV6BsTGVyweYFj1hFEqy6x0dM+qr4fnDZipNo4VVgQ9u5lwI9VcqhgPThzJq+Z2sMUqfUwb3VGJz5qm+5HWRyQwui0nEMNccm/6IoG9WsXgfBJczr5eloimH7pO3k0eGTfHPkg2u8DythU/myDSQcTiaWI9t2NvNvE20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749675702; c=relaxed/simple;
	bh=SnbSz1PFXeGQcR6SbyF5h2tun7RW4MEGOqaPeAnZCCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uBhDj3a9qqJuSsbNVlMcmdVZwwo6IlofNRXZk3o+ti22sKLtktBOQOTJEtgcoA5EhfTJyE0gIykkAhvTbpYpxuEJ+l72WN8oSLafwyh+yhRTH4WISETqXIXg9ZagmUJY0p2hgy2sZuormpRVkg3G28vLAw6iz49zxey/kwosCYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nbpDTbtE; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-235ef62066eso3136535ad.3
        for <stable@vger.kernel.org>; Wed, 11 Jun 2025 14:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749675700; x=1750280500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A55kwomAR0Cx6KCYYxRQ9CmZaSeG18xPNWaIusqMLBI=;
        b=nbpDTbtEexuTRp/Osh67/KGYA2IQKhYC43lC89WvUwTcoOFpk73V8RmowjE4W4FHw6
         +XMQW2fLejJ7PHkwhTiNvIK3D0Fc9BepmijIlRWUd4kz6ZLZ/AUyCplWWfBaDtuGOkbU
         xpZ4EHonf+r4Tv1/n/5DSq9NS9zEKoD4ojLV9Kth+Zvrq1PVcbJaIWRwZBJUvXQnPnJw
         BZRN4M64G4jnE0Gg0VmIw0toN916FZOddOCE4zkmm/18q3RYjioLDRImPtj0jfP5ZMW7
         IHoSh+Ad1M6BP64UIaa7Z1jW3ZX0E+f5S1Y9aEhgryK9Sv8htddMfMnU0kkmx7YogI1C
         W6kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749675700; x=1750280500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A55kwomAR0Cx6KCYYxRQ9CmZaSeG18xPNWaIusqMLBI=;
        b=KoCl2lhlvIh51vx77otows2i12pmH4js6bDDXYZDcpS+s89Az/8W2ReDavDQzMofGc
         1Eg0cZdQRTnW0JyKJpsQ1ib6yckVpVjV7pnnv1a+setkD3u3NrHV+ebmUOctVyNfOVck
         O65N9Q2OE5vGYYUNNFn2C0MxxremG63YWDRWfa2wvAg79+0ofAEDjxMBKVLDOBSQDbW9
         HL0BLCVeEeEL9gO0VgjHTSbit3yqpsg2pjB6mW1se0s3EN3i9zYeJcCHutcKsr/7gvKb
         Z4/fCj1vRlyIGsCYGBciP1L+oYaGpUlqpZdmiAfymMtn0aTn/tjWI21cGcettcR/oTqw
         g0XQ==
X-Gm-Message-State: AOJu0YyzPlPsMzC2bUAFxO2cPC0YNfb+jMoKPEVlAnpsCSoAZmTlM1CO
	czdWDd/ZyVRb9g0F8mDU+xjGUWBNlFQm2Hcfgkqup5Tq35BIuPjojoQQJQteiyKw
X-Gm-Gg: ASbGncswZR52p5DhNrkQMZ5XWwW0ueacroLUQT3t5NVEgs5V4p5T793eZ63/W00O/wJ
	QXscqNzUZmAeN0m2JBjRDAMM9AXtP7C8dJ9FAuiQMSUm/QZeiu43qGub59ujct8M2LLU5mYM9bF
	vDG+McCTT84kqM2Lgp9cGNAJqjT9I0msBICNAcMIwwzRPGKwRvQd3v+G2ZF6eiSjvADjtPCRmCw
	PsHlV9PCHuA2F9CYh7VLBfQ8V3o54ZczZJnVu1PxjQpFGCHm7Svw36kHM1MFkv7ho4Cdf35etDF
	ZAH62zfsJg1wUEItT75OfwETM00rB3dKp091sSk0oebdUwvxUZyIleBeSfAE629pLzAkM3KmL35
	UJX1SjAscFbo=
X-Google-Smtp-Source: AGHT+IEJwcnJ7j3yy1hiX2JYtNIMV/SXCQ9HVeWwfXirRcHzIo6gvjX1l21/RkphWgiILJkxqSpeTg==
X-Received: by 2002:a17:903:2283:b0:235:caf9:8b08 with SMTP id d9443c01a7336-23641ac7e8amr67477245ad.23.1749675700304;
        Wed, 11 Jun 2025 14:01:40 -0700 (PDT)
Received: from lrumancik.svl.corp.google.com ([2620:15c:2c5:11:391:76ae:2143:7d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2364e6d9c86sm62005ad.101.2025.06.11.14.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 14:01:39 -0700 (PDT)
From: Leah Rumancik <leah.rumancik@gmail.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev,
	chandan.babu@oracle.com,
	catherine.hoang@oracle.com,
	djwong@kernel.org,
	Dave Chinner <dchinner@redhat.com>,
	Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH 6.1 07/23] xfs: fix xfs_btree_query_range callers to initialize btree rec fully
Date: Wed, 11 Jun 2025 14:01:11 -0700
Message-ID: <20250611210128.67687-8-leah.rumancik@gmail.com>
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

[ Upstream commit 75dc0345312221971903b2e28279b7e24b7dbb1b ]

Use struct initializers to ensure that the xfs_btree_irecs passed into
the query_range function are completely initialized.  No functional
changes, just closing some sloppy hygiene.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Dave Chinner <dchinner@redhat.com>
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
Acked-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_alloc.c    | 10 +++-------
 fs/xfs/libxfs/xfs_refcount.c | 13 +++++++------
 fs/xfs/libxfs/xfs_rmap.c     | 10 +++-------
 3 files changed, 13 insertions(+), 20 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_alloc.c b/fs/xfs/libxfs/xfs_alloc.c
index c08265f19136..cd5b197d7046 100644
--- a/fs/xfs/libxfs/xfs_alloc.c
+++ b/fs/xfs/libxfs/xfs_alloc.c
@@ -3543,19 +3543,15 @@ xfs_alloc_query_range(
 	const struct xfs_alloc_rec_incore	*low_rec,
 	const struct xfs_alloc_rec_incore	*high_rec,
 	xfs_alloc_query_range_fn		fn,
 	void					*priv)
 {
-	union xfs_btree_irec			low_brec;
-	union xfs_btree_irec			high_brec;
-	struct xfs_alloc_query_range_info	query;
+	union xfs_btree_irec			low_brec = { .a = *low_rec };
+	union xfs_btree_irec			high_brec = { .a = *high_rec };
+	struct xfs_alloc_query_range_info	query = { .priv = priv, .fn = fn };
 
 	ASSERT(cur->bc_btnum == XFS_BTNUM_BNO);
-	low_brec.a = *low_rec;
-	high_brec.a = *high_rec;
-	query.priv = priv;
-	query.fn = fn;
 	return xfs_btree_query_range(cur, &low_brec, &high_brec,
 			xfs_alloc_query_range_helper, &query);
 }
 
 /* Find all free space records. */
diff --git a/fs/xfs/libxfs/xfs_refcount.c b/fs/xfs/libxfs/xfs_refcount.c
index 4ec7a81dd3ef..7e16e76fd2e1 100644
--- a/fs/xfs/libxfs/xfs_refcount.c
+++ b/fs/xfs/libxfs/xfs_refcount.c
@@ -1901,12 +1901,17 @@ xfs_refcount_recover_cow_leftovers(
 	struct xfs_trans		*tp;
 	struct xfs_btree_cur		*cur;
 	struct xfs_buf			*agbp;
 	struct xfs_refcount_recovery	*rr, *n;
 	struct list_head		debris;
-	union xfs_btree_irec		low;
-	union xfs_btree_irec		high;
+	union xfs_btree_irec		low = {
+		.rc.rc_domain		= XFS_REFC_DOMAIN_COW,
+	};
+	union xfs_btree_irec		high = {
+		.rc.rc_domain		= XFS_REFC_DOMAIN_COW,
+		.rc.rc_startblock	= -1U,
+	};
 	xfs_fsblock_t			fsb;
 	int				error;
 
 	/* reflink filesystems mustn't have AGs larger than 2^31-1 blocks */
 	BUILD_BUG_ON(XFS_MAX_CRC_AG_BLOCKS >= XFS_REFC_COWFLAG);
@@ -1933,14 +1938,10 @@ xfs_refcount_recover_cow_leftovers(
 	if (error)
 		goto out_trans;
 	cur = xfs_refcountbt_init_cursor(mp, tp, agbp, pag);
 
 	/* Find all the leftover CoW staging extents. */
-	memset(&low, 0, sizeof(low));
-	memset(&high, 0, sizeof(high));
-	low.rc.rc_domain = high.rc.rc_domain = XFS_REFC_DOMAIN_COW;
-	high.rc.rc_startblock = -1U;
 	error = xfs_btree_query_range(cur, &low, &high,
 			xfs_refcount_recover_extent, &debris);
 	xfs_btree_del_cursor(cur, error);
 	xfs_trans_brelse(tp, agbp);
 	xfs_trans_cancel(tp);
diff --git a/fs/xfs/libxfs/xfs_rmap.c b/fs/xfs/libxfs/xfs_rmap.c
index b56aca1e7c66..95d3599561ce 100644
--- a/fs/xfs/libxfs/xfs_rmap.c
+++ b/fs/xfs/libxfs/xfs_rmap.c
@@ -2335,18 +2335,14 @@ xfs_rmap_query_range(
 	const struct xfs_rmap_irec		*low_rec,
 	const struct xfs_rmap_irec		*high_rec,
 	xfs_rmap_query_range_fn			fn,
 	void					*priv)
 {
-	union xfs_btree_irec			low_brec;
-	union xfs_btree_irec			high_brec;
-	struct xfs_rmap_query_range_info	query;
+	union xfs_btree_irec			low_brec = { .r = *low_rec };
+	union xfs_btree_irec			high_brec = { .r = *high_rec };
+	struct xfs_rmap_query_range_info	query = { .priv = priv, .fn = fn };
 
-	low_brec.r = *low_rec;
-	high_brec.r = *high_rec;
-	query.priv = priv;
-	query.fn = fn;
 	return xfs_btree_query_range(cur, &low_brec, &high_brec,
 			xfs_rmap_query_range_helper, &query);
 }
 
 /* Find all rmaps. */
-- 
2.50.0.rc1.591.g9c95f17f64-goog


