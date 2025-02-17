Return-Path: <stable+bounces-116597-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F2A0A3878B
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 16:31:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BB45171379
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 15:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3041322331F;
	Mon, 17 Feb 2025 15:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="aLh/01qX"
X-Original-To: stable@vger.kernel.org
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A692BAF9
	for <stable@vger.kernel.org>; Mon, 17 Feb 2025 15:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739806266; cv=none; b=BNf9FpYdryGHvIroBbykV+4RJ86qderdi4MpKCCSueTI+NNGBA9GKnTlov42b0fctXIXRfk18bt6doSAv7kY2ni3t8xWj2Q7Az9dcqLlI1KdNaPrm2HI/+EyA2qU1XORT8f+z5+aUB7oYDEf+Rxu3ZRMTlPDl0m0fx0q6LQ77a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739806266; c=relaxed/simple;
	bh=8vCBBIOnaV7yZr0K03FX2mQKgjz6rt27NiVCmAe2wBU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W4DKe6C7adETzrmE5gOh4V7JteFMO6Lc3e35VsjGd++T+fNLhwERstbK9CckL9iaZvZa9H2J78ir+V4yyFHznvAomvAtwJsna09Y/TEkQBEMY7UBT+MsugweLfD745GvtqywBzlQRWAzZWI2hNN4KKF7F0SVG6JiQ4Ui/T8Giu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=aLh/01qX; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1739806089;
	bh=+EPeoMBOPrDJSRW6ldOAaKkuHeJpaD74ruI8BMP7hS4=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=aLh/01qXKiqTnc01P52l7El4Zhd9PHiH37ZG84zaIuRJzFrkCynSqPX2KBUAXbiS9
	 3Yr2Dc6ZCP4RYUJ2yriRCzdqtlAFu0082Q4GrF4X9IWoMZf53PL/hSgtuP0k76MQVZ
	 Jw/56cnNegXhcSZDuSaYXzX56RiGm8FQKVrEva0M=
X-QQ-mid: bizesmtp81t1739806070tzh8edv4
X-QQ-Originating-IP: j1fxavUQSk+nzOu1c6iK0w9AVCCIHoi6/mDeN/Kwm3g=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 17 Feb 2025 23:27:48 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 17049307341331327739
From: Wentao Guan <guanwentao@uniontech.com>
To: stable@vger.kernel.org
Cc: Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
	John Hubbard <jhubbard@nvidia.com>,
	David Hildenbrand <david@redhat.com>,
	Aijun Sun <aijun.sun@unisoc.com>,
	Alistair Popple <apopple@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Wentao Guan <guanwentao@uniontech.com>
Subject: [PATCH 6.6.y] mm: gup: fix infinite loop within __get_longterm_locked
Date: Mon, 17 Feb 2025 23:27:40 +0800
Message-Id: <20250217152739.3734-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <2025021008-recharger-fastball-ffab@gregkh>
References: <2025021008-recharger-fastball-ffab@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5a-0
X-QQ-XMAILINFO: MdoRYM9mYrydlYBximkVDSutnHP7ln1xI3hhU6yvUp/glqE22C1HLS4U
	0fTzA5WIYWLKqXT6vev32lXD9EV81jOrJbSgTXjH4PmAmCH7bfUH+woRhRzLg+1r5gKfeyu
	OXEFn5gAiZH6lVbR51rgzTfng0RGsff5ZGWAM0RbhLKdlsgE+yy/qOqCx2dA1jCAyEfrOZG
	Ka+WFwCJkdaPK1kdZBwfm73SP6/TslTNy6pidxNe2p+Joasl9IHpqEOYESyvgBp69I39VLR
	Sl6SwkFzOoSxuVvv7umODAh/NcxUL092Bapype397zueGYS8lq1vAh8/KEJVlpjCbVmgNoj
	rfdGgTVDqfNr2P6DDh8bD+g4VWgidrlxVvipkHph0U2jbSkWTtvWpCpeP8jNXt1gX8Y/4YV
	XFbC2jADhnxRkNQJ/kOZyeF52VqmM9PJUBMe0mKZ1Op/eKWCBV7FS05Ti1vUma7Os1trnar
	FzJd7tThiTBiqayKYdbw0NomeE/4XTjyQRVWhmrBEKFTxH8wjBLHwBZbZPb3V4wgswKDSld
	L/DwN2xTbnnwtvwT9aW3cYpNfxp0BPjFYekloRqPRzx4cig81uhCcu7QQ+cWLH0WQNmZWhA
	KS3YYrp2LOZG/QKvAHxz+C7PXZjl79KrukieXuwP0F1m8G6VbDWLrk+abatSnIGR781qhe4
	nyz7dT+aM2ZIBYom094J9lZilbAvrETjQsdqhW73DJ+QAjBxarj27z3ncqKpmFJznsmqdyr
	HfOTAIoKx3yb+VgK4TEBESNYiFZhOFOHOiNZzvlTEaVUgWVx22M6yxkfJhLnGMasRwlGnRW
	sjCXwOjtE20EjTQWiv5mCliyjm8m+DCdflr2eoJMUG1Ty0Ba7bJrTpXUcKkW3T1CJE87QX7
	ySh5J5xs65JsHTb/nsL1sZO+F43IPfbvPB4b5mHKMcPl4K+wSO0T6/TQay49Lj4FTfeURcb
	DyaTosp3oPuJR+s6a7r1IIJf89ebFdpvVPBrEOjCtP5Qjq2NJeIo27s/Yn9yMtEXrL4A=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

