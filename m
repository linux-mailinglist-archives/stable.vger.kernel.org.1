Return-Path: <stable+bounces-164451-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8BBB0F486
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 15:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B60CB1892B04
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 13:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634562E7F25;
	Wed, 23 Jul 2025 13:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iMpBVMm+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244F92E610B
	for <stable@vger.kernel.org>; Wed, 23 Jul 2025 13:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753278622; cv=none; b=Z7qaQ5eQBfOvBwcQ86xEbB8xJLL14IA9tGMcDGIquHlL+sWjVv4ufh3tX8pv9nwEvAebCuPLH5KP/eDc8wrgH9ze/haszykeQQ6cIjn1JkvoyplyeEmP+cIxcP+iE88MCHLmbmlDu26LR2jdr7dfR1pIaAVSUKfhjmes8p9lJfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753278622; c=relaxed/simple;
	bh=MtjBL5hy3kiyRYrBuGyxA9Q33lQoaKezou0QJBw1VE8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J58XA2/XWEMTTT5pdE4gGPVSwdUKTWW73G8B6B3QtGnyfMtbpH9lmUAbup9zh4K6SvsPr/nraggb8+BvDF23nu9D6e3rGHAH5i032EKcaSsy4ATfh63BydRa0tYISGV6UxTVOzf6hmxJ1ax46nPqUb0v4VNjWu+2++G6lxZubEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iMpBVMm+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A45D5C4CEE7;
	Wed, 23 Jul 2025 13:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753278621;
	bh=MtjBL5hy3kiyRYrBuGyxA9Q33lQoaKezou0QJBw1VE8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iMpBVMm+3oUqeEtF+Bp1TyIpTVWhsG1CX33X+v5+URLb1xa43RtBZhrcGMfCs/YNr
	 9B2jOjoUm36zqdOjmAa0UVZj25xn41IRHctXx2AGHrWznr8kZvaoXRPImGCzKO4AhX
	 HfeKFiu2JYmbjNRtVs40SIfgvpc0IDPPxvzs1Gpco50oQWfxB+cWf+FYZ3x+HZzJkd
	 WA+OgKOWgZENRMs9H6w7YRmaS8CrYK+55IGnPKF92ETZSHdA+Y6IM0h4maXFK4aJvv
	 UWr4PbRjHywGH6L+T+wWmj7DeOsQd7JPpnXx3zMU7xqdv0mdNwOLvEib4qMVrO8vJS
	 TKU3LlCv7UPYA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>,
	Chao Yu <chao@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 5/6] erofs: clean up header parsing for ztailpacking and fragments
Date: Wed, 23 Jul 2025 09:50:08 -0400
Message-Id: <20250723135009.1089152-5-sashal@kernel.org>
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

[ Upstream commit 540787d38b10dbc16a7d2bc2845752ab1605403a ]

Simplify the logic in z_erofs_fill_inode_lazy() by combining the
handling of ztailpacking and fragments, as they are mutually exclusive.

Note that `h->h_clusterbits >> Z_EROFS_FRAGMENT_INODE_BIT` is handled
above, so no need to duplicate the check.

Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Link: https://lore.kernel.org/r/20250224123747.1387122-2-hsiangkao@linux.alibaba.com
Stable-dep-of: b44686c8391b ("erofs: fix large fragment handling")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/erofs/zmap.c | 39 ++++++++++++++-------------------------
 1 file changed, 14 insertions(+), 25 deletions(-)

diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index f2ff0cba2bc8c..f076cafb304f2 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -394,7 +394,8 @@ static int z_erofs_get_extent_decompressedlen(struct z_erofs_maprecorder *m)
 static int z_erofs_do_map_blocks(struct inode *inode,
 				 struct erofs_map_blocks *map, int flags)
 {
-	struct erofs_inode *const vi = EROFS_I(inode);
+	struct erofs_inode *vi = EROFS_I(inode);
+	struct super_block *sb = inode->i_sb;
 	bool fragment = vi->z_advise & Z_EROFS_ADVISE_FRAGMENT_PCLUSTER;
 	bool ztailpacking = vi->z_idata_size;
 	struct z_erofs_maprecorder m = {
@@ -438,7 +439,7 @@ static int z_erofs_do_map_blocks(struct inode *inode,
 		}
 		/* m.lcn should be >= 1 if endoff < m.clusterofs */
 		if (!m.lcn) {
-			erofs_err(inode->i_sb, "invalid logical cluster 0 at nid %llu",
+			erofs_err(sb, "invalid logical cluster 0 at nid %llu",
 				  vi->nid);
 			err = -EFSCORRUPTED;
 			goto unmap_out;
@@ -454,7 +455,7 @@ static int z_erofs_do_map_blocks(struct inode *inode,
 			goto unmap_out;
 		break;
 	default:
-		erofs_err(inode->i_sb, "unknown type %u @ offset %llu of nid %llu",
+		erofs_err(sb, "unknown type %u @ offset %llu of nid %llu",
 			  m.type, ofs, vi->nid);
 		err = -EOPNOTSUPP;
 		goto unmap_out;
@@ -473,10 +474,16 @@ static int z_erofs_do_map_blocks(struct inode *inode,
 		map->m_flags |= EROFS_MAP_META;
 		map->m_pa = vi->z_fragmentoff;
 		map->m_plen = vi->z_idata_size;
+		if (erofs_blkoff(sb, map->m_pa) + map->m_plen > sb->s_blocksize) {
+			erofs_err(sb, "invalid tail-packing pclustersize %llu",
+				  map->m_plen);
+			err = -EFSCORRUPTED;
+			goto unmap_out;
+		}
 	} else if (fragment && m.lcn == vi->z_tailextent_headlcn) {
 		map->m_flags |= EROFS_MAP_FRAGMENT;
 	} else {
-		map->m_pa = erofs_pos(inode->i_sb, m.pblk);
+		map->m_pa = erofs_pos(sb, m.pblk);
 		err = z_erofs_get_extent_compressedlen(&m, initial_lcn);
 		if (err)
 			goto unmap_out;
@@ -495,7 +502,7 @@ static int z_erofs_do_map_blocks(struct inode *inode,
 		afmt = m.headtype == Z_EROFS_LCLUSTER_TYPE_HEAD2 ?
 			vi->z_algorithmtype[1] : vi->z_algorithmtype[0];
 		if (!(EROFS_I_SB(inode)->available_compr_algs & (1 << afmt))) {
-			erofs_err(inode->i_sb, "inconsistent algorithmtype %u for nid %llu",
+			erofs_err(sb, "inconsistent algorithmtype %u for nid %llu",
 				  afmt, vi->nid);
 			err = -EFSCORRUPTED;
 			goto unmap_out;
@@ -596,26 +603,8 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
 		goto out_put_metabuf;
 	}
 
-	if (vi->z_idata_size) {
-		struct erofs_map_blocks map = {
-			.buf = __EROFS_BUF_INITIALIZER
-		};
-
-		err = z_erofs_do_map_blocks(inode, &map,
-					    EROFS_GET_BLOCKS_FINDTAIL);
-		erofs_put_metabuf(&map.buf);
-
-		if (erofs_blkoff(sb, map.m_pa) + map.m_plen > sb->s_blocksize) {
-			erofs_err(sb, "invalid tail-packing pclustersize %llu",
-				  map.m_plen);
-			err = -EFSCORRUPTED;
-		}
-		if (err < 0)
-			goto out_put_metabuf;
-	}
-
-	if (vi->z_advise & Z_EROFS_ADVISE_FRAGMENT_PCLUSTER &&
-	    !(h->h_clusterbits >> Z_EROFS_FRAGMENT_INODE_BIT)) {
+	if (vi->z_idata_size ||
+	    (vi->z_advise & Z_EROFS_ADVISE_FRAGMENT_PCLUSTER)) {
 		struct erofs_map_blocks map = {
 			.buf = __EROFS_BUF_INITIALIZER
 		};
-- 
2.39.5


