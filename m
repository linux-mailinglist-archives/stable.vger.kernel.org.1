Return-Path: <stable+bounces-110379-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D048A1B4A2
	for <lists+stable@lfdr.de>; Fri, 24 Jan 2025 12:23:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3A643ADAB6
	for <lists+stable@lfdr.de>; Fri, 24 Jan 2025 11:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE761CDFC1;
	Fri, 24 Jan 2025 11:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="F6zBhtxw"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05101BEF7C;
	Fri, 24 Jan 2025 11:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737717778; cv=none; b=DSjscS2CXfhpfm9WtE3cEHUIoVd6pr8bn0ix2Wpy64nXJSBpggdN/FXulbcsznbdxO55q2VajgH96rXxEp3YDzGu2u9IdRxaNnq4hq/+wOsDKBi/bioWx/CURpRE0unNQUfvtxTSj7z0ARksSch2byHEfJsmcW+r3PKmZa/jOUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737717778; c=relaxed/simple;
	bh=qM3CLA8t6v+UkIrJhqdjv+iYlLksPEg3+3xp1n13rN8=;
	h=From:To:Cc:Subject:Date:Message-Id; b=OWTIWOSQoWp4rs91o5v2yMNKDwSSU5RYQ9IY4KG1D8srsq+92MB4nrwalwfF83pNeiXNcVO8Mmj3AL3H8ukPsgDO7N1ZpfVMco1xi48jWr/mZtm1ETCbAMJDAqeGiUyBNZexM9ck2N2kWB7BH9bRCfQbS3T2l5Mtr6Rzg1Ae0sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=F6zBhtxw; arc=none smtp.client-ip=117.135.210.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=xb0y0bXCsoLutq0MQV
	Ry9Edyx98Tyx9r7Nct237BMjM=; b=F6zBhtxw8bO95VeEPzsodhhqOcd/3FZUFn
	zhyZp7O7WM18UjETKwt1LyBQESKRugT7QcsVsHXRqk216eFBpCpXZDoSudc4jkXH
	hbBzTecPCYg5MAlI78AzeXiVHNCXKCjrpQucKfLA7fqHH88OxaacC6drnOZP/VmV
	6cP8pGDZc=
Received: from hg-OptiPlex-7040.hygon.cn (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSkvCgD3b665d5NnpN2BAA--.10824S2;
	Fri, 24 Jan 2025 19:21:30 +0800 (CST)
From: yangge1116@126.com
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	21cnbao@gmail.com,
	david@redhat.com,
	baolin.wang@linux.alibaba.com,
	aisheng.dong@nxp.com,
	liuzixing@hygon.cn,
	yangge <yangge1116@126.com>
Subject: [PATCH] mm/cma: add an API to enable/disable concurrent memory allocation for the CMA
Date: Fri, 24 Jan 2025 19:21:27 +0800
Message-Id: <1737717687-16744-1-git-send-email-yangge1116@126.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID:PSkvCgD3b665d5NnpN2BAA--.10824S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAr17XF17Wryrur1UJFy5urg_yoW5WF48pF
	4kWw1Yk34rWrn7Zrs7Aw409an8W3s7GF4UGFyS93s3ZFW3Jr12gwn8Kw15uFy5CrWkGF9a
	vF4Fq34Y9F1UZ3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRoKZXUUUUU=
X-CM-SenderInfo: 51dqwwjhrrila6rslhhfrp/1tbiOgXeG2eTWw-7zwAAsu
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

From: yangge <yangge1116@126.com>

Commit 60a60e32cf91 ("Revert "mm/cma.c: remove redundant cma_mutex lock"")
simply reverts to the original method of using the cma_mutex to ensure
that alloc_contig_range() runs sequentially. This change was made to avoid
concurrency allocation failures. However, it can negatively impact
performance when concurrent allocation of CMA memory is required.

To address this issue, we could introduce an API for concurrency settings,
allowing users to decide whether their CMA can perform concurrent memory
allocations or not.

Fixes: 60a60e32cf91 ("Revert "mm/cma.c: remove redundant cma_mutex lock"")
Signed-off-by: yangge <yangge1116@126.com>
Cc: <stable@vger.kernel.org>
---
 include/linux/cma.h |  2 ++
 mm/cma.c            | 22 ++++++++++++++++++++--
 mm/cma.h            |  1 +
 3 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/include/linux/cma.h b/include/linux/cma.h
index d15b64f..2384624 100644
--- a/include/linux/cma.h
+++ b/include/linux/cma.h
@@ -53,6 +53,8 @@ extern int cma_for_each_area(int (*it)(struct cma *cma, void *data), void *data)
 
 extern void cma_reserve_pages_on_error(struct cma *cma);
 
+extern bool cma_set_concurrency(struct cma *cma, bool concurrency);
+
 #ifdef CONFIG_CMA
 struct folio *cma_alloc_folio(struct cma *cma, int order, gfp_t gfp);
 bool cma_free_folio(struct cma *cma, const struct folio *folio);
diff --git a/mm/cma.c b/mm/cma.c
index de5bc0c..49a7186 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -460,9 +460,17 @@ static struct page *__cma_alloc(struct cma *cma, unsigned long count,
 		spin_unlock_irq(&cma->lock);
 
 		pfn = cma->base_pfn + (bitmap_no << cma->order_per_bit);
-		mutex_lock(&cma_mutex);
+
+		/*
+		 * If the user sets the concurr_alloc of CMA to true, concurrent
+		 * memory allocation is allowed. If the user sets it to false or
+		 * does not set it, concurrent memory allocation is not allowed.
+		 */
+		if (!cma->concurr_alloc)
+			mutex_lock(&cma_mutex);
 		ret = alloc_contig_range(pfn, pfn + count, MIGRATE_CMA, gfp);
-		mutex_unlock(&cma_mutex);
+		if (!cma->concurr_alloc)
+			mutex_unlock(&cma_mutex);
 		if (ret == 0) {
 			page = pfn_to_page(pfn);
 			break;
@@ -610,3 +618,13 @@ int cma_for_each_area(int (*it)(struct cma *cma, void *data), void *data)
 
 	return 0;
 }
+
+bool cma_set_concurrency(struct cma *cma, bool concurrency)
+{
+	if (!cma)
+		return false;
+
+	cma->concurr_alloc = concurrency;
+
+	return true;
+}
diff --git a/mm/cma.h b/mm/cma.h
index 8485ef8..30f489d 100644
--- a/mm/cma.h
+++ b/mm/cma.h
@@ -16,6 +16,7 @@ struct cma {
 	unsigned long   *bitmap;
 	unsigned int order_per_bit; /* Order of pages represented by one bit */
 	spinlock_t	lock;
+	bool concurr_alloc;
 #ifdef CONFIG_CMA_DEBUGFS
 	struct hlist_head mem_head;
 	spinlock_t mem_head_lock;
-- 
2.7.4


