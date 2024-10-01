Return-Path: <stable+bounces-78586-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D629798C753
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 23:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 537CF1F220A1
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 21:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A831C9DF9;
	Tue,  1 Oct 2024 21:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P4nxLlxc"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC2214B972
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 21:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727816984; cv=none; b=PntYOaarwgM+uk66n7fLyfBl/mBVvYfnV+Ygv0iMn3u1FYQgHmq+Z21FpNJrnYNUvauucU7sgDN+jHJsxnvA5H8Ewlb41cOdgQzxYirS16J2fk+MTPlI9VlSgMUFBNs4WlXiWmIoRIwTUOAP1JgPYvnf8YdiRWKrcw2UXd0LZqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727816984; c=relaxed/simple;
	bh=zvwN+I/JtI6Jo0tnbVvwqPrJKpeHNGpD8bZeS/U1GkA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qkx1bzw7peGcVzzUur6YbRzejh+c40rSJacd0s2N95SBWVBuq2sWtWUTINdOamd1/Se4+1Sa6eKFxCO+Cf4m08gYErkxItLqTbswcXyZgLTiTr1JG7dMzSSl9PUmTMh+0xs1kXyv3GGWG3k8HmeXClhx780RWAoEHRWVg0kGoHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P4nxLlxc; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7cd8803fe0aso4166704a12.0
        for <stable@vger.kernel.org>; Tue, 01 Oct 2024 14:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727816981; x=1728421781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=As30q96mpK8klknJmj3uWiqJyOPpZxrxIMShC0/154o=;
        b=P4nxLlxcFjEjvX4ALIGrEyBoNULGzBLIQ4YS1D+rNz2cTHqpOtrXPNRXtAydR4pzl8
         aR7xMjmC3wZLEdjWVt41yYPkkIigLR49+J35DbjvbQwmkBbEKT5f4h/WgZnOInVErnER
         m6xyMD7o6KrZDKDvHOwzX+XxoI2WtCPEqK0U0178L83nSGRqVMzRN1DjAEdkkjrokmAv
         1kwEn/NoxACM/QDR2Cyxwu+g3+wW7oj1iSBL3oYHiWpmhT6k6GBnOKdhoVt1Kcm2t+Ah
         p57I0wY6nDsGKzlLwmrCGoUFw8ZhLq78VBDa/hkxL3yFw9Saq+nUslvW7qOnqkjeLDt3
         G7Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727816981; x=1728421781;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=As30q96mpK8klknJmj3uWiqJyOPpZxrxIMShC0/154o=;
        b=XtrkRfQF5odZIJUqEWccf4H/XFU3CWILqw5pqEK/R2CpgVbivxtrylFiyQU3UE+wRs
         xWYrzBFauDxTCgJoDTWhIqS2DZVq/ctWqocCQ943Zc9N7KuHoVmCGLp9XJ2kaW2AucXR
         KDN3sNyBf3iM+gi1VHZJHGSkDaJrEBvSheq10O5SscxuzOthgL0Ml1BW7Tj3WY5VLenM
         8VTvx23zS+N8IvBhVLCJn3nN7Vjn0WRu358M5z2NbSaspmuem+yPTqIuuRtNZw60yQTf
         uuzhdpguZs2vOlXCnULn1YabtWJSQ6RhvXuSKIDul7RPlOhuaL7xlzOuv9IHHyb7l2Uq
         SJtw==
X-Gm-Message-State: AOJu0YwDQU1XwzSGbm/XeG1u2UdHdCVM1hrm/T79hZE+OprlupkJkKI4
	Yn4gFxlJ7YB6qrepE5q7uzo/it+u2wy05OWJ5VKbAHku/ow71gEVhVSXdrvyWqE=
X-Google-Smtp-Source: AGHT+IG2cwKW0RKfFfSYFLUuYECnvoGWHbd6Kvgcus04RxPkl9onLYZQbC2HLYMk45cUzPZsrWgVeQ==
X-Received: by 2002:a17:90b:1c87:b0:2d8:f515:3169 with SMTP id 98e67ed59e1d1-2e184527827mr1103184a91.6.1727816981403;
        Tue, 01 Oct 2024 14:09:41 -0700 (PDT)
Received: from KASONG-MC4.tencent.com ([106.37.120.18])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e18f798037sm34307a91.25.2024.10.01.14.09.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 01 Oct 2024 14:09:40 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
To: stable@vger.kernel.org,
	Greg KH <gregkh@linuxfoundation.org>
Cc: Matthew Wilcox <willy@infradead.org>,
	Jens Axboe <axboe@kernel.dk>,
	David Howells <dhowells@redhat.com>,
	Dave Chinner <david@fromorbit.com>,
	Christian Theune <ct@flyingcircus.io>,
	Christian Brauner <brauner@kernel.org>,
	Chris Mason <clm@meta.com>,
	Sam James <sam@gentoo.org>,
	Daniel Dao <dqminh@cloudflare.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Kairui Song <kasong@tencent.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.1.y 6.6.y 3/3] mm/filemap: optimize filemap folio adding
