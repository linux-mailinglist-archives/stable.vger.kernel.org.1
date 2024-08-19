Return-Path: <stable+bounces-69520-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC8E956794
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 11:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81F46B2226F
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 09:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4791815B986;
	Mon, 19 Aug 2024 09:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HC8AlvG5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076A013B592
	for <stable@vger.kernel.org>; Mon, 19 Aug 2024 09:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724061261; cv=none; b=fbJrxfjNb/MeU8cJVuBxkBpHf6ahwV6182B0pEbOi2042cekXCbKfRfwcOOt5pVBqXRPknJ900jr3a4BzLsHVPR8fjWL/EtKIoNpOqklw9tUI2oH16OfrqoqhS5ege/pF3vEDtHpLTIRUYDtHjxAK5nhVKkml5UgblzttsyOQbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724061261; c=relaxed/simple;
	bh=zh460gA+57UevNhf7MVrdfYoflryl297D42fvOyV9u4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Wd8zNV4+pLtfWUl1LRFxMmGkhnhuzsnV0lYLEpLFued5iD2HGlkPmCNnbTAFM7ADy3tfaGzgzaZoxPnzqHLL9QVk+HVAw/Tk94SmXe9tllgLiDMGQzVa5HG5DH4b7Mvai7JGC6e/hV2IZl1fabBmdOtC4HZi6sP3veiX0GQBVUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HC8AlvG5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 326B9C32782;
	Mon, 19 Aug 2024 09:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724061260;
	bh=zh460gA+57UevNhf7MVrdfYoflryl297D42fvOyV9u4=;
	h=Subject:To:Cc:From:Date:From;
	b=HC8AlvG5y8uCG+sbUPB3Kzhhd3mnmzdZJ+I7xQqJFj5hYuiwcaUKPcwJGCEMGaUBN
	 RuK3ef0XNeLYlpwEmRV5QBwKgJh9n/hLf0bg3sLRa7u3RIWesrysTiFAPgxpuVcQw+
	 hcvJovH46+A996AgGQfHJO0vCUsLNDj+A11aOFOA=
Subject: FAILED: patch "[PATCH] mm/vmalloc: fix page mapping if vm_area_alloc_pages() with" failed to apply to 6.6-stable tree
To: hailong.liu@oppo.com,akpm@linux-foundation.org,baohua@kernel.org,bhe@redhat.com,mhocko@suse.com,stable@vger.kernel.org,urezki@gmail.com,willy@infradead.org,zhengtangquan@oppo.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Aug 2024 11:54:17 +0200
Message-ID: <2024081917-rubber-cable-a9ab@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 61ebe5a747da649057c37be1c37eb934b4af79ca
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081917-rubber-cable-a9ab@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

61ebe5a747da ("mm/vmalloc: fix page mapping if vm_area_alloc_pages() with high order fallback to order 0")
88ae5fb755b0 ("mm: vmalloc: enable memory allocation profiling")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 61ebe5a747da649057c37be1c37eb934b4af79ca Mon Sep 17 00:00:00 2001
From: Hailong Liu <hailong.liu@oppo.com>
Date: Thu, 8 Aug 2024 20:19:56 +0800
Subject: [PATCH] mm/vmalloc: fix page mapping if vm_area_alloc_pages() with
 high order fallback to order 0

The __vmap_pages_range_noflush() assumes its argument pages** contains
pages with the same page shift.  However, since commit e9c3cda4d86e ("mm,
vmalloc: fix high order __GFP_NOFAIL allocations"), if gfp_flags includes
__GFP_NOFAIL with high order in vm_area_alloc_pages() and page allocation
failed for high order, the pages** may contain two different page shifts
(high order and order-0).  This could lead __vmap_pages_range_noflush() to
perform incorrect mappings, potentially resulting in memory corruption.

Users might encounter this as follows (vmap_allow_huge = true, 2M is for
PMD_SIZE):

kvmalloc(2M, __GFP_NOFAIL|GFP_X)
    __vmalloc_node_range_noprof(vm_flags=VM_ALLOW_HUGE_VMAP)
        vm_area_alloc_pages(order=9) ---> order-9 allocation failed and fallback to order-0
            vmap_pages_range()
                vmap_pages_range_noflush()
                    __vmap_pages_range_noflush(page_shift = 21) ----> wrong mapping happens

We can remove the fallback code because if a high-order allocation fails,
__vmalloc_node_range_noprof() will retry with order-0.  Therefore, it is
unnecessary to fallback to order-0 here.  Therefore, fix this by removing
the fallback code.

Link: https://lkml.kernel.org/r/20240808122019.3361-1-hailong.liu@oppo.com
Fixes: e9c3cda4d86e ("mm, vmalloc: fix high order __GFP_NOFAIL allocations")
Signed-off-by: Hailong Liu <hailong.liu@oppo.com>
Reported-by: Tangquan Zheng <zhengtangquan@oppo.com>
Reviewed-by: Baoquan He <bhe@redhat.com>
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Acked-by: Barry Song <baohua@kernel.org>
Acked-by: Michal Hocko <mhocko@suse.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 6b783baf12a1..af2de36549d6 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3584,15 +3584,8 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
 			page = alloc_pages_noprof(alloc_gfp, order);
 		else
 			page = alloc_pages_node_noprof(nid, alloc_gfp, order);
-		if (unlikely(!page)) {
-			if (!nofail)
-				break;
-
-			/* fall back to the zero order allocations */
-			alloc_gfp |= __GFP_NOFAIL;
-			order = 0;
-			continue;
-		}
+		if (unlikely(!page))
+			break;
 
 		/*
 		 * Higher order allocations must be able to be treated as


