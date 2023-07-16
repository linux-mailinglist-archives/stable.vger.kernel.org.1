Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5DF755498
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbjGPUcK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232257AbjGPUcH (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:32:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 509AD10CA
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:32:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 193DF60EAE
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:32:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C881C433C7;
        Sun, 16 Jul 2023 20:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689539520;
        bh=oUW0ngMxfkHaKm/wF1V0uBn+sFeVsKYQMFkpS3I4Oqk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vi3aaCZmjN8KyV7Fn40pSq0CnVTHaYeYc5CM7PnlEiyO+VWSMJeMSk46E1ALqg6nb
         fWW561Dx0GnVvZrqRK+u2x36faIktohhEMVN4RtKl3HRKVqWtRIvfjsHYVsEZKh+19
         52bKSTarnO7OfSwqDNRHqOa+Au99ogytxftey4jY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yue Hu <huyue2@coolpad.com>,
        Jingbo Xu <jefflexu@linux.alibaba.com>,
        Chao Yu <chao@kernel.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 036/591] erofs: simplify iloc()
Date:   Sun, 16 Jul 2023 21:42:55 +0200
Message-ID: <20230716194924.815371147@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Gao Xiang <hsiangkao@linux.alibaba.com>

[ Upstream commit b780d3fc6107464dcc43631a6208c43b6421f1e6 ]

Actually we could pass in inodes directly to clean up all callers.
Also rename iloc() as erofs_iloc().

