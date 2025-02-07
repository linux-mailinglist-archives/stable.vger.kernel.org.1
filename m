Return-Path: <stable+bounces-114256-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1C2A2C529
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 15:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0807163A6F
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 14:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8F923E25D;
	Fri,  7 Feb 2025 14:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Su5odgkp"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDF623CEF7
	for <stable@vger.kernel.org>; Fri,  7 Feb 2025 14:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738938328; cv=none; b=HIa3XA+oUy0TBDU1fbD6cXkZP5w94PjgmpUQctI8UxjNoadcXwYnKOfaFHWaf1OaHJqk9235af+1DCSP1ulmvzM4ioISGRTOhkVMUGpfPY6LyYgn4Dvl8ihRlt7rhpW/6VvvsASpJXtLebY4Q6etkBJMSFVKThx5eDqd83BC7Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738938328; c=relaxed/simple;
	bh=tAlCbRSP6IuW74x8rerdwtjdYTiYG+MGcK5GJOionjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TnHI6YHQaPLnn3iutCo9f9Lz6eb5UQhlroIcGEZfH0qgkr1mGRCs3qXfGeVd/WBC49KaHSJTyk+6eoHb9HYGmTaxtjSV55Udxaddh/XZzd0eUZdlHOfJ8oqz7bpwy4nhArygsdFB/QSL+kcREc4sFhjHcIgU1HmussVAo9S7ajQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Su5odgkp; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2166360285dso38452155ad.1
        for <stable@vger.kernel.org>; Fri, 07 Feb 2025 06:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738938326; x=1739543126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g7cxh0s7aldkQrXLM7tkWi5CCv03C+9clsFbPdwCDTY=;
        b=Su5odgkpw8/jqapOo6CdJPmNj0ei5nt8LCFF1pdeXPVXMSsFM2/qNboFKE0GQa9D4R
         K7K/F9eQTQ5QPeblPWnGfn9BqidK2ra0UAsR/t5r/6IcwSyrHV8JBYMXaHsApmNso3ub
         QiDeORvowPoCcuqkp3+YpkaKH8Waa11hN+6UtaKIegMMc297vUolF/GI5Dld4ccj87Bt
         A7gUULFD2h69r+V9Z5XvubhX0ZSmTMB9cfks3qJLNv/+WeIYGgb7uZ6SlGPKrrjpxes7
         4ARZl+VbhVk1bG2JTXvEwhU4tpkWHcnvwPvR2f30g6ZdclhoUxVgqy5MrdW9TzuSCWgO
         Aw5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738938326; x=1739543126;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g7cxh0s7aldkQrXLM7tkWi5CCv03C+9clsFbPdwCDTY=;
        b=EPLbPQvksT0rC/FugWNbmC/THoEys3SVi9EmzWSyMe10ZA8z7jxvDIssvu8ZAmLQEP
         sEgqik2rXXp0t0i/QoMN7H0WerQa/4ZF5Q7brlmAUha6dK185fql0pAirPqF+Pv6SOUN
         yimOOr0IfmwVCXnX1FaH58VMz2aWt1yRpKhYV5kE4SL+/OfQ6/2Ygz0h3MFJElGKR5Og
         3fC1YPkm3MxXzquVIoqDU9/IFcDJvwn96e+HhRM9w2TaFrbyw7Ys6luYuv+4rT+q8iVj
         /o8yftCTeOxIEi1LFF91jJ4gOwSuMXCMbdD88umKdNiNvK/29O5/yXjkRscJLzmlNYSP
         X3Dw==
X-Gm-Message-State: AOJu0YzRgUtn6vYIi2ppPtwsFKtpTpKXdT4YizDyuQdYx2R+S73s5qzJ
	zamEpuhxZGA6IQElhh1ainKXYyHi94AGHDiKrfa71LME4DY7zdx3MgvFcA==
X-Gm-Gg: ASbGncv3UtAFkiqTKcIN78AZ+xjzs2ltSQpwJsoSK064epNOSE4YbNYXvdwRKs32v4h
	vTjnG6aURTImOZyNWMeRhx/ks21rDWrjKCJxIwRhuGxLw+7f68DtzSaPWsfq1qQentrxQ+stjO5
	MxpT+pokC1QTBSLNuRVs0D9drhVD4hkQRvvLgID2jh6TYTsKr9U0GtmLjNsD6y9Ibkhx57CtRx9
	JEFvt8B3AqEJY97LjsRinqb0Evd9mYHjb69YXPFD+pWRscRSABnH0UBsOUbPrftirT/Uc2mJOLK
	6Bg1JNRYYytHcjzc7sXclBx5DY+F07RqDK06icEZEE0dKr6Arjf3phiV8g==
X-Google-Smtp-Source: AGHT+IG92RFS6J49XMFWNwVRb3YLxhXXoMnAnQF69HEa7NSYK7FWcUSqmnstjIRwcDoDeZFlAQItLg==
X-Received: by 2002:a17:903:2f8b:b0:216:1367:7e3d with SMTP id d9443c01a7336-21f4e70b204mr53132625ad.31.1738938325660;
        Fri, 07 Feb 2025 06:25:25 -0800 (PST)
Received: from carrot.. (i222-151-22-8.s42.a014.ap.plala.or.jp. [222.151.22.8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3655164bsm31174055ad.85.2025.02.07.06.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 06:25:24 -0800 (PST)
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 5.4 5.10 5.15 3/3] nilfs2: protect access to buffers with no active references
Date: Fri,  7 Feb 2025 23:23:49 +0900
Message-ID: <20250207142512.6129-4-konishi.ryusuke@gmail.com>
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

commit 367a9bffabe08c04f6d725032cce3d891b2b9e1a upstream.

nilfs_lookup_dirty_data_buffers(), which iterates through the buffers
attached to dirty data folios/pages, accesses the attached buffers without
locking the folios/pages.

For data cache, nilfs_clear_folio_dirty() may be called asynchronously
when the file system degenerates to read only, so
nilfs_lookup_dirty_data_buffers() still has the potential to cause use
after free issues when buffers lose the protection of their dirty state
midway due to this asynchronous clearing and are unintentionally freed by
try_to_free_buffers().

Eliminate this race issue by adjusting the lock section in this function.

[konishi.ryusuke@gmail.com: adjusted for page/folio conversion]
Link: https://lkml.kernel.org/r/20250107200202.6432-3-konishi.ryusuke@gmail.com
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Fixes: 8c26c4e2694a ("nilfs2: fix issue with flush kernel thread after remount in RO mode because of driver's internal error or metadata corruption")
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 fs/nilfs2/segment.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index 75fd6e86f18a..2f778234ecf2 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -732,7 +732,6 @@ static size_t nilfs_lookup_dirty_data_buffers(struct inode *inode,
 		}
 		if (!page_has_buffers(page))
 			create_empty_buffers(page, i_blocksize(inode), 0);
-		unlock_page(page);
 
 		bh = head = page_buffers(page);
 		do {
@@ -742,11 +741,14 @@ static size_t nilfs_lookup_dirty_data_buffers(struct inode *inode,
 			list_add_tail(&bh->b_assoc_buffers, listp);
 			ndirties++;
 			if (unlikely(ndirties >= nlimit)) {
+				unlock_page(page);
 				pagevec_release(&pvec);
 				cond_resched();
 				return ndirties;
 			}
 		} while (bh = bh->b_this_page, bh != head);
+
+		unlock_page(page);
 	}
 	pagevec_release(&pvec);
 	cond_resched();
-- 
2.43.5


