Return-Path: <stable+bounces-65523-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA5494A13A
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 08:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36DDEB27818
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 06:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26BD1917FC;
	Wed,  7 Aug 2024 06:59:23 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C7A18EFFF
	for <stable@vger.kernel.org>; Wed,  7 Aug 2024 06:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723013963; cv=none; b=QCujtUI/FK3lk4BuMcN45mhbUeFNq+WHNaMiPQq0SugZMk77YIqb19dmPztKUeZWHkQSIrE5UC5KCbgYlow82Yhr7m10I+B1qwFe5+SsapWuTKW8XSxgPE6gw8+pLW2SR2r439q0hmnhaRK11iNiuz2rRlWTMyQWxL2KvvP+R68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723013963; c=relaxed/simple;
	bh=hDDv9KcRNfeAVyWeE7G18bht5kgnuI7YLC4ygR33c64=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cvqnxLwomP3f6O8QADJPDq3L6F3BHItr9eOJs52ON/h+2F/16B+EfhAZ/0qXrPj/HLKs5K4rcuqgDsYuexnkGmaPr3IVxL3FDDrlVarNl+ML5k+I6a77RCzQfEfdtTSBS87+Lqd0693purEDfTJ2uhStzsZSGbRAKQ0lxkv9b80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Wf1Hf3c7czcdSr;
	Wed,  7 Aug 2024 14:59:10 +0800 (CST)
Received: from kwepemd200019.china.huawei.com (unknown [7.221.188.193])
	by mail.maildlp.com (Postfix) with ESMTPS id 8FE5D180AD8;
	Wed,  7 Aug 2024 14:59:17 +0800 (CST)
Received: from huawei.com (10.173.127.72) by kwepemd200019.china.huawei.com
 (7.221.188.193) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 7 Aug
 2024 14:59:16 +0800
From: Miaohe Lin <linmiaohe@huawei.com>
To: <stable@vger.kernel.org>
CC: Miaohe Lin <linmiaohe@huawei.com>, Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>, Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.1.y] mm/hugetlb: fix potential race in __update_and_free_hugetlb_folio()
Date: Wed, 7 Aug 2024 14:54:12 +0800
Message-ID: <20240807065412.2615575-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <2024071559-reptilian-chaffing-a991@gregkh>
References: <2024071559-reptilian-chaffing-a991@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemd200019.china.huawei.com (7.221.188.193)

There is a potential race between __update_and_free_hugetlb_folio() and
try_memory_failure_hugetlb():

 CPU1					CPU2
 __update_and_free_hugetlb_folio	try_memory_failure_hugetlb
					 folio_test_hugetlb
					  -- It's still hugetlb folio.
  folio_clear_hugetlb_hwpoison
  					  spin_lock_irq(&hugetlb_lock);
					   __get_huge_page_for_hwpoison
					    folio_set_hugetlb_hwpoison
					  spin_unlock_irq(&hugetlb_lock);
  spin_lock_irq(&hugetlb_lock);
  __folio_clear_hugetlb(folio);
   -- Hugetlb flag is cleared but too late.
  spin_unlock_irq(&hugetlb_lock);

When the above race occurs, raw error page info will be leaked.  Even
worse, raw error pages won't have hwpoisoned flag set and hit
pcplists/buddy.  Fix this issue by deferring
folio_clear_hugetlb_hwpoison() until __folio_clear_hugetlb() is done.  So
all raw error pages will have hwpoisoned flag set.

Link: https://lkml.kernel.org/r/20240708025127.107713-1-linmiaohe@huawei.com
Fixes: 32c877191e02 ("hugetlb: do not clear hugetlb dtor until allocating vmemmap")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Acked-by: Muchun Song <muchun.song@linux.dev>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 5596d9e8b553dacb0ac34bcf873cbbfb16c3ba3e)
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/hugetlb.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 05b8797163b2..14b9494c58ed 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1785,13 +1785,6 @@ static void __update_and_free_page(struct hstate *h, struct page *page)
 		return;
 	}
 
-	/*
-	 * Move PageHWPoison flag from head page to the raw error pages,
-	 * which makes any healthy subpages reusable.
-	 */
-	if (unlikely(PageHWPoison(page)))
-		hugetlb_clear_page_hwpoison(page);
-
 	/*
 	 * If vmemmap pages were allocated above, then we need to clear the
 	 * hugetlb destructor under the hugetlb lock.
@@ -1802,6 +1795,13 @@ static void __update_and_free_page(struct hstate *h, struct page *page)
 		spin_unlock_irq(&hugetlb_lock);
 	}
 
+	/*
+	 * Move PageHWPoison flag from head page to the raw error pages,
+	 * which makes any healthy subpages reusable.
+	 */
+	if (unlikely(PageHWPoison(page)))
+		hugetlb_clear_page_hwpoison(page);
+
 	for (i = 0; i < pages_per_huge_page(h); i++) {
 		subpage = nth_page(page, i);
 		subpage->flags &= ~(1 << PG_locked | 1 << PG_error |
-- 
2.33.0


