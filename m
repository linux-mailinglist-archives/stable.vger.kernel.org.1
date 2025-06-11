Return-Path: <stable+bounces-152458-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E14AD608B
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 23:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EE677ACDEC
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 21:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F2623C4F9;
	Wed, 11 Jun 2025 21:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MA2+tx4Y"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C01525949A
	for <stable@vger.kernel.org>; Wed, 11 Jun 2025 21:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749675699; cv=none; b=n4Hswt6QleQCKRApzju0Mi12/6EFgA3M62RC+SF/9+JI9YllzdH9iP8C1/+/gU4I3pywTIFU6wM/hUMfijRW13Gu4iCyCUvzBgnPrRZz6ceqrZonmxtMO4IILX49RaBLqEUJSb+t5ST7/uvD/DdyTN/wFwCt6hwSkV9Vhx9FkSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749675699; c=relaxed/simple;
	bh=WZC16tA6aJUEWqtNgjQGGeYeu4azB2fsGGkdLDIZnYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BRRNpRVwLa2MQs3nE2FSZg4PGBR05s0zOZdhkeLXjSnFVQRNWwsrxnk1leCYJFT0fbkSmRACztmCJS29RMI49rnoNpiaCBeOykYL56j3XTyVTHtHdaX3K2oc8moMftC06OvG9XdImbSp8X6lapGiCfjE09VpaM4SFThx3A+ef1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MA2+tx4Y; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2351227b098so2349275ad.2
        for <stable@vger.kernel.org>; Wed, 11 Jun 2025 14:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749675697; x=1750280497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RlWzc6l9lT9W1GbljxTo4PAV3dP2vomnOuqVCWyE3wU=;
        b=MA2+tx4Yd5GXVP0GkiAOU4F0MwcRVKexGBEWrQGVc3wyqvOBO4RzinUhDERXNhecCv
         FQa9kLqeLyeZQTgbuZZ26VEA6IiplibIr01b9Qqq645fJrwPCspcIaLmswfMbTSBXNeB
         vuYg7bM3TRruT7bwISIxMlxl2nVOzUFg3+fDY25Ouxcx7GcnZRJWKbi+1IzJl1PGv7n0
         4lM2uNlykRtCY9Lfv+p6Wrx6opjBF15SueiL++2PQQ32A2cBEGyYPxV7pCGzZvjQPuw/
         Vr5n2QfskEIaRp1ND7X4jYId+Ro9tXFTAAoD78O3hz8FHWIcC0832DF+pce8EuQphUVR
         2LUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749675697; x=1750280497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RlWzc6l9lT9W1GbljxTo4PAV3dP2vomnOuqVCWyE3wU=;
        b=mcXxqHU7f0tefUdJG02UBWW7Yd41Rwyy/qL1Wp9X87l/8nOUgqeZKM9mMoGFMYKaMb
         OJt8Mu7y01AhM4D1T5FjMaiHSj8pQghKgLqoxLZWDh1XyqHM2SkGMZ8rCVFBFCBTn58m
         A6F605k6l3gOcT79YsYyC8KleXEL13bFr5hz3OkmffNPdBMj+07qApIsRO8VjWnuQI8x
         oMzIPMdVGifSspxSQUkbiMCVDUigAPjL16n4Wvfm9HjwSXh5k/BoVQJlSmKaCRkt2MQy
         iXfPtkOzEo3FD7cDbF+61WoBbNA7UYJBvy6aXvh5qb5Uk05sBb7vA1NerwGJcIUnkfZ8
         JyUQ==
X-Gm-Message-State: AOJu0Yyyq+iaIVVZwBKPxmWa9kZLAwmXAFru/5bAxnXOtgmKSLUAtLHG
	TqNqcxKngenNk9fppDoSUQ7Fn13JEJ4ba3IC/630eHg/LKJEIMX6gqzDALENbA+x
X-Gm-Gg: ASbGncurJx+kXAL7UtIusGVK4fGG5nNEx+ldZfn9aORNvZuz8Z5+p1BU5CzCyGd4yNR
	m7GTwygNUx0BmYmw/1G/Tk1K1lSRf1zuNe15FX6dpHj4tsBx4UY7uy3/+COluYCqNr2LhXYkcRp
	ZTXwwSE2asM4UtVYtBoPtXfbv/UJN1GM/Irfh0q5eBUBlig118KezujbgmX30oTeO6/yWi8fRV4
	vyoOojejvOwunqzgdiV3LDcUzTWubAnfPjj29xiOPnNtP5r7UzbL1j7cjQHYoNYG7y23sZDMdY3
	F1TWtLWRzT4pzxtt81tkbrBHPFZlT6ZK3WZ4WIUKuluG+/g+CJM66u56gIwq+WpdYWd9MwQKPgF
	DKWRB7icJWSQ=
