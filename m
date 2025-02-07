Return-Path: <stable+bounces-114254-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20701A2C527
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 15:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13A961885D70
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 14:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D159023E24F;
	Fri,  7 Feb 2025 14:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kr2eLa1B"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB3623CEF7
	for <stable@vger.kernel.org>; Fri,  7 Feb 2025 14:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738938323; cv=none; b=sUt7oH5tUHDHYfalYaqaAuYR7Y8Lc1Sc8AytaFVAftxH6D2DeS1/nqJv/nrebACPtds0EtRonUzstpuEA75XtgFh6ABmSqger9eRXm0LKURYLTCt3z+T8AUJzH4OYcicEAxkq9U6lCn/5+vS2ENAEKMH1yAKITv5xzCjcfCXi4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738938323; c=relaxed/simple;
	bh=CBC5AV5CFatYcOY/NEWGjKSVYk5+aWJKjjveSx5kw1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BeTT1SHwENHdlZJveO1jM9uHEr3/uKHo0/H/0m1ZCd/tMtz9XiHoH4w1se7p8Z442JRJTjBYulp1PJNkQYcOY3eRv7PgSfMcQAeAGSHjMHws8eskAjXKmUseI5mikYHVJRyiMyJEANhBLqSw76hqaIXOwWz5KVpg0WyZJ7MVLqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kr2eLa1B; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2166360285dso38449055ad.1
        for <stable@vger.kernel.org>; Fri, 07 Feb 2025 06:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738938321; x=1739543121; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dk9cMCJj0ooTuz9J/y7qoy+6DxW5uNSjR6+3Yik244A=;
        b=Kr2eLa1B2+nK+Vo16UHRu1/ZDRLabfLsgTlblptTSljJkoUGHnYpK13JWzcs4lc5fV
         Z5DptnsNQaSNbYWtBuRHBHG3Bh3Ub5yDGuBj1Hhc71UD24Xy3mVhGTkMFIqDnQ0GIgNZ
         hf/xinHI4B4mChRkW0fG8O+VfaBUQTRVgEUOAiKR/50lQgMI9pO4ZwmOVmOOKouf4B7l
         b07G0ixCN3h5JrJLdw5eVJcdUygQt7iJGxzVMcnlxFHGEGCCWRCNPDRBZ4aahSBYsRVn
         XEjXnzsZ85LPevaol1qkHqPYwwv5RhZGsmnjlIGzVENXXb/4oS6oKFPDXhwKDko0DuSr
         AFSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738938321; x=1739543121;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dk9cMCJj0ooTuz9J/y7qoy+6DxW5uNSjR6+3Yik244A=;
        b=wRAW5czqnwOe6W/q6UXsFHV/WyuCrgTZvHHhGp9wICZx0ED12tOvud4InWj1FoUa1t
         Nif8vBlauFn3YanshDwi7zbAi08N3MRrQXnWO0y7a6dBEstRdFVUp5B3c+m1d29WMYos
         H15YXocWrTtSA/h27VMOu83sNRgucCBH7JMUyEEMmK6N4stdReA3Sig2Pqe34DGAMm8b
         oNMEIOETxfzsQIxPOyOdismYxhFTpROtepzgZrzuMyuSMiXdUjN+SDlqwvOfkLcN7gs8
         wWR5VTRGIUTo240YJuBZK3EJi1TedBmr9sWRfLJQcQ5qKQb2AFp2cFAeIP3ugoUTHzY1
         FDQw==
X-Gm-Message-State: AOJu0Ywsb81ruztng8Zv9LTJIdw0Z0TiXtq/EEfIcF2aoeQ/od84AnEn
	JE/cSP2AL/oRV6/huHzFzR0boTvZR33a3nhUn/SVJR3DrlOTaiGXf0za1A==
X-Gm-Gg: ASbGncvM+cYsMSKVVy0rU6auRi3muHz9QCiKqmXUhN2NuY0ZfSppOO/OtyH7aVFGwbY
	TpH0ZlbOt7UVKpMxT7hTOPStsgH0dS1CYRlCwzHtpZc9gM7FsWZ/fPbuUI6zO87aVyd0C4gFuG3
	KWFTcRkLeI4QT3e2fkwL8UNO9cLUOaxo9hdjk0ytvMaO1oHijlNRolYXUbJb9x2svRkQLpbb0Hc
	LDemvIbITNkDj67vSGitkc0/olgVlM1CuBHar97bpRFic3kdAfyTxv7mVux+Nc6M6ZjQjboEUID
	MS3IhbalXTVrjIe1SDsENVsLURotTouTvJbkgKrUeJ+pFWHyk4/QIGAJeg==
