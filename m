Return-Path: <stable+bounces-241089-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gDLLHcMv7GlhVQAAu9opvQ
	(envelope-from <stable+bounces-241089-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 25 Apr 2026 05:06:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CE184464D62
	for <lists+stable@lfdr.de>; Sat, 25 Apr 2026 05:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1126A3008D2D
	for <lists+stable@lfdr.de>; Sat, 25 Apr 2026 03:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB9B381AEB;
	Sat, 25 Apr 2026 03:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="B19j9Sh9"
X-Original-To: stable@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5117C381AE0
	for <stable@vger.kernel.org>; Sat, 25 Apr 2026 03:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777086390; cv=none; b=MQ/K2DbykSYNEwR8MlL/j/3Mdu7jNRiaveZq+FuSFz2QhlT2qSCYJuW+aoO0ahseEw3hAOiilsPQc1cnIK4ihWPwFshkK0wwpVRYslAbtm87T+czqZr//X9sRvLqJILZxqj6zKzMjX2wvFMkO8qzUl9jK8e4lF1SezAfI8TEpTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777086390; c=relaxed/simple;
	bh=GQo5F3MZjkVXeWJWdPuFDka2HrRtj/alAavAKitQ2FY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=lCxIj+nU+J+LWs9IYRHUGN5xPgZU5+s25fq/D3jEmlnXdgz9WmFaAiJsKwtj5uh1A4J6G4k9ZqFGyCoymyYL/XJegGS8oSeVVucGmhnb2fYAJcd+GLt8BD4HhPKZ6eyGuQT+r8lQTesfEI/JQu09YHLXRiLkciNRAVhTj1W2XRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=B19j9Sh9; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777086376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LS6FCqD8VSXr924Q4YkPV/vRhy4BlRM8EbIWjkTCfxQ=;
	b=B19j9Sh9uoyXQoT2jp7I4pOlIjQZYabWyU3GKN59qbm6g12VJj3lhVYjDoCrWYP4/xTSij
	gLNZZdLCkzFGTjkwSlTZuOJUQWEfwwmKiZ0zKs6/nksrzMF/ZYksFvgyyNoBbjTnjk9Q+h
	W1DXvgmK08TwKJnZu+cKBozIo3rbYpQ=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH v6 4/7] mm/sparse-vmemmap: Fix DAX vmemmap accounting with
 optimization
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <0fe62163-cdfd-47e4-bc88-df7a69dc5a6d@kernel.org>
Date: Sat, 25 Apr 2026 11:05:38 +0800
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
Message-Id: <4C6CE53F-918C-4D03-9DBD-1745E28A2D9E@linux.dev>
References: <20260424025547.3806072-1-songmuchun@bytedance.com>
 <20260424025547.3806072-5-songmuchun@bytedance.com>
 <0fe62163-cdfd-47e4-bc88-df7a69dc5a6d@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: CE184464D62
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241089-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:mid,bytedance.com:email,suse.de:email]



