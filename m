Return-Path: <stable+bounces-35707-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B1C896FC6
	for <lists+stable@lfdr.de>; Wed,  3 Apr 2024 15:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C56801C26BB8
	for <lists+stable@lfdr.de>; Wed,  3 Apr 2024 13:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA17D146D41;
	Wed,  3 Apr 2024 13:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="GUBiC7qS"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CDD146D4A
	for <stable@vger.kernel.org>; Wed,  3 Apr 2024 13:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712149384; cv=none; b=KP3seq6Gmo1Umj+uGVwuCkprsaC1yzQ6V+OWs4FqIWYJ4kNNuGVNPtihz6k624eBIAIbo2771xO52RhC6WbByGhmq+agu1MjumcW7IQtCj41puFTpQT/5ld9xlDFWdQNmTyUiRUHdEsKwSMm4KmussGlWeG2I4SSQKIW8uzQ4Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712149384; c=relaxed/simple;
	bh=RRQynQPR9Hz5Lw+vAgSrxqpZba3Zc5DiTXs5pXzDuQs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JO+KNVB2YMcDa2zbIY6AKusam7kTMu8mM1Z9d1bSbGPUngAlBSNc46ysmMQwczJWDV06kIAGkroaCjJ+8Hwk1sifm0M1HpOSNc4HZsLe2yN15OB7h3R+OIJfjh9Re6h1a4e+evmBBcps5vb0SL33Rc3stVQYUBYJabYWyUhDY5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=GUBiC7qS; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1712149383; x=1743685383;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=q6wCXu565ygYZcrVLCd/O7ZYIu/q748s1PQPPaZjtP0=;
  b=GUBiC7qScJgcnndfNtiqxi+N5kJToSIXAP3TCyRyJ/nriXQcu3Ml8SIK
   vOIZZz0KLbRjn32CxTQaF+Og79Q5o8KHe3QKT9I0ZQaKrQwVYdZ2gY+Ut
   T89yF+9MELQi9YWcZ6kLD7Wqs33TNVd6Rp9J/HjJN5aOhcc9cFMkgmG1K
   E=;
X-IronPort-AV: E=Sophos;i="6.07,177,1708387200"; 
   d="scan'208";a="624170881"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 13:03:00 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:55518]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.50.222:2525] with esmtp (Farcaster)
 id b514ebde-c946-4601-ad0f-34b2c8930b75; Wed, 3 Apr 2024 13:03:00 +0000 (UTC)
