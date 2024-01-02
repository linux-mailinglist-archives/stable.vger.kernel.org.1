Return-Path: <stable+bounces-9205-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 23EBA821DB8
	for <lists+stable@lfdr.de>; Tue,  2 Jan 2024 15:32:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8539B217BE
	for <lists+stable@lfdr.de>; Tue,  2 Jan 2024 14:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C623711194;
	Tue,  2 Jan 2024 14:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dE9N96OJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9258210955
	for <stable@vger.kernel.org>; Tue,  2 Jan 2024 14:32:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5785C433C7;
	Tue,  2 Jan 2024 14:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704205932;
	bh=cZcUagCPF6ih7uEaANFLTsnaGF/ArIO6y6UNY6LWkxA=;
	h=Subject:To:Cc:From:Date:From;
	b=dE9N96OJBWywv/d3D9NHG39FQg/iqgnC4fvDIm3tjqeAATjxG46MaWmhziC2q1z+k
	 kdtmZdsNm+eu/Gha7qclIj2t68MQ9WTc8SmUFnZnZ9qBPDD2rPPZ6M3MTJpZj5Q8ZG
	 k2iKhbG4gkL0BAe2XtRuBwbIrsVFbgg2k1QAF0Us=
Subject: FAILED: patch "[PATCH] mm/memory-failure: cast index to loff_t before shifting it" failed to apply to 4.19-stable tree
To: willy@infradead.org,akpm@linux-foundation.org,dan.j.williams@intel.com,n-horiguchi@ah.jp.nec.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 02 Jan 2024 15:31:57 +0100
Message-ID: <2024010257-patchy-barge-f278@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 39ebd6dce62d8cfe3864e16148927a139f11bc9a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024010257-patchy-barge-f278@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

39ebd6dce62d ("mm/memory-failure: cast index to loff_t before shifting it")
00cc790e0036 ("mm: factor helpers for memory_failure_dev_pagemap")
f25cbb7a95a2 ("mm: add zone device coherent type memory support")
034e5afad921 ("mm: re-allow pinning of zero pfns")
1c563432588d ("mm: fix is_pinnable_page against a cma page")
405ce051236c ("mm/hwpoison: fix race between hugetlb free/demotion and memory_failure_hugetlb()")
9030fb0bb9d6 ("Merge tag 'folio-5.18c' of git://git.infradead.org/users/willy/pagecache")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 39ebd6dce62d8cfe3864e16148927a139f11bc9a Mon Sep 17 00:00:00 2001
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Date: Mon, 18 Dec 2023 13:58:37 +0000
Subject: [PATCH] mm/memory-failure: cast index to loff_t before shifting it

On 32-bit systems, we'll lose the top bits of index because arithmetic
will be performed in unsigned long instead of unsigned long long.  This
affects files over 4GB in size.

Link: https://lkml.kernel.org/r/20231218135837.3310403-4-willy@infradead.org
Fixes: 6100e34b2526 ("mm, memory_failure: Teach memory_failure() about dev_pagemap pages")
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 82e15baabb48..455093f73a70 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1704,7 +1704,7 @@ static void unmap_and_kill(struct list_head *to_kill, unsigned long pfn,
 		 * mapping being torn down is communicated in siginfo, see
 		 * kill_proc()
 		 */
-		loff_t start = (index << PAGE_SHIFT) & ~(size - 1);
+		loff_t start = ((loff_t)index << PAGE_SHIFT) & ~(size - 1);
 
 		unmap_mapping_range(mapping, start, size, 0);
 	}


