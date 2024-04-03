Return-Path: <stable+bounces-35706-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5B4896FC1
	for <lists+stable@lfdr.de>; Wed,  3 Apr 2024 15:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 906E61C26291
	for <lists+stable@lfdr.de>; Wed,  3 Apr 2024 13:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF69F146D4B;
	Wed,  3 Apr 2024 13:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="MoSAi4HQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17843146D4A
	for <stable@vger.kernel.org>; Wed,  3 Apr 2024 13:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712149342; cv=none; b=QSpe2VLmuqqJeVUm78mUafT5yLFVtvUs7QTWPoUOCacUJbYu42RlzBLI6rr2pb6XnVlBEckMD/iMYWkJK0aswPEfn2na9dcV/dCbMMQQSkR+Ixei+PvdnUmjF+4xwhFLfR6qExGAuxc9l8e1aOdk84BCrRmfj3ct2XGc5k89bGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712149342; c=relaxed/simple;
	bh=sX7PMn2noSL1uhkTVij+Med8bLaM5xjtFimN9HaZEPA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RZzyuCcWQGQM0BU2FD2TUQN8NM1OUkTEapjXANYGep0cr+jWF23KIcirBdCb8wUJX0Rrc2aqRRXv4EnlVQIDnikg6BXZOmy9SxXnqvSo00W51KOJn7SMafEJGFmR3gtkRU8WOLSUstdCiok3odo9K8GEf54VfjVlBnKnBz1bnuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=MoSAi4HQ; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1712149341; x=1743685341;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ck1w6VCem/bwpXXzi/u7NuKPRI7sF/1In1JOCp5yZik=;
  b=MoSAi4HQtbqiC+1/pI/x1F7gONrmgTZtQ76N5ImPC66f2s1j68Kg/QTl
   Xb03xxmk6FpaQY28c4g39P94kklTAkQPW8U+ncpKSc3lpiWU+sHgqh+L4
   zdpfEuEoM7Ol/mFpGMmjhQKbLaOCXNsFf9CVomyZ8zRjrV1E797Y3oHZT
   E=;
X-IronPort-AV: E=Sophos;i="6.07,177,1708387200"; 
   d="scan'208";a="78356601"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 13:02:18 +0000
Received: from EX19MTAUEB002.ant.amazon.com [10.0.29.78:55914]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.27.3:2525] with esmtp (Farcaster)
 id 7a530f73-0d94-4574-a1b4-2cb04c5aa413; Wed, 3 Apr 2024 13:02:18 +0000 (UTC)