X-Farcaster-Flow-ID: b514ebde-c946-4601-ad0f-34b2c8930b75
Received: from EX19EXOUWA002.ant.amazon.com (10.250.64.216) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 3 Apr 2024 13:02:59 +0000
Received: from EX19MTAUWC001.ant.amazon.com (10.250.64.145) by
 EX19EXOUWA002.ant.amazon.com (10.250.64.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 3 Apr 2024 13:02:59 +0000
Received: from dev-dsk-mngyadam-1c-a2602c62.eu-west-1.amazon.com (10.15.1.225)
 by mail-relay.amazon.com (10.250.64.145) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Wed, 3 Apr 2024 13:02:59 +0000
Received: by dev-dsk-mngyadam-1c-a2602c62.eu-west-1.amazon.com (Postfix, from userid 23907357)
	id DE0FDBE6; Wed,  3 Apr 2024 15:02:58 +0200 (CEST)
From: Mahmoud Adam <mngyadam@amazon.com>
To: <gregkh@linuxfoundation.org>
CC: <djwong@kernel.org>, <stable@vger.kernel.org>
Subject: [PATCH 6.1 6/6] xfs: estimate post-merge refcounts correctly
Date: Wed, 3 Apr 2024 14:59:57 +0200
Message-ID: <20240403125949.33676-7-mngyadam@amazon.com>
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

commit b25d1984aa884fc91a73a5a407b9ac976d441e9b upstream.

Upon enabling fsdax + reflink for XFS, xfs/179 began to report refcount
metadata corruptions after being run.  Specifically, xfs_repair noticed
single-block refcount records that could be combined but had not been.

The root cause of this is improper MAXREFCOUNT edge case handling in
xfs_refcount_merge_extents.  When we're trying to find candidates for a
refcount btree record merge, we compute the refcount attribute of the
merged record, but we fail to account for the fact that once a record
hits rc_refcount == MAXREFCOUNT, it is pinned that way forever.  Hence
the computed refcount is wrong, and we fail to merge the extents.

Fix this by adjusting the merge predicates to compute the adjusted
refcount correctly.

Fixes: 3172725814f9 ("xfs: adjust refcount of an extent of blocks in refcount btree")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: Xiao Yang <yangx.jy@fujitsu.com>
Signed-off-by: Mahmoud Adam <mngyadam@amazon.com>
---
 fs/xfs/libxfs/xfs_refcount.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_refcount.c b/fs/xfs/libxfs/xfs_refcount.c
index 4408893333a6..6f7ed9288fe4 100644
--- a/fs/xfs/libxfs/xfs_refcount.c
+++ b/fs/xfs/libxfs/xfs_refcount.c
@@ -820,6 +820,17 @@ xfs_refc_valid(
 	return rc->rc_startblock != NULLAGBLOCK;
 }

+static inline xfs_nlink_t
+xfs_refc_merge_refcount(
+	const struct xfs_refcount_irec	*irec,
+	enum xfs_refc_adjust_op		adjust)
+{
+	/* Once a record hits MAXREFCOUNT, it is pinned there forever */
+	if (irec->rc_refcount == MAXREFCOUNT)
+		return MAXREFCOUNT;
+	return irec->rc_refcount + adjust;
+}
+
 static inline bool
 xfs_refc_want_merge_center(
 	const struct xfs_refcount_irec	*left,
@@ -831,6 +842,7 @@ xfs_refc_want_merge_center(
 	unsigned long long		*ulenp)
 {
 	unsigned long long		ulen = left->rc_blockcount;
+	xfs_nlink_t			new_refcount;

 	/*
 	 * To merge with a center record, both shoulder records must be
@@ -846,9 +858,10 @@ xfs_refc_want_merge_center(
 		return false;

 	/* The shoulder record refcounts must match the new refcount. */
-	if (left->rc_refcount != cleft->rc_refcount + adjust)
+	new_refcount = xfs_refc_merge_refcount(cleft, adjust);
+	if (left->rc_refcount != new_refcount)
 		return false;
-	if (right->rc_refcount != cleft->rc_refcount + adjust)
+	if (right->rc_refcount != new_refcount)
 		return false;

 	/*
@@ -871,6 +884,7 @@ xfs_refc_want_merge_left(
 	enum xfs_refc_adjust_op		adjust)
 {
 	unsigned long long		ulen = left->rc_blockcount;
+	xfs_nlink_t			new_refcount;

 	/*
 	 * For a left merge, the left shoulder record must be adjacent to the
@@ -881,7 +895,8 @@ xfs_refc_want_merge_left(
 		return false;

 	/* Left shoulder record refcount must match the new refcount. */
-	if (left->rc_refcount != cleft->rc_refcount + adjust)
+	new_refcount = xfs_refc_merge_refcount(cleft, adjust);
+	if (left->rc_refcount != new_refcount)
 		return false;

 	/*
@@ -903,6 +918,7 @@ xfs_refc_want_merge_right(
 	enum xfs_refc_adjust_op		adjust)
 {
 	unsigned long long		ulen = right->rc_blockcount;
+	xfs_nlink_t			new_refcount;

 	/*
 	 * For a right merge, the right shoulder record must be adjacent to the
@@ -913,7 +929,8 @@ xfs_refc_want_merge_right(
 		return false;

 	/* Right shoulder record refcount must match the new refcount. */
-	if (right->rc_refcount != cright->rc_refcount + adjust)
+	new_refcount = xfs_refc_merge_refcount(cright, adjust);
+	if (right->rc_refcount != new_refcount)
 		return false;

 	/*
--
2.40.1

