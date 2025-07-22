Return-Path: <stable+bounces-163639-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1B9B0CFE5
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 04:57:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 923095457B6
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 02:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8B3273803;
	Tue, 22 Jul 2025 02:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cH+vLsrV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6701A3172;
	Tue, 22 Jul 2025 02:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753153020; cv=none; b=oAUfXVomS+QobNKU/PnwNpVgl+AqIn1gSXBE/oJABWThqCtWC1ObkR4CLJjSc9z/tDQ/f9+ELIeaPPiWQv+uusNpPifOEYr2tH2Yhs/0yPn2CzLdzfxywEcNTNF/wSssufALIyb3EgBVtaihCc9L0OtEyh0oAdV8CeWI8HwYenk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753153020; c=relaxed/simple;
	bh=G7jQ6vjBrqcdcBX+jOv7jqiqfBiR8qm0tzxZNdDuSaM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=KCXPEYOf7XBBAT8vWtNKfyrVdpc0yJCvPQLMqce0DJC27RH8v5jVuXvxeUM6eT+OkVSJ/dSMslukUOA/gBRl5KVvXD8qaY+s1OUeQxCB3bj//Ym/U5fhEUkGWALAA3haJ6txxr3esjIEslDLXQrv3yi+0/WvcSzunn6olPS5tUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=cH+vLsrV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DD9DC4CEED;
	Tue, 22 Jul 2025 02:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1753153019;
	bh=G7jQ6vjBrqcdcBX+jOv7jqiqfBiR8qm0tzxZNdDuSaM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cH+vLsrVZoH4KqNu503CPJ9lIkgdrp545L9MHiaJl0W811QxEoe+jKilhKk4mVv4n
	 40cmLnuGhJFlmawaPAhz2jFRLSHh3XGH+QpeEdU61Pw/TzXGj37YgUZsoagBEPQJ9E
	 nc7QPywYP8zhtOHPLDIAUcuxbqkqiioHAQPNIFbY=
Date: Mon, 21 Jul 2025 19:56:58 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: SeongJae Park <sj@kernel.org>
Cc: Honggyu Kim <honggyu.kim@sk.com>, Hyeongtak Ji <hyeongtak.ji@sk.com>,
 damon@lists.linux.dev, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] mm/damon/ops-common: ignore migration request to
 invalid nodes
Message-Id: <20250721195658.935f5e2436045cc311575c9c@linux-foundation.org>
In-Reply-To: <20250720185822.1451-1-sj@kernel.org>
References: <20250720185822.1451-1-sj@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 20 Jul 2025 11:58:22 -0700 SeongJae Park <sj@kernel.org> wrote:

> damon_migrate_pages() try migration even if the target node is invalid.
> If users mistakenly make such invalid requests via
> DAMOS_MIGRATE_{HOT,COLD} action, below kernel BUG can happen.
> 
>     [ 7831.883495] BUG: unable to handle page fault for address: 0000000000001f48
>     [ 7831.884160] #PF: supervisor read access in kernel mode
>     [ 7831.884681] #PF: error_code(0x0000) - not-present page
>     [ 7831.885203] PGD 0 P4D 0
>     [ 7831.885468] Oops: Oops: 0000 [#1] SMP PTI
>     [ 7831.885852] CPU: 31 UID: 0 PID: 94202 Comm: kdamond.0 Not tainted 6.16.0-rc5-mm-new-damon+ #93 PREEMPT(voluntary)
>     [ 7831.886913] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-4.el9 04/01/2014
>     [ 7831.887777] RIP: 0010:__alloc_frozen_pages_noprof (include/linux/mmzone.h:1724 include/linux/mmzone.h:1750 mm/page_alloc.c:4936 mm/page_alloc.c:5137)
>     [...]
>     [ 7831.895953] Call Trace:
>     [ 7831.896195]  <TASK>
>     [ 7831.896397] __folio_alloc_noprof (mm/page_alloc.c:5183 mm/page_alloc.c:5192)
>     [ 7831.896787] migrate_pages_batch (mm/migrate.c:1189 mm/migrate.c:1851)
>     [ 7831.897228] ? __pfx_alloc_migration_target (mm/migrate.c:2137)
>     [ 7831.897735] migrate_pages (mm/migrate.c:2078)
>     [ 7831.898141] ? __pfx_alloc_migration_target (mm/migrate.c:2137)
>     [ 7831.898664] damon_migrate_folio_list (mm/damon/ops-common.c:321 mm/damon/ops-common.c:354)
>     [ 7831.899140] damon_migrate_pages (mm/damon/ops-common.c:405)
>     [...]
> 
> Add a target node validity check in damon_migrate_pages().  The validity
> check is stolen from that of do_pages_move(), which is being used for
> move_pages() system call.
> 
> Fixes: b51820ebea65 ("mm/damon/paddr: introduce DAMOS_MIGRATE_COLD action for demotion") # 6.11.x
> Cc: stable@vger.kernel.org
>
> ...
>
> --- a/mm/damon/ops-common.c
> +++ b/mm/damon/ops-common.c
> @@ -383,6 +383,10 @@ unsigned long damon_migrate_pages(struct list_head *folio_list, int target_nid)
>  	if (list_empty(folio_list))
>  		return nr_migrated;
>  
> +	if (target_nid < 0 || target_nid >= MAX_NUMNODES ||
> +			!node_state(target_nid, N_MEMORY))
> +		return nr_migrated;
> +
>  	noreclaim_flag = memalloc_noreclaim_save();
>  
>  	nid = folio_nid(lru_to_folio(folio_list));
> 

OK.  damon_migrate_pages() exists only in mm.git thanks to 13dde31db71f
("mm/damon: move migration helpers from paddr to ops-common").  I
assume that you'll send the -stable people a patch which adds this check into
damon_pa_migrate_pages() when called upon to do so.


