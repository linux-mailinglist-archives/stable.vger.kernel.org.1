Return-Path: <stable+bounces-9359-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DAF08231FF
	for <lists+stable@lfdr.de>; Wed,  3 Jan 2024 18:01:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2226A1F2103A
	for <lists+stable@lfdr.de>; Wed,  3 Jan 2024 17:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096961C29C;
	Wed,  3 Jan 2024 17:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="THDhLlkD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C757D1BDFB;
	Wed,  3 Jan 2024 17:01:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37120C433C9;
	Wed,  3 Jan 2024 17:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704301276;
	bh=gq6vuhZ70KbnWosI3ck3B2TWqrOC+/17Vlv5aBDIzqc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=THDhLlkDew9M6pO9T78Wj0PKB7c2K4ecXoLRD0gHorLESFDgCM+Zm1jjG45s7VbPr
	 CrQgXvgZMo08ab6m7I+R4MfjUuGx/Wttz6NO0nxsUgHmFA1tuPOLCsihI+1IeVju4B
	 2sPNcXzpN//o2P7XdVYYgnB1V0iB+2f4AyLQgStI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Charan Teja Kalla <quic_charante@quicinc.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
	Shakeel Butt <shakeelb@google.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.1 088/100] mm: migrate high-order folios in swap cache correctly
Date: Wed,  3 Jan 2024 17:55:17 +0100
Message-ID: <20240103164909.353234854@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240103164856.169912722@linuxfoundation.org>
References: <20240103164856.169912722@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Charan Teja Kalla <quic_charante@quicinc.com>

commit fc346d0a70a13d52fe1c4bc49516d83a42cd7c4c upstream.

Large folios occupy N consecutive entries in the swap cache instead of
using multi-index entries like the page cache.  However, if a large folio
is re-added to the LRU list, it can be migrated.  The migration code was
not aware of the difference between the swap cache and the page cache and
assumed that a single xas_store() would be sufficient.

This leaves potentially many stale pointers to the now-migrated folio in
the swap cache, which can lead to almost arbitrary data corruption in the
future.  This can also manifest as infinite loops with the RCU read lock
held.

[willy@infradead.org: modifications to the changelog & tweaked the fix]
Fixes: 3417013e0d18 ("mm/migrate: Add folio_migrate_mapping()")
Link: https://lkml.kernel.org/r/20231214045841.961776-1-willy@infradead.org
Signed-off-by: Charan Teja Kalla <quic_charante@quicinc.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reported-by: Charan Teja Kalla <quic_charante@quicinc.com>
Closes: https://lkml.kernel.org/r/1700569840-17327-1-git-send-email-quic_charante@quicinc.com
Cc: David Hildenbrand <david@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Cc: Shakeel Butt <shakeelb@google.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/migrate.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -388,6 +388,7 @@ int folio_migrate_mapping(struct address
 	int dirty;
 	int expected_count = folio_expected_refs(mapping, folio) + extra_count;
 	long nr = folio_nr_pages(folio);
+	long entries, i;
 
 	if (!mapping) {
 		/* Anonymous page without mapping */
@@ -425,8 +426,10 @@ int folio_migrate_mapping(struct address
 			folio_set_swapcache(newfolio);
 			newfolio->private = folio_get_private(folio);
 		}
+		entries = nr;
 	} else {
 		VM_BUG_ON_FOLIO(folio_test_swapcache(folio), folio);
+		entries = 1;
 	}
 
 	/* Move dirty while page refs frozen and newpage not yet exposed */
@@ -436,7 +439,11 @@ int folio_migrate_mapping(struct address
 		folio_set_dirty(newfolio);
 	}
 
-	xas_store(&xas, newfolio);
+	/* Swap cache still stores N entries instead of a high-order entry */
+	for (i = 0; i < entries; i++) {
+		xas_store(&xas, newfolio);
+		xas_next(&xas);
+	}
 
 	/*
 	 * Drop cache reference from old page by unfreezing



