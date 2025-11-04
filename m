Return-Path: <stable+bounces-192382-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 739D5C31192
	for <lists+stable@lfdr.de>; Tue, 04 Nov 2025 13:59:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D46613B762A
	for <lists+stable@lfdr.de>; Tue,  4 Nov 2025 12:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6832ECEB9;
	Tue,  4 Nov 2025 12:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Es8m/lqo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBF02EC57D;
	Tue,  4 Nov 2025 12:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762261016; cv=none; b=mU3UxGNykCH2Wd99ltqR9QnFgwmN2es8ybulxs/KTaosp0e3HZLZkFN46yitlxR6aMjW21Y/rTC1Yc2X6ULtR8zPTGR+pweeVkNuPourU9ujnrhs/pDRcEhsO/XaQQUThOtJCUWjwnf9xYw5epi113T9CnjatubiZXGGJSWENFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762261016; c=relaxed/simple;
	bh=yAg+tERBdKRNZ0IdDqAnoxM1iraHSr76qEFW7dj6LJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jPciOXpYTRzJeWa06k/bJAjYKcBszL+p8O/Rm+j16+T9WTUrpaga3iWBi1eojAvrxJ0TwGMIDNn7BChp9tLlK595Td3d9EAziqhO6uyu9lJbARXnWQN+p/sOzvdiY0xoo9/5p5U63yYusRxKAb+5ACHkS8LFfxok2wcT73mDskg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Es8m/lqo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E155C4CEF7;
	Tue,  4 Nov 2025 12:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762261016;
	bh=yAg+tERBdKRNZ0IdDqAnoxM1iraHSr76qEFW7dj6LJg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Es8m/lqo2xcbXfmgYsqaTaqqFIhG5CbL7Oqmhluokzz/4BxSWfZEirw6fJWpiEhsE
	 N4UHDU0C1opIC9ZssXXZmoBYUNkUr9+K6ROAep/F8uN/ggAIO2K6m+oEU2aGikhqhl
	 AhGyS4W5ARQuJDyh4mDnkWUALqVXgy4dUBVk6HP+AupdeG1/VKltnHNL7fKQX2JW5C
	 rDPK1rWrh2uA6ZeohkTHDngog6mN0TimA+8D472DY64h8mzsOOBo7UkZOtDr+AqgEA
	 5E7ChlbG2xpJQqtSCTg3bKfhB0YRfQ5Ji2AKP+BjZsHFB4trPVsM8+lgkPRdE4tr01
	 GuorBXLEmJrzA==
Date: Tue, 4 Nov 2025 12:56:51 +0000
From: Will Deacon <will@kernel.org>
To: Dev Jain <dev.jain@arm.com>
Cc: Yang Shi <yang@os.amperecomputing.com>, catalin.marinas@arm.com,
	ryan.roberts@arm.com, rppt@kernel.org,
	shijie@os.amperecomputing.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] arm64/pageattr: Propagate return value from
 __change_memory_common
Message-ID: <aQn4EwKar66UZ7rz@willie-the-truck>
References: <20251103061306.82034-1-dev.jain@arm.com>
 <aQjHQt2rYL6av4qw@willie-the-truck>
 <f594696b-ba33-4c04-9cf5-e88767221ae0@os.amperecomputing.com>
 <f8b899cf-d377-4dc7-a57c-82826ea5e1ea@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f8b899cf-d377-4dc7-a57c-82826ea5e1ea@arm.com>

On Tue, Nov 04, 2025 at 09:06:12AM +0530, Dev Jain wrote:
> On 04/11/25 12:15 am, Yang Shi wrote:
> > On 11/3/25 7:16 AM, Will Deacon wrote:
> > > On Mon, Nov 03, 2025 at 11:43:06AM +0530, Dev Jain wrote:
> > > > Post a166563e7ec3 ("arm64: mm: support large block mapping when
> > > > rodata=full"),
> > > > __change_memory_common has a real chance of failing due to split
> > > > failure.
> > > > Before that commit, this line was introduced in c55191e96caa,
> > > > still having
> > > > a chance of failing if it needs to allocate pagetable memory in
> > > > apply_to_page_range, although that has never been observed to be true.
> > > > In general, we should always propagate the return value to the caller.
> > > > 
> > > > Cc: stable@vger.kernel.org
> > > > Fixes: c55191e96caa ("arm64: mm: apply r/o permissions of VM
> > > > areas to its linear alias as well")
> > > > Signed-off-by: Dev Jain <dev.jain@arm.com>
> > > > ---
> > > > Based on Linux 6.18-rc4.
> > > > 
> > > >   arch/arm64/mm/pageattr.c | 5 ++++-
> > > >   1 file changed, 4 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
> > > > index 5135f2d66958..b4ea86cd3a71 100644
> > > > --- a/arch/arm64/mm/pageattr.c
> > > > +++ b/arch/arm64/mm/pageattr.c
> > > > @@ -148,6 +148,7 @@ static int change_memory_common(unsigned
> > > > long addr, int numpages,
> > > >       unsigned long size = PAGE_SIZE * numpages;
> > > >       unsigned long end = start + size;
> > > >       struct vm_struct *area;
> > > > +    int ret;
> > > >       int i;
> > > >         if (!PAGE_ALIGNED(addr)) {
> > > > @@ -185,8 +186,10 @@ static int change_memory_common(unsigned
> > > > long addr, int numpages,
> > > >       if (rodata_full && (pgprot_val(set_mask) == PTE_RDONLY ||
> > > >                   pgprot_val(clear_mask) == PTE_RDONLY)) {
> > > >           for (i = 0; i < area->nr_pages; i++) {
> > > > - __change_memory_common((u64)page_address(area->pages[i]),
> > > > +            ret =
> > > > __change_memory_common((u64)page_address(area->pages[i]),
> > > >                              PAGE_SIZE, set_mask, clear_mask);
> > > > +            if (ret)
> > > > +                return ret;
> > > Hmm, this means we can return failure half-way through the operation. Is
> > > that something callers are expecting to handle? If so, how can they tell
> > > how far we got?
> > 
> > IIUC the callers don't have to know whether it is half-way or not
> > because the callers will change the permission back (e.g. to RW) for the
> > whole range when freeing memory.
> 
> Yes, it is the caller's responsibility to set VM_FLUSH_RESET_PERMS flag.
> Upon vfree(), it will change the direct map permissions back to RW.

Ok, but vfree() ends up using update_range_prot() to do that and if we
need to worry about that failing (as per your commit message), then
we're in trouble because the calls to set_area_direct_map() are unchecked.

In other words, this patch is either not necessary or it is incomplete.

Will