X-Google-Smtp-Source: AGHT+IGCnsy0OSMd+AZiKHokjo00Op76hHVgk7nc3Fmu3NSeIsns18hrRLawWkYLX+rOqlYbmazkTg==
X-Received: by 2002:a17:903:234e:b0:216:4883:fb43 with SMTP id d9443c01a7336-21f4e7594e5mr61173285ad.32.1738938320741;
        Fri, 07 Feb 2025 06:25:20 -0800 (PST)
Received: from carrot.. (i222-151-22-8.s42.a014.ap.plala.or.jp. [222.151.22.8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3655164bsm31174055ad.85.2025.02.07.06.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 06:25:20 -0800 (PST)
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 5.4 5.10 5.15 1/3] nilfs2: do not output warnings when clearing dirty buffers
Date: Fri,  7 Feb 2025 23:23:47 +0900
Message-ID: <20250207142512.6129-2-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250207142512.6129-1-konishi.ryusuke@gmail.com>
References: <20250207142512.6129-1-konishi.ryusuke@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 299910dcb4525ac0274f3efa9527876315ba4f67 upstream.

After detecting file system corruption and degrading to a read-only mount,
dirty folios and buffers in the page cache are cleared, and a large number
of warnings are output at that time, often filling up the kernel log.

In this case, since the degrading to a read-only mount is output to the
kernel log, these warnings are not very meaningful, and are rather a
nuisance in system management and debugging.

The related nilfs2-specific page/folio routines have a silent argument
that suppresses the warning output, but since it is not currently used
meaningfully, remove both the silent argument and the warning output.

[konishi.ryusuke@gmail.com: adjusted for page/folio conversion]
Link: https://lkml.kernel.org/r/20240816090128.4561-1-konishi.ryusuke@gmail.com
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: ca76bb226bf4 ("nilfs2: do not force clear folio if buffer is referenced")
---
 fs/nilfs2/inode.c |  4 ++--
 fs/nilfs2/mdt.c   |  6 +++---
 fs/nilfs2/page.c  | 20 +++-----------------
 fs/nilfs2/page.h  |  4 ++--
 4 files changed, 10 insertions(+), 24 deletions(-)

diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
index 97c1beb00637..78d11e3275b3 100644
--- a/fs/nilfs2/inode.c
+++ b/fs/nilfs2/inode.c
@@ -162,7 +162,7 @@ static int nilfs_writepages(struct address_space *mapping,
 	int err = 0;
 
 	if (sb_rdonly(inode->i_sb)) {
-		nilfs_clear_dirty_pages(mapping, false);
+		nilfs_clear_dirty_pages(mapping);
 		return -EROFS;
 	}
 
@@ -185,7 +185,7 @@ static int nilfs_writepage(struct page *page, struct writeback_control *wbc)
 		 * have dirty pages that try to be flushed in background.
 		 * So, here we simply discard this dirty page.
 		 */
-		nilfs_clear_dirty_page(page, false);
+		nilfs_clear_dirty_page(page);
 		unlock_page(page);
 		return -EROFS;
 	}
diff --git a/fs/nilfs2/mdt.c b/fs/nilfs2/mdt.c
index bd3e0f9144ff..8156d2b5ec6c 100644
--- a/fs/nilfs2/mdt.c
+++ b/fs/nilfs2/mdt.c
@@ -410,7 +410,7 @@ nilfs_mdt_write_page(struct page *page, struct writeback_control *wbc)
 		 * have dirty pages that try to be flushed in background.
 		 * So, here we simply discard this dirty page.
 		 */
-		nilfs_clear_dirty_page(page, false);
+		nilfs_clear_dirty_page(page);
 		unlock_page(page);
 		return -EROFS;
 	}
