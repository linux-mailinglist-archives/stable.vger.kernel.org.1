Return-Path: <stable+bounces-2492-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A168B7F8469
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 20:27:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C7E6B257A9
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86ED8381A2;
	Fri, 24 Nov 2023 19:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1oIQ7pVz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4212FC36;
	Fri, 24 Nov 2023 19:26:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAA7CC433B8;
	Fri, 24 Nov 2023 19:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700854017;
	bh=cBpVYwnmyrDhZSzb/aBaBR7mLweaFBJl59tx9xVSeXE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1oIQ7pVzEQFZpnGN0FO6+t9GkwercWQ8o2410ObT5ZWABZE10ko8usBB/CJCvlInN
	 qAuMtwlneIGCuQIEgVO7FhCG5U8IalSWhHkyRtIbkZuvB9fsMphrpzoOMMBhSB9PC8
	 RdsZ451hawqOrYtqdMpwQtBo50QMEnehMWphi7WY=
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
Subject: [PATCH 5.4 098/159] mm/cma: use nth_page() in place of direct struct page manipulation
Date: Fri, 24 Nov 2023 17:55:15 +0000
Message-ID: <20231124171945.974713926@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124171941.909624388@linuxfoundation.org>
References: <20231124171941.909624388@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zi Yan <ziy@nvidia.com>

commit 2e7cfe5cd5b6b0b98abf57a3074885979e187c1c upstream.

Patch series "Use nth_page() in place of direct struct page manipulation",
v3.

On SPARSEMEM without VMEMMAP, struct page is not guaranteed to be
contiguous, since each memory section's memmap might be allocated
independently.  hugetlb pages can go beyond a memory section size, thus
direct struct page manipulation on hugetlb pages/subpages might give wrong
struct page.  Kernel provides nth_page() to do the manipulation properly.
Use that whenever code can see hugetlb pages.


This patch (of 5):

When dealing with hugetlb pages, manipulating struct page pointers
directly can get to wrong struct page, since struct page is not guaranteed
to be contiguous on SPARSEMEM without VMEMMAP.  Use nth_page() to handle
it properly.

Without the fix, page_kasan_tag_reset() could reset wrong page tags,
causing a wrong kasan result.  No related bug is reported.  The fix
comes from code inspection.

Link: https://lkml.kernel.org/r/20230913201248.452081-1-zi.yan@sent.com
Link: https://lkml.kernel.org/r/20230913201248.452081-2-zi.yan@sent.com
Fixes: 2813b9c02962 ("kasan, mm, arm64: tag non slab memory allocated via pagealloc")
Signed-off-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Mike Rapoport (IBM) <rppt@kernel.org>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/cma.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/mm/cma.c
+++ b/mm/cma.c
@@ -481,7 +481,7 @@ struct page *cma_alloc(struct cma *cma,
 	 */
 	if (page) {
 		for (i = 0; i < count; i++)
-			page_kasan_tag_reset(page + i);
+			page_kasan_tag_reset(nth_page(page, i));
 	}
 
 	if (ret && !no_warn) {



