Return-Path: <stable+bounces-124525-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23690A6347E
	for <lists+stable@lfdr.de>; Sun, 16 Mar 2025 08:25:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36ADC188F815
	for <lists+stable@lfdr.de>; Sun, 16 Mar 2025 07:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8331E150997;
	Sun, 16 Mar 2025 07:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oSUi0Mk8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A594C80
	for <stable@vger.kernel.org>; Sun, 16 Mar 2025 07:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742109909; cv=none; b=u4Lybvg4CNOeypLAiOILlKjgdDxTsOTI7mrk/Awx/txIc/Snh1Sorl88A0nDh+zl8a+57f8VNH2ZA8KJKp3DGdAj1o6MJGTN94zaKDtaaGLNzjYfOAyeup5E4NvNVnQ5qbZ3NJRrkhNs14Qq2v8Cux083ntDcN4HabU0UoimKf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742109909; c=relaxed/simple;
	bh=chdclulVHkct70Z9Pwy3aGOIuZ+xVdW54R+r2gpftQQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=R8pe6hb5dqxoHk0RDoZq0AjOwH64+tkHIjJOHGDgoO7INcDEhBLvzTfHgjLfzBbPhhPqzrnqTHuv01CPW0PhYDVK9rkUW8xGrmkibwTsvFx9btOI7iFpIX1wsClNptCmRKSatWPFdfZZ2QCXgv/tAo6JCh391KCCy/Yc77pXKis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oSUi0Mk8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EFCAC4CEDD;
	Sun, 16 Mar 2025 07:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742109908;
	bh=chdclulVHkct70Z9Pwy3aGOIuZ+xVdW54R+r2gpftQQ=;
	h=Subject:To:Cc:From:Date:From;
	b=oSUi0Mk8Dt8Zsx7tmqmTl2gxvrhUOZXXmXQfwtLRMdReoRPrJ7xxjJC+aBU/IH0Xu
	 msWzJN0fMTP5aYdiwQzDMrCOdNUxpB+Ubh0h01PN2w4gcy1kC8PaOxzPCDoA7Oi0aT
	 3SvmjsLQzd9ZChRiFNhCOjvU6IkV5wLEyM3FsgPk=
Subject: FAILED: patch "[PATCH] Fix mmu notifiers for range-based invalidates" failed to apply to 6.6-stable tree
To: pjaroszynski@nvidia.com,apopple@nvidia.com,catalin.marinas@arm.com,jgg@nvidia.com,jhubbard@nvidia.com,nicolinc@nvidia.com,rananta@google.com,robin.murphy@arm.com,sj@kernel.org,will@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 16 Mar 2025 08:23:50 +0100
Message-ID: <2025031650-yarn-arrogant-2584@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x f7edb07ad7c66eab3dce57384f33b9799d579133
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025031650-yarn-arrogant-2584@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f7edb07ad7c66eab3dce57384f33b9799d579133 Mon Sep 17 00:00:00 2001
From: Piotr Jaroszynski <pjaroszynski@nvidia.com>
Date: Tue, 4 Mar 2025 00:51:27 -0800
Subject: [PATCH] Fix mmu notifiers for range-based invalidates

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
Cc: stable@vger.kernel.org
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Alistair Popple <apopple@nvidia.com>
Link: https://lore.kernel.org/r/20250304085127.2238030-1-pjaroszynski@nvidia.com
Signed-off-by: Will Deacon <will@kernel.org>

diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
index bc94e036a26b..8104aee4f9a0 100644
--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -396,33 +396,35 @@ static inline void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
 #define __flush_tlb_range_op(op, start, pages, stride,			\
 				asid, tlb_level, tlbi_user, lpa2)	\
 do {									\
+	typeof(start) __flush_start = start;				\
+	typeof(pages) __flush_pages = pages;				\
 	int num = 0;							\
 	int scale = 3;							\
 	int shift = lpa2 ? 16 : PAGE_SHIFT;				\
 	unsigned long addr;						\
 									\
-	while (pages > 0) {						\
+	while (__flush_pages > 0) {					\
 		if (!system_supports_tlb_range() ||			\
-		    pages == 1 ||					\
-		    (lpa2 && start != ALIGN(start, SZ_64K))) {		\
-			addr = __TLBI_VADDR(start, asid);		\
+		    __flush_pages == 1 ||				\
+		    (lpa2 && __flush_start != ALIGN(__flush_start, SZ_64K))) {	\
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
-			addr = __TLBI_VADDR_RANGE(start >> shift, asid, \
+			addr = __TLBI_VADDR_RANGE(__flush_start >> shift, asid, \
 						scale, num, tlb_level);	\
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


