Return-Path: <stable+bounces-254333-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WE4cLsOVFWp9WgcAu9opvQ
	(envelope-from <stable+bounces-254333-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 14:44:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A55B5D5B92
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 14:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BE5823007AE9
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 12:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F643F9F56;
	Tue, 26 May 2026 12:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lMS4QbMv"
X-Original-To: stable@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AB73F58CE
	for <stable@vger.kernel.org>; Tue, 26 May 2026 12:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779799484; cv=none; b=ueI6lyY5oD42E9bOlBiu6YIQTiSak10v5oa+pCdZm586OdaIrrq7iAIDRSiBdjl/YeUYYDFgdtfu6QDbJvxbE+7Nv/Va8AMQJFaZLRlGq0ucCrgsbLRoD5D7kbf7F8l5FUlrnOg0bDO8Los4HhSXCBHZNgxEX/fmZHliDmwWyhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779799484; c=relaxed/simple;
	bh=QJVt0DZUFPNyn17DknLw2RSrN9lmnBVjMM8ckov1/TQ=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=KQX8W9UBxBRPLr5N9BHGt69TNNH02qdrPAh9x/bhTk57vjQKJvNQQAlG8P0r9F3xAk5PnO7RpB1bQlVkQN8pRvn/sAOceaAzuIJ5s06LHvKCXRMfhJl7a2McQS8sjY2q/LFYpqmdTtdsy8DPbHCjn9E2ujhInbkKY0ZbodpHj5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lMS4QbMv; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain; charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779799480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aZ+//Mss6s3qN1JOKyb8a9R/2rcpN6zHPDWF1XVoNaU=;
	b=lMS4QbMv0ataQoK+t4dIGZlupkZyH7x6RZe3qqCqB4MaCzKmuAJRFdKp34LnWMyV5A2rnt
	Xof+1+4FqRBp1nKu5FFUgPY5sPYwUwkswp6lw6QrA8IRFyn8VvKWO73b2q05qk/HqUZsF6
	yNGeOe07/UT0urDqO25kBowxlNWmROQ=
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] mm/cma: fix reserved page leak on activation failure
Date: Tue, 26 May 2026 20:44:01 +0800
Message-Id: <9A340644-CD8D-44B0-BBC5-43D29E9D046E@linux.dev>
References: <ahWJMwG8xoQli_Q0@localhost.localdomain>
Cc: Muchun Song <songmuchun@bytedance.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Frank van der Linden <fvdl@google.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <ahWJMwG8xoQli_Q0@localhost.localdomain>
To: Oscar Salvador <osalvador@kernel.org>,
 Usama Arif <usama.arif@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254333-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[muchun.song@linux.dev,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.994];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linux.dev:mid,linux.dev:dkim,bytedance.com:email]
X-Rspamd-Queue-Id: 4A55B5D5B92
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> On May 26, 2026, at 19:51, Oscar Salvador (SUSE) <osalvador@kernel.org> wr=
ote:
>=20
> =EF=BB=BFOn Tue, May 26, 2026 at 04:30:03AM -0700, Usama Arif wrote:
>> On Fri, 22 May 2026 14:26:58 +0800 Muchun Song <songmuchun@bytedance.com>=
 wrote:
> ...
>>> diff --git a/mm/cma.c b/mm/cma.c
>>> index c7ca567f4c5c..a30075507d41 100644
>>> --- a/mm/cma.c
>>> +++ b/mm/cma.c
>>> @@ -188,10 +188,13 @@ static void __init cma_activate_area(struct cma *c=
ma)
>>>=20
>>>    /* Expose all pages to the buddy, they are useless for CMA. */
>>>    if (!test_bit(CMA_RESERVE_PAGES_ON_ERROR, &cma->flags)) {
>>> -        for (r =3D 0; r < allocrange; r++) {
>>> +        for (r =3D 0; r < cma->nranges; r++) {
>>> +            unsigned long start_pfn;
>>> +
>>>            cmr =3D &cma->ranges[r];
>>> +            start_pfn =3D r < allocrange ? early_pfn[r] : cmr->early_pf=
n;
>>=20
>> Should this be r <=3D allocrange?

Yes. So I sent a v2 to fix it last Saturday.

https://lore.kernel.org/linux-mm/20260523060123.2207992-1-songmuchun@bytedan=
ce.com/

Thanks.

>=20
> Yes, I think you are right. I missed that.
>=20
> early_pfn[alloc_range] holds the last assignment, so we should start
> from the next one reading cmr->early_pfn.
>=20
>=20
>=20
> --
> Oscar Salvador
> SUSE Labs

