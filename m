Return-Path: <stable+bounces-81525-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7A7994056
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 10:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8B67286A44
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 08:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F971F7089;
	Tue,  8 Oct 2024 07:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="f9+a7ril"
X-Original-To: stable@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47E81F7063;
	Tue,  8 Oct 2024 07:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728370978; cv=none; b=URWMbCp8w5CaQHss8kFAW3vdnQlpFi0kzt3ew7Qd4rVdShoKcdQiuSwFm4bd8p4zFzxUl3UcTknRNBKAcQV4bqWYLcFvNa8tMunN5bsU6PQiPuW6vHETUq+TgwSYOU2HntVpPXmdcmGd67qsTfPYADhiDoRhK2ESuoXu54y71TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728370978; c=relaxed/simple;
	bh=5wL3ikDYq5udbI+PYpeGs4dKbX6LYxTOT+Kn4Chd9/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EXkBvXbzN7SPTzjMCZDs2UObC3zUEkaL8A6t0oQXs7XnnR1cgnSEc3tz7uM9OpvJAgnlA+N9dzyIn1b2+pSw+ZvmWniTcNWaJroNL/44+X6Hn4iE3E2W3V6h+5o5k/R2BNjOviMQGo0CaMpPtD0ym1GUvHVQJcFL8T/plZFRg7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=f9+a7ril; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728370968; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=GnvvEgpZfu5pp7KkhPx8xhUyNlF/RjW4kmUiKH0w6ak=;
	b=f9+a7rilKaPR4miVo/wlWbZhBk1Ju+c5ZmmQ4ZyMjgIAO44Wp5PYBLQSBenmbXvxHgWvOf+1Y9JeKP04EmH/ZJvwJXn4uNsYA1vqn8MyLHlNIwEjS/XwToYz20R/VsRykKLMIHowjOELz65QLaEXi+qrMZW0hQ6d5cG10+0oVcQ=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WGbLQfS_1728370644)
          by smtp.aliyun-inc.com;
          Tue, 08 Oct 2024 14:57:25 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-erofs@lists.ozlabs.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 6.1.y 2/5] erofs: get rid of z_erofs_do_map_blocks() forward declaration
Date: Tue,  8 Oct 2024 14:57:05 +0800
Message-ID: <20241008065708.727659-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241008065708.727659-1-hsiangkao@linux.alibaba.com>
References: <20241008065708.727659-1-hsiangkao@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 999f2f9a63f475192d837a2b8595eb0962984d21 upstream.

The code can be neater without forward declarations.  Let's
get rid of z_erofs_do_map_blocks() forward declaration.

Reviewed-by: Yue Hu <huyue2@coolpad.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Stable-dep-of: 9ed50b8231e3 ("erofs: fix incorrect symlink detection in fast symlink")
Link: https://lore.kernel.org/r/20230204093040.97967-5-hsiangkao@linux.alibaba.com
[ Gao Xiang: apply this to 6.6.y to avoid further backport twists
             due to obsoleted EROFS_BLKSIZ. ]
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zmap.c | 242 ++++++++++++++++++++++++------------------------
 1 file changed, 119 insertions(+), 123 deletions(-)

diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 4864863cd129..5d1a7aff2d70 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -7,10 +7,6 @@
 #include <asm/unaligned.h>
 #include <trace/events/erofs.h>
 
-static int z_erofs_do_map_blocks(struct inode *inode,
-				 struct erofs_map_blocks *map,
-				 int flags);
-
 int z_erofs_fill_inode(struct inode *inode)
 {
 	struct erofs_inode *const vi = EROFS_I(inode);
@@ -29,125 +25,6 @@ int z_erofs_fill_inode(struct inode *inode)
 	return 0;
 }
 
