Return-Path: <stable+bounces-164448-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E69DCB0F47A
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 15:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 252D7176B03
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 13:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39FF62E8893;
	Wed, 23 Jul 2025 13:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oyC7dAOV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1E32E7F1F
	for <stable@vger.kernel.org>; Wed, 23 Jul 2025 13:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753278617; cv=none; b=GmNpZV3kcbciAEXRfE68i0xxXSxc0bH9Uu0n8fhE0ai7VwI87ZcObHpXJw3lo4oCYJhu1Y26EVzHyzRJ6/NDBCCPbDnBdSZZJSRa9qq50PlMiU0YiZmSGji0qbt4xzdoKbegxNNz2XCJLywhPr2IC8RSkxALShOmkh9VaqmOloE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753278617; c=relaxed/simple;
	bh=zIjil6pDaeeYiLNxuDkJfcVhtPfWhioWT6vHcfeK7rc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YWoU2Ih6bz8IbigZ9CKthFZySSR610CHnqd6iSOB9qac8GhiWib8vhu8grm8lhBJmZli1moj0488UbYZ0cgUUxqew0ZGARlGV2sKywhIuXqsRMSsP/llxb3A0e7H4Eknkk0WzBt/CPXsbwJ6ltlLuQpY9S8wwvMX1rj5PzvU09M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oyC7dAOV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB132C4CEE7;
	Wed, 23 Jul 2025 13:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753278615;
	bh=zIjil6pDaeeYiLNxuDkJfcVhtPfWhioWT6vHcfeK7rc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oyC7dAOVoWilNsTr1KeAuh5wJaqcABOYINPK7xKQzeVmyWw3/Wh2KRgKBnUf+yitG
	 89uTSpbgI/JLlIIpIQ0Sax7Ne5bov/ZyHzmLU7rrGBUlXyhbhbokCFMIWX+hhBQKP0
	 1J6zPsGA1W4gRQvDcPFyrwTB1t15CXBLCj+0HbM3lrzexxAvytJjwt1k4/5drufxmX
	 +Vp67Edtd6ED4sIwnIqGebVfYTKlo5G1RNca5/iuNcPhC6UkE4U/ksqXEhZho321SF
	 yV2poR7lbp70IUtsPfm7GgHdur7cL/iNPNONXU7L1quXwvx/95cvMbMCg5x6XRSr8F
	 P+B1A+kHkQXQg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>,
	Chao Yu <chao@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/6] erofs: simplify z_erofs_load_compact_lcluster()
Date: Wed, 23 Jul 2025 09:50:04 -0400
Message-Id: <20250723135009.1089152-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025071422-preview-germinate-b2de@gregkh>
References: <2025071422-preview-germinate-b2de@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gao Xiang <hsiangkao@linux.alibaba.com>

[ Upstream commit 2a810ea79cd7a6d5f134ea69ca2ba726e600cbc4 ]

 - Get rid of unpack_compacted_index() and fold it into
   z_erofs_load_compact_lcluster();

 - Avoid a goto.

Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Link: https://lore.kernel.org/r/20250114034429.431408-1-hsiangkao@linux.alibaba.com
Stable-dep-of: b44686c8391b ("erofs: fix large fragment handling")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/erofs/zmap.c | 89 ++++++++++++++++++++-----------------------------
 1 file changed, 36 insertions(+), 53 deletions(-)

diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 4535f2f0a0147..b9e35089c9b8d 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -97,17 +97,48 @@ static int get_compacted_la_distance(unsigned int lobits,
 	return d1;
 }
 
