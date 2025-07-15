Return-Path: <stable+bounces-162073-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 808CCB05B6B
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 15:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3C02175717
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 13:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1984E1A23AF;
	Tue, 15 Jul 2025 13:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PahWPLTm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CDB2E2EFA;
	Tue, 15 Jul 2025 13:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752585601; cv=none; b=n1A3E2wJ9iUVH/HivzM6u85m5YY9+v3/XizqXp3FHbf7GQlwP3TSYKdNjGE+NkSkIL0+ujtvmWtzQTDWRDZDhwYyVM2LJkb+qkoPR5r9oZVCI4bWiplEiAo2Fh5r4pz4nQEURRxEJzSimt5Zht/48Tt96k2Frso3d/O+SDt6bh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752585601; c=relaxed/simple;
	bh=xF6znQZ3Wq0iV+AzgFlyp2SUldaL8ChoVP3rlyvFa14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N0ii2p28TuVnVihvSbxfcAWGdTbgn8XBV9Y+276t8yDA+WZq4dKEdSuq6vgRG/29pwLXXh8IcPFCpQnuHi64eJVF0Ywywy07JQ2fzrTOO8tAYAhsIkmsGw+e2z3nR05uE1n1DHsY8UWP6Rvg97gnXEMNxMUi3beKuQuYWti5baA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PahWPLTm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2206AC4CEE3;
	Tue, 15 Jul 2025 13:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752585601;
	bh=xF6znQZ3Wq0iV+AzgFlyp2SUldaL8ChoVP3rlyvFa14=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PahWPLTm8oDyOPSyc2d+MtV/xJcZ5NFnBr7LAmn2/jTvXPtPYrPuwElTCWsIUNCAx
	 cHN4v1W8apUElt/DpwHDvvxvq0pCZC95kQC+JqrwB9GC3K2Ta5J7l+uatlURCXkU2f
	 qv+w+FIFkquQl44I+TR8g0Q9nsXRiFMCqilWW9xE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Stefan Kerkmann <s.kerkmann@pengutronix.de>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 6.12 102/163] erofs: address D-cache aliasing
Date: Tue, 15 Jul 2025 15:12:50 +0200
Message-ID: <20250715130812.952237062@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250715130808.777350091@linuxfoundation.org>
References: <20250715130808.777350091@linuxfoundation.org>
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

commit 27917e8194f91dffd8b4825350c63cb68e98ce58 upstream.

Flush the D-cache before unlocking folios for compressed inodes, as
they are dirtied during decompression.

Avoid calling flush_dcache_folio() on every CPU write, since it's more
like playing whack-a-mole without real benefit.

It has no impact on x86 and arm64/risc-v: on x86, flush_dcache_folio()
is a no-op, and on arm64/risc-v, PG_dcache_clean (PG_arch_1) is clear
for new page cache folios.  However, certain ARM boards are affected,
as reported.

Fixes: 3883a79abd02 ("staging: erofs: introduce VLE decompression support")
Closes: https://lore.kernel.org/r/c1e51e16-6cc6-49d0-a63e-4e9ff6c4dd53@pengutronix.de
Closes: https://lore.kernel.org/r/38d43fae-1182-4155-9c5b-ffc7382d9917@siemens.com
Tested-by: Jan Kiszka <jan.kiszka@siemens.com>
Tested-by: Stefan Kerkmann <s.kerkmann@pengutronix.de>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Link: https://lore.kernel.org/r/20250709034614.2780117-2-hsiangkao@linux.alibaba.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/erofs/data.c         |   16 +++++++++++-----
 fs/erofs/decompressor.c |   12 ++++--------
 fs/erofs/fileio.c       |    4 ++--
 fs/erofs/internal.h     |    2 +-
 fs/erofs/zdata.c        |    6 +++---
 5 files changed, 21 insertions(+), 19 deletions(-)

