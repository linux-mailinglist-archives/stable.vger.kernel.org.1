Return-Path: <stable+bounces-204563-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 98CDCCF1021
	for <lists+stable@lfdr.de>; Sun, 04 Jan 2026 14:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E929301276C
	for <lists+stable@lfdr.de>; Sun,  4 Jan 2026 13:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1FF727FD51;
	Sun,  4 Jan 2026 13:44:17 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D1C2356D9;
	Sun,  4 Jan 2026 13:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767534257; cv=none; b=A5pm2dZ3lu0HrsQLTf97OyLX7D3OjquoWBAIl4fZbU6m+9nlsLUEC7AQA2D+Flg0UDTTRl0ETpw6qxhq7cp4WX2PqN2FXQEz0VqPQFDVHvz48sZD8iZftx1I4bfurzgHcUTjg5rtsN1iA9jpJGZ6cOONyHCoRMyv7H6cediV1JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767534257; c=relaxed/simple;
	bh=ZmFfRTl0IKOdmEidVox6a+BuA2sUr9cqydff5eIBThQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XYp6FTSgIWDvtarO5YmCHkidB790WGEeCJyqSlQrBdjgRQsnr8qzpwpwHNXExOpFtPdsdzv8oJu+1p8BymagdKU16Ko8yrKBEWeKQA9GEngpIjJebpaGMil45lMC1AwjxBEc+NPgL7yjJUnSVBhY88a39CV7tMn5IljAp/dpzk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 20FCF339;
	Sun,  4 Jan 2026 05:44:01 -0800 (PST)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D41783F5A1;
	Sun,  4 Jan 2026 05:44:06 -0800 (PST)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	kasan-dev@googlegroups.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v1] mm: kmsan: Fix poisoning of high-order non-compound pages
Date: Sun,  4 Jan 2026 13:43:47 +0000
Message-ID: <20260104134348.3544298-1-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kmsan_free_page() is called by the page allocator's free_pages_prepare()
during page freeing. It's job is to poison all the memory covered by the
page. It can be called with an order-0 page, a compound high-order page
or a non-compound high-order page. But page_size() only works for
order-0 and compound pages. For a non-compound high-order page it will
incorrectly return PAGE_SIZE.

The implication is that the tail pages of a high-order non-compound page
do not get poisoned at free, so any invalid access while they are free
could go unnoticed. It looks like the pages will be poisoned again at
allocaiton time, so that would bookend the window.

Fix this by using the order parameter to calculate the size.

Fixes: b073d7f8aee4 ("mm: kmsan: maintain KMSAN metadata for page operations")
Cc: stable@vger.kernel.org
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---

Hi,

I noticed this during code review, so perhaps I've just misunderstood the intent
of the code.

I don't have the means to compile and run on x86 with KMSAN enabled though, so
punting this out hoping someone might be able to validate/test. I guess there is
a small chance this could lead to KMSAN finding some new issues?

Applies against today's mm-unstable (344d3580dacd).

Thanks,
Ryan


 mm/kmsan/shadow.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/kmsan/shadow.c b/mm/kmsan/shadow.c
index e7f554a31bb4..9e1c5f2b7a41 100644
--- a/mm/kmsan/shadow.c
+++ b/mm/kmsan/shadow.c
@@ -207,7 +207,7 @@ void kmsan_free_page(struct page *page, unsigned int order)
 	if (!kmsan_enabled || kmsan_in_runtime())
 		return;
 	kmsan_enter_runtime();
-	kmsan_internal_poison_memory(page_address(page), page_size(page),
+	kmsan_internal_poison_memory(page_address(page), PAGE_SIZE << order,
 				     GFP_KERNEL & ~(__GFP_RECLAIM),
 				     KMSAN_POISON_CHECK | KMSAN_POISON_FREE);
 	kmsan_leave_runtime();
--
2.43.0


