Return-Path: <stable+bounces-121377-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B203A567E2
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 13:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E917F1684A5
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 12:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B492192F2;
	Fri,  7 Mar 2025 12:33:20 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15EB14A4F9;
	Fri,  7 Mar 2025 12:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741350800; cv=none; b=AYcyPCdZaco7Vv70UA5lUzleZbmYjC1JWhl7BPCKJnuuNmlXj5dmFWUvko/XAx8Y7KCQ6pG3+GiZx5G28EABKRocn02HWAbrgNOLGVJydzzbC3UPl30DzJCLt/XM3vUMTvHXdzi3DneLK3UtEB28cHTvvNlXQfAL97AGtPWVmrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741350800; c=relaxed/simple;
	bh=2cMPsXfDUNXxY0A39P3Pugffdm6/N2LoJqadpXCN3t4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OXBULmq8AMAm/26LYgThu55gG6VQjAP5Ir90/YqcAO7Cq1mSHomhP7F9i2b54RMTChqOrzR/daMomzhRxfuzOXN+K+K5t+viENONO+rz/CEo9kNM4gH1DkmlXyOkj56Hriw6r7ArE1A28Q0BV0TU3PynUzWPPURPc5ptVyON3sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ABBC71477;
	Fri,  7 Mar 2025 04:33:27 -0800 (PST)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 413323F673;
	Fri,  7 Mar 2025 04:33:14 -0800 (PST)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v1] mm/madvise: Always set ptes via arch helpers
Date: Fri,  7 Mar 2025 12:33:06 +0000
Message-ID: <20250307123307.262298-1-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of writing a pte directly into the table, use the set_pte_at()
helper, which gives the arch visibility of the change.

In this instance we are guaranteed that the pte was originally none and
is being modified to a not-present pte, so there was unlikely to be a
bug in practice (at least not on arm64). But it's bad practice to write
the page table memory directly without arch involvement.

Cc: <stable@vger.kernel.org>
Fixes: 662df3e5c376 ("mm: madvise: implement lightweight guard page mechanism")
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 mm/madvise.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 388dc289b5d1..6170f4acc14f 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1101,7 +1101,7 @@ static int guard_install_set_pte(unsigned long addr, unsigned long next,
 	unsigned long *nr_pages = (unsigned long *)walk->private;

 	/* Simply install a PTE marker, this causes segfault on access. */
-	*ptep = make_pte_marker(PTE_MARKER_GUARD);
+	set_pte_at(walk->mm, addr, ptep, make_pte_marker(PTE_MARKER_GUARD));
 	(*nr_pages)++;

 	return 0;
--
2.43.0