X-Farcaster-Flow-ID: 7a530f73-0d94-4574-a1b4-2cb04c5aa413
Received: from EX19MTAUEB001.ant.amazon.com (10.252.135.108) by
 EX19MTAUEB002.ant.amazon.com (10.252.135.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 3 Apr 2024 13:02:18 +0000
Received: from dev-dsk-mngyadam-1c-a2602c62.eu-west-1.amazon.com (10.15.1.225)
 by mail-relay.amazon.com (10.252.135.35) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Wed, 3 Apr 2024 13:02:18 +0000
Received: by dev-dsk-mngyadam-1c-a2602c62.eu-west-1.amazon.com (Postfix, from userid 23907357)
	id CFE8EBE6; Wed,  3 Apr 2024 15:02:17 +0200 (CEST)
From: Mahmoud Adam <mngyadam@amazon.com>
To: <gregkh@linuxfoundation.org>
CC: <djwong@kernel.org>, <stable@vger.kernel.org>
Subject: [PATCH 6.1 5/6] xfs: hoist refcount record merge predicates
Date: Wed, 3 Apr 2024 14:59:55 +0200
Message-ID: <20240403125949.33676-6-mngyadam@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240403125949.33676-1-mngyadam@amazon.com>
References: <20240403125949.33676-1-mngyadam@amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: "Darrick J. Wong" <djwong@kernel.org>

commit 9d720a5a658f5135861773f26e927449bef93d61 upstream.

Hoist these multiline conditionals into separate static inline helpers
to improve readability and set the stage for corruption fixes that will
be introduced in the next patch.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: Xiao Yang <yangx.jy@fujitsu.com>
Signed-off-by: Mahmoud Adam <mngyadam@amazon.com>
---
 fs/xfs/libxfs/xfs_refcount.c | 129 ++++++++++++++++++++++++++++++-----
 1 file changed, 113 insertions(+), 16 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_refcount.c b/fs/xfs/libxfs/xfs_refcount.c
index 3f34bafe18dd..4408893333a6 100644
--- a/fs/xfs/libxfs/xfs_refcount.c
+++ b/fs/xfs/libxfs/xfs_refcount.c
@@ -815,11 +815,119 @@ xfs_refcount_find_right_extents(
 /* Is this extent valid? */
 static inline bool
 xfs_refc_valid(
-	struct xfs_refcount_irec	*rc)
+	const struct xfs_refcount_irec	*rc)
 {
 	return rc->rc_startblock != NULLAGBLOCK;
 }

+static inline bool
+xfs_refc_want_merge_center(
+	const struct xfs_refcount_irec	*left,
+	const struct xfs_refcount_irec	*cleft,
+	const struct xfs_refcount_irec	*cright,
+	const struct xfs_refcount_irec	*right,
+	bool				cleft_is_cright,
+	enum xfs_refc_adjust_op		adjust,
+	unsigned long long		*ulenp)
+{
+	unsigned long long		ulen = left->rc_blockcount;
+
+	/*
+	 * To merge with a center record, both shoulder records must be
+	 * adjacent to the record we want to adjust.  This is only true if
+	 * find_left and find_right made all four records valid.
+	 */
+	if (!xfs_refc_valid(left)  || !xfs_refc_valid(right) ||
+	    !xfs_refc_valid(cleft) || !xfs_refc_valid(cright))
+		return false;
+
+	/* There must only be one record for the entire range. */
+	if (!cleft_is_cright)
+		return false;
+
+	/* The shoulder record refcounts must match the new refcount. */
+	if (left->rc_refcount != cleft->rc_refcount + adjust)
+		return false;
+	if (right->rc_refcount != cleft->rc_refcount + adjust)
+		return false;
+
+	/*
+	 * The new record cannot exceed the max length.  ulen is a ULL as the
+	 * individual record block counts can be up to (u32 - 1) in length
+	 * hence we need to catch u32 addition overflows here.
+	 */
+	ulen += cleft->rc_blockcount + right->rc_blockcount;
+	if (ulen >= MAXREFCEXTLEN)
+		return false;
+
+	*ulenp = ulen;
+	return true;
+}
+
+static inline bool
+xfs_refc_want_merge_left(
+	const struct xfs_refcount_irec	*left,
+	const struct xfs_refcount_irec	*cleft,
+	enum xfs_refc_adjust_op		adjust)
+{
+	unsigned long long		ulen = left->rc_blockcount;
+
+	/*
+	 * For a left merge, the left shoulder record must be adjacent to the
+	 * start of the range.  If this is true, find_left made left and cleft
+	 * contain valid contents.
+	 */
+	if (!xfs_refc_valid(left) || !xfs_refc_valid(cleft))
+		return false;
+
+	/* Left shoulder record refcount must match the new refcount. */
+	if (left->rc_refcount != cleft->rc_refcount + adjust)
+		return false;
+
+	/*
+	 * The new record cannot exceed the max length.  ulen is a ULL as the
+	 * individual record block counts can be up to (u32 - 1) in length
+	 * hence we need to catch u32 addition overflows here.
+	 */
+	ulen += cleft->rc_blockcount;
+	if (ulen >= MAXREFCEXTLEN)
+		return false;
+
+	return true;
+}
+
+static inline bool
+xfs_refc_want_merge_right(
+	const struct xfs_refcount_irec	*cright,
+	const struct xfs_refcount_irec	*right,
+	enum xfs_refc_adjust_op		adjust)
+{
+	unsigned long long		ulen = right->rc_blockcount;
+
+	/*
+	 * For a right merge, the right shoulder record must be adjacent to the
+	 * end of the range.  If this is true, find_right made cright and right
+	 * contain valid contents.
+	 */
+	if (!xfs_refc_valid(right) || !xfs_refc_valid(cright))
+		return false;
+
+	/* Right shoulder record refcount must match the new refcount. */
+	if (right->rc_refcount != cright->rc_refcount + adjust)
+		return false;
+
+	/*
+	 * The new record cannot exceed the max length.  ulen is a ULL as the
+	 * individual record block counts can be up to (u32 - 1) in length
+	 * hence we need to catch u32 addition overflows here.
+	 */
+	ulen += cright->rc_blockcount;
+	if (ulen >= MAXREFCEXTLEN)
+		return false;
+
+	return true;
+}
+
 /*
  * Try to merge with any extents on the boundaries of the adjustment range.
  */
@@ -861,23 +969,15 @@ xfs_refcount_merge_extents(
 		 (cleft.rc_blockcount == cright.rc_blockcount);

 	/* Try to merge left, cleft, and right.  cleft must == cright. */
-	ulen = (unsigned long long)left.rc_blockcount + cleft.rc_blockcount +
-			right.rc_blockcount;
-	if (xfs_refc_valid(&left) && xfs_refc_valid(&right) &&
-	    xfs_refc_valid(&cleft) && xfs_refc_valid(&cright) && cequal &&
-	    left.rc_refcount == cleft.rc_refcount + adjust &&
-	    right.rc_refcount == cleft.rc_refcount + adjust &&
-	    ulen < MAXREFCEXTLEN) {
+	if (xfs_refc_want_merge_center(&left, &cleft, &cright, &right, cequal,
+				adjust, &ulen)) {
 		*shape_changed = true;
 		return xfs_refcount_merge_center_extents(cur, &left, &cleft,
 				&right, ulen, aglen);
 	}

 	/* Try to merge left and cleft. */
-	ulen = (unsigned long long)left.rc_blockcount + cleft.rc_blockcount;
-	if (xfs_refc_valid(&left) && xfs_refc_valid(&cleft) &&
-	    left.rc_refcount == cleft.rc_refcount + adjust &&
-	    ulen < MAXREFCEXTLEN) {
+	if (xfs_refc_want_merge_left(&left, &cleft, adjust)) {
 		*shape_changed = true;
 		error = xfs_refcount_merge_left_extent(cur, &left, &cleft,
 				agbno, aglen);
@@ -893,10 +993,7 @@ xfs_refcount_merge_extents(
 	}

 	/* Try to merge cright and right. */
-	ulen = (unsigned long long)right.rc_blockcount + cright.rc_blockcount;
-	if (xfs_refc_valid(&right) && xfs_refc_valid(&cright) &&
-	    right.rc_refcount == cright.rc_refcount + adjust &&
-	    ulen < MAXREFCEXTLEN) {
+	if (xfs_refc_want_merge_right(&cright, &right, adjust)) {
 		*shape_changed = true;
 		return xfs_refcount_merge_right_extent(cur, &right, &cright,
 				aglen);
--
2.40.1

