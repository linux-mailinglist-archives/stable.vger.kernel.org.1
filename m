Return-Path: <stable+bounces-93735-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DAC79D0612
	for <lists+stable@lfdr.de>; Sun, 17 Nov 2024 22:12:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9D8C282535
	for <lists+stable@lfdr.de>; Sun, 17 Nov 2024 21:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7B11DC1B7;
	Sun, 17 Nov 2024 21:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bFw6+02h"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716BA84A3E;
	Sun, 17 Nov 2024 21:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731877932; cv=none; b=Px8OEDmOxYk2Cf8gzwYdvArabN0rZi8BEfbfHOgoDyGvNdWx3eS2tWP6RKHw5SZmsnYJTBK9Ym8mobVPmI1Qp4ujojEYFPmZBnPlzy5tWk8WQAFYBv1UBTuP7rCwo0NjZibYB4aaeqNjVqUZ4sGxT9Z6sCkGuYnqa2pxRqqNqOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731877932; c=relaxed/simple;
	bh=HGRx4uxFKRJlW6uig3Endwi2UsrcK+2HJJC5CFseVrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BrPoF2oRx0NX4eP5tw8Gku8d+aadc4cZVauURTB+Zr+Rd8ptA3ByzvRnA4g5Fa/enNyryWSknw2DvjYb1yOqMDmWSDlJHhOueVdfQ/5LX7o7G+tkg/rBnk+todL/R2sVha58y/2kOqyDYmoXKlIPE6qfNJhZ+UHRd/5kxk9Q3pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bFw6+02h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BC9BC4CED2;
	Sun, 17 Nov 2024 21:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731877931;
	bh=HGRx4uxFKRJlW6uig3Endwi2UsrcK+2HJJC5CFseVrE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bFw6+02hlzEKV45miXHj2ui9OPScaDREt4GyBl7/aCQ9ze76Gd94XQtAwU2ANvV9x
	 kk+OCMLWdVKxIVrAYQqJClJWqZdADNAM0CVqPmYihslgNzNHqItAzi1iZS3EijE8JR
	 DF1VIfkwtbjMN49rU2grAFgmm8BMOyljCgNI47E0=
Date: Sun, 17 Nov 2024 22:11:47 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Xu <peterx@redhat.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>
Subject: Re: [PATCH 6.1.y 4/4] mm: resolve faulty mmap_region() error path
 behaviour
Message-ID: <2024111713-syndrome-impolite-d154@gregkh>
References: <cover.1731671441.git.lorenzo.stoakes@oracle.com>
 <4cb9b846f0c4efcc4a2b21453eea4e4d0136efc8.1731671441.git.lorenzo.stoakes@oracle.com>
 <2979df31-ce8c-4382-ab01-7e66f852099d@suse.cz>
 <01fbc3f2-bccb-4694-99ec-2ee8e9ff6e4e@lucifer.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01fbc3f2-bccb-4694-99ec-2ee8e9ff6e4e@lucifer.local>

