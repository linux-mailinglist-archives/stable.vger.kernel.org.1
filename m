Return-Path: <stable+bounces-165354-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B3DB15CDF
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 11:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A98F718C381B
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 09:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C503294A1B;
	Wed, 30 Jul 2025 09:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fcq6vptv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223FE1F5834;
	Wed, 30 Jul 2025 09:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753868800; cv=none; b=YlzDEnsH/D8pZ9O1dML/CCqQ1J+2Qrvco7Wk0YVb0QZX0OMbNDH869Jp+IUyxG4Wb7S9GDK7Lmf32eCBKWxePXXrdi5uxF+YpFhW6qGQxBSCnGN0S5ajStr4i3UDmMeEbEhmsOjSXgQR1RMigRm/EWyJJFd3YshK70worbHCpTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753868800; c=relaxed/simple;
	bh=5Yq4Ob6jUcWxHfavLp19GSQ8gxeryI3mDYPxjf1pUyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tmA12uufJ2EgjVJBlaiDu1aXhmSToGZemQbdTC28qzXHP25SbFV8o2/FSvZNEdWpYlCSLd+fSQazuU3QmY9QmUu5FOLdD/tRuC3tJwZi0UZ7ppzUox0qfx9XQ7baf7A5TaSgKuW6IvFTUbPgT5AgpqmPEh7/77qsXE6d0bKcgNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fcq6vptv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CAA7C4CEF6;
	Wed, 30 Jul 2025 09:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753868799;
	bh=5Yq4Ob6jUcWxHfavLp19GSQ8gxeryI3mDYPxjf1pUyw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fcq6vptveXxJNmDcYf4OraGxsJE0iVErXP6xfFDpYaAj85ZHGK7GXMGvTZMGsm8Os
	 fbsp8Aq3NnmvQKr3sSxZNGzyr24qfGwvoADr8WSXEHSU9a7LVQ4AbcM5AFYENhSR5R
	 6CJOJ5qUb9gTUyyXEzsU8YJD/KyuH7/qR2UpmRpQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chao Yu <chao@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 079/117] erofs: simplify z_erofs_load_compact_lcluster()
Date: Wed, 30 Jul 2025 11:35:48 +0200
Message-ID: <20250730093236.832499065@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250730093233.592541778@linuxfoundation.org>
References: <20250730093233.592541778@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/erofs/zmap.c |   89 ++++++++++++++++++++++----------------------------------
 1 file changed, 36 insertions(+), 53 deletions(-)

--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -97,17 +97,48 @@ static int get_compacted_la_distance(uns
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
@@ -122,7 +153,6 @@ static int unpack_compacted_index(struct
 	/* it doesn't equal to round_up(..) */
 	m->nextpackoff = round_down(pos, vcnt << amortizedshift) +
 			 (vcnt << amortizedshift);
-	big_pcluster = vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_1;
 	lobits = max(lclusterbits, ilog2(Z_EROFS_LI_D0_CBLKCNT) + 1U);
 	encodebits = ((vcnt << amortizedshift) - sizeof(__le32)) * 8 / vcnt;
 	bytes = pos & ((vcnt << amortizedshift) - 1);
@@ -207,53 +237,6 @@ static int unpack_compacted_index(struct
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



