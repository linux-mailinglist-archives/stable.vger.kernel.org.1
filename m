Return-Path: <stable+bounces-164447-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C85B0F47B
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 15:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F4DD17AC53
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 13:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0612E8895;
	Wed, 23 Jul 2025 13:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r3QIC22d"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF16F2E610B
	for <stable@vger.kernel.org>; Wed, 23 Jul 2025 13:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753278617; cv=none; b=rvjBrljeGLEq2+dOXeJQHd0LHEIeIiD9mFDgUBCflpFXxLThR+uRbQuiS9c8SsNGJXuAhGmvH1yROp04IWBE/JR4wk1KxdbrYsn/h/6CEnAWwiQ4C5cyeo2wANLzTi03pA9E7v/ttJh581m2sgra2LcTK4KqZGVTnVJ8OjHxH2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753278617; c=relaxed/simple;
	bh=EsX8Meo1Tv/Sam+uwDSYtvH34kfRK2W4nwCmy01eTOI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QjqtJe0oV3tbwwr6CXk79Z6K1ThjFHYyNxxxDs2nw3BfbbwSr0zcw3dGEf5Y3lRrJPQV6WpmZCl4sxKvl/kMg8kj84JzZENClu3GNo9v9in5YWYs7MvG2LsrzeAHCzptNgg5qTiQM6iTPSMUQ6tPEaOozL/jnA1CfjO5fkt9dic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r3QIC22d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7269EC4CEEF;
	Wed, 23 Jul 2025 13:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753278616;
	bh=EsX8Meo1Tv/Sam+uwDSYtvH34kfRK2W4nwCmy01eTOI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r3QIC22dCY6+gzPxG3ssa3Dvo7ZlyBa21nq6yXwqP7+2hbYd8/fBjGkV/X0lD1iob
	 /HkQoGPwyy4pCTGYzuwj0YUT1j7Aga/ZMspYsFwnmUpwMDs9BjNQZ1mFRlEd222i5U
	 rbii2CGyV2NAjxvQ6/A3AMJrWLX1rz89YWFsp2bEVemPxhQLEC3RxLW+wSMqeDM2kS
	 AWnlJn0OmXkVEZJDS8PPipc19qgXhiljRjKo0ShZW00y/Z5DE9YOY0+eHMZhCf58jf
	 GzyGKKLGEia7wcfcDjgP3doOvA0jjoRebx51lWjdPJ76y11ZzXB3T/0gzBHXC9hlwp
	 mq0ZZUg5a4ycg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/6] erofs: refine z_erofs_get_extent_compressedlen()
Date: Wed, 23 Jul 2025 09:50:05 -0400
Message-Id: <20250723135009.1089152-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250723135009.1089152-1-sashal@kernel.org>
References: <2025071422-preview-germinate-b2de@gregkh>
 <20250723135009.1089152-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gao Xiang <hsiangkao@linux.alibaba.com>

[ Upstream commit 8f9530aeeb4f756bdfa70510b40e5d28ea3c742e ]

 - Set `compressedblks = 1` directly for non-bigpcluster cases.  This
   simplifies the logic a bit since lcluster sizes larger than one block
   are unsupported and the details remain unclear.

 - For Z_EROFS_LCLUSTER_TYPE_PLAIN pclusters, avoid assuming
   `compressedblks = 1` by default.  Instead, check if
   Z_EROFS_ADVISE_BIG_PCLUSTER_2 is set.

It basically has no impact to existing valid images, but it's useful to
find the gap to prepare for large PLAIN pclusters.

Link: https://lore.kernel.org/r/20250123090109.973463-1-hsiangkao@linux.alibaba.com
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Stable-dep-of: b44686c8391b ("erofs: fix large fragment handling")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/erofs/zmap.c | 36 ++++++++++++++++--------------------
 1 file changed, 16 insertions(+), 20 deletions(-)

diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index b9e35089c9b8d..689437e99a5a3 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -294,27 +294,23 @@ static int z_erofs_extent_lookback(struct z_erofs_maprecorder *m,
 static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
 					    unsigned int initial_lcn)
 {
-	struct super_block *sb = m->inode->i_sb;
-	struct erofs_inode *const vi = EROFS_I(m->inode);
-	struct erofs_map_blocks *const map = m->map;
-	const unsigned int lclusterbits = vi->z_logical_clusterbits;
-	unsigned long lcn;
+	struct inode *inode = m->inode;
+	struct super_block *sb = inode->i_sb;
+	struct erofs_inode *vi = EROFS_I(inode);
+	bool bigpcl1 = vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_1;
+	bool bigpcl2 = vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_2;
+	unsigned long lcn = m->lcn + 1;
 	int err;
 
-	DBG_BUGON(m->type != Z_EROFS_LCLUSTER_TYPE_PLAIN &&
-		  m->type != Z_EROFS_LCLUSTER_TYPE_HEAD1 &&
-		  m->type != Z_EROFS_LCLUSTER_TYPE_HEAD2);
+	DBG_BUGON(m->type == Z_EROFS_LCLUSTER_TYPE_NONHEAD);
 	DBG_BUGON(m->type != m->headtype);
 
-	if (m->headtype == Z_EROFS_LCLUSTER_TYPE_PLAIN ||
-	    ((m->headtype == Z_EROFS_LCLUSTER_TYPE_HEAD1) &&
-	     !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_1)) ||
-	    ((m->headtype == Z_EROFS_LCLUSTER_TYPE_HEAD2) &&
-	     !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_2))) {
-		map->m_plen = 1ULL << lclusterbits;
-		return 0;
-	}
-	lcn = m->lcn + 1;
+	if ((m->headtype == Z_EROFS_LCLUSTER_TYPE_HEAD1 && !bigpcl1) ||
+	    ((m->headtype == Z_EROFS_LCLUSTER_TYPE_PLAIN ||
+	      m->headtype == Z_EROFS_LCLUSTER_TYPE_HEAD2) && !bigpcl2) ||
+	    (lcn << vi->z_logical_clusterbits) >= inode->i_size)
+		m->compressedblks = 1;
+
 	if (m->compressedblks)
 		goto out;
 
@@ -339,9 +335,9 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
 	case Z_EROFS_LCLUSTER_TYPE_HEAD2:
 		/*
 		 * if the 1st NONHEAD lcluster is actually PLAIN or HEAD type
-		 * rather than CBLKCNT, it's a 1 lcluster-sized pcluster.
+		 * rather than CBLKCNT, it's a 1 block-sized pcluster.
 		 */
-		m->compressedblks = 1 << (lclusterbits - sb->s_blocksize_bits);
+		m->compressedblks = 1;
 		break;
 	case Z_EROFS_LCLUSTER_TYPE_NONHEAD:
 		if (m->delta[0] != 1)
@@ -356,7 +352,7 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
 		return -EFSCORRUPTED;
 	}
 out:
-	map->m_plen = erofs_pos(sb, m->compressedblks);
+	m->map->m_plen = erofs_pos(sb, m->compressedblks);
 	return 0;
 err_bonus_cblkcnt:
 	erofs_err(sb, "bogus CBLKCNT @ lcn %lu of nid %llu", lcn, vi->nid);
-- 
2.39.5