On Fri, Nov 15, 2024 at 07:28:34PM +0000, Lorenzo Stoakes wrote:
> On Fri, Nov 15, 2024 at 08:06:05PM +0100, Vlastimil Babka wrote:
> > On 11/15/24 13:40, Lorenzo Stoakes wrote:
> > > [ Upstream commit 5de195060b2e251a835f622759550e6202167641 ]
> > >
> > > The mmap_region() function is somewhat terrifying, with spaghetti-like
> > > control flow and numerous means by which issues can arise and incomplete
> > > state, memory leaks and other unpleasantness can occur.
> > >
> > > A large amount of the complexity arises from trying to handle errors late
> > > in the process of mapping a VMA, which forms the basis of recently
> > > observed issues with resource leaks and observable inconsistent state.
> > >
> > > Taking advantage of previous patches in this series we move a number of
> > > checks earlier in the code, simplifying things by moving the core of the
> > > logic into a static internal function __mmap_region().
> > >
> > > Doing this allows us to perform a number of checks up front before we do
> > > any real work, and allows us to unwind the writable unmap check
> > > unconditionally as required and to perform a CONFIG_DEBUG_VM_MAPLE_TREE
> > > validation unconditionally also.
> > >
> > > We move a number of things here:
> > >
> > > 1. We preallocate memory for the iterator before we call the file-backed
> > >    memory hook, allowing us to exit early and avoid having to perform
> > >    complicated and error-prone close/free logic. We carefully free
> > >    iterator state on both success and error paths.
> > >
> > > 2. The enclosing mmap_region() function handles the mapping_map_writable()
> > >    logic early. Previously the logic had the mapping_map_writable() at the
> > >    point of mapping a newly allocated file-backed VMA, and a matching
> > >    mapping_unmap_writable() on success and error paths.
> > >
> > >    We now do this unconditionally if this is a file-backed, shared writable
> > >    mapping. If a driver changes the flags to eliminate VM_MAYWRITE, however
> > >    doing so does not invalidate the seal check we just performed, and we in
> > >    any case always decrement the counter in the wrapper.
> > >
> > >    We perform a debug assert to ensure a driver does not attempt to do the
> > >    opposite.
> > >
> > > 3. We also move arch_validate_flags() up into the mmap_region()
> > >    function. This is only relevant on arm64 and sparc64, and the check is
> > >    only meaningful for SPARC with ADI enabled. We explicitly add a warning
> > >    for this arch if a driver invalidates this check, though the code ought
> > >    eventually to be fixed to eliminate the need for this.
> > >
> > > With all of these measures in place, we no longer need to explicitly close
> > > the VMA on error paths, as we place all checks which might fail prior to a
> > > call to any driver mmap hook.
> > >
> > > This eliminates an entire class of errors, makes the code easier to reason
> > > about and more robust.
> > >
> > > Link: https://lkml.kernel.org/r/6e0becb36d2f5472053ac5d544c0edfe9b899e25.1730224667.git.lorenzo.stoakes@oracle.com
> > > Fixes: deb0f6562884 ("mm/mmap: undo ->mmap() when arch_validate_flags() fails")
> > > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > > Reported-by: Jann Horn <jannh@google.com>
> > > Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> > > Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> > > Tested-by: Mark Brown <broonie@kernel.org>
> > > Cc: Andreas Larsson <andreas@gaisler.com>
> > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > Cc: David S. Miller <davem@davemloft.net>
> > > Cc: Helge Deller <deller@gmx.de>
> > > Cc: James E.J. Bottomley <James.Bottomley@HansenPartnership.com>
> > > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > > Cc: Peter Xu <peterx@redhat.com>
> > > Cc: Will Deacon <will@kernel.org>
> > > Cc: <stable@vger.kernel.org>
> > > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> > > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > > ---
> > >  mm/mmap.c | 103 +++++++++++++++++++++++++++++-------------------------
> > >  1 file changed, 56 insertions(+), 47 deletions(-)
> > >
> > > diff --git a/mm/mmap.c b/mm/mmap.c
> > > index 322677f61d30..e457169c5cce 100644
> > > --- a/mm/mmap.c
> > > +++ b/mm/mmap.c
> > > @@ -2652,7 +2652,7 @@ int do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
> > >  	return do_mas_munmap(&mas, mm, start, len, uf, false);
> > >  }
> > >
> > > -unsigned long mmap_region(struct file *file, unsigned long addr,
> > > +static unsigned long __mmap_region(struct file *file, unsigned long addr,
> > >  		unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
> > >  		struct list_head *uf)
> > >  {
> > > @@ -2750,26 +2750,28 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> > >  	vma->vm_page_prot = vm_get_page_prot(vm_flags);
> > >  	vma->vm_pgoff = pgoff;
> > >
> > > -	if (file) {
> > > -		if (vm_flags & VM_SHARED) {
> > > -			error = mapping_map_writable(file->f_mapping);
> > > -			if (error)
> > > -				goto free_vma;
> > > -		}
> > > +	if (mas_preallocate(&mas, vma, GFP_KERNEL)) {
> > > +		error = -ENOMEM;
> > > +		goto free_vma;
> > > +	}
> > >
> > > +	if (file) {
> > >  		vma->vm_file = get_file(file);
> > >  		error = mmap_file(file, vma);
> > >  		if (error)
> > > -			goto unmap_and_free_vma;
> > > +			goto unmap_and_free_file_vma;
> > > +
> > > +		/* Drivers cannot alter the address of the VMA. */
> > > +		WARN_ON_ONCE(addr != vma->vm_start);
> > >
> > >  		/*
> > > -		 * Expansion is handled above, merging is handled below.
> > > -		 * Drivers should not alter the address of the VMA.
> > > +		 * Drivers should not permit writability when previously it was
> > > +		 * disallowed.
> > >  		 */
> > > -		if (WARN_ON((addr != vma->vm_start))) {
> > > -			error = -EINVAL;
> > > -			goto close_and_free_vma;
> > > -		}
> > > +		VM_WARN_ON_ONCE(vm_flags != vma->vm_flags &&
> > > +				!(vm_flags & VM_MAYWRITE) &&
> > > +				(vma->vm_flags & VM_MAYWRITE));
> > > +
> > >  		mas_reset(&mas);
> > >
> > >  		/*
> > > @@ -2792,7 +2794,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> > >  				vma = merge;
> > >  				/* Update vm_flags to pick up the change. */
> > >  				vm_flags = vma->vm_flags;
> 
> As far as I can tell we should add:
> 
> +				mas_destroy(&mas);
> 
> > > -				goto unmap_writable;
> > > +				goto file_expanded;
> >
> > I think we might need a mas_destroy() somewhere around here otherwise we
> > leak the prealloc? In later versions the merge operation takes our vma
> > iterator so it handles that if merge succeeds, but here we have to cleanup
> > our mas ourselves?
> >
> 
> Sigh, yup. This code path is SO HORRIBLE. I think simply a
> mas_destroy(&mas) here would suffice (see above).
> 
> I'm not sure how anything works with stable, I mean do we need to respin a
> v2 just for one line?

How else am I supposed to take a working patch that has actually been
tested?  I can't hand-edit this...

thanks,

greg k-h

