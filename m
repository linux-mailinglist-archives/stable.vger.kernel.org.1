Return-Path: <stable+bounces-127094-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 672D4A7687F
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 16:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 181313AB834
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 14:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D60223702;
	Mon, 31 Mar 2025 14:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dpjuP1qN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067F0214818;
	Mon, 31 Mar 2025 14:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743431735; cv=none; b=KlksAkuEpsPnX1cJSbJkYHBc8IRIe84+TJaGyF47mX/Pi3GpDwqVIIpYR1clM1CsuPNpXdh1KYfdiVnr2FAOoghxUM05+t5rcGlcL4LTXILiFd7oeEXmIDzRzVIv9mdHWNW9k2d1Sig8ofggLI1ezxTWHhIjyjEpdUJ5ot8Dqzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743431735; c=relaxed/simple;
	bh=gAY113jvbK3fOrAwSQM/bozQSlaIQ+AIhsOpLMWk/IU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M6vrpKKRczYotkRiLnVHXl5kLnvCmqRiuFEgyv9GLDj7lfBmMqK5CFBQ6UGtHQnLD5fUdlbOzGlr1nz4agFlKI6bGF3Hq+El4bh0q4Zj8+Z1vAr9D+4t/dmUaaIxW5AG92To5/A3SrX5SFT36ZezkQg4B56MhMirTMuWKKSavPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dpjuP1qN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A5DEC4CEF3;
	Mon, 31 Mar 2025 14:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743431734;
	bh=gAY113jvbK3fOrAwSQM/bozQSlaIQ+AIhsOpLMWk/IU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dpjuP1qNuG2oQZw5mxZ0F6mZRX2Pvsekkqfu/U7qxrdP+W0q2QrYftusO4o/ZRdLH
	 PmRk8Z7QSnGrYHn8J0H/Cu7sgeubevpzJwrmwmj98N6ufx0OnFKSyCDL77J5FANuMP
	 g0T4tuPx9satSbR0J3o88fpn//9C4BF1PT7K4uXrQhLUdnS3yPbXcfXSVE+Zbmv5Uq
	 9VpN6VGUcYaufZivB+6nQZa4F1CLkJ7OyAL+0oiBqKiAjwC2YmQmzJkX64pBfzs1YC
	 XQhb+cFPv1C9B0dv6bHawsbJtRkiovJOgYyKwA3OKsqm6fprPzCnKs0UROMbO4OSv1
	 e5rKOowUIHIPA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	kernel test robot <oliver.sang@intel.com>,
	Ingo Molnar <mingo@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>,
	dave.hansen@linux.intel.com,
	luto@kernel.org,
	peterz@infradead.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	x86@kernel.org,
	kirill.shutemov@linux.intel.com,
	jgross@suse.com,
	rppt@kernel.org,
	kevin.brodsky@arm.com
Subject: [PATCH AUTOSEL 6.12 02/13] x86/mm: Clear _PAGE_DIRTY for kernel mappings when we clear _PAGE_RW
Date: Mon, 31 Mar 2025 10:35:16 -0400
Message-Id: <20250331143528.1685794-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250331143528.1685794-1-sashal@kernel.org>
References: <20250331143528.1685794-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.21
Content-Transfer-Encoding: 8bit

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

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
index 44f7b2ea6a073..69ceb967d73e9 100644
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
@@ -2501,7 +2501,7 @@ int __init kernel_map_pages_in_pgd(pgd_t *pgd, u64 pfn, unsigned long address,
 		.pgd = pgd,
 		.numpages = numpages,
 		.mask_set = __pgprot(0),
-		.mask_clr = __pgprot(~page_flags & (_PAGE_NX|_PAGE_RW)),
+		.mask_clr = __pgprot(~page_flags & (_PAGE_NX|_PAGE_RW|_PAGE_DIRTY)),
 		.flags = CPA_NO_CHECK_ALIAS,
 	};
 
@@ -2544,7 +2544,7 @@ int __init kernel_unmap_pages_in_pgd(pgd_t *pgd, unsigned long address,
 		.pgd		= pgd,
 		.numpages	= numpages,
 		.mask_set	= __pgprot(0),
-		.mask_clr	= __pgprot(_PAGE_PRESENT | _PAGE_RW),
+		.mask_clr	= __pgprot(_PAGE_PRESENT | _PAGE_RW | _PAGE_DIRTY),
 		.flags		= CPA_NO_CHECK_ALIAS,
 	};
 
-- 
2.39.5


