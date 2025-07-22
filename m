Return-Path: <stable+bounces-163686-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9ABB0D6DB
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 12:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A038549681
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 10:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E228D2E7BDD;
	Tue, 22 Jul 2025 10:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="McaOUUyE"
X-Original-To: stable@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671082E7654;
	Tue, 22 Jul 2025 10:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753178449; cv=none; b=TvNyGsUTBDsISoJyqqf854/8IEMhAF+HDGSayv7ednFzA0oA8HvnPhiGsUaFjp7krcUr6ndHqmXIBpl7ctdySbGEGRz9hcGC6LYt71xDJWSkZpCKsyFYfSSNlwhtfPDuSySVSzu75F9hBkBjJYLfzBUaHgod5qD+cMbX/rCcwHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753178449; c=relaxed/simple;
	bh=/ONZcVGzbRl6s/xzTD5IlwXiMfI9KKJfDsxegCaeZ28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B/g1SyAgSvBmv2kz6TkI6vRPteVs/tmAefD2pnqJtZDT9vG6eWYQI64i1l0LQ3N9CTWgyM1j2CtXT1BUNpI9diOezQDet09ocGOv2ZJ/+bF4UjjRmShQaQTC/g5d+OEDmeU+WiiVjoFp4keIo9ea3rzk5/0Yu2GNm7h5ENZ6N3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=McaOUUyE; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1753178439; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=5oAOIGk3wQoTxgJtJWrUbP/U+P36XOKJgL0cO17EcOQ=;
	b=McaOUUyErKq1oVZ+fTPe1sr0nvibIVJg7iVfqPUQ+GOyO8Qg+YpRqREIS/cy4jHFVIfGDur31gnVSeNh5nVFXKfZnpgzT8xDuMTTHW/Fo4jONxK9Pk0ggpUANPG2IskJU+Upq4i4kqOkb6dtxFl8FhfSsPR4ygQTwUZy7i7Qrjo=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WjVvTq1_1753178436 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 22 Jul 2025 18:00:37 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Stefan Kerkmann <s.kerkmann@pengutronix.de>
Cc: linux-erofs@lists.ozlabs.org,
	LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 6.1.y 2/5] erofs: sunset erofs_dbg()
Date: Tue, 22 Jul 2025 18:00:26 +0800
Message-ID: <20250722100029.3052177-3-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250722100029.3052177-1-hsiangkao@linux.alibaba.com>
References: <20250722100029.3052177-1-hsiangkao@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 10656f9ca60ed85f4cfc06bcbe1f240ee310fa8c upstream.

Such debug messages are rarely used now.  Let's get rid of these,
and revert locally if they are needed for debugging.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Link: https://lore.kernel.org/r/20230414083027.12307-1-hsiangkao@linux.alibaba.com
---
 fs/erofs/inode.c    | 3 ---
 fs/erofs/internal.h | 2 --
 fs/erofs/namei.c    | 9 +++------
 fs/erofs/zdata.c    | 5 -----
 fs/erofs/zmap.c     | 3 ---
 5 files changed, 3 insertions(+), 19 deletions(-)

diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 7dcf350b9fef..3cbef6318b7b 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -26,9 +26,6 @@ static void *erofs_read_inode(struct erofs_buf *buf,
 	blkaddr = erofs_blknr(sb, inode_loc);
 	*ofs = erofs_blkoff(sb, inode_loc);
 
-	erofs_dbg("%s, reading inode nid %llu at %u of blkaddr %u",
-		  __func__, vi->nid, *ofs, blkaddr);
-
 	kaddr = erofs_read_metabuf(buf, sb, blkaddr, EROFS_KMAP);
 	if (IS_ERR(kaddr)) {
 		erofs_err(sb, "failed to get inode (nid: %llu) page, err %ld",
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index d7cd1e619d46..126970932805 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -32,10 +32,8 @@ __printf(3, 4) void _erofs_info(struct super_block *sb,
 #define erofs_info(sb, fmt, ...) \
 	_erofs_info(sb, __func__, fmt "\n", ##__VA_ARGS__)
 #ifdef CONFIG_EROFS_FS_DEBUG
-#define erofs_dbg(x, ...)       pr_debug(x "\n", ##__VA_ARGS__)
 #define DBG_BUGON               BUG_ON
 #else
-#define erofs_dbg(x, ...)       ((void)0)
 #define DBG_BUGON(x)            ((void)(x))
 #endif	/* !CONFIG_EROFS_FS_DEBUG */
 
diff --git a/fs/erofs/namei.c b/fs/erofs/namei.c
index 8332428b780c..c0d5ffb62420 100644
--- a/fs/erofs/namei.c
+++ b/fs/erofs/namei.c
@@ -203,16 +203,13 @@ static struct dentry *erofs_lookup(struct inode *dir, struct dentry *dentry,
 
 	err = erofs_namei(dir, &dentry->d_name, &nid, &d_type);
 
-	if (err == -ENOENT) {
+	if (err == -ENOENT)
 		/* negative dentry */
 		inode = NULL;
-	} else if (err) {
+	else if (err)
 		inode = ERR_PTR(err);
-	} else {
-		erofs_dbg("%s, %pd (nid %llu) found, d_type %u", __func__,
-			  dentry, nid, d_type);
+	else
 		inode = erofs_iget(dir->i_sb, nid);
-	}
 	return d_splice_alias(inode, dentry);
 }
 
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 32ca6d3e373a..5c0f855ab18d 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -818,8 +818,6 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 
 	if (offset + cur < map->m_la ||
 	    offset + cur >= map->m_la + map->m_llen) {
-		erofs_dbg("out-of-range map @ pos %llu", offset + cur);
-
 		if (z_erofs_collector_end(fe))
 			fe->backmost = false;
 		map->m_la = offset + cur;
@@ -935,9 +933,6 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 	if (err)
 		z_erofs_page_mark_eio(page);
 	z_erofs_onlinepage_endio(page);
-
-	erofs_dbg("%s, finish page: %pK spiltted: %u map->m_llen %llu",
-		  __func__, page, spiltted, map->m_llen);
 	return err;
 }
 
diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 2cd70cf4c8b2..d2d7fe826091 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -603,9 +603,6 @@ static int z_erofs_do_map_blocks(struct inode *inode,
 
 unmap_out:
 	erofs_unmap_metabuf(&m.map->buf);
-	erofs_dbg("%s, m_la %llu m_pa %llu m_llen %llu m_plen %llu m_flags 0%o",
-		  __func__, map->m_la, map->m_pa,
-		  map->m_llen, map->m_plen, map->m_flags);
 	return err;
 }
 
-- 
2.43.5