-static int z_erofs_fill_inode_lazy(struct inode *inode)
-{
-	struct erofs_inode *const vi = EROFS_I(inode);
-	struct super_block *const sb = inode->i_sb;
-	int err, headnr;
-	erofs_off_t pos;
-	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
-	void *kaddr;
-	struct z_erofs_map_header *h;
-
-	if (test_bit(EROFS_I_Z_INITED_BIT, &vi->flags)) {
-		/*
-		 * paired with smp_mb() at the end of the function to ensure
-		 * fields will only be observed after the bit is set.
-		 */
-		smp_mb();
-		return 0;
-	}
-
-	if (wait_on_bit_lock(&vi->flags, EROFS_I_BL_Z_BIT, TASK_KILLABLE))
-		return -ERESTARTSYS;
-
-	err = 0;
-	if (test_bit(EROFS_I_Z_INITED_BIT, &vi->flags))
-		goto out_unlock;
-
-	pos = ALIGN(erofs_iloc(inode) + vi->inode_isize + vi->xattr_isize, 8);
-	kaddr = erofs_read_metabuf(&buf, sb, erofs_blknr(pos), EROFS_KMAP);
-	if (IS_ERR(kaddr)) {
-		err = PTR_ERR(kaddr);
-		goto out_unlock;
-	}
-
-	h = kaddr + erofs_blkoff(pos);
-	/*
-	 * if the highest bit of the 8-byte map header is set, the whole file
-	 * is stored in the packed inode. The rest bits keeps z_fragmentoff.
-	 */
-	if (h->h_clusterbits >> Z_EROFS_FRAGMENT_INODE_BIT) {
-		vi->z_advise = Z_EROFS_ADVISE_FRAGMENT_PCLUSTER;
-		vi->z_fragmentoff = le64_to_cpu(*(__le64 *)h) ^ (1ULL << 63);
-		vi->z_tailextent_headlcn = 0;
-		goto done;
-	}
-	vi->z_advise = le16_to_cpu(h->h_advise);
-	vi->z_algorithmtype[0] = h->h_algorithmtype & 15;
-	vi->z_algorithmtype[1] = h->h_algorithmtype >> 4;
-
-	headnr = 0;
-	if (vi->z_algorithmtype[0] >= Z_EROFS_COMPRESSION_MAX ||
-	    vi->z_algorithmtype[++headnr] >= Z_EROFS_COMPRESSION_MAX) {
-		erofs_err(sb, "unknown HEAD%u format %u for nid %llu, please upgrade kernel",
-			  headnr + 1, vi->z_algorithmtype[headnr], vi->nid);
-		err = -EOPNOTSUPP;
-		goto out_put_metabuf;
-	}
-
-	vi->z_logical_clusterbits = LOG_BLOCK_SIZE + (h->h_clusterbits & 7);
-	if (!erofs_sb_has_big_pcluster(EROFS_SB(sb)) &&
-	    vi->z_advise & (Z_EROFS_ADVISE_BIG_PCLUSTER_1 |
-			    Z_EROFS_ADVISE_BIG_PCLUSTER_2)) {
-		erofs_err(sb, "per-inode big pcluster without sb feature for nid %llu",
-			  vi->nid);
-		err = -EFSCORRUPTED;
-		goto out_put_metabuf;
-	}
-	if (vi->datalayout == EROFS_INODE_FLAT_COMPRESSION &&
-	    !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_1) ^
-	    !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_2)) {
-		erofs_err(sb, "big pcluster head1/2 of compact indexes should be consistent for nid %llu",
-			  vi->nid);
-		err = -EFSCORRUPTED;
-		goto out_put_metabuf;
-	}
-
-	if (vi->z_advise & Z_EROFS_ADVISE_INLINE_PCLUSTER) {
-		struct erofs_map_blocks map = {
-			.buf = __EROFS_BUF_INITIALIZER
-		};
-
-		vi->z_idata_size = le16_to_cpu(h->h_idata_size);
-		err = z_erofs_do_map_blocks(inode, &map,
-					    EROFS_GET_BLOCKS_FINDTAIL);
-		erofs_put_metabuf(&map.buf);
-
-		if (!map.m_plen ||
-		    erofs_blkoff(map.m_pa) + map.m_plen > EROFS_BLKSIZ) {
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
-		struct erofs_map_blocks map = {
-			.buf = __EROFS_BUF_INITIALIZER
-		};
-
-		vi->z_fragmentoff = le32_to_cpu(h->h_fragmentoff);
-		err = z_erofs_do_map_blocks(inode, &map,
-					    EROFS_GET_BLOCKS_FINDTAIL);
-		erofs_put_metabuf(&map.buf);
-		if (err < 0)
-			goto out_put_metabuf;
-	}
-done:
-	/* paired with smp_mb() at the beginning of the function */
-	smp_mb();
-	set_bit(EROFS_I_Z_INITED_BIT, &vi->flags);
-out_put_metabuf:
-	erofs_put_metabuf(&buf);
-out_unlock:
-	clear_and_wake_up_bit(EROFS_I_BL_Z_BIT, &vi->flags);
-	return err;
-}
-
 struct z_erofs_maprecorder {
 	struct inode *inode;
 	struct erofs_map_blocks *map;
@@ -732,6 +609,125 @@ static int z_erofs_do_map_blocks(struct inode *inode,
 	return err;
 }
 
+static int z_erofs_fill_inode_lazy(struct inode *inode)
+{
+	struct erofs_inode *const vi = EROFS_I(inode);
+	struct super_block *const sb = inode->i_sb;
+	int err, headnr;
+	erofs_off_t pos;
+	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
+	void *kaddr;
+	struct z_erofs_map_header *h;
+
+	if (test_bit(EROFS_I_Z_INITED_BIT, &vi->flags)) {
+		/*
+		 * paired with smp_mb() at the end of the function to ensure
+		 * fields will only be observed after the bit is set.
+		 */
+		smp_mb();
+		return 0;
+	}
+
+	if (wait_on_bit_lock(&vi->flags, EROFS_I_BL_Z_BIT, TASK_KILLABLE))
+		return -ERESTARTSYS;
+
+	err = 0;
+	if (test_bit(EROFS_I_Z_INITED_BIT, &vi->flags))
+		goto out_unlock;
+
+	pos = ALIGN(erofs_iloc(inode) + vi->inode_isize + vi->xattr_isize, 8);
+	kaddr = erofs_read_metabuf(&buf, sb, erofs_blknr(pos), EROFS_KMAP);
+	if (IS_ERR(kaddr)) {
+		err = PTR_ERR(kaddr);
+		goto out_unlock;
+	}
+
+	h = kaddr + erofs_blkoff(pos);
+	/*
+	 * if the highest bit of the 8-byte map header is set, the whole file
+	 * is stored in the packed inode. The rest bits keeps z_fragmentoff.
+	 */
+	if (h->h_clusterbits >> Z_EROFS_FRAGMENT_INODE_BIT) {
+		vi->z_advise = Z_EROFS_ADVISE_FRAGMENT_PCLUSTER;
+		vi->z_fragmentoff = le64_to_cpu(*(__le64 *)h) ^ (1ULL << 63);
+		vi->z_tailextent_headlcn = 0;
+		goto done;
+	}
+	vi->z_advise = le16_to_cpu(h->h_advise);
+	vi->z_algorithmtype[0] = h->h_algorithmtype & 15;
+	vi->z_algorithmtype[1] = h->h_algorithmtype >> 4;
+
+	headnr = 0;
+	if (vi->z_algorithmtype[0] >= Z_EROFS_COMPRESSION_MAX ||
+	    vi->z_algorithmtype[++headnr] >= Z_EROFS_COMPRESSION_MAX) {
+		erofs_err(sb, "unknown HEAD%u format %u for nid %llu, please upgrade kernel",
+			  headnr + 1, vi->z_algorithmtype[headnr], vi->nid);
+		err = -EOPNOTSUPP;
+		goto out_put_metabuf;
+	}
+
+	vi->z_logical_clusterbits = LOG_BLOCK_SIZE + (h->h_clusterbits & 7);
+	if (!erofs_sb_has_big_pcluster(EROFS_SB(sb)) &&
+	    vi->z_advise & (Z_EROFS_ADVISE_BIG_PCLUSTER_1 |
+			    Z_EROFS_ADVISE_BIG_PCLUSTER_2)) {
+		erofs_err(sb, "per-inode big pcluster without sb feature for nid %llu",
+			  vi->nid);
+		err = -EFSCORRUPTED;
+		goto out_put_metabuf;
+	}
+	if (vi->datalayout == EROFS_INODE_FLAT_COMPRESSION &&
+	    !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_1) ^
+	    !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_2)) {
+		erofs_err(sb, "big pcluster head1/2 of compact indexes should be consistent for nid %llu",
+			  vi->nid);
+		err = -EFSCORRUPTED;
+		goto out_put_metabuf;
+	}
+
+	if (vi->z_advise & Z_EROFS_ADVISE_INLINE_PCLUSTER) {
+		struct erofs_map_blocks map = {
+			.buf = __EROFS_BUF_INITIALIZER
+		};
+
+		vi->z_idata_size = le16_to_cpu(h->h_idata_size);
+		err = z_erofs_do_map_blocks(inode, &map,
+					    EROFS_GET_BLOCKS_FINDTAIL);
+		erofs_put_metabuf(&map.buf);
+
+		if (!map.m_plen ||
+		    erofs_blkoff(map.m_pa) + map.m_plen > EROFS_BLKSIZ) {
+			erofs_err(sb, "invalid tail-packing pclustersize %llu",
+				  map.m_plen);
+			err = -EFSCORRUPTED;
+		}
+		if (err < 0)
+			goto out_put_metabuf;
+	}
+
+	if (vi->z_advise & Z_EROFS_ADVISE_FRAGMENT_PCLUSTER &&
+	    !(h->h_clusterbits >> Z_EROFS_FRAGMENT_INODE_BIT)) {
+		struct erofs_map_blocks map = {
+			.buf = __EROFS_BUF_INITIALIZER
+		};
+
+		vi->z_fragmentoff = le32_to_cpu(h->h_fragmentoff);
+		err = z_erofs_do_map_blocks(inode, &map,
+					    EROFS_GET_BLOCKS_FINDTAIL);
+		erofs_put_metabuf(&map.buf);
+		if (err < 0)
+			goto out_put_metabuf;
+	}
+done:
+	/* paired with smp_mb() at the beginning of the function */
+	smp_mb();
+	set_bit(EROFS_I_Z_INITED_BIT, &vi->flags);
+out_put_metabuf:
+	erofs_put_metabuf(&buf);
+out_unlock:
+	clear_and_wake_up_bit(EROFS_I_BL_Z_BIT, &vi->flags);
+	return err;
+}
+
 int z_erofs_map_blocks_iter(struct inode *inode, struct erofs_map_blocks *map,
 			    int flags)
 {
-- 
2.43.5