> On Apr 24, 2026, at 15:33, David Hildenbrand (Arm) <david@kernel.org> =
wrote:
>=20
> On 4/24/26 04:55, Muchun Song wrote:
>> When vmemmap optimization is enabled for DAX, the nr_memmap_pages
>> counter in /proc/vmstat is incorrect. The current code always =
accounts
>> for the full, non-optimized vmemmap size, but vmemmap optimization
>> reduces the actual number of vmemmap pages by reusing tail pages. =
This
>> causes the system to overcount vmemmap usage, leading to inaccurate
>> page statistics in /proc/vmstat.
>>=20
>> Fix this by introducing section_vmemmap_pages(), which returns the =
exact
>> vmemmap page count for a given pfn range based on whether =
optimization
>> is in effect.
>>=20
>> Fixes: 15995a352474 ("mm: report per-page metadata information")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
>> Acked-by: Oscar Salvador <osalvador@suse.de>
>> ---
>> mm/sparse-vmemmap.c | 31 +++++++++++++++++++++++++++----
>> 1 file changed, 27 insertions(+), 4 deletions(-)
>>=20
>> diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
>> index 3340f6d30b01..2e642c5ff3f2 100644
>> --- a/mm/sparse-vmemmap.c
>> +++ b/mm/sparse-vmemmap.c
>> @@ -652,6 +652,28 @@ void offline_mem_sections(unsigned long =
start_pfn, unsigned long end_pfn)
>> }
>> }
>>=20
>> +static int __meminit section_nr_vmemmap_pages(unsigned long pfn, =
unsigned long nr_pages,
>> + 		struct vmem_altmap *altmap, struct dev_pagemap *pgmap)
>> +{
>> + 	const unsigned int order =3D pgmap ? pgmap->vmemmap_shift : 0;
>> + 	const unsigned long pages_per_compound =3D 1UL << order;
>> +
>> + 	VM_WARN_ON_ONCE(!IS_ALIGNED(pfn | nr_pages,
>> +    			min(pages_per_compound, =
PAGES_PER_SECTION)));
>=20
> FWIW, I though the right thing to do here would be:
>=20
> VM_WARN_ON_ONCE(!IS_ALIGNED(pfn | nr_pages, pages_per_compound);
> VM_WARN_ON_ONCE(!IS_ALIGNED(pfn | nr_pages, PAGES_PER_SUBSECTION);
>=20
> I don't really see how PAGES_PER_SECTION make sense given that
> PAGES_PER_SUBSECTION are the smallest granularity we allow =
adding/removing.
>=20
> Also, the "min()" implies that there is a connection between both =
properties,
> but there isn't to that degree.
>=20
> If order =3D=3D 0, then you'd only ever check alignment for ... 1, not
> PAGES_PER_SUBSECTION, which already looks weird.
>=20
> So you really want to check "max(pages_per_compound, =
PAGES_PER_SUBSECTION)", but
> just having two statements is clearer.
>=20
> Or am I getting something very wrong here? :)

Hi David,

Sorry, I missed the 1GB hugepage scenario earlier. Given that =
sparse_add_section()
operates on a scale between PAGES_PER_SUBSECTION and PAGES_PER_SECTION, =
the pfn and
nr_pages parameters wouldn't be aligned with the hugepage size =
(pages_per_compound),
but rather with the PAGES_PER_SECTION boundary. Do you think this =
explanation makes
it clearer? In the interest of code clarity, do you think the =
modification below
makes it easier to follow?

diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 2e642c5ff3f2..ce675c5fb94d 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -658,15 +658,18 @@ static int __meminit =
section_nr_vmemmap_pages(unsigned long pfn, unsigned long n
        const unsigned int order =3D pgmap ? pgmap->vmemmap_shift : 0;
        const unsigned long pages_per_compound =3D 1UL << order;

-       VM_WARN_ON_ONCE(!IS_ALIGNED(pfn | nr_pages,
-                                   min(pages_per_compound, =
PAGES_PER_SECTION)));
+       VM_WARN_ON_ONCE(!IS_ALIGNED(pfn | nr_pages, =
PAGES_PER_SUBSECTION));
        VM_WARN_ON_ONCE(pfn_to_section_nr(pfn) !=3D =
pfn_to_section_nr(pfn + nr_pages - 1));

        if (!vmemmap_can_optimize(altmap, pgmap))
                return DIV_ROUND_UP(nr_pages * sizeof(struct page), =
PAGE_SIZE);

-       if (order < PFN_SECTION_SHIFT)
+       if (order < PFN_SECTION_SHIFT) {
+               VM_WARN_ON_ONCE(!IS_ALIGNED(pfn | nr_pages, =
pages_per_compound));
                return VMEMMAP_RESERVE_NR * nr_pages / =
pages_per_compound;
+       }
+
+       VM_WARN_ON_ONCE(!IS_ALIGNED(pfn | nr_pages, PAGES_PER_SECTION));

        if (IS_ALIGNED(pfn, pages_per_compound))
                return VMEMMAP_RESERVE_NR;

Thanks.

>=20
>=20
> --=20
> Cheers,
>=20
> David


