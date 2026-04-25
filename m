Return-Path: <stable+bounces-241099-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPWoKr9l7GnEYQAAu9opvQ
	(envelope-from <stable+bounces-241099-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 25 Apr 2026 08:57:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 192464653D1
	for <lists+stable@lfdr.de>; Sat, 25 Apr 2026 08:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C4BAE301BA67
	for <lists+stable@lfdr.de>; Sat, 25 Apr 2026 06:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122B31B6D1A;
	Sat, 25 Apr 2026 06:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AylBSejQ"
X-Original-To: stable@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5666840DFB9
	for <stable@vger.kernel.org>; Sat, 25 Apr 2026 06:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777100218; cv=none; b=PgBUCxb/yrLhjBP+Svpon/R89e3qt0MAllOXsxadzfM7izXGM6pQnfBJj64e3JZl30VyghmoM0spuY5uDJnHgoKqvZojIinb3l05V69UaCmpW5ICpZLakNv+eTDw1w325uQJ7ANk+PEmCnsi1t20t3FlvbifLS/vIt9BZRkYBe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777100218; c=relaxed/simple;
	bh=PCKWRYcRVhHyn9+FOkoch9VrN0q6oEX4cgOj9wVnvrQ=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=qbFXespR9cTzddPc2hh/b4ezuJNJjQItMIpS2I68eDaCGomxzzsvCA5H/Xzeu/NOK3AKXyqOcyyqM6teDfvalApBE1XqLi2jmkCsqGWR84blOuyZRz5U4aUZFfgQAzXLKcXPSAXSUZHckkufr7gWnN4xBpOV22Hvix9Z6H6C64Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AylBSejQ; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain; charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777100215;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zYW2ifPKRCyV2PZsOeVHbuMLyGxnS6SER91CdDGNAFY=;
	b=AylBSejQND587ibmfjqlB+qxK/iMR3t6ePfxNQ/RCPD5Bn1YQY3gQxZPjp6uA1fwooxo0r
	MFccirkxba+ZFLzmxT0TETdP1wZKBks/Kn/wJycgtRE1uukvpHOZLMK3RN8kZX+h6D+f8A
	VUjicK463RCC1H+5n817ZUiXvfh8Ftc=
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v6 4/7] mm/sparse-vmemmap: Fix DAX vmemmap accounting with optimization
Date: Sat, 25 Apr 2026 14:56:14 +0800
Message-Id: <7B037C2B-A0DE-4C49-9BFF-4B4D999A218D@linux.dev>
References: <2e664019-f161-44d9-a3fa-74c4d8290345@kernel.org>
Cc: Muchun Song <songmuchun@bytedance.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Oscar Salvador <osalvador@suse.de>, Michael Ellerman <mpe@ellerman.id.au>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Lorenzo Stoakes <ljs@kernel.org>, Liam R Howlett <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>,
 aneesh.kumar@linux.ibm.com, joao.m.martins@oracle.com, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
