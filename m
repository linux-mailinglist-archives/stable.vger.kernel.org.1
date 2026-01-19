Return-Path: <stable+bounces-210253-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 172EAD39D3C
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 04:45:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 748A43006F6F
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 03:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D186331354D;
	Mon, 19 Jan 2026 03:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gwgkDOqH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8309F26A1B5;
	Mon, 19 Jan 2026 03:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768794307; cv=none; b=pQzLE5AVf1tzvGPd+figQU+Gd3QjgF5pg0Smbuyiui9gJ9mh4HcdBLQz2+xj1Js+DUc+xy7ThaYbyVWPtbbLGnMoCN8aqWpSx0MET8MCMJILUtE5M1fvwjX98IibKqBO2g8soX+6/Zp0r3HqpXxQrTlFB5eVjSNNuvTskPhVdXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768794307; c=relaxed/simple;
	bh=vJUyFP5PKvIHSLwRcVsSPUqjd7DJy7WczghqOwUYZXk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Vi45UJT1dX9RjTEXXN98kRY+V3XBAK7Md2rFDFwWY58auxVvC5A3yMWdgxTIkhuqm5BmeImA1wcX71UQZPz6h7zdMCG0Bh1dkQYrjtOpDbhGPjSEF7qeuskAJBsRPvq5MO/LQ99A6L/XlsY+l+t0oRLKagvEsMrWyuM3IUkHr84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=gwgkDOqH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E982C116C6;
	Mon, 19 Jan 2026 03:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1768794307;
	bh=vJUyFP5PKvIHSLwRcVsSPUqjd7DJy7WczghqOwUYZXk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gwgkDOqHKc7lGnCLYfkUbrhvqX1dmb1qTe4dTwu3+MM8KPgCAaNPunJSCWE/JoOLQ
	 fDMlV6P43pUzQvTyMTN1TnfboXvvZ61u+W6uouCw9AZkESYyONRxo+wtK6aSXuum0+
	 shA/jtt+8T3P2gwFXGm+nyGOFcpziPJjoyorKQqs=
Date: Sun, 18 Jan 2026 19:45:05 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org, Hugh Dickins <hughd@google.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Kemeng Shi <shikemeng@huaweicloud.com>,
 Nhat Pham <nphamcs@gmail.com>, Chris Li <chrisl@kernel.org>, Baoquan He
 <bhe@redhat.com>, Barry Song <baohua@kernel.org>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/shmem, swap: fix race of truncate and swap entry
 split
Message-Id: <20260118194505.e798b3ff59d7ee521dc2d58f@linux-foundation.org>
In-Reply-To: <CAMgjq7AA1LoLopoFrmRBh5KiL75VtBORfTaR2Lafq3OttD5cDQ@mail.gmail.com>
References: <20260119-shmem-swap-fix-v2-1-034c946fd393@tencent.com>
	<20260118113315.b102a7728769f05c5aeec57c@linux-foundation.org>
	<CAMgjq7AA1LoLopoFrmRBh5KiL75VtBORfTaR2Lafq3OttD5cDQ@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Jan 2026 10:17:50 +0800 Kairui Song <ryncsn@gmail.com> wrote:

> >
> > What tree was this prepared against?
> >
> > Both Linus mainline and mm.git have
> >
> > : static long shmem_free_swap(struct address_space *mapping,
> > :                           pgoff_t index, void *radswap)
> > : {
> > :       int order = xa_get_order(&mapping->i_pages, index);
> > :       void *old;
> > :
> > :       old = xa_cmpxchg_irq(&mapping->i_pages, index, radswap, NULL, 0);
> > :       if (old != radswap)
> > :               return 0;
> > :       free_swap_and_cache_nr(radix_to_swp_entry(radswap), 1 << order);
> > :
> > :       return 1 << order;
> > : }
> >
> > but that free_swap_and_cache_nr() call is absent from your tree.
> 
> Oh, I tested and sent this patch based on mm-unstable, because the bug
> was found while I was testing swap table series. This is a 2 year old
> existing bug though. Swapoff during high system pressure is not a very
> common thing, and maybe mTHP for shmem is currently not very commonly
> used either? So maybe that's why no one found this issue.
> 
> free_swap_and_cache_nr is renamed to swap_put_entries_direct in
> mm-unstable, it's irrelevant to this fix or bug. The rename change was
> made here:
> https://lore.kernel.org/linux-mm/20251220-swap-table-p2-v5-14-8862a265a033@tencent.com/
> 
> Should I resend this patch base on the mainline and rebase that
> series? Or should we merge this in mm-unstable first then I can
> send seperate fixes for stable?

I think a clean fix against Linus mainline, please.  Then let's take a
look at what's needed to repair any later problems.


