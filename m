Return-Path: <stable+bounces-65519-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40FDE949EAE
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 05:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC265B220F3
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 03:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC18433BB;
	Wed,  7 Aug 2024 03:55:09 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DE6224DC
	for <stable@vger.kernel.org>; Wed,  7 Aug 2024 03:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723002909; cv=none; b=rWc6t1SlczFg8s42UbKQQvZygQsizXflHAn5WsR7qxBJ+C8cewIcGwGl0ivHF5544plWefqWTybxfI18zRbStuEaen+ixSRX/4zDzaj91mTh3W7awsw7M3JHaBqq0HbmXEN/uMqn0nBxNFsiM/05M7l6es7RULwlKn8vnutXmfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723002909; c=relaxed/simple;
	bh=PXo/1KYlDOEd1H/mpvd1ujdzbExp2ca6PVkOcxESBqY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BLGLwHtBJWsL10h3rMjEiaLwyEXLgmykWtWWaxVvGKqhsWNGe4uQIe1HOg1THvmsNaIcoJP1nRWERT9CPxi7ke4atNoGwVbr56RVnW+RXAQXkJHRvf68v1a4ySKjupYMhsdRf7YCZanNEM+SW/Nq/zX5PkHFcWBTTftr56BtThc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Wdx5f4ZNvz2Clkj;
	Wed,  7 Aug 2024 11:50:14 +0800 (CST)
Received: from kwepemd200019.china.huawei.com (unknown [7.221.188.193])
	by mail.maildlp.com (Postfix) with ESMTPS id 3E98F180044;
	Wed,  7 Aug 2024 11:54:57 +0800 (CST)
Received: from huawei.com (10.173.127.72) by kwepemd200019.china.huawei.com
 (7.221.188.193) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 7 Aug
 2024 11:54:56 +0800
From: Miaohe Lin <linmiaohe@huawei.com>
To: <stable@vger.kernel.org>
CC: Miaohe Lin <linmiaohe@huawei.com>, Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>, Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.9.y] mm/hugetlb: fix potential race in __update_and_free_hugetlb_folio()
Date: Wed, 7 Aug 2024 11:49:49 +0800
Message-ID: <20240807034949.1407040-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <2024071558-unbundle-resize-a6d4@gregkh>
References: <2024071558-unbundle-resize-a6d4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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
index c445e6fd8579..0cefa9f82c47 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1770,13 +1770,6 @@ static void __update_and_free_hugetlb_folio(struct hstate *h,
 		return;
 	}
 
-	/*
-	 * Move PageHWPoison flag from head page to the raw error pages,
-	 * which makes any healthy subpages reusable.
-	 */
-	if (unlikely(folio_test_hwpoison(folio)))
-		folio_clear_hugetlb_hwpoison(folio);
-
 	/*
 	 * If vmemmap pages were allocated above, then we need to clear the
 	 * hugetlb destructor under the hugetlb lock.
@@ -1787,6 +1780,13 @@ static void __update_and_free_hugetlb_folio(struct hstate *h,
 		spin_unlock_irq(&hugetlb_lock);
 	}
 
+	/*
+	 * Move PageHWPoison flag from head page to the raw error pages,
+	 * which makes any healthy subpages reusable.
+	 */
+	if (unlikely(folio_test_hwpoison(folio)))
+		folio_clear_hugetlb_hwpoison(folio);
+
 	/*
 	 * Non-gigantic pages demoted from CMA allocated gigantic pages
 	 * need to be given back to CMA in free_gigantic_folio.
-- 
2.33.0