X-Google-Smtp-Source: AGHT+IF0WJNNJTlclycX2Bk9pXPKqdLd84MqfMTC7OlO/eWK3jTG47ih+Z8TtYTAXs1uyqOtTcY+YA==
X-Received: by 2002:a17:903:78d:b0:235:be0:db4c with SMTP id d9443c01a7336-2364d8f0a17mr5825125ad.41.1749675697189;
        Wed, 11 Jun 2025 14:01:37 -0700 (PDT)
Received: from lrumancik.svl.corp.google.com ([2620:15c:2c5:11:391:76ae:2143:7d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2364e6d9c86sm62005ad.101.2025.06.11.14.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 14:01:36 -0700 (PDT)
From: Leah Rumancik <leah.rumancik@gmail.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev,
	chandan.babu@oracle.com,
	catherine.hoang@oracle.com,
	djwong@kernel.org,
	Dave Chinner <dchinner@redhat.com>,
	Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH 6.1 04/23] xfs: clean up the rtbitmap fsmap backend
Date: Wed, 11 Jun 2025 14:01:08 -0700
Message-ID: <20250611210128.67687-5-leah.rumancik@gmail.com>
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

[ Upstream commit f045dd00328d78f25d64913285f4547f772d13e2 ]

The rtbitmap fsmap backend doesn't query the rmapbt, so it's wasteful to
spend time initializing the rmap_irec objects.  Worse yet, the logic to
query the rtbitmap is spread across three separate functions, which is
unnecessarily difficult to follow.

Compute the start rtextent that we want from keys[0] directly and
combine the functions to avoid passing parameters around everywhere, and
consolidate all the logic into a single function.  At one point many
years ago I intended to use __xfs_getfsmap_rtdev as the launching point
for realtime rmapbt queries, but this hasn't been the case for a long
time.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Dave Chinner <dchinner@redhat.com>
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
Acked-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/xfs_fsmap.c | 62 +++++++---------------------------------------
 fs/xfs/xfs_trace.h | 25 +++++++++++++++++++
 2 files changed, 34 insertions(+), 53 deletions(-)

diff --git a/fs/xfs/xfs_fsmap.c b/fs/xfs/xfs_fsmap.c
index 7b72992c14d9..202f162515bd 100644
--- a/fs/xfs/xfs_fsmap.c
+++ b/fs/xfs/xfs_fsmap.c
@@ -510,76 +510,44 @@ xfs_getfsmap_rtdev_rtbitmap_helper(
 	irec.rm_flags = 0;
 
 	return xfs_getfsmap_helper(tp, info, &irec, rec_daddr, len_daddr);
 }
 
-/* Execute a getfsmap query against the realtime device. */
+/* Execute a getfsmap query against the realtime device rtbitmap. */
 STATIC int
-__xfs_getfsmap_rtdev(
+xfs_getfsmap_rtdev_rtbitmap(
 	struct xfs_trans		*tp,
 	const struct xfs_fsmap		*keys,
-	int				(*query_fn)(struct xfs_trans *,
-						    struct xfs_getfsmap_info *,
-						    xfs_rtblock_t start_rtb,
-						    xfs_rtblock_t end_rtb),
 	struct xfs_getfsmap_info	*info)
 {
+
+	struct xfs_rtalloc_rec		alow = { 0 };
+	struct xfs_rtalloc_rec		ahigh = { 0 };
 	struct xfs_mount		*mp = tp->t_mountp;
 	xfs_rtblock_t			start_rtb;
 	xfs_rtblock_t			end_rtb;
 	uint64_t			eofs;
-	int				error = 0;
+	int				error;
 
 	eofs = XFS_FSB_TO_BB(mp, mp->m_sb.sb_rextents * mp->m_sb.sb_rextsize);
 	if (keys[0].fmr_physical >= eofs)
 		return 0;
 	start_rtb = XFS_BB_TO_FSBT(mp,
 				keys[0].fmr_physical + keys[0].fmr_length);
 	end_rtb = XFS_BB_TO_FSB(mp, min(eofs - 1, keys[1].fmr_physical));
 
-	/* Set up search keys */
-	info->low.rm_startblock = start_rtb;
-	error = xfs_fsmap_owner_to_rmap(&info->low, &keys[0]);
-	if (error)
-		return error;
-	info->low.rm_offset = XFS_BB_TO_FSBT(mp, keys[0].fmr_offset);
-	info->low.rm_blockcount = 0;
-	xfs_getfsmap_set_irec_flags(&info->low, &keys[0]);
+	info->missing_owner = XFS_FMR_OWN_UNKNOWN;
 
 	/* Adjust the low key if we are continuing from where we left off. */
 	if (keys[0].fmr_length > 0) {
 		info->low_daddr = XFS_FSB_TO_BB(mp, start_rtb);
 		if (info->low_daddr >= eofs)
 			return 0;
 	}
 
-	info->high.rm_startblock = end_rtb;
-	error = xfs_fsmap_owner_to_rmap(&info->high, &keys[1]);
-	if (error)
-		return error;
-	info->high.rm_offset = XFS_BB_TO_FSBT(mp, keys[1].fmr_offset);
-	info->high.rm_blockcount = 0;
-	xfs_getfsmap_set_irec_flags(&info->high, &keys[1]);
-
-	trace_xfs_fsmap_low_key(mp, info->dev, NULLAGNUMBER, &info->low);
-	trace_xfs_fsmap_high_key(mp, info->dev, NULLAGNUMBER, &info->high);
-
-	return query_fn(tp, info, start_rtb, end_rtb);
-}
-
-/* Actually query the realtime bitmap. */
-STATIC int
-xfs_getfsmap_rtdev_rtbitmap_query(
-	struct xfs_trans		*tp,
-	struct xfs_getfsmap_info	*info,
-	xfs_rtblock_t			start_rtb,
-	xfs_rtblock_t			end_rtb)
-{
-	struct xfs_rtalloc_rec		alow = { 0 };
-	struct xfs_rtalloc_rec		ahigh = { 0 };
-	struct xfs_mount		*mp = tp->t_mountp;
-	int				error;
+	trace_xfs_fsmap_low_key_linear(mp, info->dev, start_rtb);
+	trace_xfs_fsmap_high_key_linear(mp, info->dev, end_rtb);
 
 	xfs_ilock(mp->m_rbmip, XFS_ILOCK_SHARED);
 
 	/*
 	 * Set up query parameters to return free rtextents covering the range
@@ -607,22 +575,10 @@ xfs_getfsmap_rtdev_rtbitmap_query(
 		goto err;
 err:
 	xfs_iunlock(mp->m_rbmip, XFS_ILOCK_SHARED);
 	return error;
 }
-
-/* Execute a getfsmap query against the realtime device rtbitmap. */
-STATIC int
-xfs_getfsmap_rtdev_rtbitmap(
-	struct xfs_trans		*tp,
-	const struct xfs_fsmap		*keys,
-	struct xfs_getfsmap_info	*info)
-{
-	info->missing_owner = XFS_FMR_OWN_UNKNOWN;
-	return __xfs_getfsmap_rtdev(tp, keys, xfs_getfsmap_rtdev_rtbitmap_query,
-			info);
-}
 #endif /* CONFIG_XFS_RT */
 
 /* Execute a getfsmap query against the regular data device. */
 STATIC int
 __xfs_getfsmap_datadev(
diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index 20e2ec8b73aa..a9e3081b6625 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -3489,10 +3489,35 @@ DEFINE_EVENT(xfs_fsmap_class, name, \
 	TP_ARGS(mp, keydev, agno, rmap))
 DEFINE_FSMAP_EVENT(xfs_fsmap_low_key);
 DEFINE_FSMAP_EVENT(xfs_fsmap_high_key);
 DEFINE_FSMAP_EVENT(xfs_fsmap_mapping);
 
+DECLARE_EVENT_CLASS(xfs_fsmap_linear_class,
+	TP_PROTO(struct xfs_mount *mp, u32 keydev, uint64_t bno),
+	TP_ARGS(mp, keydev, bno),
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(dev_t, keydev)
+		__field(xfs_fsblock_t, bno)
+	),
+	TP_fast_assign(
+		__entry->dev = mp->m_super->s_dev;
+		__entry->keydev = new_decode_dev(keydev);
+		__entry->bno = bno;
+	),
+	TP_printk("dev %d:%d keydev %d:%d bno 0x%llx",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  MAJOR(__entry->keydev), MINOR(__entry->keydev),
+		  __entry->bno)
+)
+#define DEFINE_FSMAP_LINEAR_EVENT(name) \
+DEFINE_EVENT(xfs_fsmap_linear_class, name, \
+	TP_PROTO(struct xfs_mount *mp, u32 keydev, uint64_t bno), \
+	TP_ARGS(mp, keydev, bno))
+DEFINE_FSMAP_LINEAR_EVENT(xfs_fsmap_low_key_linear);
+DEFINE_FSMAP_LINEAR_EVENT(xfs_fsmap_high_key_linear);
+
 DECLARE_EVENT_CLASS(xfs_getfsmap_class,
 	TP_PROTO(struct xfs_mount *mp, struct xfs_fsmap *fsmap),
 	TP_ARGS(mp, fsmap),
 	TP_STRUCT__entry(
 		__field(dev_t, dev)
-- 
2.50.0.rc1.591.g9c95f17f64-goog


