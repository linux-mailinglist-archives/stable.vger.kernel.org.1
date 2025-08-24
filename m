Return-Path: <stable+bounces-172672-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE13B32CBA
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 02:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F4B620827C
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 00:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBCA23595B;
	Sun, 24 Aug 2025 00:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ItbWRoLB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C94A224F3
	for <stable@vger.kernel.org>; Sun, 24 Aug 2025 00:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755995790; cv=none; b=n8FAPxyfT1oQ1gfh/rN5UUiGfqgHNMuC6ylPRhARq8sMKqTy/jqEpbvAZRzrqT/Tu/kCfbmv34Iq4oDS0G8iNYo0UKzoHWM0ZenmHcLqZ0Ss2/Ld2pJsJcG2oHyjaffDV3EZyNwo3cpMmQswsosLpSPafGovKcon7HAboOXHojY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755995790; c=relaxed/simple;
	bh=n6+bYYO5bFvQNgBD98yN1TBINAHKY0hK80VlUnB2cLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eSsHhq/JYyJL0Di/9eM4B0TA/3gzAYqADOk4LH0rkNjbbJGpRsEBpMc3OeQzZGcGdKTDQ+/IEKswo30F56/dJJsiuXkrb/dBbaK34FVg3pJ3JMdlLACsH3x2n4K3YZXhNJYXctVCk2x71UguQnadmJCuaWp9skQ6vGx3JgdgQGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ItbWRoLB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A2BCC4CEE7;
	Sun, 24 Aug 2025 00:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755995789;
	bh=n6+bYYO5bFvQNgBD98yN1TBINAHKY0hK80VlUnB2cLo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ItbWRoLBCULj1Dhfc1BrDMwZdodRBm32a/R4SCJ6Kf0k+Zcoky87Sn+8uefQVhHY2
	 QpoHlj/0Z7PlcoKLhqSZu8dC+27eaEDpasUL4ha9hBloF/SFUSIWyCPY4GAD/TsW+/
	 AjJ6x1/5dByeRpNew5bvgyCxt6frK+JXmbJftoVdjSwYQZKZbZ7C6zBeaIO2qSXqyZ
	 D7urCz8sZJ6Za3D6qOOxx2XOcz1sh/xV04k4o17OS3vTL3POMkB2x/PpyGiYzzgmRz
	 4u871UFV0xQJ0guw3hHhNysluzHO1zwm15E+ZJtQEruA1u3gWP595CQuBOm5FHIP1E
	 JvSgak/Pzj0UA==
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
Subject: [PATCH 6.1.y] mm/memory-failure: fix infinite UCE for VM_PFNMAP pfn
Date: Sat, 23 Aug 2025 20:36:26 -0400
Message-ID: <20250824003626.2559323-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082204-copied-affecting-d945@gregkh>
References: <2025082204-copied-affecting-d945@gregkh>
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
index 9ca2b58aceec..0f706ee04baf 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -731,9 +731,17 @@ static int hwpoison_hugetlb_range(pte_t *ptep, unsigned long hmask,
 #define hwpoison_hugetlb_range	NULL
 #endif
 
+static int hwpoison_test_walk(unsigned long start, unsigned long end,
+			     struct mm_walk *walk)
+{
+	/* We also want to consider pages mapped into VM_PFNMAP. */
+	return 0;
+}
+
 static const struct mm_walk_ops hwp_walk_ops = {
 	.pmd_entry = hwpoison_pte_range,
 	.hugetlb_entry = hwpoison_hugetlb_range,
+	.test_walk = hwpoison_test_walk,
 };
 
 /*
-- 
2.50.1


