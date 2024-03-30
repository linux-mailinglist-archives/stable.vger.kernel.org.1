Return-Path: <stable+bounces-33803-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 895B68929F7
	for <lists+stable@lfdr.de>; Sat, 30 Mar 2024 10:16:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F2CC1F21B8F
	for <lists+stable@lfdr.de>; Sat, 30 Mar 2024 09:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E4CBE6D;
	Sat, 30 Mar 2024 09:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EW8qlZmK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B503C2C
	for <stable@vger.kernel.org>; Sat, 30 Mar 2024 09:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711790196; cv=none; b=eaf+U1118lkHnvnMd7RuTU6h4PNARaWWaQXaRDrrUet0rldgCAAiZdTVodQvEfPIg+aMIPfyPeIeJlzRVTRTzHQ/8etCIAHyMoWvPDMHlr6R3F0PjFTRUi9Tj3gyVhfaRtkDhFcsMCITtY+Co5P/5Zsjpwa3mMRNsKxpBZKpKJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711790196; c=relaxed/simple;
	bh=p7IQwXgdmSvNeGE0lgYdvZsmVCtEOjxj54T6NflUYfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mWvU6Wnphr87M7MIO5IXApST9WJqSFszp4AUVORKoHvNomH5VJkSVhm7/HbYYRYYRWkWUCUf8SJfc/3zYBgOS3Bj1dz48NbE7MS9sMgNb3oBSkucmw3qAWFgaG2uvmjfW7QW7oET58Es49VvnOAFZ/5jiH8eTrFH03u00t2GSXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EW8qlZmK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74C26C433F1;
	Sat, 30 Mar 2024 09:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711790195;
	bh=p7IQwXgdmSvNeGE0lgYdvZsmVCtEOjxj54T6NflUYfk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EW8qlZmK27kLUWipiBr/AjZwaGDKpcaT5Qht1vlSYnfXQFUzokgxu9WZklObw+3Pk
	 Gn6I7MCp/O9COzzdbnS0GmaQspbUxmPcdwbeL7KzqScsMRepzieyOf7+fExIiztzEG
	 E08L0MLZBa6N1m4ETdtvcoQdzZT4GpJe5WpkPLas=
Date: Sat, 30 Mar 2024 10:16:32 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Zi Yan <ziy@nvidia.com>
Cc: stable@vger.kernel.org, linux-mm@kvack.org,
	Charan Teja Kalla <quic_charante@quicinc.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Huang Ying <ying.huang@intel.com>,
	Naoya Horiguchi <naoya.horiguchi@linux.dev>
Subject: Re: [PATCH STABLE v4.19.y] mm/migrate: set swap entry values of THP
 tail pages properly.
Message-ID: <2024033024-degrease-untried-0594@gregkh>
References: <20240306155052.118007-1-zi.yan@sent.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306155052.118007-1-zi.yan@sent.com>

On Wed, Mar 06, 2024 at 10:50:52AM -0500, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> The tail pages in a THP can have swap entry information stored in their
> private field. When migrating to a new page, all tail pages of the new
> page need to update ->private to avoid future data corruption.
> 
> This fix is stable-only, since after commit 07e09c483cbe ("mm/huge_memory:
> work on folio->swap instead of page->private when splitting folio"),
> subpages of a swapcached THP no longer requires the maintenance.
> 
> Adding THPs to the swapcache was introduced in commit
> 38d8b4e6bdc87 ("mm, THP, swap: delay splitting THP during swap out"),
> where each subpage of a THP added to the swapcache had its own swapcache
> entry and required the ->private field to point to the correct swapcache
> entry. Later, when THP migration functionality was implemented in commit
> 616b8371539a6 ("mm: thp: enable thp migration in generic path"),
> it initially did not handle the subpages of swapcached THPs, failing to
> update their ->private fields or replace the subpage pointers in the
> swapcache. Subsequently, commit e71769ae5260 ("mm: enable thp migration
> for shmem thp") addressed the swapcache update aspect. This patch fixes
> the update of subpage ->private fields.
> 
> Closes: https://lore.kernel.org/linux-mm/1707814102-22682-1-git-send-email-quic_charante@quicinc.com/
> Fixes: 616b8371539a ("mm: thp: enable thp migration in generic path")
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/migrate.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 171573613c39..893ea04498f7 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -514,8 +514,12 @@ int migrate_page_move_mapping(struct address_space *mapping,
>  	if (PageSwapBacked(page)) {
>  		__SetPageSwapBacked(newpage);
>  		if (PageSwapCache(page)) {
> +			int i;
> +
>  			SetPageSwapCache(newpage);
> -			set_page_private(newpage, page_private(page));
> +			for (i = 0; i < (1 << compound_order(page)); i++)
> +				set_page_private(newpage + i,
> +						 page_private(page + i));
>  		}
>  	} else {
>  		VM_BUG_ON_PAGE(PageSwapCache(page), page);
> -- 
> 2.43.0
> 
> 

All now queued up, thanks.

greg k-h

