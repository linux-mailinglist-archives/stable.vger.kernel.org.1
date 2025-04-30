Return-Path: <stable+bounces-139141-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97900AA4A5F
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 13:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5527C4C2429
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 11:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9418E259C8A;
	Wed, 30 Apr 2025 11:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=atlas.cz header.i=@atlas.cz header.b="RTB3JeXJ";
	dkim=pass (1024-bit key) header.d=atlas.cz header.i=@atlas.cz header.b="RTB3JeXJ"
X-Original-To: stable@vger.kernel.org
Received: from gmmr-4.centrum.cz (gmmr-4.centrum.cz [46.255.227.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BA22505BE;
	Wed, 30 Apr 2025 11:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.227.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746014061; cv=none; b=E9pQket/MASXbtLb6M5kouKvG+S8W5HtHQfGywIE597EGQ295hkgaXsXWXcqVoRAnHMHhZskPC6qfVfYALJyJf1BmlbBMyeI5GGOsnutEYwAMe100vrexqPPSbzt9ybCcALBUKNDq9kqgcLTpY4kTHWLEoP7EX12OGY8SNqXPCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746014061; c=relaxed/simple;
	bh=+VarrTygfhbwK4js+lP3jOaPp2vAB8U3GzifIiBuJ1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DhCRAKYqQOOYizqqdhtjzPxteo+oUHzUl1qoGa+JWbqLuHite90S4mLqvwaBmlaLKDngbU7oOjGBJx1yS1h3oC6vI/KB3ovc1R49RvoHKV7On1fCvO+WvyuKrKgmkbVSTbY+RUmT7BdVyH+kL8gLf//k80F2tlO2eGL+1xm6ZSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atlas.cz; spf=pass smtp.mailfrom=atlas.cz; dkim=pass (1024-bit key) header.d=atlas.cz header.i=@atlas.cz header.b=RTB3JeXJ; dkim=pass (1024-bit key) header.d=atlas.cz header.i=@atlas.cz header.b=RTB3JeXJ; arc=none smtp.client-ip=46.255.227.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atlas.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atlas.cz
Received: from gmmr-1.centrum.cz (envoy-stl.cent [10.32.56.18])
	by gmmr-4.centrum.cz (Postfix) with ESMTP id 799A070359;
	Wed, 30 Apr 2025 13:52:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=atlas.cz; s=mail;
	t=1746013929; bh=gRxAtLm/QO9fsYQPEJOWqw8SabNqdhfSGQ+yE3cIFwE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RTB3JeXJA546P08RVVGQI0ARlHDGeoa1e/aQfRytY5xZ7Qhw1I3FTXp31PmlwLXn1
	 DaDZysat3X4oJZ9DPKcacajfwznyyndLnJcDwk77p/h7xlRxuB2Hd3lT4Mtu2OU+P2
	 pa+UzKyJXmeZ5vShPMXd4+TvzY2ZI0tlXTS0QGug=
Received: from gmmr-1.centrum.cz (localhost [127.0.0.1])
	by gmmr-1.centrum.cz (Postfix) with ESMTP id 75FA8389;
	Wed, 30 Apr 2025 13:52:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=atlas.cz; s=mail;
	t=1746013929; bh=gRxAtLm/QO9fsYQPEJOWqw8SabNqdhfSGQ+yE3cIFwE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RTB3JeXJA546P08RVVGQI0ARlHDGeoa1e/aQfRytY5xZ7Qhw1I3FTXp31PmlwLXn1
	 DaDZysat3X4oJZ9DPKcacajfwznyyndLnJcDwk77p/h7xlRxuB2Hd3lT4Mtu2OU+P2
	 pa+UzKyJXmeZ5vShPMXd4+TvzY2ZI0tlXTS0QGug=
Received: from antispam23.centrum.cz (antispam23.cent [10.30.208.23])
	by gmmr-1.centrum.cz (Postfix) with ESMTP id 742931B4;
	Wed, 30 Apr 2025 13:52:09 +0200 (CEST)
X-CSE-ConnectionGUID: il8GC3snTl+fq4UfCzNHZw==
X-CSE-MsgGUID: mUzgsuM3Rwutlk1vHl3xAQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A2EPAACjDRJo/0vj/y5aGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUAJgTcFAQEBCwGDQIFkhFWRcQOKJIgFi2uBfg8BAQEBAQEBAQEJPQcEA?=
 =?us-ascii?q?QEDBDiESAKLNSc1CA4BAgQBAQEBAwIDAQEBAQEBAQEBDQEBBgEBAQEBAQYGA?=
 =?us-ascii?q?QKBHYU1Rg2CYgGBJIEmAQEBAQEBAQEBAQEBHQINfQEBAQECASMECwFGBQsLD?=
 =?us-ascii?q?QsCAiYCAlYGE4MCAYIvAQMOIxSxM3p/DSYaAmXccAJJBVVjgSQGgRsuAYhPA?=
 =?us-ascii?q?YVshHdCgg2EBzg+gkoXBBiFIYJpBIItgRaFeZgnUnscA1ksAVUTFwsHBYEmQ?=
 =?us-ascii?q?wOBDyNLBS4dghGFIYIRgVwDAyIBgxN0HIRphFAtT4MvggJoRCNAAwttPTcUG?=
 =?us-ascii?q?waWfINkBgFyHBwQFwllEy3FD4JDgxyBCYROh0uVSjOXcAOSZC6HZZBrG41rm?=
 =?us-ascii?q?y+BUBkBghMzIjCDIlIZl0O1eXYCAQEBNwIHAQoBAQMJgjuNfIFLAQE?=
IronPort-PHdr: A9a23:PAfZtRKPXN13wwpQUdmcuCdgWUAX0o4c3iYr45Yqw4hDbr6kt8y7e
 hCEv7M11BSTA9uFsrptsKn/jePJYSQ4+5GPsXQPItRndiQuroE7uTJlK+O+TXPBEfjxciYhF
 95DXlI2t1uyMExSBdqsLwaK+i764jEdAAjwOhRoLerpBIHSk9631+ev8JHPfglEnjWwbL1sI
 BmssQndqsYajZVjJ6swyxbFv2ZDdvhLy29vOV+ckBHw69uq8pV+6SpQofUh98BBUaX+Yas1S
 KFTASolPW4o+sDlrAHPQwSX6HQTS2kbjBVGDRXd4B71Qpn+vC36tvFg2CaBJs35Uao0WTW54
 Kh1ThLjlToKOCQ48GHTjcxwkb5brRe8rBFx34LYfIeYP+dlc6jDYd0VW3ZOXsdJVyxAHIy8a
 ZcPD/EcNupctoXxukcCoQe7CQSqGejhyCJHhmXu0KM00+ovDx/L0hEjEdIAv3vbsMj6OqgQX
 u2u0KnFzi/OY+9K1Tvh6oXFdA0qr/GWXbJ3dMrc0VMhGB3ZjlWKtIfqMCma1uITtmiY8uFtU
 vigi3Qkqw5rpzig3N0sh5LTiYIJzlDL7z55zJwpKty5UUN2Z8OvH5RMuS+ALYR2Xt8iTH9yu
 CY80rAItpG1cicJxZg5xBPSa/iKfoyG7x79VOufITN1iXJqdr6imxu/8kmtxOPzW8S13ltHo
 TZInsTQu30P1BHe6taKR/1g9Umv3jaP0hrc6uBCIU0slqrUNYQhwrgumZoXq0jDGTX2mErwg
 aSLdUsk4vCl5uvmb7n8uJORN495hhvgPqgwmMGzG+Y1PwgWU2SF5Oix2qfv8VPnTLlWlPE6j
 KbUvIzAKckfp6O0BRJe3Jw55BalFTim1cwVnXwALF1YZh2Kl5PpO1TSIPDgCve/nkisnC9rx
 //YOr3hBY3ALnfGkLv4ZrZ97lJcyBIuwdxC/Z5bFq8OIPTvWk/rqdzYCwU1PBC1wur/CdV90
 J0RWX6XD6KWMa7eq0GE6+IvLuWWeoMZpjTwJ+In6vPulXM5nEUSfait3ZsZcnC4GfFmLl2Db
 nr2gdcOC2IKsRAkTOHxklKCTTpTaGypX64m+j46CZqqDZ3fSYC1nLyBwCC7E4VMZmFGEF+MF
 23kd5+DW/gXdi2SONNhkicfWLe7UY8h0AuiuxP9y7piNubU4DEXtYr/1Nhp4O3ejRUy9T1yD
 8SA3GCBVmR0nmYTSj81wqBwu1ByylSZ3ah/mfxYGsRf5+lVXQciKZ7c0+t6BsjoVQLCZteJT
 U2rQtGnATE3U9IwzMYCY0h6G9W/iBDMwjClA6MUl7yMApw46KXc32L+J8pl0XbJyLEhj0U6Q
 stILWCpm7Rw9xbSB4HUiEiZjbilerkc3CHX6GeP13aBvEZdUAJoS6XKQWgfZlfKrdT+/k7CS
 76uCbI6MgpO0MKCKbVFasfvjVpYQPfuI8reY22vlGeqHxqIxa2DbJDse2oD2CXREk8Ekxoc/
 XqeLwgxGj+ho37CDDxpDV/veF/s/vNlp3O/UEA51B+Kb0J/2Lqv4BIVhuKTS+kV3r0avCcts
 TJ0HEyy397ODdqPvBJufL9AbtMl/FdHyWXZuhR8M5C4Mq9ihV8ecwFvsk322Bt4BJtOn9Q2o
 X0sn0JOLve02U1Ae3u43JT8N7vdMGD08Fj7Z6fI2132ytua+q4Trv8/rgOwkhuuEx8a/ml9m
 +dc1difrsHDFgkbVJvrek8r8xFh4brINHpur7jI3GFhZPHn+gTJ3MgkUa58kk7IQg==
IronPort-Data: A9a23:gjtfcaKT2NBYMJ/5FE+R5ZQlxSXFcZb7ZxGr2PjKsXjdYENSgjVSn
 2sWXDjQPP6OMWL8Ldp+Pd6/9EgOvJ7QztRmQAEd+CA2RRqmiyZk6fd1jKvUF3nPRiEWZBs/t
 63yUvGZcYZpCCaa/krwWlTYhSEU/bmSQbbhA/LzNCl0RAt1IA8skhsLd9QR2+aEuvDnRVrQ0
 T/Oi5eHYgL9h2Usajt8B5+r8XuDgtyj5Vv0gXRhPZinjHeG/1EJAZQWI72GLneQauF8Au6gS
 u/f+6qy92Xf8g1FIovNfmHTLyXm6paLVeS/oiI+t5qK23CulQRuukoPD8fwXG8M49m/t4sol
 IgS78zYpTABZcUgkMxFO/VR/roX0aduoNcrKlDn2SCfItGvn9IBDJyCAWlvVbD09NqbDklP8
 aw3A2sWaCyHxOyvnI+1YftKpvY8eZyD0IM34hmMzBnWCLM9RIzbGvyM7tJewC0tg4ZFD54yZ
 eJFN3w1MUmGOUcQfAhKYH49tL7Aan3XeidboVecv4I+/2za10p6wtABNfKOI4PUG58MxRnwS
 mTu+lnrDQoHEYel1ieZ9nH1mM/LxjPSYddHfFG/3rsw6LGJ/UQJGRQQE0G8q/SjllWWUshab
 UcT/0IGqak06VzuS9zVXAOxq33CuQQTM/JZEPU/wAWMzLfEpgieG24IRyJAb9pgs9U5LRQm3
 0GIk/vzCDBvuaHTQnWYnp+QrDWvKW0WIHUEaCssUwQI+Z/grZs1gxaJScxseIauktT/HTzY3
 T+Htm49iq8VgMpN0L+0lW0rmBrw+N6TE1NzvF+IGD34hu9kWLOYi0WTwQCzxZ59wEyxFzFtY
 FBsdxCi0d0z
IronPort-HdrOrdr: A9a23:eseF66pEhV0SX4Op1/4xgPoaV5o8eYIsimQD101hICG9JPb4qy
 nOpoV/6faQsl0ssR4b6LK90cW7MBDhHOdOjrX5ZI3PYOCEghrNEGg41+XfKlTbckWVygc378
 ddmsZFZeHNMQ==
X-Talos-CUID: 9a23:yP35kGHoX+7JHuW3qmJm8B47MZs+dEHZj3nJf3K2InRPaI+KHAo=
X-Talos-MUID: 9a23:Vx35fQk8nW2Arj87fYWRdnpnCdVn+LmLU3oSjIkCuJCaFSgrKx6k2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.15,251,1739833200"; 
   d="scan'208";a="317662137"
Received: from unknown (HELO gm-smtp11.centrum.cz) ([46.255.227.75])
  by antispam23.centrum.cz with ESMTP; 30 Apr 2025 13:52:09 +0200
Received: from arkam (ip-213-220-240-96.bb.vodafone.cz [213.220.240.96])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gm-smtp11.centrum.cz (Postfix) with ESMTPSA id E0407100AE10D;
	Wed, 30 Apr 2025 13:52:08 +0200 (CEST)
Date: Wed, 30 Apr 2025 13:52:06 +0200
From: Petr =?utf-8?B?VmFuxJtr?= <arkamar@atlas.cz>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Ryan Roberts <ryan.roberts@arm.com>, linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/1] mm: Fix folio_pte_batch() overcount with zero PTEs
Message-ID: <202543011526-aBIO5nq6Olsmq2E--arkamar@atlas.cz>
References: <20250429142237.22138-1-arkamar@atlas.cz>
 <20250429142237.22138-2-arkamar@atlas.cz>
 <d53fd549-887f-4220-b0d1-ebc336eecb9f@redhat.com>
 <2025429144547-aBDmGzJBQc9RMBj--arkamar@atlas.cz>
 <ef317615-3e26-4641-8141-4d3913ced47f@redhat.com>
 <b6613b71-3eb9-4348-9031-c1dd172b9814@redhat.com>
 <2025429183321-aBEbcQQY3WX6dsNI-arkamar@atlas.cz>
 <1df577bb-eaba-4e34-9050-309ee1c7dc57@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1df577bb-eaba-4e34-9050-309ee1c7dc57@redhat.com>

On Tue, Apr 29, 2025 at 08:56:03PM +0200, David Hildenbrand wrote:
> On 29.04.25 20:33, Petr Vaněk wrote:
> > On Tue, Apr 29, 2025 at 05:45:53PM +0200, David Hildenbrand wrote:
> >> On 29.04.25 16:52, David Hildenbrand wrote:
> >>> On 29.04.25 16:45, Petr Vaněk wrote:
> >>>> On Tue, Apr 29, 2025 at 04:29:30PM +0200, David Hildenbrand wrote:
> >>>>> On 29.04.25 16:22, Petr Vaněk wrote:
> >>>>>> folio_pte_batch() could overcount the number of contiguous PTEs when
> >>>>>> pte_advance_pfn() returns a zero-valued PTE and the following PTE in
> >>>>>> memory also happens to be zero. The loop doesn't break in such a case
> >>>>>> because pte_same() returns true, and the batch size is advanced by one
> >>>>>> more than it should be.
> >>>>>>
> >>>>>> To fix this, bail out early if a non-present PTE is encountered,
> >>>>>> preventing the invalid comparison.
> >>>>>>
> >>>>>> This issue started to appear after commit 10ebac4f95e7 ("mm/memory:
> >>>>>> optimize unmap/zap with PTE-mapped THP") and was discovered via git
> >>>>>> bisect.
> >>>>>>
> >>>>>> Fixes: 10ebac4f95e7 ("mm/memory: optimize unmap/zap with PTE-mapped THP")
> >>>>>> Cc: stable@vger.kernel.org
> >>>>>> Signed-off-by: Petr Vaněk <arkamar@atlas.cz>
> >>>>>> ---
> >>>>>>      mm/internal.h | 2 ++
> >>>>>>      1 file changed, 2 insertions(+)
> >>>>>>
> >>>>>> diff --git a/mm/internal.h b/mm/internal.h
> >>>>>> index e9695baa5922..c181fe2bac9d 100644
> >>>>>> --- a/mm/internal.h
> >>>>>> +++ b/mm/internal.h
> >>>>>> @@ -279,6 +279,8 @@ static inline int folio_pte_batch(struct folio *folio, unsigned long addr,
> >>>>>>      			dirty = !!pte_dirty(pte);
> >>>>>>      		pte = __pte_batch_clear_ignored(pte, flags);
> >>>>>>      
> >>>>>> +		if (!pte_present(pte))
> >>>>>> +			break;
> >>>>>>      		if (!pte_same(pte, expected_pte))
> >>>>>>      			break;
> >>>>>
> >>>>> How could pte_same() suddenly match on a present and non-present PTE.
> >>>>
> >>>> In the problematic case pte.pte == 0 and expected_pte.pte == 0 as well.
> >>>> pte_same() returns a.pte == b.pte -> 0 == 0. Both are non-present PTEs.
> >>>
> >>> Observe that folio_pte_batch() was called *with a present pte*.
> >>>
> >>> do_zap_pte_range()
> >>> 	if (pte_present(ptent))
> >>> 		zap_present_ptes()
> >>> 			folio_pte_batch()
> >>>
> >>> How can we end up with an expected_pte that is !present, if it is based
> >>> on the provided pte that *is present* and we only used pte_advance_pfn()
> >>> to advance the pfn?
> >>
> >> I've been staring at the code for too long and don't see the issue.
> >>
> >> We even have
> >>
> >> VM_WARN_ON_FOLIO(!pte_present(pte), folio);
> >>
> >> So the initial pteval we got is present.
> >>
> >> I don't see how
> >>
> >> 	nr = pte_batch_hint(start_ptep, pte);
> >> 	expected_pte = __pte_batch_clear_ignored(pte_advance_pfn(pte, nr), flags);
> >>
> >> would suddenly result in !pte_present(expected_pte).
> > 
> > The issue is not happening in __pte_batch_clear_ignored but later in
> > following line:
> > 
> >    expected_pte = pte_advance_pfn(expected_pte, nr);
> > 
> > The issue seems to be in __pte function which converts PTE value to
> > pte_t in pte_advance_pfn, because warnings disappears when I change the
> > line to
> > 
> >    expected_pte = (pte_t){ .pte = pte_val(expected_pte) + (nr << PFN_PTE_SHIFT) };
> > 
> > The kernel probably uses __pte function from
> > arch/x86/include/asm/paravirt.h because it is configured with
> > CONFIG_PARAVIRT=y:
> > 
> >    static inline pte_t __pte(pteval_t val)
> >    {
> >    	return (pte_t) { PVOP_ALT_CALLEE1(pteval_t, mmu.make_pte, val,
> >    					  "mov %%rdi, %%rax", ALT_NOT_XEN) };
> >    }
> > 
> > I guess it might cause this weird magic, but I need more time to
> > understand what it does :)

I understand it slightly more. __pte() uses xen_make_pte(), which calls
pte_pfn_to_mfn(), however, mfn for this pfn contains INVALID_P2M_ENTRY
value, therefore the pte_pfn_to_mfn() returns 0, see [1].

I guess that the mfn was invalidated by xen-balloon driver?

[1] https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/xen/mmu_pv.c?h=v6.15-rc4#n408

> What XEN does with basic primitives that convert between pteval and 
> pte_t is beyond horrible.
> 
> How come set_ptes() that uses pte_next_pfn()->pte_advance_pfn() does not 
> run into this?

I don't know, but I guess it is somehow related to pfn->mfn translation.

> Is it only a problem if we exceed a certain pfn?

No, it is a problem if the corresponding mft to given pfn is invalid.

I am not sure if my original patch is a good fix. Maybe it would be
better to have some sort of native_pte_advance_pfn() which will use
native_make_pte() rather than __pte(). Or do you think the issue is in
Xen part?

Cheers,
Petr

