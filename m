Return-Path: <stable+bounces-268730-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ++TxI2z9PWpS+AgAu9opvQ
	(envelope-from <stable+bounces-268730-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 06:17:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE6A6CA165
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 06:17:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=tU4auLan;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268730-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268730-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD720302E412
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 04:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A54E25B094;
	Fri, 26 Jun 2026 04:17:44 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD8B78F2B;
	Fri, 26 Jun 2026 04:17:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782447463; cv=none; b=synGBhE6R7CPXhgGb6QdYURxdOUMiGO4/F/EaHDaGVsgqDAUUhva3oUPL+TLbUhofmfrdGWymhQVwgJtO3yehC4utfuWvofWNAxowhE4OkWKkol/72r8QWz5v1XIUiCKXmqnNVUOKsGTpA7KosUE16eb6tAftLfRNr+cCg4LodM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782447463; c=relaxed/simple;
	bh=QAzu5UjlSbz6C9zs1JEWdI4j4aEcleaku/Mfot+onhg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=XTwrMSNQV+EP0O8U/kDnB5Dj0HU8lQEkEEopUTPELaU+/O3R0HyEQin4Z/bFp3KCFueitBDWLiHVr1e0l7INGXZaY7bGtk+2dGrFtJ5XXLG5BrWzmGPcuvoJMn+hsnXnXSlx/gAv5V0Atavun0jKIEU5IgqvoulWfv9snLwYCyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tU4auLan; arc=none smtp.client-ip=91.218.175.178
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782447417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XOkT4HE4MTvk1wZ4w40cb5pP0zMW5GgLzCncJ/GrFKA=;
	b=tU4auLanIoznu++bAndccmy95kBQZM3vq3F5BJdIdB3bzdmwcKIzlcD38N7fNciBZ/LSMH
	FmoUliuhEWquBQUxpNJpE5YaDbsYyNkQL31Ss1/hRuoD6Ntulu0n0evwIVXfNH2VKUj639
	Q9BDEF4Ep3G7a4GsovfzVtNZszPAUak=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH 1/5] mm/rmap: use huge_ptep_get() in try_to_unmap_one()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <4619650f-28b5-4fb4-91be-50daa0b4d84b@arm.com>
Date: Fri, 26 Jun 2026 12:16:16 +0800
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
 mel@csn.ul.ie,
 nao.horiguchi@gmail.com,
 ak@linux.intel.com,
 j-nomura@ce.jp.nec.com,
 pfalcato@suse.de,
 dave.hansen@intel.com,
 tglx@kernel.org,
 jpoimboe@kernel.org,
 ryan.roberts@arm.com,
 anshuman.khandual@arm.com,
 stable@vger.kernel.org,
 osalvador@suse.de,
 akpm@linux-foundation.org,
 ljs@kernel.org,
 david@kernel.org,
 liam@infradead.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <EF014590-F5F0-4B9A-9C6A-C4EAC8187237@linux.dev>
References: <20260625112955.3254283-1-dev.jain@arm.com>
 <20260625112955.3254283-2-dev.jain@arm.com>
 <f8516534-3b18-4988-b384-251225755285@linux.dev>
 <4619650f-28b5-4fb4-91be-50daa0b4d84b@arm.com>
To: Dev Jain <dev.jain@arm.com>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268730-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[muchun.song@linux.dev,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[34];
	FORGED_RECIPIENTS(0.00)[m:riel@surriel.com,m:vbabka@kernel.org,m:harry@kernel.org,m:jannh@google.com,m:lance.yang@linux.dev,m:kas@kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:rcampbell@nvidia.com,m:apopple@nvidia.com,m:ziy@nvidia.com,m:matthew.brost@intel.com,m:joshua.hahnjy@gmail.com,m:rakie.kim@sk.com,m:byungchul@sk.com,m:gourry@gourry.net,m:ying.huang@linux.alibaba.com,m:mel@csn.ul.ie,m:nao.horiguchi@gmail.com,m:ak@linux.intel.com,m:j-nomura@ce.jp.nec.com,m:pfalcato@suse.de,m:dave.hansen@intel.com,m:tglx@kernel.org,m:jpoimboe@kernel.org,m:ryan.roberts@arm.com,m:anshuman.khandual@arm.com,m:stable@vger.kernel.org,m:osalvador@suse.de,m:akpm@linux-foundation.org,m:ljs@kernel.org,m:david@kernel.org,m:liam@infradead.org,m:dev.jain@arm.com,m:joshuahahnjy@gmail.com,m:naohoriguchi@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[surriel.com,kernel.org,google.com,linux.dev,kvack.org,vger.kernel.org,nvidia.com,intel.com,gmail.com,sk.com,gourry.net,linux.alibaba.com,csn.ul.ie,linux.intel.com,ce.jp.nec.com,suse.de,arm.com,linux-foundation.org,infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[muchun.song@linux.dev,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,arm.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DEE6A6CA165



> On Jun 26, 2026, at 12:03, Dev Jain <dev.jain@arm.com> wrote:
>=20
>=20
>=20
> On 26/06/26 8:47 am, Muchun Song wrote:
>>=20
>>=20
>> On 2026/6/25 19:29, Dev Jain wrote:
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
>>=20
>> Thanks so much for the fix! I'm curious, though: why do we
>> need to add a separate declaration for this function here?
>=20
> For !CONFIG_HUGETLB_PAGE, compiler complains that there is no =
huge_ptep_get.
> So this is to make compiler happy.

Got it. We can refer to 5d4af6195c87c6b162b7963e0ad00a214b80d764 to fix
this warning.

Muchun,
Thanks.

>=20
>>=20
>> Thanks,
>> Muchun
>>=20
>>> +
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



