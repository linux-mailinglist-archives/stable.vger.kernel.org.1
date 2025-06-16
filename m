Return-Path: <stable+bounces-152742-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7ACADBD83
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 01:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 044783AC3F4
	for <lists+stable@lfdr.de>; Mon, 16 Jun 2025 23:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC922264A6;
	Mon, 16 Jun 2025 23:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="sHKbxxsV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A2834545;
	Mon, 16 Jun 2025 23:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750116090; cv=none; b=jz/pno2zn7CbRW5nDX7dpmaPxI0wd9yMPsdXDmwlKmd0k2+3dDZ15WV/rAN9ZEFJJIocWHAnFAcJD13fz7x+/qRmNVIfN+dIpu49TKI1i79bhuVyAtqn7njmxyLzVwlj9UYiN16VRt2WD+NJ3eXPUjDWZHM0omepSZoswOCOa4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750116090; c=relaxed/simple;
	bh=GCiKWlw5/RrdHinuuJoSOCeLqjABp+XNFv1qKbj3wMA=;
	h=Date:To:From:Subject:Message-Id; b=EcXNC6KoUeJzJXCz8ZNLUaPWmOi4fIKJvRs/qyk812SBr49nea4WsXZE0PxG52kbggnVZ3SuDVf8N9sBcvmP8pw+lOFJNuFGi9ZFQfO065vFabyhVvAU0qAqW4e8fGJwitI0hrOeSVHsd9RoefR5pWn1TYM6IQXtyltW9WPYdhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=sHKbxxsV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A40A7C4CEEA;
	Mon, 16 Jun 2025 23:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1750116089;
	bh=GCiKWlw5/RrdHinuuJoSOCeLqjABp+XNFv1qKbj3wMA=;
	h=Date:To:From:Subject:From;
	b=sHKbxxsV12+MzXaC0TpRWZYuOUhdF4/hsEFrrsxlJuE6mu/f4txE8ogy4sVcyVdAi
	 BouS/7aINLvR1QpWCpdnj5uYzj51oxyQjYDoPw77+Uxhj8AxbqCPh4YAvs52+O/IM5
	 m0pSPUUiIi0yveSNKKYr+wznAmz/4anx2Je17o/M=
Date: Mon, 16 Jun 2025 16:21:29 -0700
To: mm-commits@vger.kernel.org,zhaoyang.huang@unisoc.com,zhangpeng.00@bytedance.com,willy@infradead.org,surenb@google.com,Steve.Kang@unisoc.com,stable@vger.kernel.org,sidhartha.kumar@oracle.com,lorenzo.stoakes@oracle.com,hailong.liu@oppo.com,Liam.Howlett@oracle.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: + maple_tree-fix-ma_state_prealloc-flag-in-mas_preallocate.patch added to mm-hotfixes-unstable branch
Message-Id: <20250616232129.A40A7C4CEEA@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>


The patch titled
     Subject: maple_tree: fix MA_STATE_PREALLOC flag in mas_preallocate()
has been added to the -mm mm-hotfixes-unstable branch.  Its filename is
     maple_tree-fix-ma_state_prealloc-flag-in-mas_preallocate.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/maple_tree-fix-ma_state_prealloc-flag-in-mas_preallocate.patch

This patch will later appear in the mm-hotfixes-unstable branch at
    git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

Before you just go and hit "reply", please:
   a) Consider who else should be cc'ed
   b) Prefer to cc a suitable mailing list as well
   c) Ideally: find the original patch on the mailing list and do a
      reply-to-all to that, adding suitable additional cc's

*** Remember to use Documentation/process/submit-checklist.rst when testing your code ***

The -mm tree is included into linux-next via the mm-everything
branch at git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
and is updated there every 2-3 working days

------------------------------------------------------
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: maple_tree: fix MA_STATE_PREALLOC flag in mas_preallocate()
Date: Mon, 16 Jun 2025 14:45:20 -0400

Temporarily clear the preallocation flag when explicitly requesting
allocations.  Pre-existing allocations are already counted against the
request through mas_node_count_gfp(), but the allocations will not happen
if the MA_STATE_PREALLOC flag is set.  This flag is meant to avoid
re-allocating in bulk allocation mode, and to detect issues with
preallocation calculations.

The MA_STATE_PREALLOC flag should also always be set on zero allocations
so that detection of underflow allocations will print a WARN_ON() during
consumption.

User visible effect of this flaw is a WARN_ON() followed by a null pointer
dereference when subsequent requests for larger number of nodes is
ignored, such as the vma merge retry in mmap_region() caused by drivers
altering the vma flags (which happens in v6.6, at least)

Link: https://lkml.kernel.org/r/20250616184521.3382795-3-Liam.Howlett@oracle.com
Fixes: 54a611b605901 ("Maple Tree: add new data structure")
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reported-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
Reported-by: Hailong Liu <hailong.liu@oppo.com>
Link: https://lore.kernel.org/all/1652f7eb-a51b-4fee-8058-c73af63bacd1@oppo.com/
Link: https://lore.kernel.org/all/20250428184058.1416274-1-Liam.Howlett@oracle.com/
Link: https://lore.kernel.org/all/20250429014754.1479118-1-Liam.Howlett@oracle.com/
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Hailong Liu <hailong.liu@oppo.com>
Cc: zhangpeng.00@bytedance.com <zhangpeng.00@bytedance.com>
Cc: Steve Kang <Steve.Kang@unisoc.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 lib/maple_tree.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/lib/maple_tree.c~maple_tree-fix-ma_state_prealloc-flag-in-mas_preallocate
+++ a/lib/maple_tree.c
@@ -5527,8 +5527,9 @@ int mas_preallocate(struct ma_state *mas
 	mas->store_type = mas_wr_store_type(&wr_mas);
 	request = mas_prealloc_calc(&wr_mas, entry);
 	if (!request)
-		return ret;
+		goto set_flag;
 
+	mas->mas_flags &= ~MA_STATE_PREALLOC;
 	mas_node_count_gfp(mas, request, gfp);
 	if (mas_is_err(mas)) {
 		mas_set_alloc_req(mas, 0);
@@ -5538,6 +5539,7 @@ int mas_preallocate(struct ma_state *mas
 		return ret;
 	}
 
+set_flag:
 	mas->mas_flags |= MA_STATE_PREALLOC;
 	return ret;
 }
_

Patches currently in -mm which might be from Liam.Howlett@oracle.com are

maple_tree-fix-ma_state_prealloc-flag-in-mas_preallocate.patch
testing-raix-tree-maple-increase-readers-and-reduce-delay-for-faster-machines.patch


