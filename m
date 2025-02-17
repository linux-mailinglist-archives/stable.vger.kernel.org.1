Return-Path: <stable+bounces-116587-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2DFA38581
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 15:08:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A471F3B4C54
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 14:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B757A2248A0;
	Mon, 17 Feb 2025 14:05:02 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4BD221567;
	Mon, 17 Feb 2025 14:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739801102; cv=none; b=re3NAuVfSX5jXlDJjStZe0vmrZzup9KQ/PPx6Ynxrc1P8RpOk8WUrZSp57OicgR0AQDzUIoTIJHJk/qz+pgz84pIuXYBQNR5mxcNhpOkbTL1MTCflQPr0KDWAOxxXBQ2m7REqtclOiMHE/arJFYaH4hFIYzem0+dxGU04jWGJSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739801102; c=relaxed/simple;
	bh=tZpbmT0+atD5ryJhegsPybkC2VzONfor27CrxmOtqw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uFjEUPvD2Do3habCaLVai2WCuJghgwXoWgBmvrTPnpDGEIjjgParVD326qvy49XI6reBcmHBqmB8p01dTA4caOXEqENqnOdFXU8I+j+oz3ntpR5Ds5144l4a9iK4Ajldr3wXl/mKJ5BEFIM27EgODtKRyPrCYCmGkB36pg+zIpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D924176C;
	Mon, 17 Feb 2025 06:05:16 -0800 (PST)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 288023F6A8;
	Mon, 17 Feb 2025 06:04:52 -0800 (PST)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Helge Deller <deller@gmx.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 4/4] mm: Don't skip arch_sync_kernel_mappings() in error paths
Date: Mon, 17 Feb 2025 14:04:17 +0000
Message-ID: <20250217140419.1702389-5-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250217140419.1702389-1-ryan.roberts@arm.com>
References: <20250217140419.1702389-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix callers that previously skipped calling arch_sync_kernel_mappings()
if an error occurred during a pgtable update. The call is still required
to sync any pgtable updates that may have occurred prior to hitting the
error condition.

These are theoretical bugs discovered during code review.

Cc: stable@vger.kernel.org
Fixes: 2ba3e6947aed ("mm/vmalloc: track which page-table levels were modified")
Fixes: 0c95cba49255 ("mm: apply_to_pte_range warn and fail if a large pte is encountered")
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 mm/memory.c  | 6 ++++--
 mm/vmalloc.c | 4 ++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 539c0f7c6d54..a15f7dd500ea 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3040,8 +3040,10 @@ static int __apply_to_page_range(struct mm_struct *mm, unsigned long addr,
 		next = pgd_addr_end(addr, end);
 		if (pgd_none(*pgd) && !create)
 			continue;
-		if (WARN_ON_ONCE(pgd_leaf(*pgd)))
-			return -EINVAL;
+		if (WARN_ON_ONCE(pgd_leaf(*pgd))) {
+			err = -EINVAL;
+			break;
+		}
 		if (!pgd_none(*pgd) && WARN_ON_ONCE(pgd_bad(*pgd))) {
 			if (!create)
 				continue;
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index a6e7acebe9ad..61981ee1c9d2 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -586,13 +586,13 @@ static int vmap_small_pages_range_noflush(unsigned long addr, unsigned long end,
 			mask |= PGTBL_PGD_MODIFIED;
 		err = vmap_pages_p4d_range(pgd, addr, next, prot, pages, &nr, &mask);
 		if (err)
-			return err;
+			break;
 	} while (pgd++, addr = next, addr != end);
 
 	if (mask & ARCH_PAGE_TABLE_SYNC_MASK)
 		arch_sync_kernel_mappings(start, end);
 
-	return 0;
+	return err;
 }
 
 /*
-- 
2.43.0


