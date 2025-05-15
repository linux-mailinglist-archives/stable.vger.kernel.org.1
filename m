Return-Path: <stable+bounces-144534-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3678AB87CB
	for <lists+stable@lfdr.de>; Thu, 15 May 2025 15:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DB0D7AFA76
	for <lists+stable@lfdr.de>; Thu, 15 May 2025 13:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9EB224D7;
	Thu, 15 May 2025 13:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ULXEX8Kv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E100221348;
	Thu, 15 May 2025 13:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747315267; cv=none; b=D0UwC92HgP64VEQeN4kpLR7zxLTyoG5TlQISgZOgXcEscexWYC8yVzZA9YFrmec9HdH+b322ydgX71hWNwsATYb9o3N5oK/XN0hm948fxksH43Gd2Y32NtbZb50/h3ve+7f+Bh/UhDtenAshva7fTyt31Vx76mUDWXZheV7KcFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747315267; c=relaxed/simple;
	bh=JPkYbeCC/0+2C7oAcLkVgxvwJCw1QU+wPgbrczN6A7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NXbELUT4/K71cMjdb+ZSj333H0bxoYO1lquNBuhQdSzTyCsgHxlt0i41FhitytDYJYnp7hAWWBbxUPD/K0ghDynOhQh8YmO8d+Bb/RxN99wDtTxJev634q1bemwSxAXcrf/+coQkQZYvLLu9VyyN+cfs+zo1yQdj495qtciSFi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ULXEX8Kv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9334CC4CEEF;
	Thu, 15 May 2025 13:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747315266;
	bh=JPkYbeCC/0+2C7oAcLkVgxvwJCw1QU+wPgbrczN6A7U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ULXEX8KvfmKzhiJTB9Hd7eAwANfC1BZlgWUM6t1hJ0bRn630MAm6VurvIy9r8jpMv
	 P8420bwYR5nxut2GfVXVQDFMKw37eb5L9zAC+Lvc2MjADIccHILfOZidJCg4zVrg9d
	 ztlRyJp81Y8h9GJBQ8F7MtMW/l5FFlq2R6LHEytAK8hJO4D52qmjNYozDkFgO5xZTU
	 7XpeOkZCSYTjUvUkUIch2iogvEw/HV/kp2nPW8sWvO38mtWsKti/L661hX7Bdi/18x
	 p0vUB79T0gzxVtl8orIGPgtsS0rbb95U71ta/kVU9w0UWbwMMSBU2H25ROQ1jxHDHR
	 GX1Ig7sE95TZw==
Date: Thu, 15 May 2025 14:21:01 +0100
From: Will Deacon <will@kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: Dev Jain <dev.jain@arm.com>, catalin.marinas@arm.com,
	ryan.roberts@arm.com, anshuman.khandual@arm.com,
	mark.rutland@arm.com, yang@os.amperecomputing.com,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] arm64: Check pxd_leaf() instead of !pxd_table() while
 tearing down page tables
Message-ID: <20250515132059.GA12038@willie-the-truck>
References: <20250515063450.86629-1-dev.jain@arm.com>
 <332ecda7-14c4-4dc3-aeff-26801b74ca04@redhat.com>
 <4904d02f-6595-4230-a321-23327596e085@arm.com>
 <6fe7848c-485e-4639-b65c-200ed6abe119@redhat.com>
 <35ef7691-7eac-4efa-838d-c504c88c042b@arm.com>
 <c06930f0-f98c-4089-aa33-6789b95fd08f@redhat.com>
 <91fc96c3-4931-4f07-a0a9-507ac7b5ae6d@arm.com>
 <a005b0c3-861f-4e73-a747-91e0a15c85de@redhat.com>
 <20250515125606.GA11878@willie-the-truck>
 <23042cdf-e0fc-4b3a-92f6-688689728cc7@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <23042cdf-e0fc-4b3a-92f6-688689728cc7@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, May 15, 2025 at 03:04:50PM +0200, David Hildenbrand wrote:
