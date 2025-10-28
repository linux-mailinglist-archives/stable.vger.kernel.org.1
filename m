Return-Path: <stable+bounces-191399-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29313C1331B
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 07:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 542D61AA6AB2
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 06:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EEC22BE650;
	Tue, 28 Oct 2025 06:40:30 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE4E2BE047;
	Tue, 28 Oct 2025 06:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761633630; cv=none; b=CWFtNY6omiKP0Ag06r0BoQ4ztD7LMZY/jVgl5Uk+UDQnftjZ2ik6Tf4jtaWtTjT9blQifE/Kr2xzUbAnssm9f7Lr+A6zUZkXvoetCwOzeJsWMXc7wlfo7siFIznyrZ4xPSoQXFnwgLWvbZSY1t3ZpI/Fp1ari47u8Id51rcSqm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761633630; c=relaxed/simple;
	bh=eVfNHd1iMAWQ/lyC/xibTCJCOq6C6OUXb7eL79AUs+4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Mg0Ni6cK/a1jrNs8Sb3x6OV9BQEzpLHtEZHLyGWrzDOkoH2sD3phjZxwuwK/sE3+CrnU9YT/nvE1MeWny3+3rYCntFEQBNMqh3YrYyz7KEM5P7I8qpBpsMPuFyFENsA85eXTuUGzPjlpzLkGyK6O3CG71VeuRT71yoxUWaRin08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AE26D168F;
	Mon, 27 Oct 2025 23:40:18 -0700 (PDT)
Received: from Mac.noida.arm.com (Mac.noida.arm.com [10.166.150.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4C06A3F63F;
	Mon, 27 Oct 2025 23:40:22 -0700 (PDT)
From: Dev Jain <dev.jain@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Dev Jain <dev.jain@arm.com>,
	stable@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Barry Song <baohua@kernel.org>,
	linux-mm@kvack.org (open list:MEMORY MAPPING)
Subject: [PATCH] mm/mremap: Honour writable bit in mremap pte batching
Date: Tue, 28 Oct 2025 12:09:52 +0530
Message-Id: <20251028063952.90313-1-dev.jain@arm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently mremap folio pte batch ignores the writable bit during figuring
out a set of similar ptes mapping the same folio. Suppose that the first
pte of the batch is writable while the others are not - set_ptes will
end up setting the writable bit on the other ptes, which is a violation
of mremap semantics. Therefore, use FPB_RESPECT_WRITE to check the writable
bit while determining the pte batch.

Cc: stable@vger.kernel.org #6.17
Fixes: f822a9a81a31 ("mm: optimize mremap() by PTE batching")
Reported-by: David Hildenbrand <david@redhat.com>
Debugged-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Dev Jain <dev.jain@arm.com>
---
mm-selftests pass. Based on mm-new. Need David H. to confirm whether
the repro passes.

 mm/mremap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index a7f531c17b79..8ad06cf50783 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -187,7 +187,7 @@ static int mremap_folio_pte_batch(struct vm_area_struct *vma, unsigned long addr
 	if (!folio || !folio_test_large(folio))
 		return 1;
 
-	return folio_pte_batch(folio, ptep, pte, max_nr);
+	return folio_pte_batch_flags(folio, NULL, ptep, &pte, max_nr, FPB_RESPECT_WRITE);
 }
 
 static int move_ptes(struct pagetable_move_control *pmc,
-- 
2.30.2


