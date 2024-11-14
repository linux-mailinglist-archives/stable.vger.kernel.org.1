Return-Path: <stable+bounces-93059-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5F69C9489
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 22:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC95A282690
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 21:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE9F1AC448;
	Thu, 14 Nov 2024 21:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="w0u/nIDf"
X-Original-To: stable@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C850418B484
	for <stable@vger.kernel.org>; Thu, 14 Nov 2024 21:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731619676; cv=none; b=nKpYBCgCyfvA3Xwlgf0EbIda3LJ6aoMXNSFERTxkMOpzdKN7iuULVNt0l8oG2wD6t0THiRVUYiG9/ZFG574p81i7PBVUyux/OA2zHz5jwWOZarAOpODwVUI9GT0UKHlG4xQdSsbB+u6jo6v1bWd7N9KHPA0togSEOb8l+pPTJRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731619676; c=relaxed/simple;
	bh=5QBQ0Hcm5/J1M2m4nTR6f1zXcEgjOiWy0RwMD55ONDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=snDAmockenVsN7100HU4Qdg8tqLbHNls/w8JOrWYq7ttdMWXfOtpUYQCKIXYfgkJynxOncqZtjkd1wmwEK62Gmkfr5+elE91HYhwDU2n8G6xVLtHdRbLu13x51SOIqPzc5SBXOSMDNVMKvHrNyP224JhQtFyEMzsPeb1IdOh2LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=w0u/nIDf; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4XqCtD4cyKz9t1B;
	Thu, 14 Nov 2024 22:27:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1731619668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CEmIwCci96YBjwQQs1U1ww7OPbvaN0fGhacqsB7dztY=;
	b=w0u/nIDfN68rVxZBuy0AzhxyFsIfvjfMAbJw/vDERGzJEkLXAgcPHGOFR1iXorjtuTs8jV
	7LcNJJ3Igv7Q0jrg74d08G0J1S8lPW3cNpPfB5/29aMnrHBoS97WX0vvR/y3OyZ5FO0Sqm
	Vc5P2RWwQDGtS++QYb9wFSv2zf6gW4NXTIt3hsd0xyo+LPMUqUezcAxt5ikpVL1D9Ic00B
	pgqlO6Kko4TPCcwRJNKH+Ur+IDS/brVy0UZfZQd704XRoe3y2knKSO4jmspuCgamj7hOYI
	4IOJJWiDoMidw+6YeFQyrwJZfKlh1L06lequMVPIn1JWjMNjBBaxxIAL6ubGQQ==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: stable@vger.kernel.org
Cc: jack@suse.com,
	gregkh@linuxfoundation.org,
	Jan Kara <jack@suse.cz>,
	kernel test robot <lkp@intel.com>,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH stable 5.15 1/2] udf: Allocate name buffer in directory iterator on heap
Date: Thu, 14 Nov 2024 22:26:56 +0100
Message-ID: <20241114212657.306989-2-hauke@hauke-m.de>
In-Reply-To: <20241114212657.306989-1-hauke@hauke-m.de>
References: <20241114212657.306989-1-hauke@hauke-m.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4XqCtD4cyKz9t1B

From: Jan Kara <jack@suse.cz>

commit 0aba4860b0d0216a1a300484ff536171894d49d8 upstream.

Currently we allocate name buffer in directory iterators (struct
udf_fileident_iter) on stack. These structures are relatively large
(some 360 bytes on 64-bit architectures). For udf_rename() which needs
to keep three of these structures in parallel the stack usage becomes
rather heavy - 1536 bytes in total. Allocate the name buffer in the
iterator from heap to avoid excessive stack usage.

Link: https://lore.kernel.org/all/202212200558.lK9x1KW0-lkp@intel.com
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Jan Kara <jack@suse.cz>
[Add extra include linux/slab.h]
Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 fs/udf/directory.c | 24 ++++++++++++++++--------
 fs/udf/udfdecl.h   |  2 +-
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/fs/udf/directory.c b/fs/udf/directory.c
index e97ffae07833..a30898debdd1 100644
--- a/fs/udf/directory.c
+++ b/fs/udf/directory.c
@@ -19,6 +19,7 @@
 #include <linux/bio.h>
 #include <linux/crc-itu-t.h>
 #include <linux/iversion.h>
+#include <linux/slab.h>
 
 static int udf_verify_fi(struct udf_fileident_iter *iter)
 {
@@ -248,9 +249,14 @@ int udf_fiiter_init(struct udf_fileident_iter *iter, struct inode *dir,
 	iter->elen = 0;
 	iter->epos.bh = NULL;
 	iter->name = NULL;
+	iter->namebuf = kmalloc(UDF_NAME_LEN_CS0, GFP_KERNEL);
+	if (!iter->namebuf)
+		return -ENOMEM;
 
-	if (iinfo->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB)
-		return udf_copy_fi(iter);
+	if (iinfo->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB) {
+		err = udf_copy_fi(iter);
+		goto out;
+	}
 
 	if (inode_bmap(dir, iter->pos >> dir->i_blkbits, &iter->epos,
 		       &iter->eloc, &iter->elen, &iter->loffset) !=
@@ -260,17 +266,17 @@ int udf_fiiter_init(struct udf_fileident_iter *iter, struct inode *dir,
 		udf_err(dir->i_sb,
 			"position %llu not allocated in directory (ino %lu)\n",
 			(unsigned long long)pos, dir->i_ino);
-		return -EFSCORRUPTED;
+		err = -EFSCORRUPTED;
+		goto out;
 	}
 	err = udf_fiiter_load_bhs(iter);
 	if (err < 0)
-		return err;
+		goto out;
 	err = udf_copy_fi(iter);
-	if (err < 0) {
+out:
+	if (err < 0)
 		udf_fiiter_release(iter);
-		return err;
-	}
-	return 0;
+	return err;
 }
 
 int udf_fiiter_advance(struct udf_fileident_iter *iter)
@@ -307,6 +313,8 @@ void udf_fiiter_release(struct udf_fileident_iter *iter)
 	brelse(iter->bh[0]);
 	brelse(iter->bh[1]);
 	iter->bh[0] = iter->bh[1] = NULL;
+	kfree(iter->namebuf);
+	iter->namebuf = NULL;
 }
 
 static void udf_copy_to_bufs(void *buf1, int len1, void *buf2, int len2,
diff --git a/fs/udf/udfdecl.h b/fs/udf/udfdecl.h
index f764b4d15094..d35aa42bb577 100644
--- a/fs/udf/udfdecl.h
+++ b/fs/udf/udfdecl.h
@@ -99,7 +99,7 @@ struct udf_fileident_iter {
 	struct extent_position epos;	/* Position after the above extent */
 	struct fileIdentDesc fi;	/* Copied directory entry */
 	uint8_t *name;			/* Pointer to entry name */
-	uint8_t namebuf[UDF_NAME_LEN_CS0]; /* Storage for entry name in case
+	uint8_t *namebuf;		/* Storage for entry name in case
 					 * the name is split between two blocks
 					 */
 };
-- 
2.47.0


