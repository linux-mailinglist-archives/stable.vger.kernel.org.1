Return-Path: <stable+bounces-878-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 395357F7CF6
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:20:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CECA9B21558
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F6039FF7;
	Fri, 24 Nov 2023 18:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2HeKQRIs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC2639FE9;
	Fri, 24 Nov 2023 18:20:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 354CAC433C9;
	Fri, 24 Nov 2023 18:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700850003;
	bh=brBBBs1hcfgUdUZaySXM1jkfiZO2klNDlvGmONPatFA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2HeKQRIsVztiKlgXUuSH6QNynF95ZAYMKz24JOseMsYf/JfYOtMvzNMxSjsCVZn8t
	 V/2Kff+AVheN10btlThSVbOuv/B3WC+W0fkU3DYNmNj3Zw2Xzt92dzJ+SLA+WoExEK
	 IQseBjEhWWvHBFoW0GR44umnEzFeKs+rhjnC/AIk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zi Yan <ziy@nvidia.com>,
	Muchun Song <songmuchun@bytedance.com>,
	David Hildenbrand <david@redhat.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.6 382/530] mm/memory_hotplug: use pfn math in place of direct struct page manipulation
Date: Fri, 24 Nov 2023 17:49:08 +0000
Message-ID: <20231124172039.646320428@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172028.107505484@linuxfoundation.org>
References: <20231124172028.107505484@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zi Yan <ziy@nvidia.com>

commit 1640a0ef80f6d572725f5b0330038c18e98ea168 upstream.

When dealing with hugetlb pages, manipulating struct page pointers
directly can get to wrong struct page, since struct page is not guaranteed
to be contiguous on SPARSEMEM without VMEMMAP.  Use pfn calculation to
handle it properly.

Without the fix, a wrong number of page might be skipped. Since skip cannot be
negative, scan_movable_page() will end early and might miss a movable page with
-ENOENT. This might fail offline_pages(). No bug is reported. The fix comes
from code inspection.

Link: https://lkml.kernel.org/r/20230913201248.452081-4-zi.yan@sent.com
Fixes: eeb0efd071d8 ("mm,memory_hotplug: fix scan_movable_pages() for gigantic hugepages")
Signed-off-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: David Hildenbrand <david@redhat.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Mike Rapoport (IBM) <rppt@kernel.org>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/memory_hotplug.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1689,7 +1689,7 @@ static int scan_movable_pages(unsigned l
 		 */
 		if (HPageMigratable(head))
 			goto found;
-		skip = compound_nr(head) - (page - head);
+		skip = compound_nr(head) - (pfn - page_to_pfn(head));
 		pfn += skip - 1;
 	}
 	return -ENOENT;



