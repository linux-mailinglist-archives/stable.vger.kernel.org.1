Return-Path: <stable+bounces-145087-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9DC1ABD9B6
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 15:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03D5C1BA4A89
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 13:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672271B6CE3;
	Tue, 20 May 2025 13:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Syx1aYHO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B079242D63
	for <stable@vger.kernel.org>; Tue, 20 May 2025 13:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747748429; cv=none; b=JVeLptHM0T+nRlhlMUASBqsr0cPwXYfIADZHxR+Udag1P9FNqoX4PDR4KOBLvq20TmPc08sUUo5xERVZd+WOZXmEBriIRkB3if+45taGAHCgRyzZvQulvu0bLq/BPBaVYdFEAVQM7pZoAErWWsqOdSSpzSwx4aXqDuVNuInEQ5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747748429; c=relaxed/simple;
	bh=Z9yFPCEwMxMz1X9tdwC08HYza7WWFqfutvd2vrR8W14=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nh1MOVqnu+IOBAQVUJAdx+D3uoNcjg0y8pfhKggnRHfvwIT5S7FMWA/gzDMZHJ9UFT0gL/aXVO+MpBB003zZyil++PwecSm5d9q11hVhnpQ0SzXVaqWi09xGdztcfZd229Qx6K/hrUtLKJqyFkFV/hiI27570Mo5eXhD1t61bJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Syx1aYHO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2212DC4CEE9;
	Tue, 20 May 2025 13:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747748428;
	bh=Z9yFPCEwMxMz1X9tdwC08HYza7WWFqfutvd2vrR8W14=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Syx1aYHOIgFO+kIKHxRUJiSdp9bz+IYUiySPAynHyHEIDf//7Kq09FNtdLAy7Jrnv
	 wB3a43NnH6+m+Ik2YMnTPfK1q5/IU1d3yTIyuaB717s+U0sdxaTPEXVbwKy3ZcZky8
	 q/beHBykFnzRGqfhseGmsPVaFI4LgzwJBA+/BpaoLP8HSdiKSG7Y73ZpaR9eDfposB
	 FZrYwjGbABVRVJBxIucvYYkiblUEM6hbc0f505+t2qVIRKXY/WJYOQA3wYiRN29yFc
	 vcb5yV6XRUASg4alM41isOM4r+k6JC/42BHhQqCHJXPPJCaf7DpHE05ETqSnDf/Se6
	 6AYYqiHFu9ScA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	kirill.shutemov@linux.intel.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12.y] mm/page_alloc: fix race condition in unaccepted memory handling
Date: Tue, 20 May 2025 09:40:27 -0400
Message-Id: <20250520062522-88efd3e89d1ab487@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250520072848.639525-1-kirill.shutemov@linux.intel.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

Summary of potential issues:
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: fefc075182275057ce607effaa3daa9e6e3bdc73

Status in newer kernel trees:
6.14.y | Not found

Note: The patch differs from the upstream commit:
---
1:  fefc075182275 ! 1:  e5e24c3c382e8 mm/page_alloc: fix race condition in unaccepted memory handling
    @@ Commit message
         Cc: Johannes Weiner <hannes@cmpxchg.org>
         Cc: <stable@vger.kernel.org>    [6.5+]
         Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    -
    - ## mm/internal.h ##
    -@@ mm/internal.h: unsigned long move_page_tables(struct pagetable_move_control *pmc);
    - 
    - #ifdef CONFIG_UNACCEPTED_MEMORY
    - void accept_page(struct page *page);
    --void unaccepted_cleanup_work(struct work_struct *work);
    - #else /* CONFIG_UNACCEPTED_MEMORY */
    - static inline void accept_page(struct page *page)
    - {
    -
    - ## mm/mm_init.c ##
    -@@ mm/mm_init.c: static void __meminit zone_init_free_lists(struct zone *zone)
    - 
    - #ifdef CONFIG_UNACCEPTED_MEMORY
    - 	INIT_LIST_HEAD(&zone->unaccepted_pages);
    --	INIT_WORK(&zone->unaccepted_cleanup, unaccepted_cleanup_work);
    - #endif
    - }
    - 
    +    (cherry picked from commit fefc075182275057ce607effaa3daa9e6e3bdc73)
    +    Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
     
      ## mm/page_alloc.c ##
     @@ mm/page_alloc.c: bool has_managed_dma(void)
    @@ mm/page_alloc.c: bool has_managed_dma(void)
     -
      static bool lazy_accept = true;
      
    --void unaccepted_cleanup_work(struct work_struct *work)
    --{
    --	static_branch_dec(&zones_with_unaccepted_pages);
    --}
    --
      static int __init accept_memory_parse(char *p)
    - {
    - 	if (!strcmp(p, "lazy")) {
     @@ mm/page_alloc.c: static bool page_contains_unaccepted(struct page *page, unsigned int order)
      static void __accept_page(struct zone *zone, unsigned long *flags,
      			  struct page *page)
    @@ mm/page_alloc.c: static void __accept_page(struct zone *zone, unsigned long *fla
      
      	__free_pages_ok(page, MAX_PAGE_ORDER, FPI_TO_TAIL);
     -
    --	if (last) {
    --		/*
    --		 * There are two corner cases:
    --		 *
    --		 * - If allocation occurs during the CPU bring up,
    --		 *   static_branch_dec() cannot be used directly as
    --		 *   it causes a deadlock on cpu_hotplug_lock.
    --		 *
    --		 *   Instead, use schedule_work() to prevent deadlock.
    --		 *
    --		 * - If allocation occurs before workqueues are initialized,
    --		 *   static_branch_dec() should be called directly.
    --		 *
    --		 *   Workqueues are initialized before CPU bring up, so this
    --		 *   will not conflict with the first scenario.
    --		 */
    --		if (system_wq)
    --			schedule_work(&zone->unaccepted_cleanup);
    --		else
    --			unaccepted_cleanup_work(&zone->unaccepted_cleanup);
    --	}
    +-	if (last)
    +-		static_branch_dec(&zones_with_unaccepted_pages);
      }
      
      void accept_page(struct page *page)
    @@ mm/page_alloc.c: static bool try_to_accept_memory_one(struct zone *zone)
     -	return static_branch_unlikely(&zones_with_unaccepted_pages);
     -}
     -
    - static bool cond_accept_memory(struct zone *zone, unsigned int order,
    - 			       int alloc_flags)
    + static bool cond_accept_memory(struct zone *zone, unsigned int order)
      {
      	long to_accept, wmark;
      	bool ret = false;
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

