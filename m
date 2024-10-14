Return-Path: <stable+bounces-84618-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9601A99D114
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 17:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50F2B284A9A
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 15:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008921AB508;
	Mon, 14 Oct 2024 15:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hAYaFtRd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17E81A76A5;
	Mon, 14 Oct 2024 15:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728918632; cv=none; b=fA91cL0KXpO3Xye7HapkHOhYot5KOycqP/S6gFq2oZjjnTmsaNe0YN/6gqdtYt2fcd+ewV8KEIppTp4fmQqp1kTNtREmbwGGQqxs2kI3j/KokEdXKoEHqnsIka20uLRzSNMKhGCgE4LZfuByxrznEsZjjPrR3YNkWdSZQS/JpdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728918632; c=relaxed/simple;
	bh=KQKyO1g5qsnLJWsIZCssEEvHBU8rWmWq78tmSpIWVUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WpyaKlP6zLqqLNOOLfy2AGTt4wtgQVZaMApDSz4kbjrr4fdx2X29M7OXHVC0bCtLmux2D8JUwMZWeX6cHO/FTMvb3oo45t6H0vQGwpH/WrmzXJgPl1S3K2OJLZqccSNG76NVj8h1A6JVlBLCSroqZQCokJx8Vbpxv9/+Au2zemo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hAYaFtRd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2259FC4CEC3;
	Mon, 14 Oct 2024 15:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728918632;
	bh=KQKyO1g5qsnLJWsIZCssEEvHBU8rWmWq78tmSpIWVUg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hAYaFtRdw0DWBvgfU6OtMXsOboFDbweTmkQPiHPUzwKFY/hVOFKSUDjn8mwGzoLjg
	 Lo0foN35lcIcFkbyA897oL0N15VnpXjToFNJfAJ4xG2XqAH/xUUeoImA5d7Cg0XNbu
	 eSCnMSPOF2qIaKsS2m+t8P6rNhlLtA60j2+2Mc+k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kairui Song <kasong@tencent.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.1 360/798] mm/filemap: optimize filemap folio adding
Date: Mon, 14 Oct 2024 16:15:14 +0200
Message-ID: <20241014141232.087981997@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241014141217.941104064@linuxfoundation.org>
References: <20241014141217.941104064@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 lib/test_xarray.c |   59 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 mm/filemap.c      |   53 +++++++++++++++++++++++++++++++++++-------------
 2 files changed, 98 insertions(+), 14 deletions(-)

--- a/lib/test_xarray.c
+++ b/lib/test_xarray.c
@@ -1789,6 +1789,64 @@ static noinline void check_xas_get_order
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
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -841,6 +841,8 @@ noinline int __filemap_add_folio(struct
 {
 	XA_STATE(xas, &mapping->i_pages, index);
 	int huge = folio_test_hugetlb(folio);
+	void *alloced_shadow = NULL;
+	int alloced_order = 0;
 	bool charged = false;
 	long nr = 1;
 
@@ -863,16 +865,10 @@ noinline int __filemap_add_folio(struct
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
@@ -880,19 +876,33 @@ noinline int __filemap_add_folio(struct
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
@@ -908,9 +918,24 @@ noinline int __filemap_add_folio(struct
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



