Return-Path: <stable+bounces-133723-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01773A9270E
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 20:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 965F21906BC1
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 18:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E19E1256C65;
	Thu, 17 Apr 2025 18:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="opQ4vh7z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D994256C61;
	Thu, 17 Apr 2025 18:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744913946; cv=none; b=No3M9epSZZtHLNnHMVqVxkLXDfLctBg3dvKZcw9SQtTvfKzv6VB0Ry/X7A/5sfx7qMxMa6QbjlDdltrWYM1t61gYJ8u8CVfQtwqxdUy9hcWFOqY8nZZLCAPlJKXHZ6OVHbEqVHqDJ76GnY7H93cdd0JVOzgMqEBbb6g5zbVdS9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744913946; c=relaxed/simple;
	bh=IC3L7wDKBP/BLuzdF8wtKHFj5lDBQnG4vs3ZhWAZ0BQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tDNrDBa5nzvHcWoVdjzG8OiBj/qB/5odQ5iqizctkVeBVMoTM5Wb1Ln/KAfesfkyAZqsrE9sI0hPNl7MKyLIugXfdLJPo87g6Q54aj3tzhhyLPKfNWU8GHHIqqY98bsibVGwOND8/YzSngil6LBWg61o+ksphwGJ0r7WQ6Uc7yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=opQ4vh7z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2892AC4CEE4;
	Thu, 17 Apr 2025 18:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744913946;
	bh=IC3L7wDKBP/BLuzdF8wtKHFj5lDBQnG4vs3ZhWAZ0BQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=opQ4vh7zqblSG1KXGOQnyHXHa+GLwqPHnyfJgkX/V6/1kbW7iepbgs5hVMfAhFPVN
	 YvF19NitaQ4hz1HWHi6BxhepD9Mdw6Br/RMZB6JrsRsxgtN9h8tDP/MZQfOUaBYsGG
	 rLMd0Jmfk7ZM7tUtxMgwC1nX+3ehj81M4vtFmKi0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	kernel test robot <oliver.sang@intel.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.13 047/414] x86/mm: Clear _PAGE_DIRTY for kernel mappings when we clear _PAGE_RW
Date: Thu, 17 Apr 2025 19:46:45 +0200
Message-ID: <20250417175113.309403015@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417175111.386381660@linuxfoundation.org>
References: <20250417175111.386381660@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthew Wilcox (Oracle) <willy@infradead.org>

[ Upstream commit c1fcf41cf37f7a3fd3bbf6f0c04aba3ea4258888 ]

The bit pattern of _PAGE_DIRTY set and _PAGE_RW clear is used to mark
shadow stacks.  This is currently checked for in mk_pte() but not
pfn_pte().  If we add the check to pfn_pte(), it catches vfree()
calling set_direct_map_invalid_noflush() which calls
__change_page_attr() which loads the old protection bits from the
PTE, clears the specified bits and uses pfn_pte() to construct the
new PTE.

We should, therefore, for kernel mappings, clear the _PAGE_DIRTY bit
consistently whenever we clear _PAGE_RW.  I opted to do it in the
callers in case we want to use __change_page_attr() to create shadow
stacks inside the kernel at some point in the future.  Arguably, we
might also want to clear _PAGE_ACCESSED here.

Note that the 3 functions involved:

  __set_pages_np()
  kernel_map_pages_in_pgd()
  kernel_unmap_pages_in_pgd()

Only ever manipulate non-swappable kernel mappings, so maintaining
the DIRTY:1|RW:0 special pattern for shadow stacks and DIRTY:0
pattern for non-shadow-stack entries can be maintained consistently
and doesn't result in the unintended clearing of a live dirty bit
that could corrupt (destroy) dirty bit information for user mappings.

Reported-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/174051422675.10177.13226545170101706336.tip-bot2@tip-bot2
Closes: https://lore.kernel.org/oe-lkp/202502241646.719f4651-lkp@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/mm/pat/set_memory.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 95bc50a8541c6..24c74136acb33 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -2422,7 +2422,7 @@ static int __set_pages_np(struct page *page, int numpages)
 				.pgd = NULL,
 				.numpages = numpages,
 				.mask_set = __pgprot(0),
-				.mask_clr = __pgprot(_PAGE_PRESENT | _PAGE_RW),
+				.mask_clr = __pgprot(_PAGE_PRESENT | _PAGE_RW | _PAGE_DIRTY),
 				.flags = CPA_NO_CHECK_ALIAS };
 
 	/*
@@ -2509,7 +2509,7 @@ int __init kernel_map_pages_in_pgd(pgd_t *pgd, u64 pfn, unsigned long address,
 		.pgd = pgd,
 		.numpages = numpages,
 		.mask_set = __pgprot(0),
-		.mask_clr = __pgprot(~page_flags & (_PAGE_NX|_PAGE_RW)),
+		.mask_clr = __pgprot(~page_flags & (_PAGE_NX|_PAGE_RW|_PAGE_DIRTY)),
 		.flags = CPA_NO_CHECK_ALIAS,
 	};
 
@@ -2552,7 +2552,7 @@ int __init kernel_unmap_pages_in_pgd(pgd_t *pgd, unsigned long address,
 		.pgd		= pgd,
 		.numpages	= numpages,
 		.mask_set	= __pgprot(0),
-		.mask_clr	= __pgprot(_PAGE_PRESENT | _PAGE_RW),
+		.mask_clr	= __pgprot(_PAGE_PRESENT | _PAGE_RW | _PAGE_DIRTY),
 		.flags		= CPA_NO_CHECK_ALIAS,
 	};
 
-- 
2.39.5




