Return-Path: <stable+bounces-139168-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B17DAA4CFF
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 15:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8638350183F
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 13:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B239725D530;
	Wed, 30 Apr 2025 13:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=atlas.cz header.i=@atlas.cz header.b="Ot5fMR+R"
X-Original-To: stable@vger.kernel.org
Received: from gmmr-3.centrum.cz (gmmr-3.centrum.cz [46.255.225.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5FD248F6D;
	Wed, 30 Apr 2025 13:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.225.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746018271; cv=none; b=r3+ZtphIjzmy7vXLq7dXvHN9MnsZjNjxSnrJwWd8OO0s5SIkbUWWXaezWaH4Rav+mnzP4a56+KoO6OsjoClBs/d3MDTVcT5Jb96HiKX4OilQITijyNJ4bC3l33OnaOg1i1yZlZfdAzu59MEOZ6DJAalbZB/PxKbiwxfKI25VQjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746018271; c=relaxed/simple;
	bh=tBCNtEj6mDMXyxVFwZvbUlQrLWmMwLfnAa8S6aJ+xJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IQ/Jkv6qmS3HozJePU8ljTLTayZ+SPOvsTIzVSuaZBasc8hsu1EgfLczRFZgkYSvMDpArH7kFd6oCFNUwsDLvcYqYuNH12bI75psxwchw42/pvJPN9kpH0RAvv52qPetgUve/O7SJgEYwBOkKRS04Mm27xOwysUm2Hbvg+3DIdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atlas.cz; spf=pass smtp.mailfrom=atlas.cz; dkim=pass (1024-bit key) header.d=atlas.cz header.i=@atlas.cz header.b=Ot5fMR+R; arc=none smtp.client-ip=46.255.225.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atlas.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atlas.cz
Received: from gmmr-3.centrum.cz (localhost [127.0.0.1])
	by gmmr-3.centrum.cz (Postfix) with ESMTP id 68859203ACB0;
	Wed, 30 Apr 2025 15:04:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=atlas.cz; s=mail;
	t=1746018264; bh=yckTpz9nuwSH4blagUMkOsFHEZUjYb7TdIXN2ldZv0A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ot5fMR+RKmUweu3IuzIoDUDmFHaw0oWRSJADjRDkrwNuha+yLXc+s+qfIrf10fmet
	 luwJVQ/eoSIyM+SvVg+Fo//S03dV7HCeEBUst3PhnYfAkaDbQGphlWuytUYdpDqyEN
	 Tnv5jq28D+FsbStRFkcIxd+KuJO/brxIovKWYMvo=
Received: from antispam102.centrum.cz (antispam102.cent [10.30.208.102])
	by gmmr-3.centrum.cz (Postfix) with ESMTP id 555292009BF6;
	Wed, 30 Apr 2025 15:04:24 +0200 (CEST)
X-CSE-ConnectionGUID: 4CsVJaaFQImuUtztwlkyqg==
X-CSE-MsgGUID: j99rM2FtRUmO/tiLXzclzQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A2EtAABOHxJo/0vj/y5aGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUAJgTkDAQEBCwGCG4ElgWSEVZFxA4okiAWNaQ8BAQEBAQEBAQEJOwkEA?=
 =?us-ascii?q?QEDBDiESAKLNSc3Bg4BAgQBAQEBAwIDAQEBAQEBAQEBDQEBBgEBAQEBAQYGA?=
 =?us-ascii?q?QKBHYU1DAgyDYJiAYEkgSYBAQEBAQEBAQEBAQEdAg19AQEBAQIBIw8BRhAJA?=
 =?us-ascii?q?g0LAgImAgJWBhODAgGCLwEDDiMUlV+bS3qBMhoCZdxwAkkFVWOBJAaBGy4Bi?=
 =?us-ascii?q?E8BhWyEd0KCDYQHOD6IHoJpBIItgRaFeZgnUnscA1ksAVUTFwsHBYEmQwOBD?=
 =?us-ascii?q?yNLBS4dghGFIYIRgVwDAyIBgxN0HIRphFAtT4MvggJoRCNAAwttPTcUGwaWf?=
 =?us-ascii?q?INkBgFyAxksFwllgTg9w1qCQ4McgQmETodLlUozhAOTbQMZkksuh2WQaxuLc?=
 =?us-ascii?q?oF5my+BfYIAMyIwgyJSGYFtjE8WgRIBCIdWtgl2AjoCBwEKAQEDCYI7jXyBS?=
 =?us-ascii?q?wEB?=
IronPort-PHdr: A9a23:QnAtKR/rn5Kd8v9uWVy6ngc9DxPPW53KNwIYoqAql6hJOvz6uci5Z
 gqHvb430gGWA83y0LFttan/i+jYQ2sO4JKM4jgpUadncFsor/tTtCEbRPC/NEvgMfTxZDY7F
 skRHHVs/nW8LFQHUJ2mPw6arXK99yMdFQviPgRpOOv1BpTSj8Oq3Oyu5pHfeQpFiTSjbb9oM
 Bm6sQrdutcXjIZjKKs8ywbCr2dVdehR2W5nKlWfkgrm6Myt5pBj6SNQu/wg985ET6r3erkzQ
 KJbAjo7LW07/dXnuxbbQwSA/3cRTGoYnAdQDwfK8B/1UJHxsjDntuVmwymVIdf2TbEvVju86
 apgVQLlhz0GNz4992HXl9BwgadGqx+vuxBz34jZa5yOOfFgYq3SY88VRWtZXsZQSSNBBJ+8b
 5ASBOYFJOpUspXxq0cLoRa4GAKiBv7gyiVQi3H43aM0zfosHxzF0gwuEN0BrGnbotr3O6oJT
 eC4z7PFwSnfY/9K2zrw7pXDfBA7ofGLWLJ9adDfxlczFwPfk16fppbqPzWL0+QOrmOW6PBvV
 fisi2E9rgF+uCKvy9w2hYnVgoIa0EvE+T9lz4c0PNC1TlNwbtG4HpVKrS6aK5d2Td04Q2Fuo
 Cs0xbIIt5G4cSQUy5kqxxrSZviJfoSW4h/tVOKcLDd3in54ZL+yhBe//0avx+D9WMS530pHo
 jdZn9TOtX0A1wLe586aQfVz+Ueh3CyA1wHV6uxcIkA7i7DbK5g/zb40jJYTtl7DHiDwlU7rj
 6GWbl0p9+ep5uj9fLnrpp+RO5Vqhg3gMKkigM6yDOQgPgQQQmSW9/6w2KP98UHlWrlGkPI7n
 rXDvJ3eJMkWoLOyDRVP3YY58Rm/Ci+r0NEfnXYaMl1IYAmHj431O1HWJ/D4EOu/j0yskDh1w
 /DGOaXsAprILnTai7fheKp961ZBxAYu19xQ+4xbCrcdIPLpR0/xscbUAQM4MgCswubnDsty1
 p8GVG+AA6KVKr3evF+I6+41PeWAeo0YtCz/JvUl//LuiGU2mV4Zfamnx5sXb3W4E+x8LEWDY
 nrjmNIBHn0QvgclVuPqlFmCXiRIZ3qoQ6095yk3CJi6AofbWoCtnLuB0T+hHpxWfG9GDEqAE
 W3vd4qfRfgMcj6SItR6nzMeT7ihTpUt2g2ptA//07ZnNPbb+jUEtZL/09h4/+nTlRA09TxpA
 MWRymSNT2Rvk2MLWT85xrxwoU9nxleEy6h4jORUFcZP6PNRTgc6KZncwvRgBNDxQgLBe8yES
 FKnQtWgHDEwQcs9w9EJY0ZgHdWtkwrM3zarA78SkbyHHps08rjT33TpPcZy127G1LU9j1khW
 sZAKHephrB+9wfOHIPJiVuWmLuqdasGwC7B7nuMzW2LvE1ASg5/Tb3FXWwDZkvRtdn54kLCT
 7mzCbUoKwdBytCNKrFMatL3iVVLX+njONvAbGKrgWuwBgiHxqmKbIX0f2URxiLdCFILkwwL5
 3aJKRA+Bju9o2LZFDFuDk7vbFn3/ul6tny2VVE0zw6UYE17zba1+QAaheaaS/wN2rIIoiAhq
 y97HFql2dLZEMKPpxB9c6VEfdM9/FBH2HrYugBlI5OgLKFihlsGfgpvsE3h2Qt5BJlcnMYs/
 zsWy19IOKuemGlGfT6CwYu4bqfGI2+05helZrTKwXnXytPQ8aAKvqcWsVLm6TmkClBqzXxhc
 Nodh3KG5ZzPBRA6WI71W11x/Aos9OKSWTU0+46BjS4kCqKzqDKXnotxXIMY
IronPort-Data: A9a23:4YSGg6IQYr7cwUC3FE+R5pQlxSXFcZb7ZxGr2PjKsXjdYENShGEPm
 GRMCm3UO/rbYGryKownPNm38E9XuZ7czIIxGgMd+CA2RRqmiyZk6fd1jKvUF3nPRiEWZBs/t
 63yUvGZcYZpCCaa/krwWlTYhSEU/bmSQbbhA/LzNCl0RAt1IA8skhsLd9QR2+aEuvDnRVrQ0
 T/Oi5eHYgL9h2Usajt8B5+r8XuDgtyj5Vv0gXRhPZinjHeG/1EJAZQWI72GLneQauF8Au6gS
 u/f+6qy92Xf8g1FIovNfmHTLyXm6paLVeS/oiI+t5qK23CulQRuukoPD8fwXG8M49m/t4sol
 IgS78zYpTABZcUgkMxFO/VR/roX0aduoNcrKlDn2SCfItGvn9IBDJyCAWlvVbD09NqbDkkS3
 ucmCjkEQCmigv+L3KCnVe1vl90seZyD0IM34hmMzBnWCLM9RIzbGvyM7tJewC0tg4ZFD54yZ
 eJFN3w1MUmGOUcQfAhKYH49tL7Aan3XeidboVecv4I+/2za10p6wtABNfKMIo3RG5oOwhvwS
 mTu/TWoGDRAGsCl9D+itW6tot/dlifpYddHfFG/3rsw6LGJ/UQJGRQQE0G8q/SjllWWUshab
 UcT/0IGqak06VzuS9zVXAOxq33CuQQTM/JZEPU/wAWMzLfEpgieG24IRyJAb9pgs9U5LRQm3
 0GIk/vzCDBvuaHTQnWYnp+QrDWvKW0WIHUEaCssUwQI+Z/grZs1gxaJScxseIauktT/HTzY3
 T+Htm49iq8VgMpN0L+0lW0rmBrw+N6TE1NzvF+IGD34hu9kWLOYi0WTwQCzxZ59wEyxEgPpU
 KQs8yRG0N0zMA==
IronPort-HdrOrdr: A9a23:bZWd0q1yyyqcFZmrCjiJ4wqjBL8kLtp133Aq2lEZdPWaSKOlfu
 SV7ZEmPHjP+VIssRAb6LK90ca7K080maQZ3WBVB8bEYOCEghrKEGgB1+rfKlTbckWUygce78
 ddmsNFZuEYY2IXsfrH
X-Talos-CUID: =?us-ascii?q?9a23=3AoONU1moppTm89GAy5ZM5lZnmUZwOaUP/xX7+Gm6?=
 =?us-ascii?q?9FFt1WqGKTVyB4awxxg=3D=3D?=
X-Talos-MUID: 9a23:M2uZuwn1eeDb1ghXBsxbdnpgZZZyxv6AFHowlLJBp8igBT57PyWk2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.15,251,1739833200"; 
   d="scan'208";a="109367345"
Received: from unknown (HELO gm-smtp11.centrum.cz) ([46.255.227.75])
  by antispam102.centrum.cz with ESMTP; 30 Apr 2025 15:04:11 +0200
Received: from arkam (ip-213-220-240-96.bb.vodafone.cz [213.220.240.96])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gm-smtp11.centrum.cz (Postfix) with ESMTPSA id 37ACF100AE10D;
	Wed, 30 Apr 2025 15:04:10 +0200 (CEST)
Date: Wed, 30 Apr 2025 15:04:08 +0200
From: Petr =?utf-8?B?VmFuxJtr?= <arkamar@atlas.cz>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/1] mm: Fix folio_pte_batch() overcount with zero PTEs
Message-ID: <20254301348-aBIfyEmRyUx3zBBL-arkamar@atlas.cz>
References: <20250429142237.22138-1-arkamar@atlas.cz>
 <20250429142237.22138-2-arkamar@atlas.cz>
 <d53fd549-887f-4220-b0d1-ebc336eecb9f@redhat.com>
 <e9617001-da1d-4c4f-99f4-0e51d51d385e@arm.com>
 <bb24f0d3-cbbf-4323-a9e6-09a627c8559b@redhat.com>
 <cac9bf3c-5af1-41be-86a5-bf76384b5e3b@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cac9bf3c-5af1-41be-86a5-bf76384b5e3b@arm.com>

On Tue, Apr 29, 2025 at 04:02:10PM +0100, Ryan Roberts wrote:
> On 29/04/2025 15:46, David Hildenbrand wrote:
> > On 29.04.25 16:41, Ryan Roberts wrote:
> >> On 29/04/2025 15:29, David Hildenbrand wrote:
> >>> On 29.04.25 16:22, Petr Vaněk wrote:
> >>>> folio_pte_batch() could overcount the number of contiguous PTEs when
> >>>> pte_advance_pfn() returns a zero-valued PTE and the following PTE in
> >>>> memory also happens to be zero. The loop doesn't break in such a case
> >>>> because pte_same() returns true, and the batch size is advanced by one
> >>>> more than it should be.
> >>>>
> >>>> To fix this, bail out early if a non-present PTE is encountered,
> >>>> preventing the invalid comparison.
> >>>>
> >>>> This issue started to appear after commit 10ebac4f95e7 ("mm/memory:
> >>>> optimize unmap/zap with PTE-mapped THP") and was discovered via git
> >>>> bisect.
> >>>>
> >>>> Fixes: 10ebac4f95e7 ("mm/memory: optimize unmap/zap with PTE-mapped THP")
> >>>> Cc: stable@vger.kernel.org
> >>>> Signed-off-by: Petr Vaněk <arkamar@atlas.cz>
> >>>> ---
> >>>>    mm/internal.h | 2 ++
> >>>>    1 file changed, 2 insertions(+)
> >>>>
> >>>> diff --git a/mm/internal.h b/mm/internal.h
> >>>> index e9695baa5922..c181fe2bac9d 100644
> >>>> --- a/mm/internal.h
> >>>> +++ b/mm/internal.h
> >>>> @@ -279,6 +279,8 @@ static inline int folio_pte_batch(struct folio *folio,
> >>>> unsigned long addr,
> >>>>                dirty = !!pte_dirty(pte);
> >>>>            pte = __pte_batch_clear_ignored(pte, flags);
> >>>>    +        if (!pte_present(pte))
> >>>> +            break;
> >>>>            if (!pte_same(pte, expected_pte))
> >>>>                break;
> >>>
> >>> How could pte_same() suddenly match on a present and non-present PTE.
> >>>
> >>> Something with XEN is really problematic here.
> >>>
> >>
> >> We are inside a lazy MMU region (arch_enter_lazy_mmu_mode()) at this point,
> >> which I believe XEN uses. If a PTE was written then read back while in lazy mode
> >> you could get a stale value.
> >>
> >> See
> >> https://lore.kernel.org/all/912c7a32-b39c-494f-a29c-4865cd92aeba@agordeev.local/
> >> for an example bug.
> > 
> > So if we cannot trust ptep_get() output, then, ... how could we trust anything
> > here and ever possibly batch?
> 
> The point is that for a write followed by a read to the same PTE, the read may
> not return what was written. It could return the value of the PTE at the point
> of entry into the lazy mmu mode.
> 
> I guess one quick way to test is to hack out lazy mmu support. Something like
> this? (totally untested):

I (blindly) applied the suggested change but I am still seeing the same
issue.

Petr

> ----8<----
> diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
> index c4c23190925c..1f0a1a713072 100644
> --- a/arch/x86/include/asm/paravirt.h
> +++ b/arch/x86/include/asm/paravirt.h
> @@ -541,22 +541,6 @@ static inline void arch_end_context_switch(struct
> task_struct *next)
>         PVOP_VCALL1(cpu.end_context_switch, next);
>  }
> 
> -#define  __HAVE_ARCH_ENTER_LAZY_MMU_MODE
> -static inline void arch_enter_lazy_mmu_mode(void)
> -{
> -       PVOP_VCALL0(mmu.lazy_mode.enter);
> -}
> -
> -static inline void arch_leave_lazy_mmu_mode(void)
> -{
> -       PVOP_VCALL0(mmu.lazy_mode.leave);
> -}
> -
> -static inline void arch_flush_lazy_mmu_mode(void)
> -{
> -       PVOP_VCALL0(mmu.lazy_mode.flush);
> -}
> -
>  static inline void __set_fixmap(unsigned /* enum fixed_addresses */ idx,
>                                 phys_addr_t phys, pgprot_t flags)
>  {
> ----8<----
> 

