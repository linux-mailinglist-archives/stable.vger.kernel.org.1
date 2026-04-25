Return-Path: <stable+bounces-241095-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KNacI2xd7GnYXwAAu9opvQ
	(envelope-from <stable+bounces-241095-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 25 Apr 2026 08:21:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F247D46523F
	for <lists+stable@lfdr.de>; Sat, 25 Apr 2026 08:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A931F3017382
	for <lists+stable@lfdr.de>; Sat, 25 Apr 2026 06:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161EF13FEE;
	Sat, 25 Apr 2026 06:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZCQSa0xM"
X-Original-To: stable@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A282BDC23
	for <stable@vger.kernel.org>; Sat, 25 Apr 2026 06:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777098089; cv=none; b=RSrxx40H/U6+tMXyn5cle+xUIuu/refkecZcCd0gmkv8ErcJ1uJHYzjxPyTzVrlifZ7LLE+InBD7uLA5ZyzosGTyu2Ba/1o1yiNn/kGJt/k/GxOB4w9Cqy22xEjdFjDSJ7I6pBkKzgQzUEm6Wv3Fq5CxywUHqp3qpbFY+jmcdow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777098089; c=relaxed/simple;
	bh=4ZN3457nASgHm4tfC11PRBzk9FsN/Ns8nfhU1IFzn84=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=foFYD+rvYjOvCe49NQ5RLNT2EcBMkZdMz7gui65KQA1wR5ZqCIeogA7EXP8NeZmGCp0HS9bviElG2uICWSIV4K/sFEefRoJjtiCC1lXHoqQcAOGKrNlz/hfc9twrPE3KuzcZqIgL+3t6/XNx0u4XKyVgRF9sUrqp15zi2OY/jVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZCQSa0xM; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain; charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777098076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DHZLJC5B5fmgRAOtQknXGM+s5bBWV7trEmZX8TH0Pyk=;
	b=ZCQSa0xMAWeLz4zqajISETfXw0jpqKglaKesdUOywfIFOqHdjirtt+ma6LodskeBqPJfos
	2sHx8WiBaja3NZLDcHxvFAt1HvSgu28BujosBA5ALe9pIqvU8pMspNe8EEj4HliRx0V/0y
	I+S/2Px5CbIdsYh0eu/l0FH2uqJGXlQ=
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
Date: Sat, 25 Apr 2026 14:20:39 +0800
Message-Id: <17902B08-7487-4FC8-8EBC-268CE5F3E1B9@linux.dev>
References: <02e35414-8c30-4753-9403-432d90263f39@kernel.org>
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
In-Reply-To: <02e35414-8c30-4753-9403-432d90263f39@kernel.org>
To: David Hildenbrand <david@kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: F247D46523F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[bytedance.com,linux-foundation.org,suse.de,ellerman.id.au,linux.ibm.com,kernel.org,oracle.com,google.com,suse.com,gmail.com,kvack.org,lists.ozlabs.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-241095-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[muchun.song@linux.dev,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[20];
	TO_DN_SOME(0.00)[]



> On Apr 25, 2026, at 13:48, David Hildenbrand (Arm) <david@kernel.org> wrot=
e:
>=20
> =EF=BB=BF
>>=20
>>=20
>> Hi David,
>>=20
>> Sorry, I missed the 1GB hugepage scenario earlier. Given that sparse_add_=
section()
>> operates on a scale between PAGES_PER_SUBSECTION and PAGES_PER_SECTION, t=
he pfn and
>> nr_pages parameters wouldn't be aligned with the hugepage size (pages_per=
_compound),
>> but rather with the PAGES_PER_SECTION boundary. Do you think this explana=
tion makes
>> it clearer? In the interest of code clarity, do you think the modificatio=
n below
>> makes it easier to follow?
>>=20
>> diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
>> index 2e642c5ff3f2..ce675c5fb94d 100644
>> --- a/mm/sparse-vmemmap.c
>> +++ b/mm/sparse-vmemmap.c
>> @@ -658,15 +658,18 @@ static int __meminit section_nr_vmemmap_pages(unsig=
ned long pfn, unsigned long n
>>        const unsigned int order =3D pgmap ? pgmap->vmemmap_shift : 0;
>>        const unsigned long pages_per_compound =3D 1UL << order;
>>=20
>> -       VM_WARN_ON_ONCE(!IS_ALIGNED(pfn | nr_pages,
>> -                                   min(pages_per_compound, PAGES_PER_SEC=
TION)));
>> +       VM_WARN_ON_ONCE(!IS_ALIGNED(pfn | nr_pages, PAGES_PER_SUBSECTION)=
);
>=20
> That here makes sense. We can only add/remove in multiples of PAGES_PER_SE=
CTION.
> I think what we are saying is that we want that check in addition to the
> existing min() check.

Right.

>=20
>>        VM_WARN_ON_ONCE(pfn_to_section_nr(pfn) !=3D pfn_to_section_nr(pfn +=
 nr_pages - 1));
>>=20
>>        if (!vmemmap_can_optimize(altmap, pgmap))
>>                return DIV_ROUND_UP(nr_pages * sizeof(struct page), PAGE_S=
IZE);
>>=20
>> -       if (order < PFN_SECTION_SHIFT)
>> +       if (order < PFN_SECTION_SHIFT) {
>> +               VM_WARN_ON_ONCE(!IS_ALIGNED(pfn | nr_pages, pages_per_com=
pound));
>>                return VMEMMAP_RESERVE_NR * nr_pages / pages_per_compound;=

>=20
> That makes sense as well, within a section, we expect that we always add/r=
emove
> entire "compound"-managed chunks.
>=20
>> +       }
>> +
>> +       VM_WARN_ON_ONCE(!IS_ALIGNED(pfn | nr_pages, PAGES_PER_SECTION));
>=20
> And this is then for the case where a 1G page spans multiple sections, whe=
re we
> expect to add/remove an entire section.
>=20
> So here, indeed the "min" makes sense. I guess we also assume:
>=20
>    VM_WARN_ON_ONCE(nr_pages > PAGES_PER_SECTION);

Yes. But this one we do not need to explicit it to
assert it since at the front of this function we have

VM_WARN_ON_ONCE(pfn_to_section_nr(pfn) !=3D pfn_to_section_nr(pfn + nr_pages=
 - 1));

to make sure the passing range belongs to one section.

Thanks.

>=20
> Looks better to me!
>=20
> --
> Cheers,
>=20
> David

