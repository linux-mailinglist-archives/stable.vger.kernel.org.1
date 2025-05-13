Return-Path: <stable+bounces-144133-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F56AB4DE3
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 10:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE3C61B408E4
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 08:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80818200BBC;
	Tue, 13 May 2025 08:17:25 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B6D20101F
	for <stable@vger.kernel.org>; Tue, 13 May 2025 08:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747124245; cv=none; b=DD8TaRQrAXSLaYGvcbeI+QXOJjNPqrmSeTtIrSOrUqKJm9s+ytWGvlnXSjyrqER03WxOhm1wcGoSWYCm0ymLLvvTSnumMeeFXT0JAJn2wRNMssO1j4goK0NyK56eo6XEX3tkKKvx2/JFYMqObTL8FzvlHnH7dPIiBH3TlJvt8ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747124245; c=relaxed/simple;
	bh=7LiUzXnkzTfMVy0tjPHbAGiUjDNFmvL9u5V1MiRWYZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WpWtvX5zra4vO99HorGE+NABBzFvmZYmMtEQ17iBCg/Mq7xy39BXbNUai8wgg7jIwXq7+LR+hiKj+vkwGWFXnNPa7uIqLPleCImUnrUoLee1rOg4iccSPlyyxDfOXJvb/bROjayv5vkARgyt+6VRY5jCrAUaYKOGDE9bgxzEzG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.186])
	by gateway (Coremail) with SMTP id _____8BxIK8LACNo2qPjAA--.40874S3;
	Tue, 13 May 2025 16:17:15 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.68.186])
	by front1 (Coremail) with SMTP id qMiowMCxqhr4_yJoEn3NAA--.18021S2;
	Tue, 13 May 2025 16:16:59 +0800 (CST)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: Xuerui Wang <kernel@xen0n.name>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	loongarch@lists.linux.dev,
	Zi Yan <ziy@nvidia.com>,
	Huang Ying <ying.huang@intel.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V2 for 6.6] mm/migrate: correct nr_failed in migrate_pages_sync()
Date: Tue, 13 May 2025 16:16:47 +0800
Message-ID: <20250513081647.252911-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMCxqhr4_yJoEn3NAA--.18021S2
X-CM-SenderInfo: hfkh0x5xdftxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxWFW7uryrGr17tw47uF47WrX_yoWrCw47pF
	4Igw1qyrW8XrWvgF9xtryqkFnxCrZxZr43Ja4xGryFyFsxX3sFkFWfGayqyF4rKry2van3
	JF4qgF1Y9ay8XrcCm3ZEXasCq-sJn29KB7ZKAUJUUUUP529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2kKe7AKxVWUtVW8ZwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWrXVW3
	AwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
	8JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r1q6r43MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AK
	xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUnLID5UUUUU==

From: Zi Yan <ziy@nvidia.com>

commit a259945efe6ada94087ef666e9b38f8e34ea34ba upstream.

nr_failed was missing the large folio splits from migrate_pages_batch()
and can cause a mismatch between migrate_pages() return value and the
number of not migrated pages, i.e., when the return value of
migrate_pages() is 0, there are still pages left in the from page list.
It will happen when a non-PMD THP large folio fails to migrate due to
-ENOMEM and is split successfully but not all the split pages are not
migrated, migrate_pages_batch() would return non-zero, but
astats.nr_thp_split = 0.  nr_failed would be 0 and returned to the caller
of migrate_pages(), but the not migrated pages are left in the from page
list without being added back to LRU lists.

Fix it by adding a new nr_split counter for large folio splits and adding
it to nr_failed in migrate_page_sync() after migrate_pages_batch() is
done.

Link: https://lkml.kernel.org/r/20231017163129.2025214-1-zi.yan@sent.com
Fixes: 2ef7dbb26990 ("migrate_pages: try migrate in batch asynchronously firstly")
Signed-off-by: Zi Yan <ziy@nvidia.com>
Acked-by: Huang Ying <ying.huang@intel.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
V2: Add upstream commit id.

 mm/migrate.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 1004b1def1c2..4ed470885217 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1504,6 +1504,7 @@ struct migrate_pages_stats {
 	int nr_thp_succeeded;	/* THP migrated successfully */
 	int nr_thp_failed;	/* THP failed to be migrated */
 	int nr_thp_split;	/* THP split before migrating */
+	int nr_split;	/* Large folio (include THP) split before migrating */
 };
 
 /*
@@ -1623,6 +1624,7 @@ static int migrate_pages_batch(struct list_head *from,
 	int nr_retry_pages = 0;
 	int pass = 0;
 	bool is_thp = false;
+	bool is_large = false;
 	struct folio *folio, *folio2, *dst = NULL, *dst2;
 	int rc, rc_saved = 0, nr_pages;
 	LIST_HEAD(unmap_folios);
@@ -1638,7 +1640,8 @@ static int migrate_pages_batch(struct list_head *from,
 		nr_retry_pages = 0;
 
 		list_for_each_entry_safe(folio, folio2, from, lru) {
-			is_thp = folio_test_large(folio) && folio_test_pmd_mappable(folio);
+			is_large = folio_test_large(folio);
+			is_thp = is_large && folio_test_pmd_mappable(folio);
 			nr_pages = folio_nr_pages(folio);
 
 			cond_resched();
@@ -1658,6 +1661,7 @@ static int migrate_pages_batch(struct list_head *from,
 				stats->nr_thp_failed++;
 				if (!try_split_folio(folio, split_folios)) {
 					stats->nr_thp_split++;
+					stats->nr_split++;
 					continue;
 				}
 				stats->nr_failed_pages += nr_pages;
@@ -1686,11 +1690,12 @@ static int migrate_pages_batch(struct list_head *from,
 				nr_failed++;
 				stats->nr_thp_failed += is_thp;
 				/* Large folio NUMA faulting doesn't split to retry. */
-				if (folio_test_large(folio) && !nosplit) {
+				if (is_large && !nosplit) {
 					int ret = try_split_folio(folio, split_folios);
 
 					if (!ret) {
 						stats->nr_thp_split += is_thp;
+						stats->nr_split += is_large;
 						break;
 					} else if (reason == MR_LONGTERM_PIN &&
 						   ret == -EAGAIN) {
@@ -1836,6 +1841,7 @@ static int migrate_pages_sync(struct list_head *from, new_folio_t get_new_folio,
 	stats->nr_succeeded += astats.nr_succeeded;
 	stats->nr_thp_succeeded += astats.nr_thp_succeeded;
 	stats->nr_thp_split += astats.nr_thp_split;
+	stats->nr_split += astats.nr_split;
 	if (rc < 0) {
 		stats->nr_failed_pages += astats.nr_failed_pages;
 		stats->nr_thp_failed += astats.nr_thp_failed;
@@ -1843,7 +1849,11 @@ static int migrate_pages_sync(struct list_head *from, new_folio_t get_new_folio,
 		return rc;
 	}
 	stats->nr_thp_failed += astats.nr_thp_split;
-	nr_failed += astats.nr_thp_split;
+	/*
+	 * Do not count rc, as pages will be retried below.
+	 * Count nr_split only, since it includes nr_thp_split.
+	 */
+	nr_failed += astats.nr_split;
 	/*
 	 * Fall back to migrate all failed folios one by one synchronously. All
 	 * failed folios except split THPs will be retried, so their failure
-- 
2.47.1


