Return-Path: <stable+bounces-137796-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45656AA14F3
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 19:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FF9F167E69
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 17:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E071C6B4;
	Tue, 29 Apr 2025 17:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QLoIzZ6B"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881A0216605;
	Tue, 29 Apr 2025 17:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745947154; cv=none; b=Cxc6fu3REPXIfZcYsAjrkORmECA6WhNQRoCtdEZUVzeyjBxdcf81+GEluOhzQv1OORQJQ+8OyL+pwMvsRBDm+v6Q1nHoSpS/zRxM7iaybP8zhnwjDBYCC6q5V917gsMHdoxnBH54Ci7vyHB0Zdh9AO8Ypj8tK25Se9hME5ghiwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745947154; c=relaxed/simple;
	bh=mQdz5MkECy9twmDzlkedBGKt/RH79lCz1bpi8utk72Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IhMAXwwNu+ATwjW6gHyp82gP9lV2pt3sXuEVRVPQ3si1i1uf2wyJB5h/vdm2wgEY19vtL1jLSyz3Rd0/5jTda6vKJqPKOuCjz2onJBOqEQ6GNEBaJHj+AqXJh9jqcOI4onyA1F22/OuDlZN2Pesy3y0Q8KvadFSwq1PodqcTmdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QLoIzZ6B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2E03C4CEE9;
	Tue, 29 Apr 2025 17:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745947154;
	bh=mQdz5MkECy9twmDzlkedBGKt/RH79lCz1bpi8utk72Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QLoIzZ6BlhdKMPJKEAmOy3E1FJM82zRUTH8AsSo4nXH0ewdDmg1G/3Z0TVXp25bM1
	 put4hVF+Ty7+Q/Nq+NtPjplNm4zlU7cbCiR5TcwpTVRAvfubZTNLfNZ7g7FkLNkBKE
	 KrBqQCpfSD1949iapl0AEVL+iVMayIHMbSYWQf8M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Daniel Axtens <dja@axtens.net>,
	David Hildenbrand <david@redhat.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 5.10 189/286] mm: fix apply_to_existing_page_range()
Date: Tue, 29 Apr 2025 18:41:33 +0200
Message-ID: <20250429161115.745692698@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161107.848008295@linuxfoundation.org>
References: <20250429161107.848008295@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

commit a995199384347261bb3f21b2e171fa7f988bd2f8 upstream.

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
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/memory.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2469,11 +2469,11 @@ static int apply_to_pte_range(struct mm_
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
 



