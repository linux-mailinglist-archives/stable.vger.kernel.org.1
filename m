Return-Path: <stable+bounces-127082-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E63A3A7683C
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 16:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBC697A4C4A
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 14:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD87221737;
	Mon, 31 Mar 2025 14:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DvMbz33i"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9D9221725;
	Mon, 31 Mar 2025 14:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743431701; cv=none; b=tE0DFyd+rXDpVvIron7z46IpXMzjnt4jCEqkVYiEe4ReZ4IsaFhL4kMAuALErVMK3o8zsU1+LaqmuNw/5nPrQdKpafjVlz00YvW4yeW/OpdDyFNMJ/I7bYEUymP1T5p5aBx+H1Fb6UPT5IbH28FnB75Xp1xbTS0RdAUXpczt0pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743431701; c=relaxed/simple;
	bh=1DSQKfPq3GJpie+C92TiDqj5Q0TOL7K8mYR8d4cDbW4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BIHr5LalaH1uYDJeFeigOrwEeqM38/PlHMTypSCClKa/eHIgoyYbLIWYhuYx2rAYxgkuSHMc86JGPzxSz6ewa9XS/GmFuZRBq+Ngd06h/6rBCICizFfqY2nyRFpFMLqN+a8MEG4DtObXF+pb+R7fw09flpNYEfFlYIg6RCOrACo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DvMbz33i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D0B9C4CEE3;
	Mon, 31 Mar 2025 14:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743431701;
	bh=1DSQKfPq3GJpie+C92TiDqj5Q0TOL7K8mYR8d4cDbW4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DvMbz33i+P1SNH3JlObyPddG4CZDMESSRTCEPr3eZ9mcPWSjG1YIvfBRRE2MPjUBv
	 Y9jaykz9NJRGatuLTYbgfgG5iiO8TarMCqOKKwzWhy/Ov+BiWhX7u22rG+j7h6xDg4
	 9vtUWKyNFzITGn8aI/IFUBeBmE7T0DgJ1UlPLrAxxiQ46bdi94ZuFEwQwp3wdVpGXH
	 /UNkmuLs27uzos1xfM494C30AMPIiuNBL5EZIUwvZid4cw28oGDJVdlzThrXTyppyJ
	 /VJqTUG102OGBxVxfyLDm/kLLUz5lQzpyMt9h8wXsyL6Gcde9PteCGRQRWPBh1AbIi
	 OIuE+tBmlUN0w==
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
Subject: [PATCH AUTOSEL 6.13 04/16] x86/mm: Clear _PAGE_DIRTY for kernel mappings when we clear _PAGE_RW
Date: Mon, 31 Mar 2025 10:34:38 -0400
Message-Id: <20250331143450.1685242-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250331143450.1685242-1-sashal@kernel.org>
References: <20250331143450.1685242-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.9
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


