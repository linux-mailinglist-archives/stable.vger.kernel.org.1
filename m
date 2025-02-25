Return-Path: <stable+bounces-119562-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6AC2A44FA1
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 23:18:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 234517ABC09
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 22:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 057F920E70A;
	Tue, 25 Feb 2025 22:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gCbcoe1F"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C2015539D;
	Tue, 25 Feb 2025 22:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740521903; cv=none; b=faxF27lHenxWDavCTNor9qIS878DrHVpUpvJKaDh/Wq1nhzvebFPV5lH9hbMP1Bf6Pm1LO1DHvZY0XwTyw76mu4bZznVVcVYO26FLMaa3jNLGJz8/9p6AFyZdzC4e7ll40ViEpzRNnBx95gOqsM38MDH3/OtCrsXG6ZSUigzfmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740521903; c=relaxed/simple;
	bh=viw/irv5FYM22IZHK1n8uTxMVClyAZnRSx0477w/Koc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=am6cMc/enmmRgFAcmg0mPGFWm93BJEDi+/MFdrv7+wcDEOTl6tdZNA9Q3aPTYwhixAhzAvAGyxGaePbhTt/+j1nXVXq5ygPpiSIOcDgZuVco2BjD/xkTE4ZI7u52vpmUffvpStNc3Tra/225oBJY3U0C9JkEP2fo828cg/0XRZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gCbcoe1F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C835EC4CEDD;
	Tue, 25 Feb 2025 22:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740521903;
	bh=viw/irv5FYM22IZHK1n8uTxMVClyAZnRSx0477w/Koc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gCbcoe1FnWAkKkuivz0Ld9lqqBS4AgOIa9ysfvtOoCndfjUBbAIznfzW4O+zRQ53X
	 7i9jwLmsvP3bPXO3GhN01JEwreGc+tMywVAe75sYEs9e2EedPocFDz+peOGPBXXnbV
	 TdRuf1qo+Q4tdG4WGlSOOSVn10dyWdYDMPWIizqrIgob/NFWIzpmadvVZ0DhRK+3z2
	 46QE4El0fvJpbEAohIyW2HetDWLTxPTgirKpKIya72I5N3cHvHQ/tzKaGqT+H5eR+a
	 slzjYb3AlhpaPXDiqa+UzwCCbelVHxPePg0al6q6kQCAheTaao/TjccKU36K2E0FB7
	 iu9j+Fj87Pe4w==
Date: Tue, 25 Feb 2025 22:18:13 +0000
From: Will Deacon <will@kernel.org>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
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
	Mark Rutland <mark.rutland@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Dev Jain <dev.jain@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 2/4] arm64: hugetlb: Fix huge_ptep_get_and_clear() for
 non-present ptes
Message-ID: <20250225221812.GA23870@willie-the-truck>
References: <20250217140419.1702389-1-ryan.roberts@arm.com>
 <20250217140419.1702389-3-ryan.roberts@arm.com>
 <20250221153156.GC20567@willie-the-truck>
 <6ebf36f2-2e55-49b2-8764-90fd972d6e66@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ebf36f2-2e55-49b2-8764-90fd972d6e66@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, Feb 24, 2025 at 12:11:19PM +0000, Ryan Roberts wrote:
> On 21/02/2025 15:31, Will Deacon wrote:
> > On Mon, Feb 17, 2025 at 02:04:15PM +0000, Ryan Roberts wrote:
> >> +	pte = __ptep_get_and_clear(mm, addr, ptep);
> >> +	present = pte_present(pte);
> >> +	while (--ncontig) {
> >> +		ptep++;
> >> +		addr += pgsize;
> >> +		tmp_pte = __ptep_get_and_clear(mm, addr, ptep);
> >> +		if (present) {
> >> +			if (pte_dirty(tmp_pte))
> >> +				pte = pte_mkdirty(pte);
> >> +			if (pte_young(tmp_pte))
> >> +				pte = pte_mkyoung(pte);
> >> +		}
> >>  	}
> > 
> > nit: With the loop now structured like this, we really can't handle
> > num_contig_ptes() returning 0 if it gets an unknown size. Granted, that
> > really shouldn't happen, but perhaps it would be better to add a 'default'
> > case with a WARN() to num_contig_ptes() and then add an early return here?
> 
> Looking at other users of num_contig_ptes() it looks like huge_ptep_get()
> already assumes at least 1 pte (it calls __ptep_get() before calling
> num_contig_ptes()) and set_huge_pte_at() assumes 1 pte for the "present and
> non-contig" case. So num_contig_ptes() returning 0 is already not really
> consumed consistently.
> 
> How about we change the default num_contig_ptes() return value to 1 and add a
> warning if size is invalid:

Fine by me!

I assume you'll fold that in and send a new version, along with the typo
fixes?

Cheers,

Will

