Return-Path: <stable+bounces-145079-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D05ABD9AB
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 15:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6E2E167088
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 13:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB21424293C;
	Tue, 20 May 2025 13:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uEkzPMJ7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2DB2417E4
	for <stable@vger.kernel.org>; Tue, 20 May 2025 13:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747748204; cv=none; b=UaNxRoSiW4L81uQUFqKQ/CylVNqXp1s+qTqG+EO9MioGt9R10Kyiq1FCCRr0TMfSvcEe2yFro0AZVVhCcqeBMFawg7bFFrvPvE03BBFUdnP+xGW05j34iz6lBxAOnq0loXROkISyR1N/2CFpA0kmcuWNf058XO0AE5y0yIv/+Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747748204; c=relaxed/simple;
	bh=fLq7uIZ4qIqx2Roro5y+RqCeGXlPBv/FhLdBZCqTaxs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PSu+ZIuFzjKuwowZuAy1lsS+0638nYJKVtBBMd7qa2Ecw7j9biq00mjbwniSXY741ygE5PTVMqsIoSNnKbOn/iWE4eMBlRIq1N3d67nitbnh/LGHbJGFjkKSdJuPekbqDRnGC7FjrKTMIZ3j+YdJehFSZ0qQjSdwjAZEhNDQUBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uEkzPMJ7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6321C4CEEA;
	Tue, 20 May 2025 13:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747748204;
	bh=fLq7uIZ4qIqx2Roro5y+RqCeGXlPBv/FhLdBZCqTaxs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uEkzPMJ7X2A7kZzJbbtcwx35wHWgYxC6kd4JfobhxhgasvSJL7lD8ewfDVNQLuP4Q
	 DKQkqBA1MWaWWKim9kx76zc5PJ/JKYRhRRkBpKxe9d0nZjtpqKBs4zIYBudO8Et10t
	 cu6UOl5PseO9qKk4E6it5hERnz9UbGjaRHIXES5Rtm1mwjDnN1V64ODJKsVOKRvelb
	 +I0VtV7M97qQnsuByCxnEXk+XEzQdPdTDWaN07FwC7Pt25J54864gHkd3xlX2ZgyBG
	 HjDqkViUCW/04ou9brtEnpBBszasAX9pr8fm19qcmahNV3SRQKofHCBiewix3YMNzd
	 DKCrGoNJZVyKA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	kirill.shutemov@linux.intel.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.14.y] mm/page_alloc: fix race condition in unaccepted memory handling
Date: Tue, 20 May 2025 09:36:42 -0400
Message-Id: <20250520060539-94d821f2bc069044@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250520072320.605775-1-kirill.shutemov@linux.intel.com>
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

Note: The patch differs from the upstream commit:
---
1:  fefc075182275 ! 1:  66476a80746d9 mm/page_alloc: fix race condition in unaccepted memory handling
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
| stable/linux-6.14.y       |  Success    |  Success   |

