Return-Path: <stable+bounces-241485-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mLyuEMBl8GmWSwEAu9opvQ
	(envelope-from <stable+bounces-241485-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 09:46:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A512747F29D
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 09:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3311B30E9D7A
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 07:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C053D6487;
	Tue, 28 Apr 2026 07:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BaHKK+yR"
X-Original-To: stable@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95ADF3D4116
	for <stable@vger.kernel.org>; Tue, 28 Apr 2026 07:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777361123; cv=none; b=QZMIOqtyzmwbZyb9v3aDAGtMzhbHFYsOT01HaaWKjqNnQXS0qfZl/sKXYRBKAgXIRD1EBigTYWXkO3lxE4J66oB1Q5eNSunzWfnfg2sziaI4fqNjiPSGaJiNLp07N7J4n9yS+CKoKF4CeU22YldT6YiQKqSL2m87JccJvI6R00Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777361123; c=relaxed/simple;
	bh=WxDLlHFi6WdxZn0TcGW79Hktb17HQl+N7OaRssSX6IQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=R197Is/mFA406dqGLVsPOP7CIi2igO4zoOy+/lyoA7xotdOIR3xkRnS32ShxjzFhhKpdM0I48JcuI/RTDnVzpR0rZGBnfZtu7cT1G6DeFmzAnUzeaoxPr+eNV3K9n3z/vAUGUAwf5owOjjb/M7Rgrf/2yMbc+b0j+Ohw6nzcLDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BaHKK+yR; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777361109;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lCxxk2ZWIZ6775Ddt50SCJNnhpMNtd+lmo4iXra99RM=;
	b=BaHKK+yRKCfLKa5fiwk4B0E+J2WDiD2jnmSw45lRSgk5ed/MjG/OFPve6pztHuJ9C0KSID
	+5qQA4XNDVuHdwjkh5KOvsX7mA8gA54Huo6FjkZazML4r/okshxJ1V9ScLp5Tjo/IZQ4TE
	+eUyfeBvDKqczc0Ur6ShL3ymex8pCnY=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH v7 4/6] mm/sparse-vmemmap: Fix DAX vmemmap accounting with
 optimization
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <5dd84f9c-4ce2-4bc8-b644-e865f0623ba3@kernel.org>
Date: Tue, 28 Apr 2026 15:24:25 +0800
Cc: Muchun Song <songmuchun@bytedance.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Oscar Salvador <osalvador@suse.de>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <chleroy@kernel.org>,
 aneesh.kumar@linux.ibm.com,
 joao.m.martins@oracle.com,
 linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <0EC0552F-7394-49B9-91C7-A2E86CC0E541@linux.dev>
References: <20260426092640.375967-1-songmuchun@bytedance.com>
 <20260426092640.375967-5-songmuchun@bytedance.com>
 <09298afa-9a36-4f29-a8e1-d4750c338df2@kernel.org>
 <C2E99AB4-CC47-4D9F-BF56-F971FD5A3C26@linux.dev>
 <5dd84f9c-4ce2-4bc8-b644-e865f0623ba3@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: A512747F29D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241485-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bytedance.com:email,linux.dev:dkim,linux.dev:mid]



> On Apr 28, 2026, at 15:00, David Hildenbrand (Arm) <david@kernel.org> =
wrote:
>=20
> On 4/28/26 04:21, Muchun Song wrote:
>>=20
>>=20
>>> On Apr 27, 2026, at 18:17, David Hildenbrand (Arm) =
<david@kernel.org> wrote:
>>>=20
>>> On 4/26/26 11:26, Muchun Song wrote:
>>>> When vmemmap optimization is enabled for DAX, the nr_memmap_pages
>>>> counter in /proc/vmstat is incorrect. The current code always =
accounts
>>>> for the full, non-optimized vmemmap size, but vmemmap optimization
>>>> reduces the actual number of vmemmap pages by reusing tail pages. =
This
>>>> causes the system to overcount vmemmap usage, leading to inaccurate
>>>> page statistics in /proc/vmstat.
>>>>=20
>>>> Fix this by introducing section_nr_vmemmap_pages(), which returns =
the exact
>>>> vmemmap page count for a given pfn range based on whether =
optimization
>>>> is in effect.
>>>>=20
>>>> Fixes: 15995a352474 ("mm: report per-page metadata information")
>>>> Cc: stable@vger.kernel.org
>>>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>>>> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
>>>> Acked-by: Oscar Salvador <osalvador@suse.de>
>>>> ---
>>>> v6 -> v7:
>>>> - Refine the alignment assertions in section_nr_vmemmap_pages().
>>>> ---
>>>> mm/sparse-vmemmap.c | 34 ++++++++++++++++++++++++++++++----
>>>> 1 file changed, 30 insertions(+), 4 deletions(-)
>>>>=20
>>>> diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
>>>> index 3340f6d30b01..01f448607bad 100644
>>>> --- a/mm/sparse-vmemmap.c
>>>> +++ b/mm/sparse-vmemmap.c
>>>> @@ -652,6 +652,31 @@ void offline_mem_sections(unsigned long =
start_pfn, unsigned long end_pfn)
>>>> }
>>>> }
>>>>=20
>>>> +static int __meminit section_nr_vmemmap_pages(unsigned long pfn, =
unsigned long nr_pages,
>>>> +  struct vmem_altmap *altmap, struct dev_pagemap *pgmap)
>>>> +{
>>>> +  const unsigned int order =3D pgmap ? pgmap->vmemmap_shift : 0;
>>>> +  const unsigned long pages_per_compound =3D 1UL << order;
>>>> +
>>>> +  VM_WARN_ON_ONCE(!IS_ALIGNED(pfn | nr_pages, =
PAGES_PER_SUBSECTION));
>>>> +
>>>> +  if (!vmemmap_can_optimize(altmap, pgmap))
>>>> +  return DIV_ROUND_UP(nr_pages * sizeof(struct page), PAGE_SIZE);
>>>> +
>>>> +  if (order < PFN_SECTION_SHIFT) {
>>>> +  VM_WARN_ON_ONCE(!IS_ALIGNED(pfn | nr_pages, =
pages_per_compound));
>>>> +  return VMEMMAP_RESERVE_NR * nr_pages / pages_per_compound;
>>>> +  }
>>>> +
>>>> +  VM_WARN_ON_ONCE(!IS_ALIGNED(pfn | nr_pages, PAGES_PER_SECTION));
>>>> +  VM_WARN_ON_ONCE(nr_pages > PAGES_PER_SECTION);
>>>=20
>>> I would just have done that at the very top, as this check applies =
to all cases.
>>=20
>> My initial reasoning was that the current formula holds for compound =
pages smaller
>> than the section size, and we only need to impose limits when the =
page size exceeds
>> it. While the current callers of section_nr_vmemmap_pages() don't =
pass sizes larger
>> than a section, this will change in the future (see [1]).
>=20
> A function that is called *section_* will get a range that exceeds a =
section?
>=20
> That sounds conceptually wrong, no?

It does seem a bit ambiguous. I will rename it to something more =
appropriate if I
expand its functionality in the future. For this series, I will update a =
v8 to move
VM_WARN_ON_ONCE(nr_pages > PAGES_PER_SECTION); to the top of this =
function.

Thanks.

>=20
>=20
> --=20
> Cheers,
>=20
> David



