Return-Path: <stable+bounces-270386-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZXlyJ/BCRmpbNAsAu9opvQ
	(envelope-from <stable+bounces-270386-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 12:52:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A6086F639F
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 12:52:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=bJuZ7fPL;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270386-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-270386-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 538EE301E4F9
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 09:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3031F480DE9;
	Thu,  2 Jul 2026 09:36:39 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0A8480DFA
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 09:36:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782984999; cv=none; b=F9NDuSGX0jyxavdJgniddciv9wWmDRJrm5wfJ9ZgLp1GeBGH6QCT94tagKlTQ/iYzWGchqUqNb37F13p9NMMULcTTh6d8jCiNCX91APdMcfGW1MQZCwKmIhgI08NZyYKRe2763xPqXHyVACELnEjQi6LIssrgWo1tKssuuwZpmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782984999; c=relaxed/simple;
	bh=aFfdHKfLzaSMUrAgLzfY4FgQITyKbz5AWJ0VC4BuvUU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=rgixaO1Jk2XsKDRrO1nSGMPimig9mAGKI5KEHyj/Bb21/LOCrONlYDKvmd9BabIcpZzVwMNto4wM1RQwrENj0mmFucLUWOyd4yZ8hWOmfF9LLdZcjPBE73UaisVv1Z+3dKr5k3UGmNStKV70+rZOvXWhdNC1y5QiMA7b2mR17p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bJuZ7fPL; arc=none smtp.client-ip=91.218.175.183
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782984984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l6PG3+ZasElyMB/wFXcnxhyjCf0oibFJQuPCCw06o8E=;
	b=bJuZ7fPLGXg8b4OJI8rJg+op+KmCuoed6dszG81pHE422nuc8rKqnvB2ZsCZzcxQ/wtg+L
	eGV+IdW15bsX7k0P3sm2TxIG/eOrnntuvJY2dcPeOnPLEt81Yyg0HPFidUJOyV7pfRZBk4
	CBC6FiRgJV28WNd2nBKqYvAeWtjDIkA=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH v2 2/6] mm/rmap: use huge_ptep_get() in try_to_unmap_one()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <a6a00b38-612f-439d-9b75-337170e3af30@arm.com>
Date: Thu, 2 Jul 2026 17:35:24 +0800
Cc: riel@surriel.com,
 vbabka@kernel.org,
 harry@kernel.org,
 jannh@google.com,
 lance.yang@linux.dev,
 kas@kernel.org,
 linux-mm@kvack.org,
 linux-kernel@vger.kernel.org,
 rcampbell@nvidia.com,
 apopple@nvidia.com,
 ziy@nvidia.com,
 matthew.brost@intel.com,
 joshua.hahnjy@gmail.com,
 rakie.kim@sk.com,
 byungchul@sk.com,
 gourry@gourry.net,
 ying.huang@linux.alibaba.com,
 nao.horiguchi@gmail.com,
 ak@linux.intel.com,
 mel@csn.ul.ie,
 pfalcato@suse.de,
 jpoimboe@kernel.org,
 dave.hansen@intel.com,
 tglx@kernel.org,
 catalin.marinas@arm.com,
 will@kernel.org,
 linux-arm-kernel@lists.infradead.org,
 ryan.roberts@arm.com,
 anshuman.khandual@arm.com,
 stable@vger.kernel.org,
 osalvador@suse.de,
 akpm@linux-foundation.org,
 ljs@kernel.org,
 liam@infradead.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <CE6E9F6C-8891-40E3-A5B7-BA475070EACD@linux.dev>
References: <20260702051341.126509-1-dev.jain@arm.com>
 <20260702051341.126509-3-dev.jain@arm.com>
 <97a43d82-28c2-4f98-ad74-fe05ed9f0297@linux.dev>
 <a6a00b38-612f-439d-9b75-337170e3af30@arm.com>
