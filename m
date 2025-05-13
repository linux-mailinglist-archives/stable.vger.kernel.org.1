Return-Path: <stable+bounces-144128-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 499D5AB4DC6
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 10:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBF483A9CF3
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 08:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F1E1F5851;
	Tue, 13 May 2025 08:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M191mfSl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D171F5437;
	Tue, 13 May 2025 08:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747124017; cv=none; b=P3y3pqhNV+uS7lHBEjCpc5YuNTy3k0oghsJQ1WWNQbVh3jzCQ7qeA78PRLUhtvrhAEWuI2+ws3gS4WJLmgZrexWW3LI2arqjCCC6NMhgVnqP1lMcs4plsNNBnqUKsln0xw/8brc5vyYSlFgdjGl86HNc/xPuUj4VZzP7L2qJ4yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747124017; c=relaxed/simple;
	bh=Mwh1s3J/QlJ5abc37Djl6zBNsK2uQwu2dEU0uyMbhmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IA51F8Xr2XwfeFXJ9zNXtn5fJ+g272x4qJOfZU/YIxw1KKgxTGmczpXqbZuY6Ca33aTXzQ1oOpchVRNZxpN5AlJ5x2LUZej2IeIskOUoKwiXGM1wyLQOCaR6WgGjr7yZJ1E0NcQOs3XJJVIKBBuY1u71VQAFWuriUCvPItYjgzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M191mfSl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D22BC4CEE4;
	Tue, 13 May 2025 08:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747124017;
	bh=Mwh1s3J/QlJ5abc37Djl6zBNsK2uQwu2dEU0uyMbhmU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M191mfSlUYye565pDWRi7KtWiFLZ0eHZO9/+12sSmNezDaVIQap99TbC4xJwYbk2/
	 pU5fVCzyI/3rjgSq+JPjkxAUVly7keWTVuMnQ1mdzoiYrXzErYty0TcN0jLPNGnRai
	 G9C9c2jp5cIZGsMpqfHPT7zIEZguQ9jySKGQvwR4=
Date: Tue, 13 May 2025 10:11:49 +0200
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
Message-ID: <2025051322-aftermost-puritan-fd62@gregkh>
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

Because "Fixes:" never means that it will be backported.  Please read
the stable documentation for what needs to be added to ensure that.

thanks,

greg k-h