-static int unpack_compacted_index(struct z_erofs_maprecorder *m,
-				  unsigned int amortizedshift,
-				  erofs_off_t pos, bool lookahead)
+static int z_erofs_load_compact_lcluster(struct z_erofs_maprecorder *m,
+					 unsigned long lcn, bool lookahead)
 {
-	struct erofs_inode *const vi = EROFS_I(m->inode);
+	struct inode *const inode = m->inode;
+	struct erofs_inode *const vi = EROFS_I(inode);
+	const erofs_off_t ebase = sizeof(struct z_erofs_map_header) +
+		ALIGN(erofs_iloc(inode) + vi->inode_isize + vi->xattr_isize, 8);
 	const unsigned int lclusterbits = vi->z_logical_clusterbits;
+	const unsigned int totalidx = erofs_iblks(inode);
+	unsigned int compacted_4b_initial, compacted_2b, amortizedshift;
 	unsigned int vcnt, lo, lobits, encodebits, nblk, bytes;
-	bool big_pcluster;
+	bool big_pcluster = vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_1;
+	erofs_off_t pos;
 	u8 *in, type;
 	int i;
 
+	if (lcn >= totalidx || lclusterbits > 14)
+		return -EINVAL;
+
+	m->lcn = lcn;
+	/* used to align to 32-byte (compacted_2b) alignment */
+	compacted_4b_initial = ((32 - ebase % 32) / 4) & 7;
+	compacted_2b = 0;
+	if ((vi->z_advise & Z_EROFS_ADVISE_COMPACTED_2B) &&
+	    compacted_4b_initial < totalidx)
+		compacted_2b = rounddown(totalidx - compacted_4b_initial, 16);
+
+	pos = ebase;
+	amortizedshift = 2;	/* compact_4b */
+	if (lcn >= compacted_4b_initial) {
+		pos += compacted_4b_initial * 4;
+		lcn -= compacted_4b_initial;
+		if (lcn < compacted_2b) {
+			amortizedshift = 1;
+		} else {
+			pos += compacted_2b * 2;
+			lcn -= compacted_2b;
+		}
+	}
+	pos += lcn * (1 << amortizedshift);
+
+	/* figure out the lcluster count in this pack */
 	if (1 << amortizedshift == 4 && lclusterbits <= 14)
 		vcnt = 2;
 	else if (1 << amortizedshift == 2 && lclusterbits <= 12)
@@ -122,7 +153,6 @@ static int unpack_compacted_index(struct z_erofs_maprecorder *m,
 	/* it doesn't equal to round_up(..) */
 	m->nextpackoff = round_down(pos, vcnt << amortizedshift) +
 			 (vcnt << amortizedshift);
-	big_pcluster = vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_1;
 	lobits = max(lclusterbits, ilog2(Z_EROFS_LI_D0_CBLKCNT) + 1U);
 	encodebits = ((vcnt << amortizedshift) - sizeof(__le32)) * 8 / vcnt;
 	bytes = pos & ((vcnt << amortizedshift) - 1);
@@ -207,53 +237,6 @@ static int unpack_compacted_index(struct z_erofs_maprecorder *m,
 	return 0;
 }
 
-static int z_erofs_load_compact_lcluster(struct z_erofs_maprecorder *m,
-					 unsigned long lcn, bool lookahead)
-{
-	struct inode *const inode = m->inode;
-	struct erofs_inode *const vi = EROFS_I(inode);
-	const erofs_off_t ebase = sizeof(struct z_erofs_map_header) +
-		ALIGN(erofs_iloc(inode) + vi->inode_isize + vi->xattr_isize, 8);
-	unsigned int totalidx = erofs_iblks(inode);
-	unsigned int compacted_4b_initial, compacted_2b;
-	unsigned int amortizedshift;
-	erofs_off_t pos;
-
-	if (lcn >= totalidx || vi->z_logical_clusterbits > 14)
-		return -EINVAL;
-
-	m->lcn = lcn;
-	/* used to align to 32-byte (compacted_2b) alignment */
-	compacted_4b_initial = (32 - ebase % 32) / 4;
-	if (compacted_4b_initial == 32 / 4)
-		compacted_4b_initial = 0;
-
-	if ((vi->z_advise & Z_EROFS_ADVISE_COMPACTED_2B) &&
-	    compacted_4b_initial < totalidx)
-		compacted_2b = rounddown(totalidx - compacted_4b_initial, 16);
-	else
-		compacted_2b = 0;
-
-	pos = ebase;
-	if (lcn < compacted_4b_initial) {
-		amortizedshift = 2;
-		goto out;
-	}
-	pos += compacted_4b_initial * 4;
-	lcn -= compacted_4b_initial;
-
-	if (lcn < compacted_2b) {
-		amortizedshift = 1;
-		goto out;
-	}
-	pos += compacted_2b * 2;
-	lcn -= compacted_2b;
-	amortizedshift = 2;
-out:
-	pos += lcn * (1 << amortizedshift);
-	return unpack_compacted_index(m, amortizedshift, pos, lookahead);
-}
-
 static int z_erofs_load_lcluster_from_disk(struct z_erofs_maprecorder *m,
 					   unsigned int lcn, bool lookahead)
 {
-- 
2.39.5