Date: Wed,  2 Oct 2024 05:06:25 +0800
Message-ID: <20241001210625.95825-4-ryncsn@gmail.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241001210625.95825-1-ryncsn@gmail.com>
References: <20241001210625.95825-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

commit 6758c1128ceb45d1a35298912b974eb4895b7dd9 upstream.

Instead of doing multiple tree walks, do one optimism range check with
lock hold, and exit if raced with another insertion.  If a shadow exists,
check it with a new xas_get_order helper before releasing the lock to
avoid redundant tree walks for getting its order.

Drop the lock and do the allocation only if a split is needed.

In the best case, it only need to walk the tree once.  If it needs to
alloc and split, 3 walks are issued (One for first ranged conflict check
and order retrieving, one for the second check after allocation, one for
the insert after split).

Testing with 4K pages, in an 8G cgroup, with 16G brd as block device:

  echo 3 > /proc/sys/vm/drop_caches

  fio -name=cached --numjobs=16 --filename=/mnt/test.img \
    --buffered=1 --ioengine=mmap --rw=randread --time_based \
    --ramp_time=30s --runtime=5m --group_reporting

Before:
bw (  MiB/s): min= 1027, max= 3520, per=100.00%, avg=2445.02, stdev=18.90, samples=8691
iops        : min=263001, max=901288, avg=625924.36, stdev=4837.28, samples=8691

After (+7.3%):
bw (  MiB/s): min=  493, max= 3947, per=100.00%, avg=2625.56, stdev=25.74, samples=8651
iops        : min=126454, max=1010681, avg=672142.61, stdev=6590.48, samples=8651

Test result with THP (do a THP randread then switch to 4K page in hope it
issues a lot of splitting):

  echo 3 > /proc/sys/vm/drop_caches

  fio -name=cached --numjobs=16 --filename=/mnt/test.img \
      --buffered=1 --ioengine=mmap -thp=1 --readonly \
      --rw=randread --time_based --ramp_time=30s --runtime=10m \
      --group_reporting

  fio -name=cached --numjobs=16 --filename=/mnt/test.img \
      --buffered=1 --ioengine=mmap \
      --rw=randread --time_based --runtime=5s --group_reporting

Before:
bw (  KiB/s): min= 4141, max=14202, per=100.00%, avg=7935.51, stdev=96.85, samples=18976
iops        : min= 1029, max= 3548, avg=1979.52, stdev=24.23, samples=18976·

READ: bw=4545B/s (4545B/s), 4545B/s-4545B/s (4545B/s-4545B/s), io=64.0KiB (65.5kB), run=14419-14419msec

After (+12.5%):
bw (  KiB/s): min= 4611, max=15370, per=100.00%, avg=8928.74, stdev=105.17, samples=19146
iops        : min= 1151, max= 3842, avg=2231.27, stdev=26.29, samples=19146

READ: bw=4635B/s (4635B/s), 4635B/s-4635B/s (4635B/s-4635B/s), io=64.0KiB (65.5kB), run=14137-14137msec

The performance is better for both 4K (+7.5%) and THP (+12.5%) cached read.

Link: https://lkml.kernel.org/r/20240415171857.19244-5-ryncsn@gmail.com
Signed-off-by: Kairui Song <kasong@tencent.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Closes: https://lore.kernel.org/linux-mm/A5A976CB-DB57-4513-A700-656580488AB6@flyingcircus.io/
[ kasong@tencent.com: minor adjustment of variable declarations ]
---
 lib/test_xarray.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++
 mm/filemap.c      | 53 +++++++++++++++++++++++++++++++-----------
 2 files changed, 98 insertions(+), 14 deletions(-)

diff --git a/lib/test_xarray.c b/lib/test_xarray.c
index 2e229012920b..542926da61a3 100644
--- a/lib/test_xarray.c
+++ b/lib/test_xarray.c
@@ -1789,6 +1789,64 @@ static noinline void check_xas_get_order(struct xarray *xa)
 	}
 }
 
