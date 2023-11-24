Return-Path: <stable+bounces-2010-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A40857F8261
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 20:07:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D57021C23318
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2299A33E9;
	Fri, 24 Nov 2023 19:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Os3/wBLR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C9B2FC21;
	Fri, 24 Nov 2023 19:07:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62419C433C8;
	Fri, 24 Nov 2023 19:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700852824;
	bh=wWoGeUfHLdeTqsY7LyTRKXCg6IOqkcp6J2WRE41vZgA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Os3/wBLRn7nXcGJEnHGytBOkSGvCa2FLl039ynMML1wIHJvIJFq/EH1PVj+DkgpJr
	 j2ysfMI1e76V0dSg4O7VnbVPcSdYjUVu5KM4x2I3FbhYm1HI7g3Jr62uHn5fP745N6
	 AjYQE9xLUwqy0q1uYzDe/1VT/7YNHkAl5UCxyr2Y=
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
Subject: [PATCH 5.10 137/193] mm/cma: use nth_page() in place of direct struct page manipulation
Date: Fri, 24 Nov 2023 17:54:24 +0000
Message-ID: <20231124171952.695220143@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124171947.127438872@linuxfoundation.org>
References: <20231124171947.127438872@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

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
@@ -482,7 +482,7 @@ struct page *cma_alloc(struct cma *cma,
 	 */
 	if (page) {
 		for (i = 0; i < count; i++)
-			page_kasan_tag_reset(page + i);
+			page_kasan_tag_reset(nth_page(page, i));
 	}
 
 	if (ret && !no_warn) {



