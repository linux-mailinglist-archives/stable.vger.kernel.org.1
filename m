Return-Path: <stable+bounces-164452-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02651B0F47D
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 15:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFEA5543AA3
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 13:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06113272E5A;
	Wed, 23 Jul 2025 13:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pBPP4MGz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77EE2E610B
	for <stable@vger.kernel.org>; Wed, 23 Jul 2025 13:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753278623; cv=none; b=GZbCfdSu7+zoj/4/dF+4OKQRR6hHJK3G3cQE4jtIKzUT1ZPcIAtWDJxC5AfuB97hmW6CoDjPIDCa0bi3pAm64Hoqp6bfNXk5WtxBBst5dX1H4Y4eZGEt96nqJBPj2patCbXPUpeCaSAPbgtSIAxsUc1C+F5qReLXgYewmhiO3ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753278623; c=relaxed/simple;
	bh=4pNOpVdchWfxNwIZ1PwC3ltVYTj3JdUXL0Q2Z8JfV8c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Nj9cZMbB3fm8YcSQykbbNhVHe8yfrJ0rD0Z/v92tEjlNdc5AMXKrrgzA1JSSnvdlKaK/NFSxPRb2WFcsLue+94pONseGKn6tBUyLd4SoRN8S9/jfXMp/knH4DMTTwmdpnAIxE/1wRzFrRaY5m55ofQiRrnl7ofOLd+6xif32k/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pBPP4MGz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4017AC4CEF1;
	Wed, 23 Jul 2025 13:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753278623;
	bh=4pNOpVdchWfxNwIZ1PwC3ltVYTj3JdUXL0Q2Z8JfV8c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pBPP4MGz7S2AzMGmihGMo3PbuOSc5AvOP7al5jqJ4Zc2QRRXVfbDAqDLGeP5ctcbv
	 ukduMxzIItsWlhh0m0HZNNQ73ynMc+WKVmrgpN+H6t3pbj8ejNf+nYYY6XxN4aG14b
	 QiCcP6M40GhEmTkoLMyuyTd2qzuj6/6MuXZrjBvQS+jQlwKDfVkSQmKDiw0V77BdhZ
	 m+/J3oSolqD/s1zS1/S4w+2RBJHau0IiO0JlkJdZyx3w82HR9yXd95EEhsa2e2/46T
	 aRzSBH0th9dT2ZLQOhtxcx6pxAHnpKaWxCMzgR/sKEI+2EOQSRidA4ebqD0nd4Nssp
	 1n15nAU91pJFA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>,
	Axel Fontaine <axel@axelfontaine.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 6/6] erofs: fix large fragment handling
Date: Wed, 23 Jul 2025 09:50:09 -0400
Message-Id: <20250723135009.1089152-6-sashal@kernel.org>
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

[ Upstream commit b44686c8391b427fb1c85a31c35077e6947c6d90 ]

Fragments aren't limited by Z_EROFS_PCLUSTER_MAX_DSIZE. However, if
a fragment's logical length is larger than Z_EROFS_PCLUSTER_MAX_DSIZE
but the fragment is not the whole inode, it currently returns
-EOPNOTSUPP because m_flags has the wrong EROFS_MAP_ENCODED flag set.
It is not intended by design but should be rare, as it can only be
reproduced by mkfs with `-Eall-fragments` in a specific case.

Let's normalize fragment m_flags using the new EROFS_MAP_FRAGMENT.

Reported-by: Axel Fontaine <axel@axelfontaine.com>
Closes: https://github.com/erofs/erofs-utils/issues/23
Fixes: 7c3ca1838a78 ("erofs: restrict pcluster size limitations")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Link: https://lore.kernel.org/r/20250711195826.3601157-1-hsiangkao@linux.alibaba.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/erofs/internal.h | 4 +++-
 fs/erofs/zdata.c    | 2 +-
 fs/erofs/zmap.c     | 7 +++----
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 06895e9fec38f..856463a702b2c 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -324,10 +324,12 @@ static inline struct folio *erofs_grab_folio_nowait(struct address_space *as,
 /* The length of extent is full */
 #define EROFS_MAP_FULL_MAPPED	0x0008
 /* Located in the special packed inode */
-#define EROFS_MAP_FRAGMENT	0x0010
+#define __EROFS_MAP_FRAGMENT	0x0010
 /* The extent refers to partial decompressed data */
 #define EROFS_MAP_PARTIAL_REF	0x0020
 
+#define EROFS_MAP_FRAGMENT	(EROFS_MAP_MAPPED | __EROFS_MAP_FRAGMENT)
+
 struct erofs_map_blocks {
 	struct erofs_buf buf;
 
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 94c1e2d64df96..f35d2eb0ed11c 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1016,7 +1016,7 @@ static int z_erofs_scan_folio(struct z_erofs_frontend *f,
 		if (!(map->m_flags & EROFS_MAP_MAPPED)) {
 			folio_zero_segment(folio, cur, end);
 			tight = false;
-		} else if (map->m_flags & EROFS_MAP_FRAGMENT) {
+		} else if (map->m_flags & __EROFS_MAP_FRAGMENT) {
 			erofs_off_t fpos = offset + cur - map->m_la;
 
 			err = z_erofs_read_fragment(inode->i_sb, folio, cur,
diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index f076cafb304f2..25a4b82c183c0 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -481,7 +481,7 @@ static int z_erofs_do_map_blocks(struct inode *inode,
 			goto unmap_out;
 		}
 	} else if (fragment && m.lcn == vi->z_tailextent_headlcn) {
-		map->m_flags |= EROFS_MAP_FRAGMENT;
+		map->m_flags = EROFS_MAP_FRAGMENT;
 	} else {
 		map->m_pa = erofs_pos(sb, m.pblk);
 		err = z_erofs_get_extent_compressedlen(&m, initial_lcn);
@@ -644,8 +644,7 @@ int z_erofs_map_blocks_iter(struct inode *inode, struct erofs_map_blocks *map,
 			    !vi->z_tailextent_headlcn) {
 				map->m_la = 0;
 				map->m_llen = inode->i_size;
-				map->m_flags = EROFS_MAP_MAPPED |
-					EROFS_MAP_FULL_MAPPED | EROFS_MAP_FRAGMENT;
+				map->m_flags = EROFS_MAP_FRAGMENT;
 			} else {
 				err = z_erofs_do_map_blocks(inode, map, flags);
 			}
@@ -678,7 +677,7 @@ static int z_erofs_iomap_begin_report(struct inode *inode, loff_t offset,
 	iomap->length = map.m_llen;
 	if (map.m_flags & EROFS_MAP_MAPPED) {
 		iomap->type = IOMAP_MAPPED;
-		iomap->addr = map.m_flags & EROFS_MAP_FRAGMENT ?
+		iomap->addr = map.m_flags & __EROFS_MAP_FRAGMENT ?
 			      IOMAP_NULL_ADDR : map.m_pa;
 	} else {
 		iomap->type = IOMAP_HOLE;
-- 
2.39.5