@@ -632,10 +632,10 @@ void nilfs_mdt_restore_from_shadow_map(struct inode *inode)
 	if (mi->mi_palloc_cache)
 		nilfs_palloc_clear_cache(inode);
 
-	nilfs_clear_dirty_pages(inode->i_mapping, true);
+	nilfs_clear_dirty_pages(inode->i_mapping);
 	nilfs_copy_back_pages(inode->i_mapping, shadow->inode->i_mapping);
 
-	nilfs_clear_dirty_pages(ii->i_assoc_inode->i_mapping, true);
+	nilfs_clear_dirty_pages(ii->i_assoc_inode->i_mapping);
 	nilfs_copy_back_pages(ii->i_assoc_inode->i_mapping,
 			      NILFS_I(shadow->inode)->i_assoc_inode->i_mapping);
 
diff --git a/fs/nilfs2/page.c b/fs/nilfs2/page.c
index d2d6d5c761e8..93f24fa3ab10 100644
--- a/fs/nilfs2/page.c
+++ b/fs/nilfs2/page.c
@@ -354,9 +354,8 @@ void nilfs_copy_back_pages(struct address_space *dmap,
 /**
  * nilfs_clear_dirty_pages - discard dirty pages in address space
  * @mapping: address space with dirty pages for discarding
- * @silent: suppress [true] or print [false] warning messages
  */
-void nilfs_clear_dirty_pages(struct address_space *mapping, bool silent)
+void nilfs_clear_dirty_pages(struct address_space *mapping)
 {
 	struct pagevec pvec;
 	unsigned int i;
@@ -377,7 +376,7 @@ void nilfs_clear_dirty_pages(struct address_space *mapping, bool silent)
 			 * was acquired.  Skip processing in that case.
 			 */
 			if (likely(page->mapping == mapping))
-				nilfs_clear_dirty_page(page, silent);
+				nilfs_clear_dirty_page(page);
 
 			unlock_page(page);
 		}
@@ -389,19 +388,11 @@ void nilfs_clear_dirty_pages(struct address_space *mapping, bool silent)
 /**
  * nilfs_clear_dirty_page - discard dirty page
  * @page: dirty page that will be discarded
- * @silent: suppress [true] or print [false] warning messages
  */
-void nilfs_clear_dirty_page(struct page *page, bool silent)
+void nilfs_clear_dirty_page(struct page *page)
 {
-	struct inode *inode = page->mapping->host;
-	struct super_block *sb = inode->i_sb;
-
 	BUG_ON(!PageLocked(page));
 
-	if (!silent)
-		nilfs_warn(sb, "discard dirty page: offset=%lld, ino=%lu",
-			   page_offset(page), inode->i_ino);
-
 	ClearPageUptodate(page);
 	ClearPageMappedToDisk(page);
 	ClearPageChecked(page);
@@ -417,11 +408,6 @@ void nilfs_clear_dirty_page(struct page *page, bool silent)
 		bh = head = page_buffers(page);
 		do {
 			lock_buffer(bh);
-			if (!silent)
-				nilfs_warn(sb,
-					   "discard dirty block: blocknr=%llu, size=%zu",
-					   (u64)bh->b_blocknr, bh->b_size);
-
 			set_mask_bits(&bh->b_state, clear_bits, 0);
 			unlock_buffer(bh);
 		} while (bh = bh->b_this_page, bh != head);
diff --git a/fs/nilfs2/page.h b/fs/nilfs2/page.h
index 62b9bb469e92..a5b9b5a457ab 100644
--- a/fs/nilfs2/page.h
+++ b/fs/nilfs2/page.h
@@ -41,8 +41,8 @@ void nilfs_page_bug(struct page *);
 
 int nilfs_copy_dirty_pages(struct address_space *, struct address_space *);
 void nilfs_copy_back_pages(struct address_space *, struct address_space *);
-void nilfs_clear_dirty_page(struct page *, bool);
-void nilfs_clear_dirty_pages(struct address_space *, bool);
+void nilfs_clear_dirty_page(struct page *page);
+void nilfs_clear_dirty_pages(struct address_space *mapping);
 void nilfs_mapping_init(struct address_space *mapping, struct inode *inode);
 unsigned int nilfs_page_count_clean_buffers(struct page *, unsigned int,
 					    unsigned int);
-- 
2.43.5