To: Dev Jain <dev.jain@arm.com>,
 david@kernel.org
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270386-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:riel@surriel.com,m:vbabka@kernel.org,m:harry@kernel.org,m:jannh@google.com,m:lance.yang@linux.dev,m:kas@kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:rcampbell@nvidia.com,m:apopple@nvidia.com,m:ziy@nvidia.com,m:matthew.brost@intel.com,m:joshua.hahnjy@gmail.com,m:rakie.kim@sk.com,m:byungchul@sk.com,m:gourry@gourry.net,m:ying.huang@linux.alibaba.com,m:nao.horiguchi@gmail.com,m:ak@linux.intel.com,m:mel@csn.ul.ie,m:pfalcato@suse.de,m:jpoimboe@kernel.org,m:dave.hansen@intel.com,m:tglx@kernel.org,m:catalin.marinas@arm.com,m:will@kernel.org,m:linux-arm-kernel@lists.infradead.org,m:ryan.roberts@arm.com,m:anshuman.khandual@arm.com,m:stable@vger.kernel.org,m:osalvador@suse.de,m:akpm@linux-foundation.org,m:ljs@kernel.org,m:liam@infradead.org,m:dev.jain@arm.com,m:david@kernel.org,m:joshuahahnjy@gmail.com,m:naohoriguchi@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[muchun.song@linux.dev,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[surriel.com,kernel.org,google.com,linux.dev,kvack.org,vger.kernel.org,nvidia.com,intel.com,gmail.com,sk.com,gourry.net,linux.alibaba.com,linux.intel.com,csn.ul.ie,suse.de,arm.com,lists.infradead.org,linux-foundation.org,infradead.org];
	RCPT_COUNT_TWELVE(0.00)[36];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[muchun.song@linux.dev,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RWL_MAILSPIKE_POSSIBLE(0.00)[104.64.211.4:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linux.dev:dkim,linux.dev:mid,linux.dev:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9A6086F639F



> On Jul 2, 2026, at 17:08, Dev Jain <dev.jain@arm.com> wrote:
>=20
>=20
>=20
> On 02/07/26 2:17 pm, Muchun Song wrote:
>>=20
>>=20
>> On 2026/7/2 13:13, Dev Jain wrote:
>>> try_to_unmap_one() handles hugetlb folios when memory failure needs
>>> to replace a poisoned hugetlb mapping with a hwpoison entry. In that
>>> case page_vma_mapped_walk() returns the pte pointer to the hugetlb =
folio
>>> in pvmw.pte, but the code reads it with ptep_get().
>>>=20
>>> On arches which provide their own huge_ptep_get() to dereference a =
huge
>>> pte pointer, accessing via ptep_get() would cause pte_pfn(), =
pte_present()
>>> etc to misbehave.
>>>=20
>>> It is not clear whether this has a trivially visible effect to =
userspace.
>>>=20
>>> Just use huge_ptep_get() for dereferencing a huge pte pointer.
>>>=20
>>> Fixes: c7ab0d2fdc84 ("mm: convert try_to_unmap_one() to use =
page_vma_mapped_walk()")
>>> Cc: stable@vger.kernel.org
>>> Reported-by: David Hildenbrand <david@kernel.org>
>>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>>> ---
>>>   include/linux/hugetlb.h |  3 +++
>>>   mm/rmap.c               | 16 ++++++++++------
>>>   2 files changed, 13 insertions(+), 6 deletions(-)
>>>=20
>>> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
>>> index 2abaf99321e90..fdb7bdf7645c5 100644
>>> --- a/include/linux/hugetlb.h
>>> +++ b/include/linux/hugetlb.h
>>> @@ -1261,6 +1261,9 @@ static inline void hugetlb_count_sub(long l, =
struct mm_struct *mm)
>>>   {
>>>   }
>>>   +pte_t huge_ptep_get(struct mm_struct *mm, unsigned long addr,
>>> +            pte_t *ptep);
>>> +
>>=20
>> Maybe I didn't express my thoughts clearly in the first version, let =
me
>> explain in more detail.
>>=20
>> We should define this stub as a no-op for !CONFIG_HUGETLB_PAGE (like
>> set_huge_pte_at, that is why I mentioned 5d4af6195c87c6 for your =
reference
>> in your previous version). Currently, you've added a declaration, but =
the
>> function itself doesn't actually exist, which seems quite strange to =
me.
>=20
> =
https://lore.kernel.org/all/a4fe8ba6-2ecd-4bb9-95a9-27f9f1e87d2e@kernel.or=
g/
>=20
> David suggested this. Honestly I quite like David's suggestion, what =
do you
> think?

Thanks for pointing that out, I missed it earlier. That said, looking at
hugetlb.h, it already contains quite a few no-op stubs. To keep things
consistent, I'd personally prefer a stub here. Since David suggested =
this,
I=E2=80=99d love to hear his thoughts on this as well.

Muchun,
Thanks

>=20
>=20
>>=20
>> Muchun,
>> Thanks.
>>>   static inline pte_t huge_ptep_clear_flush(struct vm_area_struct =
*vma,
>>>                         unsigned long addr, pte_t *ptep)
>>>   {
>>> diff --git a/mm/rmap.c b/mm/rmap.c
>>> index 1c77d5dc06e9f..aa8a254efaecc 100644
>>> --- a/mm/rmap.c
>>> +++ b/mm/rmap.c
>>> @@ -2095,11 +2095,16 @@ static bool try_to_unmap_one(struct folio =
*folio, struct vm_area_struct *vma,
>>>           /* Unexpected PMD-mapped THP? */
>>>           VM_BUG_ON_FOLIO(!pvmw.pte, folio);
>>>   -        /*
>>> -         * Handle PFN swap PTEs, such as device-exclusive ones, =
that
>>> -         * actually map pages.
>>> -         */
>>> -        pteval =3D ptep_get(pvmw.pte);
>>> +        address =3D pvmw.address;
>>> +        if (folio_test_hugetlb(folio)) {
>>> +            pteval =3D huge_ptep_get(mm, address, pvmw.pte);
>>> +        } else {
>>> +            /*
>>> +             * Handle PFN swap PTEs, such as device-exclusive ones,
>>> +             * that actually map pages.
>>> +             */
>>> +            pteval =3D ptep_get(pvmw.pte);
>>> +        }
>>>           if (likely(pte_present(pteval))) {
>>>               pfn =3D pte_pfn(pteval);
>>>           } else {
>>> @@ -2110,7 +2115,6 @@ static bool try_to_unmap_one(struct folio =
*folio, struct vm_area_struct *vma,
>>>           }
>>>             subpage =3D folio_page(folio, pfn - folio_pfn(folio));
>>> -        address =3D pvmw.address;
>>>           anon_exclusive =3D folio_test_anon(folio) &&
>>>                    PageAnonExclusive(subpage);



