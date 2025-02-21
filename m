Return-Path: <stable+bounces-118564-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F8BA3F111
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 10:56:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E50C817CFD6
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 09:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8771020469D;
	Fri, 21 Feb 2025 09:55:22 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2D820459E;
	Fri, 21 Feb 2025 09:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740131722; cv=none; b=ER9lV2T126s8lcg2OTkBBiKa1861QOjWqippQYAkxxWwSFCJ9frvZ6oERCyMuMskSc+HdYO00XSLT9I9srrJjbYeweaQbCYprCWuorg1M+xqYBNx4FqIHr9CGEsdy6S2JuJXNRdyUbjLyMuLIAHGG+aKpH2YuKkYqJktQsVOFg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740131722; c=relaxed/simple;
	bh=/4FZ7qzIHqBG+3bR25Zn6qVvLpHv3e8zPmnL9xGVzAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=irkWjqRZ5T/zQq14iq3/o8sidTE4MTVfm5aqHC7z2FRZe81goOBU0wE9vOjXWmx653aepzwgCPRROjFSWVvlz6Kg/B/XFZgg7+U8bXHyCeStulxdJgSVLQfzW3Jb2BmdOQdxhndEO5QZi4axNVhMOYh6zm3SqvwzMGyi3RwhUc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8DF8C4CED6;
	Fri, 21 Feb 2025 09:55:15 +0000 (UTC)
Date: Fri, 21 Feb 2025 09:55:13 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, Will Deacon <will@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Arnd Bergmann <arnd@arndb.de>, Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>, Dev Jain <dev.jain@arm.com>,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 2/4] arm64: hugetlb: Fix huge_ptep_get_and_clear() for
 non-present ptes
Message-ID: <Z7hNgSBw6lfwwcch@arm.com>
References: <20250217140419.1702389-1-ryan.roberts@arm.com>
 <20250217140419.1702389-3-ryan.roberts@arm.com>
 <e26a59a1-ff9a-49c7-b10a-c3f5c096a2c4@arm.com>
 <5477d161-12e7-4475-a6e9-ff3921989673@arm.com>
 <50f48574-241d-42d8-b811-3e422c41e21a@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50f48574-241d-42d8-b811-3e422c41e21a@arm.com>

On Thu, Feb 20, 2025 at 12:07:35PM +0530, Anshuman Khandual wrote:
> On 2/19/25 14:28, Ryan Roberts wrote:
> > On 19/02/2025 08:45, Anshuman Khandual wrote:
> >> On 2/17/25 19:34, Ryan Roberts wrote:
> >>> +	while (--ncontig) {
> >>
> >> Should this be converted into a for loop instead just to be in sync with other
> >> similar iterators in this file.
> >>
> >> for (i = 1; i < ncontig; i++, addr += pgsize, ptep++)
> >> {
> >> 	tmp_pte = __ptep_get_and_clear(mm, addr, ptep);
> >> 	if (present) {
> >> 		if (pte_dirty(tmp_pte))
> >> 			pte = pte_mkdirty(pte);
> >> 		if (pte_young(tmp_pte))
> >> 			pte = pte_mkyoung(pte);
> >> 	}
> >> }
> > 
> > I think the way you have written this it's incorrect. Let's say we have 16 ptes
> > in the block. We want to iterate over the last 15 of them (we have already read
> > pte 0). But you're iterating over the first 15 because you don't increment addr
> > and ptep until after you've been around the loop the first time. So we would
> > need to explicitly increment those 2 before entering the loop. But that is only
> > neccessary if ncontig > 1. Personally I think my approach is neater...
> 
> Thinking about this again. Just wondering should not a pte_present()
> check on each entries being cleared along with (ncontig > 1) in this
> existing loop before transferring over the dirty and accessed bits -
> also work as intended with less code churn ?

Shouldn't all the ptes in a contig block be either all present or all
not-present? Is there any point in checking each individually?

-- 
Catalin

