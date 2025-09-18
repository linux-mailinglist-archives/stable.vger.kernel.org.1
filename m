Return-Path: <stable+bounces-172727-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D15B33000
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 15:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5773447405
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 13:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A6C2620D2;
	Sun, 24 Aug 2025 13:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QLdNoflp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750511BC9E2
	for <stable@vger.kernel.org>; Sun, 24 Aug 2025 13:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756040626; cv=none; b=imz5C3pToGSYGgPKDR2aLE5o0b691ZAsSbhAe1W3K69Ix2Oi1PadnRDo+4Itq4V9akdBpFN0MWtqewaR09I82LETgCo9UOb2BnbyAbwAygphA+xgwqlmVOJ2V2EesAqO2m659xFCx7dK5eEjZLqei3aaU7EfGW9/YUyXOyp9i5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756040626; c=relaxed/simple;
	bh=9jlNTTW4rdjzu9Zxub2V1ld71lyAuCSWeJazwjxueIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KV88MNLVRJqMZUa+DfwPcHTP0QoVYyYKymzT5e/J4i/0U0kEOwqP8q6UbB9vr7fq5N8QpzD4KGmeFOrOpDHrOscNdOMMr5Ai18MHSwD1gxsL7AyTTq4E6UChkxECOJNHd+BpHUG/F8ngzaKLPU1TNqqKrTcq9+dzBcQJB76Womc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QLdNoflp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFA3FC4CEEB;
	Sun, 24 Aug 2025 13:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756040625;
	bh=9jlNTTW4rdjzu9Zxub2V1ld71lyAuCSWeJazwjxueIs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QLdNoflpOxI2AOJa4+/pnUzfFD5fyTfaeCML2/TQM9Kws2jQDV4plIfULofgRkHMf
	 BjgRYqx1sAaNIsb8Du3hOHs8MXpaJl9sJs0xaGYofie7EDFdAIA/UkskpEZpb6k2VA
	 jcUEbge7FUu6lPRSZprYzV06Q9XkvA39vNKf5dNdruBEDVg5q/qwfG8Gx/sLsST6fN
	 yv3bbUowl3jtn3jFDv4QShbtUYkMbvC3Qm/UEEwHkmg9sRZabrYRN0X0lS1xBzRBYq
	 NrddgDz57uDKuPWt0nele+bySF7PL4LqYqjlek1ppgEWCciM7aOqWK6UCv4wWAv+ZK
	 S0Yaf7I2uQfUA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jinjiang Tu <tujinjiang@huawei.com>,
	David Hildenbrand <david@redhat.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Jane Chu <jane.chu@oracle.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Oscar Salvador <osalvador@suse.de>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Zi Yan <ziy@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] mm/memory-failure: fix infinite UCE for VM_PFNMAP pfn
Date: Sun, 24 Aug 2025 09:03:41 -0400
Message-ID: <20250824130341.2750580-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082205-cinch-riverboat-7a85@gregkh>
References: <2025082205-cinch-riverboat-7a85@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jinjiang Tu <tujinjiang@huawei.com>

[ Upstream commit 2e6053fea379806269c4f7f5e36b523c9c0fb35c ]

When memory_failure() is called for a already hwpoisoned pfn,
kill_accessing_process() will be called to kill current task.  However, if
the vma of the accessing vaddr is VM_PFNMAP, walk_page_range() will skip
the vma in walk_page_test() and return 0.

Before commit aaf99ac2ceb7 ("mm/hwpoison: do not send SIGBUS to processes
with recovered clean pages"), kill_accessing_process() will return EFAULT.
For x86, the current task will be killed in kill_me_maybe().

However, after this commit, kill_accessing_process() simplies return 0,
that means UCE is handled properly, but it doesn't actually.  In such
case, the user task will trigger UCE infinitely.

To fix it, add .test_walk callback for hwpoison_walk_ops to scan all vmas.

Link: https://lkml.kernel.org/r/20250815073209.1984582-1-tujinjiang@huawei.com
Fixes: aaf99ac2ceb7 ("mm/hwpoison: do not send SIGBUS to processes with recovered clean pages")
Signed-off-by: Jinjiang Tu <tujinjiang@huawei.com>
Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Miaohe Lin <linmiaohe@huawei.com>
Reviewed-by: Jane Chu <jane.chu@oracle.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Naoya Horiguchi <nao.horiguchi@gmail.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
[ Adjust context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/memory-failure.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 7e39a4c9e0df..e2b1591a8596 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -674,9 +674,17 @@ static int hwpoison_hugetlb_range(pte_t *ptep, unsigned long hmask,
 #define hwpoison_hugetlb_range	NULL
 #endif
 
+static int hwpoison_test_walk(unsigned long start, unsigned long end,
+			     struct mm_walk *walk)
+{
+	/* We also want to consider pages mapped into VM_PFNMAP. */
+	return 0;
+}
+
 static struct mm_walk_ops hwp_walk_ops = {
 	.pmd_entry = hwpoison_pte_range,
 	.hugetlb_entry = hwpoison_hugetlb_range,
+	.test_walk = hwpoison_test_walk,
 };
 
 /*
-- 
2.50.1