commit 1aaf8c122918aa8897605a9aa1e8ed6600d6f930 upstream.

We can run into an infinite loop in __get_longterm_locked() when
collect_longterm_unpinnable_folios() finds only folios that are isolated
from the LRU or were never added to the LRU.  This can happen when all
folios to be pinned are never added to the LRU, for example when
vm_ops->fault allocated pages using cma_alloc() and never added them to
the LRU.

Fix it by simply taking a look at the list in the single caller, to see if
anything was added.

[zhaoyang.huang@unisoc.com: move definition of local]
  Link: https://lkml.kernel.org/r/20250122012604.3654667-1-zhaoyang.huang@unisoc.com
Link: https://lkml.kernel.org/r/20250121020159.3636477-1-zhaoyang.huang@unisoc.com
Fixes: 67e139b02d99 ("mm/gup.c: refactor check_and_migrate_movable_pages()")
Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Suggested-by: David Hildenbrand <david@redhat.com>
Acked-by: David Hildenbrand <david@redhat.com>
Cc: Aijun Sun <aijun.sun@unisoc.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
 mm/gup.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index fdd75384160d8..69d259f7bf37e 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1946,14 +1946,14 @@ struct page *get_dump_page(unsigned long addr)
 /*
  * Returns the number of collected pages. Return value is always >= 0.
  */
-static unsigned long collect_longterm_unpinnable_pages(
+static void collect_longterm_unpinnable_pages(
 					struct list_head *movable_page_list,
 					unsigned long nr_pages,
 					struct page **pages)
 {
-	unsigned long i, collected = 0;
 	struct folio *prev_folio = NULL;
 	bool drain_allow = true;
+	unsigned long i;
 
 	for (i = 0; i < nr_pages; i++) {
 		struct folio *folio = page_folio(pages[i]);
@@ -1965,8 +1965,6 @@ static unsigned long collect_longterm_unpinnable_pages(
 		if (folio_is_longterm_pinnable(folio))
 			continue;
 
-		collected++;
-
 		if (folio_is_device_coherent(folio))
 			continue;
 
@@ -1988,8 +1986,6 @@ static unsigned long collect_longterm_unpinnable_pages(
 				    NR_ISOLATED_ANON + folio_is_file_lru(folio),
 				    folio_nr_pages(folio));
 	}
-
-	return collected;
 }
 
 /*
@@ -2082,12 +2078,10 @@ static int migrate_longterm_unpinnable_pages(
 static long check_and_migrate_movable_pages(unsigned long nr_pages,
 					    struct page **pages)
 {
-	unsigned long collected;
 	LIST_HEAD(movable_page_list);
 
-	collected = collect_longterm_unpinnable_pages(&movable_page_list,
-						nr_pages, pages);
-	if (!collected)
+	collect_longterm_unpinnable_pages(&movable_page_list, nr_pages, pages);
+	if (list_empty(&movable_page_list))
 		return 0;
 
 	return migrate_longterm_unpinnable_pages(&movable_page_list, nr_pages,
-- 
2.20.1


