Return-Path: <stable+bounces-164449-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2F9B0F47C
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 15:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 837A57B41FF
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 13:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF0F2E88AB;
	Wed, 23 Jul 2025 13:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bHrnu/Yj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFD728F955
	for <stable@vger.kernel.org>; Wed, 23 Jul 2025 13:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753278620; cv=none; b=KLFRSu2v6693WwfbcTbaTXVGO5LtVMpFcjZbksxRsTfWusHE+wiLfha8hNUzZ91uT1wI4PQki8jKDdh7/fd5Bcf0n0vEtjcj+SmgOJdLjYxJPNSNpzvkwd8ZnpZvkKHYXJ/7qL0JyPHflh5KQ52J63WQKd47UdqpTwOjeK3ulsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753278620; c=relaxed/simple;
	bh=hGyBMcc4zl9hm9439PFUuaVpDoyBOCz3nLJJCI/10vA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DXlkkkuy50qg2l7j28D78gDdSlDcjQrnweCGr/T53Le/gytrvfR6Y7lTv/vcsaAA++bmSL8ssbJPnv0Ngb6SeayabQ4fWQEAssW/O+jTANE1MKRHp3lWXe4ifdYmMLQ64DzDd6ajQKSatm5grrfSnSIaLQVf9hdPp4qSQ++2M00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bHrnu/Yj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16287C4CEF6;
	Wed, 23 Jul 2025 13:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753278618;
	bh=hGyBMcc4zl9hm9439PFUuaVpDoyBOCz3nLJJCI/10vA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bHrnu/Yj31eI8PnGPAMszvlstdT/q64pG+9WkSybklPw5kG4Vjg8fEuxdwgyZks2M
	 waq6dH4CzEKgwKxTt53mqu/SaPmGuGsmWl5pckbQXEsC8kkDx5YZIfZcKKNghJEp+n
	 fNTrdxEdgZwat4sNG0fgwG447xbknQcJfDwZFjUnoQ+gyzs5K9+Gzpd1OopLIX2ngT
	 qlYFMlEvIQBDAjg9aOvfqb/L1oWz2fqnpw0PPyFLaELAmUf3Zk9xUdzHlW+FSQ09oG
	 tKUezj81s/mTHaA7BY5crsUHz+1rT5sVE5j17F9Krd7FMKx83HhK7qsVVRP0BRZTdQ
	 INNotU4mCv7AA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hongzhen Luo <hongzhen@linux.alibaba.com>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Chao Yu <chao@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/6] erofs: use Z_EROFS_LCLUSTER_TYPE_MAX to simplify switches
Date: Wed, 23 Jul 2025 09:50:06 -0400
Message-Id: <20250723135009.1089152-3-sashal@kernel.org>
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

From: Hongzhen Luo <hongzhen@linux.alibaba.com>

[ Upstream commit 3b7781aeaefb627d4e07c1af9be923f9e8047d8b ]

There's no need to enumerate each type.  No logic changes.

Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Link: https://lore.kernel.org/r/20250210032923.3382136-1-hongzhen@linux.alibaba.com
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Stable-dep-of: b44686c8391b ("erofs: fix large fragment handling")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/erofs/zmap.c | 63 +++++++++++++++++++------------------------------
 1 file changed, 24 insertions(+), 39 deletions(-)

diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 689437e99a5a3..d278ebd602816 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -265,26 +265,22 @@ static int z_erofs_extent_lookback(struct z_erofs_maprecorder *m,
 		if (err)
 			return err;
 
-		switch (m->type) {
-		case Z_EROFS_LCLUSTER_TYPE_NONHEAD:
+		if (m->type >= Z_EROFS_LCLUSTER_TYPE_MAX) {
+			erofs_err(sb, "unknown type %u @ lcn %lu of nid %llu",
+				  m->type, lcn, vi->nid);
+			DBG_BUGON(1);
+			return -EOPNOTSUPP;
+		} else if (m->type == Z_EROFS_LCLUSTER_TYPE_NONHEAD) {
 			lookback_distance = m->delta[0];
 			if (!lookback_distance)
-				goto err_bogus;
+				break;
 			continue;
-		case Z_EROFS_LCLUSTER_TYPE_PLAIN:
-		case Z_EROFS_LCLUSTER_TYPE_HEAD1:
-		case Z_EROFS_LCLUSTER_TYPE_HEAD2:
+		} else {
 			m->headtype = m->type;
 			m->map->m_la = (lcn << lclusterbits) | m->clusterofs;
 			return 0;
-		default:
-			erofs_err(sb, "unknown type %u @ lcn %lu of nid %llu",
-				  m->type, lcn, vi->nid);
-			DBG_BUGON(1);
-			return -EOPNOTSUPP;
 		}
 	}
-err_bogus:
 	erofs_err(sb, "bogus lookback distance %u @ lcn %lu of nid %llu",
 		  lookback_distance, m->lcn, vi->nid);
 	DBG_BUGON(1);
@@ -329,35 +325,28 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
 	DBG_BUGON(lcn == initial_lcn &&
 		  m->type == Z_EROFS_LCLUSTER_TYPE_NONHEAD);
 
-	switch (m->type) {
-	case Z_EROFS_LCLUSTER_TYPE_PLAIN:
-	case Z_EROFS_LCLUSTER_TYPE_HEAD1:
-	case Z_EROFS_LCLUSTER_TYPE_HEAD2:
+	if (m->type == Z_EROFS_LCLUSTER_TYPE_NONHEAD) {
+		if (m->delta[0] != 1) {
+			erofs_err(sb, "bogus CBLKCNT @ lcn %lu of nid %llu", lcn, vi->nid);
+			DBG_BUGON(1);
+			return -EFSCORRUPTED;
+		}
+		if (m->compressedblks)
+			goto out;
+	} else if (m->type < Z_EROFS_LCLUSTER_TYPE_MAX) {
 		/*
 		 * if the 1st NONHEAD lcluster is actually PLAIN or HEAD type
 		 * rather than CBLKCNT, it's a 1 block-sized pcluster.
 		 */
 		m->compressedblks = 1;
-		break;
-	case Z_EROFS_LCLUSTER_TYPE_NONHEAD:
-		if (m->delta[0] != 1)
-			goto err_bonus_cblkcnt;
-		if (m->compressedblks)
-			break;
-		fallthrough;
-	default:
-		erofs_err(sb, "cannot found CBLKCNT @ lcn %lu of nid %llu", lcn,
-			  vi->nid);
-		DBG_BUGON(1);
-		return -EFSCORRUPTED;
+		goto out;
 	}
+	erofs_err(sb, "cannot found CBLKCNT @ lcn %lu of nid %llu", lcn, vi->nid);
+	DBG_BUGON(1);
+	return -EFSCORRUPTED;
 out:
 	m->map->m_plen = erofs_pos(sb, m->compressedblks);
 	return 0;
-err_bonus_cblkcnt:
-	erofs_err(sb, "bogus CBLKCNT @ lcn %lu of nid %llu", lcn, vi->nid);
-	DBG_BUGON(1);
-	return -EFSCORRUPTED;
 }
 
 static int z_erofs_get_extent_decompressedlen(struct z_erofs_maprecorder *m)
@@ -386,9 +375,7 @@ static int z_erofs_get_extent_decompressedlen(struct z_erofs_maprecorder *m)
 				m->delta[1] = 1;
 				DBG_BUGON(1);
 			}
-		} else if (m->type == Z_EROFS_LCLUSTER_TYPE_PLAIN ||
-			   m->type == Z_EROFS_LCLUSTER_TYPE_HEAD1 ||
-			   m->type == Z_EROFS_LCLUSTER_TYPE_HEAD2) {
+		} else if (m->type < Z_EROFS_LCLUSTER_TYPE_MAX) {
 			if (lcn != headlcn)
 				break;	/* ends at the next HEAD lcluster */
 			m->delta[1] = 1;
@@ -452,8 +439,7 @@ static int z_erofs_do_map_blocks(struct inode *inode,
 		}
 		/* m.lcn should be >= 1 if endoff < m.clusterofs */
 		if (!m.lcn) {
-			erofs_err(inode->i_sb,
-				  "invalid logical cluster 0 at nid %llu",
+			erofs_err(inode->i_sb, "invalid logical cluster 0 at nid %llu",
 				  vi->nid);
 			err = -EFSCORRUPTED;
 			goto unmap_out;
@@ -469,8 +455,7 @@ static int z_erofs_do_map_blocks(struct inode *inode,
 			goto unmap_out;
 		break;
 	default:
-		erofs_err(inode->i_sb,
-			  "unknown type %u @ offset %llu of nid %llu",
+		erofs_err(inode->i_sb, "unknown type %u @ offset %llu of nid %llu",
 			  m.type, ofs, vi->nid);
 		err = -EOPNOTSUPP;
 		goto unmap_out;
-- 
2.39.5


