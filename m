Return-Path: <stable+bounces-93740-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E2E9D0641
	for <lists+stable@lfdr.de>; Sun, 17 Nov 2024 22:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 260E7B219DE
	for <lists+stable@lfdr.de>; Sun, 17 Nov 2024 21:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3DE1DDA32;
	Sun, 17 Nov 2024 21:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Rhm3AUdJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7932E1DD86E
	for <stable@vger.kernel.org>; Sun, 17 Nov 2024 21:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731878766; cv=none; b=BKmkDWmOpCv6MgIgS746ZE44+OJDw5w4ssP1207o0GTwxc7fikSQGixazopfx8lw8TU2Q/Hk78ITXkZ4kQWG9xC53/ucMblc/RYMwxRVRJ3EEXMvb6IJUxDEdOi/fYSnIYFH5n8HssSe1fiFc+saia14pL0+LT/+2iPnw4gtzpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731878766; c=relaxed/simple;
	bh=G/ZM5CC2iyTItFlVPz/EibI2BlVxpc3hGFUx457ZRi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A6Tsi/2QdA4P3FYGywgSEjoo83m3OkvghY1dLaOviyGU41cfTZydvGV/r/jqt8GZFaLe3aXp0F1HI2vu4wcSucm5mfgQg4Hlx66Gaow2+NttviD1oONIoB7J1366tThWCywVoRFJr9UqNrP/mxb30A/+a/OMTuvGd4KmecL25QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Rhm3AUdJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4841FC4CECD;
	Sun, 17 Nov 2024 21:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731878765;
	bh=G/ZM5CC2iyTItFlVPz/EibI2BlVxpc3hGFUx457ZRi8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rhm3AUdJ6rzQLyEL1vfD9Jo5baFaVAWteG5VNpgk82ajbr9hdtr6joigYnAz1fPQM
	 Jno8VY972jBSMjfl+Y5jo7ov6TC/pxhqkV05PAvUxfmRmso44fNYkbeBSd5O2lPTfx
	 8gZtykKsUTlkuyjIF3/mTlDS4TZwefn1+FRXYZN8=
Date: Sun, 17 Nov 2024 22:25:41 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: John Hubbard <jhubbard@nvidia.com>
Cc: airlied@redhat.com, akpm@linux-foundation.org, arnd@arndb.de,
	daniel.vetter@ffwll.ch, david@redhat.com, dongwon.kim@intel.com,
	hch@infradead.org, hughd@google.com, jgg@nvidia.com,
	junxiao.chang@intel.com, kraxel@redhat.com, osalvador@suse.de,
	peterx@redhat.com, stable@vger.kernel.org,
	vivek.kasireddy@intel.com, willy@infradead.org
Subject: Re: FAILED: patch "[PATCH] mm/gup: avoid an unnecessary allocation
 call for" failed to apply to 6.11-stable tree
Message-ID: <2024111722-humped-untamed-d299@gregkh>
References: <2024111754-stamina-flyer-1e05@gregkh>
 <b79ed291-ad60-4be7-a2c2-19fedfde74c7@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b79ed291-ad60-4be7-a2c2-19fedfde74c7@nvidia.com>

On Sun, Nov 17, 2024 at 01:19:09PM -0800, John Hubbard wrote:
> On 11/17/24 12:33 PM, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 6.11-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> > 
> > To reproduce the conflict and resubmit, you may use the following commands:
> > 
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.11.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x 94efde1d15399f5c88e576923db9bcd422d217f2
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024111754-stamina-flyer-1e05@gregkh' --subject-prefix 'PATCH 6.11.y' HEAD^..
> > 
> 
> It seems that the last hunk didn't apply because it was just too far away,
> as far as I can tell. I've manually applied it, resulting in the same diffs
> as the original, and did a quick smoke test (boot and ran mm tests).
> 
> Here's the updated version for 6.11.y:
> 
> From: John Hubbard <jhubbard@nvidia.com>
> Date: Sun, 17 Nov 2024 13:08:00 -0800
> Subject: [PATCH] mm/gup: avoid an unnecessary allocation call for
>  FOLL_LONGTERM cases
> X-NVConfidentiality: public
> Cc: John Hubbard <jhubbard@nvidia.com>
> 
> commit 53ba78de064b ("mm/gup: introduce
> check_and_migrate_movable_folios()") created a new constraint on the
> pin_user_pages*() API family: a potentially large internal allocation must
> now occur, for FOLL_LONGTERM cases.
> 
> A user-visible consequence has now appeared: user space can no longer pin
> more than 2GB of memory anymore on x86_64.  That's because, on a 4KB
> PAGE_SIZE system, when user space tries to (indirectly, via a device
> driver that calls pin_user_pages()) pin 2GB, this requires an allocation
> of a folio pointers array of MAX_PAGE_ORDER size, which is the limit for
> kmalloc().
> 
> In addition to the directly visible effect described above, there is also
> the problem of adding an unnecessary allocation.  The **pages array
> argument has already been allocated, and there is no need for a redundant
> **folios array allocation in this case.
> 
> Fix this by avoiding the new allocation entirely.  This is done by
> referring to either the original page[i] within **pages, or to the
> associated folio.  Thanks to David Hildenbrand for suggesting this
> approach and for providing the initial implementation (which I've tested
> and adjusted slightly) as well.
> 
> [jhubbard@nvidia.com]: tweaked the patch to apply to linux-stable/6.11.y
> [jhubbard@nvidia.com: whitespace tweak, per David]
>   Link:
> https://lkml.kernel.org/r/131cf9c8-ebc0-4cbb-b722-22fa8527bf3c@nvidia.com
> [jhubbard@nvidia.com: bypass pofs_get_folio(), per Oscar]
>   Link:
> https://lkml.kernel.org/r/c1587c7f-9155-45be-bd62-1e36c0dd6923@nvidia.com
> Link: https://lkml.kernel.org/r/20241105032944.141488-2-jhubbard@nvidia.com
> Fixes: 53ba78de064b ("mm/gup: introduce check_and_migrate_movable_folios()")
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
> Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
> Cc: Dave Airlie <airlied@redhat.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Jason Gunthorpe <jgg@nvidia.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Dongwon Kim <dongwon.kim@intel.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Junxiao Chang <junxiao.chang@intel.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
>  mm/gup.c | 114 +++++++++++++++++++++++++++++++++++++------------------
>  1 file changed, 77 insertions(+), 37 deletions(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index 947881ff5e8f..fd3d7900c24b 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -2282,20 +2282,57 @@ struct page *get_dump_page(unsigned long addr)
>  #endif /* CONFIG_ELF_CORE */
> 
>  #ifdef CONFIG_MIGRATION
> +
> +/*
> + * An array of either pages or folios ("pofs"). Although it may seem
> tempting to
> + * avoid this complication, by simply interpreting a list of folios as a
> list of
> + * pages, that approach won't work in the longer term, because eventually
> the
> + * layouts of struct page and struct folio will become completely
> different.
> + * Furthermore, this pof approach avoids excessive page_folio() calls.

Patch is line-wrapped :(

Can you resend it in a format I can apply it in?

thanks,

greg k-h