Link: https://lore.kernel.org/r/20230114150823.432069-1-xiang@kernel.org
Reviewed-by: Yue Hu <huyue2@coolpad.com>
Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Stable-dep-of: 001b8ccd0650 ("erofs: fix compact 4B support for 16k block size")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/erofs/data.c              |  9 +++------
 fs/erofs/inode.c             |  2 +-
 fs/erofs/internal.h          | 16 +++++++++-------
 fs/erofs/xattr.c             | 20 +++++++-------------
 fs/erofs/zmap.c              | 13 +++++--------
 include/trace/events/erofs.h |  4 ++--
 6 files changed, 27 insertions(+), 37 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index fe8ac0e163f7e..b32801d716f89 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -95,11 +95,8 @@ static int erofs_map_blocks_flatmode(struct inode *inode,
 		map->m_pa = blknr_to_addr(vi->raw_blkaddr) + map->m_la;
 		map->m_plen = blknr_to_addr(lastblk) - offset;
 	} else if (tailendpacking) {
-		/* 2 - inode inline B: inode, [xattrs], inline last blk... */
-		struct erofs_sb_info *sbi = EROFS_SB(inode->i_sb);
-
-		map->m_pa = iloc(sbi, vi->nid) + vi->inode_isize +
-			vi->xattr_isize + erofs_blkoff(map->m_la);
+		map->m_pa = erofs_iloc(inode) + vi->inode_isize +
+			vi->xattr_isize + erofs_blkoff(offset);
 		map->m_plen = inode->i_size - offset;
 
 		/* inline data should be located in the same meta block */
@@ -154,7 +151,7 @@ int erofs_map_blocks(struct inode *inode,
 		unit = EROFS_BLOCK_MAP_ENTRY_SIZE;	/* block map */
 
 	chunknr = map->m_la >> vi->chunkbits;
-	pos = ALIGN(iloc(EROFS_SB(sb), vi->nid) + vi->inode_isize +
+	pos = ALIGN(erofs_iloc(inode) + vi->inode_isize +
 		    vi->xattr_isize, unit) + unit * chunknr;
 
 	kaddr = erofs_read_metabuf(&buf, sb, erofs_blknr(pos), EROFS_KMAP);
diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index ad2a82f2eb4cd..5aadc73d57652 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -14,7 +14,7 @@ static void *erofs_read_inode(struct erofs_buf *buf,
 	struct super_block *sb = inode->i_sb;
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
 	struct erofs_inode *vi = EROFS_I(inode);
-	const erofs_off_t inode_loc = iloc(sbi, vi->nid);
+	const erofs_off_t inode_loc = erofs_iloc(inode);
 
 	erofs_blk_t blkaddr, nblks = 0;
 	void *kaddr;
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 340bd56a57559..d8d09fc3ed655 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -273,11 +273,6 @@ struct erofs_buf {
 #define erofs_blkoff(addr)      ((addr) % EROFS_BLKSIZ)
 #define blknr_to_addr(nr)       ((erofs_off_t)(nr) * EROFS_BLKSIZ)
 
-static inline erofs_off_t iloc(struct erofs_sb_info *sbi, erofs_nid_t nid)
-{
-	return blknr_to_addr(sbi->meta_blkaddr) + (nid << sbi->islotbits);
-}
-
 #define EROFS_FEATURE_FUNCS(name, compat, feature) \
 static inline bool erofs_sb_has_##name(struct erofs_sb_info *sbi) \
 { \
@@ -342,8 +337,15 @@ struct erofs_inode {
 	struct inode vfs_inode;
 };
 
-#define EROFS_I(ptr)	\
-	container_of(ptr, struct erofs_inode, vfs_inode)
+#define EROFS_I(ptr)	container_of(ptr, struct erofs_inode, vfs_inode)
+
+static inline erofs_off_t erofs_iloc(struct inode *inode)
+{
+	struct erofs_sb_info *sbi = EROFS_I_SB(inode);
+
+	return blknr_to_addr(sbi->meta_blkaddr) +
+		(EROFS_I(inode)->nid << sbi->islotbits);
+}
 
 static inline unsigned long erofs_inode_datablocks(struct inode *inode)
 {
diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
index 8106bcb5a38d1..a2776abf36986 100644
--- a/fs/erofs/xattr.c
+++ b/fs/erofs/xattr.c
@@ -22,8 +22,7 @@ static int init_inode_xattrs(struct inode *inode)
 	struct xattr_iter it;
 	unsigned int i;
 	struct erofs_xattr_ibody_header *ih;
-	struct super_block *sb;
-	struct erofs_sb_info *sbi;
+	struct super_block *sb = inode->i_sb;
 	int ret = 0;
 
 	/* the most case is that xattrs of this inode are initialized. */
@@ -52,15 +51,14 @@ static int init_inode_xattrs(struct inode *inode)
 	 *    undefined right now (maybe use later with some new sb feature).
 	 */
 	if (vi->xattr_isize == sizeof(struct erofs_xattr_ibody_header)) {
-		erofs_err(inode->i_sb,
+		erofs_err(sb,
 			  "xattr_isize %d of nid %llu is not supported yet",
 			  vi->xattr_isize, vi->nid);
 		ret = -EOPNOTSUPP;
 		goto out_unlock;
 	} else if (vi->xattr_isize < sizeof(struct erofs_xattr_ibody_header)) {
 		if (vi->xattr_isize) {
-			erofs_err(inode->i_sb,
-				  "bogus xattr ibody @ nid %llu", vi->nid);
+			erofs_err(sb, "bogus xattr ibody @ nid %llu", vi->nid);
 			DBG_BUGON(1);
 			ret = -EFSCORRUPTED;
 			goto out_unlock;	/* xattr ondisk layout error */
@@ -69,11 +67,9 @@ static int init_inode_xattrs(struct inode *inode)
 		goto out_unlock;
 	}
 
-	sb = inode->i_sb;
-	sbi = EROFS_SB(sb);
 	it.buf = __EROFS_BUF_INITIALIZER;
-	it.blkaddr = erofs_blknr(iloc(sbi, vi->nid) + vi->inode_isize);
-	it.ofs = erofs_blkoff(iloc(sbi, vi->nid) + vi->inode_isize);
+	it.blkaddr = erofs_blknr(erofs_iloc(inode) + vi->inode_isize);
+	it.ofs = erofs_blkoff(erofs_iloc(inode) + vi->inode_isize);
 
 	/* read in shared xattr array (non-atomic, see kmalloc below) */
 	it.kaddr = erofs_read_metabuf(&it.buf, sb, it.blkaddr, EROFS_KMAP);
@@ -159,7 +155,6 @@ static int inline_xattr_iter_begin(struct xattr_iter *it,
 				   struct inode *inode)
 {
 	struct erofs_inode *const vi = EROFS_I(inode);
-	struct erofs_sb_info *const sbi = EROFS_SB(inode->i_sb);
 	unsigned int xattr_header_sz, inline_xattr_ofs;
 
 	xattr_header_sz = inlinexattr_header_size(inode);
@@ -170,9 +165,8 @@ static int inline_xattr_iter_begin(struct xattr_iter *it,
 
 	inline_xattr_ofs = vi->inode_isize + xattr_header_sz;
 
-	it->blkaddr = erofs_blknr(iloc(sbi, vi->nid) + inline_xattr_ofs);
-	it->ofs = erofs_blkoff(iloc(sbi, vi->nid) + inline_xattr_ofs);
-
+	it->blkaddr = erofs_blknr(erofs_iloc(inode) + inline_xattr_ofs);
+	it->ofs = erofs_blkoff(erofs_iloc(inode) + inline_xattr_ofs);
 	it->kaddr = erofs_read_metabuf(&it->buf, inode->i_sb, it->blkaddr,
 				       EROFS_KMAP_ATOMIC);
 	if (IS_ERR(it->kaddr))
diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index bb91cc6499725..3961bb55dea11 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -55,8 +55,7 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
 	if (test_bit(EROFS_I_Z_INITED_BIT, &vi->flags))
 		goto out_unlock;
 
-	pos = ALIGN(iloc(EROFS_SB(sb), vi->nid) + vi->inode_isize +
-		    vi->xattr_isize, 8);
+	pos = ALIGN(erofs_iloc(inode) + vi->inode_isize + vi->xattr_isize, 8);
 	kaddr = erofs_read_metabuf(&buf, sb, erofs_blknr(pos), EROFS_KMAP);
 	if (IS_ERR(kaddr)) {
 		err = PTR_ERR(kaddr);
@@ -169,10 +168,9 @@ static int legacy_load_cluster_from_disk(struct z_erofs_maprecorder *m,
 {
 	struct inode *const inode = m->inode;
 	struct erofs_inode *const vi = EROFS_I(inode);
-	const erofs_off_t ibase = iloc(EROFS_I_SB(inode), vi->nid);
 	const erofs_off_t pos =
-		Z_EROFS_VLE_LEGACY_INDEX_ALIGN(ibase + vi->inode_isize +
-					       vi->xattr_isize) +
+		Z_EROFS_VLE_LEGACY_INDEX_ALIGN(erofs_iloc(inode) +
+				vi->inode_isize + vi->xattr_isize) +
 		lcn * sizeof(struct z_erofs_vle_decompressed_index);
 	struct z_erofs_vle_decompressed_index *di;
 	unsigned int advise, type;
@@ -376,9 +374,8 @@ static int compacted_load_cluster_from_disk(struct z_erofs_maprecorder *m,
 	struct inode *const inode = m->inode;
 	struct erofs_inode *const vi = EROFS_I(inode);
 	const unsigned int lclusterbits = vi->z_logical_clusterbits;
-	const erofs_off_t ebase = ALIGN(iloc(EROFS_I_SB(inode), vi->nid) +
-					vi->inode_isize + vi->xattr_isize, 8) +
-		sizeof(struct z_erofs_map_header);
+	const erofs_off_t ebase = sizeof(struct z_erofs_map_header) +
+		ALIGN(erofs_iloc(inode) + vi->inode_isize + vi->xattr_isize, 8);
 	const unsigned int totalidx = DIV_ROUND_UP(inode->i_size, EROFS_BLKSIZ);
 	unsigned int compacted_4b_initial, compacted_2b;
 	unsigned int amortizedshift;
diff --git a/include/trace/events/erofs.h b/include/trace/events/erofs.h
index 4f4c44ea3a655..e095d36db9391 100644
--- a/include/trace/events/erofs.h
+++ b/include/trace/events/erofs.h
@@ -66,8 +66,8 @@ TRACE_EVENT(erofs_fill_inode,
 	TP_fast_assign(
 		__entry->dev		= inode->i_sb->s_dev;
 		__entry->nid		= EROFS_I(inode)->nid;
-		__entry->blkaddr	= erofs_blknr(iloc(EROFS_I_SB(inode), __entry->nid));
-		__entry->ofs		= erofs_blkoff(iloc(EROFS_I_SB(inode), __entry->nid));
+		__entry->blkaddr	= erofs_blknr(erofs_iloc(inode));
+		__entry->ofs		= erofs_blkoff(erofs_iloc(inode));
 	),
 
 	TP_printk("dev = (%d,%d), nid = %llu, blkaddr %u ofs %u",
-- 
2.39.2