In-Reply-To: <2e664019-f161-44d9-a3fa-74c4d8290345@kernel.org>
To: David Hildenbrand <david@kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 192464653D1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241099-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[bytedance.com,linux-foundation.org,suse.de,ellerman.id.au,linux.ibm.com,kernel.org,oracle.com,google.com,suse.com,gmail.com,kvack.org,lists.ozlabs.org,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[muchun.song@linux.dev,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:mid]



> On Apr 25, 2026, at 14:47, David Hildenbrand (Arm) <david@kernel.org> wrot=
e:
>=20
> =EF=BB=BFOn 4/25/26 08:20, Muchun Song wrote:
>>=20
>>=20
>>>> On Apr 25, 2026, at 13:48, David Hildenbrand (Arm) <david@kernel.org> w=
rote:
>>>=20
>>> =EF=BB=BF
>>>>=20
>>>>=20
>>>> Hi David,
>>>>=20
>>>> Sorry, I missed the 1GB hugepage scenario earlier. Given that sparse_ad=
d_section()
>>>> operates on a scale between PAGES_PER_SUBSECTION and PAGES_PER_SECTION,=
 the pfn and
>>>> nr_pages parameters wouldn't be aligned with the hugepage size (pages_p=
er_compound),
>>>> but rather with the PAGES_PER_SECTION boundary. Do you think this expla=
nation makes
>>>> it clearer? In the interest of code clarity, do you think the modificat=
ion below
>>>> makes it easier to follow?
>>>>=20
>>>> diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
>>>> index 2e642c5ff3f2..ce675c5fb94d 100644
>>>> --- a/mm/sparse-vmemmap.c
>>>> +++ b/mm/sparse-vmemmap.c
>>>> @@ -658,15 +658,18 @@ static int __meminit section_nr_vmemmap_pages(uns=
igned long pfn, unsigned long n
>>>>       const unsigned int order =3D pgmap ? pgmap->vmemmap_shift : 0;
>>>>       const unsigned long pages_per_compound =3D 1UL << order;
>>>>=20
>>>> -       VM_WARN_ON_ONCE(!IS_ALIGNED(pfn | nr_pages,
>>>> -                                   min(pages_per_compound, PAGES_PER_S=
ECTION)));
>>>> +       VM_WARN_ON_ONCE(!IS_ALIGNED(pfn | nr_pages, PAGES_PER_SUBSECTIO=
N));
>>>=20
>>> That here makes sense. We can only add/remove in multiples of PAGES_PER_=
SECTION.
>>> I think what we are saying is that we want that check in addition to the=

>>> existing min() check.
>>=20
>> Right.
>>=20
>>>=20
>>>>       VM_WARN_ON_ONCE(pfn_to_section_nr(pfn) !=3D pfn_to_section_nr(pfn=
 + nr_pages - 1));
>>>>=20
>>>>       if (!vmemmap_can_optimize(altmap, pgmap))
>>>>               return DIV_ROUND_UP(nr_pages * sizeof(struct page), PAGE_=
SIZE);
>>>>=20
>>>> -       if (order < PFN_SECTION_SHIFT)
>>>> +       if (order < PFN_SECTION_SHIFT) {
>>>> +               VM_WARN_ON_ONCE(!IS_ALIGNED(pfn | nr_pages, pages_per_c=
ompound));
>>>>               return VMEMMAP_RESERVE_NR * nr_pages / pages_per_compound=
;
>>>=20
>>> That makes sense as well, within a section, we expect that we always add=
/remove
>>> entire "compound"-managed chunks.
>>>=20
>>>> +       }
>>>> +
>>>> +       VM_WARN_ON_ONCE(!IS_ALIGNED(pfn | nr_pages, PAGES_PER_SECTION))=
;
>>>=20
>>> And this is then for the case where a 1G page spans multiple sections, w=
here we
>>> expect to add/remove an entire section.
>>>=20
>>> So here, indeed the "min" makes sense. I guess we also assume:
>>>=20
>>>   VM_WARN_ON_ONCE(nr_pages > PAGES_PER_SECTION);
>>=20
>> Yes. But this one we do not need to explicit it to
>> assert it since at the front of this function we have
>>=20
>> VM_WARN_ON_ONCE(pfn_to_section_nr(pfn) !=3D pfn_to_section_nr(pfn + nr_pa=
ges - 1));
>=20
> Ah, yes. The alignment checks + VM_WARN_ON_ONCE(nr_pages > PAGES_PER_SECTI=
ON);
> however imply that.
>=20
> So you could simplify by using that check instead of the pfn_to_section_nr=
() check.
>=20
> But it's still early here ... so whatever you prefer :)

Thanks for the suggestion. I think your approach is also
good =E2=80=94 at least it looks shorter and cleaner. I'll switch to
using VM_WARN_ON_ONCE(nr_pages > PAGES_PER_SECTION) instead.

Thanks.

>=20
> --
> Cheers,
>=20
> David

