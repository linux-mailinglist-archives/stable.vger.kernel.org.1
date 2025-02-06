Return-Path: <stable+bounces-114157-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05DDEA2B094
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 19:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87FF6162EB8
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 18:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9961DED7C;
	Thu,  6 Feb 2025 18:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BhwrbIY2"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3B41DED59
	for <stable@vger.kernel.org>; Thu,  6 Feb 2025 18:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738865770; cv=none; b=o19QujGVmAIkm3qEBsGocsYPi7euHdglCSh+Ed5B//EACv2V8xiFI7QmgkCu67IpzdOGLM3OCVfOhzNtHd6cxekccXEbuYuEzlw6q/xTbi6REGojpAF7CA9PdlEV1DlMKZwWpk2uzkAB9tYO0YJHCJWqWohpcSCkLOquAtZ2cyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738865770; c=relaxed/simple;
	bh=Ei2hoEtZscd4fdurQs6LIo1bFStOppI9akkTQe4fTs8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hkOOGPDZYBtB/8pgn8/uFPTDiTJgQyoWCnhiGMVCDKo49qEWRifCPb57n591iv0WR9bb+wo0uJQd3skJ8E2FzeE8uwfWVATqOsyYUYlcKTLAdw37EhKHbtTj4zE4YOCG2YRgk604bv+BFM56AQtDUEsvmm3EvgQDgBjekgDjVfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BhwrbIY2; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21f464b9a27so12222085ad.1
        for <stable@vger.kernel.org>; Thu, 06 Feb 2025 10:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738865767; x=1739470567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ScvwSwaA3R8ljygY0Ik3LtOgSKvQGA2VtcEJiPMELZI=;
        b=BhwrbIY29sa1t6GKmrWvyOLBiqtb3pv3Mw4xSKRrpmSmNmobGnkbRfMFaZ/t9/Zhqz
         iM7i6fa6iKtBuG2TfrmYKI5lzdHKTjl1HcjypiMO8iJo+UxDXiPIMNXz+NaNiLkRCbsy
         CW/qLZDE3dNWZafGD75TJB+EoysDn85p2dSZFcaJKx+aOSu1sJbaYKU42BixQZMorFb+
         qOfN3E2Tskrt8IGCGoMOIzL0TpLMZhBgl/jsfeSB1HW4Vgflo47hHTyaNJT7vhgCYbor
         vsishIjN+9P2wHK0lc4MVcQ6o3iEKFbAYyjvQiCb9KO/D22BHNi3g4+j+XDOThgUkylA
         39+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738865767; x=1739470567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ScvwSwaA3R8ljygY0Ik3LtOgSKvQGA2VtcEJiPMELZI=;
        b=aj+8jWzCjyJusJ2KAa//XgLa8qEYviC6HIq3vhTNR0YWVQL8tOLltkhHL0JK+VdEER
         nexej5GcRQl0INhGOeXSXIAt78tFCQJI/buzHWI/6dTIdVYYFuJuDEif/FoxwuKx0S6K
         QW7V61ZeouSXsTy8tqHZcWJgUmT93EgQHzLy1JJW8WGeEDjBo2qZ1ZqCLXiDedqMAd/E
         W3I8vGWrXZSRKPXZ2uAiiQBPzpcOqgNvTPl+xqp9E+XwzgWczr0YGYZiKabmJfdOQMap
         dfdxTY2maWvqA7j7vwp2B941b33U8E0yiYQ4p4Q1wnGBBT1uVbZLJqJX04pgws52LVqh
         47Gw==
X-Gm-Message-State: AOJu0YxEeuVdJjUEsd6ym03u0Vna+gV+c5cnGIPUIwoG6/MAQqxPq41n
	NAv9xMZwsALcF+gWvhiqyeNX9a/bClcS3EA5tdNu6z4kBIvgnrMlP17FWg==
X-Gm-Gg: ASbGncv0Pyl/dzs3JzgORG0y084dda9wqNP2rxQwgPPFwYpYV1NwVSbSMFF0ZEu2Oe5
	OQ0yVEmvGIgE4BQHploljVtBJAyRbcZ4dsRaIxG4pJPp+D0pfHjolK/LOQD8EsQ7/mxJUfXjpQm
	Uj4Eg/p1krxJn68ipOBRKAZ7/zonDxMtEeI6uwWtAQRFAYulGn8VAIL/l0ucEoNnoF53qALXkaG
	uu4ZTjcMwcmRpUDV9ksKg8/IqT6aio31IACcJdLP1gih6s2dil6UXcGZS4Hmz5rr8IkhtIDQB2q
	16kqOtCgni3jdnHy+DtoHj/IyC0zSgl2v+OwdYqbRQ9ghCvS6HDPhX29Bg==
X-Google-Smtp-Source: AGHT+IGa3wL1eWYq/wgeCSehsRHcXMwL63lDJ/ncUxZMFQbL/qBLTA0JOvL0dxhvLCatWaskHlxtNw==
X-Received: by 2002:a05:6a00:84c:b0:725:cfa3:bc6b with SMTP id d2e1a72fcca58-7305d413212mr487973b3a.3.1738865767318;
        Thu, 06 Feb 2025 10:16:07 -0800 (PST)
Received: from carrot.. (i222-151-22-8.s42.a014.ap.plala.or.jp. [222.151.22.8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048bf1375sm1587200b3a.119.2025.02.06.10.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 10:16:06 -0800 (PST)
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.1 1/3] nilfs2: do not output warnings when clearing dirty buffers
Date: Fri,  7 Feb 2025 03:14:30 +0900
Message-ID: <20250206181559.7166-2-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250206181559.7166-1-konishi.ryusuke@gmail.com>
References: <20250206181559.7166-1-konishi.ryusuke@gmail.com>
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
index 072998626155..03113937c2db 100644
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
index d0808953296a..233954e22448 100644
--- a/fs/nilfs2/mdt.c
+++ b/fs/nilfs2/mdt.c
@@ -411,7 +411,7 @@ nilfs_mdt_write_page(struct page *page, struct writeback_control *wbc)
 		 * have dirty pages that try to be flushed in background.
 		 * So, here we simply discard this dirty page.
 		 */
-		nilfs_clear_dirty_page(page, false);
+		nilfs_clear_dirty_page(page);
 		unlock_page(page);
 		return -EROFS;
 	}
@@ -634,10 +634,10 @@ void nilfs_mdt_restore_from_shadow_map(struct inode *inode)
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
index b4e2192e8796..a5ff408f2e43 100644
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
index 21ddcdd4d63e..f5432f6a2fb6 100644
--- a/fs/nilfs2/page.h
+++ b/fs/nilfs2/page.h
@@ -41,8 +41,8 @@ void nilfs_page_bug(struct page *);
 
 int nilfs_copy_dirty_pages(struct address_space *, struct address_space *);
 void nilfs_copy_back_pages(struct address_space *, struct address_space *);
-void nilfs_clear_dirty_page(struct page *, bool);
-void nilfs_clear_dirty_pages(struct address_space *, bool);
+void nilfs_clear_dirty_page(struct page *page);
+void nilfs_clear_dirty_pages(struct address_space *mapping);
 unsigned int nilfs_page_count_clean_buffers(struct page *, unsigned int,
 					    unsigned int);
 unsigned long nilfs_find_uncommitted_extent(struct inode *inode,
-- 
2.43.5


