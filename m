Return-Path: <stable+bounces-132293-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D8CA864B1
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 19:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0FA416630C
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 17:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11BC3231A21;
	Fri, 11 Apr 2025 17:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MymUixhS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD71E23099C;
	Fri, 11 Apr 2025 17:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744392491; cv=none; b=AIF4bkkKCrGYFKoCGTMwV2PghqvAIkPT9kayG32YybpfBOcL2oJKzf5Y8tL1YsHhG6yRrdzSRkmTT1vFVSBBSbQvWsB5PAoEBXfKJ/dafxhj+oZKdyV6mjlOtA618aqLes6ShoXy9t05+73AH5Ns8v0IhnUzZ2P9arkMfvDrFpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744392491; c=relaxed/simple;
	bh=WC3u1ImMrIwQcuUwS71L4kjKo8LAJfFX0pYiJWHDjs0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RdFLUADw+VGUoXdbMWmQhR6/5xrnHQAdZcybtSABeIAco/ACqQKgMxbWJSF83IqcveNNt7obhV9tHNfos3QC1dkvNXLJZNsL56tNfxIS6tS855A/P4Km2rR47MobONFZWus5860xnw8fFWQG4qlWBYiFhTbJg/zMGoB5ot7wFRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MymUixhS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AB82C4CEE2;
	Fri, 11 Apr 2025 17:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744392491;
	bh=WC3u1ImMrIwQcuUwS71L4kjKo8LAJfFX0pYiJWHDjs0=;
	h=From:To:Cc:Subject:Date:From;
	b=MymUixhS6j31bXwFvi6mFMde2JMsbqVN+cM5XbJ2n0Fw/uSA4PPjbKbuOl03Ljm65
	 c1+UhbEjQan/xoAt0c9NIRR65zLecEmEUJF3NyMD8/ejDRa/Iz2ZsBE1iTpENqhIEh
	 00Q1T95PWm9ASE3S+nTEm0EsKYpVUZ+dzRrCeswWM17+kYaykbNZ6y4Jk9j4RyONDx
	 PRqI4GNN8WIB62+cER8is5rrKbYsvr+yCpfBLHLU935pl+Q+ogeLrdmontI6Z8IjM4
	 WUh4/SyHAdwJKiNNgXyLGRr9hKTCDLc/M0r4VONW5ZFiceGjNAin/RD/b2MBZ2AJPq
	 wRe0JosummXAg==
From: Will Deacon <will@kernel.org>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	Piotr Jaroszynski <pjaroszynski@nvidia.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Alistair Popple <apopple@nvidia.com>,
	Raghavendra Rao Ananta <rananta@google.com>,
	SeongJae Park <sj@kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [BACKPORT PATCH 6.6.y] Fix mmu notifiers for range-based invalidates
Date: Fri, 11 Apr 2025 18:28:04 +0100
Message-Id: <20250411172804.6014-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Piotr Jaroszynski <pjaroszynski@nvidia.com>

[ Upstream commit f7edb07ad7c66eab3dce57384f33b9799d579133 ]

Update the __flush_tlb_range_op macro not to modify its parameters as
these are unexepcted semantics. In practice, this fixes the call to
mmu_notifier_arch_invalidate_secondary_tlbs() in
__flush_tlb_range_nosync() to use the correct range instead of an empty
range with start=end. The empty range was (un)lucky as it results in
taking the invalidate-all path that doesn't cause correctness issues,
but can certainly result in suboptimal perf.

This has been broken since commit 6bbd42e2df8f ("mmu_notifiers: call
invalidate_range() when invalidating TLBs") when the call to the
notifiers was added to __flush_tlb_range(). It predates the addition of
the __flush_tlb_range_op() macro from commit 360839027a6e ("arm64: tlb:
Refactor the core flush algorithm of __flush_tlb_range") that made the
bug hard to spot.

Fixes: 6bbd42e2df8f ("mmu_notifiers: call invalidate_range() when invalidating TLBs")

Signed-off-by: Piotr Jaroszynski <pjaroszynski@nvidia.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Raghavendra Rao Ananta <rananta@google.com>
Cc: SeongJae Park <sj@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: iommu@lists.linux.dev
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org # Backport for 6.6.y only
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Alistair Popple <apopple@nvidia.com>
Link: https://lore.kernel.org/r/20250304085127.2238030-1-pjaroszynski@nvidia.com
[will: Resolve conflicts due to lack of LPA2 support]
Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/tlbflush.h | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
index b73baaf8ae47..d37db2f7a54c 100644
--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -369,31 +369,33 @@ static inline void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
 #define __flush_tlb_range_op(op, start, pages, stride,			\
 				asid, tlb_level, tlbi_user)		\
 do {									\
+	typeof(start) __flush_start = start;				\
+	typeof(pages) __flush_pages = pages;				\
 	int num = 0;							\
 	int scale = 3;							\
 	unsigned long addr;						\
 									\
-	while (pages > 0) {						\
+	while (__flush_pages > 0) {					\
 		if (!system_supports_tlb_range() ||			\
-		    pages == 1) {					\
-			addr = __TLBI_VADDR(start, asid);		\
+		    __flush_pages == 1) {				\
+			addr = __TLBI_VADDR(__flush_start, asid);	\
 			__tlbi_level(op, addr, tlb_level);		\
 			if (tlbi_user)					\
 				__tlbi_user_level(op, addr, tlb_level);	\
-			start += stride;				\
-			pages -= stride >> PAGE_SHIFT;			\
+			__flush_start += stride;			\
+			__flush_pages -= stride >> PAGE_SHIFT;		\
 			continue;					\
 		}							\
 									\
-		num = __TLBI_RANGE_NUM(pages, scale);			\
+		num = __TLBI_RANGE_NUM(__flush_pages, scale);		\
 		if (num >= 0) {						\
-			addr = __TLBI_VADDR_RANGE(start, asid, scale,	\
-						  num, tlb_level);	\
+			addr = __TLBI_VADDR_RANGE(__flush_start, asid,	\
+						scale, num, tlb_level);	\
 			__tlbi(r##op, addr);				\
 			if (tlbi_user)					\
 				__tlbi_user(r##op, addr);		\
-			start += __TLBI_RANGE_PAGES(num, scale) << PAGE_SHIFT; \
-			pages -= __TLBI_RANGE_PAGES(num, scale);	\
+			__flush_start += __TLBI_RANGE_PAGES(num, scale) << PAGE_SHIFT; \
+			__flush_pages -= __TLBI_RANGE_PAGES(num, scale);\
 		}							\
 		scale--;						\
 	}								\
-- 
2.49.0.604.gff1f9ca942-goog


