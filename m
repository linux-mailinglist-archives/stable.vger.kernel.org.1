Return-Path: <stable+bounces-240569-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MB9sIR4h62k9IwAAu9opvQ
	(envelope-from <stable+bounces-240569-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 09:51:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F8245AF0D
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 09:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9DDA5301F5E9
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 07:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 445FD1D5CC9;
	Fri, 24 Apr 2026 07:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="f5sWadWI"
X-Original-To: stable@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995802DB7B7
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 07:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777017091; cv=none; b=BNkMJjvQjxxaVNulNBz8IGep4NJfA0XOITXEKE/I6/qBoIL0Ck4QHd4N98YKn6CehWiLb203ZYtqlMNKABCWt4oPbP8p8i2LU1kMplZfyJzVY8kIJNEB/8UefNJ4ldS6FwscbQC3F5FTebDIrmjPcnK3sVxVB8JbSiiU2dLcLGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777017091; c=relaxed/simple;
	bh=ln5xvtTyToI62jV8j0dDLYIOZoRHIVOK6bNHjdglo6A=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Zc5YPqi4h5qH6O6/567NzN4nvi5R1YVAIsqJ7s93dIPvEDeL+VOYvaLnG8q/2fA16WLq3j6Z9iW1nCEumTkzjx57rypDR5vmS2bfFeMMgi/XCjmusfSXa0JBSX3d1ZGSalv/uYxutbI5oM1TaSDWJR0ApRlO4iAiB4oh61qf+DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=f5sWadWI; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777017086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/ORSaWnko0V3NhVqidFGTv7S6AWqSkqSLorMuOfpODA=;
	b=f5sWadWIcXFWMoPuLXqfAVQq8XtQDNfCfsvXrl+tyhRViG3SQIamnGMCotuewbABJ9cFH4
	PYhz/HibwXyamvirz+mWtj2C3RPJ/RNlVHmjxhhppl13+g7APOW6R5fSkAUQgJxqYQ7tdZ
	DvCm6GbEn5PGd64kYmFnP3vBYTawe0o=
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
Date: Fri, 24 Apr 2026 15:48:44 +0800
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
Message-Id: <5A4644D9-B64E-4AD9-9D9A-B3DAB84CB827@linux.dev>
References: <20260424025547.3806072-1-songmuchun@bytedance.com>
 <20260424025547.3806072-5-songmuchun@bytedance.com>
 <0fe62163-cdfd-47e4-bc88-df7a69dc5a6d@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: E7F8245AF0D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240569-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bytedance.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.de:email,linux.dev:dkim,linux.dev:mid]



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
>> +     				    min(pages_per_compound, =
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
>=20

You are absolutely right. I misread it earlier. I mistakenly read
PAGES_PER_SUBSECTION as PAGES_PER_SECTION, which is why I still used
PAGES_PER_SECTION in v5. That was my mistake and obviously not what
you originally meant.

I completely agree with your suggestion to use two statements here,
as it makes the alignment requirements much clearer. I'll fix this in
the next version. Thanks for pointing this out!

Muchun,
Thanks.

>=20
> --=20
> Cheers,
>=20
> David



