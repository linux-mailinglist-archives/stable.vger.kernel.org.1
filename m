Return-Path: <stable+bounces-139204-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5007FAA5112
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 18:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBA901C036A4
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 16:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9310225E444;
	Wed, 30 Apr 2025 16:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=atlas.cz header.i=@atlas.cz header.b="V0619FPV"
X-Original-To: stable@vger.kernel.org
Received: from gmmr-2.centrum.cz (gmmr-2.centrum.cz [46.255.227.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C3825C711;
	Wed, 30 Apr 2025 16:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.227.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746028867; cv=none; b=K/Y+aCkVIIC3GR4fsh+qm9Z03VasHh3/VsdjgkHu3x7SVV3mGeKs7lrYNKtatjhzIPBABVYbq6TfXW7MX+vPSua/qJtUD1/599I9XQ9rcBvwPbHiXL+K9zes6AnUhG1A/4MkQlKkYlorLShE2saZ6LonEVWEseMBQZ/DUxSulVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746028867; c=relaxed/simple;
	bh=nfXeek0lWmIcCt+6/OROdfThZajfS2E8OoaJYuMBoQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=poMcvImCufVzXsVdE1M8ZOBjb/GVse2AizsRA412mfHoyEMjFYobH1Yb2X3yUQhy+q0hMgHJ1Bh6puCL29qPV391TpoQw1U1BexAVBjX+0tngjpyKFe6LqdcMGmJagDhqa7JruG0DwUYU/zKJSCqYo5aLWUDC68+etsGlmEKe8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atlas.cz; spf=pass smtp.mailfrom=atlas.cz; dkim=pass (1024-bit key) header.d=atlas.cz header.i=@atlas.cz header.b=V0619FPV; arc=none smtp.client-ip=46.255.227.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atlas.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atlas.cz
Received: from gmmr-2.centrum.cz (localhost [127.0.0.1])
	by gmmr-2.centrum.cz (Postfix) with ESMTP id 1B6F12104EF6;
	Wed, 30 Apr 2025 18:00:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=atlas.cz; s=mail;
	t=1746028852; bh=IEGz03l40qR25MIU7Cu5Wz9iz11CujXu8KMLfgmvnWw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V0619FPV4NZQM775dUT+9bOMQL2mg+4AZRAxyiZMED8HlXi5qVo1Ulva1Dv9r5H/T
	 4NNDnj9R7r2/TeMuVt/+yTwnpIe7BANxaKulUsTutXJzvFUZ96rDOpJ8LI/mL24VlQ
	 p3shnZEPLTJs9jTt6CPt3rT04JhI+4rnAHXsIwQU=
Received: from antispam30.centrum.cz (antispam30.cent [10.30.208.30])
	by gmmr-2.centrum.cz (Postfix) with ESMTP id 05491203FF6F;
	Wed, 30 Apr 2025 18:00:51 +0200 (CEST)
X-CSE-ConnectionGUID: SthcfhkjSvaf7QqPnN3/bQ==
X-CSE-MsgGUID: wvxHGg76S865EOXCF4RrJg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A2EPAABnSBJo/03h/y5aGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUAJgTcFAQEBCwGDQIFkhFWRcQOBE4kRiAWLaxSBag8BAQEBAQEBAQEJP?=
 =?us-ascii?q?QcEAQEDBDiESAKLNic1CA4BAgQBAQEBAwIDAQEBAQEBAQEBDQEBBgEBAQEBA?=
 =?us-ascii?q?QYGAQKBHYU1Rg2CYgGBJIEmAQEBAQEBAQEBAQEBHQINfQEBAQEDIwQLAUYQC?=
 =?us-ascii?q?w0EAwECAQICJgICTggGCgmDAgGCLwEDMRSyD3p/MxoCZdxwAkkFVWOBJAaBG?=
 =?us-ascii?q?y4BiE8BhWyEd0KCDYEVgnI4PoJKFwQYgS2DdIJpBIItgRaFeY0VixNSexwDW?=
 =?us-ascii?q?SwBVRMXCwcFgSZDA4EPI0sFLh2CEYUhghGBXAMDIgGDE3QchGmEUC1Pgy+CA?=
 =?us-ascii?q?mhEJUADC209NxQbBpZ8g2QGAT01HBwQFwllEy3FD4JDgxyBCYROh0uVSjOXc?=
 =?us-ascii?q?AOSZC6HZZBrG41rmy+BUBkCghIzIjCDIlIZl0O2PXYCAQEBNwIHAQoBAQMJg?=
 =?us-ascii?q?juOCYFLAQE?=
IronPort-PHdr: A9a23:rJKYXBOoipIV0EqgL9Yl6nZFCxdPi9zP1u491JMrhvp0f7i5+Ny6Z
 QqDvq8r1AeCB9uEsqsMotGVmp6jcFRI2YyGvnEGfc4EfD4+ouJSsioeReWoMgnFFsPsdDEwB
 89YVVVorDmROElRH9viNRWJ+iXhpTEdFQ/iOgVrO+/7BpDdj9it1+C15pbffxhEiCCybL58M
 hm6txndutUZjYd8K6s8yAbFrmZVcOlK2G1kIk6ekBn76sqs5pBo7j5eu+gm985OUKX6e7o3Q
 LlFBzk4MG47+dPmuwDbQQWA/nUTXXwanwRHDQbY9B31UYv/vSX8tupmxSmVJtb2QqwuWTSj9
 KhkVhnlgzoaOjEj8WHXjstwjL9HoB+kuhdyzZLYbJ2TOfFjZa7WY88USnRdUcZQTyxBA52zb
 40TD+oaIO1Uq5Dxq0YSoReiAAWhAv7kxD1ViX/sxaA03eQvHx/Y0QI9HNwOvnvbo8noO6kdU
 ++417XIwDbZYv9KxTvx9IrFfxY8qv+MR7Jwds/RxFE1GQzbklWQs5HuMDyP2eQLrW2b7PdrW
 OW1hG49qAF+uD2vyd02ioTSnI0V1lTE+j9iwIovOdK5SVd2bNi5G5Rfqy+ULZF5Qt8+Q252o
 iY6zKULt5G0ciYFy5kr2R3SZvyDfoWM7B/vSuacLzd8iX9ld7yzmgq//Euhx+PyWcS50VhHo
 yVZn9XRqn0A1R/e58iZR/Z740yv1zGP1wXJ5eFFJ0A5janbJIA7wr42iJUTtV7PHijsmEX5i
 qKda0Yq+vCw5unoY7jqvIGQOo90hw3kLKgihMyyDf46PwUMR2SX5/mw2bP58UHnXrlGkuc6n
 rfWvZzGP8gWoq+0DglI2Yg58Rm/FS2p0NEAkHkCK1JKZQyIgpDyO1HLPPD4FfC/g0mwkDtzx
 /DJILnhApLVI3jMlbftZK1960tAyAor0NxT+4hYBa0fL/L1Rk/xrsHYDhojPwOowufrENR91
 oUAVmKTGqKUP6LfvUWW6u8vI+SAfpEZtCj9JvQ/5fPjj2c1mVoHcqmo2ZsXZmq4HvNjI0iBe
 3XsmNQBHn0PvgUkVuznk0eNUSJXZ3moRKIw/C00CYO+AYfZWo+tmKCB3Du8HpBOfGBHCkqDE
 XHye4WeXPcDczydItV9kjwfTrWuUZUh1RS0uADmzLpnK/LY+jcEupL7yNh1++rTmAk29Tx1C
 cSdzm6MQ3hxnmMNXDI2375/rlZhxVeAy6R4hOZYFdNL6/NTTgg6LYLcz/B9C93qQA3Bfc+JS
 FO9T9WiADExSM8xwtAXb0ZzHNWikxbD0DewDL8JlryLA5o0/rjb33jrKMZx02zG27U5j1k6X
 stPMnWribNl+AjNBo7Gjl6Ul7y0eqsB3C7C7nuDwXCSs0FfVQ58Sb/FUmwHZkvKsdT54VvPT
 7uvCbQhLwtAxteOKqhUZd3zi1VJWvPjNc/AY2K+hWiwHwyExrCSY4rwfWUSwiHdBFIDkwAJ8
 naKLRI+CTu5o2LCEDxuEkriY1jw8eZks3y7SlE7whqUb01uybW14AQZhf+CRPMJ2LILpiMhp
 y9zHFan0NLaE9yAqBF5c6VGfdw9+EtH1X7etwFlP5GsN71thl0fcwRyp07gzxp5BYten8Y2s
 H4kylk6FaXN/Fpfdj/Q/ZH0NrDRIHP7+hznP6LfxFDS+Myb9qcG9LIzrFC17y+zEU93y3h7y
 ZFr2n0/5d2eBRARWJf4SG4+6xxzvPfRcH9utMvvyXRwPPzs4Xf50NUzCb5gk074F+o=
IronPort-Data: A9a23:HplN+qy9xmw/xx8Bknh6t+cBxyrEfRIJ4+MujC+fZmUNrF6WrkUHz
 2oaXT2DPfzYMGP8Kt0ibo2//UlX6sTUytJnQAJu+FhgHilAwSbn6XV1DatS0we6dJCroJdPt
 p1GAjX4BJlpCCKa/1H1b+WJQUBUjcmgXqD7BPPPJhd/TAplTDZJoR94kobVuKYx6TSCK13L4
 I6aT/H3Ygf/hmYoaTpMsMpvlTs21BjMkGJF1rABTa8T1LPuvyF9JI4SI6i3M0z5TuF8dsamR
 /zOxa2O5WjQ+REgELuNyt4XpWVXKlJ6FVHmZkt+A8BOsDAbzsAB+vpT2M4nVKtio27hc+ZZk
 4wR6MPqGW/FCYWX8AgVe0Ew/yiTpsSq8pefSZS0mZT7I0Er7xIAahihZa07FdRwxwp5PY1B3
 ccEKDsDbhOBvPy/zu2CU9FqoJ9kJvC+aevzulk4pd3YJfkjBIvGX72TvZlT0TEsnN1LW/3MD
 yYbQWYxKk6dPlsVYApRV81WcOSA3xETdxVRslGcoKMty2HPyAVqlrP/WDbQUofTFZQNxBrA/
 woq+UzmHAE6G9PAlwHVrC+Bod/ks3/BQqAdQejQGvlCxQf7KnYoIAcHXF39u/6zh1SiQPpWM
 UlS8S0rxYA29Uq2Xpz4WjW7vnePvVgbQdU4O+Q58ASlzqvS/hbcCG8ZSDJIdN0hsokxXzNC/
 lOAgdLlLSZivL2cVTSW8bL8hTezPzUFaGwPfykJSSMb7NT55oI+lBTCSpBkCqHdpsbpEDv0z
 hiUoyUkwbYel8gG0+O851+vvt63jsSXCFRou0ONBD/jsVwRiJOZWrFEIGPztZ5oRLt1hHHY5
 CRsdxS2hAzWMaywqQ==
IronPort-HdrOrdr: A9a23:qya/u6ho/2mPZ2+pF5USmSFPd3BQXtcji2hC6mlwRA09TyVXra
 +TddAgpHrJYVEqKRUdcLG7Scu9qBznn6KdjbN9AV7mZniAhILKFvAA0WKB+Vzd8kTFn4Y36U
 4jSchD4bbLY2SS4/yX3DWF
X-Talos-CUID: 9a23:w5rlKW23SGtOccTI1B7BIrxfIdwleXPdz3XrPUa2Vl9wcLuzEhiawfYx
X-Talos-MUID: =?us-ascii?q?9a23=3AWLhh+w356nnCNypM6CNb6DL3wjUj/Lq+KG8Czss?=
 =?us-ascii?q?965fZGAtAEBnBti6VTdpy?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.15,252,1739833200"; 
   d="scan'208";a="318902401"
Received: from unknown (HELO gm-smtp10.centrum.cz) ([46.255.225.77])
  by antispam30.centrum.cz with ESMTP; 30 Apr 2025 18:00:39 +0200
Received: from arkam (ip-213-220-240-96.bb.vodafone.cz [213.220.240.96])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gm-smtp10.centrum.cz (Postfix) with ESMTPSA id 47AF48091193;
	Wed, 30 Apr 2025 18:00:39 +0200 (CEST)
Date: Wed, 30 Apr 2025 18:00:37 +0200
From: Petr =?utf-8?B?VmFuxJtr?= <arkamar@atlas.cz>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Ryan Roberts <ryan.roberts@arm.com>, linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/1] mm: Fix folio_pte_batch() overcount with zero PTEs
Message-ID: <202543016037-aBJJJdupFVd_6FTX-arkamar@atlas.cz>
References: <20250429142237.22138-1-arkamar@atlas.cz>
 <20250429142237.22138-2-arkamar@atlas.cz>
 <d53fd549-887f-4220-b0d1-ebc336eecb9f@redhat.com>
 <2025429144547-aBDmGzJBQc9RMBj--arkamar@atlas.cz>
 <ef317615-3e26-4641-8141-4d3913ced47f@redhat.com>
 <b6613b71-3eb9-4348-9031-c1dd172b9814@redhat.com>
 <2025429183321-aBEbcQQY3WX6dsNI-arkamar@atlas.cz>
 <1df577bb-eaba-4e34-9050-309ee1c7dc57@redhat.com>
 <202543011526-aBIO5nq6Olsmq2E--arkamar@atlas.cz>
 <9c412f4f-3bdf-43c0-a3cd-7ce52233f4e5@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9c412f4f-3bdf-43c0-a3cd-7ce52233f4e5@redhat.com>

On Wed, Apr 30, 2025 at 04:37:21PM +0200, David Hildenbrand wrote:
> On 30.04.25 13:52, Petr Vaněk wrote:
> > On Tue, Apr 29, 2025 at 08:56:03PM +0200, David Hildenbrand wrote:
> >> On 29.04.25 20:33, Petr Vaněk wrote:
> >>> On Tue, Apr 29, 2025 at 05:45:53PM +0200, David Hildenbrand wrote:
> >>>> On 29.04.25 16:52, David Hildenbrand wrote:
> >>>>> On 29.04.25 16:45, Petr Vaněk wrote:
> >>>>>> On Tue, Apr 29, 2025 at 04:29:30PM +0200, David Hildenbrand wrote:
> >>>>>>> On 29.04.25 16:22, Petr Vaněk wrote:
> >>>>>>>> folio_pte_batch() could overcount the number of contiguous PTEs when
> >>>>>>>> pte_advance_pfn() returns a zero-valued PTE and the following PTE in
> >>>>>>>> memory also happens to be zero. The loop doesn't break in such a case
> >>>>>>>> because pte_same() returns true, and the batch size is advanced by one
> >>>>>>>> more than it should be.
> >>>>>>>>
> >>>>>>>> To fix this, bail out early if a non-present PTE is encountered,
> >>>>>>>> preventing the invalid comparison.
> >>>>>>>>
> >>>>>>>> This issue started to appear after commit 10ebac4f95e7 ("mm/memory:
> >>>>>>>> optimize unmap/zap with PTE-mapped THP") and was discovered via git
> >>>>>>>> bisect.
> >>>>>>>>
> >>>>>>>> Fixes: 10ebac4f95e7 ("mm/memory: optimize unmap/zap with PTE-mapped THP")
> >>>>>>>> Cc: stable@vger.kernel.org
> >>>>>>>> Signed-off-by: Petr Vaněk <arkamar@atlas.cz>
> >>>>>>>> ---
> >>>>>>>>       mm/internal.h | 2 ++
> >>>>>>>>       1 file changed, 2 insertions(+)
> >>>>>>>>
> >>>>>>>> diff --git a/mm/internal.h b/mm/internal.h
> >>>>>>>> index e9695baa5922..c181fe2bac9d 100644
> >>>>>>>> --- a/mm/internal.h
> >>>>>>>> +++ b/mm/internal.h
> >>>>>>>> @@ -279,6 +279,8 @@ static inline int folio_pte_batch(struct folio *folio, unsigned long addr,
> >>>>>>>>       			dirty = !!pte_dirty(pte);
> >>>>>>>>       		pte = __pte_batch_clear_ignored(pte, flags);
> >>>>>>>>       
> >>>>>>>> +		if (!pte_present(pte))
> >>>>>>>> +			break;
> >>>>>>>>       		if (!pte_same(pte, expected_pte))
> >>>>>>>>       			break;
> >>>>>>>
> >>>>>>> How could pte_same() suddenly match on a present and non-present PTE.
> >>>>>>
> >>>>>> In the problematic case pte.pte == 0 and expected_pte.pte == 0 as well.
> >>>>>> pte_same() returns a.pte == b.pte -> 0 == 0. Both are non-present PTEs.
> >>>>>
> >>>>> Observe that folio_pte_batch() was called *with a present pte*.
> >>>>>
> >>>>> do_zap_pte_range()
> >>>>> 	if (pte_present(ptent))
> >>>>> 		zap_present_ptes()
> >>>>> 			folio_pte_batch()
> >>>>>
> >>>>> How can we end up with an expected_pte that is !present, if it is based
> >>>>> on the provided pte that *is present* and we only used pte_advance_pfn()
> >>>>> to advance the pfn?
> >>>>
> >>>> I've been staring at the code for too long and don't see the issue.
> >>>>
> >>>> We even have
> >>>>
> >>>> VM_WARN_ON_FOLIO(!pte_present(pte), folio);
> >>>>
> >>>> So the initial pteval we got is present.
> >>>>
> >>>> I don't see how
> >>>>
> >>>> 	nr = pte_batch_hint(start_ptep, pte);
> >>>> 	expected_pte = __pte_batch_clear_ignored(pte_advance_pfn(pte, nr), flags);
> >>>>
> >>>> would suddenly result in !pte_present(expected_pte).
> >>>
> >>> The issue is not happening in __pte_batch_clear_ignored but later in
> >>> following line:
> >>>
> >>>     expected_pte = pte_advance_pfn(expected_pte, nr);
> >>>
> >>> The issue seems to be in __pte function which converts PTE value to
> >>> pte_t in pte_advance_pfn, because warnings disappears when I change the
> >>> line to
> >>>
> >>>     expected_pte = (pte_t){ .pte = pte_val(expected_pte) + (nr << PFN_PTE_SHIFT) };
> >>>
> >>> The kernel probably uses __pte function from
> >>> arch/x86/include/asm/paravirt.h because it is configured with
> >>> CONFIG_PARAVIRT=y:
> >>>
> >>>     static inline pte_t __pte(pteval_t val)
> >>>     {
> >>>     	return (pte_t) { PVOP_ALT_CALLEE1(pteval_t, mmu.make_pte, val,
> >>>     					  "mov %%rdi, %%rax", ALT_NOT_XEN) };
> >>>     }
> >>>
> >>> I guess it might cause this weird magic, but I need more time to
> >>> understand what it does :)
> > 
> > I understand it slightly more. __pte() uses xen_make_pte(), which calls
> > pte_pfn_to_mfn(), however, mfn for this pfn contains INVALID_P2M_ENTRY
> > value, therefore the pte_pfn_to_mfn() returns 0, see [1].
> > 
> > I guess that the mfn was invalidated by xen-balloon driver?
> > 
> > [1] https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/xen/mmu_pv.c?h=v6.15-rc4#n408
> > 
> >> What XEN does with basic primitives that convert between pteval and
> >> pte_t is beyond horrible.
> >>
> >> How come set_ptes() that uses pte_next_pfn()->pte_advance_pfn() does not
> >> run into this?
> > 
> > I don't know, but I guess it is somehow related to pfn->mfn translation.
> > 
> >> Is it only a problem if we exceed a certain pfn?
> > 
> > No, it is a problem if the corresponding mft to given pfn is invalid.
> > 
> > I am not sure if my original patch is a good fix.
> 
> No :)
> 
> Maybe it would be
> > better to have some sort of native_pte_advance_pfn() which will use
> > native_make_pte() rather than __pte(). Or do you think the issue is in
> > Xen part?
> 
> I think what's happening is that -- under XEN only -- we might get garbage when
> calling pte_advance_pfn() and the next PFN would no longer fall into the folio. And
> the current code cannot deal with that XEN garbage.
> 
> But still not 100% sure.
> 
> The following is completely untested, could you give that a try?

Yes, it solves the issue for me.

However, maybe it would be better to solve it with the following patch.
The pte_pfn_to_mfn() actually returns the same value for non-present
PTEs. I suggest to return original PTE if the mfn is INVALID_P2M_ENTRY,
rather than empty non-present PTE, but the _PAGE_PRESENT bit will be set
to zero. Thus, we will not loose information about original pfn but it
will be clear that the page is not present.

From e84781f9ec4fb7275d5e7629cf7e222466caf759 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Petr=20Van=C4=9Bk?= <arkamar@atlas.cz>
Date: Wed, 30 Apr 2025 17:08:41 +0200
Subject: [PATCH] x86/mm: Reset pte _PAGE_PRESENT bit for invalid mft
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Signed-off-by: Petr Vaněk <arkamar@atlas.cz>
---
 arch/x86/xen/mmu_pv.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index 38971c6dcd4b..92a6a9af0c65 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -392,28 +392,25 @@ static pteval_t pte_mfn_to_pfn(pteval_t val)
 static pteval_t pte_pfn_to_mfn(pteval_t val)
 {
 	if (val & _PAGE_PRESENT) {
 		unsigned long pfn = (val & PTE_PFN_MASK) >> PAGE_SHIFT;
 		pteval_t flags = val & PTE_FLAGS_MASK;
 		unsigned long mfn;
 
 		mfn = __pfn_to_mfn(pfn);
 
 		/*
-		 * If there's no mfn for the pfn, then just create an
-		 * empty non-present pte.  Unfortunately this loses
-		 * information about the original pfn, so
-		 * pte_mfn_to_pfn is asymmetric.
+		 * If there's no mfn for the pfn, then just reset present pte bit.
 		 */
 		if (unlikely(mfn == INVALID_P2M_ENTRY)) {
-			mfn = 0;
-			flags = 0;
+			mfn = pfn;
+			flags &= ~_PAGE_PRESENT;
 		} else
 			mfn &= ~(FOREIGN_FRAME_BIT | IDENTITY_FRAME_BIT);
 		val = ((pteval_t)mfn << PAGE_SHIFT) | flags;
 	}
 
 	return val;
 }
 
 __visible pteval_t xen_pte_val(pte_t pte)
 {
-- 
2.48.1


