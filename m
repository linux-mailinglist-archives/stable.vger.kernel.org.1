Return-Path: <stable+bounces-135004-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AAB2A95D5E
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 07:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92EC6176AB8
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 05:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3970019C578;
	Tue, 22 Apr 2025 05:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ObWqF5Ta"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5DCA59
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 05:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745300050; cv=none; b=Mt6TLlV+Tt5CxlfcAgYpKHLczwMVWtDMbwClBr/CL6yena6DmvakMcFEYaxxRLap3xKd6L896rVhVoVb7fJqiFx0tvs+hwNlLw9y/jNtKtm2v7CtPAyb9jH7KVBy06HyFS8NzEngimWsyffqYyEqHFtu9xg8b7bJzN1TxRFctss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745300050; c=relaxed/simple;
	bh=azfo17UpM0IMeOsSgjRr5mqK3r88yspW3YFpRG8exyo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OUwzdBspqx3hjzmxEGnn7MLRHzb/zDJMk2fibTQmReSeJCRYwrwnu+0Gb47ca0oCWVTRer9gezkIMJpIHptMdCORCAhVRzZY3MGilue20Aqer5DHIorJ6nK3Cl0geTc4Yz2a0bQnfQlbsIuOZX0adlB9bSiWHrnT2RUW1Cxhgeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ObWqF5Ta; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745300048; x=1776836048;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=azfo17UpM0IMeOsSgjRr5mqK3r88yspW3YFpRG8exyo=;
  b=ObWqF5TaJtlnBpg4LV3iYVP1y3mYm7RKj4Bm+fu1mrsP+y+me3k0oBIN
   qxO8IHVNgAB2XJ7flbSgwUTMeP+Kq6ORYUjJIR/bKoTsRbkjnxy3gQ9zY
   6O3oXq6TWJtO+MNUMWupATiPpBQvvWLqgF58dVh006Whjm5YJZnIQYraH
   J042+UdB5Z3Sw8O69O3gVLl6xgt7J81gha8aLgcJHEuiNobdwkFDRbYAj
   RNC8SwtAKUuss0GZwkxsPsdH0aHi0SOh8O/trPlEKHJV4gOjgNjouMs3B
   VQNTUsp3mbIBqCtZII8daSYQX9IiHCnXOnzODeP8Lpi/beCEQJ90uQjtz
   w==;
X-CSE-ConnectionGUID: qwKS7pucTd+Su7skyKR8KA==
X-CSE-MsgGUID: Mfd8TevoQJCI0tzG9uApWg==
X-IronPort-AV: E=McAfee;i="6700,10204,11410"; a="72237669"
X-IronPort-AV: E=Sophos;i="6.15,230,1739865600"; 
   d="scan'208";a="72237669"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2025 22:34:08 -0700
X-CSE-ConnectionGUID: j3oCFhCkQc6fQO/lEQpfaA==
X-CSE-MsgGUID: gu2jznEIQEmlkWct93Yg0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,230,1739865600"; 
   d="scan'208";a="131820903"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa010.jf.intel.com with ESMTP; 21 Apr 2025 22:34:05 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 23AA91AC; Tue, 22 Apr 2025 08:34:04 +0300 (EEST)
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: stable@vger.kernel.org
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Daniel Axtens <dja@axtens.net>,
	David Hildenbrand <david@redhat.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.1.y] mm: fix apply_to_existing_page_range()
Date: Tue, 22 Apr 2025 08:33:59 +0300
Message-ID: <20250422053359.830275-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <2025042114-author-badness-6b2c@gregkh>
References: <2025042114-author-badness-6b2c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the case of apply_to_existing_page_range(), apply_to_pte_range() is
reached with 'create' set to false.  When !create, the loop over the PTE
page table is broken.

apply_to_pte_range() will only move to the next PTE entry if 'create' is
true or if the current entry is not pte_none().

This means that the user of apply_to_existing_page_range() will not have
'fn' called for any entries after the first pte_none() in the PTE page
table.

Fix the loop logic in apply_to_pte_range().

There are no known runtime issues from this, but the fix is trivial enough
for stable@ even without a known buggy user.

Link: https://lkml.kernel.org/r/20250409094043.1629234-1-kirill.shutemov@linux.intel.com
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Fixes: be1db4753ee6 ("mm/memory.c: add apply_to_existing_page_range() helper")
Cc: Daniel Axtens <dja@axtens.net>
Cc: David Hildenbrand <david@redhat.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit a995199384347261bb3f21b2e171fa7f988bd2f8)
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 mm/memory.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 2e776ea38348..454d918449b3 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2659,11 +2659,11 @@ static int apply_to_pte_range(struct mm_struct *mm, pmd_t *pmd,
 	if (fn) {
 		do {
 			if (create || !pte_none(*pte)) {
-				err = fn(pte++, addr, data);
+				err = fn(pte, addr, data);
 				if (err)
 					break;
 			}
-		} while (addr += PAGE_SIZE, addr != end);
+		} while (pte++, addr += PAGE_SIZE, addr != end);
 	}
 	*mask |= PGTBL_PTE_MODIFIED;
 
-- 
2.47.2


