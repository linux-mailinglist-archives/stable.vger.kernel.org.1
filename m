Return-Path: <stable+bounces-144131-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04046AB4DCE
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 10:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A1E616DB2A
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 08:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE11C1F758F;
	Tue, 13 May 2025 08:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QNGZxHuR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992281F5852;
	Tue, 13 May 2025 08:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747124047; cv=none; b=l70iyH4swDsk8zVMmz46mK9vAsJMrCctkopDqN29k1Af1KK8jeMiFijoTC+2zx0kBKngpa2a6EOAHFiWSTnim3PPU8eZ8YHyOuLWfLmoXrjiYx2aqY8FW6LuEpgkl6T0ZFYp4Zbw0Z10noEN4LY801Jaymwv7Jc9w9zqD9b+hf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747124047; c=relaxed/simple;
	bh=26IiAqbmMHKsMOG0VsCvTwEtkr15o+63YPLSytMkTO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rphDdV9zc4WhQHxjmajlCY4xQEBh2ZxhkH1YhMU3JjdPjGrTlEdxmzETs32OIJpqufKwkfxuyUAy7kjgtL7uDpAIeBJXSexiSmfcSF1e9eyAGdloKFk29p5QI32lZy22L8kV5cp6u13Ardv9YXbTvKBUgIPyvcg1c6huc6NBFrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QNGZxHuR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF20DC4CEE4;
	Tue, 13 May 2025 08:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747124047;
	bh=26IiAqbmMHKsMOG0VsCvTwEtkr15o+63YPLSytMkTO4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QNGZxHuRUYkHldgS3NbCCXOrIksnTTv4/FUHNiboXTNexY15fr8soEo0wnDDCvXFr
	 yQxQi+ZFw1o0eYI3Ch6eo9HY+zjP9XLlzJ8w6Bq+s/wNxT3X+hdpSgu5QNQL6f6Pa2
	 GewQstdH0tO582Ti4CpnmNIY3Tk/D3AbKNMOgGfo=
Date: Tue, 13 May 2025 10:12:20 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Sasha Levin <sashal@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>, stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	loongarch@lists.linux.dev, Zi Yan <ziy@nvidia.com>,
	Huang Ying <ying.huang@intel.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH for 6.6] mm/migrate: correct nr_failed in
 migrate_pages_sync()
Message-ID: <2025051311-retaining-subtract-20c9@gregkh>
References: <20250513080521.252543-1-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250513080521.252543-1-chenhuacai@loongson.cn>

On Tue, May 13, 2025 at 04:05:21PM +0800, Huacai Chen wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> nr_failed was missing the large folio splits from migrate_pages_batch()
> and can cause a mismatch between migrate_pages() return value and the
> number of not migrated pages, i.e., when the return value of
> migrate_pages() is 0, there are still pages left in the from page list.
> It will happen when a non-PMD THP large folio fails to migrate due to
> -ENOMEM and is split successfully but not all the split pages are not
> migrated, migrate_pages_batch() would return non-zero, but
> astats.nr_thp_split = 0.  nr_failed would be 0 and returned to the caller
> of migrate_pages(), but the not migrated pages are left in the from page
> list without being added back to LRU lists.
> 
> Fix it by adding a new nr_split counter for large folio splits and adding
> it to nr_failed in migrate_page_sync() after migrate_pages_batch() is
> done.
> 
> Link: https://lkml.kernel.org/r/20231017163129.2025214-1-zi.yan@sent.com
> Fixes: 2ef7dbb26990 ("migrate_pages: try migrate in batch asynchronously firstly")
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> Acked-by: Huang Ying <ying.huang@intel.com>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
> This patch has a Fixes tag and should be backported to 6.6, I don't know
> why hasn't bakported.
> 

What is the upstream git id for this commit?