> On 15.05.25 14:56, Will Deacon wrote:
> > On Thu, May 15, 2025 at 11:32:22AM +0200, David Hildenbrand wrote:
> > > On 15.05.25 11:27, Dev Jain wrote:
> > > > 
> > > > 
> > > > On 15/05/25 2:23 pm, David Hildenbrand wrote:
> > > > > On 15.05.25 10:47, Dev Jain wrote:
> > > > > > 
> > > > > > 
> > > > > > On 15/05/25 2:06 pm, David Hildenbrand wrote:
> > > > > > > On 15.05.25 10:22, Dev Jain wrote:
> > > > > > > > 
> > > > > > > > 
> > > > > > > > On 15/05/25 1:43 pm, David Hildenbrand wrote:
> > > > > > > > > On 15.05.25 08:34, Dev Jain wrote:
> > > > > > > > > > Commit 9c006972c3fe removes the pxd_present() checks because the
> > > > > > > > > > caller
> > > > > > > > > > checks pxd_present(). But, in case of vmap_try_huge_pud(), the caller
> > > > > > > > > > only
> > > > > > > > > > checks pud_present(); pud_free_pmd_page() recurses on each pmd
> > > > > > > > > > through
> > > > > > > > > > pmd_free_pte_page(), wherein the pmd may be none.
> > > > > > > > > The commit states: "The core code already has a check for pXd_none()",
> > > > > > > > > so I assume that assumption was not true in all cases?
> > > > > > > > > 
> > > > > > > > > Should that one problematic caller then check for pmd_none() instead?
> > > > > > > > 
> > > > > > > >      From what I could gather of Will's commit message, my
> > > > > > > > interpretation is
> > > > > > > > that the concerned callers are vmap_try_huge_pud and vmap_try_huge_pmd.
> > > > > > > > These individually check for pxd_present():
> > > > > > > > 
> > > > > > > > if (pmd_present(*pmd) && !pmd_free_pte_page(pmd, addr))
> > > > > > > >        return 0;
> > > > > > > > 
> > > > > > > > The problem is that vmap_try_huge_pud will also iterate on pte entries.
> > > > > > > > So if the pud is present, then pud_free_pmd_page -> pmd_free_pte_page
> > > > > > > > may encounter a none pmd and trigger a WARN.
> > > > > > > 
> > > > > > > Yeah, pud_free_pmd_page()->pmd_free_pte_page() looks shaky.
> > > > > > > 
> > > > > > > I assume we should either have an explicit pmd_none() check in
> > > > > > > pud_free_pmd_page() before calling pmd_free_pte_page(), or one in
> > > > > > > pmd_free_pte_page().
> > > > > > > 
> > > > > > > With your patch, we'd be calling pte_free_kernel() on a NULL pointer,
> > > > > > > which sounds wrong -- unless I am missing something important.
> > > > > > 
> > > > > > Ah thanks, you seem to be right. We will be extracting table from a none
> > > > > > pmd. Perhaps we should still bail out for !pxd_present() but without the
> > > > > > warning, which the fix commit used to do.
> > > > > 
> > > > > Right. We just make sure that all callers of pmd_free_pte_page() already
> > > > > check for it.
> > > > > 
> > > > > I'd just do something like:
> > > > > 
> > > > > diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> > > > > index 8fcf59ba39db7..e98dd7af147d5 100644
> > > > > --- a/arch/arm64/mm/mmu.c
> > > > > +++ b/arch/arm64/mm/mmu.c
> > > > > @@ -1274,10 +1274,8 @@ int pmd_free_pte_page(pmd_t *pmdp, unsigned long
> > > > > addr)
> > > > > 
> > > > >            pmd = READ_ONCE(*pmdp);
> > > > > 
> > > > > -       if (!pmd_table(pmd)) {
> > > > > -               VM_WARN_ON(1);
> > > > > -               return 1;
> > > > > -       }
> > > > > +       VM_WARN_ON(!pmd_present(pmd));
> > > > > +       VM_WARN_ON(!pmd_table(pmd));
> > > > 
> > > > And also return 1?
> > > 
> > > I'll leave that to Catalin + Will.
> > > 
> > > I'm not a friend for adding runtime-overhead for soemthing that should not
> > > happen and be caught early during testing -> VM_WARN_ON_ONCE().
> > 
> > I definitely think we should return early if the pmd isn't a table.
> > Otherwise, we could end up descending into God-knows-what!
> 
> The question is: how did something that is not a table end up here, and why
> is it valid to check exactly that at runtime. Not strong opinion, it just
> feels a bit arbitrary to test for exactly that at runtime if it is
> completely unexpected.

I see it a little bit like type-checking: we could see an invalid entry,
a leaf entry or a table entry and we should only ever dereference the
latter. If the VM_WARN_ON() is justified, then I find it jarring to go
ahead with the dereference regardless of the type.

That said, maybe the VM_WARN_ON() should either be deleted or moved out
to the callers in mm/vmalloc.c?

Will

