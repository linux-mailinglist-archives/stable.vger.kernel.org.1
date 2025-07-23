Return-Path: <stable+bounces-164450-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8313AB0F481
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 15:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 284F13A4254
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 13:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF812E88B4;
	Wed, 23 Jul 2025 13:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j0C8SPRZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F04C2E7BA8
	for <stable@vger.kernel.org>; Wed, 23 Jul 2025 13:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753278620; cv=none; b=VgC2NXkt3V1aFaEBSzjFMqUvCkL1tyhmjIrU97IC34JPALWBX/wCbqlp37ywD9d0uXWpPJlFOWYx+EetCTy3nKmnrzaqvkfD7DKweTdQvsPTkWHaeNybpbMe2maotnWq1kGYSCCq9bW5Cc8xqt81klVRF0sAmYaPGeaJY/b4M28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753278620; c=relaxed/simple;
	bh=H//EfWyGY7Iw/TUXPtFHDhm4LBHisQU46m0i7q3BZ9s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eccEUWXR9FrgLM5MkPrvxqE9qfds19AidAo6D/InCdctT35SAqibr8T3PoOBT3QGuTRPXRhvtpLDAeRclOn5JB/l8/KvJux8HkjlbPA157k1zdapefyWgBs2bjntvxW33imCy4vhK2DErsu5LYFR1p1J0lppyJojMoBOJXe52d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j0C8SPRZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00850C4CEE7;
	Wed, 23 Jul 2025 13:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753278620;
	bh=H//EfWyGY7Iw/TUXPtFHDhm4LBHisQU46m0i7q3BZ9s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j0C8SPRZaVIWahEfx5xhQJcFY/C/Dk9yLvm3zxrWrkxy4PMjBSCu0sF4aTh/xdXWV
	 Uu8cm/ulbx8U5c05jSEL3G6XU/Vpb8K+OFVMKInC0HABEjfFNqo24rdBFFI2JMa2sH
	 iFYJEz0d7zfKBvMdomRCElAh9V9maNMCVHU1+o3jt+P40Vn6cIzW1nzd4zSw3NLVwT
	 93Cn+jftnnd1VsUSU3T+sHaYIm2cVw/tp7IMIvoNuYhFMqmTaeWnHMZDruGyoa0nxd
	 Bs7C9EPb4VGYfND0dBHa9/XpTpbJGN4N+Mwt7PaMrVAQNFzvGrJ7bogqu/Txz/RHyl
	 kxa2FyRaiHWyA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>,
	Chao Yu <chao@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 4/6] erofs: simplify tail inline pcluster handling
Date: Wed, 23 Jul 2025 09:50:07 -0400
Message-Id: <20250723135009.1089152-4-sashal@kernel.org>
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

[ Upstream commit b7710262d743aca112877d12abed61ce8a5d0d98 ]

Use `z_idata_size != 0` to indicate that ztailpacking is enabled.
`Z_EROFS_ADVISE_INLINE_PCLUSTER` cannot be ignored, as `h_idata_size`
could be non-zero prior to erofs-utils 1.6 [1].

Additionally, merge `z_idataoff` and `z_fragmentoff` since these two
features are mutually exclusive for a given inode.

[1] https://git.kernel.org/xiang/erofs-utils/c/547bea3cb71a
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Link: https://lore.kernel.org/r/20250225114038.3259726-1-hsiangkao@linux.alibaba.com
Stable-dep-of: b44686c8391b ("erofs: fix large fragment handling")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/erofs/internal.h |  9 ++-------
 fs/erofs/zmap.c     | 20 ++++++++++----------
 2 files changed, 12 insertions(+), 17 deletions(-)

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 3d06fda70f318..06895e9fec38f 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -277,13 +277,8 @@ struct erofs_inode {
 			unsigned char  z_algorithmtype[2];
 			unsigned char  z_logical_clusterbits;
 			unsigned long  z_tailextent_headlcn;
-			union {
-				struct {
-					erofs_off_t    z_idataoff;
-					unsigned short z_idata_size;
-				};
-				erofs_off_t z_fragmentoff;
-			};
+			erofs_off_t    z_fragmentoff;
+			unsigned short z_idata_size;
 		};
 #endif	/* CONFIG_EROFS_FS_ZIP */
 	};
diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index d278ebd602816..f2ff0cba2bc8c 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -395,8 +395,8 @@ static int z_erofs_do_map_blocks(struct inode *inode,
 				 struct erofs_map_blocks *map, int flags)
 {
 	struct erofs_inode *const vi = EROFS_I(inode);
-	bool ztailpacking = vi->z_advise & Z_EROFS_ADVISE_INLINE_PCLUSTER;
 	bool fragment = vi->z_advise & Z_EROFS_ADVISE_FRAGMENT_PCLUSTER;
+	bool ztailpacking = vi->z_idata_size;
 	struct z_erofs_maprecorder m = {
 		.inode = inode,
 		.map = map,
@@ -415,9 +415,8 @@ static int z_erofs_do_map_blocks(struct inode *inode,
 	if (err)
 		goto unmap_out;
 
-	if (ztailpacking && (flags & EROFS_GET_BLOCKS_FINDTAIL))
-		vi->z_idataoff = m.nextpackoff;
-
+	if ((flags & EROFS_GET_BLOCKS_FINDTAIL) && ztailpacking)
+		vi->z_fragmentoff = m.nextpackoff;
 	map->m_flags = EROFS_MAP_MAPPED | EROFS_MAP_ENCODED;
 	end = (m.lcn + 1ULL) << lclusterbits;
 
@@ -472,7 +471,7 @@ static int z_erofs_do_map_blocks(struct inode *inode,
 	}
 	if (ztailpacking && m.lcn == vi->z_tailextent_headlcn) {
 		map->m_flags |= EROFS_MAP_META;
-		map->m_pa = vi->z_idataoff;
+		map->m_pa = vi->z_fragmentoff;
 		map->m_plen = vi->z_idata_size;
 	} else if (fragment && m.lcn == vi->z_tailextent_headlcn) {
 		map->m_flags |= EROFS_MAP_FRAGMENT;
@@ -565,6 +564,10 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
 	vi->z_advise = le16_to_cpu(h->h_advise);
 	vi->z_algorithmtype[0] = h->h_algorithmtype & 15;
 	vi->z_algorithmtype[1] = h->h_algorithmtype >> 4;
+	if (vi->z_advise & Z_EROFS_ADVISE_FRAGMENT_PCLUSTER)
+		vi->z_fragmentoff = le32_to_cpu(h->h_fragmentoff);
+	else if (vi->z_advise & Z_EROFS_ADVISE_INLINE_PCLUSTER)
+		vi->z_idata_size = le16_to_cpu(h->h_idata_size);
 
 	headnr = 0;
 	if (vi->z_algorithmtype[0] >= Z_EROFS_COMPRESSION_MAX ||
@@ -593,18 +596,16 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
 		goto out_put_metabuf;
 	}
 
-	if (vi->z_advise & Z_EROFS_ADVISE_INLINE_PCLUSTER) {
+	if (vi->z_idata_size) {
 		struct erofs_map_blocks map = {
 			.buf = __EROFS_BUF_INITIALIZER
 		};
 
-		vi->z_idata_size = le16_to_cpu(h->h_idata_size);
 		err = z_erofs_do_map_blocks(inode, &map,
 					    EROFS_GET_BLOCKS_FINDTAIL);
 		erofs_put_metabuf(&map.buf);
 
-		if (!map.m_plen ||
-		    erofs_blkoff(sb, map.m_pa) + map.m_plen > sb->s_blocksize) {
+		if (erofs_blkoff(sb, map.m_pa) + map.m_plen > sb->s_blocksize) {
 			erofs_err(sb, "invalid tail-packing pclustersize %llu",
 				  map.m_plen);
 			err = -EFSCORRUPTED;
@@ -619,7 +620,6 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
 			.buf = __EROFS_BUF_INITIALIZER
 		};
 
-		vi->z_fragmentoff = le32_to_cpu(h->h_fragmentoff);
 		err = z_erofs_do_map_blocks(inode, &map,
 					    EROFS_GET_BLOCKS_FINDTAIL);
 		erofs_put_metabuf(&map.buf);
-- 
2.39.5


