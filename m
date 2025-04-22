Return-Path: <stable+bounces-135005-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DFD1A95D64
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 07:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05D5E3B65B0
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 05:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A2718A6AB;
	Tue, 22 Apr 2025 05:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EJaCxGWO"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AB7A59
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 05:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745300249; cv=none; b=Bg/Susd5Wfr0a3KaunCQM3BGJjPtMorAcy0qxec/Xh+W9vbO8BP2MdqsnxFX0ao8S838B7IbbuXOojGV5L6q1/pBIXXmIUACIIBXZzTuJk/YA1HJSv5yXWKAmD2FHLR6xsX/IlXiDh/eqKh0J/rJ/5fuPpgd4wQRzpR23VHvh8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745300249; c=relaxed/simple;
	bh=AdkUubfUgCiUVAS8ivJvYkbuTqptxQtiaMQQ5fTnVkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IcQ0YqTDXKsFs9KsGYP8+XMwRNjZtNZQBS7OjeK4zTn6RdcWDP9pwDZV+yubO1iTGo58zJ0oMJeDLxOJcYrTr16fDMUfRs6t/cW94MnkBHvg8E9Ta8xcjnJfSKWfcpSzIbhEcuZmYUKIBgsNl1x2PDKUrWTu75tCMl7fcJ8bUBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EJaCxGWO; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745300248; x=1776836248;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AdkUubfUgCiUVAS8ivJvYkbuTqptxQtiaMQQ5fTnVkY=;
  b=EJaCxGWOZei6kBQEg6/+vevM8mbmw7DiqPBey1jcHsfEgQBcAYqxw7Aw
   RWVyAAM+3Bn8q9jINh3U4686zAsFo6Wh2U+H+ddqK338KKPFZEL0bLKB/
   3TLZP9GSIUJZBQMmuIQGxciMGdwtGCsP7rDUDSb1AYRJptf+2QSZYceNC
   g8pldatLSPYh83qnkhzlBFrcam3WoMsjOb0qcnCErd6VqtY1reaujpTJp
   AC0yW3dkaHcIXDFUtpgIuT43tv/aaziTSzBlTLo8r8lJ5Psur06KkW1LO
   JBWH4wWXlrjjnGWRVPDb3vNiYoujSsgnHCLg2oLhaXpRgi1j9zOPyCn5h
   g==;
X-CSE-ConnectionGUID: 6VceFnomQ3+qt26GaIKfNQ==
X-CSE-MsgGUID: 4s5YSXj9SaqWBectqQzHoA==
X-IronPort-AV: E=McAfee;i="6700,10204,11410"; a="47024128"
X-IronPort-AV: E=Sophos;i="6.15,230,1739865600"; 
   d="scan'208";a="47024128"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2025 22:37:27 -0700
X-CSE-ConnectionGUID: DxuZt/OJQH2K4m737zkzvQ==
X-CSE-MsgGUID: esdhSiXkQUWbGOqquFLD2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,230,1739865600"; 
   d="scan'208";a="132791708"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa009.fm.intel.com with ESMTP; 21 Apr 2025 22:37:25 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 5559E1AC; Tue, 22 Apr 2025 08:37:24 +0300 (EEST)
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: stable@vger.kernel.org
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Daniel Axtens <dja@axtens.net>,
	David Hildenbrand <david@redhat.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 5.15.y] mm: fix apply_to_existing_page_range()
Date: Tue, 22 Apr 2025 08:37:22 +0300
Message-ID: <20250422053722.881707-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <2025042115-penholder-famished-11cb@gregkh>
References: <2025042115-penholder-famished-11cb@gregkh>
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
index 62fe3707ff92..4998b4c49052 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2570,11 +2570,11 @@ static int apply_to_pte_range(struct mm_struct *mm, pmd_t *pmd,
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