+static noinline void check_xas_conflict_get_order(struct xarray *xa)
+{
+	XA_STATE(xas, xa, 0);
+
+	void *entry;
+	int only_once;
+	unsigned int max_order = IS_ENABLED(CONFIG_XARRAY_MULTI) ? 20 : 1;
+	unsigned int order;
+	unsigned long i, j, k;
+
+	for (order = 0; order < max_order; order++) {
+		for (i = 0; i < 10; i++) {
+			xas_set_order(&xas, i << order, order);
+			do {
+				xas_lock(&xas);
+				xas_store(&xas, xa_mk_value(i));
+				xas_unlock(&xas);
+			} while (xas_nomem(&xas, GFP_KERNEL));
+
+			/*
+			 * Ensure xas_get_order works with xas_for_each_conflict.
+			 */
+			j = i << order;
+			for (k = 0; k < order; k++) {
+				only_once = 0;
+				xas_set_order(&xas, j + (1 << k), k);
+				xas_lock(&xas);
+				xas_for_each_conflict(&xas, entry) {
+					XA_BUG_ON(xa, entry != xa_mk_value(i));
+					XA_BUG_ON(xa, xas_get_order(&xas) != order);
+					only_once++;
+				}
+				XA_BUG_ON(xa, only_once != 1);
+				xas_unlock(&xas);
+			}
+
+			if (order < max_order - 1) {
+				only_once = 0;
+				xas_set_order(&xas, (i & ~1UL) << order, order + 1);
+				xas_lock(&xas);
+				xas_for_each_conflict(&xas, entry) {
+					XA_BUG_ON(xa, entry != xa_mk_value(i));
+					XA_BUG_ON(xa, xas_get_order(&xas) != order);
+					only_once++;
+				}
+				XA_BUG_ON(xa, only_once != 1);
+				xas_unlock(&xas);
+			}
+
+			xas_set_order(&xas, i << order, order);
+			xas_lock(&xas);
+			xas_store(&xas, NULL);
+			xas_unlock(&xas);
+		}
+	}
+}
+
+
 static noinline void check_destroy(struct xarray *xa)
 {
 	unsigned long index;
@@ -1839,6 +1897,7 @@ static int xarray_checks(void)
 	check_multi_store(&array);
 	check_get_order(&array);
 	check_xas_get_order(&array);
+	check_xas_conflict_get_order(&array);
 	check_xa_alloc();
 	check_find(&array);
 	check_find_entry(&array);
diff --git a/mm/filemap.c b/mm/filemap.c
index f85c13a1b739..d3b925232a59 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -841,6 +841,8 @@ noinline int __filemap_add_folio(struct address_space *mapping,
 {
 	XA_STATE(xas, &mapping->i_pages, index);
 	int huge = folio_test_hugetlb(folio);
+	void *alloced_shadow = NULL;
+	int alloced_order = 0;
 	bool charged = false;
 	long nr = 1;
 
@@ -863,16 +865,10 @@ noinline int __filemap_add_folio(struct address_space *mapping,
 	folio->mapping = mapping;
 	folio->index = xas.xa_index;
 
-	do {
-		unsigned int order = xa_get_order(xas.xa, xas.xa_index);
+	for (;;) {
+		int order = -1, split_order = 0;
 		void *entry, *old = NULL;
 
-		if (order > folio_order(folio)) {
-			xas_split_alloc(&xas, xa_load(xas.xa, xas.xa_index),
-					order, gfp);
-			if (xas_error(&xas))
-				goto error;
-		}
 		xas_lock_irq(&xas);
 		xas_for_each_conflict(&xas, entry) {
 			old = entry;
@@ -880,19 +876,33 @@ noinline int __filemap_add_folio(struct address_space *mapping,
 				xas_set_err(&xas, -EEXIST);
 				goto unlock;
 			}
+			/*
+			 * If a larger entry exists,
+			 * it will be the first and only entry iterated.
+			 */
+			if (order == -1)
+				order = xas_get_order(&xas);
+		}
+
+		/* entry may have changed before we re-acquire the lock */
+		if (alloced_order && (old != alloced_shadow || order != alloced_order)) {
+			xas_destroy(&xas);
+			alloced_order = 0;
 		}
 
 		if (old) {
-			if (shadowp)
-				*shadowp = old;
-			/* entry may have been split before we acquired lock */
-			order = xa_get_order(xas.xa, xas.xa_index);
-			if (order > folio_order(folio)) {
+			if (order > 0 && order > folio_order(folio)) {
 				/* How to handle large swap entries? */
 				BUG_ON(shmem_mapping(mapping));
+				if (!alloced_order) {
+					split_order = order;
+					goto unlock;
+				}
 				xas_split(&xas, old, order);
 				xas_reset(&xas);
 			}
+			if (shadowp)
+				*shadowp = old;
 		}
 
 		xas_store(&xas, folio);
@@ -908,9 +918,24 @@ noinline int __filemap_add_folio(struct address_space *mapping,
 				__lruvec_stat_mod_folio(folio,
 						NR_FILE_THPS, nr);
 		}
+
 unlock:
 		xas_unlock_irq(&xas);
-	} while (xas_nomem(&xas, gfp));
+
+		/* split needed, alloc here and retry. */
+		if (split_order) {
+			xas_split_alloc(&xas, old, split_order, gfp);
+			if (xas_error(&xas))
+				goto error;
+			alloced_shadow = old;
+			alloced_order = split_order;
+			xas_reset(&xas);
+			continue;
+		}
+
+		if (!xas_nomem(&xas, gfp))
+			break;
+	}
 
 	if (xas_error(&xas))
 		goto error;
-- 
2.46.1


