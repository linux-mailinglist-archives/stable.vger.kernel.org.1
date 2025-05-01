Return-Path: <stable+bounces-139286-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD7E1AA5B95
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 09:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 635377A98AD
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 07:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0FB426F463;
	Thu,  1 May 2025 07:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=atlas.cz header.i=@atlas.cz header.b="KLy4gMrP"
X-Original-To: stable@vger.kernel.org
Received: from gmmr-2.centrum.cz (gmmr-2.centrum.cz [46.255.227.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3D118641;
	Thu,  1 May 2025 07:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.227.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746085885; cv=none; b=jxAojoDdf8ft7WpM/ZWIp26NR8kj1y7vO2CAltMdH+LM+PQdmGVLTBF26VYJ/efL/jpT51Y/YlVLKo6zypV6vCoe64RT035vjHP+Cvvyyvjyg4pybSMLx9rWCkhmsPmRWXOlTHCu73AIDT9JvCGKylWjGRHCF/0LfzsoMBXyGuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746085885; c=relaxed/simple;
	bh=WjrMwJ006IGf1ds84BP41cgn9er96yFoDySfO7SdeUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m14nmyYwryV4r94amTSHozUe+wIOXjCZySXzry6FFzygBKyxJIkUclo9EKEhg2fO5rTbpmle57F+6nNKjccMKyT5Nd9Td+jYayGj3zsp4miZ+aw4TrJGGhN2sGqMCDTg4SfpHPBD2Ex6SMw4dM9zGq4X+6e3EYfj1YrfJSkObh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atlas.cz; spf=pass smtp.mailfrom=atlas.cz; dkim=pass (1024-bit key) header.d=atlas.cz header.i=@atlas.cz header.b=KLy4gMrP; arc=none smtp.client-ip=46.255.227.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atlas.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atlas.cz
Received: from gmmr-2.centrum.cz (localhost [127.0.0.1])
	by gmmr-2.centrum.cz (Postfix) with ESMTP id 482CF205F695;
	Thu,  1 May 2025 09:51:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=atlas.cz; s=mail;
	t=1746085875; bh=htvgEFFoxTH4qrki1IE17opSq5uC0asN4uI0lPgjYvU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KLy4gMrPeo5kosgbemhiC23ljW4gaECvLWMeDeWy7NFBgY++c48ZWfoFZYcnnCedv
	 t8reFtftLLW01XfoLQOBN7jvAtxXi/wMWUBvJZmozR5RJnC8UlOGde0oPXG5S6pwps
	 +51sidly1U4dKoSfgeoGA5pAjeoEn4KnPdW69asU=
Received: from antispam37.centrum.cz (antispam37.cent [10.30.208.37])
	by gmmr-2.centrum.cz (Postfix) with ESMTP id 072F1205C13B;
	Thu,  1 May 2025 09:51:14 +0200 (CEST)
X-CSE-ConnectionGUID: F/OBWZYBQUqZhjcTYR2mVg==
X-CSE-MsgGUID: k8wOC7J0RguO0lDTY+MpKQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A2EDAABrJhNo/0vj/y5aGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQAmBNgUBAQEBCwGDQIFkhFWIHIlVA4ETiRGIBYtrFIFqDwEBA?=
 =?us-ascii?q?QEBAQEBAQk9BwQBAQMEOIRIAos4JzQJDgECBAEBAQEDAgMBAQEBAQEBAQENA?=
 =?us-ascii?q?QEGAgEBAQEGBgECgR2FNUYNgmIBgSSBJgEBAQEBAQEBAQEBAR0CDX0BAQEBA?=
 =?us-ascii?q?gEjBAsBRgULCw0EAwECAQICJgICTggGCgmDAgGCLwEDDiMUsmZ6fzMaAmXcc?=
 =?us-ascii?q?AJJBVVjgSQGgRsuAYhPAYVshHdCgg2BFYJyOD6CShcEGIEeD4N0gmkEgi2BF?=
 =?us-ascii?q?oV5mDJSexwDWSwBVRMXCwcFgSZDA4EPI0sFLh2CEYUhghGBXAMDIgGDE3Qch?=
 =?us-ascii?q?GmEUC1Pgy+CAmhEP0ADC209NxQbBpcFg2YGAQE8NRwcEBcJZRMtOTRFknGwb?=
 =?us-ascii?q?IJDgxyBCYROh0uVSjOXcAOSZC6HZZBrG41rmy+BZ4IWMyIwgyJSGYtXi2y3E?=
 =?us-ascii?q?HYCAQEBNwIHAQoBAQMJgjuNTDOBSwEB?=
IronPort-PHdr: A9a23:yTvUmxVO3gxURZIm7/tLSRsGGQ7V8Ky8UzF92vMcY1JmTK2v8tzYM
 VDF4r011RmVBt+ds6oP0bSH6/iocFdDyKjCmUhKSIZLWR4BhJdetC0bK+nBJGvFadXHVGgEJ
 vlET0Jv5HqhMEJYS47UblzWpWCuv3ZJQk2sfQV6Kf7oFYHMks+5y/69+4HJYwVPmTGxfa5+I
 A+5oAjfqMUam5duJro+xhfXo3ZFf/hayX91Ll+Pghjw4du985Fk/ylMofwq6tROUb/9f6Q2T
 LxYCCopPmUo78D1thfNUBWC6GIEXmsZihRHDBHJ4Q/1UJnsqif1ufZz1yecPc3tULA7Qi+i4
 LtxSB/pkygIKTg0+3zKh8NqjaJbpBWhpwFjw4PRfYqYOuZycr/bcNgHXmdKQNpfWDJdDYO9d
 4sPDvQOPeBEr4nmulACqQKyCRSwCO/zzzNFgGL9068n3OQ7CQzI0gwuEcwQvXrJr9v1OqgdX
 vyow6fHzzrOdO9W1DTn5YTUbhwtvfOBULRtesTR00kvEAbFg02Kp4P7IzOVzPkGvGeB4OpmS
 +eviHMspgZrrTi1xccjkIzJiZgPyl3f7yp53II1KsejSEJhfdGlEYJduieHPIR5Xs0sWXtnu
 DomyrIYo567ejAHxpsoyRDQaPGLbYuF7xLnWeuVLzp0mnJodrK7ihuy/kas1/HxW8q13VhEo
 SdIk9fBu38R2hDO9sWKSPhw80e/1DuJygvd5OZEIUUumqraLZ4s2r0wmYQJsUTFACD2nF/6j
 KiMdkUr/OWj9ufpYq3+q5KTNoJ4kB/yP6Qul8ClH+g0LAoDU3KZ9Om8zLHv41D1TbtQgvEoj
 KXVrIrWKdoUq6KlGQNY1ocu5hCiBDm8ytsYh2MILFdddRKCiIjmJk/BLejjDfe6n1SsiDBrx
 +3aPrH5ApXCMHzDkLD5cLZy7k5Q0REzzdVD55JMF70NPej/VVPvu9zeEh85KRG0w+P9BNph1
 4ISQWOPAqmHP6POqVKF6eMiL/OSaIIVuDvxMeYp6+DsgHMjm1IQfbGl3Z4NZ3C5GvRmLV+ZY
 X3pgtoZC2gKpAk+Q/bviFKYSz5efGy9X7445j4hE4KqF5vMR4G1jLybwCi7BoFWZnxBCl2UC
 3fpd5+LW/EWZCKIJc9uiSILVaK9S486zhyhrhX6y799IuXI/S0YsIrv1MJp6O3LiREy6Tt0A
 tyZ02GMSWF0g2wJSyYz3KB6ukF9yUmD3rJkjPxbD9BT4OlJUggiOZ7G0+N6E8zyWh7GftqRU
 lmmQc2mATQqQ9I1wt8OZVt9Gtq7ghDN2CqqHrkVmKGRC5wo86Lc2H7xK9x6y3bc26ktl0MmT
 ddXNW26mq5/8BDeCJPTnEWHlqalaL8R3DTT+2iezWqBpl1YXBRsXqXCWHATflHWosjh5kPeU
 7+uDqwqMg9Ayc6EN6tLZcTljVZYS/f5PtTRfWaxlnyuBRaH2LyMdpDme2YD0yXHDkgLjQQT8
 WyBNQgkCSetu3jeAyB2FVLzf0Ps9vFzqGinTkAu1A6Ka1Nu2qGr+h4am/OcUekf3rEatyc7r
 TV7AlK908jRC9qaqAptZKNcbsgl71ddyW3ZrxB9PoCnL616h1MSaxl4v0Dv1xVyEohOiccko
 300wgRuNa+W1gAJSzTN8ZnuO7GfCmj28B2pYbTf3F2WhNqf5KYDwO41p1XqoEeiEU90oFt91
 NwA63aA/N30BQyxUtqlW1w0/h1zvZnTfi00/MXfxys/YuGPrjbe1odxV6MewRG6coIaafvcf
 DI=
IronPort-Data: A9a23:ZNZo+aoH4lbzx8RbIb5vTLI2UhleBmIpZBIvgKrLsJaIsI4StFCzt
 garIBnTPfmMZjf0KoggPo7g80kOvsLRztcyTQJurS41FHxE9ePIVI+TRqvS04J+DSFhoGZPt
 Zh2hgzodZhsJpPkjk7wdOWn9D8kiPzgqoPUUIbsIjp2SRJvVBAvgBdin/9RqoNziLBVOSvU0
 T/Ji5OZYQLNNwJcaDpOtvrf80s37JwehRtB1rAATaEW1LPhvyZNZH4vDfnZB2f1RIBSAtm7S
 47rpJml/nnU9gsaEdislLD2aCUiGtY+6iDT4pb+c/HKbilq/kTe4I5iXBYvQRs/ZwGyojxE4
 I4lWaqYEl51Y/KWyIzxZDEDe812FfUuFLYquhFTu+TLp6HNWyOEL/mDkCjalGDXkwp6KTgmy
 BAWFNwCRj7EoMiJ8oORc9R1tMQhJ/XaBtkahH41mFk1Dd5+KXzCa6rPoMRdwC9p34ZFEPDCf
 dccLzF9BPjCS0ERfA1KVdRkxrju2SSXnz5w8Tp5oYI++WvayQVr+LHxNNPOPNeYLSlQth/A/
 D2bpTWoXXn2MvScmSWi2S2O3tXAgASjXK4uJf6d7t1T1Qj7Kms7TUd+uUGAieOog0j4QdVVJ
 lYI4QInt610/0uuJvH5XhulsDuBuzYfRdNbEKs98g7l4qPX+wOxAmkCUy4EZts7ssM/WT0t0
 BmOhdyBLTBmrryZYWiQ+redsXW5Pi19BWsDYzIUCAgI+d/upKktgR/VCNVuCqi4ipvyAz6Y6
 yuWpSI6ip0NgsMRkaa251bKh3SrvJehc+IuzlmJGDj4s0UjPtHjONHABUXn0Mus5b2xFjGp1
 EXoUeDHsrFfZX1RvERhmNkwIYw=
IronPort-HdrOrdr: A9a23:wuyErKpqcmMQHdPsNP8eR3caV5oLeYIsimQD101hICG9E/b2qy
 nApoV56faZslgssQ8b6Le90cC7KBu2n6KdirN8AV7NZmTbUL3BFuFfBduL+VzdMhy7yLNgkY
 99bqkWMqyUMXFKyfim3E2TD8w8xt2K68mT9IXj5kYoc1xXL4Vt9R1wBArzKDwTeDV7
X-Talos-CUID: =?us-ascii?q?9a23=3AiS703Wjpe7zmBcdAPdATVSlkVzJuXDr65kjiEmW?=
 =?us-ascii?q?BNH9bSL+edW6qoqZanJ87?=
X-Talos-MUID: =?us-ascii?q?9a23=3AGlV+Dw6fuXZBPkWdP4+Um45cxoxrs7uJIx8vya8?=
 =?us-ascii?q?Jpu7cMQBMCnS4lBeOF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.15,253,1739833200"; 
   d="scan'208";a="102752997"
Received: from unknown (HELO gm-smtp11.centrum.cz) ([46.255.227.75])
  by antispam37.centrum.cz with ESMTP; 01 May 2025 09:45:43 +0200
Received: from arkam (ip-213-220-240-96.bb.vodafone.cz [213.220.240.96])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gm-smtp11.centrum.cz (Postfix) with ESMTPSA id C2F8E100AE2B1;
	Thu,  1 May 2025 09:45:39 +0200 (CEST)
Date: Thu, 1 May 2025 09:45:37 +0200
From: Petr =?utf-8?B?VmFuxJtr?= <arkamar@atlas.cz>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Ryan Roberts <ryan.roberts@arm.com>, linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/1] mm: Fix folio_pte_batch() overcount with zero PTEs
Message-ID: <20255174537-aBMmobhpYTFtoONI-arkamar@atlas.cz>
References: <d53fd549-887f-4220-b0d1-ebc336eecb9f@redhat.com>
 <2025429144547-aBDmGzJBQc9RMBj--arkamar@atlas.cz>
 <ef317615-3e26-4641-8141-4d3913ced47f@redhat.com>
 <b6613b71-3eb9-4348-9031-c1dd172b9814@redhat.com>
 <2025429183321-aBEbcQQY3WX6dsNI-arkamar@atlas.cz>
 <1df577bb-eaba-4e34-9050-309ee1c7dc57@redhat.com>
 <202543011526-aBIO5nq6Olsmq2E--arkamar@atlas.cz>
 <9c412f4f-3bdf-43c0-a3cd-7ce52233f4e5@redhat.com>
 <202543016037-aBJJJdupFVd_6FTX-arkamar@atlas.cz>
 <91c4e7e6-e4c2-4ff0-8b13-7b3ff138e98e@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <91c4e7e6-e4c2-4ff0-8b13-7b3ff138e98e@redhat.com>

On Wed, Apr 30, 2025 at 11:25:56PM +0200, David Hildenbrand wrote:
> On 30.04.25 18:00, Petr Vaněk wrote:
> > On Wed, Apr 30, 2025 at 04:37:21PM +0200, David Hildenbrand wrote:
> >> On 30.04.25 13:52, Petr Vaněk wrote:
> >>> On Tue, Apr 29, 2025 at 08:56:03PM +0200, David Hildenbrand wrote:
> >>>> On 29.04.25 20:33, Petr Vaněk wrote:
> >>>>> On Tue, Apr 29, 2025 at 05:45:53PM +0200, David Hildenbrand wrote:
> >>>>>> On 29.04.25 16:52, David Hildenbrand wrote:
> >>>>>>> On 29.04.25 16:45, Petr Vaněk wrote:
> >>>>>>>> On Tue, Apr 29, 2025 at 04:29:30PM +0200, David Hildenbrand wrote:
> >>>>>>>>> On 29.04.25 16:22, Petr Vaněk wrote:
> >>>>>>>>>> folio_pte_batch() could overcount the number of contiguous PTEs when
> >>>>>>>>>> pte_advance_pfn() returns a zero-valued PTE and the following PTE in
> >>>>>>>>>> memory also happens to be zero. The loop doesn't break in such a case
> >>>>>>>>>> because pte_same() returns true, and the batch size is advanced by one
> >>>>>>>>>> more than it should be.
> >>>>>>>>>>
> >>>>>>>>>> To fix this, bail out early if a non-present PTE is encountered,
> >>>>>>>>>> preventing the invalid comparison.
> >>>>>>>>>>
> >>>>>>>>>> This issue started to appear after commit 10ebac4f95e7 ("mm/memory:
> >>>>>>>>>> optimize unmap/zap with PTE-mapped THP") and was discovered via git
> >>>>>>>>>> bisect.
> >>>>>>>>>>
> >>>>>>>>>> Fixes: 10ebac4f95e7 ("mm/memory: optimize unmap/zap with PTE-mapped THP")
> >>>>>>>>>> Cc: stable@vger.kernel.org
> >>>>>>>>>> Signed-off-by: Petr Vaněk <arkamar@atlas.cz>
> >>>>>>>>>> ---
> >>>>>>>>>>        mm/internal.h | 2 ++
> >>>>>>>>>>        1 file changed, 2 insertions(+)
> >>>>>>>>>>
> >>>>>>>>>> diff --git a/mm/internal.h b/mm/internal.h
> >>>>>>>>>> index e9695baa5922..c181fe2bac9d 100644
> >>>>>>>>>> --- a/mm/internal.h
> >>>>>>>>>> +++ b/mm/internal.h
> >>>>>>>>>> @@ -279,6 +279,8 @@ static inline int folio_pte_batch(struct folio *folio, unsigned long addr,
> >>>>>>>>>>        			dirty = !!pte_dirty(pte);
> >>>>>>>>>>        		pte = __pte_batch_clear_ignored(pte, flags);
> >>>>>>>>>>        
> >>>>>>>>>> +		if (!pte_present(pte))
> >>>>>>>>>> +			break;
> >>>>>>>>>>        		if (!pte_same(pte, expected_pte))
> >>>>>>>>>>        			break;
> >>>>>>>>>
> >>>>>>>>> How could pte_same() suddenly match on a present and non-present PTE.
> >>>>>>>>
> >>>>>>>> In the problematic case pte.pte == 0 and expected_pte.pte == 0 as well.
> >>>>>>>> pte_same() returns a.pte == b.pte -> 0 == 0. Both are non-present PTEs.
> >>>>>>>
> >>>>>>> Observe that folio_pte_batch() was called *with a present pte*.
> >>>>>>>
> >>>>>>> do_zap_pte_range()
> >>>>>>> 	if (pte_present(ptent))
> >>>>>>> 		zap_present_ptes()
> >>>>>>> 			folio_pte_batch()
> >>>>>>>
> >>>>>>> How can we end up with an expected_pte that is !present, if it is based
> >>>>>>> on the provided pte that *is present* and we only used pte_advance_pfn()
> >>>>>>> to advance the pfn?
> >>>>>>
> >>>>>> I've been staring at the code for too long and don't see the issue.
> >>>>>>
> >>>>>> We even have
> >>>>>>
> >>>>>> VM_WARN_ON_FOLIO(!pte_present(pte), folio);
> >>>>>>
> >>>>>> So the initial pteval we got is present.
> >>>>>>
> >>>>>> I don't see how
> >>>>>>
> >>>>>> 	nr = pte_batch_hint(start_ptep, pte);
> >>>>>> 	expected_pte = __pte_batch_clear_ignored(pte_advance_pfn(pte, nr), flags);
> >>>>>>
> >>>>>> would suddenly result in !pte_present(expected_pte).
> >>>>>
> >>>>> The issue is not happening in __pte_batch_clear_ignored but later in
> >>>>> following line:
> >>>>>
> >>>>>      expected_pte = pte_advance_pfn(expected_pte, nr);
> >>>>>
> >>>>> The issue seems to be in __pte function which converts PTE value to
> >>>>> pte_t in pte_advance_pfn, because warnings disappears when I change the
> >>>>> line to
> >>>>>
> >>>>>      expected_pte = (pte_t){ .pte = pte_val(expected_pte) + (nr << PFN_PTE_SHIFT) };
> >>>>>
> >>>>> The kernel probably uses __pte function from
> >>>>> arch/x86/include/asm/paravirt.h because it is configured with
> >>>>> CONFIG_PARAVIRT=y:
> >>>>>
> >>>>>      static inline pte_t __pte(pteval_t val)
> >>>>>      {
> >>>>>      	return (pte_t) { PVOP_ALT_CALLEE1(pteval_t, mmu.make_pte, val,
> >>>>>      					  "mov %%rdi, %%rax", ALT_NOT_XEN) };
> >>>>>      }
> >>>>>
> >>>>> I guess it might cause this weird magic, but I need more time to
> >>>>> understand what it does :)
> >>>
> >>> I understand it slightly more. __pte() uses xen_make_pte(), which calls
> >>> pte_pfn_to_mfn(), however, mfn for this pfn contains INVALID_P2M_ENTRY
> >>> value, therefore the pte_pfn_to_mfn() returns 0, see [1].
> >>>
> >>> I guess that the mfn was invalidated by xen-balloon driver?
> >>>
> >>> [1] https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/xen/mmu_pv.c?h=v6.15-rc4#n408
> >>>
> >>>> What XEN does with basic primitives that convert between pteval and
> >>>> pte_t is beyond horrible.
> >>>>
> >>>> How come set_ptes() that uses pte_next_pfn()->pte_advance_pfn() does not
> >>>> run into this?
> >>>
> >>> I don't know, but I guess it is somehow related to pfn->mfn translation.
> >>>
> >>>> Is it only a problem if we exceed a certain pfn?
> >>>
> >>> No, it is a problem if the corresponding mft to given pfn is invalid.
> >>>
> >>> I am not sure if my original patch is a good fix.
> >>
> >> No :)
> >>
> >> Maybe it would be
> >>> better to have some sort of native_pte_advance_pfn() which will use
> >>> native_make_pte() rather than __pte(). Or do you think the issue is in
> >>> Xen part?
> >>
> >> I think what's happening is that -- under XEN only -- we might get garbage when
> >> calling pte_advance_pfn() and the next PFN would no longer fall into the folio. And
> >> the current code cannot deal with that XEN garbage.
> >>
> >> But still not 100% sure.
> >>
> >> The following is completely untested, could you give that a try?
> > 
> > Yes, it solves the issue for me.
> 
> Cool!
> 
> > 
> > However, maybe it would be better to solve it with the following patch.
> > The pte_pfn_to_mfn() actually returns the same value for non-present
> > PTEs. I suggest to return original PTE if the mfn is INVALID_P2M_ENTRY,
> > rather than empty non-present PTE, but the _PAGE_PRESENT bit will be set
> > to zero. Thus, we will not loose information about original pfn but it
> > will be clear that the page is not present.
> > 
> >  From e84781f9ec4fb7275d5e7629cf7e222466caf759 Mon Sep 17 00:00:00 2001
> > From: =?UTF-8?q?Petr=20Van=C4=9Bk?= <arkamar@atlas.cz>
> > Date: Wed, 30 Apr 2025 17:08:41 +0200
> > Subject: [PATCH] x86/mm: Reset pte _PAGE_PRESENT bit for invalid mft
> > MIME-Version: 1.0
> > Content-Type: text/plain; charset=UTF-8
> > Content-Transfer-Encoding: 8bit
> > 
> > Signed-off-by: Petr Vaněk <arkamar@atlas.cz>
> > ---
> >   arch/x86/xen/mmu_pv.c | 9 +++------
> >   1 file changed, 3 insertions(+), 6 deletions(-)
> > 
> > diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
> > index 38971c6dcd4b..92a6a9af0c65 100644
> > --- a/arch/x86/xen/mmu_pv.c
> > +++ b/arch/x86/xen/mmu_pv.c
> > @@ -392,28 +392,25 @@ static pteval_t pte_mfn_to_pfn(pteval_t val)
> >   static pteval_t pte_pfn_to_mfn(pteval_t val)
> >   {
> >   	if (val & _PAGE_PRESENT) {
> >   		unsigned long pfn = (val & PTE_PFN_MASK) >> PAGE_SHIFT;
> >   		pteval_t flags = val & PTE_FLAGS_MASK;
> >   		unsigned long mfn;
> >   
> >   		mfn = __pfn_to_mfn(pfn);
> >   
> >   		/*
> > -		 * If there's no mfn for the pfn, then just create an
> > -		 * empty non-present pte.  Unfortunately this loses
> > -		 * information about the original pfn, so
> > -		 * pte_mfn_to_pfn is asymmetric.
> > +		 * If there's no mfn for the pfn, then just reset present pte bit.
> >   		 */
> >   		if (unlikely(mfn == INVALID_P2M_ENTRY)) {
> > -			mfn = 0;
> > -			flags = 0;
> > +			mfn = pfn;
> > +			flags &= ~_PAGE_PRESENT;
> >   		} else
> >   			mfn &= ~(FOREIGN_FRAME_BIT | IDENTITY_FRAME_BIT);
> >   		val = ((pteval_t)mfn << PAGE_SHIFT) | flags;
> >   	}
> >   
> >   	return val;
> >   }
> >   
> >   __visible pteval_t xen_pte_val(pte_t pte)
> >   {
> 
> That might do as well.
>
>
> I assume the following would also work? (removing the early ==1 check)

Yes, it also works in my case and the removal makes sense to me.

> It has the general benefit of removing the pte_pfn() call from the
> loop body, which is why I like that fix. (almost looks like a cleanup)

Indeed, it looks like a cleanup to me as well :)

I am still considering if it would make sense to send both patches, I am
not sure if reseting _PAGE_PRESENT flag is enough, because of swapping
or other areas which I am not aware of.

>  From 75948778b586d4759a480bf412fd4682067b12ea Mon Sep 17 00:00:00 2001
> From: David Hildenbrand <david@redhat.com>
> Date: Wed, 30 Apr 2025 16:35:12 +0200
> Subject: [PATCH] tmp
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>   mm/internal.h | 27 +++++++++++----------------
>   1 file changed, 11 insertions(+), 16 deletions(-)
> 
> diff --git a/mm/internal.h b/mm/internal.h
> index e9695baa59226..25a29872c634b 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -248,11 +248,9 @@ static inline int folio_pte_batch(struct folio *folio, unsigned long addr,
>   		pte_t *start_ptep, pte_t pte, int max_nr, fpb_t flags,
>   		bool *any_writable, bool *any_young, bool *any_dirty)
>   {
> -	unsigned long folio_end_pfn = folio_pfn(folio) + folio_nr_pages(folio);
> -	const pte_t *end_ptep = start_ptep + max_nr;
>   	pte_t expected_pte, *ptep;
>   	bool writable, young, dirty;
> -	int nr;
> +	int nr, cur_nr;
>   
>   	if (any_writable)
>   		*any_writable = false;
> @@ -265,11 +263,15 @@ static inline int folio_pte_batch(struct folio *folio, unsigned long addr,
>   	VM_WARN_ON_FOLIO(!folio_test_large(folio) || max_nr < 1, folio);
>   	VM_WARN_ON_FOLIO(page_folio(pfn_to_page(pte_pfn(pte))) != folio, folio);
>   
> +	/* Limit max_nr to the actual remaining PFNs in the folio we could batch. */
> +	max_nr = min_t(unsigned long, max_nr,
> +		       folio_pfn(folio) + folio_nr_pages(folio) - pte_pfn(pte));
> +
>   	nr = pte_batch_hint(start_ptep, pte);
>   	expected_pte = __pte_batch_clear_ignored(pte_advance_pfn(pte, nr), flags);
>   	ptep = start_ptep + nr;
>   
> -	while (ptep < end_ptep) {
> +	while (nr < max_nr) {
>   		pte = ptep_get(ptep);
>   		if (any_writable)
>   			writable = !!pte_write(pte);
> @@ -282,14 +284,6 @@ static inline int folio_pte_batch(struct folio *folio, unsigned long addr,
>   		if (!pte_same(pte, expected_pte))
>   			break;
>   
> -		/*
> -		 * Stop immediately once we reached the end of the folio. In
> -		 * corner cases the next PFN might fall into a different
> -		 * folio.
> -		 */
> -		if (pte_pfn(pte) >= folio_end_pfn)
> -			break;
> -
>   		if (any_writable)
>   			*any_writable |= writable;
>   		if (any_young)
> @@ -297,12 +291,13 @@ static inline int folio_pte_batch(struct folio *folio, unsigned long addr,
>   		if (any_dirty)
>   			*any_dirty |= dirty;
>   
> -		nr = pte_batch_hint(ptep, pte);
> -		expected_pte = pte_advance_pfn(expected_pte, nr);
> -		ptep += nr;
> +		cur_nr = pte_batch_hint(ptep, pte);
> +		expected_pte = pte_advance_pfn(expected_pte, cur_nr);
> +		ptep += cur_nr;
> +		nr += cur_nr;
>   	}
>   
> -	return min(ptep - start_ptep, max_nr);
> +	return min(nr, max_nr);
>   }
>   
>   /**
> -- 
> 2.49.0
> 
> 
> -- 
> Cheers,
> 
> David / dhildenb
> 