--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -240,9 +240,11 @@ int erofs_map_dev(struct super_block *sb
 
 /*
  * bit 30: I/O error occurred on this folio
+ * bit 29: CPU has dirty data in D-cache (needs aliasing handling);
  * bit 0 - 29: remaining parts to complete this folio
  */
-#define EROFS_ONLINEFOLIO_EIO			(1 << 30)
+#define EROFS_ONLINEFOLIO_EIO		30
+#define EROFS_ONLINEFOLIO_DIRTY		29
 
 void erofs_onlinefolio_init(struct folio *folio)
 {
@@ -259,19 +261,23 @@ void erofs_onlinefolio_split(struct foli
 	atomic_inc((atomic_t *)&folio->private);
 }
 
-void erofs_onlinefolio_end(struct folio *folio, int err)
+void erofs_onlinefolio_end(struct folio *folio, int err, bool dirty)
 {
 	int orig, v;
 
 	do {
 		orig = atomic_read((atomic_t *)&folio->private);
-		v = (orig - 1) | (err ? EROFS_ONLINEFOLIO_EIO : 0);
+		DBG_BUGON(orig <= 0);
+		v = dirty << EROFS_ONLINEFOLIO_DIRTY;
+		v |= (orig - 1) | (!!err << EROFS_ONLINEFOLIO_EIO);
 	} while (atomic_cmpxchg((atomic_t *)&folio->private, orig, v) != orig);
 
-	if (v & ~EROFS_ONLINEFOLIO_EIO)
+	if (v & (BIT(EROFS_ONLINEFOLIO_DIRTY) - 1))
 		return;
 	folio->private = 0;
-	folio_end_read(folio, !(v & EROFS_ONLINEFOLIO_EIO));
+	if (v & BIT(EROFS_ONLINEFOLIO_DIRTY))
+		flush_dcache_folio(folio);
+	folio_end_read(folio, !(v & BIT(EROFS_ONLINEFOLIO_EIO)));
 }
 
 static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -331,13 +331,11 @@ static int z_erofs_transform_plain(struc
 		cur = min(cur, rq->outputsize);
 		if (cur && rq->out[0]) {
 			kin = kmap_local_page(rq->in[nrpages_in - 1]);
-			if (rq->out[0] == rq->in[nrpages_in - 1]) {
+			if (rq->out[0] == rq->in[nrpages_in - 1])
 				memmove(kin + rq->pageofs_out, kin + pi, cur);
-				flush_dcache_page(rq->out[0]);
-			} else {
+			else
 				memcpy_to_page(rq->out[0], rq->pageofs_out,
 					       kin + pi, cur);
-			}
 			kunmap_local(kin);
 		}
 		rq->outputsize -= cur;
@@ -355,14 +353,12 @@ static int z_erofs_transform_plain(struc
 			po = (rq->pageofs_out + cur + pi) & ~PAGE_MASK;
 			DBG_BUGON(no >= nrpages_out);
 			cnt = min(insz - pi, PAGE_SIZE - po);
-			if (rq->out[no] == rq->in[ni]) {
+			if (rq->out[no] == rq->in[ni])
 				memmove(kin + po,
 					kin + rq->pageofs_in + pi, cnt);
-				flush_dcache_page(rq->out[no]);
-			} else if (rq->out[no]) {
+			else if (rq->out[no])
 				memcpy_to_page(rq->out[no], po,
 					       kin + rq->pageofs_in + pi, cnt);
-			}
 			pi += cnt;
 		} while (pi < insz);
 		kunmap_local(kin);
--- a/fs/erofs/fileio.c
+++ b/fs/erofs/fileio.c
@@ -38,7 +38,7 @@ static void erofs_fileio_ki_complete(str
 	} else {
 		bio_for_each_folio_all(fi, &rq->bio) {
 			DBG_BUGON(folio_test_uptodate(fi.folio));
-			erofs_onlinefolio_end(fi.folio, ret);
+			erofs_onlinefolio_end(fi.folio, ret, false);
 		}
 	}
 	bio_uninit(&rq->bio);
@@ -158,7 +158,7 @@ io_retry:
 		}
 		cur += len;
 	}
-	erofs_onlinefolio_end(folio, err);
+	erofs_onlinefolio_end(folio, err, false);
 	return err;
 }
 
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -405,7 +405,7 @@ int erofs_fiemap(struct inode *inode, st
 int erofs_map_blocks(struct inode *inode, struct erofs_map_blocks *map);
 void erofs_onlinefolio_init(struct folio *folio);
 void erofs_onlinefolio_split(struct folio *folio);
-void erofs_onlinefolio_end(struct folio *folio, int err);
+void erofs_onlinefolio_end(struct folio *folio, int err, bool dirty);
 struct inode *erofs_iget(struct super_block *sb, erofs_nid_t nid);
 int erofs_getattr(struct mnt_idmap *idmap, const struct path *path,
 		  struct kstat *stat, u32 request_mask,
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1087,7 +1087,7 @@ static int z_erofs_scan_folio(struct z_e
 			tight = (bs == PAGE_SIZE);
 		}
 	} while ((end = cur) > 0);
-	erofs_onlinefolio_end(folio, err);
+	erofs_onlinefolio_end(folio, err, false);
 	return err;
 }
 
@@ -1193,7 +1193,7 @@ static void z_erofs_fill_other_copies(st
 			cur += len;
 		}
 		kunmap_local(dst);
-		erofs_onlinefolio_end(page_folio(bvi->bvec.page), err);
+		erofs_onlinefolio_end(page_folio(bvi->bvec.page), err, true);
 		list_del(p);
 		kfree(bvi);
 	}
@@ -1348,7 +1348,7 @@ static int z_erofs_decompress_pcluster(s
 
 		DBG_BUGON(z_erofs_page_is_invalidated(page));
 		if (!z_erofs_is_shortlived_page(page)) {
-			erofs_onlinefolio_end(page_folio(page), err);
+			erofs_onlinefolio_end(page_folio(page), err, true);
 			continue;
 		}
 		if (pcl->algorithmformat != Z_EROFS_COMPRESSION_LZ4) {



