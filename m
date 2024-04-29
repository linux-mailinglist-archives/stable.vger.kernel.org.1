Return-Path: <stable+bounces-41737-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD6A68B5B11
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 16:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BAE11F21815
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 14:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49C876413;
	Mon, 29 Apr 2024 14:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RYp+LqRd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9292C9468
	for <stable@vger.kernel.org>; Mon, 29 Apr 2024 14:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714400242; cv=none; b=RygMNmmcplOBUlEWCCUstLhFbWVzOw+PkzoDMUGYqCKABrGwWykbaEjFRN3yTooDuGYAshceu28qEXcb7ctT2OWhGBfPdUZ2cBiNmZmUc6cnK4wmoK5jPXu8UalxTfhk+YTS4KIj33x7rtV9qaSEE3dud6bhSHhNga7dH7GqTyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714400242; c=relaxed/simple;
	bh=s7C2TDdaDu4E3lKD0UFdkpBpFkCcrQqtC6Y27CBLxl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z/hAfBfWfxUMXTure61GGC9CBsuNeM5Ih/39EteRdJH/AE2nxjFLvAm3luacfYK2jxKMGvluPeLYCGj3xyVUq6EoyerNPuLzNMfuBZC5uvg7gejqq6C51aWUeHQsALE0Wiq+ioJKc8nNmHC+dhOy1xoX+ggOyx41Z9fRi0FgeYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RYp+LqRd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91E5BC113CD;
	Mon, 29 Apr 2024 14:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714400242;
	bh=s7C2TDdaDu4E3lKD0UFdkpBpFkCcrQqtC6Y27CBLxl8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RYp+LqRdO5SOOueVmart0J6wvjDzCt4zCQ8XdNqgvJtJy1dC3HAWh3QWvFIeDTgUA
	 rB/Cc04BpYIxusBmJY5wbbHyp/JzzfOWT3X9rJ9PaPCtV5JwXehK2kinibAWZmywBR
	 u8BDFp5P8FA7LE1r9ZW+I1wfS5FTyHEZNlNcp0rM=
Date: Mon, 29 Apr 2024 16:17:18 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: stable@vger.kernel.org, David Hildenbrand <david@redhat.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.8.y] mm: turn folio_test_hugetlb into a PageType
Message-ID: <2024042906-salami-steep-5022@gregkh>
References: <2024042907-unquote-thank-8de2@gregkh>
 <20240429125519.2970760-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429125519.2970760-1-willy@infradead.org>

On Mon, Apr 29, 2024 at 01:55:19PM +0100, Matthew Wilcox (Oracle) wrote:
> The current folio_test_hugetlb() can be fooled by a concurrent folio split
> into returning true for a folio which has never belonged to hugetlbfs.
> This can't happen if the caller holds a refcount on it, but we have a few
> places (memory-failure, compaction, procfs) which do not and should not
> take a speculative reference.
> 
> Since hugetlb pages do not use individual page mapcounts (they are always
> fully mapped and use the entire_mapcount field to record the number of
> mappings), the PageType field is available now that page_mapcount()
> ignores the value in this field.
> 
> In compaction and with CONFIG_DEBUG_VM enabled, the current implementation
> can result in an oops, as reported by Luis. This happens since 9c5ccf2db04b
> ("mm: remove HUGETLB_PAGE_DTOR") effectively added some VM_BUG_ON() checks
> in the PageHuge() testing path.
> 
> [willy@infradead.org: update vmcoreinfo]
>   Link: https://lkml.kernel.org/r/ZgGZUvsdhaT1Va-T@casper.infradead.org
> Link: https://lkml.kernel.org/r/20240321142448.1645400-6-willy@infradead.org
> Fixes: 9c5ccf2db04b ("mm: remove HUGETLB_PAGE_DTOR")
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Reported-by: Luis Chamberlain <mcgrof@kernel.org>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218227
> Cc: Miaohe Lin <linmiaohe@huawei.com>
> Cc: Muchun Song <muchun.song@linux.dev>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> (cherry picked from commit d99e3140a4d33e26066183ff727d8f02f56bec64)

Both backports now queued up, thanks.

greg k-h

