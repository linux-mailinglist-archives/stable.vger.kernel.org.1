Return-Path: <stable+bounces-135006-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9CC3A95D6A
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 07:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAFE618958F4
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 05:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8252B78C91;
	Tue, 22 Apr 2025 05:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g6hhwLH2"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F30A59
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 05:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745300378; cv=none; b=NkQcLmt/Nxk/wPYoAiT5F24UGIisu9rf41bTYWwfLHJju5aiG8eOqGLEhdngb0uLzEKfp+uCiX3D5KXEmrF8LGnLZUr47IhInH3G1JnIkAHe084X14w7Oxhw7nmqppWvgppprw+LGiovQzd0RA0bar0gdK8FsHZGalXYcsQHjDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745300378; c=relaxed/simple;
	bh=EAxTjtp0i3JOtL3+c3LDjqU5zJiETtUG9khwaTM9Iq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k4B7/TC5wiec9jWVCcnOBweygbJgkdKPpsfSGxvwP8+Q58udlm07acjmaMT+b9sDcc9cidz0Q0IXZFqbs2m+bV/Pd3aTPSos4kxocl3c+RKePmPQRzxqaQGHYvgbBhmwlINm/meufBscnzV3rsP1NmOqBp/dJksv/OwCwG5/s5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g6hhwLH2; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745300376; x=1776836376;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EAxTjtp0i3JOtL3+c3LDjqU5zJiETtUG9khwaTM9Iq4=;
  b=g6hhwLH2ra2H5kTc37SDXGx3qxjbo6kJ9uYEvUrloaW4cAs10WITMY0B
   vhayIUqHAkkJ4EhS83P91xzT94xA97qhkce1qS0d59EN8wVUxbT/rwhG7
   h4Xqiru2h2cZzrKWdcQB3zx1hUQunIJOsQefj9HIHBzoKN2NJYJLENCmQ
   WjL3BLhbnCxH4DORu91s8AS6eJ58DerRcdR5m9mmkWbqWSbty/RL5+ugG
   2b/154Q9/DIpuYkhdMKCBD7qvgUo99jiMh3Zp+yLWW/aNJszBYJ2QPnzA
   Ux6iNsCqS/0EYBOisPuXTPKMtzgar06JJhGW2RkMhewPfOdKhRIVTYZXe
   w==;
X-CSE-ConnectionGUID: ZT9Qi45TS5OB18xutj7IsA==
X-CSE-MsgGUID: ncx8+MvLQhq+OuT/QmyceA==
X-IronPort-AV: E=McAfee;i="6700,10204,11410"; a="72238050"
X-IronPort-AV: E=Sophos;i="6.15,230,1739865600"; 
   d="scan'208";a="72238050"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2025 22:39:36 -0700
X-CSE-ConnectionGUID: qO0MD4rJTiSO1v1ZY5Js0g==
X-CSE-MsgGUID: LsXLCrQURVqOCw5hHWd73Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,230,1739865600"; 
   d="scan'208";a="135992428"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa003.fm.intel.com with ESMTP; 21 Apr 2025 22:39:34 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 0AAB01AC; Tue, 22 Apr 2025 08:39:32 +0300 (EEST)
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: stable@vger.kernel.org
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Daniel Axtens <dja@axtens.net>,
	David Hildenbrand <david@redhat.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 5.10.y] mm: fix apply_to_existing_page_range()
Date: Tue, 22 Apr 2025 08:39:28 +0300
Message-ID: <20250422053928.882145-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <2025042115-clock-repressed-cf8e@gregkh>
References: <2025042115-clock-repressed-cf8e@gregkh>
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
index 29cce8aadb61..3ebf3f1da428 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2469,11 +2469,11 @@ static int apply_to_pte_range(struct mm_struct *mm, pmd_t *pmd,
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


